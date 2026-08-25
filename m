Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCF3AA182
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649583; cv=none; b=FgJOihJtNL22BMiIkZ2YhQjmyDyXhlGl2yAR7VYmBRMWvV+am55a16LMSyNOc5Pu0p1oRYNk8TOxuy9ASMspJFbXJJm0vk7UqJc+u+9Bq4vPcorWBCjKrU9fnhihJXyPci/XWH+kAeCyNS2OvPsndVPLMSqZpsqaqXjY3SWDczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649583; c=relaxed/simple;
	bh=Pm4PUWeW2L1To4s2otVLTBJ5/BTIITsknwFytr+zxUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZjGIWxKWz158AlUXfJVtooY3fQkEwdQjjMQM4lhUcO0Cx0T7YWzWpq9dGyTCC7EFVsdmsDg87YNAV4Dcae1UeVia7tOhp1ZegvcIJ2i3bPsmudp/1rUNT/A0RTuVbd2vaBKoMqGgmi2irmTWKKumhxEX/qm+P+kBBQE3GknfNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNw0OjVJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNw0OjVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787649581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmi+Rp+tDcGWO2/8+NKpz2hFhBNW78Pt0j3naNDc5pc=;
	b=hNw0OjVJDnnpqqCGfuATxoJGws8Ghh9kjtYSfTkGZt+N3ERIIEb2F/R+KT0NJt7hG8cQ86
	DkUcok/v/4L8ksQ8g0bF+eQPZEus/fCkHy1LDtkF9SkL9N7dje4TJ/mg2sVML1oFU0kPFg
	FOUDifXc/kbiikAnnZ24otzWPuk10zw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-M-Aid7pYN-K2AZ7R06Kolw-1; Tue,
 25 Aug 2026 05:19:34 -0400
X-MC-Unique: M-Aid7pYN-K2AZ7R06Kolw-1
X-Mimecast-MFC-AGG-ID: M-Aid7pYN-K2AZ7R06Kolw_1787649572
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C9BC195608F;
	Tue, 25 Aug 2026 09:19:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.127])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEEDC195604A;
	Tue, 25 Aug 2026 09:19:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: 4ncienth@gmail.com
Cc: netdev@vger.kernel.org,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] vsock/vmci: validate packet source for connected sockets
Date: Tue, 25 Aug 2026 11:19:21 +0200
Message-ID: <20260825091921.105436-1-pabeni@redhat.com>
In-Reply-To: <20260823175858.351431-3-4ncienth@gmail.com>
References: <20260823175858.351431-3-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: nGBGw65ZaYuAdoWnS9svwcIAs-a9oDzpNhgZ75YIe_w_1787649572
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
vsock/vmci: validate packet source for connected sockets

This adds a vsock_check_source() test to the VMCI stream receive paths so
that a non-listening socket found by the destination-only bound-table
lookup no longer processes packets from a context other than its stored
peer. The check is applied both under bh_lock_sock() in
vmci_transport_recv_stream_cb() and after lock_sock() in
vmci_transport_recv_pkt_work().

Closes: https://lore.kernel.org/netdev/20260814121255.6B5001F000E9@smtp.kernel.org/

> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 1c4ee039c1662..b612a9893856a 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c

[ ... ]

> @@ -765,17 +767,26 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
>  	bh_lock_sock(sk);
>  
>  	if (!sock_owned_by_user(sk)) {
> -		/* The local context ID may be out of date, update it. */
> -		vsk->local_addr.svm_cid = dst.svm_cid;
> +		if (sk->sk_state != TCP_LISTEN &&
> +		    !vsock_check_source(vsk, &vmci_transport, &src)) {
> +			drop_pkt = true;
> +			err = VMCI_ERROR_NO_ACCESS;
> +		} else {
> +			/* The local context ID may be out of date, update it. */
> +			vsk->local_addr.svm_cid = dst.svm_cid;
>  
> -		if (sk->sk_state == TCP_ESTABLISHED)
> -			vmci_trans(vsk)->notify_ops->handle_notify_pkt(
> -					sk, pkt, true, &dst, &src,
> -					&bh_process_pkt);
> +			if (sk->sk_state == TCP_ESTABLISHED)
> +				vmci_trans(vsk)->notify_ops->handle_notify_pkt(sk, pkt, true,
> +									       &dst, &src,
> +									       &bh_process_pkt);
> +		}
>  	}
>  
>  	bh_unlock_sock(sk);
>  
> +	if (drop_pkt)
> +		goto out;
> +

[Severity: Medium]
Should these two new exits still emit an RST before dropping the packet?

Consider a stream socket that called bind() but never listen().
__vsock_bind_connectible() puts it in the bound table with sk_state
TCP_CLOSE, remote_addr left as {VMADDR_CID_ANY, VMADDR_PORT_ANY}, and
vsk->transport still NULL, because vsock_assign_transport() is only
called for connectible sockets from vsock_connect() (and at create time
for SOCK_DGRAM).

A REQUEST from a remote context to that port misses
vsock_find_connected_socket(), is matched by vsock_find_bound_socket(),
and then reaches the new check.  vsock_check_source() fails on its very
first test:

net/vmw_vsock/af_vsock.c:vsock_check_source() {
	if (vsk->transport != transport)
		return false;
	...
}

So drop_pkt is set and "goto out" skips the kmalloc/schedule_work()
handoff entirely.  vmci_transport_send_reset_bh() is only reached on the
"no socket found" and allocation-failure paths, so nothing is sent back.

The same happens on the deferred path below, where the new "goto out"
jumps over the whole sk_state switch, including the default: arm whose
in-tree comment says the reset is required:

> @@ -908,6 +920,10 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
>  	pkt = &recv_pkt_info->pkt;
>  
>  	lock_sock(sk);
> +	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
> +	if (sk->sk_state != TCP_LISTEN &&
> +	    !vsock_check_source(vsock_sk(sk), &vmci_transport, &src))
> +		goto out;
>  
>  	/* The local context ID may be out of date. */
>  	vsock_sk(sk)->local_addr.svm_cid = pkt->dg.dst.context;

net/vmw_vsock/vmci_transport.c:vmci_transport_recv_pkt_work() {
	...
	default:
		/* Because this function does not run in the same context as
		 * vmci_transport_recv_stream_cb it is possible that the
		 * socket has closed. We need to let the other side know or it
		 * could be sitting in a connect and hang forever. Send a
		 * reset to prevent that.
		 */
		vmci_transport_send_reset(sk, pkt);
		break;
	}

Before this change that arm did transmit an RST for exactly this case,
since vmci_transport_send_reset() handles an unbound remote_addr by
replying to the packet's own source:

net/vmw_vsock/vmci_transport.c:vmci_transport_send_reset() {
	...
	if (vsock_addr_bound(&vsk->remote_addr)) {
		dst_ptr = &vsk->remote_addr;
	} else {
		vsock_addr_init(&dst, pkt->dg.src.context,
				pkt->src_port);
		dst_ptr = &dst;
	}
	...
}

With the reply gone, does the remote connect() now block for
vsk->connect_timeout and return -ETIMEDOUT instead of -ECONNRESET?  The
same loss of the reply would apply to a socket disconnected via
connect(AF_UNSPEC), which resets remote_addr to {VMADDR_CID_ANY,
VMADDR_PORT_ANY}.

Returning VMCI_ERROR_NO_ACCESS from the datagram callback does not turn
into a protocol reply, so is there anything left that notifies the peer?

For comparison, the virtio side runs the same source test but resets the
sender before dropping:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_pkt() {
	...
	if (sock_flag(sk, SOCK_DONE) ||
	    (sk->sk_state != TCP_LISTEN &&
	     !vsock_check_source(vsk, &t->transport, &src))) {
		(void)virtio_transport_reset_no_sock(t, skb, net);
	...
}

Would it make sense to follow that convention here, and to mention the
new drop-without-reply semantics in the changelog?
-- 
This is an AI-generated review.

