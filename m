Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5823F266
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393031; cv=none; b=QOwF2WZwe5fEc5hJ7/ZszG52U5nnxcUMRIc5JiovkwaPusiMGmqm2w8WxvoAtaqrOfk6kfdOFirC6CvD3B7+okk7+haNGcg8udvAYL2Gp/qjxCXj9CpPbBtMwROvGAYPcNkzR0xvpjHEVAQTPqMrHfWgJ1WRGXwviXJGTeufT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393031; c=relaxed/simple;
	bh=Vg68Rt+0evcFSSjTW58a3A/RXYo+L+pezfDP3CXzaa0=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=Z2OJ2X5lQpa4fHIvYOd15cPP9eXEKPT5mrDcaqqO1lwfEtaJRagEAGkXk5M25OyyIabNjocmFsQRs/kw4bnjI2UuYjaOdepmuqSUQJ2zIXyGULGWCwAHE0UXp0LqgAqg+x9030gjr/1g3mCIV/9wuSqlzRjGEN5A3tDssVfC1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=quicklogowebsitedesigning.com header.i=@quicklogowebsitedesigning.com header.b=KBfPQPvC; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicklogowebsitedesigning.com header.i=@quicklogowebsitedesigning.com header.b="KBfPQPvC"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B69260C07
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 10:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -3.48
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5OC5VVXbJz0 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 10:30:26 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=103.133.214.27; helo=host.quicklogowebsitedesigning.com; envelope-from=celina.jones@quicklogowebsitedesigning.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0AC6960BFB
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=quicklogowebsitedesigning.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AC6960BFB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=quicklogowebsitedesigning.com header.i=@quicklogowebsitedesigning.com header.a=rsa-sha256 header.s=202407 header.b=KBfPQPvC
Received: from host.quicklogowebsitedesigning.com (host.quicklogowebsitedesigning.com [103.133.214.27])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0AC6960BFB
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 10:30:24 +0000 (UTC)
Received: from quicklogowebsitedesigning.com (localhost [IPv6:::1])
	by host.quicklogowebsitedesigning.com (Postfix) with ESMTPA id BF9466DF368
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 15:52:09 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.quicklogowebsitedesigning.com BF9466DF368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=quicklogowebsitedesigning.com; s=202407; t=1740392529;
	bh=h3Re4ZyxmIjLjbC3kGNe4/eRd55jarqXuwjXB2zIetQ=;
	h=Date:From:To:Subject:From;
	b=KBfPQPvC/dRD4JXbroOXhb0MnKS3APo8tphLLuJr5vOKIq/nlKi4ZkjeZIjTpAVJU
	 6aqNVGPzZ0JefqsDfGM5O2e3Rlj3cS8hrBg/2T3ct2g1i3wLm9IhB1Wr3kSDpTWE4p
	 CAAVG4CpFN9TbyfkL6L14e/cgKex0hRnCFyJGTPn48E+yFGj6ulRFY1dR8cDYP3TOX
	 xSSPiDW0T8EUmR/rZLc83dK/wNblPkYM5e8uWBk6gWrOqmiH2l2GOEqs3SqwfmxhpD
	 kuKTlacQmqlFcO8nEzZbYemdRgJK4X+HLJJyTD7FLKBgg5+4zWLexxS7Jx8CV4jU37
	 lhR68RXTRT8kQ==
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 24 Feb 2025 15:52:09 +0530
From: celina.jones@quicklogowebsitedesigning.com
To: virtualization@lists.linux-foundation.org
Subject: Audio & Video Transcription / Translation Service at 70 cents/min
Message-ID: <ba855a865624a089724a676a6f016f7c@quicklogowebsitedesigning.com>
X-Sender: celina.jones@quicklogowebsitedesigning.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello,

  Are you looking for a transcriber / translator for transcribing your 
audios / videos ? Many researchers / students are not aware of who to 
reach out to get their research audios and videos transcribed with 
confidentiality.

  We have been working for university students across the globe for over 
10 years now and provide transcription service to students, researchers, 
coaches, news agencies / reporters, writers at a very reasonable cost 
and quick turnaround.

  Whether it's interviews, podcasts, meetings, or lectures, we can 
quickly and accurately convert your audio / video into a written format.

  Our rates start at USD 0.70 per audio / video minute for up to 3 
different voices in the audio / video.

  Should you be interested, please do feel free to reach out for a free 
sample transcript of any audio / video of your choice.

  In addition, we also provide service for logo / graphic designing, 
website designing and development or any kind of software development as 
well. Please feel free to ask for our portfolio.

  Regards,
  Celina Jones
