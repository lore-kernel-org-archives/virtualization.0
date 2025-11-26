Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D053126AF
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Nov 2025 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129669; cv=none; b=cJfzu3bPooZb/Imb4oX6rO33MSgSRENFX1/dN/91qyMGvTT2lCrhOnKaugc0Sh8Qiw4Nwwc4rz7u+ZFudrgseiNs4fPtPzfDd5P1cAW2k2BPD6zTWJBoEL/oixMMk3w2FBwwMnIBvYfcq2rWISNx0o+HE+VRVGojD6vi7J3GTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129669; c=relaxed/simple;
	bh=e66W30nBm93lSeox4A0GZFfHktSjddRZJws2hous++Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rJLR2Mcj1FirORZcIXcSCkbc+Dqkjp5XzS0TbndMvGAFoDsGAmfywkob80AmYkAR8/R52dGO2XXRaCKAO24NpvyrLscXR6xwjlTdMElboagvwM14MKdvCizAGCEF3K3wrhtG9oaIHwtvawfXAiHDDHruuBcCfcrVJEkJnpNSWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le8gsF2f; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le8gsF2f"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89560405C6
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Nov 2025 04:01:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id il5CrNHsYswz for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Nov 2025 04:01:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E84944058B
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E84944058B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Le8gsF2f
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E84944058B
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Nov 2025 04:01:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D6EA044487;
	Wed, 26 Nov 2025 04:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA401C116C6;
	Wed, 26 Nov 2025 04:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764129664;
	bh=e66W30nBm93lSeox4A0GZFfHktSjddRZJws2hous++Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Le8gsF2f2odt9z3fNK9mprG0lWvNfxD3cW4POqW7GXP4b01gf/v7c3NAocSYOd94k
	 v1xh7p8tCFaD0czlXv1X4qTCoR6A+bwg+GebAbRf0bslvjooA79fq+ORbzpi0njNMc
	 YdNQbqu2pSIOIBZ0NLyfpaAmAD/0hYqP0tBSIpj5IJNianCyqBvNYdqykOlLh3I6VX
	 +PEGQ8YdJSR6oxhoh3Dp01MCoi+/sfMrUQ8L4s2nPhxqKHWc627QcP7mMaphAxDeYj
	 1gx7zinW0cJi9MHyYCXEVTYimfFoMFrLvxzh/Uhyqg4cucPvIfB5ea4psiKh3LZ/C/
	 deh1LZD9RuQOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D5F380AA73;
	Wed, 26 Nov 2025 04:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] virtio_net: enhance wake/stop tx queue statistics
 accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412962675.1513924.17474261080340416413.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 04:00:26 +0000
References: <20251120015320.1418-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20251120015320.1418-1-liming.wu@jaguarmicro.com>
To: Liming Wu <liming.wu@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 angus.chen@jaguarmicro.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Nov 2025 09:53:20 +0800 you wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
> 
> This patch refines and strengthens the statistics collection of TX queue
> wake/stop events introduced by commit c39add9b2423 ("virtio_net: Add TX
> stopped and wake counters").
> 
> Previously, the driver only recorded partial wake/stop statistics
> for TX queues. Some wake events triggered by 'skb_xmit_done()' or resume
> operations were not counted, which made the per-queue metrics incomplete.
> 
> [...]

Here is the summary with links:
  - [v2] virtio_net: enhance wake/stop tx queue statistics accounting
    https://git.kernel.org/netdev/net-next/c/cfeb7cd80f40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


