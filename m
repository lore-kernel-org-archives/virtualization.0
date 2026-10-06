Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62296511E6F;
	Tue,  6 Oct 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328831; cv=none; b=PBuxBkuxfFuEDi5eoiQwLpny9BceepUs0fZW8sLd5kJDWz8baoV2wp3E1lmClT8MMtS7M3W/OHo5wH+Xh7pqW3AAMJaKTB3tGsPHZPddoXJhXew4tOzFaMU3u956VXwpT6z1A6inC+nnC9P1EF3ysKZY/SG8TEAWJ/c41N+XYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328831; c=relaxed/simple;
	bh=MlccjQ6MFYsbPUTZWGH4u1xLbLttM+ucA2gZLtShFvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eVi+ON4pj/cz0wIn3grT4sHbid0i76bwVk/P6/pb+dkMPoVy8qH3qm7i11QjCB+BeO7QflEFR3shVzdIm660naA1erR4M7kf+ASy9gsAF1kS0Su2ikhL9BPDZEvh1ybpTjGawUf/aRB7P8kdlN8ObGpOampiIO3EGcwAdp83yws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXsrdOZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXsrdOZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E4B1F0089B;
	Tue,  6 Oct 2026 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791328809;
	bh=h4cGlCZYSzF5Ta4ymfYXfzvigNdpz6wKPqLxEcKqzX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JXsrdOZDA0wqMhOfwrgJBqOL99o6L52oJvbY+YDflps+A9/uWDo4yfRv8pbOKQkX4
	 2GFoixALfBz96nMQbkTgftOJicL8K2ILqInly1jmQYcML6DidNOCfGQuB4D80nuK9g
	 ryN/bJUjWTxKc2RXZsu8A+rdt/pFpa/fIpMjmzvyG0HL1IKCROFyNQPRwOz5BEKsFR
	 TSeJGlpE0ZiVBA7/RRhzqmDXbAl4Z2aPMZ2pmTRiFsMYPRwiXkN56iVD889hu7J74i
	 OoQ3/N/0P9cZ4Tj63t6Bs+CuShsoiVGxnNGzhBaGIhuVLovwiJB2JbMEvM78TYuuMX
	 OF8A74/Uo3njQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773973806541;
	Tue,  6 Oct 2026 23:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vsock/virtio: account only unread bytes in
 read_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179132880800.2823248.5778865641724487663.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 23:20:08 +0000
References: <20261001151310.4101006-1-4ncienth@gmail.com>
In-Reply-To: <20261001151310.4101006-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, leonardi@redhat.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 00:13:10 +0900 you wrote:
> After a partial stream receive, rx_bytes tracks the unread suffix while
> buf_used and peer credit still cover the whole packet.
> virtio_transport_read_skb() dequeues that packet but passes pkt_len for
> both counters, underflowing rx_bytes.
> 
> On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
> from a 100-byte packet made SIOCINQ report -40, an empty recv return
> ELOOP, and poll report the empty socket readable.  After verdict detach,
> receiving 40 bytes wrapped the counter to zero and hid those queued bytes
> until one more byte arrived.  The fixed run kept the counter balanced
> and exposed all queued data immediately.
> 
> [...]

Here is the summary with links:
  - [net,v2] vsock/virtio: account only unread bytes in read_skb()
    https://git.kernel.org/netdev/net/c/a463f55c791b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


