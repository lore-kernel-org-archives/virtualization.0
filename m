Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D2EC433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 11:25:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0F164E61
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 11:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0F164E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49C336F4E4;
	Mon, 15 Mar 2021 11:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e672BIhirTOw; Mon, 15 Mar 2021 11:25:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE34B6F488;
	Mon, 15 Mar 2021 11:25:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D371C000A;
	Mon, 15 Mar 2021 11:25:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDA5EC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA3AB4B398
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B8UE6oMFufvY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 929C34AAEE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615807522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EDcN82trASDnIA4Psf1sFMT849eJlpI4rz5LIx/ZPbc=;
 b=DnGpBcObSosUbNV/O9qh6cJyrnMxnrKDKZk7GbyKmLPrWJ5QfpwrddoZsdQ8MoFvidyrxI
 fXLzA7qf2F9KVkWIqlXoC69LE/8+Uiwu/X/2HN6Q5aCl0h8/fOVwcpMlZt56mViQ94/I0B
 kZUxL+y9Y6583xxvqRy1+TOLlGkAONs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-RtRO0toeNeOHtkLpip1aig-1; Mon, 15 Mar 2021 07:25:20 -0400
X-MC-Unique: RtRO0toeNeOHtkLpip1aig-1
Received: by mail-wm1-f70.google.com with SMTP id a68so2074628wme.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 04:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EDcN82trASDnIA4Psf1sFMT849eJlpI4rz5LIx/ZPbc=;
 b=JutsFHK+vgIHQMu8hym3JQUOXXBw44uaxd6x4XYDZR9IlDYWxhN9cx0V6CfzL1+ZSo
 Q3F+c50zEuDuXfXo+bwmPzCiylFQBOt4P0rhxt4kE1KUZWQFNk7AMtaVhhsfwv/EEcUP
 qF39v2q2/XyVEETSWD7DaOD385+ZKnKdU706SVVazRaqosDLBtnXmJXFXemgN34SL9sq
 uWzLuJWpoQbARunvZbz77EdbJPSkQ6340zW+Hwuz01hFLUWSf4IYzlsC9xadEdcleDf6
 Exf4vSH4Tnl8mGdrU4d7QrTJkndf4qQip+sgxWN38K37VB7MU0qWJPQ/vYbW22+0Ux6s
 Tklg==
X-Gm-Message-State: AOAM533fcCJDKOrohfUPucEQxOMMQaE90OrDpO+oCiz9jMawYlLnpeuQ
 mIWNrhJG45rpHa/VIrMHU2EHE7XDan1bIzEuVXd8NTkUmWoE9ZL69rccriCA0nSCH6oQ/dtN7Gq
 6VmDK1paK9WlgcVAeZxM9Rfaqdx5gHFNc0MXgfmW9zg==
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr26147136wrs.208.1615807519056; 
 Mon, 15 Mar 2021 04:25:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL+19i7o4WzIiaFHRonxgDt5TkAS6qK3oH8aOOuycb9DLxzp3yCNty1apS15aHGkiLlIToxQ==
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr26147121wrs.208.1615807518885; 
 Mon, 15 Mar 2021 04:25:18 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id f22sm11933706wmb.31.2021.03.15.04.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 04:25:18 -0700 (PDT)
Date: Mon, 15 Mar 2021 12:25:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 14/22] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <20210315112516.wa5yos6cbukcv3ww@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180312.3466235-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307180312.3466235-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Sun, Mar 07, 2021 at 09:03:09PM +0300, Arseny Krasnov wrote:
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
> include/linux/virtio_vsock.h            |  8 +++
> net/vmw_vsock/virtio_transport_common.c | 87 ++++++++++++++++++++++++-
> 2 files changed, 93 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index d7edcfeb4cd2..6b45a8b98226 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -22,6 +22,7 @@ struct virtio_vsock_seqpack_state {
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
>@@ -90,6 +93,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>
> size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk);
> int
>+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   int flags,
>+				   size_t len);
>+int
> virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 				   struct msghdr *msg,
> 				   int flags,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 9d86375935ce..8e9fdd8aba5d 100644
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
>+		.msg_id = cpu_to_le32(vvs->seqpacket_state.next_tx_msg_id),
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
>@@ -582,6 +626,45 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>
>+int
>+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   int flags,
>+				   size_t len)
>+{
>+	int written;
>+
>+	if (msg->msg_iter.iov_offset == 0) {
>+		/* Send SEQBEGIN. */
>+		if (virtio_transport_seqpacket_send_ctrl(vsk,
>+							 VIRTIO_VSOCK_OP_SEQ_BEGIN,
>+							 len,
>+							 flags) < 0)
>+			return -1;
>+	}
>+
>+	written = virtio_transport_stream_enqueue(vsk, msg, len);
>+
>+	if (written < 0)
>+		return -1;
>+
>+	if (msg->msg_iter.count == 0) {
>+		struct virtio_vsock_sock *vvs = vsk->trans;
>+
>+		/* Send SEQEND. */
>+		if (virtio_transport_seqpacket_send_ctrl(vsk,
>+							 VIRTIO_VSOCK_OP_SEQ_END,
>+							 0,
>+							 flags) < 0)
>+			return -1;
>+
>+		vvs->seqpacket_state.next_tx_msg_id++;
>+	}

I suspect we should increment next_tx_msg_id even in case of an error to 
avoid issues with packets with same IDs, so in case of error I would do:

	if (/* error */) {
		written = -1;
		goto out;
	}

Then we can add the 'out' label and the id increment:

out:
	vvs->seqpacket_state.next_tx_msg_id++;
>+
>+	return written;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
>+
> int
> virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
>@@ -1001,7 +1084,7 @@ void virtio_transport_release(struct vsock_sock *vsk)
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
