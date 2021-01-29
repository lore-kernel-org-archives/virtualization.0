Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F3FC433DB
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 11:04:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B05564DFA
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 11:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B05564DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F21FA87106;
	Fri, 29 Jan 2021 11:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EpImXqNrYtOn; Fri, 29 Jan 2021 11:04:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0E5A185823;
	Fri, 29 Jan 2021 11:04:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9147C0FA7;
	Fri, 29 Jan 2021 11:04:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05EE6C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 11:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EB088228AC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 11:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b3YvDjGyqdoH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 11:03:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 207FC20390
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611918236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8jNn1RZu65PFh0teeF8sFRisJ8tiLMNz3mLh0OpgZ0=;
 b=TGYNUzd0ufd83tnzypS/yvs6ropvMC85DCC7Xj2DhbK35eeWgRHQ+B/gNuMfAgtMBdFgrF
 rjlU5qmWxLHXF6GmdrXrYZZmO9k6oTECRvYeIIX+23asKwkSF3WKAfHx1y8FUjg1V1BUNX
 p1V7SWWSIvwr1FO5bryZOxp2u8hPmAM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-kuarBqiMN-G19cuWW2v1qg-1; Fri, 29 Jan 2021 06:03:55 -0500
X-MC-Unique: kuarBqiMN-G19cuWW2v1qg-1
Received: by mail-ed1-f71.google.com with SMTP id v19so4731350edx.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h8jNn1RZu65PFh0teeF8sFRisJ8tiLMNz3mLh0OpgZ0=;
 b=qN9s34oM4NQjVrObpRv5KHjDJXJH4nneRnoTRKR14K6gOH367ZaCJLzhVICfKCNdkB
 5Xc+m1LHzLmEik+ZK6LSKWAdLsIcqDwpz24deNmoXylfQcPExrRyeHsdDkqE8nInZc2C
 oQ1VSMS98CaAB7SkIhHqAhTKQchJaTPKHB0K7EiInNjIiUrCs3GXRFv7V21axoSIK1by
 JeVdKSt8XmWqQWH5S4+zA1e9Dl322Kd7VzPTky8LTeUzjzZulL/R7E9fzKIe2KDnW7U7
 ClNv1eP85os7XVFh1xDQryNsAthdtQNeh5PPw/ib+7k7lJTlB+lktdqeeUlp9DXr3maK
 pIvg==
X-Gm-Message-State: AOAM531ZqgEy1ctJzSUo7VyfqnjhGOJrRlpGp+0GVxWWiDDdoifQCp6k
 gAFI3bOyz17j6y9Fc7B4iht6eXBfWw8qxpC+RvYqrNEPmCLCZoJpkRnG4ryWZjXnc1o3o5kMTJI
 AM62fBsTUlgDS3qEJMYe01haZOy6k7r0n1TLLt5dYgQ==
X-Received: by 2002:aa7:c6cc:: with SMTP id b12mr4373651eds.67.1611918233834; 
 Fri, 29 Jan 2021 03:03:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyb0Lr6bACIBTquxcxynTIuAK83D3avZb9nheN2qG6OQXcB00hyEZVtxym0C22PxoPxlkOgTQ==
X-Received: by 2002:aa7:c6cc:: with SMTP id b12mr4373629eds.67.1611918233633; 
 Fri, 29 Jan 2021 03:03:53 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s18sm4582235edw.66.2021.01.29.03.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 03:03:52 -0800 (PST)
Date: Fri, 29 Jan 2021 12:03:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 10/13] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <20210129110350.p5h2wtb2xj42rbm4@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111529.599448-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210125111529.599448-1-arseny.krasnov@kaspersky.com>
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

On Mon, Jan 25, 2021 at 02:15:26PM +0300, Arseny Krasnov wrote:
>This adds rest of logic for SEQPACKET:
>1) Shared functions for packet sending now set valid type of packet
>   according socket type.
>2) SEQPACKET specific function like SEQ_BEGIN send and data dequeue.
>3) TAP support for SEQPACKET is not so easy if it is necessary to
>send whole record to TAP interface. This could be done by allocating
>new packet when whole record is received, data of record must be
>copied to TAP packet.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/linux/virtio_vsock.h            |  7 ++++
> net/vmw_vsock/virtio_transport_common.c | 55 +++++++++++++++++++++----
> 2 files changed, 55 insertions(+), 7 deletions(-)
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
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 90f9feef9d8f..fab14679ca7b 100644
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

I think we should do this before merging SOCK_SEQPACKET support because 
it can be very useful to use tcpdump to figure out what's going on, do 
you think it's complicated?

>+	if (le16_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_SEQPACKET)
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
>@@ -659,14 +689,15 @@ EXPORT_SYMBOL_GPL(virtio_transport_do_socket_init);
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
>-					    NULL);
>+	type = virtio_transport_get_type(sk_vsock(vsk));

How about setting the type in virtio_transport_send_pkt_info(), so we 
can avoid all these changes?


>+	virtio_transport_send_credit_update(vsk, type, NULL);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_notify_buffer_size);
>
>@@ -793,10 +824,11 @@ int virtio_transport_connect(struct vsock_sock *vsk)
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
>@@ -805,7 +837,6 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.flags = (mode & RCV_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> 			 (mode & SEND_SHUTDOWN ?
>@@ -813,6 +844,8 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 		.vsk = vsk,
> 	};
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
>@@ -834,12 +867,18 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
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
>@@ -857,7 +896,6 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RST,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.reply = !!pkt,
> 		.vsk = vsk,
> 	};
>@@ -866,6 +904,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 	if (pkt && le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RST)
> 		return 0;
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
>
>@@ -1177,13 +1217,14 @@ virtio_transport_send_response(struct vsock_sock *vsk,
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
