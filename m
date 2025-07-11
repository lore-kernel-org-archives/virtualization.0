Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F81B0421
	for <virtualization@lists.linux-foundation.org>; Fri, 11 Jul 2025 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275408; cv=none; b=KM5zUM9u6trp0e7KOULFMwjUxud81rydlFtVFxriBtCUx01tUbmZAepUZzmPlaVJzKDVA6EseDe9ym6E9HPSbZOt8eOuKQP9B6I644YDUL4dt8aJJGfyjxcxb+Hw3MGCec7j87J7WhR+pX52wSVywbXZ09lDMf3F66uxXBdOCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275408; c=relaxed/simple;
	bh=tKheb8OjsLoz5R8RDmCIXx68KmbGB8ishC8u4d7w0qo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a5CqWfZfVh0RgSJk4NTEXKJ6G8Qe0mZN/MctcqQTrJqtPGL4Tvb7fDtXkguhOY4sM82Vuvv4httrKCLMPMqs5yXBanVRCWO5oNU+/yDWP9f794wJv1Ry8pcbEWZOAnrSnnZNgS2QvTtBKzMYKmX5H7D8csViIOgKXxSWVltt+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBAmpCav; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBAmpCav"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 757E840553
	for <virtualization@lists.linux-foundation.org>; Fri, 11 Jul 2025 23:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id npkTHt2mS5lu for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jul 2025 23:10:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D2CC94053A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2CC94053A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kBAmpCav
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D2CC94053A
	for <virtualization@lists.linux-foundation.org>; Fri, 11 Jul 2025 23:10:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4D3A444CA7;
	Fri, 11 Jul 2025 23:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24270C4CEED;
	Fri, 11 Jul 2025 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752275405;
	bh=tKheb8OjsLoz5R8RDmCIXx68KmbGB8ishC8u4d7w0qo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kBAmpCav8UawscICq11TjS1xmaXivlfU+81KKNmwlAUucB434hpKWNce49BNAGENJ
	 t0BWHZvQhzA2vKl0ZqGW0RN7nXeYm8U2FgvcUOQZrMyxgDB/SxCXp2TDmQ92zqBczL
	 Yaz6CBLDRVuTg2GIZl1qSGZ6+L4HKXhzK8RzJ81+sxdMRCBA311V1FZuhnSJ9k5is4
	 EO0F4eWSedKzpb0HPY+rZhVDS4OesML6S+vsi0sgVoszDTNyMHT0R9V5Dyff+OBvBL
	 kBazLcyn3YuKD7ihQH0+lQnHvjbZPZX+cQVtrCAHv13sR9tEgxBuQo4xLCHg/U2XCt
	 KgOKKx7x8CURA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7D383B275;
	Fri, 11 Jul 2025 23:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] virtio_net: simplify tx queue wake condition check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175227542702.2429127.17012200251961296918.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 23:10:27 +0000
References: <20250710023208.846-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20250710023208.846-1-liming.wu@jaguarmicro.com>
To: Liming Wu <liming.wu@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com, leiyang@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 10:32:08 +0800 you wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
> 
> Consolidate the two nested if conditions for checking tx queue wake
> conditions into a single combined condition. This improves code
> readability without changing functionality. And move netif_tx_wake_queue
> into if condition to reduce unnecessary checks for queue stops.
> 
> [...]

Here is the summary with links:
  - [v2] virtio_net: simplify tx queue wake condition check
    https://git.kernel.org/netdev/net-next/c/2f82e9954662

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


