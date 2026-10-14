Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309142EEE90;
	Wed, 14 Oct 2026 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959588; cv=none; b=VvaDQMFeRq2YUmzLLCcVhqcnNo7MobI61wYt3ROXWcb3cdWt2RoipgA1mVTM530kfB7Epm/zrC+iCLrVTccReVNidBQpTqP8J5PGjpbp83NGFmqtpb3kStTxcwYeDMMBcBpNDu78VxtlVFYpkNKCNYyY1QeALrMT73OJba4x6tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959588; c=relaxed/simple;
	bh=hZnXdS8AanEZIIEST8OIJ05dTsAd0Sx5h8VsoTQYJy8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1PvfL/93JB/Wet2CutIE+c8TQqcxZ3Z8hGIv6kYk1KDvuM126x+F+chxytYDk4KbYIttYKwSPzzzJ6/iZbsTIRl+4SGT07DiBMY8locxV61/TRCk9P4hltqSDcBK4+6mFGZu97RT2Kt5CpCBmNxIV1mqWDXCUxrUlYBuQqJFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAdv62mk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAdv62mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A051F1F000FF;
	Wed, 14 Oct 2026 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791959581;
	bh=bz7UsijxJT419pdB7TAHe5DRpQqHR9oPLis11GxsW8A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SAdv62mk3hJ0WgjjHtxTuAcC5tvg06ypH1BURi+MjJZw8A6JV4dCdRfdmhMY8sL/f
	 lxF8TgAbAqwrb4psqcRkaq7y45KlGzNthUwyYTuMcIUFpDvufRDikUPYV3nad/tqrg
	 bM1fvLp4aPKRWx+PzdJAZWe5oalGqNC2T7BzHAg2HMGFoQXTOoPOcxaqbQq8LaLf77
	 j0qsCcj4J2tpGBqbkJk+nKSXLcHYWnKD0/aQpKlBfbGdwSLm+hTvmHZYEor9IGQFFA
	 dSBWE9xwK0vBt1hjvvcCz9sCr9cngfNIRmjxINZDQMJJKW/Q2TPRMSSsppDRGeuBTt
	 lrGHLnEPQa//Q==
Subject: Re: [PATCH net-next v3 2/4] vsock/virtio: amortize RX socket locking
 for stream packets
From: netdev-bot+sashiko@kernel.org
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 06:33:00 +0000
Message-ID: <179195958017.434549.14764784523092696104@kernel.org>
In-Reply-To: <20261013063112.168321-3-physicalmtea@gmail.com>
References: <20261013063112.168321-3-physicalmtea@gmail.com>
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

- [Low] The patch is presented as a pure performance optimization
  ("amortize RX socket locking for stream packets").

--

vsock/virtio: amortize RX socket locking for stream packets

The virtio-vsock RX worker now keeps the socket lock and the lookup
reference held across a bounded run of STREAM/RW packets for one socket.
A batch is capped at 64 packets or 64KB of payload. It ends on control
packets, a flow change, or a change in socket state or protocol. Two new
exported functions are added, virtio_transport_recv_pkt_batch() and
virtio_transport_rx_batch_finish().

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a930bc42fdc3..bfe40ecf0b2f0 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -1909,6 +1945,128 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,

[ ... ]

> +	if (batch->sk) {
> +		vsk = vsock_sk(batch->sk);
> +		if (vsock_addr_equals_addr(&src, &vsk->remote_addr) &&
> +		    dst.svm_port == vsk->local_addr.svm_port &&
> +		    vsock_net_check_mode(sock_net(batch->sk), net) &&
> +		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {

[ ... ]

> +		}
> +
> +		virtio_transport_rx_batch_finish(batch);
> +	}
> +
> +	sk = virtio_transport_find_socket(skb, &src, &dst, net);

[ ... ]

> +	lock_sock(sk);
> +	/*
> +	 * Sockmap removal restores the native protocol under sk_callback_lock.
> +	 * Serialize this initial eligibility check with that update.
> +	 */
> +	read_lock_bh(&sk->sk_callback_lock);
> +	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
> +	read_unlock_bh(&sk->sk_callback_lock);
> +
> +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &src, &dst,
> +						    net,
> +						    start_batch ? &batchable : NULL);
> +	if (start_batch && batchable) {
> +		/* Keep the lookup reference until the batch is released. */
> +		batch->sk = sk;
> +		return;
> +	}

[Severity: Low]
Is there data showing this is a net win? The subject says it will
"amortize RX socket locking for stream packets". The commit message
gives no throughput, latency or CPU-cost numbers.

Take interleaved RW traffic from two or more stream flows (A, B, A, B,
...). The cached-flow check above fails on every packet, so each packet
goes through:

virtio_transport_recv_pkt_batch()
    virtio_transport_rx_batch_finish()   /* release_sock + sock_put */
    virtio_transport_find_socket()
    lock_sock()
    read_lock_bh(&sk->sk_callback_lock)
    virtio_transport_recv_pkt_batchable()
    read_unlock_bh(&sk->sk_callback_lock)
    virtio_transport_recv_pkt_locked()
        virtio_transport_recv_pkt_batchable()

Every step of the old per-packet path is still done. On top of that,
each packet pays for the read_lock_bh()/read_unlock_bh() pair, two
predicate checks, and the batch bookkeeping in
virtio_transport_rx_work(). No batch ever grows past one packet.

The socket lock from the previous flow also stays held while
virtio_transport_rx_work() runs virtqueue_get_buf(), tap delivery and
header parsing for the next packet.

The added cost is small next to lock_sock() and the socket lookup. Could
the commit message include measurements, and mention this
interleaved-flow trade-off?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013063112.168321-1-physicalmtea%40gmail.com
