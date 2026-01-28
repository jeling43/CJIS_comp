# CJIS Compliance Guidance Tool - Deployment Guide

## Local Development Setup

### 1. Install Flutter

#### macOS
```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.zshrc or ~/.bash_profile)
export PATH="$PATH:`pwd`/flutter/bin"

# Run flutter doctor
flutter doctor
```

#### Windows
1. Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
2. Extract to C:\src\flutter
3. Add C:\src\flutter\bin to PATH
4. Run `flutter doctor` in PowerShell

#### Linux
```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.bashrc)
export PATH="$PATH:$HOME/development/flutter/bin"

# Run flutter doctor
flutter doctor
```

### 2. Install Dependencies

```bash
cd CJIS_comp
flutter pub get
```

### 3. Run the Application

#### For Development (Chrome)
```bash
flutter run -d chrome
```

#### For Development (Other browsers)
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### 4. Build for Production

```bash
# Build web application
flutter build web --release

# Output will be in build/web/
```

## Deployment Options

### Option 1: Static Web Hosting (Recommended)

The application is a static web app and can be hosted on any static hosting service:

#### GitHub Pages
1. Build the app: `flutter build web --base-href /CJIS_comp/`
2. Copy `build/web` contents to `gh-pages` branch
3. Enable GitHub Pages in repository settings

#### Netlify
1. Build: `flutter build web`
2. Deploy `build/web` directory via Netlify CLI or drag-and-drop

#### AWS S3 + CloudFront
1. Build: `flutter build web`
2. Upload `build/web` contents to S3 bucket
3. Configure CloudFront distribution
4. Enable HTTPS

#### Azure Static Web Apps
1. Build: `flutter build web`
2. Deploy using Azure CLI or GitHub Actions

### Option 2: Web Server

#### Nginx
```nginx
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/cjis-comp;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

#### Apache
```apache
<VirtualHost *:80>
    ServerName your-domain.com
    DocumentRoot /var/www/cjis-comp
    
    <Directory /var/www/cjis-comp>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
        
        RewriteEngine On
        RewriteBase /
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule . /index.html [L]
    </Directory>
</VirtualHost>
```

## Testing the Application

### Manual Testing Checklist

1. **Disclaimer Screen**
   - [ ] Verify disclaimer text is clear and complete
   - [ ] "I Understand - Continue" button works
   - [ ] Responsive on tablet and desktop

2. **Categories Screen**
   - [ ] All 6 categories display correctly
   - [ ] Category icons and descriptions visible
   - [ ] Grid layout adapts to screen size
   - [ ] Clicking category navigates to detail

3. **Category Detail Screen**
   - [ ] Category information displays correctly
   - [ ] Key points are readable
   - [ ] Policy references are visible
   - [ ] "Start Guided Assessment" button works (for Access Control and MFA)
   - [ ] Back navigation works

4. **Guidance Flow Screen**
   - [ ] Questions display correctly
   - [ ] Answer options are clickable
   - [ ] Navigation between questions works
   - [ ] Results screen displays with:
     - [ ] Risk areas (if applicable)
     - [ ] Recommendations
     - [ ] Policy references
   - [ ] "Start Over" button works
   - [ ] "Back to Category" navigation works

5. **Responsive Design**
   - [ ] Test on desktop (1920x1080)
   - [ ] Test on tablet (1024x768)
   - [ ] Test on small tablet (800x600)

### Browser Testing

Test on:
- [ ] Chrome/Chromium
- [ ] Firefox
- [ ] Safari (macOS)
- [ ] Edge

## Security Considerations

1. **No Data Storage**: Verify no data is persisted between sessions
2. **HTTPS**: Always deploy with HTTPS enabled
3. **Content Security Policy**: Consider adding CSP headers
4. **CORS**: Not needed as it's a static app with no backend

## Troubleshooting

### Flutter command not found
- Ensure Flutter is in PATH
- Restart terminal after PATH update
- Run `flutter doctor` to verify

### Dependencies not installing
```bash
flutter clean
flutter pub get
```

### Web build fails
```bash
flutter clean
flutter build web --verbose
```

### App doesn't load in browser
- Check browser console for errors
- Verify all files are deployed
- Check web server configuration

## Monitoring and Maintenance

### Updates
- Review and update CJIS policy references annually
- Update guidance content as policies change
- Keep Flutter SDK updated for security patches

### Analytics (Optional)
If analytics are needed (ensure compliance with agency policies):
- Google Analytics
- Matomo (self-hosted)
- Simple page view logging

**Note**: Any analytics must comply with agency privacy policies and should not collect CJIS data.

## Support

For technical issues:
1. Check Flutter documentation: https://flutter.dev/docs
2. Check project issues on GitHub
3. Contact development team

For CJIS compliance questions:
- Contact your state's CJIS Systems Officer (CSO)
- FBI CJIS Division: https://www.fbi.gov/services/cjis
