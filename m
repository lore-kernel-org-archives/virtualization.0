Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7015665C
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Dec 2025 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903858; cv=none; b=er4/1cP3Nv1Jq57ZsC4QFXBztbRFI01hfSvtKyb8Lju0GtBy2VIrpJXA1iLWxGf+H1Eerx2LZZP8POPJSR4eI6LICAdBu8hawrnU86lbXrn0UXj/zQR60/PRCvgZxduqmU5rQLdrcpHdDqW7RqubYwP1C4I54bU16uIa1MhK0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903858; c=relaxed/simple;
	bh=/JQhc3V/qRD89UuPy9qhr18vhsDsM0Qv0lDC34gPhfA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o5oTErs59RqtWzaeUNEIV0/PIpJDnt4HY2ChewAu9/PfVbYzsqt2oje7WhGN8+pR8WXl9clB7Ytu28516yHt/luV3Bmq3AG7qmaHuhpdp1c+kFgPlTNEb1Kz3tJrpr/flQgAYygwlrl+tWlmQCdNSzghtaQR9yBjmwQs8gIrXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2sp4tge; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2sp4tge"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5A20408D9
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Dec 2025 03:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hHywAVldbsL for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Dec 2025 03:04:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 212F74048A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 212F74048A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e2sp4tge
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 212F74048A
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Dec 2025 03:04:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5DDF343EA2;
	Fri,  5 Dec 2025 03:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6C6C4CEFB;
	Fri,  5 Dec 2025 03:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764903855;
	bh=/JQhc3V/qRD89UuPy9qhr18vhsDsM0Qv0lDC34gPhfA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e2sp4tgeeJSkYr5EtF9YWosF6pstypUhquLr0xATJAoeMJypK13d62wtPyE/BuuF2
	 bZaSzllReiPlqMfZZmouqsVIvKWlVpN1cL4vRQwzLDXi3xmuxYrKGhl8eAIoHvCDcu
	 zmzzh73fg+2vjcuhHvW/xc3Dt5ikfOOnftACx5gd1w6pSUNtf5TQA6fGXV8ADClTSG
	 NAW3lqtVtP9ZVI4qsNh5OMz9eGo/AYL2vkEFI0NzbiY2PgylwHiZHugcS6u5oKtYsi
	 5Exje65zuax5F9jfiUdULVcy6LI15e57oknLU5rpo5aRXyU1E2CMm3JSAeZgnQB/tc
	 IOkM0rBuyRj3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B043AA9A89;
	Fri,  5 Dec 2025 03:01:14 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost: fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251202150721-mutt-send-email-mst@kernel.org>
References: <20251202150721-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20251202150721-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 205dd7a5d6ad6f4c8e8fcd3c3b95a7c0e7067fee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc69ed975203c3ffe34f873531f3052914d4e497
Message-Id: <176490367301.1073302.8927903391156784773.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 03:01:13 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, alok.a.tiwari@oracle.com, jasowang@redhat.com, kriish.sharma2006@gmail.com, linmq006@gmail.com, marco.crivellari@suse.com, michael.christie@oracle.com, mst@redhat.com, pabeni@redhat.com, stable@vger.kernel.org, yishaih@nvidia.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 2 Dec 2025 15:07:21 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc69ed975203c3ffe34f873531f3052914d4e497

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
