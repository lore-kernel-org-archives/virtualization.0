Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2369C3BE65F;
	Thu, 12 Mar 2026 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310229; cv=none; b=Ohyen9hha5l5P77GrMDnTOK4JO+1UdMe9k7YKeoh+IAvDtQ0cmHg7NOCkOgVH2s0XC03tzjYymNFanEpjbnGevv1QPMp/j4yPq77a6pNAiqfruqnr6CydP9gwaMMPP7bTHlW06yDx0yHDMjhEQWZTe7eC7XFMFJqKX2OND27Az0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310229; c=relaxed/simple;
	bh=hKg+5rksY5JYNEPAf/ZmrZr1leDBBBXk3/IFJWMZ4Ts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QDuQ48P2/s4RNGiv+pAQwZF4WXXelSw9t3qUft6S6nLPLwZQ1hHzg6fSf7bbmNJwfJe8KIvxtpg1vjS2dYiIGeZszO72R/ScycBSYdu3M60QmrSsKS1zknCEjlls/DeMszRI7vfdcyMPZ5ul/N2bZjvY1zi2BT9txHZtorEkllE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko9iZpA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko9iZpA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7706C4CEF7;
	Thu, 12 Mar 2026 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773310228;
	bh=hKg+5rksY5JYNEPAf/ZmrZr1leDBBBXk3/IFJWMZ4Ts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ko9iZpA7OUnwG6I5Y2Q83egrhGdUFbBr2KuzaYBeXHSIn1MJEWrT8NjalUy3VpsHr
	 4XRADPrxFhgTyKsHeyfNsxZGaTxJSFzXQQJGC29owKO4UiGt9dbr+uB+rMBcwPX15i
	 rJGTvZR8vPncFox+1vfGBi8KSt+WvQ5IYQME7zFkpIi/FZda4f7m67tYvhVfT6Jm6i
	 iJEJQFMVA9E/mjv53eDwZL+431sL9q7aJToeIMczSv7y4paFOmQMc9iugm/LTi5yVJ
	 dwRIsujX6sVumNfMPcQLOLh110QqbqVut54ObZPMIetA72/Maj9AmgB7Ww5xLDszzR
	 C728oXwt2JV/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF183808200;
	Thu, 12 Mar 2026 10:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] vsock: add G2H fallback for CIDs not owned by
 H2G
 transport
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177331022429.4031253.15687388113936443008.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 10:10:24 +0000
References: <20260304230027.59857-1-graf@amazon.com>
In-Reply-To: <20260304230027.59857-1-graf@amazon.com>
To: Alexander Graf <graf@amazon.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, corbet@lwn.net, bryan-bt.tan@broadcom.com,
 vishnu.dasa@broadcom.com, nh-open-source@amazon.com,
 syzbot@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 4 Mar 2026 23:00:27 +0000 you wrote:
> When no H2G transport is loaded, vsock currently routes all CIDs to the
> G2H transport (commit 65b422d9b61b ("vsock: forward all packets to the
> host when no H2G is registered"). Extend that existing behavior: when
> an H2G transport is loaded but does not claim a given CID, the
> connection falls back to G2H in the same way.
> 
> This matters in environments like Nitro Enclaves, where an instance may
> run nested VMs via vhost-vsock (H2G) while also needing to reach sibling
> enclaves at higher CIDs through virtio-vsock-pci (G2H). With the old
> code, any CID > 2 was unconditionally routed to H2G when vhost was
> loaded, making those enclaves unreachable without setting
> VMADDR_FLAG_TO_HOST explicitly on every connect.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] vsock: add G2H fallback for CIDs not owned by H2G transport
    https://git.kernel.org/netdev/net-next/c/0de607dc4fd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


