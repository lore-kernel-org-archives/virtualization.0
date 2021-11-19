Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0544C433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 19:37:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4A961221
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 19:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A4A961221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 017F361C40;
	Fri, 19 Nov 2021 19:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwBNmim2z50R; Fri, 19 Nov 2021 19:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7565F606A6;
	Fri, 19 Nov 2021 19:37:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 539A7C002E;
	Fri, 19 Nov 2021 19:37:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C281EC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 19:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B77E40943
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 19:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fi4zAOOP64Ey
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 19:37:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B3EB401FB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 19:37:34 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id l22so47717826lfg.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 11:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20210112.gappssmtp.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=Wt//CLA6AqmFrMXPB18WbAA0DZfaNyanrsqjnhP1p7w=;
 b=CjH8ZrEJMoZ0mYRRwamYGVfhg8tu+xcgQlyvyf8IzLqJWn27kB4lPwUZu/5wGxO2m4
 KGDDosVgklZ4Ale38Be239eWm8izJx/d072D5Q3Zn24oB6aaZkxjZ7tQW+K7IDBPJ5UB
 8HxJOe+II5BHWQj+Vc9L2QxXZIesO1y00xMj0sEUtVlopq4Yu8PfVRGcaGypvNJuVjFt
 epRLnIz1RDE6dqMR/gDUni85uxaBIeZzwSEoyhDGTpQScwapQQqqd+/TXjZ9XOMDR0ha
 +k03hTKTY0E9P5kUirg5xLVLpgZq9E0CRKzE5Q+OxcetRxw6cAoCG5ImbapQrpbUwILM
 MbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Wt//CLA6AqmFrMXPB18WbAA0DZfaNyanrsqjnhP1p7w=;
 b=MKRAxs1QVlvczEOWeps+IlNd2tinlzNLjgCXN+wLO26+79bSDx6AgcJzchp85BSke3
 H0ty1qv4tjD/ggAQ5o388jMRPzys4+XIhbZLZrAGScQiqPCGK0couQCMn/gfw+46XsVW
 I2jW1JJTITK87bawfgU/z/AW3R14l79+0GjJG0LZxMMdw71ArvF29rmMmSQPWK8BxBpc
 kUE/s0II5K90sD/L/i0d9GIXJca72aqdfANXSY2CLsErdR+/sH7Q/+UB2guiVh+eP/EG
 UNFZFGLYhVHv1ihRq5YAIfuPx/9teovAXP9f+C2QOL4aoViEDS0xRX0TLxWGrUwnl7e1
 1X+g==
X-Gm-Message-State: AOAM532Qg4Q0Y1znOJw6FIbXOJrV/7bVpIL9l1EowgU5Qm3x+tUYosyL
 MfZcJOHHzTvDAFd8+Vr4oGT/F/LynwbLryb91AeB2g==
X-Google-Smtp-Source: ABdhPJyq6AQR3vWEQTQTJ/wMlg7XMzcmaJHzlAMMNQzn2N6uUj6JLkHf/PL/8yvvjke6PzzUm8HJeFJAWJncfQQZpbE=
X-Received: by 2002:a05:651c:17a6:: with SMTP id
 bn38mr28388107ljb.56.1637350652562; 
 Fri, 19 Nov 2021 11:37:32 -0800 (PST)
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Sat, 20 Nov 2021 00:37:20 +0500
Message-ID: <CA+Vr5csdvGfJrYLRG_xMOGVhEDVhV9SevUJ3JUdHBJG2j9aZJw@mail.gmail.com>
Subject: Call for Workshops: ACM HPDC 2022 (The 31th International Symposium
 on High-Performance Parallel and Distributed Computing)
To: tcpp-announce@computer.org, tcbis-announce@computer.org, 
 publicity@hipeac.net, hpc-announce@mcs.anl.gov, htcondor-users@cs.wisc.edu, 
 dbworld@cs.wisc.edu, virtualization@lists.linux-foundation.org, 
 infodir_sigcomm@acm.org, sc-workshop-attendee-cfp@group.supercomputing.org, 
 HPC-MEMBERS@listserv.acm.org, hpc-india@mailman.serc.iisc.in, 
 hipeac.publicity@lists.ugent.be, sigops-announce@listserv.acm.org, 
 users@planet-lab.org, sigplan-l@acm.uiuc.edu, tcde-announce@computer.org, 
 tci-announce@computer.org
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
Content-Type: multipart/mixed; boundary="===============7467520327793912254=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7467520327793912254==
Content-Type: multipart/alternative; boundary="00000000000004e19d05d1296867"

--00000000000004e19d05d1296867
Content-Type: text/plain; charset="UTF-8"

Call for Workshops

The 31th International ACM Symposium on High-Performance Parallel and
Distributed Computing (HPDC'22)
Minneapolis, Minnesota, United States, June 30 - July 1, 2022

Overview
The organizers of the 31st International ACM Symposium on High-Performance
Parallel and Distributed Computing (HPDC'22) call for proposals for
Workshops to be held with the main conference.
The HPDC Workshops provide forums for discussion among researchers and
practitioners on focused topics and/or emerging research areas relevant to
HPC and distributed computing.
Workshops typically include some combination of invited talks,
peer-reviewed papers, panel discussions, and work-in-progress talks.
Proposers should design workshops for approximately 20-40 participants,
lasting either one full day or one-half day, depending on interest and
space constraints. Proposals for workshops on new topics are welcome, as
are proposals to continue previously successful workshops. Tutorials that
would provide attendees with an interactive learning experience will be
given special consideration in acceptance. HPDC workshop proceedings will
be published by ACM in the HPDC proceedings companion book.

Proposal Submission
To Submit: Please email your proposal to Ivy Peng (peng8@llnl.gov) with the
title "HPDC'22 Workshop Proposal"

Formatting Guidelines
Workshop proposals should be formatted as a single PDF document of 2-4
pages, describing the following:
> The full name and acronym of the workshop
> Whether the workshop is planned for one full day or one half day
> A description of the theme and its key topics
> A description of the relevance to HPDC
> The structure of the workshop (peer-reviewed articles, invited articles,
invited talks, panels, etc.)
> Proposed names for invited speakers and panelists and their impacts on
the topics discussed at the workshop
> A tentative list of program committee members (optional)
> Details of the review process leading to acceptance to present at the
workshop
> If the workshop will have a call for papers, a tentative version of such
CFP (optional)
> If the workshop is going to have published papers, the type of papers to
be accepted and their length
> A summary of the intended audience
> A plan for attracting submissions and attendees to the workshop
> A plan for in-person + hybrid option
> A brief biographical information on the workshop organizers
> Data about previous editions of the workshop including attendance, number
of papers submitted and accepted

Accepted workshops will need to be ready to set up a website and, if a
paper submission process with peer review is going to be used, provide the
submission link.

Important Dates
Deadline for Workshop Proposals: January 15, 2022
Notification of Workshop Acceptance: January 31, 2022
Workshop Submission Deadlines: Late March, 2022*
Camera-Ready Deadline: Early May, 2022**
Workshop Dates: June 30 - July 1, 2022

* could change slightly, to allow for the flow of borderline articles from
main conference to workshops
** could change slightly, to synchronize with the main conference
proceedings

Workshops Chair:
Ivy B. Peng, Lawrence Livermore National Laboratory (email:peng8@llnl.gov).

--00000000000004e19d05d1296867
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Call for Workshops<br><br>The 31th International ACM Sympo=
sium on High-Performance Parallel and Distributed Computing (HPDC&#39;22)<b=
r>Minneapolis, Minnesota, United States, June 30 - July 1, 2022<br><br>Over=
view<br>The organizers of the 31st International ACM Symposium on High-Perf=
ormance Parallel and Distributed Computing (HPDC&#39;22) call for proposals=
 for Workshops to be held with the main conference. <br>The HPDC Workshops =
provide forums for discussion among researchers and practitioners on focuse=
d topics and/or emerging research areas relevant to HPC and distributed com=
puting. <br>Workshops typically include some combination of invited talks, =
peer-reviewed papers, panel discussions, and work-in-progress talks. Propos=
ers should design workshops for approximately 20-40 participants, lasting e=
ither one full day or one-half day, depending on interest and space constra=
ints. Proposals for workshops on new topics are welcome, as are proposals t=
o continue previously successful workshops. Tutorials that would provide at=
tendees with an interactive learning experience will be given special consi=
deration in acceptance. HPDC workshop proceedings will be published by ACM =
in the HPDC proceedings companion book.<br><br>Proposal Submission<br>To Su=
bmit: Please email your proposal to Ivy Peng (<a href=3D"mailto:peng8@llnl.=
gov" target=3D"_blank">peng8@llnl.gov</a>) with the title &quot;HPDC&#39;22=
 Workshop Proposal&quot;<br><br>Formatting Guidelines<br>Workshop proposals=
 should be formatted as a single PDF document of 2-4 pages, describing the =
following:<br>&gt;	The full name and acronym of the workshop<br>&gt;	Whethe=
r the workshop is planned for one full day or one half day <br>&gt;	A descr=
iption of the theme and its key topics<br>&gt;	A description of the relevan=
ce to HPDC<br>&gt;	The structure of the workshop (peer-reviewed articles, i=
nvited articles, invited talks, panels, etc.)<br>&gt;	Proposed names for in=
vited speakers and panelists and their impacts on the topics discussed at t=
he workshop<br>&gt;	A tentative list of program committee members (optional=
)<br>&gt;	Details of the review process leading to acceptance to present at=
 the workshop<br>&gt;	If the workshop will have a call for papers, a tentat=
ive version of such CFP (optional)<br>&gt;	If the workshop is going to have=
 published papers, the type of papers to be accepted and their length<br>&g=
t;	A summary of the intended audience<br>&gt;	A plan for attracting submiss=
ions and attendees to the workshop<br>&gt;	A plan for in-person + hybrid op=
tion<br>&gt;	A brief biographical information on the workshop organizers<br=
>&gt;	Data about previous editions of the workshop including attendance, nu=
mber of papers submitted and accepted<br><br>Accepted workshops will need t=
o be ready to set up a website and, if a paper submission process with peer=
 review is going to be used, provide the submission link. <br><br>Important=
 Dates<br>Deadline for Workshop Proposals:	January 15, 2022<br>Notification=
 of Workshop Acceptance:	January 31, 2022<br>Workshop Submission Deadlines:=
		Late March, 2022*<br>Camera-Ready Deadline:			Early May, 2022**<br>Worksh=
op Dates:				June 30 - July 1, 2022<br><br>* could change slightly, to allo=
w for the flow of borderline articles from main conference to workshops <br=
>** could change slightly, to synchronize with the main conference proceedi=
ngs<br><br>Workshops Chair:<br>Ivy B. Peng, Lawrence Livermore National Lab=
oratory (<a href=3D"mailto:email%3Apeng8@llnl.gov" target=3D"_blank">email:=
peng8@llnl.gov</a>).=C2=A0<br></div>

--00000000000004e19d05d1296867--

--===============7467520327793912254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7467520327793912254==--
