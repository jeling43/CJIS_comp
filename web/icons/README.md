# Web Icons

This directory should contain PWA icons for the application.

## Required Icons

For Progressive Web App support, you need to add:

1. **icon-192.png** (192x192 pixels)
   - Used for smaller displays and app shortcuts
   - Should be clear and recognizable at small sizes

2. **icon-512.png** (512x512 pixels)
   - Used for larger displays and splash screens
   - Higher quality version of the app icon

## Icon Design Guidelines

### Theme
- Use a shield or lock icon to represent security
- Incorporate blue color (#0175C2) from the app theme
- Keep design simple and professional
- Suitable for government/law enforcement context

### Technical Requirements
- PNG format with transparency
- Square dimensions
- Clear at small sizes
- High contrast
- Maskable (icon should work when cropped to a circle)

## Creating Icons

You can create icons using:
- Adobe Illustrator/Photoshop
- Figma
- GIMP (free)
- Online icon generators
- Flutter Icon Generator tool

Example using Flutter Icon Generator:
```bash
flutter pub run flutter_launcher_icons:main
```

Or manually:
1. Create a 512x512 design
2. Export as PNG
3. Scale down to 192x192 for the smaller version
4. Place both files in this directory

## Reference

The manifest.json file references these icons:
```json
"icons": [
    {
        "src": "icons/icon-192.png",
        "sizes": "192x192",
        "type": "image/png"
    },
    {
        "src": "icons/icon-512.png",
        "sizes": "512x512",
        "type": "image/png"
    }
]
```

Until actual icons are added, the app will function but won't have a custom icon when installed as a PWA.
