Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FEE47B401
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851548; cv=none; b=eq8mGyQma2DzB4As0Bz0uwS5uqtcFDDpdzt/ueyVrEZ7Rt6zdulHX13nLGFXhAwegiyMLXK+J5KaM/1JLEMOTaqmVmh97CNcNuvR7wn7mCLj6bwFuD+EN20m9/F1BC24j8DiSxXJOdYpXKDst5qJc/JtTr12oniwsANfdqgjjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851548; c=relaxed/simple;
	bh=+0vnvc0Lj/Of1cM+Yk8+OLr0KRKRO9Qc9+jopixFTfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M8bAvOgM30OWxzfR1shhlOXH538+Y9ensts1k5V6JmklR8c1SIBRiIScYBTExbcgVhPajQTG6dORTtO0Y1hGtauAz5S2pzCDEONxUKmePGxKHDDs5Ek1dB8qLQzlKwqCT2zwJaR+8CYpp0CHsw+xPoAyNeRE+Js2G9hHU4o748M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLrtswsw; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLrtswsw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9976F411F3
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 20:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5RhEl2ZDWuxQ for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jun 2026 20:32:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E0EE8411D0
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0EE8411D0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLrtswsw
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E0EE8411D0
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 20:32:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CB44A41096;
	Tue, 30 Jun 2026 20:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1461F000E9;
	Tue, 30 Jun 2026 20:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851545;
	bh=Ee0DW3u1OlD5/tDh+LJKu7ztlAs2aVA5k16PIo1KX+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GLrtswswueibf9TbwxLG6RHEqxAXwDHnvwO5ikdxKbEytrpbwQyitN4Uv1eEAwlII
	 9lIjqZlU6blDHghNITxhoN3THzQFzGDxNUEO+IZAku+1ru0DXcph8LUYvRY29EUn+E
	 pDl94gc4wPHNG9zMOre3lkVksmZg4pC9D3Kqa2+V6u0jqpOtOWdgSvYz3Zlwh4DAMX
	 A1xkZTXFngUtdcl1ULhF1BGHWeW6+OFxYlfiLVdkLkppuJCCX7XOIrGtrVItvTnzFq
	 iVaYG/ciGMJpaIpn258ajMjqDZCRNBx45O7LtOBMwY8AJ4QCQOF2wNHvpR33HwQ9pf
	 v+BhNfIHpoTEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B11393A951;
	Tue, 30 Jun 2026 20:32:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178285152938.267316.4321290266039198269.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:09 +0000
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobbyeshleman@meta.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Jun 2026 21:20:52 +0300 you wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
> this way, patch also adds handling case when 'msg_ubuf' is already set.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
> ---
>  Changelog v1->v2:
>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>    already added.
>  Changelog v2->v3:
>  * Update commit message.
>  * Remove one empty line.
>  Changelog v3->v4:
>  * Update commit message.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] vsock/virtio: rewrite MSG_ZEROCOPY flag handling
    https://git.kernel.org/netdev/net-next/c/f456c1922c49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


