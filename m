Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393D28DD1
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Aug 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968740; cv=none; b=L9Wp3rgZRLmoURsOEod2/cUfnevShqs39ULOE+4cNZlp4wUA1+CRNRRAQtRoqMDaZ5QJTlGKxx7NKwSs3kGvxb4P5J9zH9mlc7e5PB7VdKPLTFdntPxBsSQ+cJRO7OXxTiu1kbBFKG9SZNzIsc3a+s21jKrxAcELeomi2zssuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968740; c=relaxed/simple;
	bh=iU42ztsF59RemOZGmfY9bIY+jPcLw4R8DUsI3VzS39Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T0rLmzzD+9XCKd49vX19HMayquWBwrMV7MN7CMLZWMMmAOuKWOavbIfj9EdfeFy2nYOoYYoSh+tcV8z4MANYGddR4Jxio8LAd3aTgHFzvTRikg3JpRqwkiPMyHE/vTPcGsnwnoIeW6Ait2pQmkPXefQBDsgqvQEw2Qy682HBq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuLFwHdB; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuLFwHdB"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9104C80EFD
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Aug 2024 18:25:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rYThRD0q9FR2 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Aug 2024 18:25:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7A11D80EF5
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A11D80EF5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HuLFwHdB
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7A11D80EF5
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Aug 2024 18:25:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0E481CE0B2C;
	Tue,  6 Aug 2024 18:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DB8C32786;
	Tue,  6 Aug 2024 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722968732;
	bh=iU42ztsF59RemOZGmfY9bIY+jPcLw4R8DUsI3VzS39Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HuLFwHdBoQA2ubJAqanE2ACb+DrYwGWc/hkRREtpq/34TCH/0pHBbQ3FEVm/C7F7t
	 qwtcgEPysgBxWIIQdnqRb0sancQfuhFz1Dvs/1yfTv7lfXCqzzKa+wW1Phj7JoyGpg
	 lxizAKOfUUcFyl4U3BUWr5aDGPXlFwA/rl1KO48tPMbxCFdXMmWHPogVLSHqZ0jewg
	 Lh5AozScJTZc2Pj48KLmNky4mH9zcsgedGLKzOFtCENarbR5vvBpQnSz0xoMu4tE5j
	 WOEeIh8FlLjxXMU8qJJxknY1qO9DObu+KKDcEwaFzuEhQSK3jjMFF0sRWN+hUhHLFi
	 gsCEEcVgW2WDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9F3822F99;
	Tue,  6 Aug 2024 18:25:32 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240806135722-mutt-send-email-mst@kernel.org>
References: <20240806135722-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240806135722-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 0823dc64586ba5ea13a7d200a5d33e4c5fa45950
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4560686726f7a357922f300fc81f5964be8df04
Message-Id: <172296873074.1388134.15266811486107132547.pr-tracker-bot@kernel.org>
Date: Tue, 06 Aug 2024 18:25:30 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dtatulea@nvidia.com, jasowang@redhat.com, mst@redhat.com, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 6 Aug 2024 13:57:22 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4560686726f7a357922f300fc81f5964be8df04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
