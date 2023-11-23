Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD43FB2E
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVlUgOAd"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A42D3408BD
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 17:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A42D3408BD
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AVlUgOAd
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hw6_0p1wCOSL
	for <virtualization@lists.linux-foundation.org>;
	Thu, 23 Nov 2023 17:00:29 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 016C34087F
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 17:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 016C34087F
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 621116233B;
	Thu, 23 Nov 2023 17:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B39C43395;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700758826;
	bh=QAhKOwmSyYL/06pMRYmwqRumPVYS4ikPDyPLMLk4BuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AVlUgOAd/6Qj6nT4t8NFVdUtPwQ2l/VvAr/AsYAyEhcsdIDgNE74ytiYqDubRqE6S
	 p0e/zkaOVwOAzshbkNW6MePqAsUbguzkjL48aPfFSqbNhpH1U70AWOr3jAAdyiSBic
	 EVtmD37c45/gc21eptnlVFgYG/z2ZiNP1/wwzFi1VbaFCpzS2nJxCdUX/cVxQu7zld
	 ezgZjc97kOLjvSYG9EPn/1PHIzVE04Gdl5kPsMZt1D8vH5sytLhN6Ytj/g0zSkZIGo
	 rXjYt3gI0HhFVPv/fqpnNH1Wv5qV53VHTAMUFgwPGG3PHkHWZgiEPitcHT5BcrbR/o
	 Uulq4AblryAaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8277EE00087;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] vsock/test: fix SEQPACKET message bounds test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170075882653.541.9262158470588794948.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 17:00:26 +0000
References: <20231121211642.163474-1-avkrasnov@salutedevices.com>
In-Reply-To: <20231121211642.163474-1-avkrasnov@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 00:16:42 +0300 you wrote:
> Tune message length calculation to make this test work on machines
> where 'getpagesize()' returns >32KB. Now maximum message length is not
> hardcoded (on machines above it was smaller than 'getpagesize()' return
> value, thus we get negative value and test fails), but calculated at
> runtime and always bigger than 'getpagesize()' result. Reproduced on
> aarch64 with 64KB page size.
> 
> [...]

Here is the summary with links:
  - [net,v1] vsock/test: fix SEQPACKET message bounds test
    https://git.kernel.org/netdev/net/c/f0863888f6cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


