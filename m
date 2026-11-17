Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874816;
	b=yhIVLf20b28o3BoQIAI1l8E3kqgzhpO4QwgepZHRYbbv3KG3RMc8WyaFx2YXQOg/0W3y
	 pASohtpUzmSLXZftd6NW2FGmGP2Wgefz/fNf/smINxyZwItxzGVz9dBrMhApQg/4o9ZDP
	 tGwwinxttVNAd78sARIrvWE0WLokr/Adb4S8T8f8rmjA5KoUOijyJ2o5rrYltaYXcilxc
	 rwnYAXl7EOeBooMePqpoeU7TlPWiKLV0gb/Gq2cJDyX7nILLy4gT/y+mjMZMRhKSBpZFQ
	 k7z2uTOVBRB2JmvbKLgi89R4yO0EB5m7l7VdYYxq4T1mD6bxna1p3A9Jj1A6VQ9nm3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874816;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uP7hcZkT230kP7rxF93VkubUnO4lWwFxbpZ6S50BNq8=;
	b=ON3y0EN76MS/Pd2KUopG7mz9TEQW8Ja38Z7ZkAi9xOlpDALRMTZ59/hK/Bgz5iPljU7N
	 MLeyQ8a32hzVCMElSAl+rTNOQQc6DsSbDBQ5mFZJ0PhjSdCAUjjlokb4Ce7X5kb/kjCLt
	 dAiF1jbenOLoirly4KDFlQ1H9z4bq95GdjM3Y4xpDD7GfuE5DVhJ/E73rkcjzTiIE6NYu
	 gtKs++quEWEVfZbaiEt7KWbnNd3myhAwD9mOVYhjmkxtgOAUA5b6F0ZhovwHAX2cbnWn1
	 YSLV4UDPZScW8Wg0sNLTLgVTDQhffgvKU4PlWCWWUOoj2xUct2tdR6WBZ/KZ7YnsG9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgbcV909;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54B606A332;
	Tue, 17 Nov 2026 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgbcV909
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA4C1F000C7;
	Tue, 17 Nov 2026 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874815;
	bh=uP7hcZkT230kP7rxF93VkubUnO4lWwFxbpZ6S50BNq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YgbcV9091h3ApXJGeCwLZCN3HaswL0Oyj0F2hufau4bmHLaeX9Y7ycxUB1oJUaWtI
	 8cR8njJzvRA6CBd+F+KNzOlaxXqsng0gHiyLGe+QwMcxNVs61Vm5W4FsCKmkbzXJAX
	 92lINtoePfXaHtA5OmdE+/zI8yo+p/10hiRG7yTEfoK4xhYLDFZ1u4PimzH5J+AY8o
	 kRXNGdljIta9XPVtbd9HGrMm/7r6fhT9Gm5Xn34J0xpdWw7PqwnuvyYpGJhEGp3nZv
	 uLiVP3zYj1FEWGvfiWjQAWXc5uAuZKgV8bY8CG5mOvDnwR2+tfZBJEUwU6XUvqNzLe
	 hml4C5WKHiVEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43AD391AFE7;
	Tue, 17 Nov 2026 00:20:15 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/2] virtio_net: AF_XDP zero-copy fixes for arm64
 and
 XDP queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179487481427.257811.11536645665053197427.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 00:20:14 +0000
References: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 00:29:59 +0900 you wrote:
> Two AF_XDP zero-copy fixes for virtio_net.
> 
> Patch 1: on arm64, binding a zero-copy socket fails with -ENOMEM and a
> "rejecting DMA map of vmalloc memory" warning whenever the device uses
> the DMA API (e.g. VIRTIO_F_ACCESS_PLATFORM), because the static TX
> header lives in the kernel image, which arm64 maps in the vmalloc area.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
    https://git.kernel.org/netdev/net-next/c/5d761fccffdf
  - [net,v3,2/2] virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


