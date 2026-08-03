Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C769345CCD;
	Mon,  3 Aug 2026 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785801079; cv=none; b=GyHf0qMhgUInOVKA8ycjdLRsq5QP5urFdXPvUT0ZDsyD0D3pS3Lq7MxYnhZgjF+HzPPiLxFBqClgKPt8Exh1QjQS/2OqqmVoXb/n7NtOQO5w0/a6lqzW9sM4+gGDDdk7akfN1+Km+GpB7MKdUQYie5cV08Kc2M9f7IqhKYmo0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785801079; c=relaxed/simple;
	bh=4+NWCndIlI3Af6U3MgwKrToeARcnbP2pH/RpXhkWeHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cqi6PrrvOGQT3UfVMNW/hZdhPUhkxxBYcrnGV8nhOPlYGMtP9tXPuwt+X/o/8Rsd5CxLpLTfqZOv3thdDnL+siPyji/FBvKyfo0ANccnGf6FPcQzE66eNFXChK7cXP+l98ebcRwdQtzj1NITRPLMgbJVHrfaRfX/KY0LjcGwS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz2wcvPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz2wcvPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711F71F00A3A;
	Mon,  3 Aug 2026 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785801065;
	bh=8dDV+xQcfg8sDZGR+Bj/sfNsLBssczM0NZnv2WaDSdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fz2wcvPVKmZzlpzqQykgv7MyBQSZuvOAe/SyE/9guGyttT6h7b1z1TioR3h3ir7OG
	 W4mY+o7UhBFoz2YgIlZH2JPN/kFjk6tnLATGFUQ1s+hkjujhqTg3vkpQzCyDME0zcU
	 w31e4p9pD/y1Vdd2puAzD1W5W6qtTU9wwbwxZCJL1XpEqjeEq4CCyPUw1vi/ePJUzj
	 oeBgjNuL2ySXJeWiVZgnW2M1XVHsppkFqDUPF7FufRVZqvfriE40R0Ik99H0G7qHLj
	 YnB+jHQukDN5QAcHqyN4yBKuumWDD7fJ7bZTZLmm58T0A5H7utROsl1bgarl7TJ9sf
	 9MS4Tag/yG3+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BA63924467;
	Mon,  3 Aug 2026 23:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] vsock/virtio: fix worker access after virtqueue
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580102614.2881314.2071869667851695934.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 23:50:26 +0000
References: <cover.1785352330.git.bestswngs@gmail.com>
In-Reply-To: <cover.1785352330.git.bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xmei5@asu.edu,
 bobbyeshleman@meta.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 12:16:53 -0700 you wrote:
> Virtio-vsock workers can remain queued while freeze deletes the
> virtqueues.  This series prevents workers delayed across freeze and
> restore from retaining pointers to deleted queues, and prevents the RX
> worker from refilling its queue after teardown.
> 
> Changes in v3:
> - Resend the series with proper email threading; no code changes.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] vsock/virtio: read virtqueues under worker locks
    https://git.kernel.org/netdev/net/c/ebac8f6b1ef0
  - [v3,2/2] vsock/virtio: avoid refilling the RX queue after teardown
    https://git.kernel.org/netdev/net/c/a31e0ad44469

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


