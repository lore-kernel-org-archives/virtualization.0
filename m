Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496711FAC5E
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340614; cv=none; b=Nx6js3G3amoK+aFD9f/5Usxa2+wvgM23F17ZELFrROMQVKmfnvjbeCKxmYB0y1cPaeL2ri8xbWtvv48a6Iz2PjEtddGWKQO56yaRD5QQ8LQVTyePD6Qb56CBIqIsTHFX3UGDQuKlMJhm7HsUfET2X3M5QDuB0nncCsEYOqVdEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340614; c=relaxed/simple;
	bh=YiJrTfY+TiGJUrCS4GvvFA3Xo+ceErOtea7oVDJDOA4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=seSbABwKGTvk0mIDSsDdmlIs22Epoih59bBecOJ2FYWWwtt1YNPJFnpOyxIpQDlOCCCH8FTo77WWEuZ4Txw5k03Y+d+eMsIlgcZq1xYDEHmD7QaXhZhMMLnzjcj3fE1HBT+NR8V4SETKHvsQM+1avhs/neiPw3MT9HZFRd7G39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=tu-sofia.bg header.i=@tu-sofia.bg header.b=r6KflBX8; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-sofia.bg header.i=@tu-sofia.bg header.b="r6KflBX8"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8069408AD
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNsclC6Wof-p for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 12:50:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=81.161.240.27; helo=new-smtp.tu-sofia.bg; envelope-from=rrom@tu-sofia.bg; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EB30A4063D
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=tu-sofia.bg
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB30A4063D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=tu-sofia.bg header.i=@tu-sofia.bg header.a=rsa-sha256 header.s=dkim header.b=r6KflBX8
Received: from new-smtp.tu-sofia.bg (new-smtp.tu-sofia.bg [81.161.240.27])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB30A4063D
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:50:08 +0000 (UTC)
Received: from new-smtp.tu-sofia.bg (localhost.localdomain [127.0.0.1])
	by new-smtp.tu-sofia.bg (TU - Sofia SMTP Gateway) with ESMTP id 03E05477DE;
	Wed,  8 Jan 2025 14:41:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-sofia.bg; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=dkim; bh=TkaYep9mMYfMUUKXREoF
	v/fzFdoCTt2AIEPJH6JwBSk=; b=r6KflBX8NBaVFuqp0YiL0DpcZHm7bHtYgrdQ
	RFMhe4WLuXqjs8QODyuoxCty9YiKm4AxhhkUg0q34uuoCROCjypd19rD5toXgD3a
	J29bLithNIi4x+2EiB6kExW1yDu8LlZZdSHh3PWDnp7lq3c4kmI1W+7fYqx9LhSQ
	5T2lO2w=
Received: from mail.tu-sofia.bg (ALPHA.tu-sofia.bg [81.161.240.12])
	by new-smtp.tu-sofia.bg (TU - Sofia SMTP Gateway) with ESMTP id D5826477D9;
	Wed,  8 Jan 2025 14:41:24 +0200 (EET)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 08 Jan 2025 14:41:24 +0200
From: rrom <rrom@tu-sofia.bg>
To: Stefan Schulte <stefan.schulte@tuhh.de>
Cc: access@ncsa.uiuc.edu, agents@cs.umbc.edu, bblisa-announce@bblisa.org,
 CABERNET-EVENTS@jiscmail.ac.uk, cfp@mmlab.snu.ac.kr,
 chi-Announcements@acm.org, comm-theory@ieee.org,
 CommunicationsSociety@comsoc.org, community@mlnet.org,
 conference-services@ieee.org, conferences@gridtoday.com,
 conferences@newsmaster.tgc.com, contiki-developers@lists.sourceforge.net,
 cphc-conf@jiscmail.ac.uk, csc@lists.purdue.edu, cse-cfp@cse.stfx.ca,
 DAI-List@mcc.com, discuss@ieeetcsc.org,
 distributed-computing-announce@datasys.cs.iit.edu, editor@hpcwire.com,
 end2end-china@netarchlab.tsinghua.edu.cn, grideditor@gridtoday.com,
 GRUPO@gsd.inesc-id.pt, hpc-announce@mcs.anl.gov, icec@listserver.tue.nl,
 info@autonomic-communication.org, INVESTIGADORES@inesc-id.pt,
 iot-edge-cloud@comsoc.org, ml@ics.uci.edu, ml@isle.org, mmb@ira.uka.de,
 multicomm@comsoc.org, NGN@jiscmail.ac.uk, pdcemail@ee.uwa.edu.au,
 performance@merlot.usc.edu, planning@asu.edu, podc-related@acm.org,
 publicity@hipeac.net, remarks@psc.edu, siam-sc@siam.org,
 SIGCOMM-MEMBERS@acm.org, sigcomm@postel.org, sigmetrics-bb@merlot.usc.edu,
 sigplan-l@acm.uiuc.edu, SIGSIM@acm.org, socinfo@cs.tut.fi,
 spectrum-webmaster@ieee.org, storage-research-list@ece.cmu.edu,
 tccc-announce@comsoc.org, tccn@comsoc.org, tcsc@cse.stfx.ca,
 tfcc@clustercomputing.org, uk-performance@macs.hw.ac.uk, uksim@glam.ac.uk,
 virtualization@lists.linux-foundation.org, webmaster@ncsa.uiuc.edu
Subject: IJITS journal - Information
In-Reply-To: <057d01db6012$d243ad10$76cb0730$@tuhh.de>
References: <02f901db2556$971b8560$c5529020$@tuhh.de>
 <057d01db6012$d243ad10$76cb0730$@tuhh.de>
Message-ID: <baae856877d4bd5809317ed8274058bf@tu-sofia.bg>
X-Sender: rrom@tu-sofia.bg
Organization: =?UTF-8?Q?=D0=A2=D0=A3-=D0=A1=D0=BE=D1=84=D0=B8=D1=8F?=
X-Priority: 1 (Highest)
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Dear Colleagues,
Thanks for all comunications and information for potential publications!

Please, find attached a brief information about a scientific journal 
International Journal on IT and Security (ijits-bg.com), published by 
me, which is indexed in the Web of Science with an impact factor 
JIF(2023)=1.0.
Published articles for the past two years can be accessed using the URL
    2023
https://ijits-bg.com/sites/default/files/archive/2023(vol.15)/contents-vol15-2023_1.pdf
    2024
https://ijits-bg.com/sites/default/files/archive/2024(vol.16)/Contents_Vol16-2024-6.pdf

Please, do not hesitate to contact me if you need additional 
information.
Kind regards
Prof. Eng. Radi Romansky, D.Sc.





На 06.01.2025 10:12, Stefan Schulte написа:
> Deadline Extended: 9th IEEE International Conference on Fog and Edge
> Computing (ICFEC 2025) http://icfec2025.ontariotechu.ca/, May 
> 19th-22nd,
> 2025, Tromsø, Norway
> 
> ###TOPICS OF INTEREST###
> The conference seeks to attract high-quality contributions covering 
> both
> theory and practice over systems research and emerging domain-specific
> applications related to next-generation distributed systems that cover
> different parts of the cloud-edge compute continuum. This covers 
> different
> computing models, including mist computing, edge computing, 
> multi-access
> edge computing, fog computing, and mobile cloud computing.
> Some representative topics of interest include, but are not limited to:
> * Data centers and infrastructures along the compute continuum
> * Mobility management along the compute continuum
> * Federated learning and distributed machine learning in and for the 
> compute
> continuum
> * 5G/6G for the compute continuum
> * Middleware and runtime systems for the compute continuum
> * Programming models for the compute continuum
> * Storage and data management platforms along the compute continuum
> * Scheduling and resource management for the compute continuum
> * Security, privacy, trust, and provenance issues for the compute 
> continuum
> * Distributed consensus and blockchains in the compute continuum
> * Modeling and simulation for and in the compute continuum
> * Performance monitoring and metering of infrastructures along the 
> compute
> continuum
> * (Big) Data processing in the compute continuum
> * Energy-efficient computing in the compute continuum
> 
> ###SUBMISSION###
> We invite original manuscripts that have neither been published 
> elsewhere
> nor are under review at a different venue. Papers should follow the 
> IEEE
> template for conference proceedings. Authors should submit papers, 
> written
> in English, electronically in PDF format, and may not exceed 8 
> letter-size
> pages in length, including all figures, tables, and references. Apart 
> from
> full papers, authors may also submit poster papers, which may not 
> exceed 2
> pages in length.
> 
> All manuscripts will be reviewed and judged on originality, technical
> strength, significance, presentation, and relevance to the conference 
> by at
> least three reviewers. Papers may be submitted online at
> https://easychair.org/conferences/?conf=icfec2025.
> 
> Papers that are accepted for publication may be accepted as REGULAR 
> papers
> (8 pages), SHORT papers (5 pages), or POSTER papers (2 pages), 
> depending on
> the reviewers' recommendations. Accepted regular, short, and poster 
> papers
> will be included in the conference proceedings that will be published
> through the IEEE Computer Society Conference Publishing Services.
> 
> Further submission information can be found at
> http://icfec2025.ontariotechu.ca/.
> 
> ###IMPORTANT DATES###
> * Jan. 23, 2025: Paper submission deadline
> * Feb. 28, 2025: Author notification
> * Mar. 15, 2025: Camera-ready submission
> * May 19-22, 2025: Conference (on-site in Tromsø, Norway)
> 
> ###ORGANIZATION & CONTACT###
> General Chairs:
> * Khalid Elgazzar, Ontario Tech University, Canada
> * Lena Mashayekhy, University of Delaware, USA
> 
> Program Committee Chairs:
> * Cristina L. Abad, Escuela Superior Politecnica del Litoral (ESPOL),
> Ecuador
> * Stefan Schulte, Hamburg University of Technology, Germany
> * Subhajit Sidhanta, IIT Kharagpur, India
> 
> The organizing committee of IEEE ICFEC 2025 can be reached via email at
> stefan.schulte@tuhh.de.

