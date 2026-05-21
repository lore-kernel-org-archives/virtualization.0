Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523703655E5;
	Thu, 21 May 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330019; cv=none; b=k8GgBJyOBeoQEAk7wZ9bQbdsGnkroAhrmVuk/fs1raVD842/tfvmUWKiM0tS13ERQcR0+/HMYLrFtET6cqpcV047EfDJzOnu0JgHk7FWX+Y/lZpRyrwNZrk34pXSK7Zwv6+hCRk4cSyPI3TYeLO6iqMJE9w/PpaTCKd0CkdNiVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330019; c=relaxed/simple;
	bh=BjlukyP5bTQHvs0L2QCUfZaNLjb0pmJmzWqNyPaH4x8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FYufTrqNLKpuKPDgIHd774X0A0ZtFqwvr2ZlN8z2gvQ+jJX8DPYJ0ab6ojLQ77mJFFMZuNHgr2B72DQuHjbJat1PXke0EfKzOn0vv37JnQBez+I9vyUQQND0BAx+WskoSageO6vnqGc23qhuTypplzsMOUCmSWXotK1axsn/4Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+qMr8Yn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+qMr8Yn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F101F00A3B;
	Thu, 21 May 2026 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329996;
	bh=oxGAPtkWo6+OlSRC8RjNsfV13vDMRjGxMBTahMYmMYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c+qMr8Yn8HYJbW/OjWYlXsWHr7hZ9p2k9OaCW0c8ykfn5HxUDGsEKyZPmDDcWemUC
	 XkOGMjxPVzC+87W4pelYHsLKyHaaCjrZXRwaEYBVhHZBkkElLjtJadp/yx+pgXUniF
	 RcZrHDU1e5yyQColjQ7PfYfPXQBR34kpbZRX+tYMlcDhc0VIiNaAv3OBvSLFBHHQfi
	 Ee4V58Ae4FXzZ3Zx39k9HWGnYlwFGnLUzhFcSwE9Nv+5jLiGzDBV2qXTMYwiJ664Zn
	 0tFMU4QRGXQXjA0kzn3svXEze0vdUjUMSqioUncQciImvWIn5D0uuQqHtgqOkzSZL9
	 PsdCMj90IocNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569183930C38;
	Thu, 21 May 2026 02:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] vsock/vmci: fix UAF when peer resets connection
 during
 handshake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177933000715.3834961.4605675753542747762.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:20:07 +0000
References: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
In-Reply-To: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: pabeni@redhat.com, bryan-bt.tan@broadcom.com, sgarzare@redhat.com,
 vishnu.dasa@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 17:23:10 +0700 you wrote:
> vmci_transport_recv_connecting_server() returned err = 0 for a peer
> RST in its default switch arm:
> 
> 	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
> 
> That made vmci_transport_recv_listen() skip vsock_remove_pending(),
> leaving the pending socket on the listener's pending_links with
> sk_state = TCP_CLOSE while destroy: still dropped the explicit
> reference taken before schedule_delayed_work().
> 
> [...]

Here is the summary with links:
  - [net,v4] vsock/vmci: fix UAF when peer resets connection during handshake
    https://git.kernel.org/netdev/net/c/99e22ddf4edb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


