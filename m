Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD145FFC1;
	Sun, 11 Oct 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728755; cv=none; b=Al0qKe7TWNyqurqAB6XPmBmZZ5OCb/irPqIOSVE79uEPtn5jnpucl4i1bBp+sfLAnpz2ToqQTqsRs6/O7jqkSlFUSJk8ic+PALeBAGmJXT+52dbxvXyqj8chsGqLpmxL2iP6yPoCUecZXhLlDcrsxWnoJqexg7UFGhBnmvMYpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728755; c=relaxed/simple;
	bh=Lito27FAcJjJgFKmuwJxNqlg4XB1uwuMiZ4brDv6PYI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/XMDhlzIwFcXka7PBYRnQCtpTQnxPuR3cEzVsixPMV8Bsscw13h3v1MLZu1uTqF6eH7KvvpUBvJEGCicKN2uVjg9ywB/UUDieYZALNjoTqhVWiE3ujv7fab9reR8MdfOuhvnBS+FdZt7BQPAkgrok6xtrXV2gTQNnt80+Ix/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivZkunCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivZkunCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736FE1F0089B;
	Sun, 11 Oct 2026 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791728753;
	bh=vMTPsdj6wCJsOSGzLMqIJMkvsXUZ4bZ2rafitDf6kq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ivZkunCJcA9HcgLmUv7jdH9+q3b9v8P1A4FDNlgpfX2BxSy5OZcNme+sAlnBuzXAV
	 3mUVnOD5AM+cekKmc5i6XDzu7Ek/MEjCD/3wMv0EWL20RgRxqIHHUalZcCpAholfn/
	 3tvZCDmNljS8fVoADHUO9wCOL9I47t468PJdpelgEI15/VAIeoavu6xntpx24MeEpd
	 dP+ow+kYCM+uCEx6Iui7QUbl88fso4TB2jsvWzeKDQ2D/nTYI9BkQ+Ph00vt634E5p
	 eGxqcVoIulpYs0hb2K7gM0oHK7e08//PMJZWLFNpqo5uIRhg89Dff2y7kEoNqrWO2c
	 4Ik/8+MhfT93w==
Subject: Re: [PATCH net-next v2 5/5] vsock/virtio: defer RX readable
 notifications until batch unlock
From: netdev-bot+sashiko@kernel.org
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 14:25:52 +0000
Message-ID: <179172875205.434549.8636973340087490564@kernel.org>
In-Reply-To: <20261010142247.99223-6-physicalmtea@gmail.com>
References: <20261010142247.99223-6-physicalmtea@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new attach-time handoff passes partially read skbs to
  read_skb, which ignores the read offset.
- [Medium] Sockmap attach/detach now drains queued data on every vsock
  socket, and the commit message wrongly says non-batched sockets keep…
- [Low] The commit message says "Sampling at batch finish takes
  sk_callback_lock once." That holds only on the native path.
- [Low] vsock_rx_callback_handoff() calls sk_data_ready without the
  sk_rcvlowat/SOCK_DONE check that vsock_data_ready() and the per-packet…

Pre-existing issues:
- [Medium] vsock_rx_callback_handoff() reads sk_data_ready under
  read_lock_bh(&sk->sk_callback_lock), releases the lock, and only then…

--

vsock/virtio: defer RX readable notifications until batch unlock

During virtio vsock RX batches, this commit holds back the native
sock_def_readable() notification until the batch has dropped the socket
lock. If sk_data_ready or sk_write_space has been replaced, for example
by sockmap, a new vsock_rx_callback_handoff() passes queued skbs to the
current callback one at a time. vsock_bpf_update_proto() now schedules
that handoff on sockmap attach and detach.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index fe7f49da6c4bc..df6faee0bd37a 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -931,6 +931,107 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)

[ ... ]

> +/* Caller holds lock_sock(). */
> +void vsock_rx_callback_handoff(struct sock *sk)
> +{
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	void (*write_space)(struct sock *sk);
> +	void (*data_ready)(struct sock *sk);
> +	bool wrote = false;
> +	s64 before, after;
> +	int i;
> +
> +	if (sock_flag(sk, SOCK_DEAD) || !vsk->transport)
> +		return;
> +
> +	read_lock_bh(&sk->sk_callback_lock);
> +	data_ready = READ_ONCE(sk->sk_data_ready);
> +	if (READ_ONCE(sk->sk_prot) != sk->sk_prot_creator &&
> +	    data_ready == vsk->default_data_ready) {
> +		read_unlock_bh(&sk->sk_callback_lock);
> +		/*
> +		 * start_verdict publishes sk_data_ready after the proto swap.
> +		 * Retry once before treating this as a stable non-RX setup.
> +		 */
> +		if (!vsk->rx_cb_retried) {
> +			vsk->rx_cb_retried = true;
> +			vsock_rx_callback_queue(sk, 1);
> +			return;
> +		}
> +		vsk->rx_cb_retried = false;
> +		data_ready(sk);
> +		return;
> +	}
> +	read_unlock_bh(&sk->sk_callback_lock);
> +	vsk->rx_cb_retried = false;
> +
> +	for (i = 0; i < VSOCK_RX_CB_HANDOFF_MAX; i++) {
> +		read_lock_bh(&sk->sk_callback_lock);
> +		data_ready = READ_ONCE(sk->sk_data_ready);
> +		write_space = READ_ONCE(sk->sk_write_space);
> +		read_unlock_bh(&sk->sk_callback_lock);

[Severity: Medium]
This is a pre-existing issue, but sk_callback_lock here only covers
reading the pointers, not calling them. Can a concurrent sockmap delete
restore sk_data_ready and clear the psock between this read_unlock_bh()
and the data_ready(sk) call below?

The delete path takes only write_lock_bh(&sk->sk_callback_lock), not
lock_sock():

__sock_map_delete()
  sock_map_unref()
    sock_map_del_link() / sk_psock_drop()

In that case the stale sk_psock_verdict_data_ready() still dequeues an
skb through virtio_transport_read_skb(). That lowers rx_bytes and sends a
credit update. sk_psock_verdict_recv() then finds no psock:

net/core/skmsg.c:sk_psock_verdict_recv() {
    ...
	if (unlikely(!psock)) {
		len = 0;
		tcp_eat_skb(sk, skb);
		sock_drop(sk, skb);
		goto out;
	}
    ...
}

So the skb is dropped after it has already been credited to the peer.

The baseline vsock_data_ready() has the same window. It calls
sk->sk_data_ready(sk) under lock_sock() without sk_callback_lock, and
tcp_data_ready() has the same issue. This patch adds more call sites
with the same pattern: the attach-kicked work item and the batch-finish
handoff. Taking the read lock here can also make it look as if the call
is protected when it is not.

> +
> +		if (!wrote && write_space != vsk->default_write_space) {
> +			write_space(sk);
> +			wrote = true;
> +		}
> +		if (data_ready == vsk->default_data_ready) {
> +			data_ready(sk);
> +			break;
> +		}
> +		before = vsock_stream_has_data(vsk);
> +		if (before <= 0)
> +			break;
> +		data_ready(sk);

[Severity: Low]
Neither of these data_ready(sk) calls checks sk->sk_rcvlowat or
SOCK_DONE, unlike vsock_data_ready() and the per-packet path in
virtio_transport_recv_connected(). Is that intended?

For a replaced callback such as the sockmap verdict, data_ready(sk) runs
whenever vsock_stream_has_data() > 0. The verdict program can then see
data below SO_RCVLOWAT that the per-packet path would hold back.

For the default callback the call is unconditional, both here and in the
retry branch above:

		vsk->rx_cb_retried = false;
		data_ready(sk);
		return;

Doesn't this wake readers when no readable event was pending? That
happens on every attach and restore kick from vsock_bpf_update_proto().
It also happens when virtio_transport_rx_batch_finish() enters the
handoff with only write_space_pending set.

> +		after = vsock_stream_has_data(vsk);
> +		if (after >= before)
> +			break;

[Severity: High]
Can this hand a partially read skb to read_skb?

A native stream read can consume only part of the head skb. In that
case virtio_transport_stream_do_dequeue() advances the private offset,
leaves the skb queued, and lowers rx_bytes only by the bytes copied:

		VIRTIO_VSOCK_SKB_CB(skb)->offset += bytes;
		...
		virtio_transport_dec_rx_pkt(vvs, bytes, dequeued);

If the socket is then added to a sockmap with a verdict program, the new
kick in vsock_bpf_update_proto() runs this loop:

vsock_rx_callback_work()
  vsock_rx_callback_handoff()
    sk_psock_verdict_data_ready()
      vsock_read_skb()
        virtio_transport_read_skb()

virtio_transport_read_skb() does not look at the offset:

	pkt_len = le32_to_cpu(hdr->len);
	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
	...
	return recv_actor(sk, skb);

Take a 1000 byte skb with 400 bytes already read, so rx_bytes is 600.
The verdict program sees all 1000 bytes, 400 of them a second time. The
u32 rx_bytes then wraps to 4294966896.

The after >= before check above sees no progress and stops. But
vsock_stream_has_data() now reports about 4GB, so poll stays readable.
The next native read hits WARN_ONCE("rx_queue is empty, but rx_bytes is
non-zero") and returns -EFAULT.

The offset handling in virtio_transport_read_skb() predates this patch.
In the baseline the same corruption needs a partial read, then an
attach, then another packet from the peer. With this patch the extra
packet is no longer needed, and the new attach-time drain depends on
read_skb handling already-queued skbs correctly.

> +		if (i == VSOCK_RX_CB_HANDOFF_MAX - 1 && after > 0)
> +			vsock_rx_callback_queue(sk, 0);
> +	}
> +}

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e5637291f3185..6b96d8ac0d598 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -1986,33 +2007,45 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);

[ ... ]

> -	if (write_space_pending) {
> -		vsk = vsock_sk(sk);
> +	vsk = vsock_sk(sk);
> +	if (write_space_pending)
>  		vsk->default_write_space(sk);
> -		write_space = READ_ONCE(sk->sk_write_space);
> -		if (write_space != vsk->default_write_space)
> -			write_space(sk);
> +
> +	read_lock_bh(&sk->sk_callback_lock);
> +	native = vsock_rx_cb_is_native(sk);
> +	read_unlock_bh(&sk->sk_callback_lock);
> +
> +	if (native) {
> +		release_sock(sk);
> +		if (data_ready_pending)
> +			vsk->default_data_ready(sk);
> +		sock_put(sk);
> +		return;
>  	}
>  
> +	if (write_space_pending || data_ready_pending)
> +		vsock_rx_callback_handoff(sk);

[Severity: Low]
The commit message says:

    Sampling at batch finish takes sk_callback_lock once.

Does that hold on the non-native path? sk_callback_lock is taken once
here for vsock_rx_cb_is_native(). vsock_rx_callback_handoff() then takes
it again at the top. It takes it once more on each loop iteration, up
to VSOCK_RX_CB_HANDOFF_MAX (64) times, and the requeued work can do all
of this again.

[ ... ]

> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 9049d26486460..7770a6c51dbe5 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -154,6 +154,7 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
>  	if (restore) {
>  		sk->sk_write_space = psock->saved_write_space;
>  		sock_replace_proto(sk, psock->sk_proto);
> +		vsock_rx_callback_kick(sk);
>  		return 0;
>  	}
>  
> @@ -166,6 +167,7 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
>  
>  	vsock_bpf_check_needs_rebuild(psock->sk_proto);
>  	sock_replace_proto(sk, &vsock_bpf_prot);
> +	vsock_rx_callback_kick(sk);
>  	return 0;
>  }

[Severity: Medium]
These kicks run for every AF_VSOCK socket added to or removed from a
sockmap or sockhash, not only for sockets in a virtio RX batch. Is this
change in behaviour intended?

RX batching exists only in the guest virtio transport
(virtio_transport_rx_work() -> virtio_transport_recv_pkt_batch()).
vhost_vsock and vsock_loopback always use virtio_transport_recv_pkt().
Both still set .read_skb = virtio_transport_read_skb, so their sockets
reach this code too. The same is true of SOCK_SEQPACKET sockets, which
virtio_transport_recv_pkt_batchable() rejects.

Before this patch, sk_data_ready was not called by either path:

sock_map_link() -> sock_map_init_proto() -> vsock_bpf_update_proto()
sk_psock_start_verdict()

Data queued before attach only reached the verdict program when a later
packet arrived.

Now the kick pushes that data through sk_psock_verdict_data_ready(), up
to 64 skbs per pass, and requeues itself if data remains. The verdict
program can redirect or drop data that arrived before attach, where it
used to stay for the native reader.

If only the prot was swapped, for example with a msg_parser-only map,
the handoff calls the default callback unconditionally after one retry.
That adds an extra wakeup on every attach and detach.

The commit message says "non-batched sockets keep their existing
behavior". It also says the handoff is scheduled "so an attach or detach
outside the worker still drains skbs already queued".

Neither statement seems to fit what the code does: this is a new sockmap
behaviour for every vsock transport that has read_skb, and the subject
line does not mention it. Could this be split out, or at least
described in the commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010142247.99223-1-physicalmtea%40gmail.com
