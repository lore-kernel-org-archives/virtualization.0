Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64E1DC198;
	Thu,  2 Apr 2026 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143824; cv=none; b=vC5IuyuXQhgikM9EnZmHIk3UyMH2ulEQAwgW9wCqzSaz3vTz6kl/+iK3JZAtucDmoMEkzSVIoRa/3SizEOx5XzU9VLNGW7lwlrUOr/3M1slh6IR2Gqvhl66SEOnI4IMaYehltaqgGp+wqaeCvzLDw8kOnwGtK07fX8AlkIN1SWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143824; c=relaxed/simple;
	bh=Dvei2zgYz+6qevmJy8xRqAYuoOOqh4Tgi/RoGGKx0Mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=idDtAd7qu+mo433bT4ZxovbuJd2TVjmAM1JD0IRtIc4DS57bdbwWtkSH+5O1F2YwBLmyicYHgmVr4Oq14A9/DdZrublMdan39l4eecL/8dWtkid3nUOjAypIzMm+COnn3Ivw0yIl5e081UUq+rHb7kTHK2uROJ0FwJBiOlDWW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPdcprMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPdcprMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E2BC116C6;
	Thu,  2 Apr 2026 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775143823;
	bh=Dvei2zgYz+6qevmJy8xRqAYuoOOqh4Tgi/RoGGKx0Mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DPdcprMen7la1emKIGzJZY0E+gTdFLVdcgE3AgC4IjVw2HAsTyNq1SsD062+/4Bka
	 7BoeHQnj22g9u3et7DnuiHOL1H90yIgBvYn05rdq/nqjdT9mnbmBbv4vpPXqCh1HYy
	 W8mu/LYKtaoYdVwhhDsAp13fuMAwr4juFTUSRjZOecmVU/v0jfovpU6THL879Vv/hv
	 +hWjnyplhbFD5II9AVmNLjAPQY1srxxM+R44BHEtFwaOhfMB997l5u+MpWCIQuDAoL
	 HWsFhLHv4Lt3hDnPHy75pw+2gbNpNY77hEnDlOxvfCgKsiSD/g0ea8P1DAk5+1HIMA
	 /34kOYesThxbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D323809A05;
	Thu,  2 Apr 2026 15:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: initialize child_ns_mode_locked in
 vsock_net_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177514380579.495568.7004810880826599315.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 15:30:05 +0000
References: <20260401092153.28462-1-sgarzare@redhat.com>
In-Reply-To: <20260401092153.28462-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
 bobbyeshleman@meta.com, kuba@kernel.org, horms@kernel.org,
 virtualization@lists.linux.dev, edumazet@google.com, pabeni@redhat.com,
 jinl@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 11:21:53 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> The `child_ns_mode_locked` field lives in `struct net`, which persists
> across vsock module reloads. When the module is unloaded and reloaded,
> `vsock_net_init()` resets `mode` and `child_ns_mode` back to their
> default values, but does not reset `child_ns_mode_locked`.
> 
> [...]

Here is the summary with links:
  - [net] vsock: initialize child_ns_mode_locked in vsock_net_init()
    https://git.kernel.org/netdev/net/c/b18c83388874

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


