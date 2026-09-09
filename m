Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86323AAF41
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Sep 2026 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979152; cv=fail; b=gT8TE9Lvr4FY0xs6VsEoU/xC6lupRnV8ps8EwEIZlhKJIOYUxZgg5QFiGE5JybH1SvjeFVJ2Ow/M7BrsWrRYRPiI8hhwiY45EZClvlp0sm7gs2vxEqOO1c0YAb7bmH95cLXO8+IBSPxAL1BGYbUEOnIfkBBckN651RITEYJNTho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979152; c=relaxed/simple;
	bh=Nw9KAnbZf4r9Qnp5kADDzg6JMDKcvWJMmbfOuqXIlmE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hKC2y33kSH1/RJ6K2Nbi1uFITA/WquLSVwwCxeb1QjQ2xr7fhl9iDdlDpaDpOE7nLVHHmK6/3M4DqYZ/a/DVqegBLetpYBNHiECQXk9izEoHtNLneRGtlqhXsEHQI62ibnbarZ2FvJ/XRbdts6281VbEIeHZShOlLDTr+TOPC2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RewST8Rc; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RewST8Rc"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBB8E81007
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Sep 2026 18:39:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.352
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LVz36ae4MUhC for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2026 18:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EF25D8100A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788979149;
	b=d+ZHA4tb8Wpe4m4g2H5FzPrzjNb0At5kRlxSWGdsnr98fIJHwTmF3VG4Jur0hWKiq+RI
	 L1IPtYsk7upquMEgMBKznP2Tvw69dA8x97CBqvcsjhEh3lbDQGp8N4K/mWDY6TtaznZB5
	 ND0TSaX+6ySxoyCpPFXknhV3iDDMxEhVL2qxuR6uV1e/gZbqMPT4Jr97mQP9Lx8WMfwKq
	 AYxYgxt6DsWyVu2vMrE3c+7jUu4BBgc3kW0ALFtyQVl/Hy+JwJ2nn9MKFOm8r5Y99tagM
	 tfBkgoP9unGOiHxDDI3JA4JVMdGq0miIKKyOADXTYs3MWSa5MLfspubvKQWB3OWbUBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788979149;
	h=Received-SPF:Received:Received:DKIM-Signature:Received:Subject:From:
	 In-Reply-To:References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=4U2dqUB9rYju9cGE8O6PTrlGgiUtfu8eS/aeTlHfcVs=;
	b=bgf2hDpmDmpy+9VkOlglyHDjEL6MVLAF3jxa4cnJ2F+cYil+ApylaQr7e3jdrnWjSPZq
	 SjHh+Cx7gILX1RBVHRsKHdo+PdJZ2u6TS0hQZVP5VRau5ClKECMPsN4P0DEOofvS8I2Cv
	 f9RRwMCUmyAA/3Cjzuj5OnQPKNZfqnoHw8pyDZq9H7YDyR54LnVGPGjTnR5/beC7Xio52
	 bC7lHLu4o16jRMYq5wcksBpkTEA1sP/eaELfJ7VY57l0592pkbEjYujDMEAHHVMUqKA8Z
	 xJbvrreOpqVgeQscQ4BqXactQMmVKCec1Sqbn+snO0jpQnvZoXJpEVOw+qiC247jeFQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RewST8Rc;
	arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RewST8Rc
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF25D8100A
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Sep 2026 18:39:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AD0A4601EF;
	Wed,  9 Sep 2026 18:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A461F00893;
	Wed,  9 Sep 2026 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979146;
	bh=4U2dqUB9rYju9cGE8O6PTrlGgiUtfu8eS/aeTlHfcVs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RewST8RcPI60gGZzPlDKPNeyQNRvWZJtrm17xtCNXOt0pv+9zkAu2+8mzs1qEGhki
	 S1C+B02O1ee8degPKbCw1unLfz0TohfvPYkihQRXDe2+J+BifukYmLZAcUKWtuSvFz
	 jNUqEgJHvDz46SGKPZOmM6xl4RDwsPNveykBrfIBUoBphEKV/fbpr7/dmd6nTfoXRg
	 te62lNFFjs+PQ739b0k/SheX58NZIvCbMaAAYD+TaCz9vk0MzBjdqei7ZpK0rPvZJy
	 4Fsum+A0DiHLHQ2J60zWiNcQuI031qhVDW/XzW/Kg/bYbqHaU51JROEQ1JYLtEvfVR
	 JdmJ/OYjVG0mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AD2380AA52;
	Wed,  9 Sep 2026 18:38:05 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,vdpa,virtio: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260909054245-mutt-send-email-mst@kernel.org>
References: <20260909054245-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260909054245-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 48a4ee65e677559776349128e6a81a6041986c99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f3989d75d33414389a57e78f4979931a0164df4
Message-Id: <178897908417.999556.12078163197648897722.pr-tracker-bot@kernel.org>
Date: Wed, 09 Sep 2026 18:38:04 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, astellman@stellman-greene.com, dongli.zhang@oracle.com, eperezma@redhat.com, graf@amazon.com, kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lvivier@redhat.com, mst@redhat.com, nikhilljatt@gmail.com, physicalmtea@gmail.com, xiongweimin@kylinos.cn, yuz08559@gmail.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 9 Sep 2026 05:42:45 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f3989d75d33414389a57e78f4979931a0164df4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
