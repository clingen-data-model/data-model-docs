---
title: ClinGen Data Exchange
layout: home

---
<div style="text-align:right"><em><small>(last updated Jun.26.2018)</small></em></div>

<div style="border:solid;padding:5px">
<em>Pardon Our Appearence While We Reoganize!</em><br/>
We are in the process of overhauling our site to make it easier to access all the infromation about the Data Exchange. <br/>
However, the sections below should provide an overview of the activities and resources available now.
</div>
<br/>
This site is dedicated to providing updates on developments and documentation on the Data Exchange platform, data models and tools produced by the ClinGen Data Exchange Working Group. 

The ClinGen Data Exchange is a comprised of the platform, data models and tools that enable an environment of standardized exchange of genomic knowledge. The Data Exchange is designed to enable a consistent approach to produce and consume the full suite of genomic knowledge curated in ClinGen. Access to the Data Exchange is currently accessible to all systems within ClinGen and may potentially be made available to external systems in the future. 


###Collaborations, Interactions & Integrations
* **[Allele Registry](http://reg.clinicalgenome.org)** - The ClinGen Allele Registry has adopted the Allele Model.
* **VCI's ClinVar Submission Process** - [Tools](http://dataexchange.clinicalgenome.org/interpretation/tools.html) have been developed to transform and generate the internal VCI representation of variant interpretations into valid clinvar submission records. Currently manual, soon to be integrated with the VCI's User Interface.
* **[SEPIO](https://github.com/monarch-initiative/SEPIO-ontology/wiki)** - The Monarch Intiative's Scientific Evidence Provenance Information Ontology has become the basis for the Interpretation modeling approach. Plans are to continue developing all future knowledge models using the approach developed here.
* **[GA4GH](http://www.ga4gh.org)** - ClinGen is a driver project for the GA4GH and heavily involved in the Genomic Knowledge Standards (GSK) workstream to harmonize our models for both Variants (aka Alleles) and Variant Annotations (aka Interpretations). The ClinVar Submitter tools are planned to be a pilot project to illustrate the utility of the GA4GH GKS Variant model.
* **[HL7 Clinical Genomics(CG)](http://www.hl7.org/Special/committees/clingenomics/overview.cfm)** - ClinGen data exchange modeling members actively participate in HL7's CG WG to provide a communication channel for overlapping objectives.

###Data Models
* The [Allele Model](http://dataexchange.clinicalgenome.org/allele) was release in 2017 and is the basis for the JSON-LD representation of alleles in the [ClinGen Allele Registry](http://reg.clinicalgenome.org).
* The [Interpretation Model](http://dataexchange.clinicalgenome.org/interpretation) was released in June 2018. This first interpertation model was scoped to provide support for Variant Pathogenicity Interpretations as specified by the 2015 ACMG ISV guidelines.

<br/>
<b>Current Plans</b>
There will be several more Interpretation models developed and implemented to support the sharing of the other types of curated genomic knowledge within ClinGen in the upcoming months.  These models will be documented on this site once released. 

###Platform
The figure below illustrates the current platform also referred to as the ClinGen Data Exchange. Currently, the primary consumer of the platform data is the ClinGen website. And, several of the ClinGen curation systems are actively producing and sharing their data with the platform to be accessible on the website. 

In the upcoming phase of platform development all curated genomic knowledge types will be modified to standardized models by the data exchange working group. And further integration opportunities outside the website will be explored.

![Infrastructure Diagram](../images/dataexchange-overview.jpg "The DataExchange Infrastructure")

###Tools
Information on the tools available for working with our models is currently located on the [Tools page](http://dataexchange.clinicalgenome.org/interpretation/tools.html) in the Interpretaion Model. This may be re-organized and moved in the future. This section will provide updates on how to access the information.

