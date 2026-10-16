Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1BA3CB56E
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161646; cv=none; b=SOM0obtd3fCd6TFybT3K8bM7IjfsxgBGJbhcm21Kkh6+GK5f8sOMra/pAN2RLzEvEl/+GetafxMe/mHzAYbVgt++nQBnF7+m/KwlCMD7xJJJnTvefycgva6BUPOb7vtHftA0Ye7iTJR9CvFg8qG9PbX8Jj69/njBeEzVv3lMYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161646; c=relaxed/simple;
	bh=wpgUo4tlfUOAavT5OSEA9Rp22opL76ck6Sk9O4PpWJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UvLnaOlgg6PcR+Iv4LDaGa3TILLe1iapSrrIrKf2Dy8FcSjkVpEY2e5gzvviodmvi6kcvpDVmohTgQypm/LZzWnlU8XSzJQ6RJKxNml/49Iczjwh1IxeKlzNrKmlnaxPUuNg4n2VwC33yLw0VUu+UmYW2qTQjwWo2h+eUW3WDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xc+NdUW6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc+NdUW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792161642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LWwdo5Kq1dmAwX8uvj4MLC+o6yXs47hvnpvLkKvNuAY=;
	b=Xc+NdUW6nCy+XLreiMP4zYzCCE1dyWDO8bWCvfogy2nSRbtf/cWRa59R3DDQsw0xskT5F+
	pZyGeaGkaYiMkVSX3086wQMKiaWJ8Q7w7sbwQRGf0K5S/AJN+1PftiO1Hq4Wwu2V2IkPQ2
	2198hwW44lgMhkePUE0CgyEY6tNkYsM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-7m4pUNmZMcam0ggGaYGfiA-1; Fri, 16 Oct 2026 14:40:41 +0000
X-MC-Unique: 7m4pUNmZMcam0ggGaYGfiA-1
X-Mimecast-MFC-AGG-ID: 7m4pUNmZMcam0ggGaYGfiA_1792161640
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1612c4b80so319855e9.0
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 07:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161640; x=1792766440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWwdo5Kq1dmAwX8uvj4MLC+o6yXs47hvnpvLkKvNuAY=;
        b=Bb5FMgeUl6X/+4V+ybuhap2KR4qE/VLko2ntESFdSiz6zSxuuG7F3j7URlpYSRJmW5
         DBYc+5xvQEb+8cdoYdP0lhBaFXyi0m+JkwbqNGz6jVmst9o7+OqVe0dcZb51sbQE9D8z
         JwrfgfEaObqP3tmOxsQPvITcxiI0I43WrmvP/NpDNl/25Dun2wi5Q608v/GLyupSP/gM
         7BhDCZ8VNSQuu8hjbgSpHnYcetS4uLLGZaSNyj2dZyeHN7vIuGrtxF84l+0Uz4taI4xv
         IbVTYXuYEkoXMUJnM04LcCVfAsaSDPu+RPpu8MCWvSFbMeluJR2JBN5Q7naBEkF2vR0I
         eoig==
X-Forwarded-Encrypted: i=1; AKwUvBwEVIAQ7iBJB6dPjHzJ/8H/OWblazHboCOrWlThHCZ6W+hdKqg/JWPtgOMD8vYD78d4DJpsRrNe7LI/AGBoyA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJCiC3kIxVk9eGVt2DabZhzOl0j8TnRmcarQzxDEq8qRIWJs9qG
	sg+aTXep1yovmL+sekFOA63H9og+IlBrg1NcO335GEj1XTZ2dbet+myYpn4LP6FlWPiJA1nm1a6
	i9La/23D8iitUGU0+92DdqBPpEQOu/ZHcCryEhdwbeYwZzaGzf6zBxHexg0GzhDLxbrR5
X-Gm-Gg: AYBFou0trCcZsLg6YdVPp7KPwi3XWLBsOjFnYLMKio+7M59lKSVm6AFTUjYUUeHo5bb
	FXJbVgIONOsCVwqu1rnojAA9pe6N8SaKrpUI+K3lvxgXY4KIYUmNappnx4W6uYF0xWYzKlHirhu
	FPHN71LJdN3piEYF+B5FL4vVdUDzdD6j8FSch0RlEAXCI0RkCwFq1vs6EfmDL+GR273EhDHwrLN
	4fnI1zo2ExYx2pSQNvgThYxR2FWQ+IdYNcpuErOFYpIsCZAlZIRGYCvkDdztITDUOnxJ86bsf3q
	hP8ahs5Fxisn7RbLuwXjQfHPVb8CeMRPM+kcu4x8RakDLsuOJxD50h1QMBioO52jBOWde7RGHbE
	NqSKx
X-Received: by 2002:a05:600c:1d11:b0:4a1:d307:b52a with SMTP id 5b1f17b1804b1-4a1d307b62fmr25323095e9.19.1792161639837;
        Fri, 16 Oct 2026 07:40:39 -0700 (PDT)
X-Received: by 2002:a05:600c:1d11:b0:4a1:d307:b52a with SMTP id 5b1f17b1804b1-4a1d307b62fmr25322625e9.19.1792161639342;
        Fri, 16 Oct 2026 07:40:39 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.137.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm64518855e9.6.2026.10.16.07.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:40:38 -0700 (PDT)
Date: Fri, 16 Oct 2026 16:40:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v4 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
Message-ID: <atI1-_FAri2x-k2p@sgarzare-redhat>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-4-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261014115640.184286-4-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j_lFOGzJLJswxFRnlDzcBlmeQkmr0zYK67UQo_SZzl4_1792161640
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 14, 2026 at 07:56:39PM +0800, Jia Jia wrote:
>Each received packet updates peer credit and may call sk_write_space().
>A writer cannot use that credit until the batch releases the socket lock,
>so one notification at batch finish is sufficient.
>
>Save the initial sk_write_space callback when the AF_VSOCK socket is
>created and require it to remain installed for batching. This lets the
>transport module deliver the deferred notification without referring to
>the unexported default callback. Sockets with replaced callbacks retain
>their per-packet behavior.
>
>Record the batch socket before processing its first packet so a batch that
>ends on that packet cannot lose the pending notification.

mmm, is this a fix of the previous patch?

>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> include/net/af_vsock.h                  |  5 +++
> net/vmw_vsock/af_vsock.c                |  1 +
> net/vmw_vsock/virtio_transport_common.c | 53 +++++++++++++++++--------
> 4 files changed, 44 insertions(+), 16 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 26dde6909c4ed..bf077ee0ded88 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -287,6 +287,7 @@ struct virtio_transport_rx_batch {
> 	struct sock *sk;
> 	unsigned int pkts;
> 	size_t bytes;
>+	bool write_space_pending;
> };
>
> void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 5549298c1ec6b..9a40960d10cbe 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -63,6 +63,11 @@ struct vsock_sock {
> 	u32 peer_shutdown;
> 	bool sent_request;
> 	bool ignore_connecting_rst;
>+	/*
>+	 * Initial callback, used to identify replacements and deliver deferred
>+	 * write-space notifications.
>+	 */
>+	void (*default_write_space)(struct sock *sk);

This is kind of virtio-vsock specific, why need to be here?

>
> 	/* Protected by lock_sock(sk) */
> 	u64 buffer_size;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 44cee74519555..fe7f49da6c4bc 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> 		sk->sk_type = type;
>
> 	vsk = vsock_sk(sk);
>+	vsk->default_write_space = sk->sk_write_space;
> 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ff74e805527a5..f4b5f0230493e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1820,6 +1820,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> 	return sk->sk_state == TCP_ESTABLISHED &&
> 	       sk->sk_type == SOCK_STREAM &&
> 	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
>+	       READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&

Why?

> 	       !sock_flag(sk, SOCK_DONE) &&
> 	       vsk->transport == &t->transport &&
> 	       vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
>@@ -1828,13 +1829,15 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>
> /*
>  * The caller holds sk's socket lock.  Set @batchable if the socket can remain
>- * locked for another ordinary STREAM/RW packet.  Return true if the caller
>- * must free @skb.
>+ * locked for another ordinary STREAM/RW packet.  When @batch is non-NULL,
>+ * record a default write-space notification for batch finish instead of
>+ * delivering it immediately.  Return true if the caller must free @skb.
>  */
> static bool
> virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 				 struct sk_buff *skb, struct sock *sk,
>-				 bool *batchable)
>+				 bool *batchable,
>+				 struct virtio_transport_rx_batch *batch)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct sockaddr_vm src;
>@@ -1863,8 +1866,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> 		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
>
>-	if (space_available)
>-		sk->sk_write_space(sk);
>+	if (space_available) {
>+		if (batch)
>+			batch->write_space_pending = true;
>+		else
>+			sk->sk_write_space(sk);
>+	}
>
> 	switch (sk->sk_state) {
> 	case TCP_LISTEN:
>@@ -1931,7 +1938,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	}
>
> 	lock_sock(sk);
>-	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
>+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL, NULL);
> 	release_sock(sk);
>
> 	/* Release refcnt obtained when we fetched this socket out of the
>@@ -1949,22 +1956,27 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>
> /*
>  * Finish the RX batch.
>- * For a non-empty batch, the caller must hold the socket lock acquired with
>- * lock_sock(). This function releases the lock and the batch's lookup
>- * reference.
>+ * For a non-empty batch, the caller holds the socket lock acquired with
>+ * lock_sock(). Deliver any deferred write-space notification while the lock
>+ * is held, then release the lock and the batch's lookup reference.
>  * An empty batch is a no-op.
>  */
> void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> {
>+	bool write_space_pending = batch->write_space_pending;
> 	struct sock *sk = batch->sk;
>
> 	batch->sk = NULL;
> 	batch->pkts = 0;
> 	batch->bytes = 0;
>+	batch->write_space_pending = false;
>
> 	if (!sk)
> 		return;
>
>+	if (write_space_pending)
>+		vsock_sk(sk)->default_write_space(sk);
>+
> 	release_sock(sk);
> 	sock_put(sk);
> }
>@@ -2019,7 +2031,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> 			}
>
> 			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
>-								    &batchable);
>+								    &batchable,
>+								    batch);
> 			if (!batchable)
> 				virtio_transport_rx_batch_finish(batch);
> 			if (free_pkt)
>@@ -2059,23 +2072,31 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>
> 	lock_sock(sk);
> 	/*
>-	 * Sockmap removal restores the native protocol under sk_callback_lock.
>-	 * Serialize this initial eligibility check with that update.
>+	 * Sockmap teardown restores callbacks under sk_callback_lock. Keep the
>+	 * initial eligibility check consistent with that update.
> 	 */

Unrelated change?

BTW if you are assisted by AI, please read https://docs.kernel.org/process/coding-assistants.html 

> 	read_lock_bh(&sk->sk_callback_lock);
> 	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
> 	read_unlock_bh(&sk->sk_callback_lock);
>
>+	if (start_batch)
>+		batch->sk = sk;
>+
> 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
>-						    start_batch ? &batchable : NULL);
>+						    start_batch ? &batchable : NULL,
>+						    start_batch ? batch : NULL);
> 	if (start_batch && batchable) {
> 		/* Keep the lookup reference until the batch is released. */
>-		batch->sk = sk;
> 		return;
> 	}
>
>-	release_sock(sk);
>-	sock_put(sk);
>+	if (start_batch) {
>+		virtio_transport_rx_batch_finish(batch);
>+	} else {
>+		release_sock(sk);
>+		sock_put(sk);
>+	}
>+
> 	if (free_pkt)
> 		kfree_skb(skb);
> }
>-- 
>2.53.0
>

