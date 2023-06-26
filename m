Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB17AEB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 16:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A3388196A;
	Mon, 26 Jun 2023 16:03:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A3388196A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHfFrLMV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5naMqnpIJjkd; Mon, 26 Jun 2023 16:03:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43EFC81753;
	Mon, 26 Jun 2023 16:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43EFC81753
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29A2DC007A;
	Mon, 26 Jun 2023 16:03:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3E81C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EAA060E33
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EAA060E33
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHfFrLMV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dJHex921J04j
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AFE560E58
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AFE560E58
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Tnb02vCLFDP3y7cFw7iTeMVZsMikvp5WixYX1PmmAc=;
 b=BHfFrLMVdqcQ3rDeVp9tRC59EKnD0GZCIQG6UshSWRoFnMRpWqSNYpWxFvwHpu7iixeirQ
 24yG3/CCxhj8LYW7nZQKE9PEpT/pEwyQRx/7SsREaLVWWjutxYtGNWG86I/iR1NyLqDQkz
 udDY3E9ZDNg1r8oFQADSKG7AfFQ+qsM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-jQevScFGM5iMDDreDOYl0Q-1; Mon, 26 Jun 2023 12:03:39 -0400
X-MC-Unique: jQevScFGM5iMDDreDOYl0Q-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-763a397a3ceso396288785a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795411; x=1690387411;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Tnb02vCLFDP3y7cFw7iTeMVZsMikvp5WixYX1PmmAc=;
 b=g338+feI9FLb753v7WKFYLWOpmk/+9s5qf/QqX4K13QYnA4HZx2HIPa6sGtQPHL4Dr
 xp0pOwtOqFsa7B4/X/556JVvtFFIwK1eCkeIJzQ/rM0B1RNaFLN9fdnTqxhqgyIPPUg4
 gXdMSi+tEdMxR9orMqrhmbg8yLyjAF3kzAp63mtc64M6B4E0jPW4ziVRZKnIV+UvW+4s
 gaVIPLH/CgLqusy6rMG/t8CZJp8Vs+CrnJvismT+0FRVIf5WPs3bo71Vqgb5JNRpLR/4
 JSlPl9mJE+qHXwIF5oqZOX+7+gPYleQ9NI01IjgROjn8McQr9uGQeZMkaI+vtvfIlUIW
 KdxQ==
X-Gm-Message-State: AC+VfDxe9vRgWLlC9hUOtCDrr6tpap5xmh3utWnWe0sOWWCPfEF8V4Rg
 J9nxoPSRx3U+X4Xp5ucjz7Gb+t32GRynQyZS7gmOdIBh6tPdJJy1t8GH4esql46Es68NfrhFfdW
 t2eEiGNFUf9mol4G1QJig6e0mm3EIuemspZ2W6X9ANA==
X-Received: by 2002:a05:620a:4106:b0:763:a115:c19 with SMTP id
 j6-20020a05620a410600b00763a1150c19mr26017666qko.30.1687795411302; 
 Mon, 26 Jun 2023 09:03:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NNgkwpij5VR/DHVTfQWkZP2oAQTne7exiudSoJAi6+hOeu47D40cI/zbPLlh6RXfxoQbjaw==
X-Received: by 2002:a05:620a:4106:b0:763:a115:c19 with SMTP id
 j6-20020a05620a410600b00763a1150c19mr26017642qko.30.1687795410987; 
 Mon, 26 Jun 2023 09:03:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 m4-20020ae9f204000000b007628f6e0833sm2820759qkg.100.2023.06.26.09.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:03:30 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:03:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 05/17] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <rbyt6uomvimurmgchxpuyoqjehdleqzzohzzdnajgadrwkbwsf@qwlcvzqhqxqw>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-6-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-6-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Jun 03, 2023 at 11:49:27PM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ZEROCOPY flag on transmission path: if this
>flag is set and zerocopy transmission is possible, then non-linear skb
>will be created and filled with the pages of user's buffer. Pages of
>user's buffer are locked in memory by 'get_user_pages()'.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 270 ++++++++++++++++++------
> 1 file changed, 208 insertions(+), 62 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 0de562c1dc4b..f1ec38c72db7 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -37,27 +37,100 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
> 	return container_of(t, struct virtio_transport, transport);
> }
>
>-/* Returns a new packet on success, otherwise returns NULL.
>- *
>- * If NULL is returned, errp is set to a negative errno.
>- */
>-static struct sk_buff *
>-virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
>-			   size_t len,
>-			   u32 src_cid,
>-			   u32 src_port,
>-			   u32 dst_cid,
>-			   u32 dst_port)
>-{
>-	const size_t skb_len = VIRTIO_VSOCK_SKB_HEADROOM + len;
>-	struct virtio_vsock_hdr *hdr;
>-	struct sk_buff *skb;
>+static bool virtio_transport_can_zcopy(struct virtio_vsock_pkt_info *info,
>+				       size_t max_to_send)
>+{
>+	struct iov_iter *iov_iter;
>+
>+	if (!info->msg)
>+		return false;
>+
>+	iov_iter = &info->msg->msg_iter;
>+
>+	/* Data is simple buffer. */
>+	if (iter_is_ubuf(iov_iter))
>+		return true;
>+
>+	if (!iter_is_iovec(iov_iter))
>+		return false;
>+
>+	if (iov_iter->iov_offset)
>+		return false;
>+
>+	/* We can't send whole iov. */
>+	if (iov_iter->count > max_to_send)
>+		return false;
>+
>+	return true;
>+}
>+
>+static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>+					   struct sk_buff *skb,
>+					   struct msghdr *msg,
>+					   bool zerocopy)
>+{
>+	struct ubuf_info *uarg;
>+
>+	if (msg->msg_ubuf) {
>+		uarg = msg->msg_ubuf;
>+		net_zcopy_get(uarg);
>+	} else {
>+		struct iov_iter *iter = &msg->msg_iter;
>+		struct ubuf_info_msgzc *uarg_zc;
>+		int len;
>+
>+		/* Only ITER_IOVEC or ITER_UBUF are allowed and
>+		 * checked before.
>+		 */
>+		if (iter_is_iovec(iter))
>+			len = iov_length(iter->__iov, iter->nr_segs);
>+		else
>+			len = iter->count;
>+
>+		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>+					    len,
>+					    NULL);
>+
>+		if (!uarg)
>+			return -1;
>+
>+		uarg_zc = uarg_to_msgzc(uarg);
>+		uarg_zc->zerocopy = zerocopy ? 1 : 0;
>+	}
>+
>+	skb_zcopy_init(skb, uarg);
>+
>+	return 0;
>+}
>+
>+static int virtio_transport_fill_linear_skb(struct sk_buff *skb,
>+					    struct vsock_sock *vsk,

`vsk` seems unused

>+					    struct virtio_vsock_pkt_info *info,
>+					    size_t len)
>+{
> 	void *payload;
> 	int err;
>
>-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>-	if (!skb)
>-		return NULL;
>+	payload = skb_put(skb, len);
>+	err = memcpy_from_msg(payload, info->msg, len);
>+	if (err)
>+		return -1;
>+
>+	if (msg_data_left(info->msg))
>+		return 0;
>+
>+	return 0;
>+}
>+
>+static void virtio_transport_init_hdr(struct sk_buff *skb,
>+				      struct virtio_vsock_pkt_info *info,
>+				      u32 src_cid,
>+				      u32 src_port,
>+				      u32 dst_cid,
>+				      u32 dst_port,
>+				      size_t len)
>+{
>+	struct virtio_vsock_hdr *hdr;
>
> 	hdr = virtio_vsock_hdr(skb);
> 	hdr->type	= cpu_to_le16(info->type);
>@@ -68,42 +141,6 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	hdr->dst_port	= cpu_to_le32(dst_port);
> 	hdr->flags	= cpu_to_le32(info->flags);
> 	hdr->len	= cpu_to_le32(len);
>-
>-	if (info->msg && len > 0) {
>-		payload = skb_put(skb, len);
>-		err = memcpy_from_msg(payload, info->msg, len);
>-		if (err)
>-			goto out;
>-
>-		if (msg_data_left(info->msg) == 0 &&
>-		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
>-			hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>-
>-			if (info->msg->msg_flags & MSG_EOR)
>-				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>-		}
>-	}
>-
>-	if (info->reply)
>-		virtio_vsock_skb_set_reply(skb);
>-
>-	trace_virtio_transport_alloc_pkt(src_cid, src_port,
>-					 dst_cid, dst_port,
>-					 len,
>-					 info->type,
>-					 info->op,
>-					 info->flags);
>-
>-	if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info->vsk))) {
>-		WARN_ONCE(1, "failed to allocate skb on vsock socket with sk_refcnt == 0\n");
>-		goto out;
>-	}
>-
>-	return skb;
>-
>-out:
>-	kfree_skb(skb);
>-	return NULL;
> }
>
> static void virtio_transport_copy_nonlinear_skb(struct sk_buff *skb,
>@@ -214,6 +251,85 @@ static u16 virtio_transport_get_type(struct sock *sk)
> 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> }
>
>+/* Returns a new packet on success, otherwise returns NULL.
>+ *
>+ * If NULL is returned, errp is set to a negative errno.

I had noticed this in Bobby's patches, I think it's an old comment we
left around.

>+ */
>+static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk,
>+						  struct virtio_vsock_pkt_info *info,
>+						  size_t payload_len,
>+						  bool zcopy,
>+						  u32 dst_cid,
>+						  u32 dst_port,
>+						  u32 src_cid,
>+						  u32 src_port)
>+{
>+	struct sk_buff *skb;
>+	size_t skb_len;
>+
>+	skb_len = VIRTIO_VSOCK_SKB_HEADROOM;
>+
>+	if (!zcopy)
>+		skb_len += payload_len;
>+
>+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>+	if (!skb)
>+		return NULL;
>+
>+	virtio_transport_init_hdr(skb, info, src_cid, src_port,
>+				  dst_cid, dst_port,
>+				  payload_len);
>+
>+	/* Set owner here, because '__zerocopy_sg_from_iter()' uses
>+	 * owner of skb without check to update 'sk_wmem_alloc'.
>+	 */
>+	if (vsk)
>+		skb_set_owner_w(skb, sk_vsock(vsk));

why we are moving from skb_set_owner_sk_safe() to skb_set_owner_w()?

We should mention this in the commit description.

>+
>+	if (info->msg && payload_len > 0) {
>+		int err;
>+
>+		if (zcopy) {
>+			err = __zerocopy_sg_from_iter(info->msg, NULL, skb,
>+						      &info->msg->msg_iter,
>+						      payload_len);
>+		} else {
>+			err = virtio_transport_fill_linear_skb(skb, vsk, info, payload_len);
>+		}
>+
>+		if (err)
>+			goto out;
>+
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off = 0;
>+
>+		if (info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
>+			struct virtio_vsock_hdr *hdr;
>+
>+			hdr = virtio_vsock_hdr(skb);

Just `struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);` should be
fine.

>+
>+			hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>+
>+			if (info->msg->msg_flags & MSG_EOR)
>+				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+		}
>+	}
>+
>+	if (info->reply)
>+		virtio_vsock_skb_set_reply(skb);
>+
>+	trace_virtio_transport_alloc_pkt(src_cid, src_port,
>+					 dst_cid, dst_port,
>+					 payload_len,
>+					 info->type,
>+					 info->op,
>+					 info->flags);
>+
>+	return skb;
>+out:
>+	kfree_skb(skb);
>+	return NULL;
>+}
>+
> /* This function can only be used on connecting/connected sockets,
>  * since a socket assigned to a transport is required.
>  *
>@@ -226,6 +342,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	const struct virtio_transport *t_ops;
> 	struct virtio_vsock_sock *vvs;
> 	u32 pkt_len = info->pkt_len;
>+	bool can_zcopy = false;
>+	u32 max_skb_cap;
> 	u32 rest_len;
> 	int ret;
>
>@@ -254,22 +372,49 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>+	/* If zerocopy is not enabled by 'setsockopt()', we behave as
>+	 * there is no MSG_ZEROCOPY flag set.
>+	 */
>+	if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>+		info->flags &= ~MSG_ZEROCOPY;
>+
>+	if (info->flags & MSG_ZEROCOPY)
>+		can_zcopy = virtio_transport_can_zcopy(info, pkt_len);
>+
>+	if (can_zcopy)
>+		max_skb_cap = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>+				    (MAX_SKB_FRAGS * PAGE_SIZE));
>+	else
>+		max_skb_cap = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>+

We use `len` very often, what about `max_skb_len`?

> 	rest_len = pkt_len;
>
> 	do {
> 		struct sk_buff *skb;
> 		size_t skb_len;
>
>-		skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE, rest_len);
>+		skb_len = min(max_skb_cap, rest_len);
>
>-		skb = virtio_transport_alloc_skb(info, skb_len,
>-						 src_cid, src_port,
>-						 dst_cid, dst_port);
>+		skb = virtio_transport_alloc_skb(vsk, info, skb_len, can_zcopy,
>+						 dst_cid, dst_port,
>+						 src_cid, src_port);
> 		if (!skb) {
> 			ret = -ENOMEM;
> 			break;
> 		}
>
>+		/* This is last skb to send this portion of data. */
>+		if (skb_len == rest_len &&
>+		    info->flags & MSG_ZEROCOPY &&
>+		    info->op == VIRTIO_VSOCK_OP_RW) {
>+			if (virtio_transport_init_zcopy_skb(vsk, skb,
>+							    info->msg,
>+							    can_zcopy)) {
>+				ret = -ENOMEM;
>+				break;
>+			}
>+		}
>+
> 		virtio_transport_inc_tx_pkt(vvs, skb);
>
> 		ret = t_ops->send_pkt(skb);
>@@ -884,6 +1029,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>+		.flags = msg->msg_flags,

These flags then get copied into the virtio_vsock_hdr, which I don't
think is a good idea.

Why not using directly info->msg->msg_flags?

> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -935,11 +1081,11 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 	if (!t)
> 		return -ENOTCONN;
>
>-	reply = virtio_transport_alloc_skb(&info, 0,
>-					   le64_to_cpu(hdr->dst_cid),
>-					   le32_to_cpu(hdr->dst_port),
>+	reply = virtio_transport_alloc_skb(NULL, &info, 0, false,
> 					   le64_to_cpu(hdr->src_cid),
>-					   le32_to_cpu(hdr->src_port));
>+					   le32_to_cpu(hdr->src_port),
>+					   le64_to_cpu(hdr->dst_cid),
>+					   le32_to_cpu(hdr->dst_port));
> 	if (!reply)
> 		return -ENOMEM;
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
