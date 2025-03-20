### Product Requirements Document (PRD): Turntable.fm Recreation

#### Overview
This Product Requirements Document (PRD) outlines the specifications for recreating Turntable.fm, a pioneering social music platform, from scratch using modern technologies: Next.js, TypeScript, React 19, and Supabase. The purpose of this document is to provide a comprehensive guide for the development team to rebuild Turntable.fm’s core functionalities, delivering a real-time, interactive, and community-driven music experience. The platform will enable users to create and join virtual rooms, act as DJs, share music, engage in real-time chat, and vote on songs, all while fostering a vibrant social environment. This PRD captures the essence of the original Turntable.fm, adapts it to contemporary technical standards, and ensures scalability, usability, and legal compliance.

---

### Objectives and goals
#### Project objectives
- Recreate Turntable.fm’s unique “live social music experience” with virtual rooms as hubs for music sharing and interaction.
- Leverage modern technologies (Next.js, TypeScript, React 19, Supabase) to ensure performance, scalability, and maintainability.
- Enable seamless real-time functionality for music playback, chat, and voting using Supabase’s real-time capabilities.
- Integrate social sign-on (e.g., via Supabase Auth) to simplify user onboarding and enhance social connectivity.
- Support a diverse, user-driven community with customizable rooms and music discovery features.

#### Success metrics
- **User engagement**: Achieve an average session duration of 30+ minutes per user within the first three months of launch.
- **Room creation**: 1,000+ active public rooms created within the first month post-launch.
- **Scalability**: Support 10,000 concurrent users across all rooms with no significant latency (<500ms for real-time updates).
- **Retention**: Attain a 40% day-30 retention rate for new users.
- **Music diversity**: Facilitate the playback of 10,000+ unique tracks monthly through user uploads and library access.

---

### Scope
#### In-scope features
- Virtual room creation and management (public/private, themes, DJ slots).
- Real-time DJing with song selection, queue management, and playback controls.
- Audience voting system (“awesome”/“lame”) with dynamic song skipping.
- Real-time in-room chat for social interaction.
- User profiles with avatars, DJ points, and follow functionality.
- Social sign-on integration (e.g., Google, Facebook via Supabase Auth).
- Music discovery through genre-based rooms and user-driven curation.
- Mobile responsiveness via Next.js and React 19.
- Supabase integration for database, real-time updates, and authentication.

#### Out-of-scope features
- Native mobile apps (initial focus on web-based experience).
- Advanced algorithmic music recommendations (initially user-driven only).
- Video streaming or music video integration.
- Third-party plugin ecosystem (e.g., browser extensions).

---

### Assumptions and constraints
#### Assumptions
- Users have access to modern web browsers (Chrome, Firefox, Safari, Edge) supporting WebSocket and HTML5 audio.
- Supabase can handle real-time requirements for 10,000+ concurrent users.
- Licensing agreements for a music library (similar to MediaNet’s 11M+ tracks) can be secured or approximated via user uploads.
- Users are familiar with social platforms and basic music streaming interfaces.

#### Constraints
- **Licensing**: Music playback must comply with copyright laws, restricting solo listening and imposing artist/song frequency limits.
- **Scalability**: Initial room capacity limited to 200 interactive users, with overflow rooms for additional listeners.
- **Budget**: Development constrained to a single sprint cycle (e.g., 3 months) for MVP launch.
- **Team expertise**: Assumes proficiency in Next.js, TypeScript, React 19, and Supabase.

---

### User personas
#### Casual listener
- **Name**: Alex, 25, music enthusiast
- **Goals**: Discover new music, join friends in rooms, vote on songs
- **Pain points**: Overwhelmed by generic playlists, lacks social interaction in streaming
- **Tech savviness**: Moderate, uses Spotify and Discord regularly

#### Aspiring DJ
- **Name**: Jamie, 30, amateur musician
- **Goals**: Share curated playlists, gain recognition, build a following
- **Pain points**: Limited platforms to showcase DJ skills socially
- **Tech savviness**: High, comfortable with digital audio tools

#### Community builder
- **Name**: Sam, 35, music blogger
- **Goals**: Create niche rooms (e.g., indie rock), foster discussions
- **Pain points**: Hard to find engaged audiences for specific genres
- **Tech savviness**: Moderate, runs a WordPress blog

---

### Functional requirements
#### Virtual rooms
- **Room creation**
  - Users can create public or private rooms with customizable names and themes (e.g., genre, mood).
  - Specify 1-5 DJ slots per room (default: 5).
  - Private rooms require invite links or user approval.
- **Room joining**
  - Display a list of public rooms ranked by popularity (active users).
  - Search rooms by name or theme.
  - Show friends’ active rooms via social sign-on integration.
- **Room types**
  - Support genre-based (e.g., “Hip-Hop”), mood-based (e.g., “Chill Vibes”), and private rooms.
  - Allow overflow rooms for scalability beyond 200 interactive users.
- **Scalability**
  - Limit interactive users (chat/voting) to 200 per main room; unlimited listeners in overflow rooms.

#### DJing experience
- **Becoming a DJ**
  - Open DJ slots filled on a first-come, first-served basis or via a queue system (room-specific).
  - Visual indication of available slots on a virtual stage.
- **Song selection**
  - Access a licensed music library (target: 10M+ tracks) via API integration.
  - Allow user uploads (stored in Supabase storage) with legal restrictions.
  - Preview songs before playback.
- **DJ controls**
  - Display track info (artist, title, album) during playback.
  - Manage song queue (add, reorder, remove, skip).
- **Rules and limits**
  - Default limit: 4 songs per DJ set, 30-minute cooldown.
  - Auto-remove idle DJs after 10 minutes of inactivity.
  - Restrict same artist/song replays within 1 hour.

#### Audience engagement
- **Voting system**
  - “Awesome” and “lame” buttons for real-time feedback.
  - “Awesome” votes earn DJ points (1 point per vote).
  - “Lame” votes skip songs if threshold met (e.g., 20% of active users).
- **Visual feedback**
  - Avatars bob heads on “awesome” votes, slump on “lame” votes.
- **DJ points**
  - Unlock new avatars at milestones (e.g., 50, 100, 500 points).

#### Social interaction
- **In-room chat**
  - Real-time text chat for all users in a room (Supabase real-time).
  - Support basic formatting (e.g., bold, emojis).
- **User profiles**
  - Display username, avatar, DJ points, and followed users.
  - Clickable avatars link to profiles.
- **Following users**
  - Notify users when followed DJs start playing.
- **Sharing rooms**
  - Share room links via social media, email, or permalink.

#### User interface
- **Room layout**
  - DJ stage at top, audience avatars below, chat on the side, voting buttons at bottom.
- **DJ controls interface**
  - Virtual turntable design with queue management tools.
- **Social elements**
  - Chat bubble icon, share buttons, and avatar pop-ups.

---

### Non-functional requirements
#### Performance
- Real-time updates (chat, voting, playback) delivered within 500ms.
- Support 10,000 concurrent users with <5% error rate.

#### Scalability
- Scale rooms dynamically via Supabase and Next.js serverless functions.
- Handle 1,000+ active rooms concurrently.

#### Security
- Secure user data with Supabase Auth (JWT tokens).
- Encrypt sensitive data (e.g., private room links) at rest and in transit.

#### Usability
- Intuitive navigation with <3 clicks to join a room or start DJing.
- Mobile-responsive design (min. 320px width).

---

### User stories and acceptance criteria
#### Room creation and joining
- **US-001**: As a user, I want to create a public room so I can share music with others.
  - **Acceptance Criteria**: 
    - User can set a room name and theme.
    - Room defaults to public with 5 DJ slots.
    - Room appears in public list within 5 seconds.
- **US-002**: As a user, I want to create a private room so I can host exclusive sessions.
  - **Acceptance Criteria**: 
    - User can mark room as private and generate an invite link.
    - Only invited users can join.
- **US-003**: As a user, I want to join a room so I can listen and interact.
  - **Acceptance Criteria**: 
    - User sees list of public rooms with popularity ranking.
    - User can search and join a room in <3 clicks.

#### DJing experience
- **US-004**: As a DJ, I want to claim a DJ slot so I can play music.
  - **Acceptance Criteria**: 
    - Open slots are clickable and assignable.
    - User appears on stage within 2 seconds.
- **US-005**: As a DJ, I want to select and play songs so I can share my taste.
  - **Acceptance Criteria**: 
    - User can search library or upload songs.
    - Song plays for all users with <1s latency.
- **US-006**: As a DJ, I want to manage my queue so I can plan my set.
  - **Acceptance Criteria**: 
    - User can add, reorder, or remove songs.
    - Changes reflect instantly in UI.

#### Audience engagement
- **US-007**: As a listener, I want to vote on songs so I can influence the playlist.
  - **Acceptance Criteria**: 
    - “Awesome” and “lame” buttons are clickable.
    - Votes update DJ points and trigger skips as per threshold.
- **US-008**: As a listener, I want visual feedback so I can see others’ reactions.
  - **Acceptance Criteria**: 
    - Avatars animate based on votes within 1s.

#### Social interaction
- **US-009**: As a user, I want to chat in real-time so I can connect with others.
  - **Acceptance Criteria**: 
    - Messages appear instantly (<500ms).
    - Chat supports 200+ users without lag.
- **US-010**: As a user, I want to follow DJs so I can track their sessions.
  - **Acceptance Criteria**: 
    - Follow button adds DJ to user’s list.
    - Notification sent when DJ starts playing.

#### Authentication
- **US-011**: As a user, I want to log in with social sign-on so I can access the platform easily.
  - **Acceptance Criteria**: 
    - Login via Google/Facebook integrates with Supabase Auth.
    - User profile auto-populates with basic info (e.g., name, avatar).
    - Session persists across devices.

#### Edge cases
- **US-012**: As a user, I want to join an overflow room if the main room is full.
  - **Acceptance Criteria**: 
    - User redirected to overflow room at 200+ capacity.
    - Listening enabled, chat/voting disabled.

---

### Technical requirements
#### Frontend
- Built with Next.js, TypeScript, and React 19.
- Real-time UI updates via Supabase subscriptions.
- Responsive design using CSS-in-JS (e.g., Emotion).

#### Backend
- Supabase for database (PostgreSQL), real-time WebSockets, and storage.
- Serverless API routes in Next.js for custom logic (e.g., room management).

#### Integrations
- Social sign-on via Supabase Auth (OAuth 2.0).
- Music library API (e.g., MediaNet or equivalent) for licensed tracks.

#### Infrastructure
- Hosted on Vercel for Next.js deployment.
- Supabase hosted instance for scalability and real-time features.

---

### Risks and mitigation
#### Licensing risks
- **Risk**: Inability to secure music library licenses.
- **Mitigation**: Rely on user uploads initially, negotiate with providers post-MVP.

#### Scalability risks
- **Risk**: Supabase real-time limits exceeded.
- **Mitigation**: Implement fallback queuing system, optimize WebSocket usage.

#### User adoption risks
- **Risk**: Low initial user base.
- **Mitigation**: Leverage social sharing, target niche music communities.

---

### Timeline and milestones
- **Month 1**: Setup (tech stack, Supabase integration, basic UI).
- **Month 2**: Core features (rooms, DJing, voting, chat).
- **Month 3**: Polish (profiles, social features), testing, launch MVP.
- **Launch Date**: June 19, 2025 (target).

---

### Appendix
- **References**: See “Works cited” in prd_instructions for source material.
- **Glossary**: 
  - DJ slot: Virtual position for music playback control.
  - Overflow room: Secondary listening space for scalability.