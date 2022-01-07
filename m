Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B253C433EF
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 21:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7042424C0;
	Fri,  7 Jan 2022 21:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8qPyHRSqrbcM; Fri,  7 Jan 2022 21:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A66B40010;
	Fri,  7 Jan 2022 21:15:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E397C0030;
	Fri,  7 Jan 2022 21:15:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36FB7C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 21:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19CF782A4F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 21:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbE07ZqZ-7Bt
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 21:15:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40B0682A4E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 21:15:01 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id g11so20027358lfu.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Jan 2022 13:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20210112.gappssmtp.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=3+HTa1FLLLEErymEnmIqAl1o+sUHa5WiSXAG0bdxYIk=;
 b=zss1NLSZ/tsb0kjOT/vGaxMQd7vaPfg9sgtwmbnAJjwy7yakizWVUJzCO/iEFPZ0rf
 ruDj0W+dH9oaQklqaunqfJAfcjum1cX80PUosHXmBdgUcFcRwux2w4RQvo2fWY5n6QzE
 Q3vEmIb9DyjcjifxLcB4auj8DDwerMv1j0nX/cmZ3z+JKnuIjX3B2RJsMaUd1aTSvbd8
 Sei46F4glQSJEqD40nb6fBaxpcuj7fWt7pteXq52ZXwXBjCrGpGXKHlOQKoYQtZrum0w
 npEpvkzx60E3fp1GMuByZOaqYVUuuFnRdcALB5orYGuHhuDATu1mwYMcj3U7TFr92iLo
 m21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=3+HTa1FLLLEErymEnmIqAl1o+sUHa5WiSXAG0bdxYIk=;
 b=0zybZSapcR9jrmKkOQ9Y1zhH76pgS0KpZQuCcrFRB21dJfxD1/hgvxmqb9r8x9wVOm
 rJQw9mHPteej+fD0El44nZfv+jNwlGm8wNzWQzNICeqM1IFWX0RmAu3P22zTOsRBdgm+
 h0rhffmjcfGse2/KDwxrI/SldeEnhdBQaQGvt8a6bFZVTqBLrs9tvvVQMmmFSDtFeEJJ
 UQ0MEuzgnm8CS7ELehinihPR1g2qNuB73Dy+RuAa20tFs0lhLr7Zml9CKNRf/8OM3PNF
 +2XWCf8IWOnmZH/2Tv6LHwdiEndLaQ10tN0FaQ3MzTqWTDxqh0KaKdFTTm9ZP3drwM1e
 Yn2w==
X-Gm-Message-State: AOAM533eGC/m/fLZhWsVKKV1qdhNZuyo4kVO9CmnCLFimpiiWxuXkJfD
 DE46p+8qVDQ6V4vHGSgpYD8/0O9YFqNqhYWNJ5aY0g==
X-Google-Smtp-Source: ABdhPJzyOoXEmPyI7tWNJ6JAUPvyNZooGhAw/hxcs1GDpbblVM4ZdLtZPH2VIxQXwojip2sux9l+GgUwBqEMh1L1+iU=
X-Received: by 2002:a2e:b710:: with SMTP id j16mr51724643ljo.460.1641590099689; 
 Fri, 07 Jan 2022 13:14:59 -0800 (PST)
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Fri, 7 Jan 2022 16:14:48 -0500
Message-ID: <CA+Vr5ctstL=TwcKVMM-7c=hRP2JsgSTypuugjpS6pGq=02Jq1w@mail.gmail.com>
Subject: CFP: ACM HPDC 2022 (The 31th International Symposium on
 High-Performance Parallel and Distributed Computing)
To: tci-announce@computer.org, tcde-announce@computer.org, 
 tcpp-announce@computer.org, tcbis-announce@computer.org, 
 "HPC-MEMBERS@listserv.acm.org" <HPC-MEMBERS@listserv.acm.org>, 
 sc-workshop-attendee-cfp@group.supercomputing.org, 
 hpc-india@mailman.serc.iisc.in, hipeac.publicity@lists.ugent.be, 
 sigops-announce@listserv.acm.org, publicity@hipeac.net, 
 htcondor-users@cs.wisc.edu, dbworld@cs.wisc.edu, 
 virtualization@lists.linux-foundation.org, users@planet-lab.org, 
 infodir_sigcomm@acm.org, sigplan-l@acm.uiuc.edu
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6356703159971802791=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6356703159971802791==
Content-Type: multipart/alternative; boundary="000000000000c2598005d5047a0b"

--000000000000c2598005d5047a0b
Content-Type: text/plain; charset="UTF-8"

The ACM International Symposium on High-Performance Parallel and
Distributed Computing (HPDC) is the premier annual conference for
presenting the latest research on the design, implementation, evaluation,
and use of parallel and distributed systems for high-end computing. The
31st HPDC will take place in Minneapolis, Minnesota, June 27-July 1, 2022.

Submissions

Submissions are now open here (hpdc22.hotcrp.com).

Deadlines

Abstracts due: January 20th 11:59pm Anywhere on Earth (AoE), 2022

Papers due: January 27th 11:59pm Anywhere on Earth (AoE), 2022

Author notifications: March 31st, 2022

Camera-ready version: April 21, 2022

Conference dates: June 27 - July 1, 2022

Scope and Topics

Submissions are welcomed on high-performance parallel and distributed
computing (HPDC) topics including but not limited to: clouds, clusters,
grids, big data, massively multicore, and extreme-scale computing systems.
Experience reports of operational deployments that provide significantly
novel insights for future research on HPDC applications and systems are
also welcome.

In the context of high-performance parallel and distributed computing, the
topics of interest include, but are not limited to:

Datacenter, HPC, cloud, serverless, and edge/IoT computing platforms

Heterogeneous computing accelerators and non-volatile memory systems

File and storage systems, I/O, and data management

Operating systems and networks

System software and middleware for parallel and distributed systems

Programming languages and runtime systems

Big data stacks and big data ecosystems

Scientific applications, algorithms, and workflows

Resource management and scheduling

Performance modeling, benchmarking, and engineering

Fault tolerance, reliability, and availability

Operational guarantees, risk assessment, and management

Novel post-Moore computing technologies including neuromorphic,
brain-inspired computing, and quantum computing.

New at HPDC 2022

New paper submission categories:

This year, submissions to HPDC can be made in one of the following two
categories: (1) regular papers, or (2) open-source tools and data papers.
The primary focus of "regular papers" should be to describe new research
ideas supported by experimental implementation and evaluation of the
proposed research ideas. The primary focus of "open-source tools and data"
should be to describe the design, development, and evaluation of new
open-source tools or novel data sources. Submissions in the "regular
papers" category are also encouraged to open-source their software or
hardware artifacts.

The authors are required to indicate the category of the paper as a part of
the submitted manuscript's title. The last line of the title should
indicate the paper type by using one of the two phrases (1) Paper Type:
Regular, or (2) Paper Type: Open-source tools and data paper.

Papers in the open-source tools and data papers category with relatively
shorter length (e.g., 6 pages) are welcome, if the contributions can be
well articulated and substantiated in 6 pages. However, all submissions in
the tool and data category have the flexibility of using the maximum
allowed number of pages, similar to the regular category papers.

The submissions in both categories will be evaluated to the same standards
in terms of novelty, scientific value, demonstrated usefulness, and
potential impact on the field. The nature of the contribution differs
between the two categories (new research idea vs. new open-source
tool/data) and papers will be evaluated based on the intended nature of the
contribution, as declared by the chosen paper category at the time of the
submission. The chosen category at the time of the submission can not be
changed after the submission deadline.

Suggested formatting for Introduction section of the paper

This year, HPDC authors are encouraged to structure their introduction
section of the paper in the following format (as subsections or headings).
The suggested length is two pages at maximum for this format.

[A] Motivation: Clearly state the objective of the paper and provide
(quantitative) support to motivate the specific problem your submission is
solving.

[B] Limitation of state-of-art approaches: Briefly review the most relevant
and most recent prior works. Clearly articulate the limitations of prior
works and how your approach breaks away from those limitations. A more
detailed discussion should be reserved for the related work section. But,
this section should be sufficient to help readers recognize the novelty of
your approach.

[C] Key insights and contributions: Briefly articulate the major insights
that enable your approach or make it effective. Clearly specify the novelty
of these insights and how they advance state-of-the-art. Describe the key
ideas of your approach and design. List the key contributions including
flagship empirical results and improvement over the prior art as applicable.

[D] Experimental methodology and artifact availability: Clearly specify the
key experimental / simulation infrastructure and methodological details.
Support the experimental methodology choices (e.g., cite that most relevant
and most recent prior works have evaluated their ideas using similar
methodology). Include a line to indicate whether the software/hardware
artifact will be available upon acceptance.

[E] Limitations of the proposed approach: Almost all scientific
contributions have limitations and scope for improvement. Clearly
articulate all the major limitations of the proposed approach and identify
conclusions that are sensitive to specific assumptions made in the paper.

Please note this suggested format is not a requirement for submission and
authors have the flexibility to choose what they see fit to articulate
their contributions. We hope that this structured format achieves two
purposes: (1) helps authors state their contributions clearly and
concisely, and (2) allows reviewers to judge the contributions more
objectively. While this structure is encouraged, the authors will not be
penalized for not following this format.

Submission Guidelines

Authors are invited to submit technical papers of at most 11 pages in PDF
format, excluding references. Accepted papers will have the flexibility to
use an additional page in the camera-ready to incorporate feedback from the
reviewers. Papers should be formatted in the ACM Proceedings Style and
submitted via the conference submission website. Submitted papers must be
original work that has not appeared in and is not under consideration for
another conference or a journal.

Reviewing for HPDC 2022 will be double-blind.

Anonymizing Submissions

HPDC will use double-blind reviewing this year. Please make a good faith
attempt to anonymize your submission. Avoid identifying yourself or your
institution explicitly or by implication (e.g., through the references or
acknowledgments). The first page should use the paper ID assigned during
registration in place of the author names.

Use care in referring to your own related work. Do not omit references to
your prior work, as this would make it difficult for reviewers to place
your submission in its proper context. Instead, reference your past work in
the third person, just as you would any other piece of related work. In
some cases, it is not credible to refer to your related work in the third
person. For example, your submission may extend a previous workshop paper,
or it may relate to a submission currently under review at HPDC or another
venue. In these cases, you must still explain the differences between your
HPDC submission and the other work, but you should cite the other work
anonymously and e-mail the deanonymized work to the PC chairs.

If your submission reports on experiences with a system at your
institution, you should refer to the system anonymously but describe the
properties of the system that are needed to evaluate the work (e.g., size
of the user base, volume of requests, etc.). We recognize that, in some
cases, these properties may allow a reviewer to identify your institution.

All tool/data papers should also adhere to the double-blind submission
policy. If the described tool/dataset framework is already widely used by
the research community, consider describing the framework using a different
name and not sharing the open-source code repository in the paper.

Optional Supplemental Information about Revisions

Authors can upload a document listing the improvements made in response to
the reviews received from a previously submitted version. Authors have
three options: (1) not provide this information, (2) provide this
information but the visibility is set to the PC chairs only, and (3)
provide this information and the visibility is set to all the reviewers.
The intent is to improve the efficiency of the over-burdened review process
and benefit the authors who faithfully revise the paper to incorporate
feedback from previous reviewers. Additional implementation details related
to this policy are available on the submission website.

Confidential Information

Papers containing information that is subject to a non-disclosure agreement
(NDA) will not be considered for review.

arXiv Submission Policy

Please note that having an arXiv paper does not prohibit authors from
submitting a paper to HPDC 2022. arXiv papers are not peer-reviewed and not
considered as formal publications, hence do not count as prior work.
Authors are not expected to compare against arXiv papers that have not
formally appeared in previous conference or journal proceedings. If a
submitted paper is already on arXiv, please continue to follow the
double-blind submission guidelines. Authors are encouraged to use
preventive measures to reduce the chances of accidental breach of anonymity
(e.g., use a different title in the submission, not upload/revise the arXiv
version during the review period after the submission deadline).

Author list after acceptance

Please note that the author list cannot be changed after acceptance.

Conflict of Interest Declaration

At the time of submission, all authors must indicate their conflict of
interest with the PC members. A conflict of interest may be institutional,
collaborative, or personal. Please see detailed guidelines about how to
accurately declare a conflict of interest on the submission website.

Ethical Guidelines

If your research describes a new security-related attack, please consider
adding information about the responsible disclosure. Overall, as
appropriate and relevant, the paper should follow the ethical principles
and not alter the security/privacy/equality expectations of the associated
human users.

Inclusive Description of Research Contributions

Please consider making your research contribution description inclusive in
nature. For example, consider using gender-neutral pronouns, consider using
examples that are ethnicity/culture-rich, consider engaging users from
diverse backgrounds if your research

--000000000000c2598005d5047a0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&=
quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;whit=
e-space:pre-wrap">The ACM International Symposium on High-Performance Paral=
lel and Distributed Computing (HPDC) is the premier annual conference for p=
resenting the latest research on the design, implementation, evaluation, an=
d use of parallel and distributed systems for high-end computing. The 31st =
HPDC will take place in Minneapolis, Minnesota, June 27-July 1, 2022.</span=
></p><div><br></div><div><p dir=3D"ltr" style=3D"line-height:1.38;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Op=
en Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font=
-weight:700;font-variant-numeric:normal;font-variant-east-asian:normal;vert=
ical-align:baseline;white-space:pre-wrap">Submissions</span></p><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">Submission=
s are now open here (<a href=3D"http://hpdc22.hotcrp.com/" target=3D"_blank=
">hpdc22.hotcrp.com</a>).</span></p><br><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-=
family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:t=
ransparent;font-weight:700;font-variant-numeric:normal;font-variant-east-as=
ian:normal;vertical-align:baseline;white-space:pre-wrap">Deadlines</span></=
p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt=
"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-seri=
f;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal=
;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wra=
p">Abstracts due: January 20th 11:59pm Anywhere on Earth (AoE), 2022</span>=
</p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0=
pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-se=
rif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norm=
al;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-w=
rap">Papers due: January 27th 11:59pm Anywhere on Earth (AoE), 2022</span><=
/p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0p=
t"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-ser=
if;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norma=
l;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wr=
ap">Author notifications: March 31st, 2022</span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);bac=
kground-color:transparent;font-variant-numeric:normal;font-variant-east-asi=
an:normal;vertical-align:baseline;white-space:pre-wrap">Camera-ready versio=
n: </span><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,s=
ans-serif;color:rgb(0,0,0);font-variant-numeric:normal;font-variant-east-as=
ian:normal;vertical-align:baseline;white-space:pre-wrap">April 21, 2022</sp=
an></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-botto=
m:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans=
-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:n=
ormal;font-variant-east-asian:normal;vertical-align:baseline;white-space:pr=
e-wrap">Conference dates: </span><span style=3D"font-size:11pt;font-family:=
&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);font-variant-numeric:norm=
al;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-w=
rap">June 27 - July 1, 2022</span></p></div><br><p dir=3D"ltr" style=3D"lin=
e-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11=
pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background=
-color:transparent;font-weight:700;font-variant-numeric:normal;font-variant=
-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">Scope and =
Topics</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&=
quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;whit=
e-space:pre-wrap">Submissions are welcomed on high-performance parallel and=
 distributed computing (HPDC) topics including but not limited to: clouds, =
clusters, grids, big data, massively multicore, and extreme-scale computing=
 systems. Experience reports of operational deployments that provide signif=
icantly novel insights for future research on HPDC applications and systems=
 are also welcome.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-ali=
gn:baseline;white-space:pre-wrap">In the context of high-performance parall=
el and distributed computing, the topics of interest include, but are not l=
imited to:</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Op=
en Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font=
-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:basel=
ine;white-space:pre-wrap">Datacenter, HPC, cloud, serverless, and edge/IoT =
computing platforms</span></p><p dir=3D"ltr" style=3D"line-height:1.38;marg=
in-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&qu=
ot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:=
baseline;white-space:pre-wrap">Heterogeneous computing accelerators and non=
-volatile memory systems</span></p><p dir=3D"ltr" style=3D"line-height:1.38=
;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-famil=
y:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transp=
arent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-a=
lign:baseline;white-space:pre-wrap">File and storage systems, I/O, and data=
 management</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0=
pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open =
Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-va=
riant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline=
;white-space:pre-wrap">Operating systems and networks=C2=A0</span></p><p di=
r=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span=
 style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color=
:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-v=
ariant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">Syst=
em software and middleware for parallel and distributed systems</span></p><=
p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><=
span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;c=
olor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">=
Programming languages and runtime systems</span></p><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-siz=
e:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);backgr=
ound-color:transparent;font-variant-numeric:normal;font-variant-east-asian:=
normal;vertical-align:baseline;white-space:pre-wrap">Big data stacks and bi=
g data ecosystems</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot=
;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;f=
ont-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:ba=
seline;white-space:pre-wrap">Scientific applications, algorithms, and workf=
lows</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&qu=
ot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-n=
umeric:normal;font-variant-east-asian:normal;vertical-align:baseline;white-=
space:pre-wrap">Resource management and scheduling</span></p><p dir=3D"ltr"=
 style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D=
"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,=
0);background-color:transparent;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;vertical-align:baseline;white-space:pre-wrap">Performance m=
odeling, benchmarking, and engineering</span></p><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);backgroun=
d-color:transparent;font-variant-numeric:normal;font-variant-east-asian:nor=
mal;vertical-align:baseline;white-space:pre-wrap">Fault tolerance, reliabil=
ity, and availability</span></p><p dir=3D"ltr" style=3D"line-height:1.38;ma=
rgin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&=
quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transpare=
nt;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-alig=
n:baseline;white-space:pre-wrap">Operational guarantees, risk assessment, a=
nd management</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top=
:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Ope=
n Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-=
variant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseli=
ne;white-space:pre-wrap">Novel post-Moore computing technologies including =
neuromorphic, brain-inspired computing, and quantum computing.=C2=A0</span>=
</p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bott=
om:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,san=
s-serif;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-=
variant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseli=
ne;white-space:pre-wrap">New at HPDC 2022
</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-b=
ottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,=
sans-serif;color:rgb(0,0,0);background-color:transparent;font-weight:700;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;text-decoration-li=
ne:underline;vertical-align:baseline;white-space:pre-wrap">New paper submis=
sion categories:=C2=A0</span></p><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-ali=
gn:baseline;white-space:pre-wrap">This year, submissions to HPDC can be mad=
e in one of the following two categories: (1) regular papers, or (2) open-s=
ource tools and data papers. The primary focus of &quot;regular papers&quot=
; should be to describe new research ideas supported by experimental implem=
entation and evaluation of the proposed research ideas. The primary focus o=
f &quot;open-source tools and data&quot; should be to describe the design, =
development, and evaluation of new open-source tools or novel data sources.=
 Submissions in the &quot;regular papers&quot; category are also encouraged=
 to open-source their software or hardware artifacts.</span></p><br><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:=
rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-va=
riant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">The a=
uthors are required to indicate the category of the paper as a part of the =
submitted manuscript&#39;s title. The last line of the title should indicat=
e the paper type by using one of the two phrases (1) Paper Type: Regular, o=
r (2) Paper Type: Open-source tools and data paper.</span></p><br><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span sty=
le=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb=
(0,0,0);background-color:transparent;font-variant-numeric:normal;font-varia=
nt-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">Papers i=
n the open-source tools and data papers category with relatively shorter le=
ngth (e.g., 6 pages) are welcome, if the contributions can be well articula=
ted and substantiated in 6 pages. However, all submissions in the tool and =
data category have the flexibility of using the maximum allowed number of p=
ages, similar to the regular category papers.</span></p><br><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0=
);background-color:transparent;font-variant-numeric:normal;font-variant-eas=
t-asian:normal;vertical-align:baseline;white-space:pre-wrap">The submission=
s in both categories will be evaluated to the same standards in terms of no=
velty, scientific value, demonstrated usefulness, and potential impact on t=
he field. The nature of the contribution differs between the two categories=
 (new research idea vs. new open-source tool/data) and papers will be evalu=
ated based on the intended nature of the contribution, as declared by the c=
hosen paper category at the time of the submission. The chosen category at =
the time of the submission can not be changed after the submission deadline=
.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;mar=
gin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&q=
uot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-weight:7=
00;font-variant-numeric:normal;font-variant-east-asian:normal;text-decorati=
on-line:underline;vertical-align:baseline;white-space:pre-wrap">Suggested f=
ormatting for Introduction section of the paper</span></p><p dir=3D"ltr" st=
yle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fo=
nt-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);=
background-color:transparent;font-variant-numeric:normal;font-variant-east-=
asian:normal;vertical-align:baseline;white-space:pre-wrap">This year, HPDC =
authors are encouraged to structure their introduction section of the paper=
 in the following format (as subsections or headings). The suggested length=
 is two pages at maximum for this format.=C2=A0</span></p><br><p dir=3D"ltr=
" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-weight:700;font-variant-numeric:nor=
mal;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-=
wrap">[A] Motivation:</span><span style=3D"font-size:11pt;font-family:&quot=
;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;f=
ont-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:ba=
seline;white-space:pre-wrap"> Clearly state the objective of the paper and =
provide (quantitative) support to motivate the specific problem your submis=
sion is solving.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;mar=
gin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&q=
uot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparen=
t;font-weight:700;font-variant-numeric:normal;font-variant-east-asian:norma=
l;vertical-align:baseline;white-space:pre-wrap">[B] Limitation of state-of-=
art approaches: </span><span style=3D"font-size:11pt;font-family:&quot;Open=
 Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;vertical-align:baselin=
e;white-space:pre-wrap">Briefly review the most relevant and most recent pr=
ior works. Clearly articulate the limitations of prior works and how your a=
pproach breaks away from those limitations. A more detailed discussion shou=
ld be reserved for the related work section. But, this section should be su=
fficient to help readers recognize the novelty of your approach.</span></p>=
<br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0=
pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-se=
rif;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;w=
hite-space:pre-wrap">[C] Key insights and contributions:</span><span style=
=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;vertical-align:baseline;white-space:pre-wrap"> Briefly a=
rticulate the major insights that enable your approach or make it effective=
. Clearly specify the novelty of these insights and how they advance state-=
of-the-art. Describe the key ideas of your approach and design. List the ke=
y contributions including flagship empirical results and improvement over t=
he prior art as applicable.</span></p><br><p dir=3D"ltr" style=3D"line-heig=
ht:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;fon=
t-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color=
:transparent;font-weight:700;font-variant-numeric:normal;font-variant-east-=
asian:normal;vertical-align:baseline;white-space:pre-wrap">[D] Experimental=
 methodology and artifact availability:</span><span style=3D"font-size:11pt=
;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-c=
olor:transparent;font-variant-numeric:normal;font-variant-east-asian:normal=
;vertical-align:baseline;white-space:pre-wrap"> Clearly specify the key exp=
erimental / simulation infrastructure and methodological details. Support t=
he experimental methodology choices (e.g., cite that most relevant and most=
 recent prior works have evaluated their ideas using similar methodology). =
Include a line to indicate whether the software/hardware artifact will be a=
vailable upon acceptance.</span></p><br><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-=
family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:t=
ransparent;font-weight:700;font-variant-numeric:normal;font-variant-east-as=
ian:normal;vertical-align:baseline;white-space:pre-wrap">[E] Limitations of=
 the proposed approach:</span><span style=3D"font-size:11pt;font-family:&qu=
ot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:=
baseline;white-space:pre-wrap"> Almost all scientific contributions have li=
mitations and scope for improvement. Clearly articulate all the major limit=
ations of the proposed approach and identify conclusions that are sensitive=
 to specific assumptions made in the paper.=C2=A0</span></p><br><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">Please not=
e this suggested format is not a requirement for submission and authors hav=
e the flexibility to choose what they see fit to articulate their contribut=
ions. We hope that this structured format achieves two purposes: (1) helps =
authors state their contributions clearly and concisely, and (2) allows rev=
iewers to judge the contributions more objectively. While this structure is=
 encouraged, the authors will not be penalized for not following this forma=
t.=C2=A0</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:=
0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open=
 Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-w=
eight:700;font-variant-numeric:normal;font-variant-east-asian:normal;vertic=
al-align:baseline;white-space:pre-wrap">Submission Guidelines</span></p><p =
dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><sp=
an style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;col=
or:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font=
-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">Au=
thors are invited to submit technical papers of at most 11 pages in PDF for=
mat, excluding references. Accepted papers will have the flexibility to use=
 an additional page in the camera-ready to incorporate feedback from the re=
viewers. Papers should be formatted in the ACM Proceedings Style and submit=
ted via the conference submission website. Submitted papers must be origina=
l work that has not appeared in and is not under consideration for another =
conference or a journal.</span></p><br><p dir=3D"ltr" style=3D"line-height:=
1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-f=
amily:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:tr=
ansparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertic=
al-align:baseline;white-space:pre-wrap">Reviewing for HPDC 2022 will be dou=
ble-blind.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Op=
en Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font=
-weight:700;font-variant-numeric:normal;font-variant-east-asian:normal;vert=
ical-align:baseline;white-space:pre-wrap">Anonymizing Submissions</span></p=
><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap=
">HPDC will use double-blind reviewing this year. Please make a good faith =
attempt to anonymize your submission. Avoid identifying yourself or your in=
stitution explicitly or by implication (e.g., through the references or ack=
nowledgments). The first page should use the paper ID assigned during regis=
tration in place of the author names.</span></p><br><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-siz=
e:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);backgr=
ound-color:transparent;font-variant-numeric:normal;font-variant-east-asian:=
normal;vertical-align:baseline;white-space:pre-wrap">Use care in referring =
to your own related work. Do not omit references to your prior work, as thi=
s would make it difficult for reviewers to place your submission in its pro=
per context. Instead, reference your past work in the third person, just as=
 you would any other piece of related work. In some cases, it is not credib=
le to refer to your related work in the third person. For example, your sub=
mission may extend a previous workshop paper, or it may relate to a submiss=
ion currently under review at HPDC or another venue. In these cases, you mu=
st still explain the differences between your HPDC submission and the other=
 work, but you should cite the other work anonymously and e-mail the deanon=
ymized work to the PC chairs.</span></p><br><p dir=3D"ltr" style=3D"line-he=
ight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;f=
ont-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-col=
or:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;v=
ertical-align:baseline;white-space:pre-wrap">If your submission reports on =
experiences with a system at your institution, you should refer to the syst=
em anonymously but describe the properties of the system that are needed to=
 evaluate the work (e.g., size of the user base, volume of requests, etc.).=
 We recognize that, in some cases, these properties may allow a reviewer to=
 identify your institution.=C2=A0=C2=A0</span></p><br><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);bac=
kground-color:transparent;font-variant-numeric:normal;font-variant-east-asi=
an:normal;vertical-align:baseline;white-space:pre-wrap">All tool/data paper=
s should also adhere to the double-blind submission policy. If the describe=
d tool/dataset framework is already widely used by the research community, =
consider describing the framework using a different name and not sharing th=
e open-source code repository in the paper.</span></p><br><p dir=3D"ltr" st=
yle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fo=
nt-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);=
background-color:transparent;font-weight:700;font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">=
Optional Supplemental Information about Revisions</span></p><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0=
);background-color:transparent;font-variant-numeric:normal;font-variant-eas=
t-asian:normal;vertical-align:baseline;white-space:pre-wrap">Authors can up=
load a document listing the improvements made in response to the reviews re=
ceived from a previously submitted version. Authors have three options: (1)=
 not provide this information, (2) provide this information but the visibil=
ity is set to the PC chairs only, and (3) provide this information and the =
visibility is set to all the reviewers. The intent is to improve the effici=
ency of the over-burdened review process and benefit the authors who faithf=
ully revise the paper to incorporate feedback from previous reviewers. Addi=
tional implementation details related to this policy are available on the s=
ubmission website.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transpar=
ent;font-weight:700;font-variant-numeric:normal;font-variant-east-asian:nor=
mal;vertical-align:baseline;white-space:pre-wrap">Confidential Information<=
/span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bo=
ttom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,s=
ans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeri=
c:normal;font-variant-east-asian:normal;vertical-align:baseline;white-space=
:pre-wrap">Papers containing information that is subject to a non-disclosur=
e agreement (NDA) will not be considered for review.</span></p><br><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:=
rgb(0,0,0);background-color:transparent;font-weight:700;font-variant-numeri=
c:normal;font-variant-east-asian:normal;vertical-align:baseline;white-space=
:pre-wrap">arXiv Submission Policy=C2=A0</span></p><p dir=3D"ltr" style=3D"=
line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);backgro=
und-color:transparent;font-variant-numeric:normal;font-variant-east-asian:n=
ormal;vertical-align:baseline;white-space:pre-wrap">Please note that having=
 an arXiv paper does not prohibit authors from submitting a paper to HPDC 2=
022. arXiv papers are not peer-reviewed and not considered as formal public=
ations, hence do not count as prior work. Authors are not expected to compa=
re against arXiv papers that have not formally appeared in previous confere=
nce or journal proceedings. If a submitted paper is already on arXiv, pleas=
e continue to follow the double-blind submission guidelines. Authors are en=
couraged to use preventive measures to reduce the chances of accidental bre=
ach of anonymity (e.g., use a different title in the submission, not upload=
/revise the arXiv version during the review period after the submission dea=
dline).</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0=
pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open =
Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-we=
ight:700;font-variant-numeric:normal;font-variant-east-asian:normal;vertica=
l-align:baseline;white-space:pre-wrap">Author list after acceptance=C2=A0</=
span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bot=
tom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sa=
ns-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric=
:normal;font-variant-east-asian:normal;vertical-align:baseline;white-space:=
pre-wrap">Please note that the author list cannot be changed after acceptan=
ce.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;m=
argin-bottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans=
&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-weight=
:700;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-al=
ign:baseline;white-space:pre-wrap">Conflict of Interest Declaration=C2=A0</=
span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bot=
tom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sa=
ns-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric=
:normal;font-variant-east-asian:normal;vertical-align:baseline;white-space:=
pre-wrap">At the time of submission, all authors must indicate their confli=
ct of interest with the PC members. A conflict of interest may be instituti=
onal, collaborative, or personal. Please see detailed guidelines about how =
to accurately declare a conflict of interest on the submission website.</sp=
an></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-b=
ottom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,=
sans-serif;color:rgb(0,0,0);background-color:transparent;font-weight:700;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:bas=
eline;white-space:pre-wrap">Ethical Guidelines=C2=A0</span></p><p dir=3D"lt=
r" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">If your re=
search describes a new security-related attack, please consider adding info=
rmation about the responsible disclosure. Overall, as appropriate and relev=
ant, the paper should follow the ethical principles and not alter the secur=
ity/privacy/equality expectations of the associated human users.</span></p>=
<br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0=
pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-se=
rif;color:rgb(0,0,0);background-color:transparent;font-weight:700;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;w=
hite-space:pre-wrap">Inclusive Description of Research Contributions=C2=A0<=
/span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bo=
ttom:0pt"><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,s=
ans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeri=
c:normal;font-variant-east-asian:normal;vertical-align:baseline;white-space=
:pre-wrap">Please consider making your research contribution description in=
clusive in nature. For example, consider using gender-neutral pronouns, con=
sider using examples that are ethnicity/culture-rich, consider engaging use=
rs from diverse backgrounds if your research</span></p></div>

--000000000000c2598005d5047a0b--


--===============6356703159971802791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6356703159971802791==--


