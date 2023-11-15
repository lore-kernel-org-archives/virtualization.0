Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F913EA6E
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="SintiX85"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0DA660FFD
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 14:55:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0DA660FFD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=SintiX85
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f_xycHWkLPdp
	for <virtualization@lists.linux-foundation.org>;
	Wed, 15 Nov 2023 14:55:36 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F929614C4
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 14:55:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F929614C4
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-45d90e1333fso2794184137.3
        for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1700060135; x=1700664935; darn=lists.linux-foundation.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aqzoeAECt6Lxv5nWTCs7rezuVRbCcvk0sZFFSeF1AO0=;
        b=SintiX85g5ve0W2OfgfWDnGXHj6QX+BALcRUE0fHbfiJG0vAk7WNetkazB3j+mVoSH
         5mG4IeYuIEXBhLh5OqXPnLKS5DB+zrHW8nLsWE5g/mNuqRZ0WCMleStMHUT/3IMxDa2X
         iMDtC8/er2dgpMtHl2fxezNxFjDyaIaksdntWkBbAkv7RhKcuP0+nrrA/jUXMuVTViaI
         XxiUxq3esK0J0+px4SgFG32ZaaknEdS+ORaBY6bbypNf7fAdKo0snCJMulozlmvKr0Va
         wOHcjm53eWPvo4MpgwXrn3cP/UAjjD5y775a4FT4BSCHooQQrjsgf8/ylpfWPIndSOvY
         GypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060135; x=1700664935;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqzoeAECt6Lxv5nWTCs7rezuVRbCcvk0sZFFSeF1AO0=;
        b=BDmpYPwY3rSqm1ARrVVOB0xpZWQI/kNRK/ZKOw4Big+92fmH5cSfSZPvbFFNY2FLpd
         /1kZ/FOaxWP5QOjp1JCE+geD54wT4+jRCQpajcyW4WlJnpjHI2ddFFom5zbDpOY+3xnF
         bD6KgRsQxRa5JwFbJG+t9b6ubP7sHUUm5IB776A6bOf1mJY9pmN8LdaC2XGdnennn1MB
         kly6oN0UDYRH6/uf8xdTnlzZBo9jhyplyDKihZLtACoBZPI3buMx3VAedPADKLa1YDX5
         8Kb3YLUSnIJUEnJjPy/V/e7tLQLq3mgCQUJuDov0BWDD5Pa6AcWZX7eC0fv4izO0kcdx
         dJFw==
X-Gm-Message-State: AOJu0Yyr+0gd1qr1pzhng5tsphC/8hmhB9pADyDdwnt95eDqkHPtfKFm
	WrUtKMOkrR5pMW6JR8xxGHmlXMtxfMFgKIQiJ5JWOg==
X-Google-Smtp-Source: AGHT+IHaEF1RFbxmNDjKrj+Lm6kiKXSvCrIL/SgKViKI+T5CRRwav9o4c/wg9BsawIDq4redEnSVrpBZ2ZdIy5XAWu0=
X-Received: by 2002:a05:6102:f06:b0:45f:5d1:9c62 with SMTP id
 v6-20020a0561020f0600b0045f05d19c62mr15575004vss.19.1700060134157; Wed, 15
 Nov 2023 06:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Wed, 15 Nov 2023 08:54:58 -0600
Message-ID: <CA+Vr5csxY-atTYM8u=EbaQBE4Q1-fXkCA0NdRDOMkKXmdCUVVQ@mail.gmail.com>
Subject: HPDC 2024: Call for Papers (Main Track)
To: tci-announce@computer.org, tcde-announce@computer.org, 
	tcpp-announce@computer.org, tcbis-announce@computer.org, 
	"HPC-MEMBERS@listserv.acm.org" <HPC-MEMBERS@listserv.acm.org>, 
	sc-workshop-attendee-cfp@group.supercomputing.org, 
	hpc-india@mailman.serc.iisc.in, hipeac.publicity@lists.ugent.be, 
	sigops-announce@listserv.acm.org, publicity@hipeac.net, 
	htcondor-users@cs.wisc.edu, dbworld@cs.wisc.edu, 
	virtualization@lists.linux-foundation.org, users@planet-lab.org, 
	infodir_sigcomm@acm.org, sigplan-l@acm.uiuc.edu
Content-Type: text/plain; charset="UTF-8"

**********************************************
HPDC 2024: Call for Papers (Main Track)
Date: 3-7 June 2024
Location: Pisa, Italy
Web Site: https://www.hpdc.org/2024/
**********************************************

The ACM International Symposium on High-Performance Parallel and
Distributed Computing (HPDC) is the premier annual conference for
presenting the latest research on the design, implementation,
evaluation, and use of parallel and distributed systems for high-end
computing. The 33rd HPDC will take place in Pisa, Italy, June 3-7,
2024.

* Deadlines

Abstracts due: January 18th 11:59pm Anywhere on Earth (AoE), 2024
Papers due: January 25th 11:59pm Anywhere on Earth (AoE), 2024
Author notifications: March 25th, 2024
Camera-ready version: April 18th, 2024
Conference dates: June 3-7, 2024

* Scope and Topics

Submissions are welcomed on high-performance parallel and distributed
computing (HPDC) topics including but not limited to: clouds,
clusters, grids, big data, massively multicore, and extreme-scale
computing systems. Experience reports of operational deployments that
provide significantly novel insights for future research on HPDC
applications and systems are also welcome.

In the context of high-performance parallel and distributed computing,
the topics of interest include, but are not limited to:
-Datacenter, HPC, cloud, serverless, and edge/IoT computing platforms
-Heterogeneous computing accelerators and non-volatile memory systems
-File and storage systems, I/O, and data management
-Operating systems and networks
-System software and middleware for parallel and distributed systems
-Programming languages and runtime systems
-Big data stacks and big data ecosystems
-Scientific applications, algorithms, and workflows
-Resource management and scheduling
-Performance modeling, benchmarking, and engineering
-Fault tolerance, reliability, and availability
-Operational guarantees, risk assessment, and management
-Novel post-Moore computing technologies including neuromorphic,
brain-inspired computing, and quantum computing.

* Paper Submission Categories

Submissions to HPDC can be made in one of the following two
categories: (1) regular papers, or (2) open-source tools and data
papers. The primary focus of regular papers should be to describe new
research ideas supported by experimental implementation and evaluation
of the proposed research ideas. The primary focus of open-source tools
and data should be to describe the design, development, and evaluation
of new open-source tools or novel data sources. Submissions in the
regular papers category are also strongly encouraged to open-source
their software or hardware artifacts.

The authors are required to indicate the category of the paper as a
part of the submitted manuscript's title. The last line of the title
should indicate the paper type by using one of the two phrases (1)
Paper Type: Regular, or (2) Paper Type: Open-source tools and data
paper.

Submissions in both categories will be evaluated to the same standards
in terms of novelty, scientific value, demonstrated usefulness, and
potential impact on the field.  The chosen category at the time of the
submission can not be changed after the submission deadline.

* Submission Guidelines

Authors are invited to submit technical papers of at most 11 pages in
PDF format, excluding references. Accepted papers will have the
flexibility to use an additional page in the camera-ready to
incorporate feedback from the reviewers. Papers should be formatted in
the ACM Proceedings Style and submitted via the conference submission
website. Submitted papers must be original work that has not appeared
in and is not under consideration for another conference or a journal.

* Anonymizing Submissions

HPDC uses double-blind reviewing. Avoid identifying yourself or your
institution explicitly or by implication (e.g., through the references
or acknowledgments). The first page should use the paper ID assigned
during registration in place of the author names.

Use care in referring to your own related work. Do not omit references
to your prior work, as this would make it difficult for reviewers to
place your submission in its proper context. Instead, reference your
past work in the third person, just as you would any other piece of
related work. In some cases, it is not credible to refer to your
related work in the third person. For example, your submission may
extend a previous workshop paper, or it may relate to a submission
currently under review at HPDC or another venue. In these cases, you
must still explain the differences between your HPDC submission and
the other work, but you should cite the other work anonymously and
e-mail the deanonymized work to the PC chairs.

If your submission reports on experiences with a system at your
institution, you should refer to the system anonymously but describe
the properties of the system that are needed to evaluate the work
(e.g., size of the user base, volume of requests, etc.). We recognize
that, in some cases, these properties may allow a reviewer to identify
your institution.  Tool/data papers should also adhere to the
double-blind submission policy. If the described tool/dataset
framework is already widely used by the research community, consider
describing the framework using a different name and not sharing the
open-source code repository in the paper.

* Confidential Information

Papers containing information that is subject to a non-disclosure
agreement (NDA) will not be considered for review.

* arXiv Submission Policy

Please note that having an arXiv paper does not prohibit authors from
submitting a paper to HPDC 2024. arXiv papers are not peer-reviewed
and not considered as formal publications and hence do not count as
prior work. Authors are not expected to compare against arXiv papers
that have not formally appeared in previous conference or journal
proceedings. If a submitted paper is already on arXiv, please continue
to follow the double-blind submission guidelines. Authors are
encouraged to use preventive measures to reduce the chances of
accidental breach of anonymity (e.g., use a different title in the
submission and do not upload/revise the arXiv version during the
review period after the submission deadline).

* Author List After Acceptance

Please note that the author list cannot be changed after acceptance.

* Conflict of Interest Declaration

At the time of submission, all authors must indicate their conflict of
interest with the PC members. A conflict of interest may be
institutional, collaborative, or personal. Please see detailed
guidelines about how to accurately declare a conflict of interest on
the submission website.

* ACM Policy on Authorship

Please refer to the ACM Policy on Authorship for all other guidelines.
The frequently asked questions page
(https://www.acm.org/publications/policies/frequently-asked-questions)
provides policies on the use of generative AI tools in preparing
manuscripts.

By submitting your article to an ACM Publication, you are hereby
acknowledging that you and your co-authors are subject to all ACM
Publications Policies, including ACM's new Publications Policy on
Research Involving Human Participants and Subjects. Alleged violations
of this policy or any ACM Publications Policy will be investigated by
ACM and may result in a full retraction of your paper, in addition to
other potential penalties, as per ACM Publications Policy.

Please ensure that you and your co-authors obtain an ORCID ID, so you
can complete the publishing process for your accepted paper.  ACM has
been involved in ORCID from the start and we have recently made a
commitment to collect ORCID IDs from all of our published authors.
The collection process has started and will roll out as a requirement
throughout 2022.  We are committed to improve author discoverability,
ensure proper attribution and contribute to ongoing community efforts
around name normalization; your ORCID ID will help in these efforts.

* Contact PC Chairs

David Lowenthal (dkl@cs.arizona.edu)
Rosa M Badia (rosa.m.badia@bsc.es)

* Submissions

Submissions are now open at https://hpdc24.hotcrp.com/.

* Suggestions for Document Preparation for Authors

-Formatting the Introduction Section

HPDC authors are encouraged to structure their introduction section of
the paper in the following format (as subsections or headings).

I. Motivation. Clearly state the objective of the paper and provide
(quantitative) support to motivate the specific problem your
submission is solving.

II. Limitation of state-of-art approaches. Briefly review the most
relevant and most recent prior works. Clearly articulate the
limitations of prior works and how your approach breaks away from
those limitations. A more detailed discussion should be reserved for
the related work section. But, this section should be sufficient to
help readers recognize the novelty of your approach.

III. Key insights and contributions. Briefly articulate the major
insights that enable your approach or make it effective. Clearly
specify the novelty of these insights and how they advance
state-of-the-art. Describe the key ideas of your approach and design.
List the key contributions including flagship empirical results and
improvement over the prior art as applicable.

IV. Experimental methodology and artifact availability. Clearly
specify the key experimental / simulation infrastructure and
methodological details. Support the experimental methodology choices
(e.g., cite that most relevant and most recent prior works have
evaluated their ideas using similar methodology). Include a line to
indicate whether the software/hardware artifact will be available upon
acceptance.

V. Limitations of the proposed approach. Almost all scientific
contributions have limitations and scope for improvement. Clearly
articulate all the major limitations of the proposed approach and
identify conclusions that are sensitive to specific assumptions made
in the paper.

Please note this suggested format is not a requirement for submission,
and authors will not be penalized for using a different format.

-Ethical Considerations

If your research describes a new security-related attack, please
consider adding information about the responsible disclosure to the
relevant entity. Overall, as appropriate and relevant, the paper
should follow the ethical principles and not alter the
security/privacy/equality expectations of the associated human users.

-Inclusive Description of Research Contributions

Please consider making your research contribution description
inclusive in nature. For example, consider using gender-neutral
pronouns, consider using examples that are ethnicity/culture-rich,
consider engaging users from diverse backgrounds if your research
involves a survey, etc. Best efforts should be made to make the paper
accessible to visually impaired or color-blind readers.

-- 
Ali Anwar,
Assistant Professor, UMN
Department of Computer Science and Engineering
200 Union St SE, Minneapolis, MN 55455
aanwar@umn.edu | https://chalianwar.github.io/
