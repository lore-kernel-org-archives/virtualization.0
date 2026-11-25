Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575606;
	b=zFJRLhRvq0r+LsUQC/+D1du1hyGLzcZiOgorOmXcDBT3qdunLwsdDAt3oBPsXpuDxWEX
	 r/OfsqcJ5wxHpHL49i3F84vBYzDrqutmoqICRy5p7kfkP420ZR54fypo0+fxoJB7rNtCg
	 BjzDBCSsC7I0sOC3YEVy/UoDPXvBGuARnF/DRnhk6P3qbk43N+M5aOK8ANeDUx03I0iL7
	 n583EW7RST38uGyVywQcFqztrcHaAIEOTYZmqvhF82MlTVMGH0wmMvqdajmqUnKYXYL1h
	 MiS9eavAgpEFeZ+VUTeRlHKG0IXGzv46e6Lksv0omOEpISXhALBq5ArFalokLaJeM8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=iNklBZQrLHYGAqU2RpzMvGdWtQQExSe7/qvrXqs5xNk=;
	b=P03OEGaP0idNce1wkB/TDf1V87elqu1U/8OY6z4UtunoVnJnJ+MtdOHzVHJP5JKkodZz
	 k1Ia5uMTh+EDYttEZ1OAjp/ApGTMt//UcbKyNUK/0JsvPJG+X2p0U8nwNY09c7yjeBQ4n
	 qRwCA8Zs8VpVYG7cdWTNDepgKRtjnd5um7d5R5QDj9+H+UGkyYDfsweP9YFlUki6Ym7CM
	 jV1Ug0p4hPIMN0Q3pDcrBZXM1xwwkSDHOjWrxC5TFbeCCqHz+2RvtUAsOMFWRkI6qQeqr
	 6qQpnOAU6bRJmEv1xoF5qAcPWkxUfoBw1wpeiEbakF6rEba1QFC/5SMFaIflalip92Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdN4Lxkw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8A606A327;
	Wed, 25 Nov 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdN4Lxkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434051F000C4;
	Wed, 25 Nov 2026 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795575606;
	bh=iNklBZQrLHYGAqU2RpzMvGdWtQQExSe7/qvrXqs5xNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EdN4LxkwehIXVwzDyk+waCsirGjFWxfQDyUjxTugKiTk3t8wJ5SlSPJGs700sJ2km
	 NNOyIU2Xpic4Amx+rkqJomUo6QnaD7cSooxxVJsaxT2kQbWbny8dbFw1fQBLY63S9C
	 n9QSuchTj3Au+/yM3fVyDsag86y0Cl6MxxIpQB3L45kBfOAfx4wJOcZyLKU3nejZTO
	 cXX8s4wiXQa5CFM8gCHjz6skHibdHZaNWKN9m/g5SjD9gcA4EKWD7R9sLGMqijd0gN
	 ZPqK17+TMEV1xwM+2NlvhDl+1GU/G0FTfHeMFu0BwEoHM5dXNSUKa5fc1X768ZAES2
	 ogkpSIIyuAQSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3793808209;
	Wed, 25 Nov 2026 03:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v7] tun: bound the NAPI receive queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179557560477.185420.5263589507960471697.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 03:00:04 +0000
References: <20261119153056.353156-1-antonio@mandelbit.com>
In-Reply-To: <20261119153056.353156-1-antonio@mandelbit.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, maheshb@google.com,
 peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Willem de Bruijn <willemb@google.com>:

On Thu, 19 Nov 2026 16:30:55 +0100 you wrote:
> With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
> an unbounded list. When the poll runs asynchronously (threaded NAPI or
> ksoftirqd) and is slower than the writer, the queue grows until the
> system runs out of memory. An unprivileged user can do this from its own
> user and network namespaces, and the queued skbs are not charged to its
> memcg: in a test VM, a uid 1000 process limited to 128 MB caused a
> global OOM in ~6 seconds. The socket send buffer does not help: tun sets
> it to INT_MAX by default, the build_skb() path is only used while it is
> INT_MAX, and the XDP batch path never checks it.
> 
> [...]

Here is the summary with links:
  - [net,v7] tun: bound the NAPI receive queue
    https://git.kernel.org/netdev/net/c/cc7fe6e74173

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


