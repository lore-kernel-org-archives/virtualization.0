Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3056C433C1
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 09:56:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11ADA61A14
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 09:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11ADA61A14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5A7840426;
	Thu, 25 Mar 2021 09:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vy3bE75BoNXI; Thu, 25 Mar 2021 09:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECAB140489;
	Thu, 25 Mar 2021 09:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C97B2C000D;
	Thu, 25 Mar 2021 09:56:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70947C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51B3C8496A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xOL0Z2YpqlW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:56:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48CBA84955
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616666189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f7arxhNAMv3h1evArY7DzFkpDB1UYsISFzJG6a6lx+U=;
 b=DpiCz8WypOgRkV6SCwlHqPOnaVCbAWs8nxw3mvCdm3ikt8ulpvAXe0x/Vj18vLHRlOFCwH
 i2L6WQdxpcaQNSdDphBKLEeUe/+YWkzJLXBIU4phGyyJiszHrOqyzkRwqOzWQ4bshxOh4K
 3FLUBqZqsZaQsPp2SfBX2w16xN8fSjY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-reC1rQnoMfyhBjrBCVD_cw-1; Thu, 25 Mar 2021 05:56:27 -0400
X-MC-Unique: reC1rQnoMfyhBjrBCVD_cw-1
Received: by mail-wm1-f69.google.com with SMTP id f9so1464624wml.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 02:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f7arxhNAMv3h1evArY7DzFkpDB1UYsISFzJG6a6lx+U=;
 b=K3FHbU7OCXdM/YB3K/lCB2dKhAvfQ5SFdU/QPySnWftRdowu1O9/cmskfyZhZkOlUl
 tvxLCTESeQyVYqyA95gGC/DMTr06bFpZh/eKPWLOc+A05TBdTk9rtvNvTfDigm553e+Y
 xQ0NMbG/ZxjCFVjeyAE+MIDaliSdP4WbdjQVYR1uiR+pwBpI9jUDqsnyli4fhPdoBI4i
 F7hZo87uF5MMuvqhhJ52fOD+JX1O2MvFQYQQq+l+aIhgbdZJujbgv6UCEriStNjTJKvV
 8HvQKcq7dfEwU5bQSip85VHwSefnKLp7OPlJAJpV2jxPhvq3RuDHDjetrjPWExUw4pgl
 wZfg==
X-Gm-Message-State: AOAM5325rqghAeUaVPAwsYK+LjyHhG9gUaSN9M543l0WjfPjT9mCKgGm
 SmEQpeZGnwfew0IBfDTCtfenYXqiUZGcklcdpkr8tzCJ0N8s4ak6ox7QdB4JWxMewPC86g/iGeN
 oprctyR2XnLrRR+K6yE4C0JAlJ1fDcYdcqZC715IJyg==
X-Received: by 2002:a05:6000:2c4:: with SMTP id
 o4mr7922910wry.190.1616666186329; 
 Thu, 25 Mar 2021 02:56:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydmBcnoWtoBeDvbwU94unU9ftSHdYZpkK/K7zfA0Ye12bJ+r4Y1kawci9doSExoMjlaMSMiQ==
X-Received: by 2002:a05:6000:2c4:: with SMTP id
 o4mr7922889wry.190.1616666186085; 
 Thu, 25 Mar 2021 02:56:26 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id 81sm5782133wmc.11.2021.03.25.02.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 02:56:25 -0700 (PDT)
Date: Thu, 25 Mar 2021 10:56:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 11/22] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210325095623.q44wr2ymavq7axtv@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131244.2461050-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131244.2461050-1-arseny.krasnov@kaspersky.com>
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

On Tue, Mar 23, 2021 at 04:12:41PM +0300, Arseny Krasnov wrote:
>This adds transport callback and it's logic for SEQPACKET dequeue.
>Callback fetches RW packets from rx queue of socket until whole record
>is copied(if user's buffer is full, user is not woken up). This is done
>to not stall sender, because if we wake up user and it leaves syscall,
>nobody will send credit update for rest of record, and sender will wait
>for next enter of read syscall at receiver's side. So if user buffer is
>full, we just send credit update and drop data. If during copy SEQ_BEGIN
>was found(and not all data was copied), copying is restarted by reset
>user's iov iterator(previous unfinished data is dropped).
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v6 -> v7:
> 1) 'struct virtio_vsock_seqpacket_state' now renamed to
>    'struct virtio_vsock_seq_state'.
> 2) Field 'seqpacket_state' of 'struct virtio_vsock_sock' now
>    renamed to 'seq_state'.
> 3) Current message length to process('user_read_seq_len') is
>    set to 0 on error or message dequeue completed sucecssfully.
>
> include/linux/virtio_vsock.h            |  14 +++
> include/uapi/linux/virtio_vsock.h       |  16 ++++
> net/vmw_vsock/virtio_transport_common.c | 121 ++++++++++++++++++++++++
> 3 files changed, 151 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index dc636b727179..0e3aa395c07c 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -18,6 +18,12 @@ enum {
> 	VSOCK_VQ_MAX    = 3,
> };
>
>+struct virtio_vsock_seq_state {
>+	u32 user_read_seq_len;
>+	u32 user_read_copied;
>+	u32 curr_rx_msg_id;
>+};
>+
> /* Per-socket state (accessed via vsk->trans) */
> struct virtio_vsock_sock {
> 	struct vsock_sock *vsk;
>@@ -36,6 +42,8 @@ struct virtio_vsock_sock {
> 	u32 rx_bytes;
> 	u32 buf_alloc;
> 	struct list_head rx_queue;
>+
>+	struct virtio_vsock_seq_state seq_state;
> };
>
> struct virtio_vsock_pkt {
>@@ -80,6 +88,12 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+int
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   int flags,
>+				   bool *msg_ready,
>+				   size_t *msg_len);
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 1d57ed3d84d2..692f8078cced 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h

Maybe we can move the following changes to this file (that should match 
the virtio-spec discussed in the separate thread) in a separate patch 
with a reference to the spec.

You can include this in the series before this patch.

>@@ -63,8 +63,14 @@ struct virtio_vsock_hdr {
> 	__le32	fwd_cnt;
> } __attribute__((packed));
>
>+struct virtio_vsock_seq_hdr {
>+	__le32  msg_id;
>+	__le32  msg_len;
>+} __attribute__((packed));
>+
> enum virtio_vsock_type {
> 	VIRTIO_VSOCK_TYPE_STREAM = 1,
>+	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
> };
>
> enum virtio_vsock_op {
>@@ -83,6 +89,11 @@ enum virtio_vsock_op {
> 	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
> 	/* Request the peer to send the credit info to us */
> 	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
>+
>+	/* Record begin for SOCK_SEQPACKET */
>+	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
>+	/* Record end for SOCK_SEQPACKET */
>+	VIRTIO_VSOCK_OP_SEQ_END = 9,
> };
>
> /* VIRTIO_VSOCK_OP_SHUTDOWN flags values */
>@@ -91,4 +102,9 @@ enum virtio_vsock_shutdown {
> 	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
> };
>
>+/* VIRTIO_VSOCK_OP_RW flags values */
>+enum virtio_vsock_rw {
>+	VIRTIO_VSOCK_RW_EOR = 1,
>+};
>+
> #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 833104b71a1c..a8f4326e45e8 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -393,6 +393,114 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static inline void virtio_transport_remove_pkt(struct virtio_vsock_pkt *pkt)
>+{
>+	list_del(&pkt->list);
>+	virtio_transport_free_pkt(pkt);
>+}
>+
>+static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>+						 struct msghdr *msg,
>+						 bool *msg_ready)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct virtio_vsock_pkt *pkt;
>+	int err = 0;
>+	size_t user_buf_len = msg->msg_iter.count;
>+
>+	*msg_ready = false;
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	while (!*msg_ready && !list_empty(&vvs->rx_queue) && !err) {
>+		pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+
>+		switch (le16_to_cpu(pkt->hdr.op)) {
>+		case VIRTIO_VSOCK_OP_SEQ_BEGIN: {
>+			/* Unexpected 'SEQ_BEGIN' during record copy:
>+			 * Leave receive loop, 'EAGAIN' will restart it from
>+			 * outer receive loop, packet is still in queue and
>+			 * counters are cleared. So in next loop enter,
>+			 * 'SEQ_BEGIN' will be dequeued first. User's iov
>+			 * iterator will be reset in outer loop. Also
>+			 * send credit update, because some bytes could be
>+			 * copied. User will never see unfinished record.
>+			 */
>+			err = -EAGAIN;
>+			break;
>+		}
>+		case VIRTIO_VSOCK_OP_SEQ_END: {
>+			struct virtio_vsock_seq_hdr *seq_hdr;
>+
>+			seq_hdr = (struct virtio_vsock_seq_hdr *)pkt->buf;
>+			/* First check that whole record is received. */
>+
>+			if (vvs->seq_state.user_read_copied !=
>+			    vvs->seq_state.user_read_seq_len ||
>+			    le32_to_cpu(seq_hdr->msg_id) !=
>+			    vvs->seq_state.curr_rx_msg_id) {
>+				/* Tail of current record and head of 
>next missed,
>+				 * so this EOR is from next record. Restart receive.
>+				 * Current record will be dropped, next headless will
>+				 * be dropped on next attempt to get record length.
>+				 */
>+				err = -EAGAIN;
>+			} else {
>+				/* Success. */
>+				*msg_ready = true;
>+			}
>+
>+			break;
>+		}
>+		case VIRTIO_VSOCK_OP_RW: {
>+			size_t bytes_to_copy;
>+			size_t pkt_len;
>+
>+			pkt_len = (size_t)le32_to_cpu(pkt->hdr.len);
>+			bytes_to_copy = min(user_buf_len, pkt_len);
>+
>+			/* sk_lock is held by caller so no one else can dequeue.
>+			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+			 */
>+			spin_unlock_bh(&vvs->rx_lock);
>+
>+			if (memcpy_to_msg(msg, pkt->buf, bytes_to_copy)) {
>+				spin_lock_bh(&vvs->rx_lock);
>+				err = -EINVAL;
>+				break;
>+			}
>+
>+			spin_lock_bh(&vvs->rx_lock);
>+			user_buf_len -= bytes_to_copy;
>+			vvs->seq_state.user_read_copied += pkt_len;
>+
>+			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_RW_EOR)
>+				msg->msg_flags |= MSG_EOR;
>+			break;
>+		}
>+		default:
>+			;
>+		}
>+
>+		/* For unexpected 'SEQ_BEGIN', keep such packet in queue,
>+		 * but drop any other type of packet.
>+		 */
>+		if (le16_to_cpu(pkt->hdr.op) != VIRTIO_VSOCK_OP_SEQ_BEGIN) {
>+			virtio_transport_dec_rx_pkt(vvs, pkt);
>+			virtio_transport_remove_pkt(pkt);
>+		}
>+	}
>+
>+	/* Reset current record length on error or whole message received. */
>+	if (*msg_ready || err)
>+		vvs->seq_state.user_read_seq_len = 0;
>+
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	virtio_transport_send_credit_update(vsk);
>+
>+	return err;
>+}
>+
> ssize_t
> virtio_transport_stream_dequeue(struct vsock_sock *vsk,
> 				struct msghdr *msg,
>@@ -405,6 +513,19 @@ virtio_transport_stream_dequeue(struct vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_stream_dequeue);
>
>+int
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   int flags, bool *msg_ready,
>+				   size_t *msg_len)
>+{
>+	if (flags & MSG_PEEK)
>+		return -EOPNOTSUPP;
>+

msg_len seems not filled...


>+	return virtio_transport_seqpacket_do_dequeue(vsk, msg, 
>msg_ready);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>+
> int
> virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
