Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C80C4332F
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 15:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4083D8135F;
	Fri, 11 Nov 2022 15:15:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4083D8135F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PuDKI9vi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OmbWwAopzTvy; Fri, 11 Nov 2022 15:15:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95802813A5;
	Fri, 11 Nov 2022 15:15:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95802813A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41B45C0033;
	Fri, 11 Nov 2022 15:15:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE4D9C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 15:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAE4B60FD9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 15:15:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAE4B60FD9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PuDKI9vi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FwjOQdIJTkG1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 15:15:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D43B460FD8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D43B460FD8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668179712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFfjRSX6x+xXHoXLdolT6LJnuObdR7C+VEPrQ+OyqAA=;
 b=PuDKI9vinHA12koPLu+7olOnuPzMjThZtovRz8oOo5A33pvIm3qddwpTve8FGEcXG0o2/f
 n1CVkVkoX470JTKtvUY55mykOg0OmDNeDfVyOaZkPBsiObKiomAPZ+VuCNo8ZtLt093ARo
 BWz+jvL5AKEVGMOwffjxThHV+DSkKcE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-wyXYW-27O9eUZxDBGGkvRw-1; Fri, 11 Nov 2022 10:15:11 -0500
X-MC-Unique: wyXYW-27O9eUZxDBGGkvRw-1
Received: by mail-qt1-f199.google.com with SMTP id
 i4-20020ac813c4000000b003a5044a818cso3802694qtj.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 07:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFfjRSX6x+xXHoXLdolT6LJnuObdR7C+VEPrQ+OyqAA=;
 b=SWc1qml/0w6LmshYxtQL9hSjNkDG8KHJgSwPo42AZf4zj4J+sgaJUQR/DKaAHwXLNQ
 IkuJq6C+9M9gHjimCclEq6rqf5V8bz6OmwhPix+4ESL4riG3nmUiAW5RY6Eoz1qGcJlu
 BELB2hC9/234vBFmAg1UzyUUn6MCMhIXQ2I1b8dhwyUbELO+eNF+jV/6xXCTL9RyLT5W
 P+/IpoyzaPhq++2x38U/L2qO2zRz+zzxzxV6/+/xLswzG6hb0nRUshAcqgJc0hZ/SDYy
 8MODMJVdXy3isQ1J+/w0IVwze/D5k9Zd7e0j0Cl80NbW1IT+x24HzJcrTvJIahlSCa6G
 yV7g==
X-Gm-Message-State: ANoB5pmAbNCAlSBjSbhfotId/koobXat7D+Xfwc155IOZuyeFCLbYKL3
 EaRXRvd8ZzhqoByFS5YAgwwOzMql/9HiU4f4l+PZkdNSeM/LkWfHYnetfLhypZ9mUQYSI/pOKm6
 4SeHFX/jUP9iBIbXi+7R9Z8+9ei9KtxrN8YrPONaQ4g==
X-Received: by 2002:ae9:f815:0:b0:6fa:2b22:ff3e with SMTP id
 x21-20020ae9f815000000b006fa2b22ff3emr1360152qkh.200.1668179710678; 
 Fri, 11 Nov 2022 07:15:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7vYL/+fo+qZqe8owiSVEkcRSV/WH8SUV6pATe7L3qLNPu68l1cgYhGGZAQ62WVFvh21qKR/A==
X-Received: by 2002:ae9:f815:0:b0:6fa:2b22:ff3e with SMTP id
 x21-20020ae9f815000000b006fa2b22ff3emr1360121qkh.200.1668179710380; 
 Fri, 11 Nov 2022 07:15:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 ga16-20020a05622a591000b003a598fcddefsm1375111qtb.87.2022.11.11.07.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Nov 2022 07:15:09 -0800 (PST)
Date: Fri, 11 Nov 2022 16:14:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH] vp_vdpa: harden the logic of set status
Message-ID: <20221111151459.dyz42jclq26ai26q@sgarzare-redhat>
References: <20221111145505.1232-1-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221111145505.1232-1-longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xiehong@huawei.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Fri, Nov 11, 2022 at 10:55:05PM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>1. We should not set status to 0 when invoking vp_vdpa_set_status().
>
>2. The driver MUST wait for a read of device_status to return 0 before
>   reinitializing the device.
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index d448db0c4de3..d35fac5cde11 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -212,8 +212,12 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> {
> 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>-	u8 s = vp_vdpa_get_status(vdpa);

Is this change really needed?

>+	u8 s;
>+
>+	/* We should never be setting status to 0. */
>+	BUG_ON(status == 0);

IMHO panicking the kernel seems excessive in this case, please use 
WARN_ON and maybe return earlier.

>
>+	s = vp_vdpa_get_status(vdpa);
> 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> 		vp_vdpa_request_irq(vp_vdpa);
>@@ -229,6 +233,11 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
> 	u8 s = vp_vdpa_get_status(vdpa);
>
> 	vp_modern_set_status(mdev, 0);
>+	/* After writing 0 to device_status, the driver MUST wait for a read of
>+	 * device_status to return 0 before reinitializing the device.
>+	 */
>+	while (vp_modern_get_status(mdev))
>+		msleep(1);

Should we set a limit after which we give up? A malfunctioning device 
could keep us here forever.

Thanks,
Stefano

>
> 	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
> 		vp_vdpa_free_irq(vp_vdpa);
>-- 
>2.23.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
