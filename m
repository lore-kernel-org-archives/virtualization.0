Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1031281D;
	Mon,  5 May 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489045; cv=none; b=dtHHdrH6c3IYApX7bp2nkm33LVdvN8eRhzzliwOF5ayQ6Htrjh29QiIvwiC+0fb1L/30JHe7QD7u+S7Ud71Bueex+BxPaMu2HzCzWGlrUKKRbAyMTAUGBSSRoxw5qZ/K1FSMR9ztTw05OviC0TAq/y1eLz4ScYwQL4O3KmZmACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489045; c=relaxed/simple;
	bh=9tjhNDn0NgbadNYoCcvnypG2qb/hyPzLaYytJs+fY9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FGNSOehpfiHhhKOMSbyF+47i9m20oMXqyyecFOAOLdo2TjbjbuYN4nxV9byHHBa4ow2yFm4c+CRTJsrOuIQzhEX8KfXC3fWUKuPAhdKsJxcVipUVE9DjdWJV1eVdaxMeRkRsbQXVziqq4ltZlZSeLfoe+fVl4c7NrXO7MhuMZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/YKpv43; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/YKpv43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8A5C4CEE4;
	Mon,  5 May 2025 23:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489045;
	bh=9tjhNDn0NgbadNYoCcvnypG2qb/hyPzLaYytJs+fY9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h/YKpv4334p9MTxmphcHTXw0eh/la2yf8vQWRJJJwYhSAqC/9B6j36zlG33aNaZg3
	 zowRVJSaS3msm1T21BKtGvCHp9ujDCAd1Bas2s1HMJevgrQgRXgXHY76jebA+C/dxX
	 wxhZMQX0JjUKOzpv95RBuRy5PZNluw7R4NdYe64lT9CCFXEPrKlhs7YvSPnBjPd3M7
	 vUmihzmZABofcrQUH3QeqVu75Eengyj+i2hj7H+h101Lhi4KsKRGKXaCBpyqnOvxjs
	 tONpZMdkBdpwOYtdJ7/4J+fZlrzGDjTlJfAUuj55B66Dj2+iSi1CzZp2dwebKUS9ZN
	 lvADnD+5fTbMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD42380CFD9;
	Mon,  5 May 2025 23:51:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] virtio-net: don't re-enable refill work too early when
 NAPI is disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648908424.967302.11832658516748544814.git-patchwork-notify@kernel.org>
Date: Mon, 05 May 2025 23:51:24 +0000
References: <20250430163758.3029367-1-kuba@kernel.org>
In-Reply-To: <20250430163758.3029367-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 minhquangbui99@gmail.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, romieu@fr.zoreil.com,
 kuniyu@amazon.com, virtualization@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 09:37:58 -0700 you wrote:
> Commit 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> fixed a deadlock between reconfig paths and refill work trying to disable
> the same NAPI instance. The refill work can't run in parallel with reconfig
> because trying to double-disable a NAPI instance causes a stall under the
> instance lock, which the reconfig path needs to re-enable the NAPI and
> therefore unblock the stalled thread.
> 
> [...]

Here is the summary with links:
  - [net,v2] virtio-net: don't re-enable refill work too early when NAPI is disabled
    https://git.kernel.org/netdev/net/c/1e20324b23f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


