# CJIS Compliance Guidance Tool - UI Design

## Visual Design Overview

The application uses a clean, professional design suitable for government and law enforcement users. The color scheme is based on Flutter's Material Design 3 with a blue primary color.

## Screen Layouts

### 1. Disclaimer Screen

**Layout:**
- Full-screen gradient background (blue gradient)
- Centered white card with shadow
- Maximum width of 800px for readability

**Components:**
- Large security icon (shield) at top
- Application title in large, bold text
- Four main sections with bullet points:
  - Important Disclaimer
  - Intended Audience
  - Purpose
  - Limitations
- Warning box with red border and warning icon
- Large "I Understand - Continue" button at bottom

**Color Scheme:**
- Background: Blue gradient
- Card: White
- Primary text: Dark gray/black
- Headings: Primary blue
- Warning box: Red border with light red background
- Button: Primary blue

### 2. Categories Screen

**Layout:**
- App bar with title at top
- Info card below app bar
- Responsive grid of category cards:
  - 3 columns on desktop (>1200px)
  - 2 columns on tablet (>800px)
  - 1 column on mobile (<800px)

**Category Card Components:**
- Large emoji icon (top left)
- Category title (large, bold)
- Description text (2-3 lines)
- Policy reference tag (bottom)
- Arrow icon (bottom right)
- Hover effect on mouse over
- Card shadow for depth

**Info Card:**
- Light blue background
- Info icon on left
- "Select a Category" heading
- Descriptive text about the tool

### 3. Category Detail Screen

**Layout:**
- App bar with category title
- Centered content (max 900px width)
- Scrollable content

**Components:**
- Header card:
  - Large emoji icon (left)
  - Category title (large heading)
  - Policy reference tag
  - Description text
- Key Points section:
  - Individual cards for each point
  - Check circle icon (left)
  - Point text
- Guided Assessment card (if available):
  - Light blue background
  - Quiz icon
  - "Guided Assessment Available" heading
  - Description
  - "Start Guided Assessment" button (green)
- Back button at bottom

### 4. Guidance Flow Screen - Question View

**Layout:**
- App bar with category title
- Centered content (max 800px width)
- Scrollable

**Components:**
- Progress card:
  - Quiz icon
  - "Question X of Y" text
- Question card:
  - Large, bold question text
  - Spacing for readability
- Answer option cards:
  - Radio button icon (left)
  - Answer text
  - Forward arrow icon (right)
  - Hover effect
  - Click to select
- Back button at bottom

### 5. Guidance Flow Screen - Result View

**Layout:**
- App bar with category title
- Centered content (max 900px width)
- Scrollable

**Components:**
- Header card (blue background):
  - Success/checkmark icon
  - Result title (large)
  - Policy reference tag
- Assessment card:
  - "Assessment" heading
  - Description text
- Risk Areas section (if applicable):
  - Light red background card
  - Warning icons
  - List of risk areas
- Recommended Actions:
  - Individual cards for each recommendation
  - Check circle icon
  - Action text
- Action buttons:
  - "Start Over" button (primary)
  - "Back to Category" button (outlined)
  - "Return to All Categories" link

## Typography

### Font Sizes:
- Headline (large): 32px
- Headline (medium): 28px
- Headline (small): 24px
- Title (large): 22px
- Title (medium): 16px
- Body (large): 16px
- Body (medium): 14px
- Body (small): 12px

### Font Weights:
- Regular: 400
- Bold: 700

## Color Palette

### Primary Colors:
- Primary Blue: #2196F3
- Primary Container: Light blue (#BBDEFB)
- On Primary: White

### Semantic Colors:
- Error/Warning: Red (#F44336)
- Error Container: Light red (#FFCDD2)
- Success: Green (#4CAF50)
- Info: Blue (#2196F3)

### Surface Colors:
- Surface: White (#FFFFFF)
- Background: Light gray (#FAFAFA)
- Surface Variant: Light gray (#F5F5F5)

### Text Colors:
- Primary text: Dark gray (#212121)
- Secondary text: Medium gray (#757575)
- Disabled text: Light gray (#BDBDBD)

## Icons

Icons are from Material Icons:
- Security/Shield: Home screen
- Info: Information sections
- Quiz: Questions
- Warning: Risk areas
- Check Circle: Success/recommendations
- Arrow Forward: Navigation
- Arrow Back: Back navigation
- Home: Return home

## Spacing

### Padding:
- Extra large: 40px
- Large: 32px
- Medium: 24px
- Regular: 16px
- Small: 12px
- Extra small: 8px

### Margins:
- Section spacing: 24px
- Card spacing: 16px
- Item spacing: 12px

## Responsive Breakpoints

- Mobile: < 600px (not primary target)
- Tablet: 600px - 1200px
- Desktop: > 1200px

## Accessibility Features

- High contrast text
- Clear focus indicators
- Keyboard navigation support
- Screen reader friendly
- WCAG AA compliant color contrast (4.5:1 minimum)

## Interaction States

### Buttons:
- Default: Primary color
- Hover: Slightly darker
- Pressed: Even darker
- Disabled: Gray

### Cards:
- Default: White with subtle shadow
- Hover: Elevated shadow (cursor pointer)
- Pressed: Slightly darker

## Animation

- Page transitions: Fade
- Card hover: Subtle elevation change (0.2s)
- Button press: Quick scale (0.1s)
- Navigation: Slide (0.3s)

## Empty States

If a category has no questions:
- Info box with icon
- "Coming soon" message
- Friendly, informative tone

## Loading States

- Circular progress indicator
- Centered on screen
- Primary blue color

## Error States

- Error icon
- Clear error message
- Suggestion to retry or go back
- Contact information if persistent

This design ensures a professional, accessible, and user-friendly experience suitable for law enforcement personnel.
