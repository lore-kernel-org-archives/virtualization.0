Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A4C433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:21:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0D564FF3
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0D564FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7399F4ED4D;
	Fri, 12 Mar 2021 15:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tRfBDBSJM2t; Fri, 12 Mar 2021 15:21:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 972544710A;
	Fri, 12 Mar 2021 15:20:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 743F2C000B;
	Fri, 12 Mar 2021 15:20:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2132C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92F6043049
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFIgDuH2R3Ru
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:20:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CACAF4017B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615562455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XNhlw58yD5yXI9Wev/02PZnuhLLW5yA/Trw5RjUWlz8=;
 b=YsGwYCKnU1cvfhechO5ZIWBUZi6RVanAX/JQReoAhqwQc37+my+l/7YNakJtSkC1Da7bnb
 MbvNVzMbN22pdt3MWtohMQQrLZnRfE0ozqu2Mha5ezcV+VHOxXR/E17cujAy2EzYr0aYU9
 AW9m0ctO/TBWQX2fNUW93A7hAnVNORw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-nkNSjlxlN4KyjhPs90PRBA-1; Fri, 12 Mar 2021 10:20:54 -0500
X-MC-Unique: nkNSjlxlN4KyjhPs90PRBA-1
Received: by mail-wm1-f71.google.com with SMTP id a65so2168668wmh.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XNhlw58yD5yXI9Wev/02PZnuhLLW5yA/Trw5RjUWlz8=;
 b=snAAoojOsl4M+rpjtuWhRHrSWs4WSWd9brQZcARYE6GaJfdhs2g5ABfQ4m4+ed5h6P
 2aRqcU//5mb9Y9oNqBVIB0YW/9PuP7T5nUDqYRQq8RxP40e2s7jCGcs28QeMpYdYgQ0r
 Cvm8J2fll21YfZl74uuHcn9qIZCEhdoQ4SKnoaQ1serz/8xlm6mHAvJyCb95YTkzllPS
 dJTTeTHxPMGi5kHZv0sTNUbSdS62wFeL6JAWBMsC23W0xDRFS5LCDi3SjSHtAY2ALalP
 jzEidF5mIQHZdNJnKmHTJJDkUT9phpCuv1cpw+rds+Mhq99Gct/rQlcg4ah1T6iorosW
 5yEQ==
X-Gm-Message-State: AOAM533WleUyKfjtPYMQ9MNuwe/IfurBdZJ+9t3cNc8ggZIQ6NB7uBf8
 Pdw5VCa2knTPLvwfgaxu+m72Xw/meCbB0hU+jgCebUWiRW7M/T8bMTd8aaCrF48wRrjNCMEggZG
 OI8HNQrWvzDI8sCmEJGLJdTRGrqaAN2nrgROBIIa7Gw==
X-Received: by 2002:adf:8562:: with SMTP id 89mr14637726wrh.101.1615562452730; 
 Fri, 12 Mar 2021 07:20:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOgAMv5zfx20zVxHk8NkAVCtdDWRTDNIVXsPFGWUxUqnBQhG1JfeKtcQP8FzSMF5UIyygdGw==
X-Received: by 2002:adf:8562:: with SMTP id 89mr14637714wrh.101.1615562452552; 
 Fri, 12 Mar 2021 07:20:52 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s84sm2463651wme.11.2021.03.12.07.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 07:20:52 -0800 (PST)
Date: Fri, 12 Mar 2021 16:20:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 12/22] virtio/vsock: fetch length for SEQPACKET
 record
Message-ID: <20210312152049.iiarapjotp6eqho2@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180235.3465973-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307180235.3465973-1-arseny.krasnov@kaspersky.com>
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

On Sun, Mar 07, 2021 at 09:02:31PM +0300, Arseny Krasnov wrote:
>This adds transport callback which tries to fetch record begin marker
>from socket's rx queue. It is called from af_vsock.c before reading data
>packets of record.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 53 +++++++++++++++++++++++++
> 2 files changed, 54 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 466a5832d2f5..d7edcfeb4cd2 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -88,6 +88,7 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk);
> int
> virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 				   struct msghdr *msg,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 5f1e283e43f3..6fc78fec41c0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -399,6 +399,59 @@ static inline void virtio_transport_remove_pkt(struct virtio_vsock_pkt *pkt)
> 	virtio_transport_free_pkt(pkt);
> }
>
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
>+		virtio_transport_remove_pkt(pkt);
>+	}
>+
>+	return bytes_dropped;
>+}
>+
>+size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk)
>+{
>+	struct virtio_vsock_seq_hdr *seq_hdr;
>+	struct virtio_vsock_sock *vvs;
>+	struct virtio_vsock_pkt *pkt;
>+	size_t bytes_dropped;
>+
>+	vvs = vsk->trans;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* Fetch all orphaned 'RW' packets and send credit update. */
>+	bytes_dropped = virtio_transport_drop_until_seq_begin(vvs);
>+
>+	if (list_empty(&vvs->rx_queue))
>+		goto out;

What do we return to in this case?

IIUC we return the len of the previous packet, should we set 
vvs->seqpacket_state.user_read_seq_len to 0?

>+
>+	pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+
>+	vvs->seqpacket_state.user_read_copied = 0;
>+
>+	seq_hdr = (struct virtio_vsock_seq_hdr *)pkt->buf;
>+	vvs->seqpacket_state.user_read_seq_len = 
>le32_to_cpu(seq_hdr->msg_len);
>+	vvs->seqpacket_state.curr_rx_msg_id = le32_to_cpu(seq_hdr->msg_id);
>+	virtio_transport_dec_rx_pkt(vvs, pkt);
>+	virtio_transport_remove_pkt(pkt);
>+out:
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	if (bytes_dropped)
>+		virtio_transport_send_credit_update(vsk);
>+
>+	return vvs->seqpacket_state.user_read_seq_len;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_seq_get_len);
>+
> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 						 struct msghdr *msg,
> 						 bool *msg_ready)
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
