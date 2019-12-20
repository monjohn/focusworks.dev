%{
  theme: Serum.Themes.Essence,
  site_name: "FocusWorks",
  site_description: "Blog of Monte Johnston",
  date_format: "{WDfull}, {D} {Mshort} {YYYY}",
  base_url: "/",
  author: "Monte Johnston",
  author_email: "johnston.monte@gmail.com",
  plugins: [
    {Serum.Plugins.LiveReloader, only: :dev}
  ]
}
