Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B47E792;
	Sun, 11 Oct 2026 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728751; cv=none; b=psZrrAq97OSzrsShy9c0KHuzF1MToNSpwn9zgatWxFNOqFzcqeQlRc3F8iDW1Zfjks2QBA0PWGpwJLTkFt4V5c/V+6VMOckDHfVoHmtnZDhdFDg4VGgqCZu1r1KdmS3OHGfqDnEXTWFLSeXPUBlcWBD0XsxvzyRyjFJ+DxDOVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728751; c=relaxed/simple;
	bh=4ckeA/SIeG5+ddnnV7RUphNs+eM3SDYw8WWRGPMZPtA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yyo80iVXiEf4aQ8fEVxf9DsnxUxi0blaAlfSPoZTxo1HxFA8VQm0g3TZaB0oBIQuKcYKbn75Pk8j24B0Dq8QCVvScz0LK9Jgg2IIyps+Qfu60JeVlvkEn2xJ6BG3e2FqIddW26gd1vTNmYilhzpLBmBsmE59tD2F8f3EfEWB9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmuvGUNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmuvGUNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9A11F0089B;
	Sun, 11 Oct 2026 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791728750;
	bh=eVWxZPC3pTpsZn7iTHsDs5kC9m9kUC1hvTf+hzyUtA8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HmuvGUNhfwJbv2hNWEl/R6kO5Q+HkNd8AwxBfdEpt+9CROiiycvyrvH0Yywpa1a1C
	 REP2Gs6YsH5pq1uOQCqOXuuX2S57sTxRPlJwf5fzIeUt6giO/wRvC0z04nagw2Q6pZ
	 WMwETsJQ7lgz78SKx683b49b8Bqr+g58zSYFBsDGot4jQ7z28CjvYrC0fgZ81LPmG0
	 F4CsUN9v8Jce3Hdez70763j2lkqAJCoQa7ojjEYdEx0seNUqTfWWQHr2aEkqo27yrp
	 KnOogDoB1h/wRDw1pCIMGhdILaVHOHQajpjtqPWKwunoBpKj4zaa8+jmQf50BijQ2N
	 b35eAgM/ZHGFA==
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
From: netdev-bot+sashiko@kernel.org
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 14:25:49 +0000
Message-ID: <179172874905.434549.15262603111137504099@kernel.org>
In-Reply-To: <20261010142247.99223-2-physicalmtea@gmail.com>
References: <20261010142247.99223-2-physicalmtea@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit message concern: the message for "vsock/virtio: split
  socket lookup from locked RX processing" lists what the refactor does…

--

vsock/virtio: split socket lookup from locked RX processing

This commit splits virtio_transport_recv_pkt() into two helpers. One
does the socket lookup. The other runs the receive state machine under
the socket lock. The decoded source and destination addresses and the
network namespace reach the locked helper through a new struct
virtio_transport_rx_pkt_ctx.

> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the source and destination addresses used for lookup to the locked
> receive path so they are decoded only once.

[Severity: Low]
This isn't a bug, but does "decoded only once" describe this patch on
its own? The old virtio_transport_recv_pkt() also decoded src and dst
once with vsock_addr_init(). It then reused them for the lookup and for
vsock_check_source().

> Preserve source validation and failure handling. Keep the lookup reference
> separate from the skb owner reference so the locked receive path can manage
> the two lifetimes independently.

In this patch, virtio_transport_recv_pkt_locked() doesn't touch either
reference. The caller still calls skb_set_owner_sk_safe(),
release_sock(), sock_put() and kfree_skb() in the same order as before:

    free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
    release_sock(sk);
    ...
    sock_put(sk);
    if (free_pkt)
        kfree_skb(skb);

Also, struct virtio_transport_rx_pkt_ctx has only one user here.

These statements seem to describe the next patch in the series,
"vsock/virtio: amortize RX socket locking for stream packets". That
patch adds virtio_transport_recv_pkt_batch() as a second caller of
virtio_transport_recv_pkt_find_socket() and
virtio_transport_recv_pkt_locked().

It also adds batchable, batch and defer_data_ready to the ctx struct.
It keeps the lookup reference for the life of the batch and takes the
skb owner reference per packet.

The diff reorders one thing: on a type mismatch, sock_put() now runs
before virtio_transport_reset_no_sock(). This has no effect, because
virtio_transport_reset_no_sock() uses skb->sk and not the looked-up sk.

Could the commit message say that this is preparation for the batched
RX work, and add a "No functional change intended" line?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010142247.99223-1-physicalmtea%40gmail.com
