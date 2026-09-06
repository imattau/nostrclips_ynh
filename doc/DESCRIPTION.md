# Nostr Clips for YunoHost

Nostr Clips (upstream project name: scrollstr) is a consumption-first,
vertical short-form video client for Nostr, in the style of TikTok/Reels/
YouTube Shorts.

This YunoHost package hosts the Nostr Clips static web app (a PWA) only. It
does not install a Nostr relay: the app talks directly, from the visitor's
browser, to whichever public relays are configured in its Settings page (a
sensible default list ships out of the box and can be changed per-visitor).

All data (session, cached feed/profile data, relay list, preferences) is
stored client-side in the browser (localStorage/IndexedDB) - this package
keeps no server-side application data of its own. Nostr login (browser
extension, pasted nsec, or passkey) is independent of YunoHost accounts and
LDAP.

Video trimming/encoding for posting clips runs client-side via a bundled
ffmpeg WebAssembly build; nothing is uploaded to this server for processing.
