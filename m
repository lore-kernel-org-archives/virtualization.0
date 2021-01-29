Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C2DC433DB
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 10:56:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B49C64ECF
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 10:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B49C64ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5C6586AB1;
	Fri, 29 Jan 2021 10:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRTLVsylGyd0; Fri, 29 Jan 2021 10:55:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EAF3086AA4;
	Fri, 29 Jan 2021 10:55:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1EAFC0FA7;
	Fri, 29 Jan 2021 10:55:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97520C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7D98B86AA4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hAAAyl5_1Ojf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:55:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 25B1486A94
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611917754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWftcXiQm+nogOviCUKyywzv+wx/sp0R6J9AC7Pstoo=;
 b=W3WNhqpHe83i2gF5BtG3P2dd288N5IkBIE2uUJqzsxBAuMI0T/TdRDdbwF8jPYPpF9jnpB
 vxcUk/V7rO3ixvlsoci5zBQIBzk0mIkrn6qecZ+XNJ32gtFcM2Z7jknEuRRQox4x2WsaiN
 7dFdWQiR8c/+AYv3zBoZndhQ57dYKXk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-jw9CoVmPMy6hkZJAKhnLpQ-1; Fri, 29 Jan 2021 05:55:51 -0500
X-MC-Unique: jw9CoVmPMy6hkZJAKhnLpQ-1
Received: by mail-ej1-f70.google.com with SMTP id k3so3741944ejr.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 02:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XWftcXiQm+nogOviCUKyywzv+wx/sp0R6J9AC7Pstoo=;
 b=B9VD4r0N8XlCbnHp6L2okP8PnwI+4w/F2xzdIrDNy6fsO6nENfwzb2aEkfMgXk0BQI
 DDGqm3LWcpEPfE7SBtgWdu4AiBkFScbJ9fZbxN+Jona33sQt8LoNBf9gAouBy0hJ24gw
 Xadk9X5F8p8z6J7gBNDvKpAjMKnKExNke6GpcvTtqC7xkeV3k8qXArqjiLcUc4QOw/7q
 aQaQ5MnfvKIS1k2mzIQ9wC8cSMGCX9nA42e47bOgRfWV9OY1uBxuZsNCDCJCSW4Db4Ve
 z4k1Vz0wtBe33YUX/wvKW6CyODgcT36TX/y5aXSFTl7x1/GxtDX6XqVDNkRkDSxSTrAv
 G2Wg==
X-Gm-Message-State: AOAM533gqElb1vVSRxMTy2eHhzjJBaEEG2nWEqPjGeuWnDZQL5Y9F10U
 IMQsXFZ+1eaIgnbi+esCnfomfjmeV9YY8sgsIG0jxbrVgWplqcyFr0dXV3+F257XQo5gDTVi37c
 1ODZK1+sWRpRgGKdtolXpYsv0Fyytr1yvOjE3kdRBpg==
X-Received: by 2002:a17:906:4a19:: with SMTP id
 w25mr3916249eju.153.1611917749759; 
 Fri, 29 Jan 2021 02:55:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyisY3z4Ew2R/eytJ5ChjJ5KuGRuf51nFfuQ7gRtgRHv233dPug6u8MF3C6/qSNTmtXmRistg==
X-Received: by 2002:a17:906:4a19:: with SMTP id
 w25mr3916232eju.153.1611917749595; 
 Fri, 29 Jan 2021 02:55:49 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id r26sm4675315edc.95.2021.01.29.02.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 02:55:49 -0800 (PST)
Date: Fri, 29 Jan 2021 11:55:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 09/13] virtio/vsock: add SEQPACKET receive logic
Message-ID: <20210129105546.ldose6xjjjh3crye@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111444.599211-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210125111444.599211-1-arseny.krasnov@kaspersky.com>
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

On Mon, Jan 25, 2021 at 02:14:41PM +0300, Arseny Krasnov wrote:
>This modifies current receive logic for SEQPACKET support:
>1) Inserts 'SEQ_BEGIN' packet to socket's rx queue.
>2) Inserts 'RW' packet to socket's rx queue, but without merging with
>   buffer of last packet in queue.
>3) Performs check for packet and socket types on receive(if mismatch,
>   then reset connection).
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 79 ++++++++++++++++++-------
> 1 file changed, 58 insertions(+), 21 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcce35d7b462..90f9feef9d8f 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -397,6 +397,14 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
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
> static inline void virtio_transport_del_n_free_pkt(struct virtio_vsock_pkt *pkt)
> {
> 	list_del(&pkt->list);
>@@ -1050,39 +1058,49 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 			      struct virtio_vsock_pkt *pkt)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>-	bool can_enqueue, free_pkt = false;
>+	bool free_pkt = false;
>
> 	pkt->len = le32_to_cpu(pkt->hdr.len);
> 	pkt->off = 0;
>
> 	spin_lock_bh(&vvs->rx_lock);
>
>-	can_enqueue = virtio_transport_inc_rx_pkt(vvs, pkt);
>-	if (!can_enqueue) {
>+	if (!virtio_transport_inc_rx_pkt(vvs, pkt)) {

This is an unnecessary change, it should go in another patch.

> 		free_pkt = true;
> 		goto out;
> 	}
>
>-	/* Try to copy small packets into the buffer of last packet queued,
>-	 * to avoid wasting memory queueing the entire buffer with a small
>-	 * payload.
>-	 */
>-	if (pkt->len <= GOOD_COPY_LEN && !list_empty(&vvs->rx_queue)) {
>-		struct virtio_vsock_pkt *last_pkt;
>+	switch (le16_to_cpu(pkt->hdr.type)) {
>+	case VIRTIO_VSOCK_TYPE_STREAM: {

We already checked the 'type' in virtio_transport_recv_pkt(), so there 
is no need to this switch, I think you can simply add

        if (le16_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_STREAM) {

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
>+		break;
>+	}
>+	case VIRTIO_VSOCK_TYPE_SEQPACKET: {
>+		break;
>+	}
>+	default:
>+		goto out;
> 	}
>
> 	list_add_tail(&pkt->list, &vvs->rx_queue);
>@@ -1101,6 +1119,14 @@ virtio_transport_recv_connected(struct sock *sk,
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

Are there any problems if we use virtio_transport_recv_enqueue() in this 
case?

> 	case VIRTIO_VSOCK_OP_RW:
> 		virtio_transport_recv_enqueue(vsk, pkt);
> 		sk->sk_data_ready(sk);
>@@ -1247,6 +1273,12 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
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
>@@ -1272,7 +1304,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 					le32_to_cpu(pkt->hdr.buf_alloc),
> 					le32_to_cpu(pkt->hdr.fwd_cnt));
>
>-	if (le16_to_cpu(pkt->hdr.type) != VIRTIO_VSOCK_TYPE_STREAM) {
>+	if (!virtio_transport_valid_type(le16_to_cpu(pkt->hdr.type))) {
> 		(void)virtio_transport_reset_no_sock(t, pkt);
> 		goto free_pkt;
> 	}
>@@ -1289,6 +1321,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		}
> 	}
>
>+	if (virtio_transport_get_type(sk) != le16_to_cpu(pkt->hdr.type)) {
>+		(void)virtio_transport_reset_no_sock(t, pkt);
>+		goto free_pkt;
>+	}
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
