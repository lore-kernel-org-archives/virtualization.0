Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951DEC433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:14:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3588C206D8
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3588C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC5C9866F6;
	Mon, 18 Jan 2021 15:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A0AveMpoCp5q; Mon, 18 Jan 2021 15:14:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37E0B86483;
	Mon, 18 Jan 2021 15:14:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2284AC08A1;
	Mon, 18 Jan 2021 15:14:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1410C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE91C866AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zhpSi-6LThd3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:14:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AA16986483
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610982883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7DwJ38re0ujAkamx3nky8dDI0/xuXUfSzX99uwavtQk=;
 b=EckqnOYIop5nbyobj+9nHGm2cBR+eQymT9zL2IPoJYSkxNsX1rGFEexLse9zNtaY7JgSty
 5+pkZy+7sEL4wa2WiDgtC5n8d0DHGogRHon++vD5XrTzWZUvJlpiB/ubI8k7lTmcfv3qqd
 pTXeqBmfB3VsEe7EtFDSFI3Njx6Jw6c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-e9BO7KMkO5mLnlIvcsT49A-1; Mon, 18 Jan 2021 10:14:41 -0500
X-MC-Unique: e9BO7KMkO5mLnlIvcsT49A-1
Received: by mail-wm1-f70.google.com with SMTP id u67so58512wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 07:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7DwJ38re0ujAkamx3nky8dDI0/xuXUfSzX99uwavtQk=;
 b=klfE5NOY4AXcqATWNvnYZj6PA91BjQnZrz9CGDcjV/zL7RQmsXNAdeZVGM9vXAxeey
 STDR+ZxCBnAMkAxSQN1Ygz0K8eBLjtsSWN2wTj0OwAXbyvykDfOyjMe1jUiYNiF1K8oV
 TNzNqBSuroV2TRdWj6CeQmRT9G+lYerluieM1awxv5OfcNnoPg1JdvtjXstaLomPT6Fy
 mI5DHkwI5ECS1/lMt0mBqQ8mhLioIWrlp/5tJdaEz6z2hf9PvoIY5YlBWGXSGxG0+fij
 5bNL7+L5s5VSnpeUhigKl1VfWCyg3OuxH5sKWIt/n2Bnd1AVYYsuCZ23U4boF042ae1a
 Omog==
X-Gm-Message-State: AOAM533hwZmer7HUMT8mUkG7/fuOxWOgy2A3BGio8NqoDGSM2/VNobkH
 /250sD8dLqfWeWGD2AeT1/1xDbXMeBpE+WapU/NF4wxX8pwT2xP5WcKbETwjaxEJUlBfKLZiPWr
 1XnxTg5mzLIhWqKdWovtxOzBjx4eMylM9ylpEz37dMA==
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr2780614wml.16.1610982880222; 
 Mon, 18 Jan 2021 07:14:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKV84kFbL5zwaCWGOvkUHhAjSms+iwAnzbYH9GFcAF16ElsVs0Qor3D4uoA5S7uN2CA62ZcQ==
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr2780582wml.16.1610982879993; 
 Mon, 18 Jan 2021 07:14:39 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s4sm24493309wme.38.2021.01.18.07.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 07:14:39 -0800 (PST)
Date: Mon, 18 Jan 2021 16:14:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 08/13] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET.
Message-ID: <20210118151436.klgddfmaefch4no5@steredhat>
References: <20210115053553.1454517-1-arseny.krasnov@kaspersky.com>
 <20210115054327.1456645-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210115054327.1456645-1-arseny.krasnov@kaspersky.com>
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
 Jakub Kicinski <kuba@kernel.org>, Colin Ian King <colin.king@canonical.com>,
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

On Fri, Jan 15, 2021 at 08:43:24AM +0300, Arseny Krasnov wrote:
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
> include/linux/virtio_vsock.h            |   4 +
> include/uapi/linux/virtio_vsock.h       |   9 ++
> net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++++++++++++
> 3 files changed, 141 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index dc636b727179..7f0ef5204e33 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -36,6 +36,10 @@ struct virtio_vsock_sock {
> 	u32 rx_bytes;
> 	u32 buf_alloc;
> 	struct list_head rx_queue;
>+
>+	/* For SOCK_SEQPACKET */
>+	u32 user_read_seq_len;
>+	u32 user_read_copied;
> };
>
> struct virtio_vsock_pkt {
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 1d57ed3d84d2..058908bc19fc 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -65,6 +65,7 @@ struct virtio_vsock_hdr {
>
> enum virtio_vsock_type {
> 	VIRTIO_VSOCK_TYPE_STREAM = 1,
>+	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
> };
>
> enum virtio_vsock_op {
>@@ -83,6 +84,9 @@ enum virtio_vsock_op {
> 	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
> 	/* Request the peer to send the credit info to us */
> 	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
>+
>+	/* Record begin for SOCK_SEQPACKET */
>+	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
> };
>
> /* VIRTIO_VSOCK_OP_SHUTDOWN flags values */
>@@ -91,4 +95,9 @@ enum virtio_vsock_shutdown {
> 	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
> };
>
>+/* VIRTIO_VSOCK_OP_RW flags values for SOCK_SEQPACKET type */
>+enum virtio_vsock_rw_seqpacket {
>+	VIRTIO_VSOCK_RW_EOR = 1,
>+};
>+
> #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 5956939eebb7..4328f653a477 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -397,6 +397,132 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static inline void virtio_transport_del_n_free_pkt(struct virtio_vsock_pkt *pkt)
>+{
>+	list_del(&pkt->list);
>+	virtio_transport_free_pkt(pkt);
>+}
>+
>+static size_t virtio_transport_drop_until_seq_begin(struct virtio_vsock_sock *vvs)
>+{
>+	struct virtio_vsock_pkt *pkt, *n;
>+	size_t bytes_dropped = 0;
>+
>+	list_for_each_entry_safe(pkt, n, &vvs->rx_queue, list) {
>+		if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_SEQ_BEGIN)
>+			break;
>+
>+		bytes_dropped += le32_to_cpu(pkt->hdr.len);
>+		virtio_transport_dec_rx_pkt(vvs, pkt);
>+		virtio_transport_del_n_free_pkt(pkt);
>+	}
>+
>+	return bytes_dropped;
>+}
>+
>+static ssize_t virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>+						     struct msghdr *msg,
>+						     size_t user_buf_len)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct virtio_vsock_pkt *pkt;
>+	size_t bytes_handled = 0;
>+	int err = 0;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	if (user_buf_len == 0) {
>+		/* User's buffer is full, we processing rest of
>+		 * record and drop it. If 'SEQ_BEGIN' is found
>+		 * while iterating, user will be woken up,
>+		 * because record is already copied, and we
>+		 * don't care about absent of some tail RW packets
>+		 * of it. Return number of bytes(rest of record),
>+		 * but ignore credit update for such absent bytes.
>+		 */
>+		bytes_handled = virtio_transport_drop_until_seq_begin(vvs);
>+		vvs->user_read_copied += bytes_handled;
>+
>+		if (!list_empty(&vvs->rx_queue) &&
>+		    vvs->user_read_copied < vvs->user_read_seq_len) {
>+			/* 'SEQ_BEGIN' found, but record isn't complete.
>+			 * Set number of copied bytes to fit record size
>+			 * and force counters to finish receiving.
>+			 */
>+			bytes_handled += (vvs->user_read_seq_len - vvs->user_read_copied);
>+			vvs->user_read_copied = vvs->user_read_seq_len;
>+		}
>+	}
>+
>+	/* Now start copying. */
>+	while (vvs->user_read_copied < vvs->user_read_seq_len &&
>+	       vvs->rx_bytes &&
>+	       user_buf_len &&
>+	       !err) {
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
>+			bytes_handled += pkt->len;
>+			vvs->user_read_copied += bytes_to_copy;
>+
>+			if (le16_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_RW_EOR)
                             ^
hdr.flags is __le32, so please use le32_to_cpu()

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
>+			virtio_transport_del_n_free_pkt(pkt);
>+		}
>+	}
>+
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_SEQPACKET,
>+					    NULL);
>+
>+	return err ?: bytes_handled;
>+}
>+
> ssize_t
> virtio_transport_stream_dequeue(struct vsock_sock *vsk,
> 				struct msghdr *msg,
>@@ -481,6 +607,8 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
> 	spin_lock_init(&vvs->rx_lock);
> 	spin_lock_init(&vvs->tx_lock);
> 	INIT_LIST_HEAD(&vvs->rx_queue);
>+	vvs->user_read_copied = 0;
>+	vvs->user_read_seq_len = 0;
>
> 	return 0;
> }
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
