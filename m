Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FB7C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 14:03:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F3A64E8A
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 14:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F3A64E8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E92C186E50;
	Thu, 11 Feb 2021 14:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bYsmWd5LoHmu; Thu, 11 Feb 2021 14:03:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9687286E44;
	Thu, 11 Feb 2021 14:03:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AE58C0891;
	Thu, 11 Feb 2021 14:03:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E7A4C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7CF2386E40
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OwwDb5kINbLz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 39E2E86E44
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613052215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=18myQGQLnK7BH7Rw5XJwML6ZVL0hP7cTmzt6Wmuy4xU=;
 b=QQIREVLQJEU0svvM0HfdRWLxHlHB6zL0TAmL9dQNeBpuqxiSzcfI+2CZxYzslTYRJkeuL6
 S5tnFH/6iUpYc+WlfuRmeZc7lleP9YlJ1grWNPwd11407kea8h2pMxNnjramMFwxVFCRaM
 6u33hM4QFbYf3zB8ZOtfc3BG0bkVfSE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-ZtvLaHs2Ny6T3TL2EqecOw-1; Thu, 11 Feb 2021 09:03:33 -0500
X-MC-Unique: ZtvLaHs2Ny6T3TL2EqecOw-1
Received: by mail-ej1-f70.google.com with SMTP id hx26so4765910ejc.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 06:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=18myQGQLnK7BH7Rw5XJwML6ZVL0hP7cTmzt6Wmuy4xU=;
 b=iKhQFkF7Pw89noZlP5jeYWsWpUHolkAggKNZ3UZ6+CmXtYSAsoGniZsaAtBIvJ9hnO
 n8FGL3Ij3ehAPVhiTYiLCTdN5y45QWMMmZh6FADMUcxKUV98E8D1ZW0M1f9wVu11tGhh
 DA78BIEMSDPhhTcEq6TzZfvaNv++XrYPuAOKJEtOKEB2jZtsTdEVVbFOZW5ik+drJY5P
 6lEQFF4qfE99Evutwimy9q7hNtu3djAJLTVth1wMpzx26ZsjJUx+S/SlS/Bj4CJGvXmS
 7U2NxMs3iFov6t8IMvNhoereoijFlNW3q8KsohZvYDFWinKFUxRPCBy+FIc0pgKtJTjP
 MmRQ==
X-Gm-Message-State: AOAM533f7Gn1a012N+SumC6HIKNoNYoMxUfFYpb0plhBR7Ppr1g+wH/T
 WsqWc3t6LIDjsU9YkuOVSJssWohF2zhiMipk8wt5JyTdChM1TxurRbC5PNpaAUeq9BEgR39oli/
 u802El3vvhCMyy1JW2a5GAV1NQQYZty5PiacBEe/9SA==
X-Received: by 2002:a17:906:aec6:: with SMTP id
 me6mr8516283ejb.163.1613052211096; 
 Thu, 11 Feb 2021 06:03:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBiH9SvgCAiqbC2qOJb6Mrpwjew9mxmT6XitiTd8tQdiVlLxB2zcepRrlBr2ebP9Qsdf3+wQ==
X-Received: by 2002:a17:906:aec6:: with SMTP id
 me6mr8516178ejb.163.1613052203085; 
 Thu, 11 Feb 2021 06:03:23 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id i4sm4440606eje.90.2021.02.11.06.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 06:03:21 -0800 (PST)
Date: Thu, 11 Feb 2021 15:03:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 09/17] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210211140319.ptqgrj5nvjn4snc7@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151649.805359-1-arseny.krasnov@kaspersky.com>
 <20210211135428.k6cncu3m7ee4odhl@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210211135428.k6cncu3m7ee4odhl@steredhat>
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

On Thu, Feb 11, 2021 at 02:54:28PM +0100, Stefano Garzarella wrote:
>On Sun, Feb 07, 2021 at 06:16:46PM +0300, Arseny Krasnov wrote:
>>This adds transport callback and it's logic for SEQPACKET dequeue.
>>Callback fetches RW packets from rx queue of socket until whole record
>>is copied(if user's buffer is full, user is not woken up). This is done
>>to not stall sender, because if we wake up user and it leaves syscall,
>>nobody will send credit update for rest of record, and sender will wait
>>for next enter of read syscall at receiver's side. So if user buffer is
>>full, we just send credit update and drop data. If during copy SEQ_BEGIN
>>was found(and not all data was copied), copying is restarted by reset
>>user's iov iterator(previous unfinished data is dropped).
>>
>>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>---
>>include/linux/virtio_vsock.h            |   5 +
>>include/uapi/linux/virtio_vsock.h       |  16 ++++
>>net/vmw_vsock/virtio_transport_common.c | 120 ++++++++++++++++++++++++
>>3 files changed, 141 insertions(+)
>>
>>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>>index dc636b727179..4d0de3dee9a4 100644
>>--- a/include/linux/virtio_vsock.h
>>+++ b/include/linux/virtio_vsock.h
>>@@ -36,6 +36,11 @@ struct virtio_vsock_sock {
>>	u32 rx_bytes;
>>	u32 buf_alloc;
>>	struct list_head rx_queue;
>>+
>>+	/* For SOCK_SEQPACKET */
>>+	u32 user_read_seq_len;
>>+	u32 user_read_copied;
>>+	u32 curr_rx_msg_cnt;
>>};
>>
>>struct virtio_vsock_pkt {
>>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>>index 1d57ed3d84d2..cf9c165e5cca 100644
>>--- a/include/uapi/linux/virtio_vsock.h
>>+++ b/include/uapi/linux/virtio_vsock.h
>>@@ -63,8 +63,14 @@ struct virtio_vsock_hdr {
>>	__le32	fwd_cnt;
>>} __attribute__((packed));
>>
>>+struct virtio_vsock_seq_hdr {
>>+	__le32  msg_cnt;

Maybe it's better 'msg_id' for this field, since we use it to identify a 
message. Then whether we use a counter or a random number, I think it's 
just an implementation detail.

As Michael said, perhaps this detail should be discussed in the proposal 
for VIRTIO spec changes.

>>+	__le32  msg_len;
>>+} __attribute__((packed));
>>+
>>enum virtio_vsock_type {
>>	VIRTIO_VSOCK_TYPE_STREAM = 1,
>>+	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
>>};
>>
>>enum virtio_vsock_op {
>>@@ -83,6 +89,11 @@ enum virtio_vsock_op {
>>	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
>>	/* Request the peer to send the credit info to us */
>>	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
>>+
>>+	/* Record begin for SOCK_SEQPACKET */
>>+	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
>>+	/* Record end for SOCK_SEQPACKET */
>>+	VIRTIO_VSOCK_OP_SEQ_END = 9,
>>};
>>
>>/* VIRTIO_VSOCK_OP_SHUTDOWN flags values */
>>@@ -91,4 +102,9 @@ enum virtio_vsock_shutdown {
>>	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
>>};
>>
>>+/* VIRTIO_VSOCK_OP_RW flags values */
>>+enum virtio_vsock_rw {
>>+	VIRTIO_VSOCK_RW_EOR = 1,
>>+};
>>+
>>#endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
>>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>index 5956939eebb7..4572d01c8ea5 100644
>>--- a/net/vmw_vsock/virtio_transport_common.c
>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>@@ -397,6 +397,126 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>	return err;
>>}
>>
>>+static inline void virtio_transport_remove_pkt(struct virtio_vsock_pkt *pkt)
>>+{
>>+	list_del(&pkt->list);
>>+	virtio_transport_free_pkt(pkt);
>>+}
>>+
>>+static size_t virtio_transport_drop_until_seq_begin(struct virtio_vsock_sock *vvs)
>>+{
>
>This function is not used here, but in the next patch, so I'd add this 
>with the next patch.
>
>>+	struct virtio_vsock_pkt *pkt, *n;
>>+	size_t bytes_dropped = 0;
>>+
>>+	list_for_each_entry_safe(pkt, n, &vvs->rx_queue, list) {
>>+		if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_SEQ_BEGIN)
>>+			break;
>>+
>>+		bytes_dropped += le32_to_cpu(pkt->hdr.len);
>>+		virtio_transport_dec_rx_pkt(vvs, pkt);
>>+		virtio_transport_remove_pkt(pkt);
>>+	}
>>+
>>+	return bytes_dropped;
>>+}
>>+
>>+static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>>+						 struct msghdr *msg,
>>+						 bool *msg_ready)
>>+{
>
>Also this function is not used, maybe you can add in this patch the 
>virtio_transport_seqpacket_dequeue() implementation.
>
>>+	struct virtio_vsock_sock *vvs = vsk->trans;
>>+	struct virtio_vsock_pkt *pkt;
>>+	int err = 0;
>>+	size_t user_buf_len = msg->msg_iter.count;
>>+
>>+	*msg_ready = false;
>>+	spin_lock_bh(&vvs->rx_lock);
>>+
>>+	while (!*msg_ready && !list_empty(&vvs->rx_queue) && !err) {
>>+		pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>>+
>>+		switch (le16_to_cpu(pkt->hdr.op)) {
>>+		case VIRTIO_VSOCK_OP_SEQ_BEGIN: {
>>+			/* Unexpected 'SEQ_BEGIN' during record copy:
>>+			 * Leave receive loop, 'EAGAIN' will restart it from
>>+			 * outer receive loop, packet is still in queue and
>>+			 * counters are cleared. So in next loop enter,
>>+			 * 'SEQ_BEGIN' will be dequeued first. User's iov
>>+			 * iterator will be reset in outer loop. Also
>>+			 * send credit update, because some bytes could be
>>+			 * copied. User will never see unfinished record.
>>+			 */
>>+			err = -EAGAIN;
>>+			break;
>>+		}
>>+		case VIRTIO_VSOCK_OP_SEQ_END: {
>>+			struct virtio_vsock_seq_hdr *seq_hdr;
>>+
>>+			seq_hdr = (struct virtio_vsock_seq_hdr *)pkt->buf;
>>+			/* First check that whole record is received. */
>>+
>>+			if (vvs->user_read_copied != vvs->user_read_seq_len ||
>>+			    (le32_to_cpu(seq_hdr->msg_cnt) - vvs->curr_rx_msg_cnt) != 1) {
>>+				/* Tail of current record and head of next missed,
>>+				 * so this EOR is from next record. Restart receive.
>>+				 * Current record will be dropped, next headless will
>>+				 * be dropped on next attempt to get record length.
>>+				 */
>>+				err = -EAGAIN;
>>+			} else {
>>+				/* Success. */
>>+				*msg_ready = true;
>>+			}
>>+
>>+			break;
>>+		}
>>+		case VIRTIO_VSOCK_OP_RW: {
>>+			size_t bytes_to_copy;
>>+			size_t pkt_len;
>>+
>>+			pkt_len = (size_t)le32_to_cpu(pkt->hdr.len);
>>+			bytes_to_copy = min(user_buf_len, pkt_len);
>>+
>>+			/* sk_lock is held by caller so no one else can dequeue.
>>+			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>>+			 */
>>+			spin_unlock_bh(&vvs->rx_lock);
>>+
>>+			if (memcpy_to_msg(msg, pkt->buf, bytes_to_copy)) {
>>+				spin_lock_bh(&vvs->rx_lock);
>>+				err = -EINVAL;
>>+				break;
>>+			}
>>+
>>+			spin_lock_bh(&vvs->rx_lock);
>>+			user_buf_len -= bytes_to_copy;
>>+			vvs->user_read_copied += pkt_len;
>>+
>>+			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_RW_EOR)
>>+				msg->msg_flags |= MSG_EOR;
>>+			break;
>>+		}
>>+		default:
>>+			;
>>+		}
>>+
>>+		/* For unexpected 'SEQ_BEGIN', keep such packet in queue,
>>+		 * but drop any other type of packet.
>>+		 */
>>+		if (le16_to_cpu(pkt->hdr.op) != VIRTIO_VSOCK_OP_SEQ_BEGIN) {
>>+			virtio_transport_dec_rx_pkt(vvs, pkt);
>>+			virtio_transport_remove_pkt(pkt);
>>+		}
>>+	}
>>+
>>+	spin_unlock_bh(&vvs->rx_lock);
>>+
>>+	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_SEQPACKET,
>>+					    NULL);
>>+
>>+	return err;
>>+}
>>+
>>ssize_t
>>virtio_transport_stream_dequeue(struct vsock_sock *vsk,
>>				struct msghdr *msg,
>>-- 
>>2.25.1
>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
