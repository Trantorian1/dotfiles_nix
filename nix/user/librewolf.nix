{...}: {
  # Install Librewolf
  programs.librewolf = {
    enable = true;
    settings = {
      # Enabling google safe browsing
      # https://librewolf.net/docs/settings/#enable-google-safe-browsing
      "browser.safebrowsing.malware.enabled" = true;
      "browser.safebrowsing.phishing.enabled" = true;
      "browser.safebrowsing.blockedURIs.enabled" = true;
      "browser.safebrowsing.provider.google4.gethashURL" = "https://safebrowsing.googleapis.com/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
      "browser.safebrowsing.provider.google4.updateURL" = "https://safebrowsing.googleapis.com/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
      "browser.safebrowsing.provider.google.gethashURL" = "https://safebrowsing.google.com/safebrowsing/gethash?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2";
      "browser.safebrowsing.provider.google.updateURL" = "https://safebrowsing.google.com/safebrowsing/downloads?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2&key=%GOOGLE_SAFEBROWSING_API_KEY%";
      "browser.safebrowsing.downloads.enabled" = true;

      # Do not restore tabs on crash
      # https://librewolf.net/docs/settings/#stop-librewolf-from-resuming-after-a-crash
      "browser.sessionstore.resume_from_crash" = false;

      # Stricter autoplay prevention
      # https://librewolf.net/docs/settings/#use-a-stricter-autoplay-policy
      "media.autoplay.blocking_policy" = 2;

      # Disable history
      "places.history.enabled" = false;

      # Homepage
      "browser.startup.homepage" = "https://discord.com/login|https://app.deel.com/login|https://app.rippling.com/sign-in/id|https://id.atlassian.com/login|https://claude.ai/login|https://auth.openai.com/log-in-or-create-account|https://account.proton.me/mail|https://account.proton.me/calendar|https://github.com/login|https://habitica.com/login|https://www.odoo.com/web/login|https://web.whatsapp.com/|https://web.telegram.org/|https://tidal.com/login/";

      # Use vertical tabs
      "sidebar.verticalTabs" = true;

      # Default extensions
      "browser.policies.runOncePerModification.extensionsInstall" = ''
        [
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi"
        ]
      '';
    };
  };
}
