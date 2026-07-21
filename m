Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CF44E04C;
	Tue, 21 Jul 2026 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629240; cv=none; b=rhrkSp5HYMoR6doYQtiVVxz5EB09gXR2YOUIHT7pTAtxUZqb1VIUPpIOGW9ziMywEauJS6xYH/EfHQ6zWi0XlDPaWwDYQxTrpxXy58IIVnmSMZHoSwqqWlwvGHWCr0xA2wBhrNEYYmeufOVK3iGjsZWmAHyrbXScpU8peyxlBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629240; c=relaxed/simple;
	bh=0Fm3sWDL7mGlcpEagS6QdEDCQyEdPi1oLKlyh/WzVgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cHo6NYBfYouAsEW1/NWmWozmTGNPTUDkwc7O0WQjnbus9lqUrkBoXyL6gt8gWLHAb0nGnHyObK6TwEnXG+JRHR/S9BrBHscTo/zyBNyITUpQqpR2U24a5VHlPQBr+3UPqssTBeLEGqW12fbYWl08INxw06AfuqxFiEgbcX7C1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnmDkgPs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnmDkgPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C781F000E9;
	Tue, 21 Jul 2026 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629239;
	bh=NZjF6IslAshXnUX5uCvSeC1uxCOQg61zL5aJFvaJmKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HnmDkgPs7fZ/nrohqcaYKz+y8JbEjFZT3OtAMgAoMg1RdFsOtxxqylOXmNjzSQFrI
	 gHuW9hb3RaVNl+ymiABFGhMw/41L03JWxdC/r07NHR6YXrnGly7qhQYX4xN6ElXOxd
	 ebJsFXrL62x2AvM1q5tPy3kVYyfIdxamyK+oX7mmvYIOGSj/HlbSnhWo8l7RvxRo/e
	 cSbE5BnhYRH1z7ThNaAOREUo2IeQLS6HaFkPEeHToUPaQ2tGqe1fVu20OzUEGB41Zq
	 JAzBX7eBPUIKaxxMT29L+pI94ozC29GWujm94yDKfHgtG0G+ERxY9vfEqxyJ6k4z10
	 8BJjlRcHZLG7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A203924A61;
	Tue, 21 Jul 2026 10:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] vsock/virtio: collapse receive queue under
 memory
 pressure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462920939.207636.7054657083618402533.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:20:09 +0000
References: <20260708102904.50732-1-sgarzare@redhat.com>
In-Reply-To: <20260708102904.50732-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 edumazet@google.com, eperezma@redhat.com, horms@kernel.org,
 stefanha@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 mst@redhat.com, kvm@vger.kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev, kuba@kernel.org, jasowang@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 12:29:02 +0200 you wrote:
> This series contains a patch (the first one) that is part of work I'm
> doing to improve the tracking of memory used by AF_VSOCK sockets.
> The second patch is a test for our suite that highlights the issue.
> 
> Since Brien reported an issue with his environment (based on Linux 6.12.y)
> related to the work I’m doing, I extracted this patch and tried to make it
> as easy as possible to backport. Brien tested it by backporting it to
> 6.12.y, which now contains the backport of the 059b7dbd20a6
> ("vsock/virtio: fix potential unbounded skb queue").
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] vsock/virtio: collapse receive queue under memory pressure
    https://git.kernel.org/netdev/net/c/2a12c05aef21
  - [net,v2,2/2] vsock/test: add test for small packets under pressure
    https://git.kernel.org/netdev/net/c/30c82aa0a8b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


