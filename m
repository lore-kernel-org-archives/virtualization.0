Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE33EC433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:15:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6531622BEA
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6531622BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1B58320107;
	Mon, 18 Jan 2021 15:15:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id noiIvw+kb9-x; Mon, 18 Jan 2021 15:15:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DC5C31FD7D;
	Mon, 18 Jan 2021 15:15:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8C8CC08A1;
	Mon, 18 Jan 2021 15:15:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 265D0C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2230485A84
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZpWT6FalSnVn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:15:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 296028551F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610982941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcaqopXIlvlEXLRCW3l9OfviX/eFyfP/wopbLVj233M=;
 b=CHJN1lWwx3j9+36/QougdnoqRJ30s7ZYBWXt9hFgKyJisYfsT0hI7ceNQn+W+5JMjUdcTA
 w5VPnuLr+FU2z8PrUFz0bcqMfpBTN1h99BnqOtkpFOdXcgY12QtEPJCHd7fIvbyRCEXLKY
 02jUdT1uqTdqsx0eSx9rIrs9uf5JKLU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-JdDr0b_-OB6-clrkiNt9nw-1; Mon, 18 Jan 2021 10:15:40 -0500
X-MC-Unique: JdDr0b_-OB6-clrkiNt9nw-1
Received: by mail-wr1-f69.google.com with SMTP id m20so8436573wrh.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 07:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xcaqopXIlvlEXLRCW3l9OfviX/eFyfP/wopbLVj233M=;
 b=fqeEN9wjiRsSVHUvuKRRecqSeyF2BKvDZxiNRYseNhvv6Dr10x8k+BxQ+7WeNj2PJs
 rFZ+CFhMQRp8Gk92xvkOXT8sjXNYfMli56Ehal0fNMEfAbPlOzIEXhU6fbMMfYx+ARfO
 KOdYPkgaSFPG74iI4gBzYUdaWLWI25eEb/S1PXgLaVevyig8g0sfpeXkPBolhUs7Q/SP
 ETq1/flrpTkZJfPUq/fIefFyeGUIyjPWDVouCcGMXLRqMxe9tHfCnpWXe/cNrol4G2Q1
 +AmZHeNkohhfMC44nihvrTOZyvwJLOa/qp6q3OZbD7Hnd0ptY4UU2SrNeVcSNXUs/Z2w
 gMEA==
X-Gm-Message-State: AOAM5307FryOX/VIbZfXv6d71k4NBvgq1XmT47ObvzUvZiNs8zEKVSM5
 ZOzNHEGf87aYb3Wy0gWWjSXKloFFyKx1H38vnpxq2iBhw7pHF3Lj9iPy+Njd+thjIkxwosMNT/Z
 aK2c431OftmJUujJE9W9+669FaPzXNPtnnfcZKswoQw==
X-Received: by 2002:adf:8342:: with SMTP id 60mr26549269wrd.140.1610982938684; 
 Mon, 18 Jan 2021 07:15:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc7QTOAkMvdn8bwe1eCaMlvVb/4VRCysRSLWf+/IRHgXNYr1i0nxD/bAnSmDlH1IG2U6GWxQ==
X-Received: by 2002:adf:8342:: with SMTP id 60mr26549247wrd.140.1610982938516; 
 Mon, 18 Jan 2021 07:15:38 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id h13sm29904915wrm.28.2021.01.18.07.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 07:15:37 -0800 (PST)
Date: Mon, 18 Jan 2021 16:15:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 11/13] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <20210118151535.ugjshvej3lrpnp3d@steredhat>
References: <20210115053553.1454517-1-arseny.krasnov@kaspersky.com>
 <20210115054426.1457041-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210115054426.1457041-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Fri, Jan 15, 2021 at 08:44:22AM +0300, Arseny Krasnov wrote:
>This adds rest of logic for SEQPACKET:
>1) Shared functions for packet sending now set valid type of packet
>   according socket type.
>2) SEQPACKET specific function like SEQ_BEGIN send and data dequeue.
>3) Ops for virtio transport.
>4) TAP support for SEQPACKET is not so easy if it is necessary to send
>   whole record to TAP interface. This could be done by allocating
>   new packet when whole record is received, data of record must be
>   copied to TAP packet.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/linux/virtio_vsock.h            |  7 ++++
> net/vmw_vsock/virtio_transport.c        |  4 ++
> net/vmw_vsock/virtio_transport_common.c | 54 ++++++++++++++++++++++---
> 3 files changed, 59 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index af8705ea8b95..ad9783df97c9 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -84,7 +84,14 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+bool virtio_transport_seqpacket_seq_send_len(struct vsock_sock *vsk, size_t len);
> size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk);
>+ssize_t
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   size_t len,
>+				   int type);
>+
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..5a7ab1befee8 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -469,6 +469,10 @@ static struct virtio_transport virtio_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_seq_send_len	  = virtio_transport_seqpacket_seq_send_len,
>+		.seqpacket_seq_get_len	  = virtio_transport_seqpacket_seq_get_len,
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index c3e07eb1c666..5fdf1adfdaab 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -139,6 +139,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 		break;
> 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>+	case VIRTIO_VSOCK_OP_SEQ_BEGIN:
> 		hdr->op = cpu_to_le16(AF_VSOCK_OP_CONTROL);
> 		break;
> 	default:
>@@ -157,6 +158,10 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>
> void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
> {
>+	/* TODO: implement tap support for SOCK_SEQPACKET. */
>+	if (le32_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_SEQPACKET)
             ^
hdr.type is __le16, so please use le16_to_cpu()

>+		return;
>+
> 	if (pkt->tap_delivered)
> 		return;
>
>@@ -405,6 +410,19 @@ static u16 virtio_transport_get_type(struct sock *sk)
> 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
> }
>
>+bool virtio_transport_seqpacket_seq_send_len(struct vsock_sock *vsk, size_t len)
>+{
>+	struct virtio_vsock_pkt_info info = {
>+		.type = VIRTIO_VSOCK_TYPE_SEQPACKET,
>+		.op = VIRTIO_VSOCK_OP_SEQ_BEGIN,
>+		.vsk = vsk,
>+		.flags = len
>+	};
>+
>+	return virtio_transport_send_pkt_info(vsk, &info);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_seq_send_len);
>+
> static inline void virtio_transport_del_n_free_pkt(struct virtio_vsock_pkt *pkt)
> {
> 	list_del(&pkt->list);
>@@ -576,6 +594,18 @@ virtio_transport_stream_dequeue(struct vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_stream_dequeue);
>
>+ssize_t
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   size_t len, int flags)
>+{
>+	if (flags & MSG_PEEK)
>+		return -EOPNOTSUPP;
>+
>+	return virtio_transport_seqpacket_do_dequeue(vsk, msg, len);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>+
> int
> virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
>@@ -659,13 +689,15 @@ EXPORT_SYMBOL_GPL(virtio_transport_do_socket_init);
> void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>+	int type;
>
> 	if (*val > VIRTIO_VSOCK_MAX_BUF_SIZE)
> 		*val = VIRTIO_VSOCK_MAX_BUF_SIZE;
>
> 	vvs->buf_alloc = *val;
>
>-	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
>+	type = virtio_transport_get_type(sk_vsock(vsk));
>+	virtio_transport_send_credit_update(vsk, type,
> 					    NULL);

With this change, you can move 'NULL' in the previous line.

> }
> EXPORT_SYMBOL_GPL(virtio_transport_notify_buffer_size);
>@@ -793,10 +825,11 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.vsk = vsk,
> 	};
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_connect);
>@@ -805,7 +838,6 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.flags = (mode & RCV_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> 			 (mode & SEND_SHUTDOWN ?
>@@ -813,6 +845,8 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 		.vsk = vsk,
> 	};
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
>@@ -834,12 +868,18 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RW,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>+		.flags = 0,
> 	};
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
>+	if (info.type == VIRTIO_VSOCK_TYPE_SEQPACKET &&
>+	    msg->msg_flags & MSG_EOR)
>+		info.flags |= VIRTIO_VSOCK_RW_EOR;
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_stream_enqueue);
>@@ -857,7 +897,6 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RST,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.reply = !!pkt,
> 		.vsk = vsk,
> 	};
>@@ -866,6 +905,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 	if (pkt && le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RST)
> 		return 0;
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
>
>@@ -1177,13 +1218,14 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RESPONSE,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.remote_cid = le64_to_cpu(pkt->hdr.src_cid),
> 		.remote_port = le32_to_cpu(pkt->hdr.src_port),
> 		.reply = true,
> 		.vsk = vsk,
> 	};
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
