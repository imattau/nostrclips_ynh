Nostr Clips must be served from the domain root (no sub-path install): its
PWA manifest scope, service-worker scope, and several absolute `/...` asset
paths all assume `/`. Installing under a path would require patching
upstream's Vite/PWA config.
