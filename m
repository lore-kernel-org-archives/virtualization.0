Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21C45BE9
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="P4WHliBV"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05026403BE
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 19:36:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05026403BE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=P4WHliBV
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id soI1B0_16xr7
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 19:36:54 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 71B5A403AF
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 19:36:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71B5A403AF
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-464892990beso116979137.2
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1702669013; x=1703273813; darn=lists.linux-foundation.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uLs8lcs2PrGlNBgpAtf2Ac6kwE8H9rluQ4YLUxZGpjE=;
        b=P4WHliBVabrCcpiXgF1QLfXvB81ibO7cqnV+hxHL7xmY5kWtzMelrsG2EoGfmB08Z4
         hCtPDdj9cNl3HwWK+zpSCVIGHCAB9y88QHjDt2vM03/CzDCQVoC45Ainbs+3ow5pHji5
         FR4T0RsG1TbPeFfFAkv8MgQa/U9foZ1ruKMUQkUiguSF+1Ng4QY3bTqMT4hyyHWXlo8U
         oewcwSrf8jfmir05tmBrHeFRHW601c0VhUVv+zgR5gYCResGogCAoGYqeb10zEnx79Zv
         sXfdQmObFNDsRgf3JswuV5a6qi7OSsJ8BabgmFkFr3wfnpVqb7MCtwmNM/4JfFmy0HRG
         eOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702669013; x=1703273813;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLs8lcs2PrGlNBgpAtf2Ac6kwE8H9rluQ4YLUxZGpjE=;
        b=N3AUFC5XcRbJg6sridF7MGJ97uNhGAeWLn94Kb3PEBb2omKvzzTutF9ezQQv6bTQiI
         LjvRak76+adlcEs1E2n+IF5s2qcHBj9gCkwmKI+YzoHq18RcWVFHPJb5AVwxxY1jwN+z
         MP4BzKvUKgzlu3N7ycZpIk93heNcujpxU4U0uTshRqTtHBk0KzXfrLtcl+EpsVHNauc6
         aL75SWmaprK5+X1V/l6F1G41mLV3NFq38x9oF4f3BvhhrbNPglTEen8lPz/9rC/91Yhw
         OpxhL7aldc4WvLxQ+Ba0UggCkX3mnS0pUt/oj8nr51L2A1h1u93nKoH2njrfFoyFqsck
         pRnA==
X-Gm-Message-State: AOJu0Yy1JqAkaviF4Sx0zGWKOQgw1dnCYqUnuPRP4FxbbB+th4GKBOHi
	f9VcoNJ9TDXjEoOAQezC1N/QuZ1xf4yL7GomEv4hRw==
X-Google-Smtp-Source: AGHT+IE1iTKt8ErgJQwdj7P6bvj8rEx1lZ0sqCDpSzk7vE/wfZWvbZixH7SORb4TtPq5oFneySZMWOZbRrg3j1kfqhQ=
X-Received: by 2002:ac5:ca8c:0:b0:4b2:8bdb:3449 with SMTP id
 u12-20020ac5ca8c000000b004b28bdb3449mr4986088vkk.13.1702669012895; Fri, 15
 Dec 2023 11:36:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Fri, 15 Dec 2023 13:36:16 -0600
Message-ID: <CA+Vr5csFemT86wVuBvD9deAf+CtL-fUanme_mNeP+dx=V2m9cg@mail.gmail.com>
Subject: Second Call for Papers HPDC 2024
To: tci-announce@computer.org, tcde-announce@computer.org, 
	tcpp-announce@computer.org, tcbis-announce@computer.org, 
	"HPC-MEMBERS@listserv.acm.org" <HPC-MEMBERS@listserv.acm.org>, 
	sc-workshop-attendee-cfp@group.supercomputing.org, 
	hipeac.publicity@lists.ugent.be, sigops-announce@listserv.acm.org, 
	publicity@hipeac.net, htcondor-users@cs.wisc.edu, dbworld@cs.wisc.edu, 
	virtualization@lists.linux-foundation.org, infodir_sigcomm@acm.org
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

Regards,
Ali Anwar,
Assistant Professor, UMN
Department of Computer Science and Engineering
200 Union St SE, Minneapolis, MN 55455
aanwar@umn.edu | https://chalianwar.github.io/
