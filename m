Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C839CC433EF
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 21:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71C68424C1;
	Fri,  7 Jan 2022 21:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JFTYlQJOFYWj; Fri,  7 Jan 2022 21:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38DF240010;
	Fri,  7 Jan 2022 21:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9DC9C0030;
	Fri,  7 Jan 2022 21:19:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 710B1C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 21:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58B64429D0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 21:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5WGDfUYMGXbG
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 21:19:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3068642986
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 21:19:28 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id r4so20002805lfe.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Jan 2022 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20210112.gappssmtp.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=SwcWUjfUQ3E3da8RvoOeTiWNFas/x2OMl3d/t623Jts=;
 b=D+hm7QLiV5837lIvTKqyUppm4Vg0LX5hZ0KuMBBNOVsyH0jBT015DNOnu4c2dzoGsY
 Kt+zDAPslpErT3n6hdulJq8y+8gxT1AecB0TBlfO7/iNzZIWhh/DvEdjKlm54aeg43/A
 CJQpNw72v4eLUAWzq+AqVTmGr78+1lqlPYGEDKnl6r6HJeBhz1+JulBbFW4DQXFECkhj
 F9pbZ2vZnqv1LN1ZqyRQ4eXQm85/EIOwDnCTuhm8B2N7SeYZE+tp3tPbN7/HIyxmTgBC
 fMzMp4dhzsyraPd17GEeSgG83dYgFGWSCb5M+eQkduJME2KJUU/Tsvdtdag/yFOKVdbf
 eDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=SwcWUjfUQ3E3da8RvoOeTiWNFas/x2OMl3d/t623Jts=;
 b=sBVnXozLv0+GdT2LPTGH3PRu8dXUSif69Kq92jZ2Kv31YZ0fAHeU/UCyquW0Wn4QEb
 WNXutTdK4wui+7w2K+XqIl1l1J1r5i/D9tpPkwzgJjIN5gJsquQOMt9X3JqkCZvoGD2W
 1+iACVQfFy/LwIrWGocIXEL5ViHDXsaIl5G2A0gXxQo8ioWQXPEbeY7hu+GywiJafn49
 N+Ny+FcxKfy4E8O/YpcfSuzGGnKt1Z/SDPrQJTg7sJc0ZI+1EoSiul19JRjD8/OcV9gV
 Vz0sTk9gqmSspNHtivDzCT8i8X66p/8r7dj+wPdB+obybNPNpmCNVbdSifHG81YcsvBv
 uTbQ==
X-Gm-Message-State: AOAM531kKeoOcJ8auXrmdIO8d23bLjawrRI/L4rHrqO0gpigOB3qROND
 d6U6jkp6KD47BFeDf+wnvr96jbs4LOT3Qrl/gvRaWA==
X-Google-Smtp-Source: ABdhPJywdCOhXGvmbF7Vy67DQIQiNtGUgSnxkmVaqQVPy1Fq63q4sbj1/ntQIrMPT2W9GXOxe3PySomKfFwYajOnVIs=
X-Received: by 2002:a05:6512:22c6:: with SMTP id
 g6mr48401119lfu.632.1641590366007; 
 Fri, 07 Jan 2022 13:19:26 -0800 (PST)
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Fri, 7 Jan 2022 16:19:14 -0500
Message-ID: <CA+Vr5cs=noNXHzcSnxvKfBrfbke85qRDu-Ta8O1fsvCcHFSD7g@mail.gmail.com>
Subject: Call for Workshops: ACM HPDC 2022 (The 31th International Symposium
 on High-Performance Parallel and Distributed Computing)
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
Content-Type: multipart/mixed; boundary="===============7611248823848865206=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7611248823848865206==
Content-Type: multipart/alternative; boundary="000000000000a2140905d5048a4b"

--000000000000a2140905d5048a4b
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

--000000000000a2140905d5048a4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Call for Workshops<br><br>The 31th International ACM Sympo=
sium on High-Performance Parallel and Distributed Computing (HPDC&#39;22)<b=
r>Minneapolis, Minnesota, United States, June 30 - July 1, 2022<br><br>Over=
view<br>The organizers of the 31st International ACM Symposium on High-Perf=
ormance Parallel and Distributed Computing (HPDC&#39;22) call for proposals=
 for Workshops to be held with the main conference.<br>The HPDC Workshops p=
rovide forums for discussion among researchers and practitioners on focused=
 topics and/or emerging research areas relevant to HPC and distributed comp=
uting.<br>Workshops typically include some combination of invited talks, pe=
er-reviewed papers, panel discussions, and work-in-progress talks. Proposer=
s should design workshops for approximately 20-40 participants, lasting eit=
her one full day or one-half day, depending on interest and space constrain=
ts. Proposals for workshops on new topics are welcome, as are proposals to =
continue previously successful workshops. Tutorials that would provide atte=
ndees with an interactive learning experience will be given special conside=
ration in acceptance. HPDC workshop proceedings will be published by ACM in=
 the HPDC proceedings companion book.<br><br>Proposal Submission<br>To Subm=
it: Please email your proposal to Ivy Peng (<a href=3D"mailto:peng8@llnl.go=
v" target=3D"_blank">peng8@llnl.gov</a>) with the title &quot;HPDC&#39;22 W=
orkshop Proposal&quot;<br><br>Formatting Guidelines<br>Workshop proposals s=
hould be formatted as a single PDF document of 2-4 pages, describing the fo=
llowing:<br>&gt; The full name and acronym of the workshop<br>&gt; Whether =
the workshop is planned for one full day or one half day<br>&gt; A descript=
ion of the theme and its key topics<br>&gt; A description of the relevance =
to HPDC<br>&gt; The structure of the workshop (peer-reviewed articles, invi=
ted articles, invited talks, panels, etc.)<br>&gt; Proposed names for invit=
ed speakers and panelists and their impacts on the topics discussed at the =
workshop<br>&gt; A tentative list of program committee members (optional)<b=
r>&gt; Details of the review process leading to acceptance to present at th=
e workshop<br>&gt; If the workshop will have a call for papers, a tentative=
 version of such CFP (optional)<br>&gt; If the workshop is going to have pu=
blished papers, the type of papers to be accepted and their length<br>&gt; =
A summary of the intended audience<br>&gt; A plan for attracting submission=
s and attendees to the workshop<br>&gt; A plan for in-person + hybrid optio=
n<br>&gt; A brief biographical information on the workshop organizers<br>&g=
t; Data about previous editions of the workshop including attendance, numbe=
r of papers submitted and accepted<br><br>Accepted workshops will need to b=
e ready to set up a website and, if a paper submission process with peer re=
view is going to be used, provide the submission link.<br><br>Important Dat=
es<br>Deadline for Workshop Proposals: January 15, 2022<br>Notification of =
Workshop Acceptance: January 31, 2022<br>Workshop Submission Deadlines: Lat=
e March, 2022*<br>Camera-Ready Deadline: Early May, 2022**<br>Workshop Date=
s: June 30 - July 1, 2022<br><br>* could change slightly, to allow for the =
flow of borderline articles from main conference to workshops<br>** could c=
hange slightly, to synchronize with the main conference proceedings<br><br>=
Workshops Chair:<br>Ivy B. Peng, Lawrence Livermore National Laboratory (<a=
 href=3D"mailto:email%3Apeng8@llnl.gov" target=3D"_blank">email:peng8@llnl.=
gov</a>).=C2=A0<br></div>

--000000000000a2140905d5048a4b--

--===============7611248823848865206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7611248823848865206==--
