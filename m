Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4F9C433C1
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:40:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B98661A1A
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B98661A1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15D5840644;
	Thu, 25 Mar 2021 10:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j7VKQOdouJVO; Thu, 25 Mar 2021 10:40:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60A234063B;
	Thu, 25 Mar 2021 10:40:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32F3FC000E;
	Thu, 25 Mar 2021 10:40:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0666AC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAC8760B1A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7v3iEM7hNv7P
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:39:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1704260727
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616668796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/kpD2aeNiHkluUl+lY5UKmHgOwXffwSQz+l4fa/jph4=;
 b=cnu+/53sQdcj1f2aVCX1bdB85aJOH69WeDUYsurcz0forrowm5FxZqvcbJBTqteiEzceer
 duOczffPczCXzMV4SPGRb4010DkK0ew2GWh+KiXQFU9pBtcQkO+s2muus1G0dwAyn61P+Y
 mwleDr2GrRYZsh36qTiYqK6EJo5LCR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-IRzk8GKlNGuWJh16kxykmA-1; Thu, 25 Mar 2021 06:39:55 -0400
X-MC-Unique: IRzk8GKlNGuWJh16kxykmA-1
Received: by mail-wm1-f69.google.com with SMTP id a65so1088651wmh.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 03:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/kpD2aeNiHkluUl+lY5UKmHgOwXffwSQz+l4fa/jph4=;
 b=Rs3jL0uha8pp19zDv9bDQJdXXuYhqu6t6Lmi94hhAe8G0Lzyap1H1v1hJSelh2ZuXx
 O0/ojTtJyQsFxSX27RT4xgxYuS3BXJi2FnlEfkn+VM2L3EUGz2d8PkNNGMTTMgYRYMuw
 0LEnD3q+RJLkf3KlOJzLkUAXBKFsaPz0c5GZk3+WXaQgYHvbPsPPBCFrUTSjJw8PeZ22
 eucLdSZSrT8bisvScnY5XFu3ZDFvE11NFyDHrD3sgxZzrb74omnpVqgkLRdydJbZX9CN
 Bu3oiG9cMD7I7wiCwS/lahIg9IeUSbu4+cexlFXn9ivY0vCiPC5LKDssHPgevIIjnXtq
 AsMw==
X-Gm-Message-State: AOAM533nlstZ80KeP1n2tjMcqY/tiCfBHy919DMcAeP7dnKKyTKbJP6e
 vwQ5MYvX1vm+KogmKv2SMpL21gZ8RHmXkRaAbv1Ic7GRzhQhi/o7QUzUxRW36t9x7no/2N6JWaf
 4TyNO1OD3AY6C3+LI4DTbxwQKNWy1sxLmpbr1nreSwg==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr8193205wrw.355.1616668793956; 
 Thu, 25 Mar 2021 03:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSTH23goWjAebsKh2RhkZfdPUdCAZpsy4s0EXvpQEhvBoOO6j7qufPnU+Ca8egdJ+gYncnng==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr8193189wrw.355.1616668793779; 
 Thu, 25 Mar 2021 03:39:53 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id c2sm6099603wmr.22.2021.03.25.03.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 03:39:53 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:39:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 16/22] virtio/vsock: setup SEQPACKET ops for
 transport
Message-ID: <20210325103950.7k75hntees5ppgbm@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131406.2461651-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131406.2461651-1-arseny.krasnov@kaspersky.com>
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

On Tue, Mar 23, 2021 at 04:14:03PM +0300, Arseny Krasnov wrote:
>This adds SEQPACKET ops for virtio transport and 'seqpacket_allow()'
>callback.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)

Sorry for not mentioning this in the previous review, but maybe we can 
merge this patch with "virtio/vsock: SEQPACKET feature bit support", so 
we have a single patch when we fully enable the SEQPACKET support in 
this transport.

Anyway, I don't have a strong opinion on that.

What do you think?

Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport.c 
>b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..83ae2078c847 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -443,6 +443,8 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
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
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
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
>-- 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
