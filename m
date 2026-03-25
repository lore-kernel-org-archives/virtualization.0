Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FA1428F4;
	Wed, 25 Mar 2026 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410618; cv=none; b=KWyhXbCDO41ZiwyMep8GIPMuf+xkctK/JPvNb5CmiJPGc2PKr/fA2NGiPLImiyF4BSpu7xPYssehGLGGP5ZM0yy01qurJn8IcDu+h5GsqNSKEyunTMZbsQFYU9eefiXZDZhXm/ItLP/0qQano9W3GAo8vjiCm8KliYwZtA+AS7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410618; c=relaxed/simple;
	bh=y9MIOuw2Ly0TzHzNpn7/wuF3fbyAN9ULuyr4UQBY41M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=puIfdvQsCsixcCSVVW6sqKg9IK1iqA2ClBQRd9+dul5iSdZc8cNQzWuYfp1cNQpDMezSby7kmeUElO1uDmsb3tyQf0Ktj26lKszxFmbDEhHKbvuYXVpKo8Zd9P5Mc0GDcgxTKqqgPsrux+pBIboohOapYdjOXaaqMAzwXBv1GDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGxLgyeJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGxLgyeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85065C4CEF7;
	Wed, 25 Mar 2026 03:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774410617;
	bh=y9MIOuw2Ly0TzHzNpn7/wuF3fbyAN9ULuyr4UQBY41M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BGxLgyeJI1UHCLzpRcYdH0I7SoOusC9G8Gs7FBhNT5A/t/CqZ2F+f3Q+gVqVfomuy
	 cc35IO1RuNS37M+8QCvceqLwnS8VUcrC3qVpSNQWW9Ib/sHZDAvKsyZdVk9mcpCAgi
	 W8vJS6zLecrTsH6YldYKCb2uCpc2X7unNfC2Aqk9RzCvG4vuotlqcuMlivoPmvuf71
	 n0+UulWuT0TGm32LoTsmFoFT29STFMA54BEBkO1i2LymXnced/N/u5XIyVNq3ix1c0
	 /KTcsrAXYznfssln2q8VZg1HD6zx0CXgHAXAia1RXlrWxqSUuYgTRFQ6SidPzEYZz0
	 vFD022Ovcyv/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD833808203;
	Wed, 25 Mar 2026 03:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441060504.1414050.1860151290582447060.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 03:50:05 +0000
References: <20260312025406.15641-1-xietangxin@yeah.net>
In-Reply-To: <20260312025406.15641-1-xietangxin@yeah.net>
To: xietangxin <xietangxin@yeah.net>
Cc: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 10:54:06 +0800 you wrote:
> A UAF issue occurs when the virtio_net driver is configured with napi_tx=N
> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> (e.g., during the configuration of tc route filter rules).
> 
> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network stack
> expects the driver to hold the reference to skb->dst until the packet
> is fully transmitted and freed. In virtio_net with napi_tx=N,
> skbs may remain in the virtio transmit ring for an extended period.
> 
> [...]

Here is the summary with links:
  - [net,v2] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
    https://git.kernel.org/netdev/net/c/ba8bda9a0896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


