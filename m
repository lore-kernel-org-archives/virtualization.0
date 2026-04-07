Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BD1F91E3;
	Tue,  7 Apr 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526047; cv=none; b=GxNJoHR5RRCD9JRtN+oFqLfGypYULIp1klzl+6HZLRBQcrZvWEVNukOUutw75aG9j4dfHaE7HP/aXtajec6Qnmq6RiScXFtgo8ElyuqdPAv8dGHTQYgfLkBNGaEXAZIBEygaCudereJ7lDdPQOPt3kEYLFEwNEIlRfrHzbThljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526047; c=relaxed/simple;
	bh=CrvNckWVDsiDnXOP0XHIevmZ4ZtfHWAyTDSyNAQ/iqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X29Dufd0WD741fbHg9GsYVx5R1Ud46enxkQ4Lx6bt+9I891sSg8U+wLJOQ44iOzsWavfPXgGscI9WoKn6gVavQx993qOq8Ajn30M6AIfGEgNhP0lzqokEeVKkvrRCRC2uUG02oxLL71Fb4+nwij1ab9GXhR/BojQgnMeRxv7ELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER2RAdtw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER2RAdtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CBAC4AF09;
	Tue,  7 Apr 2026 01:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526046;
	bh=CrvNckWVDsiDnXOP0XHIevmZ4ZtfHWAyTDSyNAQ/iqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ER2RAdtw8T+wzjQMTw8I60jp1oyuQVGG4Kl6hrnaWYol2mA+5SXolp2zP37fx9EKo
	 MclHdqofvBIaCtQz/UDiUfxsTh5QFuoehf/DutZ0K5rJzf/fGg19rRsbj1d3KaYXH1
	 MC8wYS/scRSyUvTo9fUJQKhl2mQHqVeW9clJ9+jaWvHwbgru9On5eSBKUo9PaCqrox
	 /E589mk39UE+7aPJKuN9cmlBoUgwMyr69vNI5zkXp7kjkccsCWsqwxHQWNBcSSpOl9
	 NTfv4YPzBN9UdKvfNND5k6PVOUYo+cvQtOok9cwWCssON+9tsh6MLRGhNKZbtEKGDy
	 dVyhsto8/a+yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1DF3809A28;
	Tue,  7 Apr 2026 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] vsock: avoid timeout for non-blocking
 accept()
 with empty backlog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552602504.3334922.14970338927374707582.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:40:25 +0000
References: <20260402204918.130395-1-laurencerowe@gmail.com>
In-Reply-To: <20260402204918.130395-1-laurencerowe@gmail.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 bobbyeshleman@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 13:49:18 -0700 you wrote:
> A common pattern in epoll network servers is to eagerly accept all
> pending connections from the non-blocking listening socket after
> epoll_wait indicates the socket is ready by calling accept in a loop
> until EAGAIN is returned indicating that the backlog is empty.
> 
> Scheduling a timeout for a non-blocking accept with an empty backlog
> meant AF_VSOCK sockets used by epoll network servers incurred hundreds
> of microseconds of additional latency per accept loop compared to
> AF_INET or AF_UNIX sockets.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vsock: avoid timeout for non-blocking accept() with empty backlog
    https://git.kernel.org/netdev/net-next/c/98f28d8d6e5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


