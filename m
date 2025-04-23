Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796E28DF05
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429348; cv=none; b=iSMBICFttXOCNNvB9223s+1CsSva5ei78J0h978zw2+rNUBzGXc8OrOrr2t7Vt3ezIMtco+zPWNghFOPh+xCy4NQyJRBvIX6NJfan6G8eu835Y5UGJTd6R1zlniRMmlvLn6UUI50qCgVJhjgzU3Dj7OEapsOok4/WFpYknBM+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429348; c=relaxed/simple;
	bh=vlh4+BR1H/RmxNREq1KSV9QK1KeKmMVnQikynmcuhwo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PTXkACkZE2tSJVVg67qJV2LLKt1wuF8YT7/C498B4vTbDCubJjKGS67CmXilgBG53/plrCVKkOBZ8rBbfpVhxwUiBodpOzoPLtns4qLyODkPMoPtW29zPJnAO+L0cDKOx1xUPX+qCG8RTdCWdiHxei1Os5hcYe/CllbacrnHay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvatOY7j; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvatOY7j"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDD9D6106D
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 17:29:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -10.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNBRT2xkxuFF for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Apr 2025 17:29:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DC8F360740
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC8F360740
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EvatOY7j
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC8F360740
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 17:29:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 66BC15C5EB9;
	Wed, 23 Apr 2025 17:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA69C4CEE2;
	Wed, 23 Apr 2025 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745429344;
	bh=vlh4+BR1H/RmxNREq1KSV9QK1KeKmMVnQikynmcuhwo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EvatOY7j4yFv4XGVGP3rNEdg/WKME+vsbamFNlzOONW7QA8WC2SVwQYVbLVtItU9c
	 nI7MSrPUcMdNxrj5PaIFmpCudbbBbjLQt6iAzDWDXpjNxQRtwz4BgmqDcIafWyGNJ6
	 Etvuga9n13LB6xyr8GSQH6RRpJBZ7sSqTTZANjmJzHo6SyByVMDMhcqcovZPHMEF4e
	 3M+WqNF1OPH1SMrEiQWRmzTu0gpn1BhvGFJQ9w1pGV14qHGuw+x/YCwTvaijd8fgMT
	 0+tCyJlNXblO+0wdqPfpymr3kcTekTMZtf6NLNIkbUnTgVwqpcLb2/82am44eacyA7
	 OvjXbylSjPxNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D9380CED9;
	Wed, 23 Apr 2025 17:29:43 +0000 (UTC)
Subject: Re: [GIT PULL] virtio, vhost: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250423024239-mutt-send-email-mst@kernel.org>
References: <20250423024239-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250423024239-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 58465d86071b61415e25fb054201f61e83d21465
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0251ddbffbeb213f0f74ef94b2cacce580eb8d76
Message-Id: <174542938258.2710377.13663228633712440875.pr-tracker-bot@kernel.org>
Date: Wed, 23 Apr 2025 17:29:42 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, danielj@nvidia.com, dongli.zhang@oracle.com, eauger@redhat.com, eric.auger@redhat.com, jasowang@redhat.com, jfalempe@redhat.com, maxbr@linux.ibm.com, mst@redhat.com, pasic@linux.ibm.com, quic_zhonhan@quicinc.com, sgarzare@redhat.com, syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 23 Apr 2025 02:42:39 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0251ddbffbeb213f0f74ef94b2cacce580eb8d76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
