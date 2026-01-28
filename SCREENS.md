# Application Screens Overview

This document provides a textual description of each screen in the CJIS Compliance Guidance Tool.

## 1. Disclaimer Screen (Home)

**Route**: `/`

**Layout**:
```
┌────────────────────────────────────────────────────────┐
│                    [Blue Gradient Background]          │
│                                                        │
│  ╔════════════════════════════════════════════╗       │
│  ║                                            ║       │
│  ║              🛡️ [Security Icon]           ║       │
│  ║                                            ║       │
│  ║        CJIS Compliance Guidance Tool       ║       │
│  ║                                            ║       │
│  ║  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ║       │
│  ║                                            ║       │
│  ║  Important Disclaimer                      ║       │
│  ║  • This is guidance only                   ║       │
│  ║  • Not an auditing system                  ║       │
│  ║  • Does not generate official assessments  ║       │
│  ║  • Not legal advice                        ║       │
│  ║                                            ║       │
│  ║  Intended Audience                         ║       │
│  ║  • Small to mid-sized agencies             ║       │
│  ║  • IT security personnel                   ║       │
│  ║  • Agency administrators                   ║       │
│  ║                                            ║       │
│  ║  Purpose                                   ║       │
│  ║  • Help interpret CJIS requirements        ║       │
│  ║  • Understand risks                        ║       │
│  ║  • Learn best practices                    ║       │
│  ║  • Provide decision-support                ║       │
│  ║                                            ║       │
│  ║  Limitations                               ║       │
│  ║  • No authentication or data storage       ║       │
│  ║  • Does not handle case data               ║       │
│  ║  • No logging of CJIS information          ║       │
│  ║  • Local browser session only              ║       │
│  ║  • Not a replacement for audits            ║       │
│  ║                                            ║       │
│  ║  ┌────────────────────────────────────┐   ║       │
│  ║  │ ⚠️ By continuing, you acknowledge  │   ║       │
│  ║  │ this is guidance only             │   ║       │
│  ║  └────────────────────────────────────┘   ║       │
│  ║                                            ║       │
│  ║         [I Understand - Continue]          ║       │
│  ║                                            ║       │
│  ╚════════════════════════════════════════════╝       │
│                                                        │
└────────────────────────────────────────────────────────┘
```

## 2. Categories Screen

**Route**: `/categories`

**Layout** (Desktop - 3 columns):
```
┌────────────────────────────────────────────────────────┐
│  CJIS Guidance Categories                              │
├────────────────────────────────────────────────────────┤
│                                                        │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ℹ️ Select a Category                             │ │
│  │ Choose a category to explore requirements...     │ │
│  └──────────────────────────────────────────────────┘ │
│                                                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐│
│  │ 🔐           │  │ 🔑           │  │ 💾           ││
│  │ Access       │  │ Auth & MFA   │  │ Data Storage ││
│  │ Control      │  │              │  │ & Encryption ││
│  │              │  │              │  │              ││
│  │ Guidelines   │  │ Multi-factor │  │ Requirements ││
│  │ for managing │  │ auth reqs... │  │ for storing  ││
│  │ access...    │  │              │  │ CJIS data... ││
│  │              │  │              │  │              ││
│  │ [Policy 5.2] │  │ [Policy 5.6] │  │ [Policy 5.10]││
│  │          →   │  │          →   │  │          →   ││
│  └──────────────┘  └──────────────┘  └──────────────┘│
│                                                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐│
│  │ 👥           │  │ ☁️            │  │ 📚           ││
│  │ User Roles & │  │ Cloud &      │  │ Training &   ││
│  │ Least Priv.  │  │ Vendor       │  │ Personnel    ││
│  │              │  │              │  │              ││
│  │ Implementing │  │ Requirements │  │ Personnel    ││
│  │ least priv.  │  │ for cloud... │  │ security...  ││
│  │ and roles... │  │              │  │              ││
│  │              │  │              │  │              ││
│  │ [Policy 5.2] │  │ [Policy 5.14]│  │ [Policy 5.1] ││
│  │          →   │  │          →   │  │          →   ││
│  └──────────────┘  └──────────────┘  └──────────────┘│
│                                                        │
└────────────────────────────────────────────────────────┘
```

## 3. Category Detail Screen

**Route**: `/category-detail`

**Example** (Access Control):
```
┌────────────────────────────────────────────────────────┐
│  ← Access Control                                      │
├────────────────────────────────────────────────────────┤
│                                                        │
│  ╔════════════════════════════════════════════╗       │
│  ║  🔐        Access Control                  ║       │
│  ║                                            ║       │
│  ║           [CJIS Policy Section 5.2]        ║       │
│  ║                                            ║       │
│  ║  Guidelines for managing and controlling   ║       │
│  ║  access to CJIS systems and data           ║       │
│  ╚════════════════════════════════════════════╝       │
│                                                        │
│  Key Points                                            │
│                                                        │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Implement role-based access control           │ │
│  └──────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Regular access reviews and audits              │ │
│  └──────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Principle of least privilege                   │ │
│  └──────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Access termination procedures                  │ │
│  └──────────────────────────────────────────────────┘ │
│                                                        │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ❓ Guided Assessment Available                   │ │
│  │                                                  │ │
│  │ Answer questions to receive tailored guidance   │ │
│  │                                                  │ │
│  │            [▶ Start Guided Assessment]           │ │
│  └──────────────────────────────────────────────────┘ │
│                                                        │
│              [← Back to Categories]                    │
│                                                        │
└────────────────────────────────────────────────────────┘
```

## 4. Guidance Flow - Question Screen

**Route**: `/guidance-flow`

**Example**:
```
┌────────────────────────────────────────────────────────┐
│  ← Access Control                                      │
├────────────────────────────────────────────────────────┤
│                                                        │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ❓ Question 1 of 2                               │ │
│  └──────────────────────────────────────────────────┘ │
│                                                        │
│  ╔════════════════════════════════════════════╗       │
│  ║                                            ║       │
│  ║  Does your organization have documented    ║       │
│  ║  access control policies?                  ║       │
│  ║                                            ║       │
│  ║  ┌────────────────────────────────────┐   ║       │
│  ║  │ ○ Yes, fully documented & current  │   ║       │
│  ║  │                                 →  │   ║       │
│  ║  └────────────────────────────────────┘   ║       │
│  ║                                            ║       │
│  ║  ┌────────────────────────────────────┐   ║       │
│  ║  │ ○ Partially documented             │   ║       │
│  ║  │                                 →  │   ║       │
│  ║  └────────────────────────────────────┘   ║       │
│  ║                                            ║       │
│  ║  ┌────────────────────────────────────┐   ║       │
│  ║  │ ○ No documentation                 │   ║       │
│  ║  │                                 →  │   ║       │
│  ║  └────────────────────────────────────┘   ║       │
│  ║                                            ║       │
│  ╚════════════════════════════════════════════╝       │
│                                                        │
│              [← Back to Category]                      │
│                                                        │
└────────────────────────────────────────────────────────┘
```

## 5. Guidance Flow - Result Screen

**Route**: `/guidance-flow` (result state)

**Example**:
```
┌────────────────────────────────────────────────────────┐
│  ← Access Control                                      │
├────────────────────────────────────────────────────────┤
│                                                        │
│  ╔════════════════════════════════════════════╗       │
│  ║          ✅ [Success Icon]                 ║       │
│  ║                                            ║       │
│  ║      Critical Documentation Gap            ║       │
│  ║                                            ║       │
│  ║      [CJIS Security Policy Section 5.2]    ║       │
│  ╚════════════════════════════════════════════╝       │
│                                                        │
│  ┌──────────────────────────────────────────────────┐ │
│  │ Assessment                                       │ │
│  │                                                  │ │
│  │ Lacking documented access control policies is a  │ │
│  │ significant compliance issue...                  │ │
│  └──────────────────────────────────────────────────┘ │
│                                                        │
│  Potential Risk Areas                                  │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ⚠️ Non-compliance with CJIS requirements         │ │
│  │ ⚠️ Unauthorized access risks                     │ │
│  │ ⚠️ Inability to demonstrate controls             │ │
│  │ ⚠️ Inconsistent enforcement                      │ │
│  └──────────────────────────────────────────────────┘ │
│                                                        │
│  Recommended Actions                                   │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Immediately begin documenting policies         │ │
│  └──────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Review CJIS Security Policy Section 5.2        │ │
│  └──────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Engage leadership for policy approval          │ │
│  └──────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Implement training program                     │ │
│  └──────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────┐ │
│  │ ✓ Establish regular policy review cycle          │ │
│  └──────────────────────────────────────────────────┘ │
│                                                        │
│      [🔄 Start Over]    [← Back to Category]          │
│                                                        │
│              [🏠 Return to All Categories]             │
│                                                        │
└────────────────────────────────────────────────────────┘
```

## Navigation Flow

```
┌─────────────┐
│ Disclaimer  │
│   Screen    │
└──────┬──────┘
       │ Click "Continue"
       ▼
┌─────────────┐
│ Categories  │
│   Screen    │
└──────┬──────┘
       │ Click category
       ▼
┌─────────────┐
│  Category   │
│   Detail    │
└──────┬──────┘
       │ Click "Start Assessment"
       ▼
┌─────────────┐
│  Question   │◄─┐
│   Screen    │  │ Next question
└──────┬──────┘  │
       │ Answer  │
       ▼         │
┌─────────────┐  │
│   Result    │  │
│   Screen    ├──┘ Start over
└─────────────┘

All screens can navigate back
using browser back button or
on-screen back buttons
```

## Responsive Behavior

### Desktop (>1200px)
- 3-column grid for categories
- Max content width: 900px
- Spacious padding

### Tablet (800-1200px)
- 2-column grid for categories
- Max content width: 800px
- Moderate padding

### Mobile (<800px)
- Single column for categories
- Full width (with margins)
- Compact padding

## Color Indicators

- **Blue**: Primary actions, navigation
- **Red**: Risks, warnings, errors
- **Green**: Success, positive outcomes
- **Gray**: Neutral information
- **Light backgrounds**: Information panels

## Icon Legend

- 🛡️ Security - Protection, safety
- 🔐 Lock - Access control
- 🔑 Key - Authentication
- 💾 Disk - Data storage
- 👥 People - User management
- ☁️ Cloud - Cloud services
- 📚 Books - Training, documentation
- ❓ Question mark - Questions
- ✓ Checkmark - Completed, recommended
- ⚠️ Warning - Risks, caution
- ℹ️ Info - Information
- → Arrow - Navigation
- ← Back arrow - Go back

## Interactive Elements

All cards and buttons have:
- Hover effects (elevation change)
- Click/tap feedback
- Keyboard navigation support
- Clear focus indicators
- Accessible labels

---

This visual guide helps understand the application flow without running the code.
