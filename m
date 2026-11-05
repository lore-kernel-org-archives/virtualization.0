Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870515;
	b=F7fmiQ0al6zFhu2q/lCoVqts5gH2rCeobeImOEsJvSC3eYn+uv7r/uT5ZED/FxUWpjyW
	 nu4VZuHKRZdGecaUM56qn9dXGtnFsElDR3c1iIDF+Czh/N5NzF3+k7VIG1bkIoxcfcPab
	 E+sUdfWnGZZj8Zi5PnKnn6U2E+usH7dJ0vh13KzB6Bdvv1R7M0CF2ZltWuMeOcTKzVIXt
	 NTRYwkjzM+efYOq5IIIK9VP0rooDVifI/DyI6r7TPabXAa5KnMjSjWggl2PG8bqJgxvRF
	 XNA0QYdrbZe4tbAcKeB6ej0j9UHJzMWVErVHxgPGxlfi9vkuo4UF0qBQ5+tIjx5/ueA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870515;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=KaPt1diWMgCZPc1vxZpjAWeLtJhKjtfKBpuZ5FbfsnM=;
	b=we7RsljlJyVOWDVRP9UkX1S4fSuCh57C1b+Yh1nvu6DSwxwjiZst4cbC/v3fe3yT/Mqq
	 1mFM2i2u0jWqgsh9dwZr91e4vXlGiinwEVEPapDftrdwp4bBg2sTk8KYQc/zsmtTLRksP
	 9VxhKPEd0wUVhyOC6/PeKnt36ukVCFf5qPJpPQjMpw42ToeCr3EN6R0qdpHYY1FZqpgSC
	 DttTI5R9W3TCqkMx5Y2RcLbypYyCzur+vruachef1xBc+j07/JfljUbqEdJAPkw2JN3Fj
	 1MGEhmpaTUUuqypcyjNSbAzVmS088X8tTJbF1HDBKUrYvHkwYUzFSSSuR/vpHNOozuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VLtkempC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CED606A335
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 09:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0CED606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VLtkempC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793870514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KaPt1diWMgCZPc1vxZpjAWeLtJhKjtfKBpuZ5FbfsnM=;
	b=VLtkempCPzP7XsM6eJ3Eh7Ry69YpDEztpD7vhU2C2i2tc4+yh5xkczgvgY36M50IK1VkCs
	ddkJATcA2bO0hzaRF5kstsOoy0019+nvBnBDBdCohBjHb4Ebal36KLhnlQFaT1S23r0SEa
	SJrTo/vgP7de/Ga1IqB/XYJTCRb9eNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Gm4ilnbIPNCc_DxIRX-CHg-1; Thu, 05 Nov 2026 04:21:52 -0500
X-MC-Unique: Gm4ilnbIPNCc_DxIRX-CHg-1
X-Mimecast-MFC-AGG-ID: Gm4ilnbIPNCc_DxIRX-CHg_1793870511
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a210f93860so13242205e9.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 01:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870511; x=1794475311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KaPt1diWMgCZPc1vxZpjAWeLtJhKjtfKBpuZ5FbfsnM=;
        b=1KE4CblRLVfkA13Hz3J9U6CWYSVLA/G25eIOFqBfqx9lsBkBZA0KH8lmKzyDViJN4o
         eeoHFr7ShLJKPTsiKt56Tyq8Ajh3s/vcFbD0gU9DOPhyTHdhnJbZJhi+wlHa1lMk9q6h
         DkpxYYIFHBUZZkbhmYdT+IVd2TAuJ1tW27y3kPNakSjXs/JVWf4Bff/C1GG7e4glC1bZ
         xgQCj8YCDRxfQ680eNXUxEBtPcI744YTJWfJkDb4PR2NQCBm3UZj4O/HBOtG67Fk+iw2
         GKYWJZ2/xkogZyeP4dq0VSVCX3y0Im6jzy8/athc7AK/utzcKrP/gC/ltQOj86rp3S7e
         xtsw==
X-Forwarded-Encrypted: i=1; AKwUvBz5VhZdmXquX0dcah1SwAJtiKQsEIM/UNtTAroQnpO3ZZkmdNPqL6/L0SMvnDChoOgeDgBlTfX0YRhTKPEtFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8bRefOmzUBFrkSqvFzisEEAzdnln0u0Ij8KqF6/ec/TwS4Rl07
	UJauLG3AHFix62K8/+n1dtfGbD7QJHlpYkJ7aaCyXbnGXVLTYO2MKKtWYCj5TNsYCgOw/n1IQW7
	gQNhcsBU4DYMuN0TeOdYnGPXpIfEsBtzvmGOqZnJ/trxEKpVTDHNOVzSTXtCom7aHkg4i
X-Gm-Gg: AYBFou33kFM029UJ4QIgl5KnChpjgKv1DJfb19JECaHivnaUxG5koSEVzOGQJzb771J
	kqyfhtyfdog0c9ZQtQrnqLTDZASBA0BfpRLj+c12KHiC2E7iz84kiDpG7BlBuK69JF+7COvOk3H
	joTsYhvcfLpOsQb+6p91NG5Vw5xmdpGyUSbxvEuo/EBOzf4IEYk3QIodgc2AQfGBT5cjGigqnam
	u1Q5aWVObgd0vOuHSgZl7w8SCOj7QjF92kpe2pN31ltjI3NBi5M53v5kjurkKiNWtJLN+nTMb+s
	uLX06Toh1LS8toUzuSALKQzeW5pYjLXf6y+r5HuPtkILS0Lz2w6TOj9kEDWsSL4VMWb0mekMvvT
	0b7OdkAzEL8wCpeufidAd6PFCekhNd3anCihAcShazORN8UhKGGRV
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr413376365e9.3.1793870511185;
        Thu, 05 Nov 2026 01:21:51 -0800 (PST)
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr413375715e9.3.1793870510562;
        Thu, 05 Nov 2026 01:21:50 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46489sm50483395e9.3.2026.11.05.01.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:21:49 -0800 (PST)
Date: Thu, 5 Nov 2026 10:21:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX
 write-space notifications
Message-ID: <auxHe77Kv3tS4hjJ@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-5-physicalmtea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261103041134.33310-5-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w-hyU0UQsn9ctUH1kOUrinMjyg8nLCb8eEPeOAHZtRc_1793870511
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 03, 2026 at 12:11:33PM +0800, Jia Jia wrote:
>Each received packet can update peer credit and call sk_write_space(). A
>writer cannot consume that credit while the virtio RX worker retains the
>socket lock, so repeated native write-space notifications in one RX batch
>are unnecessary.
>
>This patch coalesces write-space notifications on the native AF_VSOCK path;
>data-ready remains per-packet here.
>
>The batching patch establishes batch ownership before its first packet.
>This lets this patch record a pending notification for that packet and
>flush it even if the packet immediately ends the batch. Deliver it while
>holding the socket lock to preserve the callback context of the existing
>receive path. A following patch changes that timing together with
>data-ready handling.

Can you report performance data related to this patch also here?

IIUC this is not giving a lot of advantage, so my question is if this 
more complexity really add a value for us.

>
>Capture the native write-space callback before socket publication and
>access it through AF_VSOCK helpers. Sockmap can change the protocol,
>write-space callback, and psock marker without the socket lock. Serialize
>each batch eligibility check with sk_callback_lock; if a packet boundary
>observes a replacement, finish the batch and use the regular per-packet
>path.
>
>Packets admitted on the native path use the saved native callback at batch
>finish. Reloading a current sockmap callback would not synchronize its
>invocation with teardown; a wrapper seen before teardown need not forward
>the native wakeup after its psock is gone.

I really don't understand the goal of this patch, and why we need to 
store the "native" sk_write_space.

>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> include/linux/virtio_vsock.h            |  4 +-
> include/net/af_vsock.h                  |  7 +++
> net/vmw_vsock/af_vsock.c                | 16 +++++
> net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++++++++--------
> 4 files changed, 81 insertions(+), 24 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 748633aa0cc81..bf28e8e32e280 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -287,12 +287,14 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
>  * lock and the reference returned by vsock_find_connected_socket_net(). The
>  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
>- * empty batch owns neither.
>+ * empty batch owns neither. A pending native write-space notification belongs
>+ * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
>  */
> struct virtio_transport_rx_batch {
> 	struct sock *sk;
> 	unsigned int pkts;
> 	size_t bytes;
>+	bool write_space_pending;
> };
>
> static inline bool
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 5549298c1ec6b..b76ab565ea58b 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -63,6 +63,11 @@ struct vsock_sock {
> 	u32 peer_shutdown;
> 	bool sent_request;
> 	bool ignore_connecting_rst;
>+	/*
>+	 * Captured before the socket is published. This identifies AF_VSOCK's
>+	 * native write-space callback after a consumer has replaced it.
>+	 */
>+	void (*native_write_space)(struct sock *sk);
>
> 	/* Protected by lock_sock(sk) */
> 	u64 buffer_size;
>@@ -78,6 +83,8 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
> s64 vsock_stream_has_space(struct vsock_sock *vsk);
> struct sock *vsock_create_connected(struct sock *parent);
> void vsock_data_ready(struct sock *sk);
>+bool vsock_write_space_is_native(const struct sock *sk);
>+void vsock_call_native_write_space(struct sock *sk);
>
> /**** TRANSPORT ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 44cee74519555..e39567990539f 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> 		sk->sk_type = type;
>
> 	vsk = vsock_sk(sk);
>+	vsk->native_write_space = sk->sk_write_space;
> 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>
>@@ -1122,6 +1123,21 @@ void vsock_data_ready(struct sock *sk)
> }
> EXPORT_SYMBOL_GPL(vsock_data_ready);
>
>+bool vsock_write_space_is_native(const struct sock *sk)
>+{
>+	const struct vsock_sock *vsk = vsock_sk(sk);
>+
>+	return READ_ONCE(sk->sk_write_space) ==
>+	       READ_ONCE(vsk->native_write_space);
>+}
>+EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
>+
>+void vsock_call_native_write_space(struct sock *sk)
>+{
>+	vsock_sk(sk)->native_write_space(sk);
>+}
>+EXPORT_SYMBOL_GPL(vsock_call_native_write_space);
>+
> /* Dummy callback required by sockmap.
>  * See unconditional call of saved_close() in sock_map_close().
>  */
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f83e5b2edce35..af26344678e41 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1865,31 +1865,55 @@ virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> 	       !virtio_transport_rx_buf_full(vvs);
> }
>
>-/* The caller holds sk's socket lock. */
>+/* The caller holds sk's socket and callback locks. */
> static bool
>-virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
>-				      struct sock *sk, u32 len)
>+__virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
>+					struct sock *sk, u32 len)
> {
> 	if (!virtio_transport_rx_batch_can_continue(t, sk, len))
> 		return false;
>
> 	/*
>-	 * Sockmap can replace sk_prot and publish a psock without the socket lock.
>-	 * Check both at each packet boundary; a boundary that sees a replacement
>-	 * returns to the existing per-packet path.
>+	 * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
>+	 * without the socket lock. Coalescing is safe only for the native
>+	 * write-space callback, so a boundary that sees a replacement returns to
>+	 * the existing per-packet path.
> 	 */
> 	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
>+	       vsock_write_space_is_native(sk) &&

I'm confused, why for sk_prot we are doing the check here, while for 
sk_write_space we need a new API?

> 	       !virtio_transport_sock_has_psock(sk);
> }
>
>+/*
>+ * Sockmap teardown restores the native protocol and write-space callback
>+ * under sk_callback_lock. Serialize each packet admission check with those
>+ * updates.
>+ */
>+static bool
>+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
>+				      struct sock *sk, u32 len)
>+{
>+	bool batchable;
>+
>+	read_lock_bh(&sk->sk_callback_lock);
>+	batchable = __virtio_transport_rx_batch_can_receive(t, sk, len);
>+	read_unlock_bh(&sk->sk_callback_lock);
>+
>+	return batchable;
>+}
>+
> /*
>  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
>  * after processing @skb to say whether a native STREAM/RW batch can continue.
>+ * When @batch is non-NULL, record a native write-space notification for batch
>+ * finish. A writer cannot consume the updated credit until this lock is
>+ * released.
>  */
> static void
> virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 				 struct sk_buff *skb, struct sock *sk,
>-				 struct net *net, bool *batchable)
>+				 struct net *net, bool *batchable,
>+				 struct virtio_transport_rx_batch *batch)

Do we really need bot batchable and batch ?

> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct vsock_sock *vsk = vsock_sk(sk);
>@@ -1921,8 +1945,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
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
>@@ -1947,7 +1975,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 	}
>
> 	if (batchable)
>-		*batchable = virtio_transport_rx_batch_can_receive(t, sk, 0);
>+		*batchable = virtio_transport_rx_batch_can_continue(t, sk, 0);

Why this change?

> }
>
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>@@ -1991,7 +2019,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		goto free_pkt;
>
> 	lock_sock(sk);
>-	virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
>+	virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
>
> 	release_sock(sk);
>
>@@ -2008,20 +2036,31 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>
> /*
>  * Release an active RX batch. A non-empty batch holds the socket lock and the
>- * reference returned by vsock_find_connected_socket_net(). An empty batch
>- * holds neither.
>+ * reference returned by vsock_find_connected_socket_net(). Deliver any
>+ * deferred native write-space notification while holding the lock, preserving
>+ * the callback context of the regular receive path. An empty batch holds
>+ * neither.
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
>+	/*
>+	 * The packet was admitted with the native callback. Do not reload a current
>+	 * callback here: sockmap can replace or remove its wrapper independently.
>+	 */
>+	if (write_space_pending)
>+		vsock_call_native_write_space(sk);
>+
> 	release_sock(sk);
> 	sock_put(sk);
> }
>@@ -2080,7 +2119,8 @@ virtio_transport_rx_batch_process(struct virtio_transport *t,
> 		return;
> 	}
>
>-	virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable);
>+	virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable,
>+					 batch);
> 	if (!batchable) {
> 		virtio_transport_rx_batch_finish(batch);
> 		return;
>@@ -2158,16 +2198,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> 	}
>
> 	lock_sock(sk);
>-	/*
>-	 * Serialize initial admission with sockmap's callback updates. Later
>-	 * packet boundaries recheck native state and end a batch when they
>-	 * observe a replacement.
>-	 */
>-	read_lock_bh(&sk->sk_callback_lock);
> 	batchable = virtio_transport_rx_batch_can_receive(t, sk, len);
>-	read_unlock_bh(&sk->sk_callback_lock);

Can we avoid this change and do this in the previous patch?

Please avoid as much as you can change code introduced in the same series.

> 	if (!batchable) {
>-		/* State or receive-buffer failures keep the regular lookup path. */

Why removing this comment just added by previous patch?

> 		if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
> 			release_sock(sk);
> 			sock_put(sk);
>@@ -2176,7 +2208,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>
> 		virtio_transport_trace_recv_pkt(hdr, &src, &dst);
> 		if (virtio_transport_recv_pkt_set_owner(skb, sk))
>-			virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
>+			virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> 		else
> 			kfree_skb(skb);
>
>-- 
>2.53.0
>

