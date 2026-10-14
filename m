Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373341442E;
	Wed, 14 Oct 2026 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959594; cv=none; b=AniO4a50yu4Wul49G24RqmjWnp/tlGxfu+4Rc9iZVaKxupk04aE/m/zK0DTvF5uj8kLxY2487m7LpxM+RnS87oAeSsi/ScB/iDsi4ybkABJKYMapwnYBugpsEgJLf4SaqgRuw0YERIuFJqGvMUO8+BE2ArhPqQFnuPaoDKJMYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959594; c=relaxed/simple;
	bh=cAIywBzkCt8Lviyejkt3agFeuwMEaHmMiq6vSrZ5EbU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hps4cUqgXXKSNjkcEwxDIKejC2WMU19+jOczLAy5Ksy8KbhrqxXZGympQr147ua1sdwuQUu5uhxi362p+rPj73q/eZ+e4QnAIlLkyFVxSOIMC5/Mn5HtLXBmibf0Qie8RYPYxTeYUv3b5DNutPAB7BnOws2XWE2JlJ2eDa5JprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsRFwhyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsRFwhyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237701F00893;
	Wed, 14 Oct 2026 06:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791959583;
	bh=wI/vaaNxrZHGSu+C0IaS6QHTgleVRRrjMvxvMj4WfWg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BsRFwhyPkz3wH0IUyX9xdqPn1Or+3kjS/Y/Pjv55NflWdb3M9brdQzxiE4Jj0P4bM
	 clVi8M9a/74g3DW7IjVxQJLzp8Yn6eV+eJpYbILyMbsXSomQ/QcYKToX8zoFHeHKeT
	 co4LL5f+g5U4csS9GpF8qUAAGfYghD9fv7Clv+mM4a9c1ytuSWZPx+WAf2v8mDuN6H
	 xlj7XQ8cEpteFGe5VYEl6IEtw8hM95eXEoFJ9jvgcDOc3+pNX6RN8+vXZPdmttFTOb
	 DJ1+pg6jevwqLi9qK6lWDu3bLPDYvBcFuEJnF0xibVG/Mh3gO7radYC2Zlm1X2cP4l
	 Vlm0OkAHkXBlw==
Subject: Re: [PATCH net-next v3 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
From: netdev-bot+sashiko@kernel.org
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 06:33:01 +0000
Message-ID: <179195958167.434549.3993403899530916978@kernel.org>
In-Reply-To: <20261013063112.168321-4-physicalmtea@gmail.com>
References: <20261013063112.168321-4-physicalmtea@gmail.com>
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

- [Low] The patch is presented purely as a performance optimisation but
  gives no numbers.
- [Low] Retained for the separate validation policy; my baseline decision
  is that this is not a real defect.
- [Low] The patch changes the behaviour of three interfaces without
  updating their comments.

--

vsock/virtio: coalesce RX write-space notifications in lock batches

This commit stops calling sk_write_space() for every packet in a virtio
vsock RX lock batch. It records one pending notification and delivers it
through the saved default callback before release_sock(). The default
callback is saved in __vsock_create(), and sockets whose sk_write_space
has been replaced are no longer eligible for batching.

> Each received packet updates peer credit and calls sk_write_space() when
> send space is available. A writer cannot use the newly advertised credit
> until the socket lock is released, so repeated callbacks within one lock
> batch cannot let it make progress sooner.

[Severity: Low]
This shows that the change is safe, but are there any numbers showing it
helps? Neither this commit message nor the other three in the series
gives throughput, CPU or wakeup-count data, or names a workload where
per-packet sk_write_space() costs something measurable.

The change does have costs. Every struct vsock_sock gets a new function
pointer, including VMCI and Hyper-V sockets, but only the virtio RX batch
path reads it. virtio_transport_recv_pkt_batchable() gets one more
admission condition. The wakeup moves to
virtio_transport_rx_batch_finish().

The callback being coalesced is also cheap when nobody is waiting.
sock_def_write_space() only calls sock_writeable(), skwq_has_sleeper()
and sk_wake_async_rcu().

Documentation/process/submitting-patches.rst says:

  Quantify optimizations and trade-offs. If you claim improvements in
  performance ... include numbers that back them up. But also describe
  non-obvious costs.

Could the commit message include measurements that justify the extra
per-socket field?

> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 5549298c1ec6b..9d8ae62209eda 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -63,6 +63,8 @@ struct vsock_sock {
>  	u32 peer_shutdown;
>  	bool sent_request;
>  	bool ignore_connecting_rst;
> +	/* Initial callback, used to identify replacements. */
> +	void (*default_write_space)(struct sock *sk);

[Severity: Low]
This comment only describes the identification role.
virtio_transport_rx_batch_finish() also calls this pointer to deliver
deferred notifications. Should the comment say that too?

Two other comments are also unchanged by this patch.

The comment above the exported virtio_transport_rx_batch_finish() still
reads:

  For a non-empty batch, the caller must hold the socket lock acquired with
  lock_sock(). This function releases the lock and the batch's lookup
  reference.

It does not say that a write-space callback now runs from this function
while the socket lock is still held. At the end of the series it also
runs a data-ready callback after release_sock(), and the comment is
still the same.

The comment above virtio_transport_recv_pkt_locked() documents
@batchable and the return value, but not the new @batch parameter:

  The caller holds sk's socket lock.  Set @batchable if the socket can remain
  locked for another ordinary STREAM/RW packet.  Return true if the caller
  must free @skb.

A non-NULL @batch suppresses the immediate sk->sk_write_space() call and
defers it to batch finish. Could these comments be updated to match?

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index bfe40ecf0b2f0..d6ebfde880db6 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -1860,8 +1862,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>  	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>  		vsk->local_addr.svm_cid = dst->svm_cid;
>  
> -	if (space_available)
> -		sk->sk_write_space(sk);
> +	if (space_available) {
> +		if (batch)
> +			batch->write_space_pending = true;
> +		else
> +			sk->sk_write_space(sk);
> +	}

[ ... ]

> @@ -1954,15 +1960,20 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>   */
>  void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>  {
> +	bool write_space_pending = batch->write_space_pending;
>  	struct sock *sk = batch->sk;
>  
>  	batch->sk = NULL;
>  	batch->pkts = 0;
>  	batch->bytes = 0;
> +	batch->write_space_pending = false;
>  
>  	if (!sk)
>  		return;
>  
> +	if (write_space_pending)
> +		vsock_sk(sk)->default_write_space(sk);

[Severity: Low]
Is it intended to call the saved default callback here rather than the
current sk->sk_write_space?

sock_map_update_elem() from BPF takes only bh_lock_sock(). It can
therefore attach a psock while the RX batch holds lock_sock(). In that
case sk_psock_start_verdict() does:

	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);

A notification latched for a packet admitted before the attach would
then skip sk_psock_write_space(), which is what schedules psock->work.

>From a closer look, this may be harmless:

- virtio_transport_sock_has_psock() is checked at every packet
  boundary, and the psock is published before sk_write_space is
  replaced. So only a packet admitted before that point can leave a
  pending notification. That is the same outcome as the pre-series case
  where the attach lands just after that packet's own sk_write_space()
  call.

- The next packet fails admission and takes the non-batched path, which
  calls the new sk_psock_write_space().

- sk_psock_backlog() reschedules itself with
  schedule_delayed_work(&psock->work, 1) on -EAGAIN. It is also
  scheduled on enqueue, so psock TX should not stall.

- sk_psock_write_space() forwards to psock->saved_write_space, so
  user-space writers get the same wakeup either way.

If that reasoning holds, would a short comment explaining why it is safe
to bypass a callback installed mid-batch help future readers?

> +
>  	release_sock(sk);
>  	sock_put(sk);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013063112.168321-1-physicalmtea%40gmail.com
