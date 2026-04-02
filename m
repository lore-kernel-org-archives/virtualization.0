Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBBF34F489;
	Thu,  2 Apr 2026 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098828; cv=none; b=GzSmQUVtnT7Ebi9JASYFt6qssOTkxnd8w6WQkhnQEKvP9KdvNjB68YC/SlY6FJcuCkRLwV6SAUT+W3rsi7fqD+xA9O1ADOvQL2iklRKqnYbMHk6dZZQumDOGZGpnihaEEL9rQbIxQ9IijvBPCJCGVPjB3/3AkOM2/9Y9xLyiP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098828; c=relaxed/simple;
	bh=9k+TgUtNxsgHwQ6uRp5AXltiRhjl/HKTIupXBQTays0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WH0mDUVUCKIvb9KiKjVXWpcEg9e35V59Xn864sTdmwOZIBPX7lLYgDyP+bjoVn2KQ7RTi18pmfkaYko0HkKljrVmvcwKtZ/vr+j6+Y14sM8IOpxXXMO6SoHCA3O7CHZQPwpJM/lyKhMvdS9GHPN6EQ9nND0j7B5mK848Jw6mQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3Tm+Nc7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3Tm+Nc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBB1C4CEF7;
	Thu,  2 Apr 2026 03:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098827;
	bh=9k+TgUtNxsgHwQ6uRp5AXltiRhjl/HKTIupXBQTays0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n3Tm+Nc7RXlPQkRq7nzvjTPnp3nEbRkTbYZUGPx8trtRqTMP7d1IZ2/c8eC7oL00d
	 w/5qbRNVAudnkCCJ4cLMn68p2+EhMuJEc/tjoS9o1DpbhQvwLF+zFE+KOzHKfEmwDy
	 AWNOMEQxXULoL1ikvL6PSF37tIKU0bOyipesvGOfYrgx1m3XpM9k1H4PLuobvCQmVy
	 liJDNkwpU76D8a5wIYv9S36bHvB8DWqW9XzjdTuhpluQnsH2Vc8gOudRdoLfi+WdV4
	 vqzNnQC56FUhCmhWjFpmwBG81q0XPDaQb4DhGXc68vC1whe6QgJfUmrIJjKXxZfBrQ
	 oODZ9aXH1A/iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF63808203;
	Thu,  2 Apr 2026 03:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509881053.3966658.16060466684151424030.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 03:00:10 +0000
References: <20260326142344.1171317-1-schalla@marvell.com>
In-Reply-To: <20260326142344.1171317-1-schalla@marvell.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, pabeni@redhat.com,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 19:53:44 +0530 you wrote:
> rss_max_key_size in the virtio spec is the maximum key size supported by
> the device, not a mandatory size the driver must use. Also the value 40
> is a spec minimum, not a spec maximum.
> 
> The current code rejects RSS and can fail probe when the device reports a
> larger rss_max_key_size than the driver buffer limit. Instead, clamp the
> effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
> and keep RSS enabled.
> 
> [...]

Here is the summary with links:
  - [net,v5] virtio_net: clamp rss_max_key_size to NETDEV_RSS_KEY_LEN
    https://git.kernel.org/netdev/net/c/b4e5f04c58a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


