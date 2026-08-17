Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2213EEAC1;
	Mon, 17 Aug 2026 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005855; cv=none; b=fqhwHWdJzhUa909a/xXCeuHZvGeA9rcx9Kte49ogtveHwjmH38MqNVE91lp+mBfr8xUhfCyuXg1TeyeI5ce/jOc4APVFCAkg9IWkQygUEpUMKOcsuYzBcH36QukYtYqz7lHbaWKBz4eYg2608bGH+djKFEgzRIGOrhF46dYn5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005855; c=relaxed/simple;
	bh=BEyr+tPldOJT8Ie9U2Kcvs0eHELDcQUqZId2oectqMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DCiC+VXbW/S4YFHU+uL2nmT9QtBXZLPkkIc8FlWAhloKwli/HfKzLuzDk2KeLvQorghLoGxftehoxYjfC8Yfku2h83HoJmZQs1sVcRFD0bbFIQ8+HJNn5v5psCeFJ3dn6HawIqr7zm3CIj32028PPYrdfmbzt9us9tvH2mZ8bf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D45Ivp9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D45Ivp9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FE31F000E9;
	Mon, 17 Aug 2026 22:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005853;
	bh=n6+C8RPRpCGeF/VrH2Mcf3sJSuqZ0WRUi72c6ZRIPew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D45Ivp9DdE+TCWJzONNf7igneT53vkdRae7Zm6yDaTBJIxyceQr95jqBqoNwN6cOs
	 8k4TeVM2/gqstA2ZBLboWTnDm9IaC9VaZbGZ7nm4veN5ABZFcXU7YbLgFi97VlwHvQ
	 jyEDnYD4J977vectL/ESxu/eFurp8LX0Zu0QcdMSORlhPtDsUgubk4lttGs3WOBw/M
	 b1wvGJWIU4FLzdqxb+NPWbrxWcD+EAuXEgvOXxRU1x2dV7ATwNK+GnRLUzv8S04Wm8
	 IUxvgVpYJb/51yMi7JmK69Rba96IQXK0BK+ZOdJAgTirBet3lAWoEtJtTG9nx4chX/
	 nG8k9E9ahN2lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A673926274;
	Mon, 17 Aug 2026 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] virtio_net: Fix resize of the RX ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178700580564.1772138.12429357713894347188.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 22:30:05 +0000
References: <20260810120728.47445-1-a.s.protopopov@gmail.com>
In-Reply-To: <20260810120728.47445-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Aug 2026 12:07:25 +0000 you wrote:
> When a AF_XDP socket is attached, the virtnet_rx_resize
> should resize the rq->xsk_buffs XSK buffer array. Otherwise,
> when the size grows, the virtnet_rx_resume() causes a write
> past the end of the array. This is easily reproducable with
> 
>     ethtool -G ens3 rx 32
>     ./xdpsock -i eth0 -q 0 -r -z &
>     ethtool -G eth0 rx 256
> 
> [...]

Here is the summary with links:
  - [net] virtio_net: Fix resize of the RX ring
    https://git.kernel.org/netdev/net/c/d09c98a6da21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


