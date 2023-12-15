Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C6249FA
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANnBYkNF"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F01CC405D9
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 10:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F01CC405D9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ANnBYkNF
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VVSP1RbqLlUI
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 10:40:26 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0893241728
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 10:40:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0893241728
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CEE5062579;
	Fri, 15 Dec 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77438C433C9;
	Fri, 15 Dec 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702636824;
	bh=JBbZH1q4HL5wDd/RNVcF9/EvLKn50EvknKYeVg8NXus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ANnBYkNFlvad5/u1ppH/JwE0eJuCJzekQ0uG9LsFMHAutoetqLlr5RwT0P03mWGc3
	 CEc4+oAwYqImQSnG/cCFcbg27buTcaeLPJ33J09OO9fIW26mbvEk9QXIlUMWDAcTj1
	 sCWTVSkttibrqNk0BJfTNzFb79Whpd+AvKlEIJILISMXvwN0dZ5ftQdWO8dtOpIL96
	 L13DikMrvosjexTieOIil1pjn33rjlyJzjFTI08fmTrd6402jqjFIjlImC2m55dBM+
	 epyiZ1Ey1G/RJblFAFB2IcZnT1hgGCw2+3HXhTQ6BgmYqeDiSpmia3kkO7DDlFrPRm
	 dD18i0X7P+EyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BFF3C4314C;
	Fri, 15 Dec 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/3] send credit update during setting
 SO_RCVLOWAT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263682437.3810.7637682047198331916.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 10:40:24 +0000
References: <20231214125230.737764-1-avkrasnov@salutedevices.com>
In-Reply-To: <20231214125230.737764-1-avkrasnov@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 15:52:27 +0300 you wrote:
> Hello,
> 
>                                DESCRIPTION
> 
> This patchset fixes old problem with hungup of both rx/tx sides and adds
> test for it. This happens due to non-default SO_RCVLOWAT value and
> deferred credit update in virtio/vsock. Link to previous old patchset:
> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/3] virtio/vsock: fix logic which reduces credit update messages
    https://git.kernel.org/netdev/net-next/c/93b808876682
  - [net-next,v10,2/3] virtio/vsock: send credit update during setting SO_RCVLOWAT
    https://git.kernel.org/netdev/net-next/c/0fe179896811
  - [net-next,v10,3/3] vsock/test: two tests to check credit update logic
    https://git.kernel.org/netdev/net-next/c/542e893fbadc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


