Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D5CA0FE6
	for <virtualization@archiver.kernel.org>; Fri,  1 Sep 2023 12:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 757C2418EA;
	Fri,  1 Sep 2023 12:30:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 757C2418EA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bwl093gF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d1XwivkCw0ve; Fri,  1 Sep 2023 12:30:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 515734192C;
	Fri,  1 Sep 2023 12:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 515734192C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11CF6C0039;
	Fri,  1 Sep 2023 12:30:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF163C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8282260E47
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8282260E47
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bwl093gF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A3q7MLO1Oxbl
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:30:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 075B560E76
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:30:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 075B560E76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693571428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wlSInNWjhL7x2yeDRNI/eFcOzlex+3MaTg2i/wzmzA=;
 b=Bwl093gFn99H5M+sig2T0YMSy+r0b8FaqtBl3AaMFr+dxbuOmLaPipSNmAj2AQ/9kNDoUq
 ukYXpR4O3LZek2xizUHhPIud+62cLseQD7j+L95bDrMWWsCQoNwsqZ4oi12Bo8dV5ERW6R
 iBAsRvz6YHbQu0c6/HO+7QPDLDB1Y9c=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-vtY8ewAHOOaYlU_et3jaWg-1; Fri, 01 Sep 2023 08:30:27 -0400
X-MC-Unique: vtY8ewAHOOaYlU_et3jaWg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5009121067cso2316617e87.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Sep 2023 05:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693571425; x=1694176225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wlSInNWjhL7x2yeDRNI/eFcOzlex+3MaTg2i/wzmzA=;
 b=VuXtAfrzzY7tuzS9teXqWbCyOXeLvzsFfY+DIAQc7+342KylSAScGpIBSWFyipPhrk
 1cIAE04QaLCFp6A29R+JwrDycxzhLJZXzFfoTifqtC61SoJTaFiObZ3xj1iusGsWngla
 k5W40m8TSH4iM+suvIW7bCrF+G30hq00WgixIfZ/v+/SWrz19k1UaKfGjCwg7a69qkhn
 bj/VX3uVFW1Tmnwd2wR6GgynIotbxGq7xSd94jOh1sUvu5R0KjApWPCHbB90Tj1gWS/t
 2bjvNqPG5lUqFkyEblK5xP79Clg2vCVJyVNk9JtWpP11lcb7qrZGCVXmnXqueVi4bEIz
 FsSg==
X-Gm-Message-State: AOJu0YzBGFJ8gQB3vhrZO0a/Cjd/aRXjZKgyHjrl2uvDpxLhXGTTzOwK
 iiL3TbNAk+Msc2dI8kEX0OfztI2gKniXp53eR7FOcIJf+5PXDHcG/927X3fbzVHFHdxT4k8NlBZ
 JVcbHnVHhZj2vpG5AMgY/rbQKILMGJ9HNRWJf7lOqIw==
X-Received: by 2002:ac2:58cc:0:b0:500:7c51:4684 with SMTP id
 u12-20020ac258cc000000b005007c514684mr1338256lfo.56.1693571424857; 
 Fri, 01 Sep 2023 05:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwsynilaoZ3C1p2jpzXAgspWrZgKc6y1cID8TwydNktR7lKRy2lNzOS+PLYgtzL3MNYIUgxw==
X-Received: by 2002:ac2:58cc:0:b0:500:7c51:4684 with SMTP id
 u12-20020ac258cc000000b005007c514684mr1338235lfo.56.1693571424458; 
 Fri, 01 Sep 2023 05:30:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 f6-20020a056402160600b0052544bca116sm1994242edv.13.2023.09.01.05.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 05:30:23 -0700 (PDT)
Date: Fri, 1 Sep 2023 14:30:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v7 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <p2u2irlju6yuy54w4tqstaijhpnbmqxwavsdumsmyskrjguwux@kmd7cbavhjbh>
References: <20230827085436.941183-1-avkrasnov@salutedevices.com>
 <20230827085436.941183-5-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230827085436.941183-5-avkrasnov@salutedevices.com>
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

On Sun, Aug 27, 2023 at 11:54:36AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ZEROCOPY flag on transmission path: if this
>flag is set and zerocopy transmission is possible (enabled in socket
>options and transport allows zerocopy), then non-linear skb will be
>created and filled with the pages of user's buffer. Pages of user's
>buffer are locked in memory by 'get_user_pages()'. Second thing that
>this patch does is replace type of skb owning: instead of calling
>'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
>change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
>of socket, so to decrease this field correctly proper skb destructor is
>needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * Refactorings of 'if' conditions.
>  * Remove extra blank line.
>  * Remove 'frag_off' field unneeded init.
>  * Add function 'virtio_transport_fill_skb()' which fills both linear
>    and non-linear skb with provided data.
> v1 -> v2:
>  * Use original order of last four arguments in 'virtio_transport_alloc_skb()'.
> v2 -> v3:
>  * Add new transport callback: 'msgzerocopy_check_iov'. It checks that
>    provided 'iov_iter' with data could be sent in a zerocopy mode.
>    If this callback is not set in transport - transport allows to send
>    any 'iov_iter' in zerocopy mode. Otherwise - if callback returns 'true'
>    then zerocopy is allowed. Reason of this callback is that in case of
>    G2H transmission we insert whole skb to the tx virtio queue and such
>    skb must fit to the size of the virtio queue to be sent in a single
>    iteration (may be tx logic in 'virtio_transport.c' could be reworked
>    as in vhost to support partial send of current skb). This callback
>    will be enabled only for G2H path. For details pls see comment
>    'Check that tx queue...' below.
> v3 -> v4:
>  * 'msgzerocopy_check_iov' moved from 'struct vsock_transport' to
>    'struct virtio_transport' as it is virtio specific callback and
>    never needed in other transports.
> v4 -> v5:
>  * 'msgzerocopy_check_iov' renamed to 'can_msgzerocopy' and now it
>    uses number of buffers to send as input argument. I think there is
>    no need to pass iov to this callback (at least today, it is used only
>    by guest side of virtio transport), because the only thing that this
>    callback does is comparison of number of buffers to be inserted to
>    the tx queue and size of this queue.
>  * Remove any checks for type of current 'iov_iter' with payload (is it
>    'iovec' or 'ubuf'). These checks left from the earlier versions where I
>    didn't use already implemented kernel API which handles every type of
>    'iov_iter'.
> v5 -> v6:
>  * Refactor 'virtio_transport_fill_skb()'.
>  * Add 'WARN_ON_ONCE()' and comment on invalid combination of destination
>    socket and payload in 'virtio_transport_alloc_skb()'.
>
> include/linux/virtio_vsock.h            |   5 +
> net/vmw_vsock/virtio_transport.c        |  33 ++++
> net/vmw_vsock/virtio_transport_common.c | 250 ++++++++++++++++++------
> 3 files changed, 231 insertions(+), 57 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index a91fbdf233e4..56501cd9843f 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -160,6 +160,11 @@ struct virtio_transport {
>
> 	/* Takes ownership of the packet */
> 	int (*send_pkt)(struct sk_buff *skb);
>+
>+	/* Used in MSG_ZEROCOPY mode. Checks that provided data
>+	 * could be transmitted with zerocopy mode.
>+	 */
>+	bool (*can_msgzerocopy)(int bufs_num);
> };
>
> ssize_t
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 8636477cf088..4ce44916e585 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -453,6 +453,38 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+static bool virtio_transport_can_msgzerocopy(int bufs_num)
>+{
>+	struct virtio_vsock *vsock;
>+	bool res = false;
>+
>+	rcu_read_lock();
>+
>+	vsock = rcu_dereference(the_virtio_vsock);
>+	if (vsock) {
>+		struct virtqueue *vq = vsock->vqs[VSOCK_VQ_TX];
>+
>+		/* Check that tx queue is large enough to keep whole
>+		 * data to send. This is needed, because when there is
>+		 * not enough free space in the queue, current skb to
>+		 * send will be reinserted to the head of tx list of
>+		 * the socket to retry transmission later, so if skb
>+		 * is bigger than whole queue, it will be reinserted
>+		 * again and again, thus blocking other skbs to be sent.
>+		 * Each page of the user provided buffer will be added
>+		 * as a single buffer to the tx virtqueue, so compare
>+		 * number of pages against maximum capacity of the queue.
>+		 * +1 means buffer for the packet header.
>+		 */
>+		if (bufs_num + 1 <= vq->num_max)

I'd move the + 1 in the caller.

>+			res = true;
>+	}
>+
>+	rcu_read_unlock();
>+
>+	return res;
>+}
>+
> static bool virtio_transport_seqpacket_allow(u32 remote_cid);
>
> static struct virtio_transport virtio_transport = {
>@@ -502,6 +534,7 @@ static struct virtio_transport virtio_transport = {
> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>+	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
> };
>
> static bool virtio_transport_seqpacket_allow(u32 remote_cid)
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 3a48e48a99ac..7f42ad131a69 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -37,27 +37,99 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
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
                                               ^
I'd call it `pkt_len`, `max_to_send` is confusing IMHO. I didn't
initially if it was the number of buffers or bytes.

>+{
>+	const struct virtio_transport *t_ops;
>+	struct iov_iter *iov_iter;
>+
>+	if (!info->msg)
>+		return false;
>+
>+	iov_iter = &info->msg->msg_iter;
>+
>+	if (iov_iter->iov_offset)
>+		return false;
>+
>+	/* We can't send whole iov. */
>+	if (iov_iter->count > max_to_send)
>+		return false;
>+
>+	/* Check that transport can send data in zerocopy mode. */
>+	t_ops = virtio_transport_get_ops(info->vsk);
>+
>+	if (t_ops->can_msgzerocopy) {

So if `can_msgzerocopy` is not implemented, we always return true after
this point. Should we mention it in the .can_msgzerocopy documentation?

Can we also mention in the commit description why this is need only for
virtio_tranport and not for vhost and loopback?

>+		int pages_in_iov = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>+		int pages_to_send = min(pages_in_iov, MAX_SKB_FRAGS);
>+
>+		return t_ops->can_msgzerocopy(pages_to_send);
>+	}
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
>+
>+		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>+					    iter->count,
>+					    NULL);
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
>+static int virtio_transport_fill_skb(struct sk_buff *skb,
>+				     struct virtio_vsock_pkt_info *info,
>+				     size_t len,
>+				     bool zcopy)
>+{
> 	void *payload;
> 	int err;
>
>-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>-	if (!skb)
>-		return NULL;
>+	if (zcopy)
>+		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
>+					       &info->msg->msg_iter,
>+					       len);
>+
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

I'd move `len` after `info` like in virtio_transport_alloc_skb().
And maybe we can use the same name on both (`len` or `payload_len`).

>+{
>+	struct virtio_vsock_hdr *hdr;
>
> 	hdr = virtio_vsock_hdr(skb);
> 	hdr->type	= cpu_to_le16(info->type);
>@@ -68,42 +140,6 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
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
> static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>@@ -214,6 +250,78 @@ static u16 virtio_transport_get_type(struct sock *sk)
> 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> }
>
>+static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk,
>+						  struct virtio_vsock_pkt_info *info,
>+						  size_t payload_len,
>+						  bool zcopy,
>+						  u32 src_cid,
>+						  u32 src_port,
>+						  u32 dst_cid,
>+						  u32 dst_port)
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
>+	/* If 'vsk' != NULL then payload is always present, so we
>+	 * will never call '__zerocopy_sg_from_iter()' below without
>+	 * setting skb owner in 'skb_set_owner_w()'. The only case
>+	 * when 'vsk' == NULL is VIRTIO_VSOCK_OP_RST control message
>+	 * without payload.
>+	 */
>+	WARN_ON_ONCE(!(vsk && (info->msg && payload_len)) && zcopy);
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
>+		err = virtio_transport_fill_skb(skb, info, payload_len, 
>zcopy);
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
>@@ -222,10 +330,12 @@ static u16 virtio_transport_get_type(struct sock *sk)
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
>@@ -254,15 +364,30 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
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
>+		skb = virtio_transport_alloc_skb(vsk, info, skb_len, can_zcopy,
> 						 src_cid, src_port,
> 						 dst_cid, dst_port);
> 		if (!skb) {
>@@ -270,6 +395,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 			break;
> 		}
>
>+		/* This is last skb to send this portion of data. */

Sorry I didn't get it :-(

Can you elaborate this a bit more?

Thanks,
Stefano

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
>@@ -985,7 +1121,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 	if (!t)
> 		return -ENOTCONN;
>
>-	reply = virtio_transport_alloc_skb(&info, 0,
>+	reply = virtio_transport_alloc_skb(NULL, &info, 0, false,
> 					   le64_to_cpu(hdr->dst_cid),
> 					   le32_to_cpu(hdr->dst_port),
> 					   le64_to_cpu(hdr->src_cid),
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
