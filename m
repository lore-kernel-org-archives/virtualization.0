Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE879F6
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706148633; cv=none; b=He/RcOh5ErqXf1RXI13D6Jy+U18iM5KIBEzfr4VMOBUkNkwSYiulGwgKfdPA2lEAwGRsJVEDw8mnHZZZzgRUWZnCfxNeqF6/zcin2902YCuNWPgn+z58O7Tao1ElEmaor1MB9F6K0bGpErmS1WsAdD1tXvRtRQjo7fK9P0NdcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706148633; c=relaxed/simple;
	bh=exbNsUO+6hEk5AT7leqbsd2aeyVCGYHr5/DdVbI3xxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H0Qc7Hu7MmXnegpwG5YwB4bMiL5MjuYdS119S/bZHUeTE4elfiLaMhV1cIJ8aJOK4Hy97eaGgjAheBZR3Zg/Gy4csI48hhx5yAmCbrmCzyGnN0KRvdpHWZRtNKNg6SDHz4frjZwAx2tbf0Ud2659/FGFtyNmIRs8laeRy5daNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl0AtRgr; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl0AtRgr"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5358820DA
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 02:10:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5358820DA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tl0AtRgr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S-AjATLS1BtG
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 02:10:31 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E85A882027
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 02:10:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E85A882027
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0B059CE32B0;
	Thu, 25 Jan 2024 02:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EFB7C433C7;
	Thu, 25 Jan 2024 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706148626;
	bh=exbNsUO+6hEk5AT7leqbsd2aeyVCGYHr5/DdVbI3xxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tl0AtRgrA50fu6DljdBxD7qdCGPntWYlJI8VDDzBPYFJ7W7uielVp5gQI8zpshB4m
	 JDM/GZP6IoRoDMnCk+/0RIGRuPs3lCKGTNmzGpjlvhMpnvr5E0+RnhtnhuDy+eKL7t
	 j74oGigM1eiWIh/Bd2dpF89GFT+BqdBGVeoHCFpJqZmuCTc5F8JeSmPzaWo8tkaXh6
	 fxIoJNj/Z3SFeJRThnmxe2Xgue/9y8Doaf0ZkJRPy1z+9UICGOX902WXOggws6vRTc
	 MYvxupdnfb53ND3PAHIN5AphM8jzdJax9a0mOnahIlf6l/up9qcTAypEqUI6zsVWEH
	 MM0TDQRF6vD2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16F39D8C966;
	Thu, 25 Jan 2024 02:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] vsock/test: add '--peer-port' input argument
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170614862608.13756.13921214804637913157.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 02:10:26 +0000
References: <20240123072750.4084181-1-avkrasnov@salutedevices.com>
In-Reply-To: <20240123072750.4084181-1-avkrasnov@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jan 2024 10:27:50 +0300 you wrote:
> Implement port for given CID as input argument instead of using
> hardcoded value '1234'. This allows to run different test instances
> on a single CID. Port argument is not required parameter and if it is
> not set, then default value will be '1234' - thus we preserve previous
> behaviour.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vsock/test: add '--peer-port' input argument
    https://git.kernel.org/netdev/net-next/c/e18c709230cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


