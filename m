Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAEC15666F
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085006; cv=none; b=Tvy3cL979xgAay2NCOdegVPYZkyg/gP98rFe4zPXiGDYgH8kLtqrr4y95GwSKKiG3S+zmfEm8YTLPtg7EPgCPo5abpbdJ4AFTKI6ZaEkmDmGm/SQEtTiJegQKMVWopCJqIzmwxoZpTBSREmI3epOjwSKu3oG79UmUlBrVMHRTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085006; c=relaxed/simple;
	bh=zdLuVH84OGqw7RgBSDevcy3yPUi7yV0lCoRUme7EejI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UKSEcTmTD6s4NgVvaUgbM+p/WQSYZ7d+6s4X83/ybihewLBEKxGzbjIN1eASdBO9T8X1aruxFFVFTFJ0NanRItaJk2cKMTqUA6wgblsQfyqlfS4Iz5Np78BHaHRNJwIDFkq9+Qadp8bcNFfLNTZDoJbjqot2WNHiLk9BZeudrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvAUAiqd; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvAUAiqd"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30517612E2
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 22:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UDSlCx7Rz6d for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Apr 2024 22:43:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5913D612D6
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5913D612D6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bvAUAiqd
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5913D612D6
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 22:43:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 275E361B33;
	Thu, 25 Apr 2024 22:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3742C113CC;
	Thu, 25 Apr 2024 22:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714085002;
	bh=zdLuVH84OGqw7RgBSDevcy3yPUi7yV0lCoRUme7EejI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bvAUAiqdnVhUoT90KfLZoWMIloxHKzb83Ho6Ug5u3u4adNoK98VmNcbreqHLpVLxI
	 wWAOF9gnHljJyfDMX66bL/iG4rY8JT+AtpyhrLchQvZtd8tSQAfR0hk4tFEF5RfqCn
	 wXX2IwopietaS1EZQUVdiMswdkmbTKj625nvueY9RyJ2Czom69c0qrs5tjXThrcb0+
	 +3w1enj398oY/YVU7oFeoBQ4MYxctgOV9KjZ/zo+FuSgm+BDO8/PhtMhzaGDgzQxMi
	 Ms4s48fxQRLyLQP2xCgsbU6hxP6glFC/QDKKfs5YN2rtlhN33RUGmmB4HngCh+0xNv
	 oKRoDTXIWpvtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAC5DC43614;
	Thu, 25 Apr 2024 22:43:22 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240425180106-mutt-send-email-mst@kernel.org>
References: <20240425180106-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240425180106-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 98a821546b3919a10a58faa12ebe5e9a55cd638e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c942a0cd3603e34dd2d7237e064d9318cb7f9654
Message-Id: <171408500275.32202.9237906041561329048.pr-tracker-bot@kernel.org>
Date: Thu, 25 Apr 2024 22:43:22 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lingshan.zhu@intel.com, mst@redhat.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 25 Apr 2024 18:01:06 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c942a0cd3603e34dd2d7237e064d9318cb7f9654

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
