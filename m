Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F92EB84E;
	Sat, 23 May 2026 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502822; cv=none; b=lqtkDJYv2TOZ2rGki8mdTV4PKLKTjhvrpPUjG0xarIpXlr4eMJsbP0cTKCJMbe5vkOj21gh6ocERcZx9AMnh+L5o0yq/cQALqJ5Nmsnl983qZHyW6FyB6vmW24nq/29NIVS+c5KOpJMvc42dyWJQm95jBVOa2nvtPnabj2XGl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502822; c=relaxed/simple;
	bh=TftbvUH9N6EldBCuw32plM2I4zDKKxadrGCnuP27TJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aoqOveR2OBJsCWcJjp8Kq1x9V9ME2KKQ7ElFj3GxeXRRg/at31O3tX44lsUbM19JSj4OdGDlKW3m0OXHc3ki1QfmXolP/c4QL7Rfs6079vguICf3nS7UeSWTZSfI2z9IUeb5UT3PuEA5AzulGOfH+4PF7S9y12V2xs+yS1tKO7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4taf3ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4taf3ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118801F00A3A;
	Sat, 23 May 2026 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502821;
	bh=FCB32I04tXOU3A4ivBWnoocFg6h6DTzbS5mMPphmppE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O4taf3ip4l+MOTs9BgdWuIp8pey+Sz8LYtkp051amHYvxgcmAeBqhbJvbLMJkzgqB
	 Y4rT5yfULhJ0m2uPmfMQTSQ/zeeWBeMUHKO9sRy8oofHlCA9hJbyxqkaWcdSXp+dmi
	 rSyQsLkkYtnnRid2Fy8Ewb9/NiD6J9LdcUOkcKSM2/VEk8gEc3wgpHGw+1hCWjTMNe
	 nFqF+y065qVDHdlJiuiab3yh6wn8BdPGOrfREKOQ/VGCr/SI9Ue7Hdq5B36SFAzmlI
	 HoQg2fYPPtFTDWjanurIIVyrWI7f3Gtwvz1oLeLPJhkq8QjxQgXX7vYANXTkYvlwEm
	 hYj0OW7p77U/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198273808205;
	Sat, 23 May 2026 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 02:20:29 +0000
References: <20260521124732.125771-1-sgarzare@redhat.com>
In-Reply-To: <20260521124732.125771-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, pabeni@redhat.com,
 mst@redhat.com, davem@davemloft.net, jasowang@redhat.com,
 stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 14:47:32 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> to 32-bit values. The multiplication can overflow before being assigned to
> the u64 skb_overhead variable, making the skb overhead check ineffective.
> 
> Cast skb_queue_len() to u64 so the multiplication is always performed in
> 64-bit arithmetic.
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
    https://git.kernel.org/netdev/net/c/4157501b9a8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


