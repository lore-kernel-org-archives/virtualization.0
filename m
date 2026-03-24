Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4B3DCD90;
	Tue, 24 Mar 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348220; cv=none; b=WDQ2XnHtEY2WviUkGyPoxrpHaX0clcvURxJhbR75p0AEJ6jgrCgxCs1Bzezo6uyj91XxLTcVFYBXmaHpnSbsIq/n/djCfDPOxiQMKX24r2GIOWeZFGaKCk1jWPgGzqQ+IwS4Y1fDfG4JbduZcnqPtHhSZZWUmaBJnqoG2mJQAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348220; c=relaxed/simple;
	bh=LNff/5gU1PcyAnEzd6VAqImqQIt84855LfF1mf7IpNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jgwxkiGsRevfGucVvHJrheqnktEvQLrESz+9nM9+oX9ZirUFjVoL4sOxn8SXpE5YWHd3BM66tbnsTURlrX1MWNku7S1YYPi1Kx1JiPhXuKC6vyfzL4xXaoUqqbEer5pN3C4hSETI9Fs0PG0WWnLhshHWZFFt5VKHesnWHnMjv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+UDi8bw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+UDi8bw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9437C19424;
	Tue, 24 Mar 2026 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348219;
	bh=LNff/5gU1PcyAnEzd6VAqImqQIt84855LfF1mf7IpNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+UDi8bwckMdT5EWPEU+QkJMoSBz2oYWpoNcQrK5hXqhqyvi6Qxmb/ml+UUOUfY2v
	 e1Pb+TsUM2RpoOnEdtbOvmcOipuO14Pq4hx6YHAzty5fQ9cJc6tMmJyEIurWtwnGrA
	 bV71lc3uJNKqZvipXNjmUN85lwMkJp3/DEnRUeJD1FxaAAaFlz3789bcgOpvDxkyEC
	 tclZy2PJI5k9+TFmjMknQ9z9FQwBulV38cN9E/Z+h5fwhi8ds8OXc4WTwqARWl1xhw
	 E09BVWTkrdieZmjuplNFCQCYwl9dIZw3pCBWW7PjF7VDYeFVZDwF8rky24Yum2abh0
	 XIfkMZ0tm3ACg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F533808200;
	Tue, 24 Mar 2026 10:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v11 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177434820779.609364.1964955018523380063.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 10:30:07 +0000
References: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 eperezma@redhat.com, jiri@resnulli.us, alvaro.karsz@solid-run.com,
 virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Mar 2026 10:18:16 +0800 you wrote:
> v11:
>   1. rename virtio_net_set_hdrlen() to __virtio_net_set_hdrlen(),
>   virtio_net_set_tnl_hdrlen() to __virtio_net_set_tnl_hdrlen(), and add
>   explicitly mention in a comment that such functions must be invoked only after
>   virtio_net_hdr_from_skb()
> 
> v10:
>   1. fix http://lore.kernel.org/all/202603122214.8Anoxrmq-lkp@intel.com
> 
> [...]

Here is the summary with links:
  - [net,v11,1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
    https://git.kernel.org/netdev/net/c/38ec410b99a5
  - [net,v11,2/2] virtio-net: correct hdr_len handling for tunnel gso
    https://git.kernel.org/netdev/net/c/6c860dc02a8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


