---
title: Using React Navigation with Okta
date: 2020-06-02 10:03:25
tags: React Native Web, React Navigation, Okta
---

### Navigation

There have been some exciting announcements recently in the world of React Native.
[React Native for Web](https://github.com/necolas/react-native-web) is gaining traction, providing a single API for mobile and web apps. Equally important is that [Expo.io](https://docs.expo.io/workflow/web/) continues to make using React Native more and more. Creating a new React Native project that can be build for Android, iOS or the web is as easy as `expo init newProject`.

One persistant problem with using React is navigation. What seems like a good solution often gets rewritten to provide another, "better" solution. Obviously it is a hard problem where each solution has trade-offs. Personally, I have come to appreciate [React Navigation](https://reactnavigation.org/) when working on React Native projects. (This project is also by Expo folks.) Therefore, I was excited when I saw that it's now compatible with the web: [https://reactnavigation.org/blog/2020/05/16/web-support](https://reactnavigation.org/blog/2020/05/16/web-support).

So with all of this good news, **my goal was to build a website with React Native for web and use React Navigation to do it.**

### Authentication

I have been working with Okta lately as an OAuth provider, I wanted to integrate that too. I have used their SDK for plain JavaScript on another project. But since this is a React project I took a look at [a library they have published](https://developer.okta.com/code/react/okta_react/) for integrating Okta with React. It looked promising. According to their docs:

> We'll also need @okta/okta-react and react-router-dom to manage our routes (@okta/okta-react can be used to support other router libraries, but react-router-dom has pre-existing support).

It is unclear whether react-router-dom is required or not, given that they say that other libraries are supported. Turns out, it is required. I was a bit annoyed, not wanting to include a library I am not using, but, oh well!. I included it, but soon a ran into trouble. Turns out that it didn't like not having react-router routes. So much for supporting other libraries!

Looking at the souorce code, I extracted the parts that I needed. Below, I'm going to share the solution that I came up with.

### React Navigation and Otka 💕

My App.ts file is pretty simple. It simply wraps the Navigation component with a Security component, which provides the functionality from Okta. That gets pretty complicated, so I'll save that for the end, for those who are looking for an example of calling the low level functions.

#### App.tsx

```lang-tsx
import 'react-native-gesture-handler'
import React from 'react'
import { authConfig } from './utils/constants'
import Security from './okta/Security'
import Navigation from './Navigation'

function App() {
  return (
    <Security config={authConfig}>
      <Navigation />
    </Security>
  )
}

export default App
```

The config looks something like this. The constants will come from your Okta account info.

```lang-javascript
export const authConfig = {
  pkce: true,
  issuer: ISSUER,
  clientId: CLIENT_ID,
  redirectUri: REDIRECT_URL,
  tokenManager: {
    secure: true,
  },
}
```

Next up is Navigation.ts. This is where we set up React Navigation. I needed to set up the main NavigationContainer with a `linking` config, which handled the route 'auth/callback' because that is how my Okta server is set up.

I created the `requireAuthentication` function to handle Okta logic of getting an access token. It redirects to the Okta signup page if an authorization token is not present. Once an token is present, it changes the value of `isAuthenticated`, which then renders the main content of the app. This is the pattern that React Navigation [recommends](https://reactnavigation.org/docs/auth-flow).

Here is the code:

#### Navigation.tsx

```lang-javascript
import React, { useEffect } from 'react'
import { NavigationContainer } from '@react-navigation/native'
import { createStackNavigator } from '@react-navigation/stack'
import HomeScreen from './HomeScreen'
import AccountScreen from './AccountScreen'
import { useOktaAuth } from '../okta/OktaContext'
import SigninScreen from './SigninScreen'
const Stack = createStackNavigator()

const linking = {
  // prefixes is not actually required for the web
  prefixes: ['https://example.com', 'example://'],
  config: {
    Signin: 'auth/callback',
  },
}
const Navigation = () => {
  const { requireAuthentication, isAuthenticated } = useOktaAuth()

  useEffect(() => {
    requireAuthentication(() => {
      console.log('signed in')
    })
  }, [])

  return (
    <NavigationContainer linking={linking}>
      <Stack.Navigator>
        {isAuthenticated ? (
          <>
            <Stack.Screen name='Home' component={HomeScreen} />
            <Stack.Screen name='Account' component={AccountScreen} />
          </>
        ) : (
          <Stack.Screen name='Signin' component={SigninScreen} />
        )}
      </Stack.Navigator>
    </NavigationContainer>
  )
}
export default Navigation
```

As you can see in the code above, we render the Signup screen if the user is not authenticated. The main purpose of this file is to serve as the destination for the redirect from Okta. I originally used the home page for this but ended up in a loop. Moving this to a new route solved the problem. Here is the simple file.

#### Signin.tsx

```lang-javascript
import React, { useEffect } from 'react'
import { useOktaAuth } from '../okta/OktaContext'
import SplashScreen from './SplashScreen'

function Signin() {
  const { requireAuthentication } = useOktaAuth()

  useEffect(() => {
    requireAuthentication()
  })

  return <SplashScreen />
}

export default Signin
```

To see how it is wired up, we have a Context file to provide our Okta functions to the App. Pretty basic...

#### OktaContext.tsx

```lang-javascript
import React, { useContext } from 'react'

interface Props {
  requireAuthentication: (f?: () => void) => void
  isAuthenticated: boolean
}

const OktaContext = React.createContext<Props>({
  requireAuthentication: () => {},
  isAuthenticated: true,
})

export const useOktaAuth = () => useContext<Props>(OktaContext)
export default OktaContext
```

And finally, the implementation of the Security component. See the notes in the code for details.

#### Security.tsx

```lang-javascript
import OktaAuth from '@okta/okta-auth-js'
import React, { useState } from 'react'
import { authConfig } from '../utils/constants'
import OktaContext from './OktaContext'

const Security = (props: any) => {
  const authClient = new OktaAuth(props.config)
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false)

  function requireAuthentication(onSuccess: Function) {

    // First, we check to see if the authClient has an access token
    authClient.tokenManager.get('accessToken').then((accessToken: string) => {

      // if so, set IsAuthenticated to true and invoke the callback
      if (accessToken) {
        setIsAuthenticated(true)
        onSuccess()
      } else if (location.search) {

        // if not, check to see if the user has just completed their
        // signin with Okta, which would return the token in the url
        authClient.token
          .parseFromUrl()
          .then(({ tokens }: any) => {
            authClient.tokenManager.add('accessToken', tokens.accessToken)
            setIsAuthenticated(true)
            onSuccess()
          })
      } else {
        // otherwise redirect to Okta so that the user can login
        authClient.token
          .getWithRedirect({
            scopes: ['openid', 'profile'],
          })
      }
    })
  }

  return (
    <OktaContext.Provider value={{ requireAuthentication, isAuthenticated }}>
      {props.children}
    </OktaContext.Provider>
  )
}

export default Security
```

### Finally

I am sure that there a opportunities for real improvement, feel free to let me know if you see some.

When I see a write-up like this, I find it really helpful to have a repo that I can look at and try to build. I considered that but using Okta requires an account and a server, so each solution would be pretty unique. The best outcome would be for [@okta](https://twitter.com/okta) to provide a solution for React that is not [so tied to React Router](https://developer.okta.com/code/react/okta_react/).
