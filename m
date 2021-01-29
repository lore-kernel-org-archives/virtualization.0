Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7F2C433E0
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 10:28:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7200A64DE9
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 10:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7200A64DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA6028748F;
	Fri, 29 Jan 2021 10:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tQs4bCVargXs; Fri, 29 Jan 2021 10:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8A41A87487;
	Fri, 29 Jan 2021 10:28:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7857FC0FA7;
	Fri, 29 Jan 2021 10:28:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E9B9C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 027E386A73
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XBFVnd6K2B8i
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 02C4686A70
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611916105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luWojuwCWV+DTkUpf/C1VVT/bGWPyg3zaVejpkuIWgQ=;
 b=EvGZQS8tIUEBp61fBLgb6gDU4/SET02L+VSVOJp2ZBqN66l/Pc7pW+DmNPeVSRMWEjTFgM
 I0UQMSGiPCFtJUXAeyfAYbtvpmOUaCOM2a/064aqhZJjshU+vEvdgoqox0/xPKOxDGtvVA
 r2BhpwvX3lrMSG3xOmwhWc9jt/1DRYw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Csux6YuROl6oxxszZ6Hs8A-1; Fri, 29 Jan 2021 05:28:23 -0500
X-MC-Unique: Csux6YuROl6oxxszZ6Hs8A-1
Received: by mail-ej1-f71.google.com with SMTP id ar27so2607693ejc.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 02:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=luWojuwCWV+DTkUpf/C1VVT/bGWPyg3zaVejpkuIWgQ=;
 b=Q25HB82YH9GUwas5A88+r/r1xnYcIWibQq98TStJKnBBQYu4FYvQ/pvF5XDQRZqBWo
 ZxrAjZ3UhMoYMY7dChgZfUyezZvl/K6stt2qBTYSRvEADqfYKOiFE4x6WBqhu/CGGkKk
 i47hYa4wMxe2MgM33sMTTBYUDlgnqvnSWRERQuJcOpdnzthv+wQShaK0aPYQajriRYZ3
 pbl6ak/eI6hkuWOZiwprLruas21SeUxnITNCG1xDQvHuk28DLqnkQygBswwH0HkkNl2R
 02aqxmT5p8rtpuPVOoWit695Ee1RHQcCIdSmclT7awhrQ2wK40hxxI/eQQDCazyBdLEW
 ljAw==
X-Gm-Message-State: AOAM532c202fDUosMkIA4OqwUCsT1HVwTP8HF6sRHLUAi9xOUNcDtkkj
 g6Q4y0nElVFySLoHumRMtrI2KYYq7BW9dHRJ6hMMSccP9PmuilUxgFlR3EFWG8VKqhFfhs0mUrS
 C1/Jkrz+MwMcVFuPNAr8bDRgfswXUs4h+OHtR+TTO6w==
X-Received: by 2002:a17:906:a153:: with SMTP id
 bu19mr3917884ejb.287.1611916101885; 
 Fri, 29 Jan 2021 02:28:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNs3C/JN3Gdp/OQ+4ec29f597FcNscNaB4CuarhSvE5gQhe9GBvXSXvOIQsRHFOgvwEXm9NQ==
X-Received: by 2002:a17:906:a153:: with SMTP id
 bu19mr3917859ejb.287.1611916101666; 
 Fri, 29 Jan 2021 02:28:21 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id u16sm3576755ejn.117.2021.01.29.02.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 02:28:21 -0800 (PST)
Date: Fri, 29 Jan 2021 11:28:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 07/13] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210129102818.7qckiox66dtzxdzc@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111402.598929-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210125111402.598929-1-arseny.krasnov@kaspersky.com>
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

On Mon, Jan 25, 2021 at 02:13:59PM +0300, Arseny Krasnov wrote:
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

I'm not sure if it is better to specify flags about an operation 
regardless of type, but if you want to make that distinction, maybe then 
the flag needs to contain some reference, e.g 
VIRTIO_VSOCK_RW_SEQPACKET_EOR, otherwise you can rename this enumeration 
to 'virtio_vsock_rw', and will contain all flags for RW operation 
regardless of type.

>+	VIRTIO_VSOCK_RW_EOR = 1,
>+};
>+

Maybe these changes in include/uapi/linux/virtio_vsock.h could go in 
another patch where we add the new protocol stuff to implement the 
SEQPACKET support.

> #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 5956939eebb7..e66ec39445ff 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -397,6 +397,132 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static inline void virtio_transport_del_n_free_pkt(struct 

This function name is a bit cryptic, what about something like
virtio_transport_remove_pkt() ?

>virtio_vsock_pkt *pkt)
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

Single line for those conditions?

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

These initializations are not necessary, since we use kzalloc to 
allocate 'vvs'.

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
