Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D96525A98;
	Tue,  8 Sep 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865872; cv=none; b=n/kqzaSEMq8cPu4JORpA7aPIgU7aZaZwwgL92zD3M+pJSeywLydrHVHnuJMQEv1GBvhjunDSkaIX/si5vZAMEa5VQcIVvrVAtJwLxEg168qFPbTfoLpWjQspR1ab5ZSDdRgyOziGSteJFpZcfIlj37PxKovm/6fTtGnu7n/BiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865872; c=relaxed/simple;
	bh=iXach9ag4pYu+uekrmGnQhNAeFI0U48yMOdGOWNT2hM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sXUG1ATl1XLuFFrRjR+7HLjv8cB3kDEXvGMKZMsf9JTy+t628B4wkQbyw052ovbRrHoZh36UA0E3ihJqwoaeRHVw4yzE5OHdnHtRIa0s0Fs0M6SDdMmSBFNbhWxkzLo377HfmVx3xxuap0sa4dyoaO6UQbDd8vpZb3oAqfjF3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwOypjUQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwOypjUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277851F00A3A;
	Tue,  8 Sep 2026 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788865866;
	bh=qbnLGGQYuGuo6y1fYmSfcg6lEzwVdZor3F+NuT27/A0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OwOypjUQP5r1wfJtlUY/YakQ+j2EzL/w+9GlwRIVwJ5C7QRS1vHPvnn/X9yWWNXsQ
	 Q1UPXwkZnRAJyd61bRZll3CB2Ac27L0CPuaAWoL3QyqUUDz1woVTdkUwl6Cclx8Yrw
	 G9ueyxn4y63wSihBy3aAV+TlaRKnJin4PFObJUdSeSO0OzfcUNxtbAO6qDpWrJJaDm
	 kh5ufX77sqRESXy9/BR4c4UdVwZ8SLyd3ZIostevwvM2p5+Qyq7vH1an/4R4Hn3R2m
	 E8Hftym2cZh1G0OOAyiCbjEbgLM0nIKYaUJkL5jQp7wYBIsSQhLyU8O37rdU/MJRBn
	 1djTfiHq5waMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C939E960E;
	Tue,  8 Sep 2026 11:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] virtio_net: add rx-alloc-fail counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178886580490.3468256.13674396744145035927.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 11:10:04 +0000
References: <20260903022848.33595-1-lange_tang@163.com>
In-Reply-To: <20260903022848.33595-1-lange_tang@163.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, mst@redhat.com, jasowangio@gmail.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, tanglongjun@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Sep 2026 10:28:48 +0800 you wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> Count the cases where the driver fails to allocate a buffer or an skb,
> such as when try_fill_recv() fails with ENOMEM, and report them via the
> rx-alloc-fail qstat.
> 
> Plumb alloc-fail into virtnet_get_base_stats() to keep this new stat
> reported consistently at both queue and device scope, matching how
> packets, bytes, stop and wake are handled.
> 
> [...]

Here is the summary with links:
  - [v3] virtio_net: add rx-alloc-fail counter
    https://git.kernel.org/netdev/net-next/c/6a41ab891fe8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


