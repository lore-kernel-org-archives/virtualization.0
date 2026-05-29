Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCF326D65;
	Fri, 29 May 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084210; cv=none; b=YkUihyI86yljpCbOR+jisM5ksr8K21CHbud4k1zYkzWFh6HoEUmlZaMXUJ2jtCEm5QHrvBeomS08NYXqSLA/FIba0UheMgr20hMJzxVIoMpRIosj+aJMSKfTPbC/Pua4VrLTA4AmyDV5i/xsQKk/qyURISC+YUslLnEB9WUPBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084210; c=relaxed/simple;
	bh=h9m+j9PFBQFn2jg1ggcCkZRwuM9t0s8Ey77g12E3lKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tp6unn1vznCgUThcuTS7/GkofL4YWPWhvWrTmpK4m/n0+F0ZF6CrWzDJUropDdyjebMZrFlvQx2mfe2NW5xUe7a4+qd5BbpvBkB6yXEHwmPJnWua+YtQXcYRcjgju9+ktUqkAQeNKjc9ixJj5MCsi1u9CVp/4iOWoytfS5W1brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxLVzFyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxLVzFyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE821F00893;
	Fri, 29 May 2026 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084209;
	bh=2kqzw/5S8xRtznkagGHui7yP4isApl7FIN//Fy8kYw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RxLVzFyPeZjElsREHGsXttTxhzTYtD4t5/C79h9B2c7kVma2bu3x+1Xav4XT4533W
	 IVkkvujT4HDu+wXUjZsFYtfUYzEBfZufD3TkhSlbRHkNy+NROuK+XvZNZ28LSJrdS3
	 CE8OJwZnrDaRBeC3xy0wV15wvfV8ajaiFB4a10X1ZbniYcwVr5YStMLK9oR6dQKaUM
	 Mqm2Brt6OZesHuUprx1eomHAskaO1JAYdk37WDG6JTLIa+HxoetkvPfR/m7fcjjVr/
	 +fJ+4WhGMBxtNuG32y8PaMfw21/IV4bgZN/bYfjeyeP9Umk6tClKVuTRZnAmkVesQN
	 4dV2dCTD4HEyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199E639301A0;
	Fri, 29 May 2026 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vsock/virtio: bind uarg before filling zerocopy
 skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178008421264.1939215.14797550643980385939.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 19:50:12 +0000
References: <20260527023301.1075581-1-malin89@huawei.com>
In-Reply-To: <20260527023301.1075581-1-malin89@huawei.com>
To: Lin Ma <malin89@huawei.com>
Cc: kuba@kernel.org, avkrasnov@salutedevices.com, cenxianlong@huawei.com,
 chenzhe@huawei.com, cuirongzhen@huawei.com, davem@davemloft.net,
 edumazet@google.com, eperezma@redhat.com, horms@kernel.org,
 jasowang@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com, tanjingguo@huawei.com,
 virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 10:33:01 +0800 you wrote:
> From: Jingguo Tan <tanjingguo@huawei.com>
> 
> virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
> before entering the send loop, but virtio_transport_alloc_skb() still
> fills the skb before it inherits that uarg. When fixed-buffer vectored
> zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
> managed frags and return -EMSGSIZE. The rollback path call kfree_skb()
> to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
> skb_release_data() falls through to ordinary frag unref.
> 
> [...]

Here is the summary with links:
  - [net,v2] vsock/virtio: bind uarg before filling zerocopy skb
    https://git.kernel.org/netdev/net/c/1e584c304cfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


