Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795139408;
	b=tL4W6rfbLoKKm5q59vrto3T3VHFhJXYQ1NaiFu3NKfMpjAn0cOk2HA2+atmDGqIBO5Zp
	 nsvLYwKCWmQ54R4HXWVPUzi1LoXVoYnzOoFq6k5TN4fQv6OHi0EUrc9a+ophJvADB2QzJ
	 kemx0Eb6UdM7NyYSK6ANGVhF/LvRpvmH/8RGmPFWTkl9N+L+b0LKUtAjucAoBlDHuBLb9
	 MAOSInikCFuHkLjnxGpedpCzLokWkSMMdi5Cv4HWrodCTVPhzXYuHpMXnV6UYhyjLh/nP
	 ZKsFRDlXXo4au4adoKb18u7GIrxGNI/wNjasKf/gJIns1vPiTnANhnVAC8NhktvlF6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795139408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xkeQUkQ9MaTrapcq04cr0AuQZjWL0stDXUyA4Hvb8Wc=;
	b=ulrINpncWxlJu0QLu3NngG/dOgWenCxg3PkJJ8RChFBe9Ufqp1f3Ksz6t0KffYwlDS9+
	 BROt7lIFDbDEVus6FTJ9JrJu0XVXq3iQlQKPN9/V/+BVaLBVK4o98JCcmoFBAHj38U0Rn
	 VeFPQQFZCaswL0F4UqTj7accgdeV+iwWh2/H0qfA24FdqJEBy8iCfNRwCb3dhV3ZIpgIF
	 Z5LrdKJd7JZrwXG7wcMZs8lPh0G/eG6gvO9uTDoTO9QDTOONTyXQwepE1V4WM6iBN9T0b
	 F/E5yiMPwRihsBZdC2Q3TOie/qFGyD107vs7ci8jk2j58kNXuj+dHo1MEd6DbWSvf7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HiTsf+1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF4606A320;
	Fri, 20 Nov 2026 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HiTsf+1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076FE1F000C4;
	Fri, 20 Nov 2026 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795139408;
	bh=xkeQUkQ9MaTrapcq04cr0AuQZjWL0stDXUyA4Hvb8Wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HiTsf+1O4NSnNqpeZcGKpQLdOE8YUP9pEoJyyXRbh2s3l6ihClIb345qrp/14SVI5
	 zWZEprNn6J7VlQVeVMKZH1xeyUVlEEYmubYMeSfLNkGvfEeUSt6iPR0dYRqgKjdfZE
	 o+QRlRU1IS2xfa8ES7VRMAavD977tlKUovvZaS+kVCJft2yTGAferomrObpkBlYCIE
	 oqX66AE4Do3q5L8rF5bgcIxLaRfXMVFcYwDetqq1uINBG/EXcKBHiM2pRwEsBSMzIN
	 4OZb1SYxSPj/wCYpONsTLqI/me3gVIp/3lKDEZnWr15KtvrQt+8nWp9nOCAhcD5i8c
	 yXx94t7xmU4qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15773808209;
	Fri, 20 Nov 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] virtio_net: fix out-of-bounds accesses and a
 heap
 info leak via the device stats reply
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179513940678.3975042.856875230562263797.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 01:50:06 +0000
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
In-Reply-To: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
To: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, michael.bommarito@gmail.com,
 shina@is.s.u-tokyo.ac.jp

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Nov 2026 18:24:41 +0900 you wrote:
> With the statistics reply, a device can make the driver write past the
> ethtool -S output array (patch 1), leak stale heap or loop forever
> (patch 2), and read past the reply buffer (patch 3). Patch 4 returns an
> error when the statistics command fails.
> 
> Claude Opus 5.5 was used to audit the driver and draft the patches.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] virtio_net: reject stats replies for queues outside the request
    https://git.kernel.org/netdev/net-next/c/8c99fb84b512
  - [net,v3,2/4] virtio_net: zero the stats reply buffer
    https://git.kernel.org/netdev/net-next/c/48147635243a
  - [net,v3,3/4] virtio_net: keep reads of stats records within the reply buffer
    https://git.kernel.org/netdev/net-next/c/96b229723bb5
  - [net,v3,4/4] virtio_net: report a failed stats command as an error
    https://git.kernel.org/netdev/net-next/c/942d862f65b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


