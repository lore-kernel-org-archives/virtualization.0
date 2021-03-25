Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900FEC433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:42:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C43F61A10
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C43F61A10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C88140EBA;
	Thu, 25 Mar 2021 10:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ebWFM2Trlr-H; Thu, 25 Mar 2021 10:42:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF93A40E95;
	Thu, 25 Mar 2021 10:42:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B121BC000E;
	Thu, 25 Mar 2021 10:42:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B43B8C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8AE3540526
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NzujUsb8Mdq4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:42:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD7D140193
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616668931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQDI6ul2y7LDTOrys0NWj2wyx1hXa7tSyglML0bhC18=;
 b=KchhdeGfkta7UjzBaNgoi/j/pZtgG3NjgR/rt4JDX9XQs3yTi5JPYx9IM09ZgE6hAVSQtg
 KgxiMfUZcsPp5Af0VB0rF/git+pGcnFQFcGXJSuKkcBA8CVMXYbAz4yTelCXDq90YbK1Yx
 DtZbxLoa/WeTwt0nEJknzAbmRZiWBj0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-rTUx7MswP4mpSNaG1_Bh8w-1; Thu, 25 Mar 2021 06:42:09 -0400
X-MC-Unique: rTUx7MswP4mpSNaG1_Bh8w-1
Received: by mail-wr1-f69.google.com with SMTP id m23so2452116wrh.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 03:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aQDI6ul2y7LDTOrys0NWj2wyx1hXa7tSyglML0bhC18=;
 b=paSK2Nm+Fo4I7gPUGuKMdA9xNvGzA0rAVQfCVAJumfpTPZfzhjRE73TIoXl/TCeWK9
 er0glHOH5F14l4YCjBhQYBN6WG8ZT4R47H5tWQgbAGJ80JyrU4gTTESP5PPX1Ex1TVXu
 sa5eNts057/rKV1DC/daZ5oCHndNX7PD+FIPqeKL/DRa2/v0EkaS+893lednavF9z9UH
 OLpITkfpgfVcD1Rdj1cp1wWBWRwdZtwHSxsbfoM58UEQ/CUPEMptatpbgPAutZHYGPWg
 o3Lq9p4Mtoyt6eD4LHYyLsoZqEO7468oIHVFl+HC6+BF6rLtmqLrhMMrQGhDMHP3ihEz
 vEEw==
X-Gm-Message-State: AOAM532KVSUz8T0zFIsG2/5bnYIhoDWiCc0Vob8qHzRtkLtAx3DrvFD0
 eLl0/mmu/jV3st+2rvLGGbd02z+40FHxN9GVpw38uJt85wMIb8epNr+bqm1HluCgU8Wgp8emgrx
 agdD34n+pLanOUuxfa0gbQAWLug477Rc867DYftd88g==
X-Received: by 2002:a05:600c:3506:: with SMTP id
 h6mr7332010wmq.168.1616668928293; 
 Thu, 25 Mar 2021 03:42:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG/dVJd/zV/tTUYY28Q+C/IDwYWmzMmVdSbdEw8RE1Cc5u1xVljyOZijxgygq5uU0DSr+VGA==
X-Received: by 2002:a05:600c:3506:: with SMTP id
 h6mr7331961wmq.168.1616668927966; 
 Thu, 25 Mar 2021 03:42:07 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id p18sm6580970wrs.68.2021.03.25.03.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 03:42:07 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:42:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 17/22] vhost/vsock: setup SEQPACKET ops for
 transport
Message-ID: <20210325104205.y5z6qjv5g2kzvj3m@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131421.2461760-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131421.2461760-1-arseny.krasnov@kaspersky.com>
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

On Tue, Mar 23, 2021 at 04:14:18PM +0300, Arseny Krasnov wrote:
>This also removes ignore of non-stream type of packets and adds
>'seqpacket_allow()' callback.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c | 15 +++++++++++++--
> 1 file changed, 13 insertions(+), 2 deletions(-)

Same thing for this transporter too, maybe we can merge with the patch 
"vhost/vsock: SEQPACKET feature bit support".

Stefano

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 5e78fb719602..5af141772068 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -354,8 +354,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	if (le16_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_STREAM)
>-		pkt->len = le32_to_cpu(pkt->hdr.len);
>+	pkt->len = le32_to_cpu(pkt->hdr.len);
>
> 	/* No payload */
> 	if (!pkt->len)
>@@ -398,6 +397,8 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_seqpacket_allow(void);
>+
> static struct virtio_transport vhost_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -424,6 +425,10 @@ static struct virtio_transport vhost_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>+		.seqpacket_allow          = vhost_transport_seqpacket_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>@@ -439,8 +444,14 @@ static struct virtio_transport vhost_transport = {
> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>+	.seqpacket_allow = false
> };
>
>+static bool vhost_transport_seqpacket_allow(void)
>+{
>+	return vhost_transport.seqpacket_allow;
>+}
>+
> static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> {
> 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
