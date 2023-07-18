Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45466EB64DA
	for <virtualization@archiver.kernel.org>; Tue, 18 Jul 2023 13:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C696D81EE0;
	Tue, 18 Jul 2023 13:51:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C696D81EE0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OdXepaUG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ILFWIKsnEHrd; Tue, 18 Jul 2023 13:51:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1450281E5A;
	Tue, 18 Jul 2023 13:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1450281E5A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2C98C0071;
	Tue, 18 Jul 2023 13:51:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19876C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 13:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DACC081EDD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 13:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DACC081EDD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8huDVzaSwTec
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 13:51:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A355481E5A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A355481E5A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689688286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nQE+ECYXertmxQmnjGXdYM0wCD7EJx6wVGHXR+lHouc=;
 b=OdXepaUGpHUPbFr1rWHiAG0tFYeMsGqo8r4mVbbUMwnyZBTJoZL6aJ9md4aVWkyM2iVOO3
 9LP7nQe9c+s/0/SxwmGQzRE4ESLZW7euMTk53SqC5GOaEsNbuWukN1JHTs2vCDh/L9mFK9
 Kl9/t0daJWmYrhwhdDzbsLw4cUnBHG8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-tZIxT0LrOqqdqEDLuGyD4w-1; Tue, 18 Jul 2023 09:51:24 -0400
X-MC-Unique: tZIxT0LrOqqdqEDLuGyD4w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63c566512c0so45896946d6.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 06:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689688284; x=1690293084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQE+ECYXertmxQmnjGXdYM0wCD7EJx6wVGHXR+lHouc=;
 b=gyCY5/q1P9MEeSnVt05Q1ejU7H9CplgM3J4cifQg88l3Ug9EcELoU+Jq1NlzF2T/8x
 UyZ692qu/Wwhi1plB7cPh5PlGR1gDhxj6xyh+9BilpotfRMSuHYMmd+sKw+x7cCfvE8g
 p2SU8O5d319Fy4iasANRNtPOUw0BXcsPxHr2ctOZE4qpj+KeYfXW9o8VYCpd6V/rSEXj
 uLIGm9+YKKONRAfnz5k14zPw0ezLVAeDjnuOPFXnhyNbg/JXL41j9ID45czRSCgWaA3d
 cesrCCt+D3sU/s6nFEM+s0zvbJN5vMEnVzYR9kTA08Fn1XEQ+ZO5biTZCNii24enkPWx
 +F2A==
X-Gm-Message-State: ABy/qLb7XsyI6NREzkuCNpgNpeJ/SzSsUvLWsdGtBFhQN7JswPqEJEWd
 oLJPhx3syys1ODlcj9Bm0WRRZc+kBsJmMovjLDaPi1vUWZRJycw1drAgfy0HZ0gYCmnXOAFCdvB
 STtsIWCNOUIJXzyGL6FjeNODF2817QpAMjA2ZtVEJZw==
X-Received: by 2002:a05:6214:300a:b0:637:2eb:6c23 with SMTP id
 ke10-20020a056214300a00b0063702eb6c23mr13702735qvb.18.1689688283814; 
 Tue, 18 Jul 2023 06:51:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE8cekRjzkERg8v4oOdF3HpmUKDTKckd6xPnZCWJY9tjq+p9BwONtxIfmhEO75w7E/fQPekxA==
X-Received: by 2002:a05:6214:300a:b0:637:2eb:6c23 with SMTP id
 ke10-20020a056214300a00b0063702eb6c23mr13702714qvb.18.1689688283523; 
 Tue, 18 Jul 2023 06:51:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-94.retail.telecomitalia.it.
 [79.46.200.94]) by smtp.gmail.com with ESMTPSA id
 f18-20020a0cf3d2000000b00637873ff0f3sm743721qvm.15.2023.07.18.06.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 06:51:23 -0700 (PDT)
Date: Tue, 18 Jul 2023 15:51:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v1 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <k7rovmw7abzkwhngbqwgg74qgkcvq2ggygo46y6skkxnchgqcj@7yabz52oh4sr>
References: <20230717210051.856388-1-AVKrasnov@sberdevices.ru>
 <20230717210051.856388-5-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230717210051.856388-5-AVKrasnov@sberdevices.ru>
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

On Tue, Jul 18, 2023 at 12:00:51AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ZEROCOPY flag on transmission path: if this
>flag is set and zerocopy transmission is possible, then non-linear skb
>will be created and filled with the pages of user's buffer. Pages of
>user's buffer are locked in memory by 'get_user_pages()'. Second thing
>that this patch does is replace type of skb owning: instead of calling
>'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
>change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
>of socket, so to decrease this field correctly proper skb destructor is
>needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * Refactorings of 'if' conditions.
>  * Remove extra blank line.
>  * Remove 'frag_off' field unneeded init.
>  * Add function 'virtio_transport_fill_skb()' which fills both linear
>    and non-linear skb with provided data.
>
> net/vmw_vsock/virtio_transport_common.c | 260 ++++++++++++++++++------
> 1 file changed, 197 insertions(+), 63 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 26a4d10da205..1fb0a0f694c6 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -37,73 +37,115 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
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
>-	void *payload;
>-	int err;
>+static bool virtio_transport_can_zcopy(struct virtio_vsock_pkt_info *info,
>+				       size_t max_to_send)
>+{
>+	struct iov_iter *iov_iter;
>
>-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>-	if (!skb)
>-		return NULL;
>+	if (!info->msg)
>+		return false;
>
>-	hdr = virtio_vsock_hdr(skb);
>-	hdr->type	= cpu_to_le16(info->type);
>-	hdr->op		= cpu_to_le16(info->op);
>-	hdr->src_cid	= cpu_to_le64(src_cid);
>-	hdr->dst_cid	= cpu_to_le64(dst_cid);
>-	hdr->src_port	= cpu_to_le32(src_port);
>-	hdr->dst_port	= cpu_to_le32(dst_port);
>-	hdr->flags	= cpu_to_le32(info->flags);
>-	hdr->len	= cpu_to_le32(len);
>+	iov_iter = &info->msg->msg_iter;
>
>-	if (info->msg && len > 0) {
>-		payload = skb_put(skb, len);
>-		err = memcpy_from_msg(payload, info->msg, len);
>-		if (err)
>-			goto out;
>+	/* Data is simple buffer. */
>+	if (iter_is_ubuf(iov_iter))
>+		return true;
>
>-		if (msg_data_left(info->msg) == 0 &&
>-		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
>-			hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>+	if (!iter_is_iovec(iov_iter))
>+		return false;
>
>-			if (info->msg->msg_flags & MSG_EOR)
>-				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>-		}
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
>+		if (!uarg)
>+			return -1;
>+
>+		uarg_zc = uarg_to_msgzc(uarg);
>+		uarg_zc->zerocopy = zerocopy ? 1 : 0;
> 	}
>
>-	if (info->reply)
>-		virtio_vsock_skb_set_reply(skb);
>+	skb_zcopy_init(skb, uarg);
>
>-	trace_virtio_transport_alloc_pkt(src_cid, src_port,
>-					 dst_cid, dst_port,
>-					 len,
>-					 info->type,
>-					 info->op,
>-					 info->flags);
>+	return 0;
>+}
>
>-	if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info->vsk))) {
>-		WARN_ONCE(1, "failed to allocate skb on vsock socket with sk_refcnt == 0\n");
>-		goto out;
>+static int virtio_transport_fill_skb(struct sk_buff *skb,
>+				     struct virtio_vsock_pkt_info *info,
>+				     size_t len,
>+				     bool zcopy)
>+{
>+	if (zcopy) {
>+		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
>+					      &info->msg->msg_iter,
>+					      len);
>+	} else {
>+		void *payload;
>+		int err;
>+
>+		payload = skb_put(skb, len);
>+		err = memcpy_from_msg(payload, info->msg, len);
>+		if (err)
>+			return -1;
>+
>+		if (msg_data_left(info->msg))
>+			return 0;
>+
>+		return 0;
> 	}
>+}
>
>-	return skb;
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
>-out:
>-	kfree_skb(skb);
>-	return NULL;
>+	hdr = virtio_vsock_hdr(skb);
>+	hdr->type	= cpu_to_le16(info->type);
>+	hdr->op		= cpu_to_le16(info->op);
>+	hdr->src_cid	= cpu_to_le64(src_cid);
>+	hdr->dst_cid	= cpu_to_le64(dst_cid);
>+	hdr->src_port	= cpu_to_le32(src_port);
>+	hdr->dst_port	= cpu_to_le32(dst_port);
>+	hdr->flags	= cpu_to_le32(info->flags);
>+	hdr->len	= cpu_to_le32(len);
> }
>
> static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>@@ -214,6 +256,70 @@ static u16 virtio_transport_get_type(struct sock *sk)
> 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> }
>
>+static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk,
>+						  struct virtio_vsock_pkt_info *info,
>+						  size_t payload_len,
>+						  bool zcopy,
>+						  u32 dst_cid,
>+						  u32 dst_port,
>+						  u32 src_cid,
>+						  u32 src_port)

Before this patch the order of dst_* and src_* fields were reversed
for virtio_transport_alloc_skb(), why are we changing it?

I think putting them back as before (and following the same ordering in
the new functions as well) makes the patch easier to review and the code
easier to maintain.

Thanks,
Stefano

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
>+
>+	if (info->msg && payload_len > 0) {
>+		int err;
>+
>+		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
>+		if (err)
>+			goto out;
>+
>+		if (info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
>+			struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
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
>@@ -222,10 +328,12 @@ static u16 virtio_transport_get_type(struct sock *sk)
> static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 					  struct virtio_vsock_pkt_info *info)
> {
>+	u32 max_skb_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> 	u32 src_cid, src_port, dst_cid, dst_port;
> 	const struct virtio_transport *t_ops;
> 	struct virtio_vsock_sock *vvs;
> 	u32 pkt_len = info->pkt_len;
>+	bool can_zcopy = false;
> 	u32 rest_len;
> 	int ret;
>
>@@ -254,22 +362,48 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>+	if (info->msg) {
>+		/* If zerocopy is not enabled by 'setsockopt()', we behave as
>+		 * there is no MSG_ZEROCOPY flag set.
>+		 */
>+		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>+			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>+
>+		if (info->msg->msg_flags & MSG_ZEROCOPY)
>+			can_zcopy = virtio_transport_can_zcopy(info, pkt_len);
>+
>+		if (can_zcopy)
>+			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>+					    (MAX_SKB_FRAGS * PAGE_SIZE));
>+	}
>+
> 	rest_len = pkt_len;
>
> 	do {
> 		struct sk_buff *skb;
> 		size_t skb_len;
>
>-		skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE, rest_len);
>+		skb_len = min(max_skb_len, rest_len);
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
>+		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
>+		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
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
>@@ -934,11 +1068,11 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
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
