Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42F20F5B7;
	Thu,  7 Nov 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980221; cv=none; b=pKBXHa6r8eXkdgJ2KAoECfh+Ps/+J8zbMpBmLtS6FfRtO1B4a6hC+hg7I8rhzfmthqpC7IEhGyySNNIIR4iCHzEJc/oLGUHYpKKaXlXciWnIc8lfMGF1Z+y4y8m5SvnXF4J2Z+IocmNqvPF4KnBIMrcLZLmpIHmv3JR+WvAwiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980221; c=relaxed/simple;
	bh=2UyNdy4qGbpUbTVMh2TIe9zeckWHBjwyMeyiAort2yU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kwRtj5LCVlyFRV2QfmRZ57KhyyUmpIAsHor4DIRDpAAwhFq0Cb2JfsPp12p7nezKV+6wZBnKsX/ByGKpL/XNdqLr56/4cMvbRTwnR5zZh007WgRY/XtlDhwRqinKuNORKiLF/TdPqzzC/jhouyNY5KDIDkHq2W3Q3OjDyjemGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft1ItOfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft1ItOfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC6CC4CECC;
	Thu,  7 Nov 2024 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730980220;
	bh=2UyNdy4qGbpUbTVMh2TIe9zeckWHBjwyMeyiAort2yU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ft1ItOfwxHkMQKyX70arcU/rXPkwfnXSyhbEgW/RMtmJ3FT2RwpvpPvj4V9vEz88H
	 1Sd69JLNxeZq5q5ZylouwJv8dQGGD10jp6AF0wmBmZcAo0Sfsx60X0e7h1aU/3ACrj
	 BRqIhHa5mD2G0MNbkVodhsYWQZ7QSU8wCuhqoPmjr1DQlZ1adTpK9Kb6IXt5GqQQ+q
	 wr+GCl1mGGEOsCb3tcaowjiYXvZWiCEFiuDiSsUJBYkj7scgpz0MKlAWFflVULbc9k
	 VL+RolwZSpsyFz2hKKmO4ck6HA9ikZOPQC1VJFcBDvewFhcp2gHKKNG9EMGy2D7bgI
	 u/cI442my2eOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343863809A80;
	Thu,  7 Nov 2024 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] virtio_net: Make RSS interact properly with queue
 number
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173098023002.1629022.1863004983853146136.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 11:50:30 +0000
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew@daynix.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Nov 2024 16:57:02 +0800 you wrote:
> With this patch set, RSS updates with queue_pairs changing:
> - When virtnet_probe, init default rss and commit
> - When queue_pairs changes _without_ user rss configuration, update rss
>   with the new queue number
> - When queue_pairs changes _with_ user rss configuration, keep rss as user
>   configured
> 
> [...]

Here is the summary with links:
  - [net,1/4] virtio_net: Support dynamic rss indirection table size
    https://git.kernel.org/netdev/net/c/86a48a00efdf
  - [net,2/4] virtio_net: Add hash_key_length check
    https://git.kernel.org/netdev/net/c/3f7d9c1964fc
  - [net,3/4] virtio_net: Sync rss config to device when virtnet_probe
    https://git.kernel.org/netdev/net/c/dc749b7b0608
  - [net,4/4] virtio_net: Update rss when set queue
    https://git.kernel.org/netdev/net/c/50bfcaedd78e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


