Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C4BEB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 16:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D2C661395;
	Mon, 26 Jun 2023 16:11:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D2C661395
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fB/I+2kM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3J918zdh8fu; Mon, 26 Jun 2023 16:11:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC12261398;
	Mon, 26 Jun 2023 16:11:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC12261398
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 953DCC007A;
	Mon, 26 Jun 2023 16:11:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32B83C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0036261395
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:11:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0036261395
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zG45-qZLQ8QU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:11:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2805B6137C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2805B6137C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YymWdEkHWhyai/v4Ncfq5HtLNdYJQriBatYjnpRoPBU=;
 b=fB/I+2kMbhfkgOGyezNBywBQnlSaxHuvQxVfmEYFE1b/o55mnkJ3d6q63j8x7JGOy+aO95
 BKnH+TjiLzY/QrYqCfZcehopBJTsKN24X3OzyQY0LX0Dk4NdLBcZERt8oEJvMTED3RtODE
 PrpAYsLST6TDrON2FzT8PU8KJciQvcI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-BoqlcGG-Pp6d4XKj6Y8tmg-1; Mon, 26 Jun 2023 12:11:22 -0400
X-MC-Unique: BoqlcGG-Pp6d4XKj6Y8tmg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7659cb9c3b3so142334685a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795881; x=1690387881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YymWdEkHWhyai/v4Ncfq5HtLNdYJQriBatYjnpRoPBU=;
 b=Zdqv/GZFBWV6BNnUrRainQPnBgALGSvuB5d2g+uRb4myiVjmFLyszR8jdoa+pYfHGn
 9XvHRTFSqTl7tAaAhdroPpJeObamlwZdEgZEeOT7uteEcUr6fosDADTbNf1wkyzZhIIf
 Da0J9M4RtSAtgyjFYhQs/RGeegtvVqfoxPeg2tM5CJYZ989KdTjhIcwL2H+twFjBBl23
 mkm7Kf54BPSIAD8KK1tcUarggeX/HhVrkRq9Qo2dFg3bQyveWW1j4D6f9eXQu7F0Lvhs
 vXxr6/uGugvsVSCSsD0HA3hl7tdqxb47KCab+U3hbaX3ofpRrzRuUfFgPSkkKWUz/2iC
 Egaw==
X-Gm-Message-State: AC+VfDztc3v1lC24+Znyzw2soIf3pawziPBS76OsyKFemJL+E15nttjZ
 xTACgLZp+T3QPMEV8yRehzjTlNXxs1zVK21B5k+iM/dsC6dormpWWKae/uXUYzmVaiMpsCaVvF2
 1PBjampMLqaji2hC2nP47GdIaRDN6EywtkveFfvUAxWWT15RX7A==
X-Received: by 2002:a05:620a:4308:b0:765:619c:cca8 with SMTP id
 u8-20020a05620a430800b00765619ccca8mr8196732qko.16.1687795881649; 
 Mon, 26 Jun 2023 09:11:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OTPuoDBhm9NFpKvI1ovmDpK5uOGhA7usFuq/EJikHKcpNPEengaaoKEb0Pz/YsBCORIP4qQ==
X-Received: by 2002:a05:620a:4308:b0:765:619c:cca8 with SMTP id
 u8-20020a05620a430800b00765619ccca8mr8196717qko.16.1687795881447; 
 Mon, 26 Jun 2023 09:11:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 y26-20020a37e31a000000b00765a7843382sm1252256qki.74.2023.06.26.09.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:11:20 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:11:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 11/17] vsock/virtio: support MSG_ZEROCOPY for
 transport
Message-ID: <fvxvln7njntjflcwbw7ypzu7jybe2cwq5xedgjcxkkubuuayp7@bs3r3r5rvifw>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-12-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-12-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Sat, Jun 03, 2023 at 11:49:33PM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for virtio transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 6053d8341091..d9ffa16dda69 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -438,6 +438,11 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+static bool virtio_transport_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool virtio_transport_seqpacket_allow(u32 remote_cid);
>
> static struct virtio_transport virtio_transport = {
>@@ -484,6 +489,8 @@ static struct virtio_transport virtio_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,

Ditto.

> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
