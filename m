Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48477C4332F
	for <virtualization@archiver.kernel.org>; Fri,  3 Nov 2023 12:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B14A04368D;
	Fri,  3 Nov 2023 12:25:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B14A04368D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=A8I+nJZl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9SRsU5FC7UpK; Fri,  3 Nov 2023 12:25:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8EF4E404B1;
	Fri,  3 Nov 2023 12:25:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EF4E404B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6798EC0071;
	Fri,  3 Nov 2023 12:25:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F09F4C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 12:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC3E084D21
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 12:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC3E084D21
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com
 header.i=@vt-edu.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601
 header.b=A8I+nJZl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wD4e0jnWggGx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 12:25:38 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49CB484D18
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 12:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49CB484D18
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7ba0d338367so828030241.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Nov 2023 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1699014337; x=1699619137;
 darn=lists.linux-foundation.org; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2Bi2g2lPG1OoJamzAodvRCrCRuGvSQDXo9Dph5jPEVg=;
 b=A8I+nJZlfeLIML/CaTXh/IBeIXIR9pnH5lgHnTuivhk5vihTs+6dtFnsW9Io/+NS6W
 yLHKPOG7aenKrxd3EI96NVbz3A5P/h0RR7MOcHyCLe5cYrjjgb9Y5EoSrUcICt5uGbeH
 BVNWMghp5nXIZBqAp31EMlUP2C5kq1WcmeAVZOlUnG6BX7qarj2U8ywiZjS56VnM5a0O
 /B7xbaHqvfOLznUlJadlWQLXtooPGXt8pIeNpO/bJRWax+n6a19mhL/WG743XZnuIHQQ
 a7CZbm3qiIqA+gSvkUB41mFB/a32F/RD4Y1LEUZ74Ndn18tvF+WR3Occle6U7/DDPKkG
 SFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699014337; x=1699619137;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Bi2g2lPG1OoJamzAodvRCrCRuGvSQDXo9Dph5jPEVg=;
 b=PgznoL6tXXM+qnuznnOBU8W5hNDJSWYKlw3RQ1/1KsuJ/WBl4/RbIy2sTOU6/mtilc
 JgTHyorP8ushBVJ62VWQk+rTrkuPKtzPIZeDFUyN9QObn09UHb3fXyQVPsdKVZUaQr13
 gG+yyAROhn2WeEl3VukJHFC2N4hZ33Hi2NiJM5df3aNxumoU1GyTVNPOxYhFwuly5Wzy
 QBiVBNwRI65DhepMdKObwHczEeSTcoHdHAjjxhMwBg8dz8spqkA+HK/pW7xASyESlBul
 7dlmOyX57R6Y2PitdtB2RRGp5lOu6vwt9SZ1x5jbThLpVvzn5q6RDS1TE+MNx4TPyW7U
 qV1w==
X-Gm-Message-State: AOJu0YzbUihgg70y8LmZ/AfBxuBShC2zIn10D4Q71CtZIwbcUfvgxD1R
 x0WIAqnSD/0OeF/8ABxug8w/XNQYpHj4RlyqSLw4Jw==
X-Google-Smtp-Source: AGHT+IHbT9frMxL5oLpzIdUsUjA0gg/IXMcQsOkUPXiuDUDwH+esN39MtPcCamlXq1ZTFDJOhEoFwD9iMQA02/qgEJA=
X-Received: by 2002:a05:6102:2089:b0:45d:8876:882 with SMTP id
 h9-20020a056102208900b0045d88760882mr2578337vsr.4.1699014336846; Fri, 03 Nov
 2023 05:25:36 -0700 (PDT)
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Fri, 3 Nov 2023 07:25:00 -0500
Message-ID: <CA+Vr5ctG0bTnM8s5jOTFC02_iryLg_6yuzN5nNaBG24xqP8WOg@mail.gmail.com>
Subject: HPDC 2024: Call for Workshops and Tutorials
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
Content-Type: multipart/mixed; boundary="===============8454685716702946201=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8454685716702946201==
Content-Type: multipart/alternative; boundary="00000000000004374006093e9a0e"

--00000000000004374006093e9a0e
Content-Type: text/plain; charset="UTF-8"

*******************************************
HPDC 2024: Call for Workshops and Tutorials
Date: 3-7 June 2024
Location: Pisa, Italy
*******************************************

* Overview

HPDC warmly invites proposals for workshops and tutorials. Workshops offer
a platform for valuable discussions among researchers and practitioners,
focusing on key topics and emerging research areas in the field of
High-Performance Computing (HPC) and distributed computing. Workshops
typically feature a blend of invited talks, peer-reviewed papers, panel
discussions, and work-in-progress presentations. Workshop organizers are
encouraged to structure their sessions for an audience of approximately
20-40 participants, with flexibility for either a full day or half day
format depending on interest and space availability.

We welcome proposals for workshops on new, innovative topics as well as
submissions to continue successful workshops from previous years. Note that
proceedings of HPDC workshops will be published in by the ACM in dedicated
proceedings. The selected workshops and tutorials will be held on the first
two days of the conference (June 3rd and 4th).

* Important Dates AoE

    November 6, 2023. Workshops and Tutorial proposals' early deadline

    November 13, 2023. Notification of acceptance (Workshops and Tutorials)
- early submissions

    December 4, 2023. Workshops and Tutorial proposals' late deadline

    December 11, 2023. Notification of acceptance (Workshops and Tutorials)
- early submissions

    TBA Paper Submission deadline

    TBA Notification of acceptance (Papers)

    TBA Camera-ready due

* Workshops and Tutorials Submission Process

To Submit: Please email your proposal to the Worshops and Tutorial chairs
using the following addresses: matteo.mordacchini@iit.cnr.it ,
mrz7dp@virginia.edu . The submissions must conform to the Submission
Guidelines.

* Workshop Proposals Formatting Guidelines

Please adhere to the following formatting guidelines for workshop
proposals. Your proposal should be submitted as a single PDF document
containing 2 to 4 pages and should include the following information:
- Workshop name: Provide the complete workshop title along its acronym.
- Duration: Specify whether the workshop is intended for a full day or a
half day.
- Workshop Theme and Key Topics: Describe the overarching theme of the
workshop and its core topics. Emphasize the focused nature of the theme.
- Relevance to HPDC: Highlight how the proposed workshop complements the
main HPDC program.
- The structure of the workshop (peer-reviewed articles, invited articles,
invited talks, panels, etc.).
- Workshop Structure: Explain the workshop's structure, including elements
like peer-reviewed articles, invited talks, panels, and more.
- Invited Speakers and Panelists: Propose the names of potential invited
speakers and panelists and describe how they will contribute to the
workshop's discussions.
- Program Committee (Optional): Provide a tentative list of program
committee members if available.
- Review Process: Detail the review process for workshop paper acceptance.
- Call for Papers (Optional): If applicable, include a preliminary version
of the Call for Papers (CFP).
- Paper Publication: Specify the type and length of papers to be accepted
if the workshop plans to publish papers.
- Intended Audience: Outline plans for attracting submissions and workshop
attendees.
- Attraction and Engagement: A plan for attracting submissions and
attendees to the workshop.
- Organizer Bios: Briefly introduce the workshop organizers with their
biographical information.
- Previous Workshop Data (if applicable): Share details of past workshop
editions, including attendance, submitted papers, and accepted papers.
- Workshop Setup: Accepted workshops should be prepared to establish a
dedicated website. If you plan to use a paper submission process with peer
review, provide the submission link.

* Tutorial Proposals Formatting Guidelines

Tutorial proposals should be formatted as a single PDF document of 2-4
pages, describing the following:
- The full name and acronym of the Tutorial
- Abstract, objectives and motivation, and intended audience
- Name and a short biography of each tutorial presenter
- A description of the topics that the tutorial will address, emphasizing
their timeliness
- An outline of the tutorial content, including its tentative schedule and
the presenters for different parts
- Possibility of and suitability for a virtual presentation of the tutorial
- A description of the past/relevant experience of the speaker(s) on the
topic of the tutorial
- A description of previous tutorial experience of the speaker(s), and past
versions of the tutorial
- State whether a similar tutorial has been offered in recent ICC &
Globecom (last two years) and how your tutorial differs

--00000000000004374006093e9a0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">******************************************* <br>
<span class=3D"gmail-il">HPDC</span> 2024: Call for Workshops and Tutorials=
 <br>
Date: 3-7 June 2024 <br>
Location: Pisa, Italy <br>
******************************************* <br>
<br>
* Overview <br>
<br>
<span class=3D"gmail-il">HPDC</span> warmly invites proposals for workshops=
 and=20
tutorials. Workshops offer a platform for valuable discussions among=20
researchers and practitioners, focusing on key topics and emerging=20
research areas in the field of High-Performance Computing (HPC) and=20
distributed computing. Workshops typically feature a blend of invited=20
talks, peer-reviewed papers, panel discussions, and work-in-progress=20
presentations. Workshop organizers are encouraged to structure their=20
sessions for an audience of approximately 20-40 participants, with=20
flexibility for either a full day or half day format depending on=20
interest and space availability. <br>
<br>
We welcome proposals for workshops on new, innovative topics as well as=20
submissions to continue successful workshops from previous years. Note=20
that proceedings of <span class=3D"gmail-il">HPDC</span> workshops will be=
=20
published in by the ACM in dedicated proceedings. The selected workshops
 and tutorials will be held on the first two days of the conference=20
(June 3rd and 4th). <br>
<br>
* Important Dates AoE <br>
<br>
=C2=A0 =C2=A0 November 6, <span class=3D"gmail-il">2023</span>. Workshops a=
nd Tutorial proposals&#39; early deadline <br>
<br>
=C2=A0 =C2=A0 November 13, <span class=3D"gmail-il">2023</span>. Notificati=
on of acceptance (Workshops and Tutorials) - early submissions <br>
<br>
=C2=A0 =C2=A0 December 4, <span class=3D"gmail-il">2023</span>. Workshops a=
nd Tutorial proposals&#39; late deadline <br>
<br>
=C2=A0 =C2=A0 December 11, <span class=3D"gmail-il">2023</span>. Notificati=
on of acceptance (Workshops and Tutorials) - early submissions <br>
<br>
=C2=A0 =C2=A0 TBA Paper Submission deadline <br>
<br>
=C2=A0 =C2=A0 TBA Notification of acceptance (Papers) <br>
<br>
=C2=A0 =C2=A0 TBA Camera-ready due <br>
<br>
* Workshops and Tutorials Submission Process <br>
<br>
To Submit: Please email your proposal to the Worshops and Tutorial chairs u=
sing the following addresses: <a href=3D"mailto:matteo.mordacchini@iit.cnr.=
it" target=3D"_blank">matteo.mordacchini@iit.cnr.it</a> , <a href=3D"mailto=
:mrz7dp@virginia.edu" target=3D"_blank">mrz7dp@virginia.edu</a> . The submi=
ssions must conform to the Submission Guidelines. <br>
<br>
* Workshop Proposals Formatting Guidelines <br>
<br>
Please adhere to the following formatting guidelines for workshop=20
proposals. Your proposal should be submitted as a single PDF document=20
containing 2 to 4 pages and should include the following information: <br>
- Workshop name: Provide the complete workshop title along its acronym. <br=
>
- Duration: Specify whether the workshop is intended for a full day or a ha=
lf day. <br>
- Workshop Theme and Key Topics: Describe the overarching theme of the=20
workshop and its core topics. Emphasize the focused nature of the theme.
 <br>
- Relevance to <span class=3D"gmail-il">HPDC</span>: Highlight how the prop=
osed workshop complements the main <span class=3D"gmail-il">HPDC</span> pro=
gram. <br>
- The structure of the workshop (peer-reviewed articles, invited articles, =
invited talks, panels, etc.). <br>
- Workshop Structure: Explain the workshop&#39;s structure, including=20
elements like peer-reviewed articles, invited talks, panels, and more. <br>
- Invited Speakers and Panelists: Propose the names of potential invited
 speakers and panelists and describe how they will contribute to the=20
workshop&#39;s discussions. <br>
- Program Committee (Optional): Provide a tentative list of program committ=
ee members if available. <br>
- Review Process: Detail the review process for workshop paper acceptance. =
<br>
- Call for Papers (Optional): If applicable, include a preliminary version =
of the Call for Papers (CFP). <br>
- Paper Publication: Specify the type and length of papers to be accepted i=
f the workshop plans to publish papers. <br>
- Intended Audience: Outline plans for attracting submissions and workshop =
attendees. <br>
- Attraction and Engagement: A plan for attracting submissions and attendee=
s to the workshop. <br>
- Organizer Bios: Briefly introduce the workshop organizers with their biog=
raphical information. <br>
- Previous Workshop Data (if applicable): Share details of past workshop
 editions, including attendance, submitted papers, and accepted papers. <br=
>
- Workshop Setup: Accepted workshops should be prepared to establish a=20
dedicated website. If you plan to use a paper submission process with=20
peer review, provide the submission link. <br>
<br>
* Tutorial Proposals Formatting Guidelines <br>
<br>
Tutorial proposals should be formatted as a single PDF document of 2-4 page=
s, describing the following: <br>
- The full name and acronym of the Tutorial <br>
- Abstract, objectives and motivation, and intended audience <br>
- Name and a short biography of each tutorial presenter <br>
- A description of the topics that the tutorial will address, emphasizing t=
heir timeliness <br>
- An outline of the tutorial content, including its tentative schedule and =
the presenters for different parts <br>
- Possibility of and suitability for a virtual presentation of the tutorial=
 <br>
- A description of the past/relevant experience of the speaker(s) on the to=
pic of the tutorial <br>
- A description of previous tutorial experience of the speaker(s), and past=
 versions of the tutorial <br><div>
- State whether a similar tutorial has been offered in recent ICC &amp; Glo=
becom (last two years) and how your tutorial differs</div><div><br></div><d=
iv><br></div></div>

--00000000000004374006093e9a0e--

--===============8454685716702946201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8454685716702946201==--
