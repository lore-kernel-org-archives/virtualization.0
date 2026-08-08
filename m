Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658830D41D;
	Sat,  8 Aug 2026 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151459; cv=none; b=Ziwn7ueD8MC/HsKsZlv7kVoYNZkuMm8TKA/uEVrqVJBwjeY1tPmwAaU10twKJbMXrgGgPRX4GV5vgefwHvh3ZK0WK/FDAVoCbszdlZxP4+oizdiCBA+zY6T4RZSsGvkR2BmiKv2YvlzaiENI2r1ZHSO8qk3yAXH8rLafHz6Lt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151459; c=relaxed/simple;
	bh=PTbxKVIMuTxFmnFB91dToNzd5VLn17JR7Wl3Hzeon0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NnKJZqCssqrW2XlSmXEe9XyDQa/5CLtFH61BiHujG+UShGdBXXfpb/lrmA375vjZvZS3Dq3CLp+tJEMyrD7Yqvr9V1PdFxiFdDTJ9/fhRWLFSaq1plUVrEZR7ueKoil3Kbs3uxONUeaLT2zrNjs3WDKKe/Lhr5Ex6TZLniwTcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNf6VfdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNf6VfdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740D01F000E9;
	Sat,  8 Aug 2026 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151457;
	bh=9USWE24ySgryYfAxS+G1GhPrYCkhN1Ame0rUzvDT4vM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gNf6VfdD8Fobjp/EVlnHB294zVCD4kCZFmd7dJWjv9GnSf1SMgbScAqzkl18sW/C3
	 W7KqJz8zPOR32DthRD2XUxV/3yteQl91jBH65vTPfGGomg0u6pXffxekNLypz0WOXv
	 ryhEv38jgOgf3lTLFQWucf9SIzZ5HOmiPdxIpzjcTuwFEdFGaG2u20kGaFdrUABnjS
	 tQp/vWAYGyfo3O58vn4LwG6YN/JcI/nWbWqn98R+rReUi+BcWaiQVrGNEhH4LKPiQK
	 iQVM0pUs94El0L9jkgMqrGvnuGKsNkaOc3Vr/e/mAGNe3o+TGFCfG9EvTFzharS/EY
	 UoIIZnyL3RWzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BAB380CEE4;
	Sat,  8 Aug 2026 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 0/5] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178615141563.2487956.10160071466888547898.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 01:10:15 +0000
References: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
 stephen@networkplumber.org, jon@nutanix.com, brett@librecast.net,
 corbet@lwn.net, skhan@linuxfoundation.org, tim.gebauer@tu-dortmund.de,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 20:36:36 +0200 you wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> patch series, the associated netdev queue is stopped, but only when the
> new IFF_BACKPRESSURE flag is set and a qdisc is attached. Without the
> flag, or if no qdisc is present, the existing behavior is preserved. The
> XDP transmit path is not affected. This patch series touches tun/tap and
> vhost-net, as they share common logic and must be updated together.
> Modifying only one of them would break the other.
> 
> [...]

Here is the summary with links:
  - [net-next,v14,1/5] tun/tap: add IFF_BACKPRESSURE flag
    https://git.kernel.org/netdev/net-next/c/485e38995cc3
  - [net-next,v14,2/5] tun/tap: add ptr_ring consume helper with netdev queue wakeup
    https://git.kernel.org/netdev/net-next/c/9b990ae358b3
  - [net-next,v14,3/5] vhost-net: wake queue of tun/tap after ptr_ring consume
    https://git.kernel.org/netdev/net-next/c/f65c1fb427aa
  - [net-next,v14,4/5] ptr_ring: move free-space check into separate helper
    https://git.kernel.org/netdev/net-next/c/43be21ec2efd
  - [net-next,v14,5/5] tun/tap & vhost-net: stop tail-drop when IFF_BACKPRESSURE is set
    https://git.kernel.org/netdev/net-next/c/d00c7369ef24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


