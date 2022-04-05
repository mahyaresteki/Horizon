<img src="https://raw.githubusercontent.com/mahyaresteki/Horizon/master/logo.png" width="100" height="100">

# Horizon Research Project (HRP)
Horizon Research Project (HRP) is a R&D project to create a free and open source payment switch based on "[Distributed Open Banking Theory](https://github.com/mahyaresteki/Horizon/raw/master/Documentation/Distributed_Open_Banking_Theory.pdf)". Horizon is a payment approach based on ISO 8583 standard which is following the distributed data management architecture. It will be a script based payment switch to implement changes with minimum cost. Horizon will be connected to any gateway and terminal by REST services. It will try to achieve an appropriate transaction per second (TPS) rate.

## Project Status
The project status is **"underdevelopment"**.

## Research Type
Based on defenitions of [Lawrence Berkeley	National	Laboratory](https://www.sjsu.edu/people/fred.prochaska/courses/ScWk170/s0/Basic-vs.-Applied-Research.pdf), this project is an **"applied research"**.

## Objectives
Horizon Research Project (HRP) is a free and open source software project that focuses on some research objectives regarding the optimization of bank payment switches. However, the project has aspects of research in the field of “management” and “technology”.

### Technical Objectives
1. Is it possible to develop a RESTful payment switch based on ISO 8583 which can convert ISO message to REST format and vice versa with minimum process?  2. Is it possible to create a payment switch based on ISO 8583 standard which clients can inquery format of specific message (ex: input and output for 0200 request message type) for the switch?
3. Is it possible to create a flexible RESTful payment switch which aministrators can map ISO fields to JSON parameters without restarting or switching off payment gateway or switch?
4. Is it posible to develop a payment switch which uses RESTful (HTTP) and socket programming (TCP) connection methods at a same time to provide payment services for deferent types of clients (ex: ATM and mobile app server)?

### Management Objectives
1. Is it possible to use a methodology in the software development process that in addition to improving the development process and product implementation, the interests of all project stakeholders are fairly provided and social principles are observed throughout the project?
2. Is it possible to ensure the human rights of the employees during the project without interfering with the project obligations?
3. Can this model become a permanent culture in the organization?

## Development Team
Horizon will be developed by MAHEST development team which is managed by [Mahyar Esteki](https://www.linkedin.com/in/mahyaresteki/).

## Case Study
Public data of I.R. Iran Central Bank used as sample data for this project (such as settings and basic data). Therefore, Iranian fintech and banking system is case study of this project. 

## Security Concerns
The following security concerns are considered in this project to prevent any critical issues for any live banking system all around the world.

1 - There is not any integration code between this payment switch and Iranian national banking card networks (SHETAB or SHAPARAK).

2 - There is not any integration code between this payment switch and international card payment system such as Master Card, Visa Card and PayPal.

If any bank or financial institiute wants to use this payment switch, they have to customise integration layer based on proposed card payment network. 

## Quality Management Philosophy
Quality management philosophy of Horizon project is based on [Kaizen](https://en.wikipedia.org/wiki/Kaizen). Therefore, we will accept any logical and scientific critique or suggestion which helps to improve the project.
