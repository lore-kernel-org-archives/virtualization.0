Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD236E482;
	Fri, 27 Mar 2026 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582824; cv=none; b=gFf2iV/VocNYQ4jkngFMjrcHvDSCEvPcddYZICpbakdrsgUZKzKDaJR3O2YowqLr9g58kd0G/mQ6IXo87pfYjHcx2j6A4WN2OOOWfTz98t0qBDuvxkgiPPn7g9Ae9rL2Hfes6vbhwD9/xfRx7QgMtc1nyUag0zKKyrZXvE8n01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582824; c=relaxed/simple;
	bh=hICh2ybyY8oAWcTzR4MUd/iENTmcUq8gUlg9iQ+i16M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCwCcPHeqdf1lyJCUBUMOmpO3UyUlLJAGzXGLJo1Qr6IkAIhyyqcotMx/L4+atSI3R0Qo0DzXW781AxqoIPZ9qVv49d0iYB4pYFUnlcALOsdiQmWE5tIRt0WjmzqhrNf058F7cixAe03Ex3n10sIFcEGVZRkPPUIMmDv9UBlNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pj+PnC32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj+PnC32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A7FC19423;
	Fri, 27 Mar 2026 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582823;
	bh=hICh2ybyY8oAWcTzR4MUd/iENTmcUq8gUlg9iQ+i16M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pj+PnC32GsQmVFm8YYii6JK0anr2CGyYjo/3rQfYxgNMXayyeZPFn7/5L6YZxW9Bi
	 K2YbDb5rf17LtwlAndo8bcXCGcMoatdqnbNJhwo19DEE0DkoBBaD4Cei/EnIcrmZoe
	 oJc8Wzry3EDqkPUpbUU+cRYSMHPTBIM+uibjr2iSGIHRj4s3YsH7WM5MaQ/B6Q4PCv
	 58W0A+g/fR1rXIugo60XJBSxxCbEZXKnFhKqf0fCmLm4t7+rpbmY16Dof7YSBsnn+C
	 Hv2cTdLMPGhFBb0pP3nQYOn4NZgMdWnpbEXUzbbFIEsagk0JjU/8Dhs+UNl8vimXE9
	 3PX5bDkMo1muQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF53809A0B;
	Fri, 27 Mar 2026 03:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458280978.3288619.10895546782089194731.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:40:09 +0000
References: <20260323041730.986351-1-zhud@hygon.cn>
In-Reply-To: <20260323041730.986351-1-zhud@hygon.cn>
To: Di Zhu <zhud@hygon.cn>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, lijing@hygon.cn,
 yingzhiwei@hygon.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Mar 2026 12:17:30 +0800 you wrote:
> Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> allows control over offload support, but the offloads that can be
> controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
> nor GUEST_TSO6 is supported).
> 
> In such a setup, reporting NETIF_F_GRO_HW as available for the device
> is too optimistic and misleading to the user.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] virtio-net: enable NETIF_F_GRO_HW only if GRO-related offloads are supported
    https://git.kernel.org/netdev/net-next/c/f8844dfeeae8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


