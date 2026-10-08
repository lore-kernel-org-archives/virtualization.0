Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99274C4F69;
	Thu,  8 Oct 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485415; cv=none; b=fzQ8YpppK7WS36aOuqGiiICQ/6zckQGYjxNcpUgaBY2TzRoWcUiEdb1Ed7e9f6vqG0MZE7mlDOmCeZhquW8flY7SaZP00sfoBCwQCqXdASvBLWZc0oOL1uHuib+ApFGqQMN85Vw5Zw7WZTBSNR9Ghr0r84giRN4nOZBpJ3Yv7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485415; c=relaxed/simple;
	bh=ngZiPFjVCInN0a7DMiqtmTuciWagZL2I2Wkxfr+I5Xc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UjDazt0kvPKXT9qPwXxukGjrr1iK9yrBFC/pdKhXwP/FGX3QqvTnwntJwL9un5dPtTIUDSL7V6OFDMOzYvbrxNEEwFu8tROjnxvgKqxKYYirIruy+GHdstmCv51MoM3H3c1y/UGk4xtnjlUYFYAnAXY/DajGgwOivFvQSL9nEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh1mQ6Oo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh1mQ6Oo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809771F00893;
	Thu,  8 Oct 2026 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791485414;
	bh=pmry3YDty3lArcuGan9FsXp54o5p5qJgi78oNfIItuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mh1mQ6OoZYAHZ5zhqEMLIZw1L2lHiQyBFK38fUrG+43U4Mcn47S/V88S7GYPBdkCH
	 +VlV+rk2IyEhNcDK3U6jJYGyMkHdz+Rs2Bjipo4vO0QqeR8cA63WDuzBPuhJLKUjh+
	 curJr94aEjwxaxHqyMjrhb5iLlqdoKBR/HHZREVbpFt/cysy3CB62/KSuNBKF38kee
	 sG6v03eUP1ZnX2+tPeziIlUkm3F6El/7RIYP+IMkYduZusw1RWauWDvFnYCiWmYvA7
	 3r381/TAKsJsX5zDyK5TFEl08asG/kicvxQ8oRlkgA2l41M3HSzoral+vg2oqM+UHw
	 5x2slw1cAy0hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7751D380CEC8;
	Thu,  8 Oct 2026 18:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vsock: Fix memory leak in
 vmci_transport_recv_dgram_cb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148541301.391001.8349992685770043645.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:50:13 +0000
References: <20261008144046.90853-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20261008144046.90853-1-Ilia.Gavrilov@infotecs.ru>
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, georgezhang@vmware.com,
 dtor@vmware.com, acking@vmware.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Oct 2026 14:41:17 +0000 you wrote:
> During the closure of a datagram socket, the vmci_transport_recv_dgram_cb()
> function may be called, which will add the packets
> to the socket's backlog; then, after the receive queue is cleared,
> the __release_sock() function will move the packet back from the socket's
> backlog to the receive queue, which will lead to a memory leak.
> 
> sock_close
>   __sock_release
>     __vsock_release
>       // take ownership by user-space
>       lock_sock_nested
>       sock_set_flag(sk, SOCK_DEAD)
>       vmci_transport_release
>                                       vmci_dispatch_dgs
>                                         vmci_datagram_invoke_guest_handler
>                                           vmci_transport_recv_dgram_cb
>                                             sk_receive_skb
>                                               if (!sock_owned_by_user(sk))
>                                                   [...]
>                                          (!)  else if sk_add_backlog()
>                                                   [...]
>   (!) skb_queue_purge(&sk->sk_receive_queue)
> 
> [...]

Here is the summary with links:
  - [net,v2] vsock: Fix memory leak in vmci_transport_recv_dgram_cb()
    https://git.kernel.org/netdev/net/c/7c24a4e87e21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


