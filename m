Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78350129B;
	Wed, 23 Sep 2026 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167594; cv=none; b=eFSxqhoQSJPA94cIFd6Xsq2EerpIypmUNob+ueK2t5314Jc+3ishbybxYDr+HUknWaanAZUMUhd5eYmLY88Ylkt+unGdfdPHPCInJXCbHeNTr6prg5fLgdX6ekcev+4Qjwl6O57AnJsuYiDwIYQcxN5hzbH2SPyL/bEyXfoPTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167594; c=relaxed/simple;
	bh=t7e1nfGxHNmrDNX6QfK4dqISXW7xeANntYXIlgJBYFI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAyYash9d9JUrA1Zl2T9HWw4mdCueLgjWHaF5Z74jkF0ikTCSmNe2hyDpovEmymjVDpfc5lPRxyJ2kSMtP6uxGu0kFvPDZ8q0zW6qrP3FbPY7w32P8TivyRa2tHNM9yQEkunlf+Wo2hpO24UJ2wJh33+3Hhka8cbQMlopbzqIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrWiKmjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrWiKmjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459301F000FF;
	Wed, 23 Sep 2026 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790167593;
	bh=hvEATMHT8LppXMY0FVV0LoMbdtpDyVnS655+tRllo2k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CrWiKmjHshxqOwkbah01Mw2iJUiDqL6nYF43KbhteUpDjZFlCaN9jtGKpXi2D2qKk
	 E3aaCpH7y6p+UGNXuTTA85f85Y8/bxLGzaKWgQs8ul13j76scKj67o1NTX8iZPyRV5
	 Rc0rGZx4UZMj+vhFeEKoIqFtMqXzIhM2yY2ZwlZxTSS0MQx6d2nWS/tUQ/LzuOLk2p
	 Kfnv2azgZm++VOkmN7f1SK32aXtpNlsPAa8Y2ARugeNTEB4edGhXEuKRuz+W76U8Tq
	 2Mm3iaQgMq0QDOaLSe7E3sqjRk+5Xu2ZLXqOEJvhp7E7GEP3NYJF9Po4dGn0vR0eEG
	 ZY/8NJEJHxr3A==
Subject: Re: [PATCH v2] vsock: keep SOCK_SEQPACKET message boundaries on
 interrupted send
From: netdev-bot+sashiko@kernel.org
To: bartlomiej.dmitruk@isec.pl
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 12:46:31 +0000
Message-ID: <179016759182.2160803.6151329514063340647@kernel.org>
In-Reply-To: <20260919122916.28226-1-bartlomiej.dmitruk@isec.pl>
References: <20260919122916.28226-1-bartlomiej.dmitruk@isec.pl>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] vhost-vsock is left with an unsatisfiable atomic wait: the new
  whole-message wait (`min_space = len - total_written`) in…
- [High] Waiting for whole-message credit does not make the SEQPACKET
  enqueue atomic, so EOM-less orphan fragments — the exact corruption…
- [High] The `len > transport->seqpacket_max_size(vsk)` feasibility test
  is evaluated once at the top of the outer `while (total_written <…
- [Medium] The commit message claims "SOCK_STREAM behaviour is unchanged
  (min_space == 1 reproduces the old 'wait while space == 0')", but that…
- [Medium] Raising the wake-up threshold from 1 byte to the full message
  length makes SEQPACKET send liveness depend on the peer proactively…
- [Low] The patch fixes a user-visible SOCK_SEQPACKET framing bug
  (interrupted credit-limited sends leaving EOM-less fragments that the…

--

vsock: keep SOCK_SEQPACKET message boundaries on interrupted send

The patch makes vsock_connectible_sendmsg() wait until a whole remaining
SOCK_SEQPACKET message fits in the transmit window before enqueuing it, so
an error during the wait leaves no EOM-less fragments behind.  A new
optional seqpacket_max_size() transport op, implemented by the virtio and
loopback transports, is used to reject up front a message that could never
fit, with -EMSGSIZE.

A few questions below.

[Severity: Low]

This fixes a user-visible SEQPACKET framing problem but carries no Fixes:
tag and no Cc: stable.  Should it point at the commit that added SEQPACKET
handling to the generic send loop ("af_vsock: implement send logic for
SEQPACKET"), so backport tooling can pick the affected stable trees?

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9b71479a2b29..01fc9ac6fa2b 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2250,9 +2250,32 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>  
>  	while (total_written < len) {
>  		ssize_t written;
> +		s64 min_space;
> +
> +		if (sk->sk_type == SOCK_SEQPACKET) {
> +			/* A SEQPACKET message must be delivered atomically, so
> +			 * wait until the whole remaining message fits before
> +			 * enqueuing.  Otherwise a credit-limited partial send that
> +			 * later errors out (e.g. -EINTR) leaves EOM-less fragments
> +			 * that the peer merges into the next message.
> +			 *
> +			 * Reject a message that can never fit up front so the wait
> +			 * below cannot block forever (a peer may advertise a small
> +			 * buf_alloc); this mirrors the -EMSGSIZE the transport
> +			 * returns for an oversized message.
> +			 */
> +			if (transport->seqpacket_max_size &&
> +			    len > transport->seqpacket_max_size(vsk)) {
> +				err = -EMSGSIZE;
> +				goto out_err;
> +			}

[Severity: High]

The new wait threshold below applies to every SOCK_SEQPACKET socket, but
this -EMSGSIZE escape is gated on the new optional op.  vhost_transport in
drivers/vhost/vsock.c does not register it:

	.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
	.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
	.seqpacket_allow          = vhost_transport_seqpacket_allow,
	.seqpacket_has_data       = virtio_transport_seqpacket_has_data,

so transport->seqpacket_max_size is NULL there and this branch is skipped,
while min_space still becomes len - total_written.

What happens on a host-side SEQPACKET sendmsg() whose len exceeds the
window?  vsock_stream_has_space() -> virtio_transport_stream_has_space() ->
virtio_transport_has_space() is capped by virtio_transport_tx_buf_size() =
min(peer_buf_alloc, buf_alloc):

net/vmw_vsock/virtio_transport_common.c:virtio_transport_has_space() {
	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
		(vvs->tx_cnt - vvs->peer_fwd_cnt);
	...
}

Can the loop condition vsock_stream_has_space(vsk) < min_space ever become
false in that case?  A blocking sender would sleep in wait_woken() until
SO_SNDTIMEO or a signal, and a non-blocking one would keep getting -EAGAIN,
where before this change virtio_transport_seqpacket_enqueue() returned
-EMSGSIZE immediately.

Since peer_buf_alloc is taken verbatim from peer headers in
virtio_transport_space_update(), can a guest advertising a small buf_alloc
hold a host process inside sendmsg()?

Does tools/testing/vsock/vsock_test.c:test_seqpacket_bigmsg_client() still
pass on vhost-vsock?  It expects the immediate error:

	send_buf(fd, data, buf_size, 0, -EMSGSIZE);

> +			min_space = len - total_written;
> +		} else {
> +			min_space = 1;
> +		}

[Severity: High]

Does waiting for whole-message credit actually make the enqueue atomic?
virtio_transport_send_pkt_info() still splits the payload into
VIRTIO_VSOCK_MAX_PKT_BUF_SIZE (64K) chunks and hands each skb to send_pkt()
as it goes, and EOM is stamped only on the chunk where the iterator drains:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_alloc_skb() {
	if (msg_data_left(info->msg) == 0 &&
	    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
		hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
	...
}

If a later chunk fails, the loop breaks but the error is replaced by a
positive partial count:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_send_pkt_info() {
	skb = virtio_transport_alloc_skb(...);
	if (!skb) {
		ret = -ENOMEM;
		break;
	}
	...
	/* Return number of bytes, if any data has been sent. */
	if (rest_len != pkt_len)
		ret = pkt_len - rest_len;
}

So for a message larger than 64K whose second fragment hits -ENOMEM, or a
copy failure on an unmapped part of the user iovec, doesn't this loop see
written > 0, add it to total_written, recompute min_space and re-enter the
wait with EOM-less fragments already at the peer?  Any later out_err exit
(-EINTR, -EAGAIN, sk_err, peer RCV_SHUTDOWN) then abandons them, and
virtio_transport_seqpacket_do_dequeue() only advances msg_count on an EOM
skb:

	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
		msg_ready = true;
		vvs->msg_count--;

virtio_transport_get_credit() can also grant less than requested if the
window shrank after the wait:

	ret = min_t(u32, credit, virtio_transport_has_space(vvs));

which produces the same short, EOM-less write.

Separately, the size test above compares the full len rather than
len - total_written, so on a second iteration a shrunken maximum can return
-EMSGSIZE in the middle of a partially transmitted message.  Should the
transport enqueue itself be made transactional (emit EOM or discard on
abort) instead of, or in addition to, extending the wait here?

>  
>  		add_wait_queue(sk_sleep(sk), &wait);
> -		while (vsock_stream_has_space(vsk) == 0 &&
> +		while (vsock_stream_has_space(vsk) < min_space &&
>  		       sk->sk_err == 0 &&
>  		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
>  		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {

[Severity: Medium]

The commit message says:

  "SOCK_STREAM behaviour is unchanged (min_space == 1 reproduces the old
  "wait while space == 0")"

Is that accurate for transports whose stream_has_space() can return a
negative error?  The comparison is signed, so < 1 is also true for negative
values, while the old == 0 test was not.  vsock_stream_has_space() passes
the raw s64 through, and VMCI does not clamp:

net/vmw_vsock/vmci_transport.c:vmci_transport_stream_has_space() {
	return vmci_qpair_produce_free_space(vmci_trans(vsk)->qpair);
}

vmci_q_header_free_space() returns a negative error when the shared
queue-pair indices are out of range:

include/linux/vmw_vmci_defs.h:vmci_q_header_free_space() {
	if (tail >= produce_q_size || head >= produce_q_size)
		return VMCI_ERROR_INVALID_SIZE;
}

Before this change that negative value skipped the wait and
vmci_transport_stream_enqueue() reported -ENOMEM to userspace.  With the
new test, doesn't a blocking STREAM sender sleep instead (sk_err is 0 and
no shutdown bit is set), and a non-blocking one get -EAGAIN?

[Severity: Medium]

Raising the wake threshold from one byte to the full message length also
makes SEQPACKET send liveness depend on the peer advertising enough credit
on its own.  Linux never sends VIRTIO_VSOCK_OP_CREDIT_REQUEST:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_notify_send_pre_block() {
	return 0;
}

So a sender blocked on vsock_stream_has_space(vsk) < len cannot solicit a
credit refresh.  For a peer whose credit-update policy uses hysteresis
(the same heuristic Linux uses on its stream receive path, updating only
when free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes), can the
cached peer_fwd_cnt/peer_buf_alloc stay below len with no further packets
arriving, now that the partial data that used to keep the exchange moving
is no longer sent?  Linux peers mask this because
virtio_transport_seqpacket_do_dequeue() calls
virtio_transport_send_credit_update() unconditionally, so the exposure
looks limited to non-Linux peers.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index f225f53ed4ba..e10e7b95807e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -994,6 +994,19 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
>  
> +u32 virtio_transport_seqpacket_max_size(struct vsock_sock *vsk)
> +{
> +	struct virtio_vsock_sock *vvs = vsk->trans;
> +	u32 max_size;
> +
> +	spin_lock_bh(&vvs->tx_lock);
> +	max_size = virtio_transport_tx_buf_size(vvs);
> +	spin_unlock_bh(&vvs->tx_lock);
> +
> +	return max_size;
> +}
> +EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_max_size);

[Severity: High]

This returns a snapshot of min(peer_buf_alloc, buf_alloc) taken under
tx_lock, and the lock is dropped before the value is used.  The feasibility
test in vsock_connectible_sendmsg() runs once per outer iteration, before
add_wait_queue(), and the inner predicate only re-reads
vsock_stream_has_space(), sk_err and the shutdown bits.  Meanwhile the wait
releases the socket lock:

	release_sock(sk);
	timeout = wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
	lock_sock(sk);

During that window the bound can shrink from the peer side:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_space_update() {
	vvs->peer_buf_alloc = le32_to_cpu(hdr->buf_alloc);
	vvs->peer_fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
}

or locally via setsockopt(SO_VM_SOCKETS_BUFFER_SIZE):

net/vmw_vsock/virtio_transport_common.c:virtio_transport_notify_buffer_size() {
	vvs->buf_alloc = *val;
}

Consider sendmsg(len = 128K) passing the check with a 256K window, then
sleeping; a peer credit update lowers peer_buf_alloc to 64K and wakes the
sender.  The sender re-tests only vsock_stream_has_space(vsk) < min_space,
which virtio_transport_has_space() can no longer satisfy, sk_err is 0 and
no shutdown bit is set, so doesn't it sleep again indefinitely with the
default infinite SO_SNDTIMEO?  Before the patch the sender either made
partial progress or got -EMSGSIZE from
virtio_transport_seqpacket_enqueue().

Would it work to fold the maximum-size test into the wait predicate, so it
is re-evaluated after each wakeup under the same lock that computes the
available space?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919122916.28226-1-bartlomiej.dmitruk%40isec.pl
