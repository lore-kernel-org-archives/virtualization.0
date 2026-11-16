Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825356;
	b=5NKj+8kCT0vVfxxp+jXRnHYNtMrC/2XwvRuqeu+nccOjmGevAxSExuCbIfSuhKMTIr21
	 9fj7Jksfwuo2gApXjuwm4toa4apB0gokciHEWR0WWPaqVDgWS/evK/6qbg25IOK6hw4ai
	 E08mdew5nwNPsdRuLFJXJOV9Bf1tApzbxCih3jTp10GEzmFHaUjix5QA7ugCnzS7xWOu7
	 lwHuhOFv4DRCRYRlbglYXsNt0fltCwlfm/Scp9G9ZSfxcwfunOXgyeny/9OxSGXKOKLKQ
	 VPrQO9JfH6kUhXin26Am7N8KfxPQf8al4eu8qoNa+YplnjhF5Tfu01nMkiwt+Y1l2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825356;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yJIFDAZTBBUc/zWvcjI+JoSUsDm2VmZ4BHMBL+zYoOg=;
	b=JlzsWN0aYZb+Uu/J4Bb3pkxxvS5/oE4kXRb6wGNZHi4ctl8sTAZOlbp6nCTxes5pKnll
	 523k8g4Upd3qWJBvvJhP2r9A8+sEJcdIkd2G8fda0NMXnh01M9wzv5GEQuiMd6TPvIg0T
	 xbFjGNqJyuIe40/eRSO0WAIB5tliwOPhHxFbyz0cs74/imrJlUu51PHaF800bLdYJqPF8
	 AOFA+8qpxycPuzd2eKTuDmQIzanfsY+ks/Ov8WD4NtRFtYHIydL4qs/xDfNcDKuNdMRcT
	 7G8vMD66m+5Vx2ucaHbU5z3yEUvpC3gLtgnm5FbPWh/aIG23uiKfCmLxvA4dmltdG1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi9FfVIk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E2606A330;
	Mon, 16 Nov 2026 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi9FfVIk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E732E1F000C4;
	Mon, 16 Nov 2026 10:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825356;
	bh=yJIFDAZTBBUc/zWvcjI+JoSUsDm2VmZ4BHMBL+zYoOg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zi9FfVIkSFfbDd7ubsUktRGMsIHDCNUtu3OnboGf8dkzTfs49fP0b0t5egcZr7qsl
	 FgA4oO2ko3m9qeqW79ZZQsdSpH+mKFLNJXxWXCgGvOFUVIRUN40XwJyyUW6zpoa7Fl
	 6S34lMcF5leGhdSQXICkEZ+lQOkiltt65hmsc5eRiBg/SlBDA0grcBIgrD7nl5JEfe
	 7J559ahYAea0l7MzcGcOVYrynXKwS3nFU08qGujnDW7or4fJpYwf9CgDdIHdGP8ljV
	 WJj6n/ndblsiL6B+v70t1tWG1KZsyump1VDDjlpWZCTrv6SGVrKYkhz91SmFLwfPB0
	 yENSLcOVbymag==
Subject: Re: [PATCH net] vhost/vsock: Fix socket state constant
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, bobbyeshleman@meta.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 davem@davemloft.net, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 16 Nov 2026 10:35:55 +0000
Message-ID: <179482535544.3136.14958523425614003338@kernel.org>
In-Reply-To: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
References: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Writing TCP_CLOSE plus sk_err = ECONNRESET in
  vhost_vsock_reset_orphans() (drivers/vhost/vsock.c:792-793) brings…
- [Medium] vhost_vsock_reset_orphans() now moves every orphaned connected
  socket to TCP_CLOSE unconditionally, after setting SOCK_DONE, even…

--

vhost/vsock: Fix socket state constant

This patch replaces SS_UNCONNECTED with TCP_CLOSE in
vhost_vsock_reset_orphans(). SS_UNCONNECTED has the value 1, which is the
same as TCP_ESTABLISHED. So far, orphaned sockets have been left in the
established state after the vhost device was released.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 88a310390eb0a..fd224f7681d92 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -789,7 +789,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
>  
>  	sock_set_flag(sk, SOCK_DONE);
>  	vsk->peer_shutdown = SHUTDOWN_MASK;
> -	sk->sk_state = SS_UNCONNECTED;
> +	sk->sk_state = TCP_CLOSE;

[Severity: High]
Can this let connect() reset a socket that is still linked in
vsock_connected_table? Commit 4f6ac74fa594 ("vsock: treat TCP_CLOSING as
once-established") fixed that problem for the other close paths.

vhost_vsock_reset_orphans() runs without lock_sock(). Suppose it runs
after virtio_transport_recv_connecting() has handled a RESPONSE, but
before the waiter in vsock_connect() gets the socket lock back:

vhost TX worker
virtio_transport_recv_connecting()
    sk->sk_state = TCP_ESTABLISHED;
    sk->sk_socket->state = SS_CONNECTED;
    vsock_insert_connected(vsk);

vhost_vsock_dev_release()
  vhost_vsock_reset_orphans()
    sk->sk_state = TCP_CLOSE;
    sk->sk_err = ECONNRESET;

The waiter then fails the TCP_ESTABLISHED/TCP_CLOSING check and ends up
here:

net/vmw_vsock/af_vsock.c:vsock_connect() {
    ...
	err = sock_error(sk);
	if (err) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}
    ...
}

connect() returns -ECONNRESET, but the socket is still in the connected
table. With the old value (1 == TCP_ESTABLISHED), connect() returned 0 and
the socket stayed SS_CONNECTED.

After that, ordinary API calls seem to be enough to insert the socket a
second time:

1. A second connect(): sock->state is SS_UNCONNECTED, so it does not get
   -EISCONN. vsock_assign_transport() returns early because the transport
   is the same. That skips both vsock_remove_sock() and
   sock_reset_flag(sk, SOCK_DONE).

2. shutdown() while the socket is SS_CONNECTING: vsock_shutdown() calls
   sock_reset_flag(sk, SOCK_DONE). Without that flag,
   virtio_transport_recv_pkt() no longer drops the incoming RESPONSE.

3. A RESPONSE from a guest with that CID reaches
   virtio_transport_recv_connecting() in TCP_SYN_SENT. It calls
   vsock_insert_connected() a second time.

__vsock_insert_connected() then does an unconditional sock_hold() and
list_add() on a node that is already linked, which corrupts the bucket.

Any later walk of that bucket under vsock_table_lock can then loop forever,
for example in vsock_find_connected_socket() or
vsock_for_each_connected_socket(). With CONFIG_DEBUG_LIST it hits the
list_add double add BUG instead. One socket reference is also leaked.

Only the first step depends on timing, a race with VM teardown. The rest
is normal use of the socket API.

> +	sk->sk_state = TCP_CLOSE;

[Severity: Medium]
Does this drop data that is still queued in the socket's rx_queue?

vhost_vsock_reset_orphans() now sets SOCK_DONE and then moves the socket
to TCP_CLOSE unconditionally. __vsock_connectible_recvmsg() then returns
early without dequeuing anything:

net/vmw_vsock/af_vsock.c:__vsock_connectible_recvmsg() {
    ...
	if (!transport || sk->sk_state != TCP_ESTABLISHED) {
		...
		if (sock_flag(sk, SOCK_DONE))
			err = 0;
		else
			err = -ENOTCONN;

		goto out;
	}
    ...
}

So recv() returns 0 (EOF), and sk_err is not reported there.

The other close paths only leave the readable state when no data is
pending:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_do_close() {
    ...
	if (vsock_stream_has_data(vsk) <= 0)
		sk->sk_state = TCP_CLOSING;
    ...
}

hvs_do_close_lock_held() in hyperv_transport.c has the same check.
vmci_transport_handle_detach() skips the check only on the host side,
where queue-pair data can't be read once the VM detaches. With vhost, the
data is still in host-kernel skbs and can be read.

One way to hit this:

1. The guest writes data and sends SHUTDOWN.
   virtio_transport_recv_connected() keeps the socket TCP_ESTABLISHED
   because data is pending.

2. The VM exits, or the VMM closes the vhost fd.
   vhost_vsock_dev_release() calls vhost_vsock_reset_orphans().

3. The host application's next recv() returns 0, and the end of the
   stream is lost.

With the old value the socket stayed TCP_ESTABLISHED, so the application
could read the remaining data before seeing EOF.

On the guest side, virtio_vsock_reset_sock() also sets TCP_CLOSE
unconditionally on a transport reset, so this may be the intended reset
behaviour. It is still different from the RST path, which keeps queued
data readable.

Should vhost_vsock_reset_orphans() check vsock_stream_has_data() the way
the other transports do?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-transport-reset-state-fix-v1-1-5698375f52a9%40rbox.co
