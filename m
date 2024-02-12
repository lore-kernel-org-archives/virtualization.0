Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68528389
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748889; cv=none; b=pqHNbYUAK2AlRtZR6LLdCHvhCxyPpWNzR349i52ryMwot0KxSSim++GWItyDK3mBF9EEBHAjUo7PsRN/BPtn4TV0WcwGNNatpYxQ/SF//KMlIULfjagQadiIXFXAvUdkqN/mJIDoH3RRQ0/m398ByX1BfpLZhJgYKbChfPEkbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748889; c=relaxed/simple;
	bh=dk4SMg4Eyo+17IaC+TfkVNmtO/97IFXCvEuxfoZbaMk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QJJtSSy0kNDmkbN9OTOW3IOiQ5PCsuR5AFx6Cyn95lynM04R4FndPcrs4MKze+oVArC0pqx/xXRKeLtxRU9wQ0/2HS4MdetDYPc6SLrBUC+mJH0rBFPP56kRiyuGBKvg2+AV6Zj15ves1kLIlRZknOWRbEeLoll/oprQEobHv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=xgRtd0E2; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="xgRtd0E2"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75B02410EA
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 14:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LLtVbTIPIlZJ
	for <virtualization@lists.linux-foundation.org>;
	Mon, 12 Feb 2024 14:41:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::92a; helo=mail-ua1-x92a.google.com; envelope-from=ali@vt.edu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DCC42410C4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=vt.edu
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCC42410C4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=xgRtd0E2
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCC42410C4
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 14:41:25 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so1067004241.3
        for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 06:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1707748884; x=1708353684; darn=lists.linux-foundation.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dk4SMg4Eyo+17IaC+TfkVNmtO/97IFXCvEuxfoZbaMk=;
        b=xgRtd0E2Yme3/Ru1zHXR91oyZm9N9C0tY4Kk4GkTINpHdXVNMBIwo5a5d/gJsh5F2V
         qyDvjHtqdJ0R50C55w0SvKDxjAikGzuSqX6q4Yd3vA8NC89rwZJlGktilhmyRJS69Gfm
         voG2MR8j/0jOnIR2h140X4+9dVC/4Oiq3dXw0VhVP03kAXNGy3+44XSvuLcnh7WQ0Lp3
         puswPm2/pn1sNHfZTC4T5zKu50WLAbtvN+AcYEXOcIHEptjfDh0eUwh3RcevCTS94WR6
         V2Fom95Q0GlsWgVq6z4s6oz1LUSlTzQWNm9tP6nB1Y3SptyG9d60Fw8BQ00CUUurz75w
         wLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748884; x=1708353684;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dk4SMg4Eyo+17IaC+TfkVNmtO/97IFXCvEuxfoZbaMk=;
        b=EAOIr3w1YCcu67HggmUBrw2Apd+6aCeEYO2raI/d0kAQvJE1Cnuoll+Lr8LnzsFrVG
         7M74jWpToxesBjCXyIr1KBZCIGUq7nnP3/TlPKw5MG7f3yyB2FlBV58vaKiN1viit92m
         f1dX9MY5nTSvl8DaeMRd9mcrVLEgDKGTPJ+1TDJs3+mjeTgnUkjkZ6Ot0tLRmo7ndHbx
         /5hLq4pWLy3X7HzPeE7urGyIwPrQs2AzGMWVqSrSm+gWYx5psg7PxjSgZ/u7Ap1ChKYT
         RZb71AqG/aYtFD1cNovgl/0AA9Jh92FxEiKSarciss/xAg9+jm+ckklM/auUczJ8i/7r
         EBsg==
X-Gm-Message-State: AOJu0Yxbf6NMiHtajeyU4Ew9DozLYSY2Kl3CZ5tZcEA09sIM93ww54K4
	r+aBcSeqYfTlehHVzOxfaaXhEBNiONmkMpsXeSuGrRWoiNHGTtVa0DlcYhca6qzu6JmDNDDI11N
	hm74h+oZI+iXrcTR/G6KenqL+6qa2GRww/HkM+w==
X-Google-Smtp-Source: AGHT+IG+s1X222JCOQr8SZuk633tsmHimK5sFbJgj5pvuzFXCOdYe8n9TfIoOZrblTd06cc9Dc3IELJCpxF+e7SXMBg=
X-Received: by 2002:a1f:db04:0:b0:4c0:292d:192a with SMTP id
 s4-20020a1fdb04000000b004c0292d192amr3158691vkg.0.1707748884141; Mon, 12 Feb
 2024 06:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ali Anwar <ali@vt.edu>
Date: Mon, 12 Feb 2024 08:40:48 -0600
Message-ID: <CA+Vr5csHyK9qtpQ_+iq9dPs2PPr4fc2J77p4erv4FGTG4UJidA@mail.gmail.com>
Subject: HPDC 2024: PhD Symposium call for papers
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

************************************************
HPDC 2024: PhD Symposium call for papers
Date: 3-7 June 2024
Location: Pisa, Italy
Web: https://www.hpdc.org/2024/calls-phd.html
Sponsored by SIGARCH
In-cooperation with SIGHPC
************************************************

The ACM International Symposium on High-Performance Parallel and
Distributed Computing (HPDC) is the premier annual conference for
presenting the latest research on the design, implementation,
evaluation, and use of parallel and distributed systems for high-end
computing.

The PhD Symposium at HPDC 2024 is intended to offer the possibility to
show advanced "work in progress" to PhD students working on the HPDC
2024 conference relevant topics in the context of high-performance
parallel and distributed computing.

The selected contributions will appear in a special section of the
conference proceedings.
HPDC 2024 programme will host sessions where authors of accepted
contributions will present their work to the entire HPDC conference
audience, thus offering to graduate students an opportunity to discuss
their research with experts in academia and industry, and to make
useful contacts regarding future career opportunities.

* Submission Guidelines

Graduate students are invited to submit their paper of at most 4 pages
in PDF format, including references.

Papers should be formatted in the ACM Proceedings Style (double column
format) and submitted via the submission website
https://hpdc24-phd.hotcrp.com/

* Important Dates

- Abstract submission: February 19, 2024
- Paper submission: March 1, 2024
- Acceptance notification: March 25, 2024
- Camera-ready version: April 18, 2024
- Conference dates: June 3-7, 2024

* PhD Symposium Chairs
- Valeria Cardellini (Tor Vergata University of Rome)
- Marco Danelutto (University of Pisa)
