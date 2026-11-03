Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715606;
	b=4rQNSmVI/fqXMWTS7PCBOrdVDYxCZAKn5AFZhl0kXafTbV+TqKir4If9c/yRe1gYAlXE
	 m8C+q9Ti1+5VHHECo4uoO6mQi4ukdkE22riJkwqHMPHJMSDfwQiWbVvhsp6MNwltyyIYo
	 KSj+SCIliqAKogjQym+Hxqx7wCfim/l4n23q2hIoh6gwhLNLzcA5At8SC6wMdk4SxQnOT
	 cEvi7myGx943t17RSHeFx6wXtSt/bY1RpbrMKB6e5OQ8ywqr9/f70dUevXopmM/6KKSWt
	 ITa7+gCGJvKTUzEaTW9NBv9+zKILKDbwOShT2ilvzwXEWkxUhRAChrnOLyun3NTzitg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2l7sqExqMj4Qy8taKddk/sZMVV6oRyxAHdiPHqn7mIo=;
	b=uhDtj8CabWnAFYpSGgBVGfj5FrLoY48TuaDm0v5deUvhzPSSp0i2pc815anzrqeFXbLj
	 34zzuUYOj2z9Pc+w17o6xpG6JZjAvulaEpvbnmW28wbJ5+RWjnMG8OyKu0qbv2l32rYca
	 Nl8uKIDT6d0m5fWunVbIBMm1Sjs4OD8L4ADC6+fVZOPooI/gkb1uVkEHiBaZ5CppJuzoc
	 HMAd14jrQ6esvY3VmKvRYqEkyxMcB0snNEDVZOnhjU01Vzfc2Rai9gRl8c9BVmZaGIM4C
	 e6tn1VHNMXPsk3QNK95hT/z9o2QhwBdBDOk+La4eoUJEv6yrPrIfVIC9UO6r83vGpFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQtGjWn0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE50606A333;
	Tue,  3 Nov 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQtGjWn0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4241F00A16;
	Tue,  3 Nov 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793715606;
	bh=2l7sqExqMj4Qy8taKddk/sZMVV6oRyxAHdiPHqn7mIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mQtGjWn0tGARjA6Qoc6usSqPUcT1HcPgH1u6G1prYFE0dIXhCQYw/6F931g8cJxSo
	 DTAOmD0JMZW/QLCqtP/1SxhsKpobj7LlFUdLY5wGnO4JGcqv4zPpX0lJDCt0wUgeYL
	 DpvOhBXtIyVNf/8SQNGPaFLo3NlJOX67qm//oSOc9sQl4RgMkRexshhaZAofUi2kR8
	 0SvruGQLFWnbNtrEQuKCtx+IFmmrUXjRze/7Xs4SZNea6JlpeuZMbh28iVfPYUQ0Wy
	 mbhDMPIZgNwQ3yHDj5NqmBpUVHF6Xiep1lpERCYMrl7EQ8w64dcCflcE/82zLvsQTP
	 XLEdYEOBWuP0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030F838007CC;
	Tue,  3 Nov 2026 14:20:06 +0000 (UTC)
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
Subject: Re: [PATCH] vsock: reject negative tv_usec in
 SO_VM_SOCKETS_CONNECT_TIMEOUT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179371560480.1166073.16451930000365691837.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 14:20:04 +0000
References: <20261030064428.73930-1-phind.uet@gmail.com>
In-Reply-To: <20261030064428.73930-1-phind.uet@gmail.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: sgarzare@redhat.com, bobbyeshleman@meta.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 georgezhang@vmware.com, acking@vmware.com, dtor@vmware.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 14:43:50 +0800 you wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> The timeval validation checks tv_usec < USEC_PER_SEC but not
> tv_usec >= 0, so a negative tv_usec makes the timeout computation
> wrap into a bogus value, later tripping "schedule_timeout: wrong
> timeout value" instead of being rejected.
> 
> [...]

Here is the summary with links:
  - vsock: reject negative tv_usec in SO_VM_SOCKETS_CONNECT_TIMEOUT
    https://git.kernel.org/netdev/net/c/c0ef6144b4d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


