Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47CBC433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 14:29:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD3D64E23
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 14:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD3D64E23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B406867B9;
	Thu, 11 Feb 2021 14:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9nb8oViq6X_Q; Thu, 11 Feb 2021 14:29:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C9F61864AD;
	Thu, 11 Feb 2021 14:29:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D93DC0891;
	Thu, 11 Feb 2021 14:29:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 683E6C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4DFF88744C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oJNJWjwKAi51
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:29:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 21D1086E2A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613053770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lW/IdNqoQWH6t/JJ7uY6HVGKpmhmOv+VfmaelHA2RZg=;
 b=WwakLNHdxpDhCa8m4VvOWmf8UopQRMM+7qM3NGmFAXBiVZMXcdsJlZoLo/NbLGRqTx6+fC
 e9MkoVCE2BBt7bvzMpr0j1cE+DNWIXq7cKDt+TXTGtwfSqk/TZS+6AbxWLsjMO2ZjYfcws
 Kwet+RQlEMLxRxF60NhAVrniaN7Fn98=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-AWt045LCPfa3j_jLK3RuWw-1; Thu, 11 Feb 2021 09:29:26 -0500
X-MC-Unique: AWt045LCPfa3j_jLK3RuWw-1
Received: by mail-ed1-f71.google.com with SMTP id g2so4682580edq.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 06:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lW/IdNqoQWH6t/JJ7uY6HVGKpmhmOv+VfmaelHA2RZg=;
 b=j4hNvGZKcqCATl9p5F6B0NpZwdXxRGwhtn6koe3Jp1S3xIjJMoERoJDZc+tfdx0RC7
 0H+yqcQpshPWbcPOi/TENizCCcgYKAQUgOG1IGahguycOO4fptrKIxvIDBdsed6N2oZ5
 3/haOsGAf5DE+ZhMEGeDH0vktUEjvGQh/kvUKwqlAZTaXQkJpXeuRV1XBqzBgNcpi/9F
 afhKTVgXGg9fvdtqHwXvwF+IhwYo20QwG/0R7UkVdmNbT339+OSj00fKl+0unzoVuamk
 5h9U0FbpmkSFOsYW7VAX//+OEmUGBF+v4gW3fVU5Z6L9IuXEdmg4TuSx6XWz+NBbzVCU
 Dtqw==
X-Gm-Message-State: AOAM5319gpJOxoroiI7PH4Gps3CcCefnmlC5jrdcCDoOvW2xSqubTKUA
 PT2072MhoGfNdj4MMVPAeo4F64T9ariiWVjQY23C6TREl7/QLWAKrdKwqdFyt/feddXPyi6Me8x
 2izPZHs/ubb82Q783hg3YuGuDNZNEcZTgHve2UP0W9Q==
X-Received: by 2002:a50:c88d:: with SMTP id d13mr8667769edh.206.1613053765526; 
 Thu, 11 Feb 2021 06:29:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznAyPLBmRbTrAtsfoXI6wrxWQX7kS7AYx9cUSHIaxtMN8RgxFlMSUWsMBn6tza9ZZLHYyDug==
X-Received: by 2002:a50:c88d:: with SMTP id d13mr8667734edh.206.1613053765324; 
 Thu, 11 Feb 2021 06:29:25 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id kz4sm4532925ejc.38.2021.02.11.06.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 06:29:24 -0800 (PST)
Date: Thu, 11 Feb 2021 15:29:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 12/17] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <20210211142921.ne5ics7b42gndc2a@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151747.805754-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151747.805754-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Sun, Feb 07, 2021 at 06:17:44PM +0300, Arseny Krasnov wrote:
>This adds rest of logic for SEQPACKET:
>1) Packet's type is now set in 'virtio_send_pkt_info()' using
>   type of socket.
>2) SEQPACKET specific functions which send SEQ_BEGIN/SEQ_END.
>   Note that both functions may sleep to wait enough space for
>   SEQPACKET header.
>3) SEQ_BEGIN/SEQ_END to TAP packet capture.
>4) Send SHUTDOWN on socket close for SEQPACKET type.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/linux/virtio_vsock.h            |  9 +++
> net/vmw_vsock/virtio_transport_common.c | 99 +++++++++++++++++++++----
> 2 files changed, 95 insertions(+), 13 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index a5e8681bfc6a..c4a39424686d 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -41,6 +41,7 @@ struct virtio_vsock_sock {
> 	u32 user_read_seq_len;
> 	u32 user_read_copied;
> 	u32 curr_rx_msg_cnt;
>+	u32 next_tx_msg_cnt;
> };
>
> struct virtio_vsock_pkt {
>@@ -85,7 +86,15 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+int virtio_transport_seqpacket_seq_send_len(struct vsock_sock *vsk, size_t len, int flags);
>+int virtio_transport_seqpacket_seq_send_eor(struct vsock_sock *vsk, int flags);
> size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk);
>+int
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   int flags,
>+				   bool *msg_ready);
>+
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 51b66f8dd7c7..0aa0fd33e9d6 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -139,6 +139,8 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 		break;
> 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>+	case VIRTIO_VSOCK_OP_SEQ_BEGIN:
>+	case VIRTIO_VSOCK_OP_SEQ_END:
> 		hdr->op = cpu_to_le16(AF_VSOCK_OP_CONTROL);
> 		break;
> 	default:
>@@ -165,6 +167,14 @@ void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
>
>+static u16 virtio_transport_get_type(struct sock *sk)
>+{
>+	if (sk->sk_type == SOCK_STREAM)
>+		return VIRTIO_VSOCK_TYPE_STREAM;
>+	else
>+		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>+}
>+

Maybe add this function in this part of the file from the first patch, 
so you don't need to move it in this series.

> /* This function can only be used on connecting/connected sockets,
>  * since a socket assigned to a transport is required.
>  *
>@@ -179,6 +189,13 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	struct virtio_vsock_pkt *pkt;
> 	u32 pkt_len = info->pkt_len;
>
>+	info->type = virtio_transport_get_type(sk_vsock(vsk));

I'd this change in another patch before this one, since this touch also 
the stream part.

>+
>+	if (info->type == VIRTIO_VSOCK_TYPE_SEQPACKET &&
>+	    info->msg &&
>+	    info->msg->msg_flags & MSG_EOR)
>+		info->flags |= VIRTIO_VSOCK_RW_EOR;
>+
> 	t_ops = virtio_transport_get_ops(vsk);
> 	if (unlikely(!t_ops))
> 		return -EFAULT;
>@@ -397,13 +414,61 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>-static u16 virtio_transport_get_type(struct sock *sk)
>+static int virtio_transport_seqpacket_send_ctrl(struct vsock_sock *vsk,
>+						int type,
>+						size_t len,
>+						int flags)
> {
>-	if (sk->sk_type == SOCK_STREAM)
>-		return VIRTIO_VSOCK_TYPE_STREAM;
>-	else
>-		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct virtio_vsock_pkt_info info = {
>+		.op = type,
>+		.vsk = vsk,
>+		.pkt_len = sizeof(struct virtio_vsock_seq_hdr)
>+	};
>+
>+	struct virtio_vsock_seq_hdr seq_hdr = {
>+		.msg_cnt = vvs->next_tx_msg_cnt,
>+		.msg_len = len
>+	};
>+
>+	struct kvec seq_hdr_kiov = {
>+		.iov_base = (void *)&seq_hdr,
>+		.iov_len = sizeof(struct virtio_vsock_seq_hdr)
>+	};
>+
>+	struct msghdr msg = {0};
>+
>+	//XXX: do we need 'vsock_transport_send_notify_data' pointer?
>+	if (vsock_wait_space(sk_vsock(vsk),
>+			     sizeof(struct virtio_vsock_seq_hdr),
>+			     flags, NULL))
>+		return -1;
>+
>+	iov_iter_kvec(&msg.msg_iter, WRITE, &seq_hdr_kiov, 1, sizeof(seq_hdr));
>+
>+	info.msg = &msg;
>+	vvs->next_tx_msg_cnt++;
>+
>+	return virtio_transport_send_pkt_info(vsk, &info);
>+}
>+
>+int virtio_transport_seqpacket_seq_send_len(struct vsock_sock *vsk, size_t len, int flags)
>+{
>+	return virtio_transport_seqpacket_send_ctrl(vsk,
>+						    VIRTIO_VSOCK_OP_SEQ_BEGIN,
>+						    len,
>+						    flags);
> }
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_seq_send_len);
>+
>+int virtio_transport_seqpacket_seq_send_eor(struct vsock_sock *vsk, int flags)
>+{
>+	return virtio_transport_seqpacket_send_ctrl(vsk,
>+						    VIRTIO_VSOCK_OP_SEQ_END,
>+						    0,
>+						    flags);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_seq_send_eor);
>
> static inline void virtio_transport_remove_pkt(struct virtio_vsock_pkt *pkt)
> {
>@@ -577,6 +642,18 @@ virtio_transport_stream_dequeue(struct vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_stream_dequeue);
>
>+int
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   int flags, bool *msg_ready)
>+{
>+	if (flags & MSG_PEEK)
>+		return -EOPNOTSUPP;
>+
>+	return virtio_transport_seqpacket_do_dequeue(vsk, msg, msg_ready);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>+
> int
> virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
>@@ -658,14 +735,15 @@ EXPORT_SYMBOL_GPL(virtio_transport_do_socket_init);
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
>+	virtio_transport_send_credit_update(vsk, type, NULL);

I think we can remove the 'type' parameter of 
virtio_transport_send_credit_update() since 
virtio_transport_send_pkt_info() will overwrite it.

> }
> EXPORT_SYMBOL_GPL(virtio_transport_notify_buffer_size);
>
>@@ -792,7 +870,6 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.vsk = vsk,
> 	};
>
>@@ -804,7 +881,6 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.flags = (mode & RCV_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> 			 (mode & SEND_SHUTDOWN ?
>@@ -833,7 +909,6 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RW,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>@@ -856,7 +931,6 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RST,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.reply = !!pkt,
> 		.vsk = vsk,
> 	};

These changes could go with the new patch to handle the type directly in 
the virtio_transport_send_pkt_info().


>@@ -1001,7 +1075,7 @@ void virtio_transport_release(struct vsock_sock *vsk)
> 	struct sock *sk = &vsk->sk;
> 	bool remove_sock = true;
>
>-	if (sk->sk_type == SOCK_STREAM)
>+	if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)
> 		remove_sock = virtio_transport_close(vsk);
>
> 	list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
>@@ -1164,7 +1238,6 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RESPONSE,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.remote_cid = le64_to_cpu(pkt->hdr.src_cid),
> 		.remote_port = le32_to_cpu(pkt->hdr.src_port),
> 		.reply = true,

Also this one.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
