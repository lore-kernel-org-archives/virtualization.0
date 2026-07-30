Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C42E974D;
	Thu, 30 Jul 2026 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370855; cv=none; b=IPOKfDq7oBJMXTfiov1bmRC6OMA4ykexTqzc3plww8VW0AOnmtRp7N6giBsEq+xVYZccfR4JmrSIR7sW/ijwAnzQ9T7Bv79VVML8xqyMtH8J3UdRy99+pS8I8tmPlkL1zbIw/O4u1OeL2YaiC9M2JyUMTPW3d1NSM5iogE2bYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370855; c=relaxed/simple;
	bh=MCvOERHoQ1utAVyBxtRKjPVQqF2sFvORAss1VbsTkWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NA0f36vkWG0bi+jNldcC93RL0qK/vzA7iHKm5lPkgVsrO0owbOMHFiqQ2davzzs7H4FBbYnUiRGKdrxWh6mqMVyRtb/pCO0kpKCj7RJLZMX5VSPOPDj1bCRDPs6jx/12YQYtwX0sfxUKY/n7UygIAO5U+U4EhsbT0+2PAro4Cl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmiXSpVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmiXSpVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6111F000E9;
	Thu, 30 Jul 2026 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785370848;
	bh=Y/ar3p1LYVEouOsJQKs8P3xplzoQODF9Duqlif8Y8ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VmiXSpVaoEF8+TNSMF8PWojUVW3wDykLCtyIXz6OAYNqt4MkBnsoPJDfe8gv9imAx
	 Bxs0rInvkFI4ZePPLv/kKM1hOWHdGHNo49O3n/iagB3F/9jX2Y7osfsuEqcAdlGPRO
	 1OO2RBQC3Zrr0VUFW12iHo008BijUCRlG9C6OIHZleiPO33YLVsMTn8wJdhvnu0Qwy
	 IlXRvRndnDGncbQ8QxuzMNhvgcuje+/B6cbacTOcDcIXiMeatEOJrrO7rIDjl+G2xA
	 skgTfARIDBYGHXJk0SbIy9rMwQe5WEKs1URffm9ST8LLt+YlRKt17F0EOha+8vwii4
	 Qa1DoMzNQWKlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3B3926250;
	Thu, 30 Jul 2026 00:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] Revert "tun/tap & vhost-net: apply qdisc
 backpressure
 on full ptr_ring to reduce TX drops"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537081189.3294584.1292356149475658515.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:20:11 +0000
References: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 eperezma@redhat.com, horms@kernel.org, tim.gebauer@tu-dortmund.de,
 brett@librecast.net, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 11:22:36 +0200 you wrote:
> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when
> a qdisc is present") did not show a relevant performance regression in my
> testing, but on Brett Sheffield's librecast testbed it causes a
> significant throughput drop in an IPv6 multicast testcase. The regression
> can be pinpointed to multiple iperf3 TCP threads sending: for 8 threads
> the throughput dropped from 13.5 Gbit/s to 9.13 Gbit/s.
> 
> [...]

Here is the summary with links:
  - [net,1/4] Revert "tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
    https://git.kernel.org/netdev/net/c/f11b48aa674b
  - [net,2/4] Revert "ptr_ring: move free-space check into separate helper"
    https://git.kernel.org/netdev/net/c/6bc85579c3bb
  - [net,3/4] Revert "vhost-net: wake queue of tun/tap after ptr_ring consume"
    https://git.kernel.org/netdev/net/c/8f83be72d9f5
  - [net,4/4] Revert "tun/tap: add ptr_ring consume helper with netdev queue wakeup"
    https://git.kernel.org/netdev/net/c/c3da92af07ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


