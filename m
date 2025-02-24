Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336D24BC07
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393037; cv=none; b=rlCZGFt33qAPxyM7eIdc24qejyKumkIcWvJ4VUNNHK+cjPSSCli/ZtGsr3jYckNhdkoLJE5tYPl4pUk1ZuhoYaBC1zazH1MkyyOl2IG9Zl2EduiTPrRZdTJqxFX0jtR5ucLBiWN6izIhTKNLX++84fdqCgRd7+sor/z7TIx2OqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393037; c=relaxed/simple;
	bh=Vg68Rt+0evcFSSjTW58a3A/RXYo+L+pezfDP3CXzaa0=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=EmDWIpUqB1Xj7TdXam136frK5AE9yH0Xvv4dJNEyRgtQ+GZPIaxBjCJRcq9FYi2kv9w/pOFtJINtxeHVq0f9iukHPdOFresiOFrSshQTjILdhHaufvLoax1HfClijbbKFAtYoVB3Mpwihuq1wDn7VewjGRI2ZFLafaoy51BVVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=quicklogowebsitedesigning.com header.i=@quicklogowebsitedesigning.com header.b=bpw3f1dr; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicklogowebsitedesigning.com header.i=@quicklogowebsitedesigning.com header.b="bpw3f1dr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3CBE540B38
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 10:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -3.48
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJ6BU0TkxJP1 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 10:30:34 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=103.133.214.27; helo=host.quicklogowebsitedesigning.com; envelope-from=celina.jones@quicklogowebsitedesigning.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 13B0240AF8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=quicklogowebsitedesigning.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13B0240AF8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=quicklogowebsitedesigning.com header.i=@quicklogowebsitedesigning.com header.a=rsa-sha256 header.s=202407 header.b=bpw3f1dr
Received: from host.quicklogowebsitedesigning.com (host.quicklogowebsitedesigning.com [103.133.214.27])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13B0240AF8
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 10:30:33 +0000 (UTC)
Received: from quicklogowebsitedesigning.com (localhost [IPv6:::1])
	by host.quicklogowebsitedesigning.com (Postfix) with ESMTPA id C1C6BAB17D
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 15:52:27 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.quicklogowebsitedesigning.com C1C6BAB17D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=quicklogowebsitedesigning.com; s=202407; t=1740392547;
	bh=h3Re4ZyxmIjLjbC3kGNe4/eRd55jarqXuwjXB2zIetQ=;
	h=Date:From:To:Subject:From;
	b=bpw3f1drrFVScFVuoUpwfppxWZ1zczD34JL5POcMZtJuMQd2ogh9FU1KP4gzKxBaw
	 lkUSNECEkX6BZJVR0cQdtwFz/aFoMbew5kNZHQ8avwzfnIpXEW+851jGO7G/Kl+d+K
	 NLrH+dVMaVmPk2OIUzjC5YG8pzujVmm1IKTgLloPewOgKfuyqsKZH6KwtyEebWPz6X
	 uncx2DMDyiDGda6NpNHsth+ciRt//VkN4VvUXsRxf8rNf2qrkik0qWU/TE3TvAo1pk
	 GZMyrZTLFEU+4AwSOhVUEVSDRoQPF4XqIvJ4VNFCpEbGWEfHNQR2REA+1pbrtOvbgF
	 F73IfUalxmeMQ==
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 24 Feb 2025 15:52:27 +0530
From: celina.jones@quicklogowebsitedesigning.com
To: virtualization@lists.linux-foundation.org
Subject: Audio & Video Transcription / Translation Service at 70 cents/min
Message-ID: <2c7a8e0e5f05e2d3457c1d52e9f7e89a@quicklogowebsitedesigning.com>
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
