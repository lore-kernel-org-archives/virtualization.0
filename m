Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50822DA03
	for <virtualization@lists.linux-foundation.org>; Thu, 29 May 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536777; cv=none; b=WqhAu4uokvbpuZ2kCkjuko5TQgttnVgMU9g0brZFUsPa9oOswAB+cUiVuiqojMvlGXCeVbyc305Bz5t6o3XDokEhBYcHPUsAQGnGKQexMBEXbujLj4TSz43EUzakXDVSTvqso5YvxpG/TveLfCT3EB9QjLPE+fM76/C1Wc+k1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536777; c=relaxed/simple;
	bh=AV7mRmu/eJ0wXPouJqUI5yuujO4QNYzfTIJ7tqJ+ZQI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k8/vzpONdwViggm0uUVi4w/Mx7H7L26ywVBFK6Efws83wBzO59NHtQJcrRJZ1W5Bhm1llYthldQgoBttXdDvQVZgI6DHEfFMlpFZL0N19qP+5Z2iLFiYPBoxqeaov4qPUnp8TaJHu/ug6OCacjijUaGbKUyV8aq2+hebJ7MRW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTTNDLYb; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTTNDLYb"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41BF2614BD
	for <virtualization@lists.linux-foundation.org>; Thu, 29 May 2025 16:39:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eM_vnMjLPB2H for <virtualization@lists.linux-foundation.org>;
 Thu, 29 May 2025 16:39:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 83A9161463
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83A9161463
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XTTNDLYb
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 83A9161463
	for <virtualization@lists.linux-foundation.org>; Thu, 29 May 2025 16:39:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1350EA4FBBD;
	Thu, 29 May 2025 16:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78857C4CEE7;
	Thu, 29 May 2025 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748536773;
	bh=AV7mRmu/eJ0wXPouJqUI5yuujO4QNYzfTIJ7tqJ+ZQI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XTTNDLYbJQ5htcIEwZrLRwO+/Y/Hbf1U/LyjubxjR1zyrKnl3+EWuuFffUagEOmqK
	 5bzY3FPryDQTIEStuxG35aqzA/6lx8mp4D1DlAVNbe2eVnRw+b0nqQx2aMqx0CUUbd
	 u7xaR6cjy8LIKGGA6/3ss9lyVrdh5elbpoZCEp9AcfcS6XoGOqlDcp0gNQtSdFUN8Z
	 wDU0srEkvOYTxhPxwgKEfnx5NIJarMmJI2QrrvLOs6WXSt6L4r+4E1qbawQOp+MES7
	 IV/+wjvUhg09ubVL9cQqna+vBxcU7R4fjZ93cG9AUSvJU7zQSQBOvccimWfbsQuGs2
	 mn+zLM2xsUWgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7134A380664F;
	Thu, 29 May 2025 16:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] virtio, vhost: features, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250528032724-mutt-send-email-mst@kernel.org>
References: <20250528032724-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250528032724-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 206cc44588f72b49ad4d7e21a7472ab2a72a83df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ca154e4910efff1b04e7750e007d75732c68323
Message-Id: <174853680707.3320073.17659236547655577423.pr-tracker-bot@kernel.org>
Date: Thu, 29 May 2025 16:40:07 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com, dongli.zhang@oracle.com, hch@lst.de, israelr@nvidia.com, kees@kernel.org, leiyang@redhat.com, mst@redhat.com, phasta@kernel.org, quic_philber@quicinc.com, sami.md.ko@gmail.com, vattunuru@marvell.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 28 May 2025 03:27:24 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ca154e4910efff1b04e7750e007d75732c68323

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
