# Visual Guide: CJIS Mapping and Risk Context Layer

## Category Detail Screen Layout

When a user clicks on any category (e.g., "Access Control"), they now see:

### 1. Compliance Disclaimer Banner (Top)
```
┌─────────────────────────────────────────────────────────────────┐
│ ⓘ  This tool provides guidance only and does not determine     │
│    CJIS compliance. Consult your CJIS Systems Officer for      │
│    official compliance assessment.                              │
└─────────────────────────────────────────────────────────────────┘
```
- Light red/error background
- Info icon
- Clear, concise warning message

### 2. Category Overview Card (Existing)
```
┌─────────────────────────────────────────────────────────────────┐
│  🔐    Access Control                                           │
│        [CJIS Security Policy Section 5.2]                       │
│                                                                  │
│  Guidelines for managing and controlling access to CJIS        │
│  systems and data                                               │
└─────────────────────────────────────────────────────────────────┘
```

### 3. Key Points (Existing)
```
Key Points

┌─────────────────────────────────────────────────────────────────┐
│  ✓  Implement role-based access control                        │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  ✓  Regular access reviews and audits                          │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  ✓  Principle of least privilege                               │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  ✓  Access termination procedures                              │
└─────────────────────────────────────────────────────────────────┘
```

### 4. NEW: CJIS Policy References Panel
```
┌─────────────────────────────────────────────────────────────────┐
│  📋  CJIS Policy References                                     │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │ ⓘ Informational only - not compliance certification      │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                  │
│  ┌────────────┐                                                 │
│  │ Section 5.2│                                                 │
│  └────────────┘                                                 │
│  Access Control requires agencies to limit system and data     │
│  access to authorized users only, implement role-based         │
│  permissions, and regularly review who has access to what.     │
│                                                                  │
│  ┌──────────────┐                                               │
│  │ Section 5.2.1│                                               │
│  └──────────────┘                                               │
│  Identification and Authentication ensures each user has a     │
│  unique identifier and proper authentication before accessing  │
│  CJIS systems.                                                  │
└─────────────────────────────────────────────────────────────────┘
```
- Policy icon (📋)
- Informational disclaimer badge
- Section numbers in colored badges
- Plain-language interpretations

### 5. NEW: Risk Context Panel (Collapsible)
```
┌─────────────────────────────────────────────────────────────────┐
│  ⚠️  Why this matters                                      [▼] │
└─────────────────────────────────────────────────────────────────┘

When expanded:
┌─────────────────────────────────────────────────────────────────┐
│  ⚠️  Why this matters                                      [▲] │
│  ─────────────────────────────────────────────────────────────  │
│  ⚠  Unauthorized access to criminal justice information can    │
│     compromise ongoing investigations and public safety        │
│                                                                  │
│  ⚠  Improper access controls increase the risk of data         │
│     breaches and potential legal liability                     │
│                                                                  │
│  ⚠  Lack of proper user accountability makes it difficult to   │
│     track who accessed what information and when               │
│                                                                  │
│  ⚠  Overly permissive access creates insider threat            │
│     vulnerabilities                                             │
└─────────────────────────────────────────────────────────────────┘
```
- Warning icon
- Collapsible with smooth animation
- Error-colored icons for each risk point
- Clear, concise risk explanations

### 6. NEW: Common Failure Patterns Panel
```
┌─────────────────────────────────────────────────────────────────┐
│  🐛  Common Failure Patterns                                    │
│                                                                  │
│  Watch out for these common issues observed in small agencies: │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │  ✗  Shared accounts                                       │ │
│  │     Multiple users sharing a single login defeats         │ │
│  │     accountability and audit trails                       │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │  ✗  Orphaned accounts                                     │ │
│  │     Former employees or transferred staff retaining       │ │
│  │     system access                                         │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │  ✗  Over-provisioned permissions                          │ │
│  │     Users having broader access than needed for their     │ │
│  │     job functions                                         │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │  ✗  Infrequent access reviews                             │ │
│  │     Failing to periodically verify that user access       │ │
│  │     remains appropriate                                   │ │
│  └───────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```
- Bug icon (🐛)
- Italicized intro text
- Each pattern in a bordered box
- X icon for each pattern
- Pattern name in bold
- Description indented

### 7. NEW: Priority Guidance Panel
```
┌─────────────────────────────────────────────────────────────────┐
│  ❗  Priority Guidance                                          │
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  ↗️  Higher risk when:                                   │   │
│  │     Your agency has high staff turnover, uses contractor│   │
│  │     personnel, or has interconnected systems with       │   │
│  │     multiple access points                              │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                Orange background                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  ↘️  Lower risk when:                                    │   │
│  │     You have a stable workforce, clear role definitions,│   │
│  │     and automated access management tools               │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                Green background                  │
└─────────────────────────────────────────────────────────────────┘
```
- Priority icon (❗)
- Two color-coded sections:
  - Orange background for higher risk
  - Green background for lower risk
- Trending arrows (↗️ for up, ↘️ for down)
- No numeric scores
- Descriptive, contextual guidance

### 8. Guided Assessment Section (Existing)
```
┌─────────────────────────────────────────────────────────────────┐
│  🎯  Guided Assessment Available                                │
│                                                                  │
│  Answer a series of questions to receive tailored guidance     │
│  and recommendations for this category.                        │
│                                                                  │
│  [▶ Start Guided Assessment]                                    │
└─────────────────────────────────────────────────────────────────┘
```

## Color Scheme

- **Primary**: Blue tones for headers and primary actions
- **Error/Warning**: Red/Orange for warnings and risk indicators
- **Success**: Green for lower risk and positive indicators
- **Surface**: Light gray/white for cards
- **Outline**: Subtle borders for visual separation

## Interactive Elements

1. **Risk Context Panel**: Click to expand/collapse with smooth animation
2. **Buttons**: Hover effects on all interactive elements
3. **Cards**: Subtle elevation shadows for depth
4. **Links**: Underline on hover for navigation elements

## Responsive Design

- All panels stack vertically on smaller screens
- Text wraps appropriately
- Icons and spacing adjust for readability
- Maximum content width of 900px for optimal readability

## Accessibility

- High contrast text
- Clear visual hierarchy
- Icon + text combinations for better understanding
- Semantic HTML structure
- Keyboard navigation support
- Screen reader friendly

## Data Completeness

All 6 categories have complete data:
1. ✅ Access Control
2. ✅ Authentication and MFA
3. ✅ Data Storage and Encryption
4. ✅ User Roles and Least Privilege
5. ✅ Cloud and Vendor Considerations
6. ✅ Training and Personnel Security

Each category includes:
- 2-3 CJIS Policy References
- 4 Risk Points
- 4 Common Failure Patterns
- Priority Guidance (higher/lower risk)
