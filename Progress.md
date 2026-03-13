Week_002
A client-based project has been selected, thanks to the coursework supervisor.
A project for the coursework has been requested this week due to the Olympiad.
The coursework topic and details will be provided by the supervisor shortly, and it requires waiting. The lead supervisor has priority.
Link to chat with supervisor: https://drive.google.com/file/d/1_ONQI1hsWcM1KQTlGy4SeSbDY1Mam2R5/view?usp=sharing



Week_003
Project description:

My final idea is not just a loan aggregator like Banki.ru or Nova Bank, but a personal financial navigator that helps people not only choose a product, but also understand what is realistically available to them and what financial path is safe.
ClearLoan is a fintech application designed as a financial navigator for Kyrgyzstan, created to help people find loan options that are not only available, but also realistically achievable for their personal situation. Unlike traditional loan marketplaces that simply display interest rates and product catalogs, ClearLoan focuses on guiding users toward the safest and most accessible financial decisions.
I chose to develop ClearLoan because financial accessibility remains a significant issue in Kyrgyzstan, especially outside major cities. Today, in order to obtain a loan, individuals often need to visit multiple banks, submit repeated documents, and wait several days just to understand whether approval is possible. This process leads to wasted time, frustration, and a high number of rejections, particularly for young people, rural residents, and those without a strong credit history.
The main purpose of ClearLoan is to shift the logic from “Where is the cheapest loan?” to “What financial product can I realistically receive right now, and why?” The platform connects banks and microfinance institutions, but works not as a simple showcase, but as an intelligent filter. After completing a short application, the user receives a personalized overview of offers: which loans are likely to be approved, where rejection is possible, and what steps can improve approval chances in the future.
If a loan is not currently accessible, ClearLoan proposes alternative solutions such as smaller amounts, installment plans, microfinance options, or a preparation roadmap. This transforms rejection into a clear next step rather than a dead end, helping users make more responsible financial decisions.
A key advantage of this concept is reducing unnecessary applications and lowering refusal rates. Financial institutions benefit by receiving more qualified and prepared clients, which decreases the workload on branch offices and call centers while improving conversion efficiency. Users benefit by saving time and gaining transparent understanding of their real financial opportunities.
ClearLoan is especially valuable for Kyrgyzstan because it considers local conditions, including weak internet connectivity in many regions. The platform can provide basic offline access through SMS or USSD to check application status and receive offers. Additionally, presenting information in a simple and understandable way, including support for the Kyrgyz language, increases trust and improves financial literacy among users with limited financial background.
Overall, I selected this project because ClearLoan addresses multiple important goals: improving financial inclusion, reducing ineffective loan applications, supporting safer borrowing decisions, and creating a scalable fintech infrastructure that can strengthen the financial ecosystem of Kyrgyzstan.

Competitors:

Several similar platforms already exist internationally, showing that the idea of digital loan marketplaces is востребована, but ClearLoan introduces important improvements adapted specifically for Kyrgyzstan.
One example is LendingTree (USA), one of the largest online loan comparison platforms. It allows users to compare offers from banks and lenders, but it mainly focuses on interest rates rather than approval probability or financial guidance.
Another well-known product is NerdWallet (USA), which provides comparisons of financial products such as loans, credit cards, and insurance. However, it works mostly as an informational catalog and does not offer personalized approval forecasting.
In Europe, Revolut has expanded beyond digital banking into personal finance services, offering loans and credit products directly through the app. Still, it operates mainly within highly developed financial systems and does not target regions with limited banking access.
A similar Russian example is Sravni.ru, which functions as a marketplace for loans, insurance, and banking services. Like Banki.ru, it helps users compare products but does not strongly focus on reducing rejection rates through pre-scoring.
Another relevant case is Credit Karma (USA/UK), which provides users with credit score monitoring and personalized financial recommendations. While it includes some approval-oriented suggestions, it depends heavily on established credit bureau systems that are not fully developed in Kyrgyzstan.
These examples demonstrate that financial marketplaces are common globally, but ClearLoan differentiates itself by combining loan aggregation with approval probability assessment, alternative pathways for users, and offline accessibility features tailored to the specific conditions of Kyrgyzstan.
<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/041fb972-d057-4f20-b670-683614f2b38e" />


What's been accomplished in the third week:
- The app framework was created
- Prospects were discussed with the Elkart MPC
- The app widgets are working properly
- A developer account was purchased

Week_004

Benefits of my app:

The ClearLoan app is a socially significant fintech solution because it helps make banking services more accessible and understandable for a wide range of people in Kyrgyzstan. Today, many people face difficulties obtaining a loan: they must personally visit various banks, fill out numerous documents, wait several days for a decision, and often end up being rejected without explanation. This is especially true for residents of rural areas, young people, the self-employed, and people without a credit history.

ClearLoan solves this problem by serving not just as a loan directory, but as a financial navigator. It helps people understand in advance which offers are actually available to them, where the likelihood of approval is higher, and what steps they need to take to improve their chances. This reduces the number of unfounded applications and rejections, and the process of obtaining financial services becomes more transparent and fair.

The app is particularly useful in Kyrgyzstan, where rural areas often experience poor internet access and limited access to banking infrastructure. The ability to access the service offline via SMS or USSD makes it convenient even for those who can't regularly use the mobile app. Furthermore, its simple language and Kyrgyz language support help people better understand financial terms and make more informed decisions.

Thus, ClearLoan promotes financial literacy, reduces debt risks, promotes financial inclusion, and strengthens trust between citizens and the banking system. This makes the app beneficial not only for individual users but also for society as a whole, as it promotes a more sustainable and accessible financial environment in the country.

Progress of week 004:

- Simple registration upon login (where they ask for a phone number, password, and passport information (only during registration, not upon login))
- Footer: The first section will contain an aggregator, the second a "basket" of current loans, the third section where you enter the loan terms and the one you want, and the fourth section a profile where you can see your details, including your current employment status.
- At least some design and UI have been added, and in a red-green color scheme. Also, add a switcher where you can change the language (either Russian or Kyrgyz).

## Progress of week 005:
Slightly improved the overall UI. The color scheme was adjusted toward a brighter green-white fintech style, replacing the previous darker tone. Basic spacing, typography, and card components were cleaned up to make the interface look more structured, though the design is still relatively simple and not fully polished.

Added a loan type selector in the “Request” section. Users can now choose between several basic options (for example: mortgage, consumer loan, etc.). The logic behind recommendations remains prototype-level and does not yet reflect real scoring or approval systems.

Moved the language switcher to the main authentication screens (Login / Registration). Users can now toggle between Russian and Kyrgyz. Translation coverage is partial and mostly affects UI labels rather than full localization.

Extended the registration form. In addition to phone number, password, and passport details, users now must specify:

Occupation (what they work as)

Monthly income
These fields are currently stored but not yet deeply used in scoring logic.

Created a basic Django backend with a simple SQLite database. It supports:

User registration

User login

Basic storage of profile data

Simple loan offer endpoints
The backend is minimal and does not yet include advanced validation, encryption layers beyond Django defaults, or real banking integrations.

Implemented a simple bottom navigation footer with four sections:

Aggregator (loan offers list)

Loans (active loans overview)

Request (loan conditions form)

Profile (user information and logout)

Added light animations (page transitions and minor UI effects). These are basic Flutter animations and do not yet represent a fully production-ready motion system.


 ## Progress of Week 006:

The overall structure of the ClearLoan application was significantly refined to better reflect the concept of a financial navigator rather than a simple loan comparison tool. The interface was visually unified across all main screens, improving consistency in typography, spacing, and component hierarchy. The design now follows a clearer green-white fintech style with improved readability and simplified visual elements. Navigation responsiveness and screen transitions were slightly optimized to provide smoother interaction, although animations remain lightweight and prototype-level.

The loan aggregator screen was expanded with additional Kyrgyzstan banks and microfinance institutions to better simulate a realistic financial marketplace. Loan cards were redesigned to present information in a clearer format, including provider name, loan amount, interest rate, repayment term, and dynamically generated decision status. Loan approval is no longer displayed automatically. Instead, the system now performs a basic internal analysis before assigning a result such as Approved, Alternative, or Rejected.

A prototype credit scoring logic was introduced on the backend side. The decision process now considers user-provided parameters such as occupation, monthly income, requested amount, and simulated credit history indicators. This scoring mechanism remains simplified but demonstrates how approval decisions could be generated instead of being hardcoded.

The Django backend was substantially improved. Database models were extended to support user credit history, loan applications, and analytical decision results. API endpoints were reorganized to better separate authentication, loan requests, and profile data management. The backend now stores historical loan interactions, enabling future expansion toward recommendation systems and approval probability estimation.

The Profile section was enhanced with a dedicated credit history module. Users can now view previously requested or active loans along with status information. For users without any prior credit activity, the section remains empty, reflecting realistic behavior rather than placeholder data. Basic visual reporting elements were added to represent financial activity trends in a simplified form.

Multilingual support was expanded to include three languages: English, Russian, and Kyrgyz. Core interface elements were translated consistently across authentication, navigation, and main workflow screens. Localization is implemented at UI level and prepared for future full internationalization.

The main aggregator screen now includes sponsor attribution displayed at the bottom of the interface, indicating Aiyl Bank as the supporting organization of the application concept. This element was integrated carefully to avoid disrupting usability while maintaining visual balance.

Loan request functionality was improved with clearer input structure and validation feedback. Users can now select loan purpose categories and receive recommendations generated through backend evaluation rather than static responses. The overall request flow better reflects a guided financial decision process.

Additional internal improvements were introduced, including cleaner API communication structure, improved state handling between screens, and preparation for future offline-friendly logic described in the technical specification. While the system remains an MVP prototype, it now demonstrates a more realistic interaction between frontend interface, backend analysis, and user financial data management.


## Progress of Week 006 (2)

During Week 006, the ClearLoan project was significantly improved to better demonstrate a realistic fintech mobile application rather than only a visual prototype. The main focus of this stage was to enhance system interaction, simulate real financial behavior, improve usability, and prepare the application for presentation and evaluation.

One of the major improvements was the creation of a simulated database containing **25 predefined users**, each having different personal and financial characteristics. These users were generated to imitate real banking clients with different credit situations. Some users have a clean credit history, some contain delayed payments, while others have mixed or completely empty credit records. This allows the system to demonstrate how loan recommendations and approval decisions change depending on the applicant’s financial profile instead of always returning identical results.

All demo users can be accessed directly for testing purposes. Every generated user shares the same password, which simplifies evaluation of the system functionality.

Example login credentials:

Phone: +996700100000  
Password: demo12345  

Phone: +996700100005  
Password: demo12345  

Phone: +996700100012  
Password: demo12345  

Phone: +996700100018  
Password: demo12345  

Phone: +996700100024  
Password: demo12345  

Any phone number within the following range can be used to log into the system:

+996700100000 — +996700100024  

After logging in for the first time, the application requests users to create a **4-digit PIN code**, allowing faster authentication on future launches without repeatedly entering login credentials. This behavior simulates modern mobile banking applications.

The Aggregator section of the application was redesigned so that banks are no longer displayed as static text elements. Each bank is now implemented as an interactive widget. When a user selects a bank, the application opens a dedicated Bank Details screen containing structured information such as headquarters address, branch locations, available credit products, interest rates, and repayment conditions. This change transforms the aggregator into a functional financial marketplace rather than a simple informational list.

The loan request process was also expanded into a full multi-step workflow. Users now select loan type, requested amount, and repayment period, after which the request is sent to the backend scoring system. The backend analyzes available data including income level, occupation, and simulated credit history. Based on this analysis, the system returns a list of banks sorted by estimated approval probability. Banks with a higher chance of approval appear first. After choosing a bank, the user proceeds to a confirmation screen where complete loan information is displayed again, including selected bank, loan conditions, repayment duration, and calculated monthly payment. The user then confirms the application, which is stored in the backend and becomes visible inside the Loans Basket section.

Filtering functionality inside the Aggregator was converted from visual placeholders into a working backend-driven system. Loan offers can now be filtered according to multiple parameters such as loan type, repayment duration, interest level, or general suitability. The filters now actively request filtered data from the backend instead of only modifying the interface visually.

The onboarding process was extended with a structured welcome screen where users select application theme (light or dark mode) and choose between **Individual** and **Legal Entity** account types. Registration for legal entities now includes additional company information such as company name, tax identification number (INN), company address, fax number, contact phone, director information, and estimated monthly profit. This allows the application to demonstrate support for both personal and business clients.

During this development stage, visual branding of the application was also completed. A dedicated **ClearLoan logo** and a promotional **mobile application poster** were designed to establish a recognizable fintech identity. These elements improve presentation quality and make the project closer to a real commercial product ready for demonstration.

The Django backend architecture was further refined to clearly separate authentication, loan aggregation, scoring logic, and user profile management. The application now communicates through structured API endpoints responsible for authentication, loan retrieval, recommendation generation, application submission, and credit history access.

Main endpoints used in the system include:

POST /api/auth/register/  
POST /api/auth/login/  

GET /api/loans/products/  
GET /api/loans/banks/<code>/  

GET /api/loans/options/scored/  
POST /api/loans/applications/apply/  

GET /api/loans/applications/  
GET /api/loans/credit-history/  
GET /api/profile/  

The Profile section was enhanced with a credit history module that displays previously submitted or active loans together with their statuses. If a user has no prior credit activity, the section remains empty, reflecting realistic system behavior rather than displaying placeholder information.

Overall, by the end of Week 006, ClearLoan evolved into a functional MVP demonstrating interaction between frontend interface, backend decision logic, simulated financial data, and user-centered loan navigation. The project now represents a working prototype of a financial navigator adapted to the needs of users in Kyrgyzstan and suitable for live demonstration.


Progress of Week 007:

During Week 007, the ClearLoan project underwent a major expansion aimed at transforming the prototype into a more realistic and deployable fintech application. This stage focused on improving database quality, implementing stricter financial filtering logic, expanding user roles, stabilizing backend infrastructure, and deploying the system to a cloud environment so that the mobile application can function outside the local development environment.

One of the primary improvements introduced during this week was the refinement of the **credit decision and filtering system**. Previously, loan requests could be submitted regardless of the user's credit reliability. The system now performs a pre-validation step before allowing a loan request to be sent to banks. If a user has more than three yellow credit warnings (late payments) or at least one red credit violation (a credit that remained unpaid for more than three months), the application automatically blocks the loan request. This ensures that risky applications are filtered out early and prevents bank employees from receiving requests that would realistically never be approved.

In addition to blocking risky requests, the backend logic was extended to **evaluate approval probability**. The system now analyzes user parameters such as monthly income, occupation, requested loan amount, repayment duration, and credit history category. Based on these factors, the backend assigns a simulated decision status such as Approved, Alternative, or Rejected. This mechanism makes the financial recommendation system more realistic and allows the application to simulate real credit evaluation workflows used by financial institutions.

Another major change during this week was the **expansion and restructuring of the database**. The original dataset containing 25 simulated users was significantly improved. Each user profile now contains more detailed financial information, including:

- occupation and employment status
- monthly income
- previously issued loans
- loan repayment records
- categorized credit events (green, yellow, red)
- simulated credit risk levels

These improvements make the database far more representative of real banking clients and allow the scoring system to produce more meaningful decisions.

The database now also stores additional financial data for each test user, including:

- type of previously issued loans (consumer loan, mortgage, business loan)
- original loan amount
- remaining balance
- monthly repayment amount
- repayment behavior history
- approval or rejection outcomes for previous requests

This expanded dataset enables the system to simulate more complex financial analysis and prepares the backend for future features such as behavioral analytics or financial recommendation models.

Another important addition introduced during this week was the creation of **separate system roles for bank administration and staff members**. The system now supports three main user roles:

- regular client users
- bank administrators
- bank staff (loan specialists)

Bank administrators can manage internal bank settings and oversee the credit request flow. Bank staff members represent loan officers who review incoming applications. The filtering system ensures that these staff members receive only valid and potentially approvable loan requests rather than large volumes of rejected applications.

Example login credentials were created for demonstration purposes.

Example client accounts:

Phone: +996700100000  
Password: demo12345  

Phone: +996700100005  
Password: demo12345  

Phone: +996700100012  
Password: demo12345  

Phone: +996700100018  
Password: demo12345  

Phone: +996700100024  
Password: demo12345  

Any phone number in the following range can be used for testing:

+996700100000 — +996700100024

Example bank administrator account:

Phone: +996555200000  
Password: demo12345  

Example bank staff account (loan specialist):

Phone: +996556200000  
Password: demo12345  

These additional roles allow the project to demonstrate how financial institutions manage incoming credit applications internally.

During this development stage, backend API functionality was also carefully reviewed and stabilized. Key endpoints responsible for loan aggregation, bank information retrieval, credit scoring, and application submission were tested to ensure reliable communication between the frontend and backend services. This verification process ensured that the mobile application can consistently interact with the server without breaking the core financial workflow.

A major milestone achieved during Week 007 was the **deployment of the backend infrastructure to a cloud platform**. The Django backend was containerized using Docker and deployed to the Koyeb cloud hosting environment. This allowed the backend to run as a public web service accessible through a secure HTTPS domain. Environment variables were configured to manage security parameters, application settings, and database connections.

To support persistent data storage, the project was integrated with a **Supabase PostgreSQL database**. This replaced the temporary SQLite database previously used during local development. PostgreSQL provides a more reliable and scalable database system capable of supporting real multi-user environments. The connection between Django and Supabase ensures that all users, credit histories, loan applications, and financial records are stored safely in the cloud.

Several infrastructure adjustments were required during the deployment process. Docker configuration was refined, environment variables were configured for production settings, and domain-related security restrictions such as allowed hosts and CSRF trusted origins were corrected to allow secure communication between the deployed backend and the mobile application.

After deployment, the Flutter frontend was configured to communicate directly with the public API endpoint provided by the cloud platform. The application now retrieves bank offers, credit products, and user data from the remote backend instead of relying on a local development server. This change allowed the application to function properly on real mobile devices connected through the internet.

The mobile build pipeline was also finalized during this week. The Flutter project was compiled into both **APK and Android App Bundle (AAB)** formats. The APK build allows the application to be installed directly on Android devices for testing purposes, while the AAB format prepares the project for potential submission to the Google Play Store.

During the mobile build process, additional configuration steps were introduced to ensure stable communication with the backend. Internet permissions were verified in the Android manifest, release builds were configured correctly, and the application was compiled with the production API endpoint so that it can communicate with the deployed backend server.

Several user interface improvements were also made to improve overall usability and visual consistency. Minor adjustments were applied to layout spacing, typography hierarchy, and interactive components to ensure that the interface remains readable and comfortable to use on mobile devices. These adjustments help the application appear more polished and suitable for demonstration purposes.

Summary of key changes introduced during Week 007:

- Improved credit filtering logic preventing risky loan applications from being submitted.
- Added simulated approval decision system based on user financial characteristics.
- Expanded database structure with detailed financial attributes and loan histories.
- Enhanced the dataset of 25 simulated users with richer financial information.
- Implemented separate roles for clients, bank administrators, and loan specialists.
- Stabilized and verified backend API endpoints.
- Containerized the Django backend using Docker.
- Deployed the backend to the Koyeb cloud platform.
- Integrated the system with a Supabase PostgreSQL cloud database.
- Connected the Flutter mobile application to the deployed backend API.
- Built Android release versions of the application (APK and AAB).
- Improved user interface elements for a cleaner and more consistent visual presentation.

By the end of Week 007, ClearLoan evolved into a fully functioning fintech prototype with a cloud-hosted backend, a persistent relational database, realistic financial filtering logic, multiple user roles, and a mobile-ready Android application build. The system now closely reflects the architecture and operational flow of modern financial technology platforms.


Progress of Week 008

During Week 008, the ClearLoan project focused on implementing the technical tasks defined in the weekly development plan and completing several important functional improvements. The goal of this stage was to transform the prototype into a more realistic fintech demonstration system with improved banking information, user interaction features, backend logic, and a fully deployed cloud infrastructure.

A major milestone of this week was the successful deployment of the application backend to a cloud server. The Django REST Framework backend was containerized and deployed using Docker to the Koyeb cloud platform. This allowed the application to function as a real web service accessible from the internet rather than only running locally. The backend server was connected to a PostgreSQL database hosted on Supabase, which now stores all persistent application data including users, banks, loan products, ratings, notifications, and loan applications.

Another important task completed during this stage was the improvement of the loan aggregation system. Previously, the aggregator displayed loan offers in a static or neutral order. During Week 008, the system was enhanced with a rule-based recommendation mechanism that ranks loan products based on user financial parameters. The recommendation logic now evaluates factors such as income level, loan amount, credit history indicators, and employment status. This allows the aggregator to prioritize banks that have a higher probability of approving the requested loan.

The banking information module was also significantly expanded. Each bank now contains detailed institutional information including headquarters address, contact phone numbers, descriptive background text, and a structured list of loan products offered by the institution. This change allows the application to simulate a realistic financial information platform where users can explore the full range of services provided by each bank.

Special improvements were made to the Islamic credit aggregator. Earlier versions of the system were limited to displaying Islamic financing options from only a single bank. The data model and filtering logic were updated so that loan products can now be marked as Islamic-compliant and dynamically displayed in the aggregator when available. This allows the system to represent a broader set of financial institutions offering Sharia-compliant credit products.

Another feature implemented during this week was the bank rating system. Users can now evaluate banks by assigning a rating from one to five stars and optionally leaving comments about their experience. These ratings are stored in the backend database and aggregated to generate an average score for each institution. This feature introduces a community feedback element similar to the rating systems used in many real financial platforms.

The project also introduced a notification module that allows the backend to generate messages for users regarding important events such as loan application results or system updates. These notifications are stored in the database and retrieved through API endpoints, while the Flutter frontend displays them in a dedicated notifications screen.

Another usability improvement implemented during Week 008 was biometric authentication support. Users can now unlock the application using fingerprint authentication after the initial login process. This simulates the biometric security mechanisms commonly used in modern mobile banking applications and improves both convenience and security.

The user interface also received improvements with the addition of a financial literacy section. This module provides short educational materials explaining fundamental financial topics such as responsible borrowing, interest rates, and credit management. The goal of this section is to simulate the educational features often included in modern banking applications to help users make informed financial decisions.

In addition to these functional improvements, the project architecture was further documented and visualized. A complete system flowchart was created to illustrate the interaction between the Flutter client application, the Django REST backend, the Supabase PostgreSQL database, and the Koyeb deployment infrastructure. This flowchart describes the full data flow within the system including API requests, backend processing logic, and database interactions.

Overall, Week 008 represents the final integration phase of the ClearLoan system. The application now operates as a fully functional fintech prototype with a mobile frontend, cloud-hosted backend, structured database storage, realistic financial workflows, and improved user interaction features.

Tasks Completed in Week 008

The following tasks defined in the technical specification for this week were successfully implemented:

• The loan aggregation system was improved with a rule-based recommendation mechanism that ranks loan offers according to user financial parameters.

• Islamic loan aggregation was expanded to support multiple Islamic-compliant financial products rather than only one bank.

• Detailed bank information was added including headquarters location, support contacts, institutional descriptions, and lists of available loan products.

• A bank rating system was implemented allowing users to evaluate banks from one to five stars.

• A notifications module was developed to allow the backend to generate informational messages for users.

• A financial literacy section was introduced in the application to provide educational materials about loans and financial responsibility.

• The bank comparison interface was redesigned to present loan interest rates and repayment conditions more clearly.

• Biometric authentication (fingerprint login) was added to simulate modern mobile banking security mechanisms.

• The application backend was successfully deployed to the Koyeb cloud platform using Docker.

• A PostgreSQL database hosted on Supabase was integrated for persistent data storage.

• API communication between the Flutter frontend and Django backend was fully configured using HTTP/JSON requests.

• A complete system architecture flowchart was created illustrating the interaction between the Flutter client, Django REST backend, Supabase database, and Koyeb deployment infrastructure.
