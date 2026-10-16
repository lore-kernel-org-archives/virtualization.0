Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB647A0A6
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158463; cv=none; b=NnTIrk9/O6piluG9jR5kCJ8lzevOU+ZpTWx/nyIQEUynCWIEqohZat2fAHxz4gr6pYBtgWGc9wrBBe5q0KaRL/VfXWqSO6RU5eWNETnLlkU5m07eCibR9Z2PxSL11/Y6kFfNYSuPDLnGCFyBEuYEzU9lh6YRfNCfjIGXzLTA0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158463; c=relaxed/simple;
	bh=CU3/MfdDC5CCAi2IBjM7GBTNHGS8rDLFUgIS668OelY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B4zTbEub2V0PRoWuiqsyU5kdineo8+CGksm/1qWnK+xj6f87/rlUHq2cRU3eRt4bDLqYi2EDJvnu2hG8RySXacpi8sUA1H0u5zSXuqokrupd/3ggIDp1k678YvzfJwg86qgGaUGvULdGChFPQAjnl3YWHN9DqBoQLEYQpX9BDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBTjKotH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBTjKotH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792158461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SSnXLe6871QixsCS+2sjMCeMY5DVo6y3bWbHQzmraY=;
	b=QBTjKotHUqRx9XmD8ira7IIRLc200+i0h1VyNilrAwXmB8bVoQChyRE6xMoRfUxOlhUyAy
	TEnxE7XrKia8tSMorNWKCAC02EPkJSs3n4stb+iKCZ0bnCwznvfNdJEDY0XBTsMyzWwseb
	HdcMOFZGaynhiuYEcQvIM7jwvJOiaM4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-iN5NS7N0OSSe5f0AtCo8ow-1; Fri, 16 Oct 2026 13:47:40 +0000
X-MC-Unique: iN5NS7N0OSSe5f0AtCo8ow-1
X-Mimecast-MFC-AGG-ID: iN5NS7N0OSSe5f0AtCo8ow_1792158459
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e011829easo380968f8f.3
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 06:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158459; x=1792763259;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SSnXLe6871QixsCS+2sjMCeMY5DVo6y3bWbHQzmraY=;
        b=lVEA255UGVNsMxfvhxEIfDysPNogt4kTsk3qWUjz1Pa+/7B4r31u1TVvnP6aMDFqlh
         4wyjC3p9a/DiCj2htdsFWonPxJD5WLKdvqeHhMpmpBZzSfFERHcN8YOgOLf1ta37Pw6/
         k9pVgQZ6Wb9LLWE/tOIU3AF5gdLwp+dXKq2ob+V1oNeHKyls2MiWQsH9UKGDSZZjI4gh
         PgC02Es7Bt026xNgUDcidcoXvnyHbgrCWsyedHCPUlZu3Q4YQFrXzoyUVq0oECrOt1v+
         ZPvKce0fSFT8cX0yYeYIHe6mLojq/VMRzZwaBCZL6CXpF8J7rGDYVtC+NevDsVEuXWz0
         SU3w==
X-Forwarded-Encrypted: i=1; AKwUvBz0KujhBE+X3BLU80GptXySj6Ka9RHxK7FSMchLGFX7Ra2ghEP8BHbXSqaQnESkM8k74pDIusF8d76YLGsewQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIZ17OR5Pl1v0db7c6U5U9DzKuf5EgCV7jZEs0o1/EYW1JlxTyq
	IGBHvQfQPhDcO9ULdXHfvFbTxVHq/ttvguwLE6ax8nqyx/Cfp63EVMUHwTFzTwJA3GtoS5AP8aE
	gpAFpghO7mr8//HMoAFqrAkYC+zvk9iYrDZuxEPMoRhrRPO1wkBaj8V61nO/NiUeookmi
X-Gm-Gg: AYBFou3Ao9YDH56o6N4Rc2zcsJ+He//NgqkZXXAlm3Fay6ZzX9TLrBMKa119R/fmbll
	TawfKSSr6IWBiS5kYnnseiAtTOdyITq58h3S/2dAIxZKh26kMwS280IUhuN5AyTWKohEv69yZFY
	2ndieLrVRv32oUyTgdnhM64LML84Y6V0uJsAkXdy/phOUjMttzpEV78Htsa5GuLj7Hqb4uXKv0D
	IAwP4F8NFWT2vDDWi5OyKo8SmyarO6SBC5bkMGCq5JRIPUgFMA5/Hs1f4VZypXdBGYzYfh+IA37
	M3ee/9vdA8YdeMEbga1mQE4TWpi2fh5PpDrqQmqij4RmWVnYerVZmbGD9q6pJXyIUNJsctXXp+1
	giAy3
X-Received: by 2002:a05:6000:200c:b0:48c:55c1:fb50 with SMTP id ffacd0b85a97d-48dbace6841mr41485211f8f.40.1792158458822;
        Fri, 16 Oct 2026 06:47:38 -0700 (PDT)
X-Received: by 2002:a05:6000:200c:b0:48c:55c1:fb50 with SMTP id ffacd0b85a97d-48dbace6841mr41485142f8f.40.1792158458102;
        Fri, 16 Oct 2026 06:47:38 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.137.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm5276537f8f.22.2026.10.16.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:47:35 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:47:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <atImp74JbTbEb0d_@sgarzare-redhat>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261014115640.184286-2-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RP4fm8WIa5K8F5rIBTouiCdA7EtwiOmZy1fHg_YGw8c_1792158459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 14, 2026 at 07:56:37PM +0800, Jia Jia wrote:
>Split virtio_transport_recv_pkt() so socket lookup is separate from
>receive state machine processing under the socket lock. This prepares the
>receive path to keep a looked-up socket across multiple packets in a later
>change.
>
>Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
>The locked helper obtains packet-specific addresses from the skb and uses
>the matched socket namespace for reset replies. Preserve source validation
>and failure handling.
>
>No functional change intended.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
> 1 file changed, 75 insertions(+), 53 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f225f53ed4bab..61ee3bc205d5d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
> 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> }
>
>-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>- * lock.
>- */
>-void virtio_transport_recv_pkt(struct virtio_transport *t,
>-			       struct sk_buff *skb, struct net *net)
>+static struct sock *
>+virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
>+			     struct sockaddr_vm *dst, struct net *net)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>-	struct sockaddr_vm src, dst;
>-	struct vsock_sock *vsk;
> 	struct sock *sk;
>-	bool space_available;
>-
>-	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>-			le32_to_cpu(hdr->src_port));
>-	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
>-			le32_to_cpu(hdr->dst_port));
>-
>-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
>-					dst.svm_cid, dst.svm_port,
>-					le32_to_cpu(hdr->len),
>-					le16_to_cpu(hdr->type),
>-					le16_to_cpu(hdr->op),
>-					le32_to_cpu(hdr->flags),
>-					le32_to_cpu(hdr->buf_alloc),
>-					le32_to_cpu(hdr->fwd_cnt));
>
>-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>-		goto free_pkt;
>-	}
>+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
>+		return NULL;
>
>-	/* The socket must be in connected or bound table
>-	 * otherwise send reset back
>-	 */
>-	sk = vsock_find_connected_socket_net(&src, &dst, net);
>-	if (!sk) {
>-		sk = vsock_find_bound_socket_net(&dst, net);
>-		if (!sk) {
>-			(void)virtio_transport_reset_no_sock(t, skb, net);
>-			goto free_pkt;
>-		}
>-	}
>+	sk = vsock_find_connected_socket_net(src, dst, net);
>+	if (!sk)
>+		sk = vsock_find_bound_socket_net(dst, net);
>+	if (!sk)
>+		return NULL;
>
> 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
> 		sock_put(sk);
>-		goto free_pkt;
>+		return NULL;
> 	}
>
>-	if (!skb_set_owner_sk_safe(skb, sk)) {
>-		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>-		goto free_pkt;
>-	}
>+	return sk;
>+}
>
>-	vsk = vsock_sk(sk);
>+/*
>+ * The caller holds sk's socket lock and must free skb if this returns true.

Why the skb must be freed by the caller and not by this function itself?

>+ */
>+static bool
>+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>+				 struct sk_buff *skb, struct sock *sk)
>+{
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct sockaddr_vm src;
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	bool space_available;

Please, follow the netdev convection for ordering local variables: 
https://www.kernel.org/doc/html/v7.2/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>
>-	lock_sock(sk);
>+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>+			le32_to_cpu(hdr->src_port));
>
>-	/* Check if sk has been closed or assigned to another transport before
>-	 * lock_sock (note: listener sockets are not assigned to any transport)
>+	/* Listener sockets accept packets from any source and are not assigned to
>+	 * a transport.
> 	 */

Why changing this comment in this commit?

Oh because we moved out lock_sock, right?

I think we should keep in some way the old info that was much more 
informative that the current comment that just say what the check is 
doing and not why.

> 	if (sock_flag(sk, SOCK_DONE) ||
> 	    (sk->sk_state != TCP_LISTEN &&
> 	     !vsock_check_source(vsk, &t->transport, &src))) {
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>-		release_sock(sk);
>-		sock_put(sk);
>-		goto free_pkt;
>+		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));

We need to be careful here, IIRC Bobby used the net from the caller for 
a reason.

Are you sure it's fine this change? Why not passing net as parameter and 
minimize changes?

>+		return true;
> 	}
>
> 	space_available = virtio_transport_space_update(sk, skb);
>
> 	/* Update CID in case it has changed after a transport reset event */
> 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>-		vsk->local_addr.svm_cid = dst.svm_cid;
>+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
>
> 	if (space_available)
> 		sk->sk_write_space(sk);
>@@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		kfree_skb(skb);
> 		break;
> 	default:
>-		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> 		kfree_skb(skb);
> 		break;
> 	}
>
>+	return false;
>+}
>+
>+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>+ * lock.
>+ */
>+void virtio_transport_recv_pkt(struct virtio_transport *t,
>+			       struct sk_buff *skb, struct net *net)
>+{
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct sockaddr_vm src, dst;
>+	struct sock *sk;
>+	bool free_pkt;
>+
>+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>+			le32_to_cpu(hdr->src_port));
>+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
>+			le32_to_cpu(hdr->dst_port));
>+
>+	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
>+					dst.svm_cid, dst.svm_port,
>+					le32_to_cpu(hdr->len),
>+					le16_to_cpu(hdr->type),
>+					le16_to_cpu(hdr->op),
>+					le32_to_cpu(hdr->flags),
>+					le32_to_cpu(hdr->buf_alloc),
>+					le32_to_cpu(hdr->fwd_cnt));
>+
>+	sk = virtio_transport_find_socket(skb, &src, &dst, net);
>+	if (!sk) {
>+		(void)virtio_transport_reset_no_sock(t, skb, net);
>+		goto free_pkt;
>+	}
>+
>+	if (!skb_set_owner_sk_safe(skb, sk)) {
>+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>+		goto free_pkt;
>+	}
>+
>+	lock_sock(sk);
>+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
> 	release_sock(sk);
>
> 	/* Release refcnt obtained when we fetched this socket out of the
> 	 * bound or connected list.
> 	 */
> 	sock_put(sk);
>+	if (free_pkt)
>+		kfree_skb(skb);
> 	return;
>
> free_pkt:
>-- 
>2.53.0
>

