Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D71499F0D;
	Mon, 12 Oct 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817807; cv=none; b=rJVuWwpAKcazaVJr0TRM+7XIoWP6QgEAz0P664v7BtBMYq3dg4Px4DVlf+al07IAOhlD3UASjuu+20b2VocEJ2mpOLOO+fpz37F6DMydOVl701jLsEeeWNQlTdlladNWxEgArgBpD8PHbEss0gRLSyzZkdYPi3L+LGuCrJXayws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817807; c=relaxed/simple;
	bh=c67aK30QWeJfJIdUSvCZzcfaVr+Lu94q011gSim9xqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d6oLdIMuIa4Xfuozwwti+1OnE9K3JoPKqS/Enyx+vkelANVAmCqCkwdSqSmsnWHJ4R6hMedqsv77oddRttVh1FN5M6bVgYRbrXx7Xv0ZpOor8lNep/2SOsJxl2n2mge/BT5rydVFFn2wkyDrVQMkUwZWnvQXCLXagu8yzfteJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UheppWLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UheppWLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8213C1F0089B;
	Mon, 12 Oct 2026 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791817805;
	bh=hAmyDzDhB5hr4lnWYlCGm3jTBvtVShDLYxejZlbAa/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UheppWLlMew26mIkHv+k6LtrENv+3lchTrHlyyHTUEW3+/w8bZw9NvmAB/MJMEvVa
	 cNc0QWudYUnYtJ7PI85mJ5RFpS8Ux1A3rsBi5EHCXmytwmNePvpMrxhFW2QcfwRSSp
	 WdhoX5xoVZ4I2RIOIud6gnIKDhTRivRPxz13qpqvHb9q0Ex3/inyWr67zUGEhtJBRp
	 gSr55uQPl4l+Sd4dUNMRUTxTPVJk0vPaXHsX9jX577B+7djP9nwL7vOdV63i0VaW1e
	 6TY+biZhrm8Xe8aSYy9IfC57CaDBhYU/GjBywxuihMMfJ+6a0b9p4p4Ijdco/anhX9
	 bTSbFjok8voHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774223924A4E;
	Mon, 12 Oct 2026 15:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] vsock: treat TCP_CLOSING as once-established
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179181780427.3481280.4297013609135522933.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 15:10:04 +0000
References: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
In-Reply-To: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, edumazet@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 05 Oct 2026 02:26:22 +0200 you wrote:
> Handle the TCP_ESTABLISHED -> TCP_CLOSING transition on OP_RST, which can
> race with the connect loop. Immediately break and return 0 on
> ESTABLISHED/CLOSING. The return value of connect() should reflect what
> happened up to the point the connection was established or failed. Events
> that occur afterwards must not affect it. E.g. even if OP_RW has already
> set sk_err, connect() should still return 0, not ENOBUFS because of it.
> Adapt the inaccurate comment above signal_pending().
> 
> [...]

Here is the summary with links:
  - [net,v4] vsock: treat TCP_CLOSING as once-established
    https://git.kernel.org/netdev/net/c/4f6ac74fa594

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


