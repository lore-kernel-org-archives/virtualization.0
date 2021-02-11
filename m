Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C96C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 13:59:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABE264E95
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 13:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABE264E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74CC087576;
	Thu, 11 Feb 2021 13:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AdJ0asifThgI; Thu, 11 Feb 2021 13:58:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A82FD87568;
	Thu, 11 Feb 2021 13:58:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E1F4C0174;
	Thu, 11 Feb 2021 13:58:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6041C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC6206F4D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E4gfAEqs2xDJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:58:56 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id A90EB6F53B; Thu, 11 Feb 2021 13:58:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB9466F4D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613051932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1bEflgou0H31BnnK3AQtbjmN1ZghmRenGr52+hcNzT0=;
 b=e2mIsZoxMJd+7o/U3tp0mHKYDk0ikgRvUxcJTuQdm3EqXRkkl17hDhXn8HoVmH1FHs0iCI
 YdxG0SvPhgHhWRDP+xFwT98kfH1qloO1H/X4vaQEbk/P+gYPKNGKQOH3MMvsDAh6u8aajD
 TvKHlvWXLAWxDHhNg1gwR/bnRLh5B4s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-MjlXo-NKPOiu7skRuvmANg-1; Thu, 11 Feb 2021 08:58:51 -0500
X-MC-Unique: MjlXo-NKPOiu7skRuvmANg-1
Received: by mail-ej1-f72.google.com with SMTP id jg11so4858124ejc.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 05:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1bEflgou0H31BnnK3AQtbjmN1ZghmRenGr52+hcNzT0=;
 b=J5rzxbhgyqysmcd5KgupEPPG2GBQ1wM1TWHptC5sfdoxImZziB6QRc7d3hqeLFhmKC
 7ikFnemkkfNN7I5aSFZHU0AFhvMr80/b/RF0txANZpz5exesxV7L29dTu/7yEX1GBjQU
 mV4nFswa2cNInTc57YY10lDdJzPSzqON/kIcYOs1fEXqCr7J+tLwhJ0dH2QjHK1t0E4G
 fD8F5zT+gH5KYCUZnOaTt4E7AdZSrjLcC9Hg8rs5iPp+yqrrJqS4CXu/CTcOj2p0O7XS
 Tzjqcql2eDOcDEaH0p1ved9zo5fn1VL/QCr/+MKQzp/GUBGTvV/b8Ba0qlFLc1EqcYqi
 gZBQ==
X-Gm-Message-State: AOAM53214vLNUIUdOXMIuCcWLHpHPpGHdeGdcuAL8pMPkij0FQNJXFqk
 KH0OgrF10IRr9JYe8Uq/frdR8LkN4DYFNZYMJy/dSHMzmMe3wdYkJ9dDr7FUE6VzRNiDe/thzhq
 i0AkcBvscif+uelgMFMN4L1zlRY5pP1k4k9ETkEJliQ==
X-Received: by 2002:a05:6402:5112:: with SMTP id
 m18mr8549462edd.129.1613051929544; 
 Thu, 11 Feb 2021 05:58:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfq7X7hD1JmHzQK5zfZIpxq+rP5EN2ilMJ1bkKStokLGIe1TtlOeeeu3gyeUI3B8S6k0JFzg==
X-Received: by 2002:a05:6402:5112:: with SMTP id
 m18mr8549428edd.129.1613051929358; 
 Thu, 11 Feb 2021 05:58:49 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id bd27sm3969917edb.37.2021.02.11.05.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 05:58:48 -0800 (PST)
Date: Thu, 11 Feb 2021 14:58:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 10/17] virtio/vsock: fetch length for SEQPACKET
 record
Message-ID: <20210211135846.mxqdranvda72vq65@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151711.805503-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151711.805503-1-arseny.krasnov@kaspersky.com>
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

On Sun, Feb 07, 2021 at 06:17:08PM +0300, Arseny Krasnov wrote:
>This adds transport callback which tries to fetch record begin marker
>from socket's rx queue. It is called from af_vsock.c before reading data
>packets of record.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 40 +++++++++++++++++++++++++
> 2 files changed, 41 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 4d0de3dee9a4..a5e8681bfc6a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -85,6 +85,7 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4572d01c8ea5..7ac552bfd90b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -420,6 +420,46 @@ static size_t virtio_transport_drop_until_seq_begin(struct virtio_vsock_sock *vv
> 	return bytes_dropped;
> }
>
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
>+	/* Fetch all orphaned 'RW', packets, and
>+	 * send credit update.

Single line?

>+	 */
>+	bytes_dropped = virtio_transport_drop_until_seq_begin(vvs);
>+
>+	if (list_empty(&vvs->rx_queue))
>+		goto out;
>+
>+	pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+
>+	vvs->user_read_copied = 0;
>+
>+	seq_hdr = (struct virtio_vsock_seq_hdr *)pkt->buf;
>+	vvs->user_read_seq_len = le32_to_cpu(seq_hdr->msg_len);
>+	vvs->curr_rx_msg_cnt = le32_to_cpu(seq_hdr->msg_cnt);
>+	virtio_transport_dec_rx_pkt(vvs, pkt);
>+	virtio_transport_remove_pkt(pkt);
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
