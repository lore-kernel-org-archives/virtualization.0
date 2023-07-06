Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87654EB64DC
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B1A26111B;
	Thu,  6 Jul 2023 16:55:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B1A26111B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IyMu8Csa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0fbDeaepN6xJ; Thu,  6 Jul 2023 16:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E361760FFE;
	Thu,  6 Jul 2023 16:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E361760FFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE404C0071;
	Thu,  6 Jul 2023 16:55:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D022C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17E6E40A98
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17E6E40A98
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IyMu8Csa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oz-gteQ9c49f
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 651F9401A4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 651F9401A4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7EFslApvIMhSEz1WUIyVbtwIYD8kB8bBcKW8IzvGEk=;
 b=IyMu8CsaEBttKaaH1CTPXRpPmhR4AiFztvBvNBk15TWXX6wlt7L8D6nd7FYYtBlDN0aL/L
 r1o1FWvRENQhtbKGMJAoIruAojS8QxnZM8GQSkyPoyMF9YjJVbWVTO0z4b03Rb84FVzJq7
 n4Mpp+v2mGskFDchFTiPURYJ4X2VrPA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-XWh1gkjTPJqLAWc9g_tfrA-1; Thu, 06 Jul 2023 12:55:47 -0400
X-MC-Unique: XWh1gkjTPJqLAWc9g_tfrA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-98e1085308eso244189666b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662546; x=1691254546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7EFslApvIMhSEz1WUIyVbtwIYD8kB8bBcKW8IzvGEk=;
 b=ic3/lY7oXRFVatPrgDAiTGQjb+R+75NoUdxMRXbUoWHYETdV493DHl+K6mmnMOECu/
 DhgAE8YYWKjyC8jBgODwXvWHDZ8vpu9+dpy6c4NNp3PeZ6gEi54L6GDmuAJL7B0VllKl
 /86i+Y2hyY1jKAYm4HNunObnN7vlzmpQbYRDG5PwQM3wB3suaB0KZi439MJfzZSQ6jAU
 OjtJBre7mfvJ8zkGuI642wnZxWgDQL2GxfsNpX5QP/i2e83u3KJRBN3Bl7LcQBLP6MZe
 IO/7tN0CXLxwkdsF4eXpyHwMw4agzcOAFk2fcFqx4Q4bNgNf2n0Hb92ysHXNNa3ozbS0
 8pSw==
X-Gm-Message-State: ABy/qLYBdcJ6RCzpv+PKCWm020tnRF/mZLpPYkPD0jq/Om8nzZPahN4H
 CUGbEA9ocFAKk0iVICti3Z5bTiiLMjCRDce/L8hHcIuhIX9onB/dhN/yTEb9HMeXNtjySQ5Z3gY
 KV2joUQReVyWg5vfRnNtVvVQxLbOdWbyt6t2jqjeKBQ==
X-Received: by 2002:a17:906:2d6:b0:993:b238:314 with SMTP id
 22-20020a17090602d600b00993b2380314mr2600089ejk.38.1688662546153; 
 Thu, 06 Jul 2023 09:55:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFGg/FURu/KpBWldonp5cKBo2TqmSR+9W2fAH24sb2tpeMexZDCIz1vdjUXF4DUou9tWLwsog==
X-Received: by 2002:a17:906:2d6:b0:993:b238:314 with SMTP id
 22-20020a17090602d600b00993b2380314mr2600069ejk.38.1688662545830; 
 Thu, 06 Jul 2023 09:55:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 h20-20020a170906719400b0099290e2c163sm1041264ejk.204.2023.07.06.09.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:55:45 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:55:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 11/17] vsock/virtio: support MSG_ZEROCOPY for
 transport
Message-ID: <tx4i6pikd6k2lejpukxsf2auodldrsciic2xu23r66dnt3ozzm@7k7nw22ek5iv>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-12-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-12-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:41AM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for virtio transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Move 'msgzerocopy_allow' right after seqpacket callbacks.
>
> net/vmw_vsock/virtio_transport.c | 7 +++++++
> 1 file changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 6cbb45bb12d2..8d3e9f441fa1 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -441,6 +441,11 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
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
>@@ -474,6 +479,8 @@ static struct virtio_transport virtio_transport = {
> 		.seqpacket_allow          = virtio_transport_seqpacket_allow,
> 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>
>+		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
