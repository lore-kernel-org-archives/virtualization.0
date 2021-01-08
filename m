Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F6FC433DB
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 10:19:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04AE5236FB
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 10:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AE5236FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7D8FD875AB;
	Fri,  8 Jan 2021 10:19:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7KKwNGdOXerN; Fri,  8 Jan 2021 10:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C80AF87590;
	Fri,  8 Jan 2021 10:19:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACE3EC0891;
	Fri,  8 Jan 2021 10:19:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36D94C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3296386EB5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b6eS0dPpzGYM
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:19:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 695068680D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610101184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=da1aOUiZ2OMou338T6jClChVyBHKa5Flbr7R6mhCNk8=;
 b=guGNuIXQV0McDRbQdczNj1M0jTkvKX0sIeE0afhH68JjZHfMnO1+he3RUlSlUiTuIrRs0z
 XJ3VvctEu4iwlUEMLWlVsIlgSRyptKJT8dfIGqF/ZIYxjXd3besqBP1VOojdrOY/fguC1T
 Yx8GkezD+ZYGsHevO0S1/8s/Gy12BpE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-aGf64LnGOVm7k9FO0PYpJw-1; Fri, 08 Jan 2021 05:19:42 -0500
X-MC-Unique: aGf64LnGOVm7k9FO0PYpJw-1
Received: by mail-wr1-f71.google.com with SMTP id e12so3953522wrp.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 08 Jan 2021 02:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=da1aOUiZ2OMou338T6jClChVyBHKa5Flbr7R6mhCNk8=;
 b=AXHIWL1KRxclZQgRFL7/RLf85y+Jq1/Rz7gAxj5EL8SnaQ4uNGixRb8MqUSW7XcGpm
 1eW5GHuErRJYYBo3OKYawfEyKcYRy40DqDMGfDXjADMZxjvuq7zopkxM0icojDXIDPec
 8AkboOhIbMANDZ2246gqxTCgusu+j2jH/wfMUpowOYfQPWG4zxnY0i8x4HmyRq8ezbvP
 VJByw765XUJexVbNkmUteAG8OXyhG7PhW1hasVh/tsXyWrU3FgyUJeYnwfn8EGPNucxJ
 kLWJigbJIOw0qp6M2EGZmYOdA3cYNeLUaHR6Y8ewy2YMXPnTeCuoesQTYfTCXyINJOMS
 9OUw==
X-Gm-Message-State: AOAM5320J6susxn/rTwhAIx2S4DQjlteAPyd9pf0Yxav96IYT7rXO8AH
 GaT45IzQxXfYNvzZnmM8Vo02vSKqlf+/WqsuLG7IyIZjL37Mc/y0sAqwxoEm+TVzI3wVI1qpreM
 gTDfdY1V3bqhnG1CiHcY928CEiS/92qNaqj8new849A==
X-Received: by 2002:a05:600c:2188:: with SMTP id
 e8mr2422823wme.182.1610101180746; 
 Fri, 08 Jan 2021 02:19:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfp+uO1U5q2uOEFcljxd+qp5wSMGgI5lrGkhfcFhhY8MPnlF00vKcSdnirrxMcw3QHqevaHA==
X-Received: by 2002:a05:600c:2188:: with SMTP id
 e8mr2422798wme.182.1610101180434; 
 Fri, 08 Jan 2021 02:19:40 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o7sm12046729wrw.62.2021.01.08.02.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 02:19:39 -0800 (PST)
Date: Fri, 8 Jan 2021 11:19:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH 1/5] vsock/virtio: support for SOCK_SEQPACKET socket.
Message-ID: <20210108101932.qwhphbunsa5sfl42@steredhat>
References: <20210103195454.1954169-1-arseny.krasnov@kaspersky.com>
 <20210103195752.1954958-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210103195752.1954958-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arseniy Krasnov <oxffffaa@gmail.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Andra Paraschiv <andraprs@amazon.com>
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

On Sun, Jan 03, 2021 at 10:57:50PM +0300, Arseny Krasnov wrote:
>	This extends rx loop for SOCK_SEQPACKET packets and implements
>callback which user calls to copy data to its buffer.

Please write a better commit message explaining the changes, e.g. that 
you are using 'flags' to transport lengths when 'op' ==
VIRTIO_VSOCK_OP_SEQ_BEGIN.

>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/linux/virtio_vsock.h            |   7 +
> include/net/af_vsock.h                  |   4 +
> include/uapi/linux/virtio_vsock.h       |   9 +
> net/vmw_vsock/virtio_transport.c        |   3 +
> net/vmw_vsock/virtio_transport_common.c | 323 +++++++++++++++++++++---
> 5 files changed, 305 insertions(+), 41 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index dc636b727179..4902d71b3252 100644
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
>@@ -80,6 +84,9 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+bool virtio_transport_seqpacket_seq_send_len(struct vsock_sock *vsk, size_t len);
>+size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk);
>+
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index b1c717286993..792ea7b66574 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -135,6 +135,10 @@ struct vsock_transport {
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>
>+	/* SEQ_PACKET. */
>+	bool (*seqpacket_seq_send_len)(struct vsock_sock *, size_t len);
>+	size_t (*seqpacket_seq_get_len)(struct vsock_sock *);
>+

These changes are related to the vsock core, so please move to another 
patch.

> 	/* Notification. */
> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
> 	int (*notify_poll_out)(struct vsock_sock *, size_t, bool *);
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
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..2bd3f7cbffcb 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -469,6 +469,9 @@ static struct virtio_transport virtio_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_seq_send_len	  = virtio_transport_seqpacket_seq_send_len,
>+		.seqpacket_seq_get_len	  = virtio_transport_seqpacket_seq_get_len,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 5956939eebb7..77c42004e422 100644
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
>+		return;
>+
> 	if (pkt->tap_delivered)
> 		return;
>
>@@ -230,10 +235,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> }
>
> static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
>-					struct virtio_vsock_pkt *pkt)
>+					u32 len)
> {
>-	vvs->rx_bytes -= pkt->len;
>-	vvs->fwd_cnt += pkt->len;
>+	vvs->rx_bytes -= len;
>+	vvs->fwd_cnt += len;
> }
>
> void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
>@@ -365,7 +370,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 		total += bytes;
> 		pkt->off += bytes;
> 		if (pkt->off == pkt->len) {
>-			virtio_transport_dec_rx_pkt(vvs, pkt);
>+			virtio_transport_dec_rx_pkt(vvs, pkt->len);
> 			list_del(&pkt->list);
> 			virtio_transport_free_pkt(pkt);
> 		}
>@@ -397,15 +402,202 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static u16 virtio_transport_get_type(struct sock *sk)
>+{
>+	if (sk->sk_type == SOCK_STREAM)
>+		return VIRTIO_VSOCK_TYPE_STREAM;
>+	else
>+		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>+}
>+
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
>+		virtio_transport_dec_rx_pkt(vvs, pkt->len);
>+		virtio_transport_del_n_free_pkt(pkt);
>+	}
>+
>+	return bytes_dropped;
>+}
>+
>+size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct virtio_vsock_pkt *pkt;
>+	size_t bytes_dropped;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* Fetch all orphaned 'RW', packets, and
>+	 * send credit update.
>+	 */
>+	bytes_dropped = virtio_transport_drop_until_seq_begin(vvs);
>+
>+	if (list_empty(&vvs->rx_queue))
>+		goto out;
>+
>+	pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+
>+	vvs->user_read_copied = 0;
>+	vvs->user_read_seq_len = le32_to_cpu(pkt->hdr.flags);
>+	virtio_transport_del_n_free_pkt(pkt);
>+out:
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	if (bytes_dropped)
>+		virtio_transport_send_credit_update(vsk,
>+						    VIRTIO_VSOCK_TYPE_SEQPACKET,
>+						    NULL);
>+
>+	return vvs->user_read_seq_len;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_seq_get_len);
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
>+			virtio_transport_dec_rx_pkt(vvs, pkt->len);
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
> 				size_t len, int flags)
> {
>-	if (flags & MSG_PEEK)
>-		return virtio_transport_stream_do_peek(vsk, msg, len);
>-	else
>+	if (virtio_transport_get_type(sk_vsock(vsk)) == VIRTIO_VSOCK_TYPE_SEQPACKET) {
>+		if (flags & MSG_PEEK)
>+			return -EOPNOTSUPP;
>+
>+		return virtio_transport_seqpacket_do_dequeue(vsk, msg, len);
>+	} else {
>+		if (flags & MSG_PEEK)
>+			return virtio_transport_stream_do_peek(vsk, msg, 
>len);
>+
> 		return virtio_transport_stream_do_dequeue(vsk, msg, len);
>+	}

Maybe is better to create two different functions here since we are 
using two complete different paths:
virtio_transport_stream_dequeue()
virtio_transport_seqpacket_dequeue()

And adding a new 'seqpacket_dequeue' callback in the transport.

> }
> EXPORT_SYMBOL_GPL(virtio_transport_stream_dequeue);
>
>@@ -481,6 +673,8 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
> 	spin_lock_init(&vvs->rx_lock);
> 	spin_lock_init(&vvs->tx_lock);
> 	INIT_LIST_HEAD(&vvs->rx_queue);
>+	vvs->user_read_copied = 0;
>+	vvs->user_read_seq_len = 0;
>
> 	return 0;
> }
>@@ -490,13 +684,16 @@ EXPORT_SYMBOL_GPL(virtio_transport_do_socket_init);
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
>+
>+	virtio_transport_send_credit_update(vsk, type,
> 					    NULL);

This line can now be merged with the previous one.

> }
> EXPORT_SYMBOL_GPL(virtio_transport_notify_buffer_size);
>@@ -624,10 +821,11 @@ int virtio_transport_connect(struct vsock_sock *vsk)
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
>@@ -636,7 +834,6 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.flags = (mode & RCV_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> 			 (mode & SEND_SHUTDOWN ?
>@@ -644,6 +841,8 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 		.vsk = vsk,
> 	};
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
>@@ -665,12 +864,18 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
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
>@@ -688,7 +893,6 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RST,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.reply = !!pkt,
> 		.vsk = vsk,
> 	};
>@@ -697,6 +901,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 	if (pkt && le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RST)
> 		return 0;
>
>+	info.type = virtio_transport_get_type(sk_vsock(vsk));
>+
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
>
>@@ -884,44 +1090,59 @@ virtio_transport_recv_connecting(struct sock *sk,
> 	return err;
> }
>
>-static void
>+static bool
> virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 			      struct virtio_vsock_pkt *pkt)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>-	bool can_enqueue, free_pkt = false;
>+	bool data_ready = false;
>+	bool free_pkt = false;
>
>-	pkt->len = le32_to_cpu(pkt->hdr.len);
> 	pkt->off = 0;
>+	pkt->len = le32_to_cpu(pkt->hdr.len);
>
> 	spin_lock_bh(&vvs->rx_lock);
>
>-	can_enqueue = virtio_transport_inc_rx_pkt(vvs, pkt);
>-	if (!can_enqueue) {
>-		free_pkt = true;
>-		goto out;
>-	}
>+	switch (le32_to_cpu(pkt->hdr.type)) {
>+	case VIRTIO_VSOCK_TYPE_STREAM: {
>+		if (!virtio_transport_inc_rx_pkt(vvs, pkt)) {
>+			free_pkt = true;
>+			goto out;
>+		}
>
>-	/* Try to copy small packets into the buffer of last packet queued,
>-	 * to avoid wasting memory queueing the entire buffer with a small
>-	 * payload.
>-	 */
>-	if (pkt->len <= GOOD_COPY_LEN && !list_empty(&vvs->rx_queue)) {
>-		struct virtio_vsock_pkt *last_pkt;
>+		/* Try to copy small packets into the buffer of last packet queued,
>+		 * to avoid wasting memory queueing the entire buffer with a small
>+		 * payload.
>+		 */
>+		if (pkt->len <= GOOD_COPY_LEN && !list_empty(&vvs->rx_queue)) {
>+			struct virtio_vsock_pkt *last_pkt;
>
>-		last_pkt = list_last_entry(&vvs->rx_queue,
>-					   struct virtio_vsock_pkt, list);
>+			last_pkt = list_last_entry(&vvs->rx_queue,
>+						   struct virtio_vsock_pkt, list);
>
>-		/* If there is space in the last packet queued, we copy the
>-		 * new packet in its buffer.
>-		 */
>-		if (pkt->len <= last_pkt->buf_len - last_pkt->len) {
>-			memcpy(last_pkt->buf + last_pkt->len, pkt->buf,
>-			       pkt->len);
>-			last_pkt->len += pkt->len;
>-			free_pkt = true;
>-			goto out;
>+			/* If there is space in the last packet queued, we copy the
>+			 * new packet in its buffer.
>+			 */
>+			if (pkt->len <= last_pkt->buf_len - last_pkt->len) {
>+				memcpy(last_pkt->buf + last_pkt->len, pkt->buf,
>+				       pkt->len);
>+				last_pkt->len += pkt->len;
>+				free_pkt = true;
>+				goto out;
>+			}
> 		}
>+
>+		data_ready = true;
>+		break;
>+	}
>+
   ^
Unnecessary line break.

>+	case VIRTIO_VSOCK_TYPE_SEQPACKET: {
>+		data_ready = true;
>+		vvs->rx_bytes += pkt->len;

Why not using virtio_transport_inc_rx_pkt()?

>+		break;
>+	}
>+	default:
>+		goto out;
> 	}
>
> 	list_add_tail(&pkt->list, &vvs->rx_queue);
>@@ -930,6 +1151,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 	spin_unlock_bh(&vvs->rx_lock);
> 	if (free_pkt)
> 		virtio_transport_free_pkt(pkt);
>+
>+	return data_ready;
> }
>
> static int
>@@ -940,9 +1163,17 @@ virtio_transport_recv_connected(struct sock *sk,
> 	int err = 0;
>
> 	switch (le16_to_cpu(pkt->hdr.op)) {
>+	case VIRTIO_VSOCK_OP_SEQ_BEGIN: {
>+		struct virtio_vsock_sock *vvs = vsk->trans;
>+
>+		spin_lock_bh(&vvs->rx_lock);
>+		list_add_tail(&pkt->list, &vvs->rx_queue);
>+		spin_unlock_bh(&vvs->rx_lock);
>+		return err;
>+	}
> 	case VIRTIO_VSOCK_OP_RW:
>-		virtio_transport_recv_enqueue(vsk, pkt);
>-		sk->sk_data_ready(sk);
>+		if (virtio_transport_recv_enqueue(vsk, pkt))
>+			sk->sk_data_ready(sk);
> 		return err;
> 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
> 		sk->sk_write_space(sk);
>@@ -990,13 +1221,14 @@ virtio_transport_send_response(struct vsock_sock *vsk,
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
>@@ -1086,6 +1318,12 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
> 	return 0;
> }
>
>+static bool virtio_transport_valid_type(u16 type)
>+{
>+	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
>+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>+}
>+
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>  * lock.
>  */
>@@ -1111,7 +1349,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 					le32_to_cpu(pkt->hdr.buf_alloc),
> 					le32_to_cpu(pkt->hdr.fwd_cnt));
>
>-	if (le16_to_cpu(pkt->hdr.type) != VIRTIO_VSOCK_TYPE_STREAM) {
>+	if (!virtio_transport_valid_type(le16_to_cpu(pkt->hdr.type))) {
> 		(void)virtio_transport_reset_no_sock(t, pkt);
> 		goto free_pkt;
> 	}
>@@ -1128,6 +1366,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		}
> 	}
>
>+	if (virtio_transport_get_type(sk) != le16_to_cpu(pkt->hdr.type))
>+		goto free_pkt;
>+
> 	vsk = vsock_sk(sk);
>
> 	space_available = virtio_transport_space_update(sk, pkt);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
