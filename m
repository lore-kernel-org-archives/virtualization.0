Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB9265CBA
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093577; cv=none; b=e0CZ4dPrTgKybXdfaIMyxSlrg5rfK9NobRTPif7XzYv0AW7bWOq/UYMJuo65G+Pp+oXtXzQMPEhtVlIEJFKIyn3Utq3A50hZj0CxtPgYtzhjopAQeFm3nlZM6226cLyQPIFzLAhvIi9pF91PO5GLcl7rI7kgYR8GTh86XJ7mXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093577; c=relaxed/simple;
	bh=SCGVRp6GOl4cx1eigu66mZ6vlzczca2P/5/u8Zt6Saw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iAOgqzXOlQshxeHjrxj94Q5TqFlxIdbaMCzGMQcFBnI24hHCLIeRH7pf1voF1uD9WLhTDjlxMEJRVHgj3X/5+kLn2s5TkZV4gUMaWb8HLDrB/AACaavTf+HUArAyvH7d+64gwfHTXNmgvoR6J6/0Xv1iVqDjRp0WyjP5aFgo/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR+8eBm2; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR+8eBm2"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04FC6411B9
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 23:19:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.726
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AtFNveI30zrQ for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Feb 2025 23:19:35 +0000 (UTC)
X-Greylist: delayed 558 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 20 Feb 2025 23:19:34 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 04C84411B1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04C84411B1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lR+8eBm2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04::f03c:95ff:fe5e:7468; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04::f03c:95ff:fe5e:7468])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 04C84411B1
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 23:19:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A9FF368355;
	Thu, 20 Feb 2025 23:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B4CC4CED1;
	Thu, 20 Feb 2025 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740093014;
	bh=SCGVRp6GOl4cx1eigu66mZ6vlzczca2P/5/u8Zt6Saw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lR+8eBm29pOim34f7Oc1islIwbMTNcL/VK6wvCInGDpyHebUAvrUtNaW0CxdWlySv
	 GH0NNEGbTa3RsyZiUpBJQ4wMbhe+5TwQI0Jbbu4O8dlZKPnolzwzw/tbGDyhkxMgQY
	 TSrdjKlWFwY7aXVPOqheBkDwpVlVIX2qdyz5FN4TpDofGyCV4vbqdWn1cZ+q9l/Qj2
	 kNS6PjfhOdXuPmeu5TxiwDiVScKvyV6/mQneRZ5inM845N7EqnRGcbtRP4nQ0/Uf0h
	 RXtz97nL83s5c5rGn0y7Qev3tlI/59E/ivxS5L+wztP1QZUEx6btWuIQ/FCvzRfTFa
	 goKzHBvrlrgXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE54B380CEE2;
	Thu, 20 Feb 2025 23:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174009304478.1506397.8001698369516362752.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 23:10:44 +0000
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
In-Reply-To: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: corbet@lwn.net, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mst@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 yuri.benditovich@daynix.com, andrew@daynix.com, stephen@networkplumber.org,
 gur.stavi@huawei.com, devel@daynix.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Feb 2025 15:04:50 +0900 you wrote:
> tun simply advances iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This will become
> especially problematic when tun starts to allow enabling the hash
> reporting feature; even if the feature is enabled, the packet may lack a
> hash value and may contain a hole in the virtio header because the
> packet arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tun: Pad virtio headers
    https://git.kernel.org/netdev/net-next/c/4adf74971018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


