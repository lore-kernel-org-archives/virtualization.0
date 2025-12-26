Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EC1397
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Dec 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766778790; cv=none; b=R5LXHE5+h5o2Kct9OLFDOtp8FQYUVzSYG1z9E30LGPqwhv+iC/VT6VPWt74cqACbTY8FwKKwIPmeUZ7nNMJzsTSx1FomXnZmnqwRxj6CP24QNQq3ZCDGM+oTpWGNfqsueWgRbpFAdOYc73rLPCN5A7ku2XhJqy2jkiTTaMUU4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766778790; c=relaxed/simple;
	bh=hgtHt1Ym0whBpm/tq4nMQqk5Cv8h2rFacLOvCET6REQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hvmWnVVe7IBNCqJ8q0iMlXafF3Mbm10YXTSBwtRn++pL2s2ao26iQzkiym4qxBk5eGxFWMUCnqEieccrnuKBiugOgs2UbAsSSSQKxy+CDQLLrf3WoqcEvxL9TPd5kc70t1ivRqltilT+KXQOZzyl/2M91G4VHZv5nd1s62T5Dp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ8XNy9m; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ8XNy9m"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED30280985
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Dec 2025 19:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uccnlijgkUrJ for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Dec 2025 19:53:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2314680978
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2314680978
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LQ8XNy9m
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2314680978
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Dec 2025 19:53:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E60E60007;
	Fri, 26 Dec 2025 19:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB980C4CEF7;
	Fri, 26 Dec 2025 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766778784;
	bh=hgtHt1Ym0whBpm/tq4nMQqk5Cv8h2rFacLOvCET6REQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LQ8XNy9mCVSG2KbDXj+xs2Y5Fsq5esHCXbBg55Pwads/SxzWu9pHITm4NPg1Xkzoq
	 GQfNx62DX/KGifPmO9s3rAqG2HbQoGKe99aAqIwaSbeNll4CmFshpKV4mTPi0/bSQ9
	 nAgOsXvkB4ewztrGutdBW9Sfn2gjnyR8BS1LnMbdzkwFvgUzSQ4w6EkuD3eoI+6szn
	 3tsy6SK0yVBUKDFKIMp0MJB8yw9szNY1XUCBr0GbeDhsVn/J2Qw3P+9jDeKsqGyqb/
	 o0QmgYElea4AYpsj0BZQn1sQpITMOH7hY/Lb/kIFVcPP3S4WRdBlHWEqS9DfasoKuL
	 P4kuiLeykwOHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78D02380A959;
	Fri, 26 Dec 2025 19:49:50 +0000 (UTC)
Subject: Re: [GIT PULL] virtio,vhost: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251226093606-mutt-send-email-mst@kernel.org>
References: <20251226093606-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20251226093606-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: d8ee3cfdc89b75dc059dc21c27bef2c1440f67eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f0cbedc86cfc93ea869bbff420a2d86f6373f57
Message-Id: <176677858907.1987757.13007166201967025863.pr-tracker-bot@kernel.org>
Date: Fri, 26 Dec 2025 19:49:49 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 26 Dec 2025 09:36:06 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f0cbedc86cfc93ea869bbff420a2d86f6373f57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
