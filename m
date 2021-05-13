Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38210C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 11:46:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3D06143D
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 11:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3D06143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89AF0843C5;
	Thu, 13 May 2021 11:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVDZeNs1Hrf9; Thu, 13 May 2021 11:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 289F383E2D;
	Thu, 13 May 2021 11:46:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02AD8C000E;
	Thu, 13 May 2021 11:46:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD241C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 11:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C60406070D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 11:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id crumAJi7toTH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 11:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42BEE6063E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620906350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MT3wo5NP4c6jdkY4rdnz2C8pxWgXXp6JkWRd1hEobAU=;
 b=g9lNaNobZgESD/ykD08L/iU8xz2b8kqaQaBv2qfrx+D2bpMbtHiVGX0jYC9VhdlfJyoeVT
 BujTGwMo5vym45isGIlVtbE4rdDDK6737gYuuXaRtYhDpzuYIxl5qbz7BiXkqeWl9ZToHT
 q1qGN1mNCfJjXuA9CEptGksD0nUXpr4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-hcXnEaeBP7KCrHMoOhaojg-1; Thu, 13 May 2021 07:45:48 -0400
X-MC-Unique: hcXnEaeBP7KCrHMoOhaojg-1
Received: by mail-ed1-f72.google.com with SMTP id
 y15-20020aa7d50f0000b02903885ee98723so14424203edq.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 04:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MT3wo5NP4c6jdkY4rdnz2C8pxWgXXp6JkWRd1hEobAU=;
 b=Bh0uQ/cGJAP8/lipnPfvAu2yGuRHb0CDHSY5Q5iMqGwhXQQJGNqoaO1Qsfw6sl+Yk/
 mZ4GR1A3wKs9E3fYFXqIHrP6WrI0Zx/hadn28P3IHdFQT/pruaTXL1HRQJ6RwPZtO4Jf
 mdzBPKksklxipczkyKer0njr06MHoHIlIVWkZd3supchfTJuqvddbbcEXlhp2bGLup0O
 leG4qYcO1FrsY2V2Ri+lrU1v0yymoNwtca6MQMMqwI1H57Lmao51Dlb5ZNuHau4JPtHj
 e5G5vd4hYkT7gL/NXMuyX/HIYh5crO5Q7uxxdGsH5Xv+tfmeyzsMiO/QncTH+Z+N2cpH
 Bg+Q==
X-Gm-Message-State: AOAM532SSaNDQOEIm4b70f2LQFLW64brgwg8/JIaqwMzSHCmgZvgKiq3
 uaNw6oy5i82zb4UVFOxNhtDwyHpYx3GKqWa2+y/2pUKbM0K9zu02cBerHf8Tpkvh+jNkQF19PIS
 djsoNDMMIQyRpLjBX4FE0bV/p0l+AfvaB9XI2PguLVA==
X-Received: by 2002:aa7:db90:: with SMTP id u16mr49671410edt.106.1620906347032; 
 Thu, 13 May 2021 04:45:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK9y97PFsnFtKG2m387tQ7wMAVv4mrXxkCxS1dn+cI2Zu3pe2nfVjZZrdViT0h2czbettl2g==
X-Received: by 2002:aa7:db90:: with SMTP id u16mr49671388edt.106.1620906346853; 
 Thu, 13 May 2021 04:45:46 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id f7sm1685809ejz.95.2021.05.13.04.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 04:45:46 -0700 (PDT)
Date: Thu, 13 May 2021 13:45:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 10/19] virtio/vsock: defines and constants for
 SEQPACKET
Message-ID: <20210513114543.hucvkhky3tlmvabl@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163508.3431890-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210508163508.3431890-1-arseny.krasnov@kaspersky.com>
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

On Sat, May 08, 2021 at 07:35:05PM +0300, Arseny Krasnov wrote:
>This adds set of defines and constants for SOCK_SEQPACKET
>support in vsock. Here is link to spec patch, which uses it:
>
>https://lists.oasis-open.org/archives/virtio-comment/202103/msg00069.html

Will you be submitting a new version?

>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/uapi/linux/virtio_vsock.h | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 1d57ed3d84d2..3dd3555b2740 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -38,6 +38,9 @@
> #include <linux/virtio_ids.h>
> #include <linux/virtio_config.h>
>
>+/* The feature bitmap for virtio vsock */
>+#define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>+
> struct virtio_vsock_config {
> 	__le64 guest_cid;
> } __attribute__((packed));
>@@ -65,6 +68,7 @@ struct virtio_vsock_hdr {
>
> enum virtio_vsock_type {
> 	VIRTIO_VSOCK_TYPE_STREAM = 1,
>+	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
> };
>
> enum virtio_vsock_op {
>@@ -91,4 +95,9 @@ enum virtio_vsock_shutdown {
> 	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
> };
>
>+/* VIRTIO_VSOCK_OP_RW flags values */
>+enum virtio_vsock_rw {
>+	VIRTIO_VSOCK_SEQ_EOR = 1,
>+};
>+
> #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
>-- 
>2.25.1
>

Looks good:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
