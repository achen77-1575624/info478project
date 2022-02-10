# Names: Niya Park, Matt Condrin, Andrew Chen
# Group 3
# Project Proposal

# Project Description

## What is the purpose of your research project?
The purpose of this research project is to determine if telehealth has increased therapy/counseling accessibility and if it had any effect on suicidality throughout the COVID-19 pandemic.


## What other research has been done in this area? Make sure to include 3+ links to related works, as well as a summary of what that work has discovered.
1. https://www.apa.org/monitor/2020/07/cover-telepsychology  
Due to the COVID-19 pandemic, individuals are under the stay-at-home order and may struggle with barriers in attaining mental health assistance, such as finances or transportation. Studies have shown that telehealth (or telepsychology) can be as effective as in person delivery of mental health services, and increases access to care. There are some challenges in telehealth, including not being able to completely read social cues from the patient during a phone or video call. Thus, further research is needed to determine the efficacy of telehealth in mental health services. 
2. https://welkinhealth.com/telehealth-benefits-and-challenges/
As most things have become virtual such as school classes, conference meetings, and overall communication with peers, visits to the doctor's office have also become more increasingly virtual in the form of telehealth. This new phenomenon has the potential and reasoning to be very successful and very helpful to our society, though there are challenges that come with it. Obviously this creates a much more immediate accessibility for patients, as well as eliminates a long trip for those who may not live close to the doctor's office. It offers an overall convenience factor similar to if the doctor was to examine you at home. This also poses a challenge. being that the doctor isn't actually there with you, so they aren't able to examine your health to the fullest extent. People in society also may not have access to the technology in which telehealth requires, which would making this much less accessible for lower income households. There are definitely many benefits to telehealth, with some challenges that will need to be addressed with further research on the matter.

3. https://www.sciencedirect.com/science/article/pii/S016517812100295X?via%3Dihub
With the COVID-19 pandemic came strict stay-at-home orders for many countries. In the U.S., states gradually implemented these mandates along with work/school-from-home orders. Social isolation became the norm as people weren't able to physically be with friends, coworkers, and even family. Employment also became an issue, as restaurants, movie theaters, and stores closed down, leaving many without work. What followed was a surge in a decline in mental health, including heightened rates of depression, anxiety, and substance abuse. A meta-analysis by ______ aggregated the results from 54 studies across 308,596 participants, suicide ideation increased by 10.81%, suicide attempts by 4.68%, and self-harm by 9.63%. These effects are further increased by being a younger age, a woman, and from a democratic country.


## What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be. You must find at least two data sources at this stage.
https://data.cdc.gov/NCHS/Mental-Health-Care-in-the-Last-4-Weeks/yni7-er2q
https://www.cdc.gov/nchs/covid19/rands/telemedicine.htm

### compare 2014-2019 data with 2020-2022 data to see difference in rates of self-harm deaths.
https://data.cdc.gov/NCHS/Monthly-Counts-of-Deaths-by-Select-Causes-2014-201/bxq8-mugm
https://data.cdc.gov/NCHS/Monthly-Provisional-Counts-of-Deaths-by-Select-Cau/9dzk-mvmi

All of our data so far is coming from the CDC. These datasets include a timeline of healthcare and telemedicine being used throughout the pandemic since June 2020. In addition, we found suicide rate datasets from before and during COVID, which we'll compare together on a time series graph to determine if suicide rates increased in the pandemic.


## Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset. You should hone in on one of these audiences.
Our target audience will mainly be therapists and/or teletherapy providers, other primary healthcare providers, and adults suffering from mental illness.

## What should your audience learn from your resource? Please consider specific questions that your project can answer using the data you have identified (that are related to the overarching purpose)
They can learn if telehealth has caused a reduction on suicide rates due to increased accessibility to mental healthcare providers, even with the COVID-19 pandemic.


# Technical Description

## What will be the format of your final product (Shiny app, HTML page, compiled .Rmd file, etc)?
The final product will be a Shiny app website.


## Do you anticipate any specific data collection / data management challenges?
We anticipate some challenges with finding relevant datasets that have columns we can join. If we code something wrong as well, it could potentially cause a ladder-effect where other part of the data will also be wrong.


## What new technical skills will need to learn in order to complete your project?
We will need to employ dplyr techniques to join and filter datasets. Additionally, we will need to use ggplot to create diagrams to map out our potential correlations.


## What major challenges do you anticipate? 
We'll need to brush up on some R techniques, including packages like dplyr.