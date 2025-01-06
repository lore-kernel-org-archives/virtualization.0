Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDC43172
	for <virtualization@lists.linux-foundation.org>; Mon,  6 Jan 2025 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151775; cv=none; b=QVeAX7PvY9G4+EQhK2OZUs4iqC8M8zAkUR2M9Fqh7DKouWsrOGCT44FEFJ1TxGvWaY73WW+q9KZEXfcGU5/CchASCaFwF/YxYAWT6EkM3rFl+EsANsdrml6cKR4xE3NVW+pj1Xxvlosa7yJVMH0A0FlYG7nZa+D+0wkUzjpIZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151775; c=relaxed/simple;
	bh=xnQDJifQ7pQZ0oM/jyc28SkYbg9i2KWTEQUpWgH1Zro=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=DtyWZZ8Swv/PVmJIUaiHUZn6m7x0unyhpeU9P2z64j7Aqjx+7ZKAZDTM/tXvDhjN5pjU+Lur6d69vo3DHLfgUU7mxF/rvCT/d4enwDx11kd+7RmhQ70AQHBC4Zbi3psrveKfjKMO+bzJxSeNuFWV/VcTo6TXXjOx6S4pGvKfmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=tuhh.de header.i=@tuhh.de header.b=fiwAC0kj; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuhh.de header.i=@tuhh.de header.b="fiwAC0kj"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F37340296
	for <virtualization@lists.linux-foundation.org>; Mon,  6 Jan 2025 08:22:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEk7HFdnmGKw for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jan 2025 08:22:50 +0000 (UTC)
X-Greylist: delayed 577 seconds by postgrey-1.37 at util1.osuosl.org; Mon, 06 Jan 2025 08:22:50 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 454BC4018F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=tuhh.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 454BC4018F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=tuhh.de header.i=@tuhh.de header.a=rsa-sha256 header.s=x2025-01 header.b=fiwAC0kj
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:638:702:20aa::205:38; helo=smtp1.rz.tu-harburg.de; envelope-from=stefan.schulte@tuhh.de; receiver=<UNKNOWN> 
Received: from smtp1.rz.tu-harburg.de (smtp1.rz.tu-harburg.de [IPv6:2001:638:702:20aa::205:38])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 454BC4018F
	for <virtualization@lists.linux-foundation.org>; Mon,  6 Jan 2025 08:22:50 +0000 (UTC)
Received: from mail.tu-harburg.de (mail3.rz.tu-harburg.de [134.28.202.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.tu-harburg.de", Issuer "GEANT OV RSA CA 4" (verified OK))
	by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 4YRRks3wmLzxRY;
	Mon,  6 Jan 2025 09:13:09 +0100 (CET)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: cvv1159@KERBEROS.TU-HARBURG.DE)
	by mail.tu-harburg.de (Postfix) with ESMTPSA id 4YRRkh65bQzJrLW;
	Mon,  6 Jan 2025 09:13:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2025-01;
	t=1736151189; bh=xnQDJifQ7pQZ0oM/jyc28SkYbg9i2KWTEQUpWgH1Zro=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=fiwAC0kjPJJ4WBbxFmnKfluyL2Z2IHO1HE6npmVOe0/AAoZ67ajy8krSxROA5vex3
	 H98G9ZGeTyQyV51NAGaIqZ79dVG8wmYb7de6ox07rnZRVFsSt1clIBy3oNT6c/9s5J
	 8d5DaRu3E5USVHVADY9WVNTNegjcERUFiGqLltZU=
From: "Stefan Schulte" <stefan.schulte@tuhh.de>
To: <access@ncsa.uiuc.edu>,
	<agents@cs.umbc.edu>,
	<bblisa-announce@bblisa.org>,
	<CABERNET-EVENTS@JISCMAIL.AC.UK>,
	<cfp@mmlab.snu.ac.kr>,
	<chi-Announcements@acm.org>,
	<comm-theory@ieee.org>,
	<CommunicationsSociety@comsoc.org>,
	<community@mlnet.org>,
	<conference-services@ieee.org>,
	<conferences@gridtoday.com>,
	<conferences@newsmaster.tgc.com>,
	<contiki-developers@lists.sourceforge.net>,
	<cphc-conf@Jiscmail.ac.uk>,
	<csc@lists.purdue.edu>,
	<cse-cfp@cse.stfx.ca>,
	<DAI-List@mcc.com>,
	<discuss@ieeetcsc.org>,
	<distributed-computing-announce@datasys.cs.iit.edu>,
	<editor@hpcwire.com>,
	<end2end-china@netarchlab.tsinghua.edu.cn>,
	<grideditor@gridtoday.com>,
	<GRUPO@GSD.INESC-ID.PT>,
	<hpc-announce@mcs.anl.gov>,
	<icec@listserver.tue.nl>,
	<info@autonomic-communication.org>,
	<INVESTIGADORES@INESC-ID.PT>,
	<iot-edge-cloud@COMSOC.ORG>,
	<ml@ics.uci.edu>,
	<ml@isle.org>,
	<mmb@ira.uka.de>,
	<multicomm@comsoc.org>,
	<NGN@JISCMAIL.AC.UK>,
	<pdcemail@ee.uwa.edu.au>,
	<performance@merlot.usc.edu>,
	<planning@asu.edu>,
	<podc-related@acm.org>,
	<publicity@hipeac.net>,
	<remarks@psc.edu>,
	<siam-sc@siam.org>,
	<SIGCOMM-MEMBERS@ACM.ORG>,
	<sigcomm@postel.org>,
	<sigmetrics-bb@merlot.usc.edu>,
	<sigplan-l@acm.uiuc.edu>,
	<SIGSIM@ACM.ORG>,
	<socinfo@cs.tut.fi>,
	<spectrum-webmaster@ieee.org>,
	<storage-research-list@ece.cmu.edu>,
	<tccc-announce@comsoc.org>,
	<tccn@comsoc.org>,
	<tcsc@cse.stfx.ca>,
	<tfcc@clustercomputing.org>,
	<uk-performance@macs.hw.ac.uk>,
	<uksim@glam.ac.uk>,
	<virtualization@lists.linux-foundation.org>,
	<webmaster@ncsa.uiuc.edu>
References: <02f901db2556$971b8560$c5529020$@tuhh.de>
In-Reply-To: <02f901db2556$971b8560$c5529020$@tuhh.de>
Subject: Deadline Extended: 9th IEEE International Conference on Fog and Edge Computing (ICFEC 2025) 
Date: Mon, 6 Jan 2025 09:12:59 +0100
Message-ID: <057d01db6012$d243ad10$76cb0730$@tuhh.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AdtgEr+aE0tiPEc0ReKzvSlDhE6Agw==

Deadline Extended: 9th IEEE International Conference on Fog and Edge
Computing (ICFEC 2025) http://icfec2025.ontariotechu.ca/, May 19th-22nd,
2025, Troms=F8, Norway

###TOPICS OF INTEREST###
The conference seeks to attract high-quality contributions covering both
theory and practice over systems research and emerging domain-specific
applications related to next-generation distributed systems that cover
different parts of the cloud-edge compute continuum. This covers =
different
computing models, including mist computing, edge computing, multi-access
edge computing, fog computing, and mobile cloud computing.=20
Some representative topics of interest include, but are not limited to:
* Data centers and infrastructures along the compute continuum
* Mobility management along the compute continuum
* Federated learning and distributed machine learning in and for the =
compute
continuum
* 5G/6G for the compute continuum
* Middleware and runtime systems for the compute continuum
* Programming models for the compute continuum
* Storage and data management platforms along the compute continuum
* Scheduling and resource management for the compute continuum
* Security, privacy, trust, and provenance issues for the compute =
continuum
* Distributed consensus and blockchains in the compute continuum
* Modeling and simulation for and in the compute continuum
* Performance monitoring and metering of infrastructures along the =
compute
continuum
* (Big) Data processing in the compute continuum
* Energy-efficient computing in the compute continuum

###SUBMISSION###
We invite original manuscripts that have neither been published =
elsewhere
nor are under review at a different venue. Papers should follow the IEEE
template for conference proceedings. Authors should submit papers, =
written
in English, electronically in PDF format, and may not exceed 8 =
letter-size
pages in length, including all figures, tables, and references. Apart =
from
full papers, authors may also submit poster papers, which may not exceed =
2
pages in length.=20

All manuscripts will be reviewed and judged on originality, technical
strength, significance, presentation, and relevance to the conference by =
at
least three reviewers. Papers may be submitted online at
https://easychair.org/conferences/?conf=3Dicfec2025.=20

Papers that are accepted for publication may be accepted as REGULAR =
papers
(8 pages), SHORT papers (5 pages), or POSTER papers (2 pages), depending =
on
the reviewers' recommendations. Accepted regular, short, and poster =
papers
will be included in the conference proceedings that will be published
through the IEEE Computer Society Conference Publishing Services.=20

Further submission information can be found at
http://icfec2025.ontariotechu.ca/.

###IMPORTANT DATES###
* Jan. 23, 2025: Paper submission deadline
* Feb. 28, 2025: Author notification
* Mar. 15, 2025: Camera-ready submission
* May 19-22, 2025: Conference (on-site in Troms=F8, Norway)

###ORGANIZATION & CONTACT###
General Chairs:
* Khalid Elgazzar, Ontario Tech University, Canada
* Lena Mashayekhy, University of Delaware, USA

Program Committee Chairs:=20
* Cristina L. Abad, Escuela Superior Politecnica del Litoral (ESPOL),
Ecuador
* Stefan Schulte, Hamburg University of Technology, Germany
* Subhajit Sidhanta, IIT Kharagpur, India

The organizing committee of IEEE ICFEC 2025 can be reached via email at
stefan.schulte@tuhh.de.


