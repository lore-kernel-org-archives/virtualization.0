Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369920;
	b=fU5G0eMzhzr+o//eFdChFYd5kjMYBvQ+Fp+r4Pn4cT8VtOPU7Tcr1GCQwJwR98YwhesK
	 ufVa8MUxk4nkbivps50zcHGWwBNLSn56zWpavnaZsmmlVk36GMvFPS6ZQPam3IJuCeXim
	 BXLxvDEgalStIUDzUojADLn9st+Z/LHVsKcPYXZ2Cm+uBX631bwzoZop08RW75AuAVCpH
	 2RRy8I79ZKcMTYGWjaidfbHlE6ODz54JV1PEFbeMI6PosY6ZmESgOxKqqTCXIbi4KgDym
	 JJNrJArsCZ+q7D/cvHH28htYxdWubuycXUu1Iq/DBrfimB9xKklsd3lywJC3ZRY1w8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369920;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=0Ql7QE+ZG2n4x9bMClMMzyIrGK2QJZdx5EMFJUT94Io=;
	b=Guas8xvjarUmm4FXn11iZp2E6OZ4R7PwtyaCTrfPW5FuhW2SxQLkcNJ7YVbUjax6K5OQ
	 oALQMWuHzOPhOemgRQyhBpXeXqTPnz4rceeSOLFGyO79PEDBcf51VnDSv5IC4nbbymWFx
	 pA+tmeCsGM4BJAbh6bg1LAofrJWPrkNVtIew0Mw+Tw7cnEfJ+kN0GLbnXisr1KfDz6hdu
	 4dWBrmB8iP+g67nCrWXd3xkK9Jz+OEDdIDC4Gx10QpDOrb1WochBXT2LmnhO9oN9WV0jY
	 i0dXEQ4CtxZxmMSEfXST/81Du+ePKcnr14du/QVTJpYJXz3bCIh1gc5jLq0jMceJL4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wowh22FI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B3606A326
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 14:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D9B3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wowh22FI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793369919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ql7QE+ZG2n4x9bMClMMzyIrGK2QJZdx5EMFJUT94Io=;
	b=Wowh22FI0QWVD5eZVe5fK7YVhNaQK6cEw9D/9Obwc+0AMqdcoQgsDv7rTdryjcloIl5Y9m
	iE9t3opYCJL5FrIr4EJr9O/Hc9bMpd6HBC/bkg/SyYNLLnYef2xudGK8OQuTwqk/765Oig
	l223uhHrqgkzyPP/kt05qFfOuDRbk04=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-GOjWth5IONi_9m8hRoAK6g-1; Fri, 30 Oct 2026 10:18:35 -0400
X-MC-Unique: GOjWth5IONi_9m8hRoAK6g-1
X-Mimecast-MFC-AGG-ID: GOjWth5IONi_9m8hRoAK6g_1793369914
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so417645f8f.1
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 07:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369914; x=1793974714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Ql7QE+ZG2n4x9bMClMMzyIrGK2QJZdx5EMFJUT94Io=;
        b=D9H1SCDnbxOJhP38LrhaStqdcHYfGSqZojUVbdYJGW7/+trYzVFk5mfq58r6x8rVnI
         9ff5m6SH8OqHWo0FAmXcjLoE524fnId9cOXoktp4+oQTiSoZ/JUnC92g38iOCnC9RXqV
         WIff+oza0GKwJj0TAcLbVbqDpVPsTDIBwKrdQQ9BCSWLcRyJGeHp4iuF8n8zvRL4tGCK
         KlF0nVfYOB5suNvQ9pWjOLq+v946SBmHxCYnf+tskZo4K36MtIJDC1XKcv1xYkqCURI3
         96rAkKV48esqoUscA/3mGqG4ef+O4OnN3TNdRAShbfXMLVt1+4vZ0fxjAL038ID5GpcA
         KnhA==
X-Forwarded-Encrypted: i=1; AKwUvBx8Ii6XGPHyfuYGI+DUOtKmrXmqjHOB04My0EWDKPCAdr3XAno5t22Z4zct2VcwmbDo3hegSdN70F4RenPoSQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJVI+4S20SRpju8iVB1Lw2Nhy8pPvnvKzjwN+tZd1HXed/B2M+u
	9Ny3qSnjMXPAy0RlMgH8KB06O9IzLlb8sE2vczh6JPxQzMkkgpCgEwVTD7qkJr1nCaRDWbNEfxb
	0JchSNgttII2v+HyEVGjJ7P393t6WqDkaGaRuJlp8rgI0osDg0uOjOE39/d27DwFtdKyY
X-Gm-Gg: AYBFou2p8cFC4p78gdm3RgGD0Je+D6I/If69XApTBwWPpMZ8F/BHBCCVV9wuEqvbWRm
	ulwEEwnpX4x8zD/WFGBLDdjE0P0tAgTUjow3iCaozPA710vSwEZghmkYc/jb5+17MY67Zslr9rN
	+w8OP4Mw3Q1vnHCGfBZ1Sk2EKcefIRY9jSDovwUIyM7Fkosa5HrI69cP2eoWR0uM9yGLBDRj5fu
	wB0Nqd+yWLSxBYGb0RtHnbzx5KzCJ6Y2wkkmElpFVdczEODbFWKwIPdntDGQu1B3mBc/3hu31pI
	Do9HGQYnP0d9zGjUMqlosN4Rgxo1SaxB+6xXIvA04ZKPQ4YuTN5k2o9XEX36vBy+wqru7S4nsOB
	NTjqWFqE8icOGOkrD1/dYcszSBAysEHnqry4hUi8+2DP1MXc3JCzMP+qKtuznL3lbKZWNPCiEgN
	Bg8MG+E0qj7PsBBls=
X-Received: by 2002:a05:6000:4a07:b0:48e:68d5:81a6 with SMTP id ffacd0b85a97d-48e6e4f53fbmr6819372f8f.34.1793369914430;
        Fri, 30 Oct 2026 07:18:34 -0700 (PDT)
X-Received: by 2002:a05:6000:4a07:b0:48e:68d5:81a6 with SMTP id ffacd0b85a97d-48e6e4f53fbmr6819274f8f.34.1793369913924;
        Fri, 30 Oct 2026 07:18:33 -0700 (PDT)
Received: from sgarzare-redhat (ip190-139-192-82.pool-bba.aruba.it. [82.192.139.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9eaeesm3565782f8f.49.2026.10.30.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:18:33 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:18:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting
 for data in recvmsg
Message-ID: <auSkQOU6qmj0NPEt@sgarzare-redhat>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qiNb7DF-3DG9ZdBJjTJ96zQpElSjTh_uLLKV5-9gQtI_1793369914
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 28, 2026 at 06:55:40PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the receive
>loop, including vsock_msg_wait_data(), which sleeps in wait_woken()
>without dropping the lock. When data arrives, the transport's delivery
>context (the vsock-loopback worker, or the virtio/vhost rx path) calls
>virtio_transport_recv_pkt() -> lock_sock() on the same socket and blocks.
>That context is the only one that would queue the skb and wake the
>reader, so neither side makes progress: a blocking recv() hangs until a
>signal arrives or SO_RCVTIMEO expires, and meanwhile the shared delivery
>worker is stalled, so all vsock rx on that transport stops. The
>hung-task watchdog reports the worker:
>
>  INFO: task kworker/1:3:107 blocked for more than 5 seconds.
>  task:kworker/1:3 state:D Workqueue: vsock-loopback vsock_loopback_work
>  Call Trace:
>   __schedule
>   schedule
>   __lock_sock
>   lock_sock_nested
>   virtio_transport_recv_pkt
>   vsock_loopback_work
>
>vsock_bpf.c is based on net/unix/unix_bpf.c, whose unix_msg_wait_data()
>drops u->iolock around wait_woken(); tcp_bpf and the native
>vsock_connectible_wait_data() also drop the lock across the wait.
>
>Releasing the lock alone is not enough. With the lock dropped, the
>reader is also woken by events that bring no data, for example a credit
>update via sk_write_space(); vsock_msg_wait_data() did not loop, so a
>blocking recv() then returned -EAGAIN early. It also checked only for a
>local RCV_SHUTDOWN, so a peer shutdown or a reset was not noticed. A
>looping wait must stop on everything the native receive path stops on:
>without the shutdown checks a peer shutdown, and without the state
>check a reset whose error was already read with SO_ERROR, would sleep
>until the timeout.
>
>Make vsock_msg_wait_data() loop and release the socket lock around each
>wait. It returns 1 when data is ready, -sk_err on a socket error, 0 on
>RCV_SHUTDOWN or a peer SEND_SHUTDOWN (as vsock_connectible_wait_data()
>does), -EAGAIN on timeout and sock_intr_errno() on a pending signal. It
>also stops once the socket is no longer TCP_ESTABLISHED, with 0 if
>SOCK_DONE is set and -ENOTCONN otherwise, mirroring the state check in
>__vsock_connectible_recvmsg(): a transport reset
>(virtio_vsock_reset_sock()) sets only TCP_CLOSE and sk_err, and
>getsockopt(SO_ERROR) clears sk_err, so without the state check the loop
>would wait out the whole timeout on a dead connection. Data already in
>the psock ingress queue is still returned first. vsock_bpf_recvmsg()
>returns a negative result as the error and 0 as end of file.
>
>Two userspace-visible results are worth noting: a pending signal now
>returns sock_intr_errno() where the old code returned -EAGAIN, and after
>a virtio transport reset recv() returns -ECONNRESET until
>getsockopt(SO_ERROR) has read the error, where the native path returns
>-ENOTCONN.
>
>The deadlock was found with the help of an LLM coding assistant
>(Anthropic's Claude); Sashiko AI reviews of two earlier sockmap patches
>had already noted it as a pre-existing issue. The early -EAGAIN on a
>dataless wakeup, the missed peer shutdown and the wait on a reset
>connection were reported by the netdev Sashiko AI review of earlier
>versions of this patch. Each reproducer is a C program run as root in
>the guest: it adds one end of a vsock stream connection to a BPF sockmap
>(CAP_BPF and CAP_NET_ADMIN) and drives a blocking recv(); the reset case
>connects to a peer on the host and unbinds the guest's virtio-vsock
>device, the others use vsock-loopback. No kernel change or error
>injection is needed. The reproducers are available on request.
>
>Testing: built a KASAN + lockdep kernel on net and ran reproducers on a
>private VM, before and after this patch. Before: a blocking recv() on a
>sockmap socket deadlocks the vsock-loopback worker (hung-task). After:
>it returns the data; a dataless credit-update wakeup does not end the
>wait; a peer SEND_SHUTDOWN returns 0; and after a reset of a virtio
>connection (unbinding the guest's virtio-vsock device) and
>getsockopt(SO_ERROR), recv() returns -ENOTCONN at once like a socket
>outside the sockmap, where before this patch it waited for SO_RCVTIMEO.
>No KASAN, lockdep or hung-task report. With both patches of this series
>applied, the three single-VM tests of
>tools/testing/selftests/vsock/vmtest.sh (vm_server_host_client,
>vm_client_host_server, vm_loopback; 44 vsock_test cases each) pass, as
>on net; on both kernels the host-side runs skip the SO_INQ cases (SO_INQ
>not supported by the host kernel). The ns_* tests of vmtest.sh were not
>run (they need root on the host). The BPF test_progs sockmap_basic,
>sockmap_listen and sockmap_redir tests pass (767 of 767 subtests, among
>them the three vsock subtests of sockmap_basic and the 240 AF_VSOCK
>cases of sockmap_redir).

Ditto about commit message, please put more effort on writing something 
readable by a human.

>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 62 ++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 48 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..5120911b8143 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -34,24 +34,55 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
> 	return vsock_sk_has_data(sk, psock);
> }
>
>-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
>+/* Returns 1 if data is ready, 0 on EOF/shutdown, or a negative error. */
>+static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
> {
>-	bool ret;
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	int ret;
>
> 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>
>-	if (sk->sk_shutdown & RCV_SHUTDOWN)
>-		return true;
>-
>-	if (!timeo)
>-		return false;
>-
> 	add_wait_queue(sk_sleep(sk), &wait);
> 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>-	ret = vsock_has_data(sk, psock);
>-	if (!ret) {
>-		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>-		ret = vsock_has_data(sk, psock);
>+	while (1) {
>+		if (vsock_has_data(sk, psock)) {
>+			ret = 1;
>+			break;
>+		}
>+
>+		if (sk->sk_err) {
>+			ret = -sk->sk_err;

Why?

>+			break;
>+		}
>+
>+		if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
>+		    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
>+			ret = 0;
>+			break;
>+		}
>+
>+		/* virtio_vsock_reset_sock() sets no shutdown bits, and
>+		 * SO_ERROR clears sk_err: check the state the way
>+		 * __vsock_connectible_recvmsg() does.
>+		 */
>+		if (sk->sk_state != TCP_ESTABLISHED) {
>+			ret = sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;
>+			break;
>+		}

I'm thinking if we should split this in multiple patches.

>+
>+		if (!timeo) {
>+			ret = -EAGAIN;
>+			break;
>+		}

Is the move of this check changing some user visible error?

I mean before this patch it was one of the first checks, is this okay?

>+
>+		release_sock(sk);
>+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>+		lock_sock(sk);
>+
>+		if (signal_pending(current)) {
>+			ret = sock_intr_errno(timeo);
>+			break;
>+		}

Why? Should be a separate patch?

> 	}
> 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> 	remove_wait_queue(sk_sleep(sk), &wait);
>@@ -101,11 +132,14 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> 	while (copied == 0) {
> 		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>+		int data = vsock_msg_wait_data(sk, psock, timeo);
>
>-		if (!vsock_msg_wait_data(sk, psock, timeo)) {
>-			copied = -EAGAIN;
>+		if (data < 0) {

Why not data <= 0  and void the other if?

Thanks,
Stefano

>+			copied = data;
> 			break;
> 		}
>+		if (!data)
>+			break;
>
> 		if (sk_psock_queue_empty(psock)) {
> 			release_sock(sk);
>
>-- 
>2.56.0
>
>

