Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847046D2BE
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878687; cv=none; b=TW3bYUWiLqX0DnnYJVNB1/nmjRnmtpGIiRe5rhzx5Fg3NpiJy5NxAbHHwEuDD0HDtlJNfwogYdKqAyuWf+XQHIbMGZ3UqS3UbYR5UpjtA7AXjHy/si2G4MHCk0vfgREu9wQ1Gu+yJc4aGghx6j0AeVuMyOMt/fcCk3SdB9DImTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878687; c=relaxed/simple;
	bh=6dl8OSg1XFIwh3f39Je6VMfFapVo5mv9XzWgUhjWrwk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bJY+zWiY7Fdh3M5+KN1BRhFbddOSx7cJ8sUumLgUyZmyVPmQ3t3iWfY9ZNQVaKMpQz5FPfxMe3vwChNKYeXtIHFcSbLUP8gawLFXXUp5n19FtNQDtA+Hs6bM8FzuII0EGGA3Or+0nk7rop63BxhwlsaG3/zrT4TX/0EX/zMN0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZAqWE4u; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZAqWE4u"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCC1740757
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 21:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K-HAmC4tsc5X for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2026 21:24:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2F02D40755
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F02D40755
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZAqWE4u
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F02D40755
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 21:24:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 17F8441AD5;
	Tue,  4 Aug 2026 21:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9A71F00A3A;
	Tue,  4 Aug 2026 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878683;
	bh=Q9c4Uy+59nf+0whCDDdw4y4B/NrYM64oav86QXjz8G8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iZAqWE4umkFufExEJQhVYR2zhJDtJ5vzdTRK62M/OXXpOZ4ieVKr13xc2T0gN3ftI
	 lnMWfVqRd1TQlCyz4xCdXymbxppCrR4KB95rFki416g6Wvx7g1GnRWg/N3zqu7SLmw
	 XVvsguuPNYoACIoASLDsFXRmEvTHtz3Woav2kHkmv5Ibg6ucVylzfcNPiBKK1S3NQC
	 kNNd1Gz8lZtOohfRVsKnBzlJOiWLcWsGMyiOJFl2PII+aUnS4V2hckW+OwafpsQwA2
	 VYEiar5Vw5OTG9KG4dni/ENBkpPmncAiHOdh6RBhLkAAKWs/0fy8nxWa4g1+gHJrl3
	 G5TwO+UZnbtbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A5C3926648;
	Tue,  4 Aug 2026 21:24:04 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,vdpa: last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260804170624-mutt-send-email-mst@kernel.org>
References: <20260804170624-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260804170624-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 42bc45df5905e2b7dccb72adaf7730f66cfbe03f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c21bb4193868a8de71fc4693fa741e195fdf5d86
Message-Id: <178587864330.3792733.10616267372223041264.pr-tracker-bot@kernel.org>
Date: Tue, 04 Aug 2026 21:24:03 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alhouseenyousef@gmail.com, borntraeger@linux.ibm.com, dtatulea@nvidia.com, junvyyang@tencent.com, linfeng.sun.dev@gamil.com, linfeng.sun.dev@gmail.com, mst@redhat.com, physicalmtea@gmail.com, slf@hdu.edu.cn, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 4 Aug 2026 17:06:24 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c21bb4193868a8de71fc4693fa741e195fdf5d86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
