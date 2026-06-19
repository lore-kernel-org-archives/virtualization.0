Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9F1EB9E3;
	Fri, 19 Jun 2026 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830218; cv=none; b=D0iSGm0TQiZV4xgQWnlSuguviwBUKIpcnxaXYGcGVFThoMNuWY6BPvshSEPoW5hTaw6lxBVzka5FL6z6bSRWe6jrhvIR53uQxeXJkvVupGTHkUORHyWGzwE4aJ1Bu3poBkvLYp33mqp4uw3mApet86SzRRvswfW7Za0MbRWqHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830218; c=relaxed/simple;
	bh=A2HR7cM9enjGlt2vYbSoJy7DtAcslfPk8U39R7U3R7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rAsT6ck58lr9BNEdIFFeXffNoT1cXS8mfvCO86dklcfOk3zEEHN0Q/lQVd/NRdGtu/AcJujbwPk8gtR8Dh1Fb77qf2uBen96R5PTJ4z65OH71oG+IOaABPPvSxwFclfBmIJzlRL+fGRXVArpoIMqaoalK0yTXCHyhr8Qujp6knA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy2QQOMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy2QQOMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0E51F00A3A;
	Fri, 19 Jun 2026 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830217;
	bh=+3YGlL7KpKqfhRts97wLZhIoeta+3YgLMi5wAdb5IgU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qy2QQOMnmLYCTge8c7PJ4eEPQWO5zERMkGrlG4qdNiN9lC7ESq4lmg9lGDyqEsuK+
	 QG6+9DXquTJ4x/ldhd6xxyas4hr/JLPec/sOKqUTXuVIVxCkLYbO987yivSg7PO5C0
	 0JbWJnwpqv9w0ADpuMOsVBHAYXvy1VrfI79s+2DC674KMPUuttEeJVbdXWk6Dx8n7C
	 NCA0Ck+u11a32H8h+diSDxRJQl3mli/TZlCkQ5yKiaR1/8q73Qx0zFFSI0xLsRuX0r
	 NrDtX+Ml3QUFPo9NOE0V3KnS7hCQMXMRYJxiOLObpEhWr6n8SKx/ZEeYSBN0KHzuSr
	 wsBOf1HebbWYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198853A78A7C;
	Fri, 19 Jun 2026 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] virtio-net: fix len check in receive_big()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183021063.3143278.6923275972130325346.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 00:50:10 +0000
References: <20260616042837.2249468-1-xmei5@asu.edu>
In-Reply-To: <20260616042837.2249468-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, minhquangbui99@gmail.com, bestswngs@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 21:28:37 -0700 you wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
> 
> [...]

Here is the summary with links:
  - [net,v4] virtio-net: fix len check in receive_big()
    https://git.kernel.org/netdev/net/c/9e5ad06ea826

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


