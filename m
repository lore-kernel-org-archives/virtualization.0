Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBFCC433ED
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:22:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CAF61437
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CAF61437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C47D7405D5;
	Wed, 21 Apr 2021 09:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ieR9UVjQXq0t; Wed, 21 Apr 2021 09:22:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39A3B405D3;
	Wed, 21 Apr 2021 09:22:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B3D8C000F;
	Wed, 21 Apr 2021 09:22:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2386FC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A7B1405D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TMF2ESvbw-wy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:22:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03E59405D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618996934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tqz+ILNRVJkY3d8AEaA0cGa9hOYYSpYKO+GI5Wbje3M=;
 b=SEWmEGX0pQXn1kOW7iZaC24mpLX52gvZQ7sL7Qv0TxPY+Mppic/bEUKSt3vpOqOf3aTpTd
 FPcZG2+KTK5jGZtsgc4YIT0MbLwPscAnY1k1jP5LLNz14MVxLnkG3p6Oj0viqgrS56XQBo
 S756if7rTJJZmIvN+fsMb79VTMLnwMk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-EIhotH1JMAeiZ3t5nnmb9g-1; Wed, 21 Apr 2021 05:22:12 -0400
X-MC-Unique: EIhotH1JMAeiZ3t5nnmb9g-1
Received: by mail-ed1-f69.google.com with SMTP id
 z3-20020a05640240c3b029037fb0c2bd3bso14800010edb.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tqz+ILNRVJkY3d8AEaA0cGa9hOYYSpYKO+GI5Wbje3M=;
 b=fK7azP758TwpqkXAerqVxnjEhQri6rs8at2HQGEjvYBjLrr2QJL7KaMAI0kcxNxzvQ
 jAe052At6dYKHFLkY/FhYAD4f10udxLzv/1AgpOkp+hsAVP7k51/4bdmCJEJVzmhBJiu
 9efRlzVtdNezpbOqSoq6iFN8RHvszjudO8hNR97eWBRmLP2SIzLpwKTtW2ZbfkgdbnxF
 Aox56M3z3yOuIvryfu5cz59STPCOEZ/qRNYO3ExAbhuOZIMOEyU5RhSrolzCdoZOroLc
 mzN1ncbORuhWY/jUPayXOzFzkYI6ltr3DifgoY3w7Hx/VBdYSXLh5ERECxqbxuPKsYy8
 ZBAQ==
X-Gm-Message-State: AOAM530AuvPpukhwEnnL6mQVTxZTYpopoS+nNQ4ZXzbsrWgzfgVOyvJI
 7rdb8Iv9Kyl0HZJ26Vg5NPT2TgRZZe2/jnfwUHhNfVzAO1LP+tOkrWk0XG2litP0QGKjUzgqwK4
 gMdjjQFisJ0pXolL98J59iKFdE/iayE5YNA9AVc+oYw==
X-Received: by 2002:a17:907:205c:: with SMTP id
 pg28mr21587936ejb.185.1618996931503; 
 Wed, 21 Apr 2021 02:22:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ1GKcB5m8ic7Uze0zxQ+IL9dAu0rGNwXFSEggtrJZNLeSX8wEQPoYN+/aKzNoisB+znsktw==
X-Received: by 2002:a17:907:205c:: with SMTP id
 pg28mr21587928ejb.185.1618996931356; 
 Wed, 21 Apr 2021 02:22:11 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id g11sm2480790edt.35.2021.04.21.02.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 02:22:11 -0700 (PDT)
Date: Wed, 21 Apr 2021 11:22:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 14/19] virtio/vsock: enable SEQPACKET for transport
Message-ID: <20210421092208.hjng7pv7loh4fj3t@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210413124552.3404877-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210413124552.3404877-1-arseny.krasnov@kaspersky.com>
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

On Tue, Apr 13, 2021 at 03:45:49PM +0300, Arseny Krasnov wrote:
>This adds
>1) SEQPACKET ops for virtio transport and 'seqpacket_allow()' callback.
>2) Handling of SEQPACKET bit: guest tries to negotiate it with vhost.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
>v7 -> v8:
> - This patch merged with patch which adds SEQPACKET feature bit to
>   virtio transport.
>
> net/vmw_vsock/virtio_transport.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..ee99bd919a12 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -443,6 +443,8 @@ static void virtio_vsock_rx_done(struct virtqueue 
>*vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+static bool virtio_transport_seqpacket_allow(void);
>+
> static struct virtio_transport virtio_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -469,6 +471,10 @@ static struct virtio_transport virtio_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>+		.seqpacket_allow          = virtio_transport_seqpacket_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = 
> 		virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>@@ -483,8 +489,14 @@ static struct virtio_transport virtio_transport = {
> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>+	.seqpacket_allow = false
> };
>
>+static bool virtio_transport_seqpacket_allow(void)
>+{
>+	return virtio_transport.seqpacket_allow;
>+}
>+
> static void virtio_transport_rx_work(struct work_struct *work)
> {
> 	struct virtio_vsock *vsock =
>@@ -612,6 +624,10 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>+
>+	if (vdev->features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
>+		virtio_transport.seqpacket_allow = true;
>+

virtio-vsock devices can be hot-plugged and hot-unplugged, so we should 
reset virtio_transport.seqpacket_allow at every probe.

Now thinking about it more, would it be better to save this information 
in struct virtio_vsock instead of struct virtio_transport?

> 	return 0;
>
> out:
>@@ -695,6 +711,7 @@ static struct virtio_device_id id_table[] = {
> };
>
> static unsigned int features[] = {
>+	VIRTIO_VSOCK_F_SEQPACKET
> };
>
> static struct virtio_driver virtio_vsock_driver = {
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
