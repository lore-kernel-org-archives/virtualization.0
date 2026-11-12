Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509409;
	b=t16WXhwBgRUjJnQudu4BRGP17QNkswZSMUKftDNvOCkBqPDr9ZWG8CX1Ltzuzyoz08fM
	 26Bre6kOYNaa45TkPm2MsueEjMtM3VflNGnsB+3VrS547n7HOjnXbFQWjVleT2ClMsByF
	 f+pV8aeTGVnGsoKWau3F8gszUAVfDsmPzf0HCEnXdehpGZnLADtQt2J++DzGuFvdAhdD0
	 TEFOaB3kDSnP7TC9O7emxmkhE5ier/3zU7D7/JBDrSzrXbAqgH0TgX3NihFqhZILVlovU
	 7RP69AYV1dH3b/y4j+pRPpVTa88IA3yCSxzVCxBflXXPIfq0SV2pcvdHbFrgGJJwTmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=A9nOSUHnoWfXTIdXQxyu3WLnnOXc0gekJomuF8p6xT8=;
	b=xTUwY/rI/uK2GI4rELRNt4/Cja6QIEG+/ZxC0XMIs9y5u/JC1HDTnNzmNElhpFKmY3m2
	 ZDYv0+dJn+3sFoLXaUxvRZkjKHtwt3xwqv5715nmyDaNBIAqrrIXkzMPNpNpfHzH6+m6S
	 sue/K5h1k2CvfQeJFSJl3qrmu/VIHBNAS88lHsEWenrN25a/LRSUMiM6vq9hinKpPOZdc
	 xLFBaeDBj/0lsYYGqybpBjyE3X3KOG0POCCZRKs5yIwoTTFOAtea0o+SiL5EH+YtoCt5T
	 GRpuAWhrwdfV4glFk2xFhrborHPdo/KcBXCFHPXjhWG3WW/QnuZ1uAI4PzZzkzoCP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYHBSodA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFA606A327;
	Thu, 12 Nov 2026 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYHBSodA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F3F1F000C6;
	Thu, 12 Nov 2026 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509408;
	bh=A9nOSUHnoWfXTIdXQxyu3WLnnOXc0gekJomuF8p6xT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MYHBSodAkMetau4H255rXTndq7VAQ7Xtou41f3JHr6HfyIDwSW3qicFr/NB71BBQZ
	 qjzipRxQ3bhmCXNwvcZ7ZecPVPuYcxcy8tCGn9ec+cOma/h12284N0JKmjKzQuvfKP
	 IWrzeqcw4x2eJwj49I6S6ybppvumM9LtvjJjatb9ioWIsZNK7KPFRQ9rX+sxzEE0WJ
	 Qgbfa1UGOf9E9KPXJe6y6RgZppcjRsoBlZnfjNmYNBSccuYAweeQYZCZUdXNoPd5UC
	 lhyrghr5MBbFH5ilVDVs642rhZ7A4KETqR92xAovruqoOlDUL2zGwzbXVEp8D7qCb1
	 TxD444MCL84pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4460391AF9C;
	Thu, 12 Nov 2026 18:50:08 +0000 (UTC)
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
Subject: Re: [PATCH net v6 0/3] net: virtio: validate outer protocol of UDP
 tunnel
 GSO packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450940753.590019.2399738283360917229.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:50:07 +0000
References: <20261110213628.3476051-1-edumazet@kernel.org>
In-Reply-To: <20261110213628.3476051-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, willemb@google.com, horms@kernel.org, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 hassansultan@google.com, virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 22:36:25 +0100 you wrote:
> virtio_net_hdr_tnl_to_skb() does not check that a UDP tunnel GSO
> packet really has outer IPv4/IPv6 and UDP headers matching the
> declared tunnel type. A guest, or any tap writer, can send a frame
> with another outer ethertype (NSH in the report), and the GSO stack
> then builds segments with skb->data before skb->head. The host
> crashes in skb_under_panic() as soon as a header is pushed.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/3] net: virtio: fix UDP tunnel GSO header of VLAN tagged packets
    https://git.kernel.org/netdev/net/c/9e244f94128a
  - [net,v6,2/3] tun: clear stale skb->protocol of NAPI frags skbs
    https://git.kernel.org/netdev/net/c/3287cd714a85
  - [net,v6,3/3] net: virtio: validate outer protocol of UDP tunnel GSO packets
    https://git.kernel.org/netdev/net/c/73e08d50eb13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


