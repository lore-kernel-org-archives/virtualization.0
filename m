Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04454C433C1
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:18:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AE560C3E
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AE560C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0652C40265;
	Thu, 25 Mar 2021 10:18:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-qHgy0PjvV2; Thu, 25 Mar 2021 10:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27DDF40263;
	Thu, 25 Mar 2021 10:18:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0DBBC000E;
	Thu, 25 Mar 2021 10:18:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0000C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB1124024B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UyUA7eEzWS6m
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:18:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A6FF401E0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616667528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hUhrozeu57DSs+XU36A+D781UPvSZ/VpjRmqBL1uGQ0=;
 b=G50sxMj5thVD/DJZQ5Vwj3ZKrDDwHlRCjVAcCHlROtH6/2INADomWyc6yclZUxgonL7u4N
 K6cbq/3/CsFh1JSNSTWBCXGGxQ4qacH41GOWzBh9pu3/3oovfKr1ODx8Zn1gLwn58AgMiV
 7zc0WZiOogXUiNoBGPdZso7VFdsbCa4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-2ovCvGxrPZGwRVKuMxlThg-1; Thu, 25 Mar 2021 06:18:46 -0400
X-MC-Unique: 2ovCvGxrPZGwRVKuMxlThg-1
Received: by mail-wm1-f70.google.com with SMTP id f9so1488127wml.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 03:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hUhrozeu57DSs+XU36A+D781UPvSZ/VpjRmqBL1uGQ0=;
 b=mqb7fraiskaXgviURxK5P0baEZ+d2zlqHeWoqRv7SyYgay9X81hpA72MO1pUwUlSai
 7idMYP7+ojM0UGdORLIkjJTWbYppPc/XtGjMDz9mZpJCEAYbHUVCcCmAy3TskFVCTLCK
 mM7sAIDghkpTXpSXK4DFN7WH++wP5gPDyIS/pHw+vk6CP3EqqMSQoK1ACYD2ny5HvqLX
 1OSZ4XAejrm08RlJyZphtQZpUgyC5wE//GcbbvdSRpiYFUuqazimkLt+myIu5+YTdlZX
 4cZkgUjeJQomywT1T6Yh7XJei0pM6LSrYCbRhGS/xK9ULi+oaDVLsOp2x6Ter9QicNIr
 ADTg==
X-Gm-Message-State: AOAM5339oVed6l5eBF+6SJ0K/3aJPhGCFozbnP4LW4o57dyWQZZVsm8F
 aBQ5OfiPi9X8HGqf6006Mk5KG1bipIUd3TesxIvyijfBa9vOLmUvy8UkvBQgrdtU5IvnnB3FmaD
 1kkDKkAu4W4oSg1HWRWyLx6IqO6CxGjIMw4Ryqc6aWg==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr8113114wrp.264.1616667524631; 
 Thu, 25 Mar 2021 03:18:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBlfzI+IvG48qHisDpU2ibEIiKoa3byd0gc11GfyaF7IgQ3ryeVPTESrDxVp1YDKp4p64vHw==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr8113089wrp.264.1616667524435; 
 Thu, 25 Mar 2021 03:18:44 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id m11sm7294285wri.44.2021.03.25.03.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 03:18:44 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:18:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 14/22] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <20210325101841.o7gs7peafxwb7rfd@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131332.2461409-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131332.2461409-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Tue, Mar 23, 2021 at 04:13:29PM +0300, Arseny Krasnov wrote:
>This adds rest of logic for SEQPACKET:
>1) SEQPACKET specific functions which send SEQ_BEGIN/SEQ_END.
>   Note that both functions may sleep to wait enough space for
>   SEQPACKET header.
>2) SEQ_BEGIN/SEQ_END in TAP packet capture.
>3) Send SHUTDOWN on socket close for SEQPACKET type.
>4) Set SEQPACKET packet type during send.
>5) Set MSG_EOR in flags for SEQPACKET during send.
>6) 'seqpacket_allow' flag to virtio transport.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v6 -> v7:
> In 'virtio_transport_seqpacket_enqueue()', 'next_tx_msg_id' is updated
> in both cases when message send successfully or error occured.
>
> include/linux/virtio_vsock.h            |  7 ++
> net/vmw_vsock/virtio_transport_common.c | 88 ++++++++++++++++++++++++-
> 2 files changed, 93 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0e3aa395c07c..ab5f56fd7251 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -22,6 +22,7 @@ struct virtio_vsock_seq_state {
> 	u32 user_read_seq_len;
> 	u32 user_read_copied;
> 	u32 curr_rx_msg_id;
>+	u32 next_tx_msg_id;
> };
>
> /* Per-socket state (accessed via vsk->trans) */
>@@ -76,6 +77,8 @@ struct virtio_transport {
>
> 	/* Takes ownership of the packet */
> 	int (*send_pkt)(struct virtio_vsock_pkt *pkt);
>+
>+	bool seqpacket_allow;
> };
>
> ssize_t
>@@ -89,6 +92,10 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       size_t len, int flags);
>
> int
>+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   size_t len);
>+int
> virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 				   struct msghdr *msg,
> 				   int flags,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index bfe0d7026bf8..01a56c7da8bd 100644
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
>@@ -187,7 +189,12 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	struct virtio_vsock_pkt *pkt;
> 	u32 pkt_len = info->pkt_len;
>
>-	info->type = VIRTIO_VSOCK_TYPE_STREAM;
>+	info->type = virtio_transport_get_type(sk_vsock(vsk));
>+
>+	if (info->type == VIRTIO_VSOCK_TYPE_SEQPACKET &&
>+	    info->msg &&
>+	    info->msg->msg_flags & MSG_EOR)
>+		info->flags |= VIRTIO_VSOCK_RW_EOR;
>
> 	t_ops = virtio_transport_get_ops(vsk);
> 	if (unlikely(!t_ops))
>@@ -401,6 +408,43 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static int virtio_transport_seqpacket_send_ctrl(struct vsock_sock *vsk,
>+						int type,
>+						size_t len,
>+						int flags)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct virtio_vsock_pkt_info info = {
>+		.op = type,
>+		.vsk = vsk,
>+		.pkt_len = sizeof(struct virtio_vsock_seq_hdr)
>+	};
>+
>+	struct virtio_vsock_seq_hdr seq_hdr = {
>+		.msg_id = cpu_to_le32(vvs->seq_state.next_tx_msg_id),
>+		.msg_len = cpu_to_le32(len)
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
>+
>+	return virtio_transport_send_pkt_info(vsk, &info);
>+}
>+
> static inline void virtio_transport_remove_pkt(struct virtio_vsock_pkt *pkt)
> {
> 	list_del(&pkt->list);
>@@ -595,6 +639,46 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>
>+int
>+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   size_t len)
>+{
>+	int written = -1;
>+
>+	if (msg->msg_iter.iov_offset == 0) {
>+		/* Send SEQBEGIN. */
>+		if (virtio_transport_seqpacket_send_ctrl(vsk,
>+							 VIRTIO_VSOCK_OP_SEQ_BEGIN,
>+							 len,
>+							 msg->msg_flags) < 0)
>+			goto out;
>+	}
>+
>+	written = virtio_transport_stream_enqueue(vsk, msg, len);
>+
>+	if (written < 0)
>+		goto out;
>+
>+	if (msg->msg_iter.count == 0) {
>+		/* Send SEQEND. */
>+		virtio_transport_seqpacket_send_ctrl(vsk,
>+						     VIRTIO_VSOCK_OP_SEQ_END,
>+						     0,
>+						     msg->msg_flags);

What happen if this fail?

In the previous version we returned -1, now we return the bytes 
transmitted, is that right?

The rest LGTM.

>+	}
>+out:
>+	/* Update next id on error or message transmission done. */
>+	if (written < 0 || msg->msg_iter.count == 0) {
>+		struct virtio_vsock_sock *vvs = vsk->trans;
>+
>+		vvs->seq_state.next_tx_msg_id++;
>+	}
>+
>+	return written;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
>+
> int
> virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
>@@ -1014,7 +1098,7 @@ void virtio_transport_release(struct vsock_sock *vsk)
> 	struct sock *sk = &vsk->sk;
> 	bool remove_sock = true;
>
>-	if (sk->sk_type == SOCK_STREAM)
>+	if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)
> 		remove_sock = virtio_transport_close(vsk);
>
> 	list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
