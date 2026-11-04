Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802607;
	b=RgIAG1KY2nYM9/Lh/hKe/5mBtt3kV7Ant41nfl2K1LylHoq5bQ/h+WY9Dneb4VHndbDP
	 rGT1VLircKEdYCCdrSLwgeM0caMR5lTa++4sCF3Ta4grmnRkjEu74uCYmeedRkHCqju08
	 OubU0iZ6GDGrR2g6BnbpNUTEMAP1q891AQLuUGjFlo2e2yYCtTQYJdyJ2WWaxHE/bJS6Y
	 amMd2mN7m9ltL564G6FWQuAY7kqmgAeqvNB0a0mZvnDPFQNOomVKaA5qX937ZqSFhc9lI
	 y8qVjBScOjjq8/RA9/6sw80Ht1+i5B+NsG7yJyviO29R9Vb8qClIIaHPCv0vRl3t2NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1rJSq25xfu3r2W4rjWjb/4F/VogDdfQBOz7FAnFZlOs=;
	b=Z13UG53pR0u8OknXnm+svqSzQ0s8YVwqTdvEufZVRz9+bMKDVXMeImAkPv+UBiBNmoMW
	 xpI14Y5EqsuEzElbOjvb3fgBjHEwT4Xr/bhtWktY4knqaB9JIi5CaBbg/NaE8mJ6Mkp1P
	 xQ5+j4oLVtPi7VjiK3IJRe2NJNtCPs7p8MfKlms8N5AX3gLOf1DOZI4QOzAw0OEMUo9u/
	 4h3GRXgUQjmKy/DsCzLno7AuM7cLbuLfG8cnjGdA6HtDp6JxMATvGcoDgT3szF7IIwnPe
	 FUX5MYL6Y3A6iKbOmMeIX9+V7NrCpu5Yk+OknM/f8lo2PVtcqXQwjY+fS6SnsGhv2kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjCNgeZB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF690606A333;
	Wed,  4 Nov 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjCNgeZB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869071F000C1;
	Wed,  4 Nov 2026 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802606;
	bh=1rJSq25xfu3r2W4rjWjb/4F/VogDdfQBOz7FAnFZlOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QjCNgeZBhcXlxUpDzVBXCY5jzSpVvDTRjqyc6e9WwHp1rlNb+FNTQsyE0cyc8hV+7
	 hWyzp+k2cI2DITnXUGCB0vLQOLLGN2rU/QG35rOoEdNMQXOgSEq5ovOuDS74gtE6Bl
	 77yBdNddg6V6uk77OyWyrnh4iybVvGcLtl6fajUXNPluSQhzL+Wmi2HxAQ/drbVKNC
	 jEWGNNAPeDmNkHpIog2I+cmMzAqafs5nXIPMeP9iVkcIISUmD930Nkh8Sd5x6oL7iK
	 QUx+0AIrv1i6WVvU7PUfkUsiV2SvSykoRa4pOkeKSoLGrVcjo39z5uSLGOx2XNPHKI
	 TSL+lOa/1T0Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1D539E8A46;
	Wed,  4 Nov 2026 14:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179380260530.2859910.7796955617386470662.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 14:30:05 +0000
References: <20261004235101.1464007-1-4ncienth@gmail.com>
In-Reply-To: <20261004235101.1464007-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 bobby.eshleman@bytedance.com, davem@davemloft.net, will@kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  5 Oct 2026 08:51:01 +0900 you wrote:
> vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
> descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
> rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
> guest controls the descriptor length and hdr->len independently.
> 
> A guest can therefore provide a 64 KiB descriptor while declaring a zero
> payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
> remain unchanged, and only the fixed queue-entry budget limits retention.
> This is not a lifetime leak: the skb is freed when dequeued or at socket
> teardown.  Repeating this across connections can nevertheless exhaust host
> memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
> a 262,144-byte receive buffer; a full-payload control retained 265,984
> bytes.
> 
> [...]

Here is the summary with links:
  - [net,v3] vhost/vsock: size receive SKBs from declared payload
    https://git.kernel.org/netdev/net/c/d5e912448cd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


