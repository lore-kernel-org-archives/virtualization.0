Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874807;
	b=wBplru90nP/dGGh7YlfJzJLPJKc3bLc2NMLyh9ajFh4SnGKNn1mxCqMjveWHvvL6HDNO
	 V2hCi+15gW57DHElCY6jKeard7GKO/U4Wu5mVaEPLiDtksF8Q1OOfEsMWnssOvmI7f5KT
	 g+Q0QGiHPj8+Cak+Hp7V7JsoOKaC72Kq05SGN9Es1uTlUX+KsbhknkvqZwhiEn7rI+TB8
	 51Ke0TE39noY2t9vhY8NqPcvPBaYLtUfAcTyHAx0P3M6A3tkt7XPtZ7dcqaBXHAJIdOJH
	 S3VcYKUmNodR6evOrx9/MbHPUVcCRYxhJCwNsPLAeuPAAgvp4pqGBNIL1Be5kYGoqPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YC0f0CFnTNvYryYxUtUimiX+FDelPcf3dZpNQNi0OF4=;
	b=ehcACL2Vzz/pe4FzTHbVQnUxilkcdn/K2uRE4N+43R5Q7AuDbAaKbesOH5RVxMtV+C8P
	 HRxN3gDdNxtzHLmJrfV94BGH/jKhtE20qiE0D6gOwJAqBKT0SdZJToIf7DTOwCJYo/DeE
	 kJ7FLAxgO85PDbenMlbIc+Qd5TYsbklEj/4u/bqRGOhi9uG98Fu4Whxp8aTnhnBDUBBWt
	 3Lfmg7nitrM+bqzeph8HW9ERCoDjY2qy1ZThI18oCrQrG1pMme6+o1zCF/BBJEHnKThOg
	 Sbdl5fRJhdKcjmA6cQiJlvghEnIzHHArFTm67syholuMeuiKt6ow76RASFdJzH0DKvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQ5MsPkw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B18606A31C;
	Tue, 17 Nov 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQ5MsPkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A491F000C4;
	Tue, 17 Nov 2026 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874806;
	bh=YC0f0CFnTNvYryYxUtUimiX+FDelPcf3dZpNQNi0OF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XQ5MsPkwbtaKe8d00NSxPCD6OAKrunNc+QRDoyviqNZYs08ebk67we41baAgJsZ2h
	 xr/sLWo/CO092gU3aQzAQTvJysQkjXrAg49tqIWdfENtoql3GhutvIf3Mt8KZuscEB
	 AZ8OAW1wX6zjjl5pIj/ZpB1y7m8GrXJC0nNdB2DeUv2XzPWluTcjA6tD4QzrLTI/Tg
	 NKu7B2r7c+Ys8EUM1V6IK/wgTgZ/NaydHfhuR8FTEVQdeNGw/NE/FCr5zUrJHHKQbb
	 smIB7QGSMg6sjhmlGlKpZla6F9JrUQYAt/F647lfLcEIbrTxXnr9ncgQ5qFzaNPc3z
	 zkYWs2pi127hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7736C391AFE7;
	Tue, 17 Nov 2026 00:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/2] virtio_net: AF_XDP zero-copy fixes for arm64
 and
 XDP queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179487480503.257811.3119115367169464801.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 00:20:05 +0000
References: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 00:29:59 +0900 you wrote:
> Two AF_XDP zero-copy fixes for virtio_net.
> 
> Patch 1: on arm64, binding a zero-copy socket fails with -ENOMEM and a
> "rejecting DMA map of vmalloc memory" warning whenever the device uses
> the DMA API (e.g. VIRTIO_F_ACCESS_PLATFORM), because the static TX
> header lives in the kernel image, which arm64 maps in the vmalloc area.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
    (no matching commit)
  - [net,v3,2/2] virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs
    https://git.kernel.org/netdev/net/c/1932779607d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


