Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038013C9DE
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Jan 2025 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738026413; cv=none; b=SlJE6Ke0MuCMjt3hC3Z6td+oypZj+d4Sdty5R5KxTJUjSkCZSXWdMCWElFoa0VmPVBFmKqPeWm2ZRkFJKADHUelOII3Q1hSCN6dAG8GtuOXOxZnZ+y3clJAb0DmiWJWTpcuJCYWNd4mIIDQjCeLa+pgadwwJcNkOjWV0wTjhN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738026413; c=relaxed/simple;
	bh=g2QvMiT5LUVcP9OrA0RXuReUPgCnilj54mqxus/bMCI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qzuDPXyngAobL6Y9JO5CaXc45lTxarq1mQYvdvVDTQAYb0aVaZUv9JrwFiV7/dXPwsufWlRLnlW6THvSw78fIta5DdXsYFRoKDXRBN0x8QOFEvdvZDjS9FQ93YPC8kbfJ+Bdgd3PFE+xmv2fk0GJud5EPzO24nEh5TGN63W5RA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1LISSgy; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1LISSgy"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 784CF405E8
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Jan 2025 01:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -10.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TnujrowsDCcU for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jan 2025 01:06:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8C65240582
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C65240582
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n1LISSgy
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C65240582
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Jan 2025 01:06:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0EA8D5C5B6B;
	Tue, 28 Jan 2025 01:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE052C4CED2;
	Tue, 28 Jan 2025 01:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738026409;
	bh=g2QvMiT5LUVcP9OrA0RXuReUPgCnilj54mqxus/bMCI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n1LISSgyLEpO/HQUoAZHZSjx3otHAyJjrw0qLjl/TKvV+YHKGmtIrJG9n0FAVTt1N
	 cMoKIn9/z4bTjFm9puxzImMC7gWXbto2O6PceHR7vQj9Hed/RO4CBlsMffKRwsck73
	 XyWG5TGoKHiUlgB8VPDKAE4yx8HNSr/zqtebigiZx1xzbnDncZOmacwHMJjL46kdVf
	 DhatUM+kOLMr+qIGRxgsjmhzlG6zxCPLsalMoi5syfsw2+DQWyUk4H4hi8uC6G35na
	 UL6O6oZT//TgpVIW10vqvlAA2F6rGulb0JhbKydFSAlQ10ytrZFur661THvdrvFdqc
	 Dw2mqeanivqbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02B380AA63;
	Tue, 28 Jan 2025 01:07:16 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250127095138-mutt-send-email-mst@kernel.org>
References: <20250127095138-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250127095138-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 5820a3b08987951e3e4a89fca8ab6e1448f672e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: deee7487f5d495d0d9e5ab40d866d69ad524c46a
Message-Id: <173802643525.3281647.14447011836115468769.pr-tracker-bot@kernel.org>
Date: Tue, 28 Jan 2025 01:07:15 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, akihiko.odaki@daynix.com, akpm@linux-foundation.org, bhe@redhat.com, david@redhat.com, israelr@nvidia.com, jasowang@redhat.com, mst@redhat.com, pstanner@redhat.com, sgarzare@redhat.com, skoteshwar@marvell.com, sthotton@marvell.com, xieyongji@bytedance.com, yuxue.liu@jaguarmicro.com, zhangjiao2@cmss.chinamobile.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 27 Jan 2025 09:51:38 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/deee7487f5d495d0d9e5ab40d866d69ad524c46a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
