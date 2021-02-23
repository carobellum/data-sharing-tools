# Data Sharing Toolbox
Author: [Caroline Nettekoven](http://caroline-nettekoven.com/), 2020
This toolbox includes tools created for sharing of MRI and behavioural data as part of my work with Professor Kate Watkins in the Speech &amp; Brain Lab at the University of Oxford.

It also includes a general outline of steps to go through when sharing your (neuroimaging) data.

# Steps for Data Sharing
1. Decide which data you want to share
   1. Which subjects do you want to share?
      - Exclude subjects that may be identifiable because of their scans (e.g. do not share subjects with incidental findings)
   2. What data and in which format do you want to share?
      - For example, DICOM or nifti? Keep in mind that currently, there is no way to deface DICOM files, other than converting them to niftis, deficing them, and converting them back to DICOMs.
      - Adopt a useful structure to organize your dataset. For example, you can make your dataset [BIDS-compatible](https://bids.neuroimaging.io).
   3. Do you also want to share stimuli, scanning protocols and analysis code?
   4. Find a suitable repository.
2. Check Compliance with Data Protection Guidelines
   - Also check whether sharing your data is complieant with regulation. [Resources](https://www.information-compliance.admin.cam.ac.uk/data-protection/guidance/data-sharing)
   - Important to check whether sharing data is possible with your study ethics.
   - Make sure the licensing for the data sharing repository is in compliance with your ethics, regulations of your institution and fits with your purposes.
3. Cleaning
   - Remove any unusuable data or aborted scans.
   - Check the dimensions of your scans and confirm they are accurately labelled.
   - Record any special information in README files, for example if a subject was taken out of the scanner and therefore has two field maps. Update README files as you go along.
4. De-identifying
   - Header scrubbing
   - Defacing
   - Binning potentially identifiable data 
   - Assign new subject code
4. QA
   - Run quality assessment and compile qa measures into a report. You can use automated tools like mriqc.
5. Reporting
   - Write a risk assessment for sharing the data.
     - Consider writing a [data sharing aggreement](https://ico.org.uk/for-organisations/data-sharing-a-code-of-practice/data-sharing-agreements/).
   - Consider writing a data paper summarising your dataset. It is helpful to include QA measures in that paper.
6. Last check
   - Run the [BIDS validator](https://github.com/bids-standard/bids-validator) to check if your data is BIDS-compatible
   - Check that your README files are clean and up-to-date
   - Check that your data directory is clean and all files that are not to be shared have been removed.
7. Uploading
   - Upload your data to the repository. Consider scripting this to make sure the uploaded data is complete.

# Tools
Tools are ordered according to their appearance in the data sharing pipeline. Within each section, tools are ordered alphabetically.

## Cleaning
```clean_jsons.py```
Clean json files of potentially identifiable info and add task name.

```clean_bold_jsons_jp.py```
Clean json files from BOLD study of potentially identifiable info, add task name and echo times.

```move_anat_originals.sh```
Move original anats (non-defaced) to seperate folder, to ensure they are not shared.

```move_anat_slicesdirs.sh```
Move anats defacing reports to seperate folder, to ensure they are not shared

```move_json_originals.sh```
Move original json files to seperate folder, to ensure they are not shared

## De-identification

### Header scrubbing
```dicom_deidentification_test.py```
Inspect dicom header and identify those fields that could contain potentially identifiable information.

```check_nifti_headers.sh```
Check nifti headers for potentially identifiable information. Script prints the value of the potentially identifiable field.

```inspect_dicom_hd.py```
Inspect dicom header and identify those fields that could contain potentially identifiable information. Lines that are commented
out show fields that do not exist in BOLD study dicom files.


```scrub_dicom_headers.sh```
Scrub dicom headers of all potentially identifiable fields. Requires [DICOM Anonymizer](http://mircwiki.rsna.org/index.php?title=The_DicomAnonymizerTool).

### Defacing

```deface_bulk.sh```
Deface several images in your dataset at once. Also generates an report with reconstructed facial features and snapshot of saggital, axial and coronal slice to enable quick inspection for:
   1. Checking that defacing removed all facial features
   2. Ensuring that defacing did not affect brain data.

```deface_check.sh```
Check defacing on example subject for all available modalities

```deface_test.sh```
Runs three different defacing algorithms on a set of images: pydeface, fsl_deface and mri_deface.

```deface_check_report.sh```
Created defacing report for example subject.


```find_3d_thresh```
Find the appropriate thresholding to reconstruct faces from different input modalities.s


```fsl_gen_3D_crn```
Modified fsl_gen_3D script. Changes made by Caroline Nettekoven, August 2020: 
    1. Line 154: The threshold of 55 is too high for my images (bias corrected T1w images). To be able to see the facial features instead of the brain, the value needs to be around 35 for my images.
    2. Lines 165 & 179: The prefix doesn’t seem to work for me - Fsleyes cannot be called that way for my mac. So I commented out the prefix lines and evaluated them by calling fsleyes render normally.

```fsl_gen_3D_crn_thr```
Modified fsl_gen_3D script. This script is equivalent to fsl_gen_3D, but takes a threshold as another argument to be able to reconstruct facial features for different modalities, not only T1w images.


```inspect_defacing_bold.sh```
Inspect defacing on example subject


```mri_deface```
Copy of mri_deface, defacing algorithm from Freesurfer.


```reconstruct_face.sh```
Reconstruct face on given subject

```slicesdir_crn```
Copy of slicesdir, part of the FSL toolbox.

### Binning potentially identifiable data
```check_demographics_deidentification.py```
Script double checks that de-identified demographics yield no unique combinations.

```create_data_dictionary_bold.py```
Get info for data dictionary from behavioural variables. Example script. Adapt to your specific demographic and behavioural variables.


```find_unique_subjects.py```
Find unique combinations of variables that could potentially identify subjects.


## BIDS Compatibilize
```bids_compatibilize_mpm_demo```
Demo version of script that makes mpm scans compatibile with BIDS specification. Does not yet apply the BIDS specification, but only shows the workings of the script. Check this before running the actual ```bids_compatibilize_mpm``` script.

```bids_compatibilize_mpm```
Script to make mpm scans compatibile with BIDS specification.

```file_scan_as_bids```
Sets up file structures BIDS style for images coming directly from the scanner.


```validate_bids_bold.sh```
Validate BIDS compatibility of folder to share (BOLD study).

## QA

```mriqc_bold.sh```
Test mriqc on example subjects
