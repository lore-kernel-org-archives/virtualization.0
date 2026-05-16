Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0832B9B7;
	Sat, 16 May 2026 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892592; cv=none; b=nUrb8GrY86XUO9H+ZZehfJfIFVd5EZF0trfXOsv7X9vSyoHbYvnzFg/3860innZQASHxe6JMCniRhrkUK7ZvmuQbgO2N4eanEJAaoz4uCxFrF4NlG2R1oZs5MByHEJeUrZJAX+gVkwDWdmz5lezC0tKc4UYBG/efAJarvPxO2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892592; c=relaxed/simple;
	bh=tA2shOVbv4GgzVa8Tn4+Kh87n3JU8yXKFhl5SgbT8oE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P0dkIMCouQjB5ivG/PrKu8EOAZsF8AmH8q1mir8BnHGCV1Q9nKwIThOYLhZIdGa0VNrqEaV8vPxibYDOUA1RQH/CXAz+O79XWvQKBVIb1izHCjJ0scYb+Zanjk47ZHn2KdJol3dVznbcvxarbzyxkZte/uP4XV1MQxUsprM5DKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH5T8d1V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH5T8d1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681A2C2BCB0;
	Sat, 16 May 2026 00:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778892592;
	bh=tA2shOVbv4GgzVa8Tn4+Kh87n3JU8yXKFhl5SgbT8oE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jH5T8d1VBSZdfXX1QY3tv7bQjxwtswIgotZRZkEmrkzU10jdB+0/735S682IeJxeQ
	 eWy++PAG/R2QERWutEe0zd4Wn0sY41F2SKK89AkIanjPxW8D9gOK4uIHP73AE0fTb2
	 zBGWRpZlR6gunVHu+MrAwDpZv38VObOg87SDnEwpUUm9IYfNZgkGjl3oihXs6Jx4Rq
	 1stbAL+uW8iZRM7QH6q4yentrE0VzaM0jsQYtg7NTU7v0wtVAvJm3bJFD5Vx6ykoh6
	 p6+Xu7a45is/8MiRtEM37jJ+M72FGHR+F0e56fABNw4BrcGvRIAux3u9Km6sp6phxl
	 RLD7ry1ZEzwWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A303930A23;
	Sat, 16 May 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889260564.211703.14782557985631128714.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 00:50:05 +0000
References: <20260514092948.268720-1-sgarzare@redhat.com>
In-Reply-To: <20260514092948.268720-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, avkrasnov@salutedevices.com, stefanha@redhat.com,
 kvm@vger.kernel.org, edumazet@google.com, eperezma@redhat.com,
 mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 davem@davemloft.net, jasowang@redhat.com, linux-kernel@vger.kernel.org,
 maherazz04@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 11:29:48 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When a large message is fragmented into multiple skbs, the zerocopy
> uarg is only allocated and attached to the last skb in the loop.
> Non-final skbs carry pinned user pages with no completion tracking,
> so the kernel has no way to notify userspace when those pages are safe
> to reuse. If the loop breaks early the uarg is never allocated at all,
> leaking pinned pages with no completion notification.
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: fix zerocopy completion for multi-skb sends
    https://git.kernel.org/netdev/net/c/ae38d9179190

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


