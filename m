Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1422C352A1
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 11:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4351081E64;
	Tue,  6 Dec 2022 11:01:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4351081E64
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OuN0bGKR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlhQdrHx1_0y; Tue,  6 Dec 2022 11:00:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC548813FA;
	Tue,  6 Dec 2022 11:00:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC548813FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96768C0033;
	Tue,  6 Dec 2022 11:00:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B964CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 11:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 853AE41725
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 11:00:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 853AE41725
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OuN0bGKR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CDP_ynl9bVYA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 11:00:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5437941720
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5437941720
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670324455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nnhqMeUW5gkAJH3i2M2e0zkZdF9yQL6BjlLwXPeq/ho=;
 b=OuN0bGKRm/+ut9t5sF7TS1aN7ZZRkWWzV35MtWnZgDHT3ZjeCf/85u8P79nlJH12OEuakE
 1la6Nz/8gs6T92XCgKdRNeJQ+0I1tcX+81QTCieuDzbckvqBrKj50J6GrBc1RXX4W++sYy
 nMdT1b7dx7s7Jw8idNkbGqUI6a+58wQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-362-i2n_PAKQObSQyuWtr0G_lQ-1; Tue, 06 Dec 2022 06:00:54 -0500
X-MC-Unique: i2n_PAKQObSQyuWtr0G_lQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 j13-20020a05620a410d00b006e08208eb31so20442548qko.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Dec 2022 03:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nnhqMeUW5gkAJH3i2M2e0zkZdF9yQL6BjlLwXPeq/ho=;
 b=rAXYJHMwYkBLy3t9+kReBVy5U99HWunO21buhvagYfy7IBUzczm7CpEoKWzyoju1n6
 cfJ4nZyRkVfUybNXHtJvVvXhafsyv6+OCFvg/DWz5DeGFeo7YlrtFlxqxLDVysfsGBdm
 VCnW2ejASHxc+rB/PVSK+CKnlF/VWQVv3St28KmrLJ9nbILB1eIgc7dV97hlYtpXdqdb
 EcGN2a3emZODqTX8h6JUW2r0gGDn8Pw7jG9WIaQARgl6kKpOBGkkJmqotI00eMIIQA6B
 1NHOjemeReF9ff3zxSJjca8bn1i/o4aaQya8rLNYtRwgmaym2dphWsBzzNbgNjDo/eMi
 unFg==
X-Gm-Message-State: ANoB5pl0q76qJ9rjeMGbZZTYghFruUqu5q6oRikdaqeGlMkAaZYBf2et
 BJ+5OO8IXFa6X3V0VifHxuyxcbmIT1VLuQCzAvG6nrjPlRg/N6+dsqEexNsa1mFlNUxue0H7UcX
 nXmhXuLPCP00RlRPlgOFiLaPR1EXqu8ukVEx23aSA5w==
X-Received: by 2002:a05:6214:170d:b0:4c7:4add:6123 with SMTP id
 db13-20020a056214170d00b004c74add6123mr14971768qvb.100.1670324453406; 
 Tue, 06 Dec 2022 03:00:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6O4cvnwiNG/1UoAXIkBQIklV5lMHMzKytVq4RHoVXR9XHDwZ6NxwUPqwnijsvhRUZGuVdF0g==
X-Received: by 2002:a05:6214:170d:b0:4c7:4add:6123 with SMTP id
 db13-20020a056214170d00b004c74add6123mr14971755qvb.100.1670324453175; 
 Tue, 06 Dec 2022 03:00:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 dm12-20020a05620a1d4c00b006fb11eee465sm14082021qkb.64.2022.12.06.03.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Dec 2022 03:00:52 -0800 (PST)
Date: Tue, 6 Dec 2022 12:00:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH v2] vp_vdpa: harden the logic of set status
Message-ID: <20221206110040.q5i2k7ypojuira2e@sgarzare-redhat>
References: <20221206021321.2400-1-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221206021321.2400-1-longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, eperezma@redhat.com, huangzhichao@huawei.com,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Tue, Dec 06, 2022 at 10:13:21AM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>1. We should not set status to 0 when invoking vp_vdpa_set_status(),
>   trigger a warning in that case.
>
>2. The driver MUST wait for a read of device_status to return 0 before
>   reinitializing the device. But we also don't want to keep us in an
>   infinite loop forever, so wait for 5s if we try to reset the device.
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
>Changes v1->v2:
>  - use WARN_ON instead of BUG_ON. [Stefano]
>  - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
>  - use usleep_range instead of msleep (checkpatch). [Longpeng]
>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index 13701c2a1963..a2d3b13ac646 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -214,6 +214,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> 	u8 s = vp_vdpa_get_status(vdpa);
>
>+	/* We should never be setting status to 0. */
>+	WARN_ON(status == 0);
>+
> 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> 		vp_vdpa_request_irq(vp_vdpa);
>@@ -222,14 +225,33 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> 	vp_modern_set_status(mdev, status);
> }
>
>+#define VP_VDPA_RESET_TMOUT_MS 5000 /* 5s */

What about moving this define on top of this file?
Near the other macro.

And I would use TIMEOUT entirely.

>+
> static int vp_vdpa_reset(struct vdpa_device *vdpa, bool clear)
> {
> 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> 	u8 s = vp_vdpa_get_status(vdpa);
>+	unsigned long timeout;
>
> 	vp_modern_set_status(mdev, 0);
>
>+	/*
>+	 * As the virtio v1.1 spec (4.1.4.3.2) says: After writing 0 to

I think we can refer to the lates v1.2 (the section should be the same).

>+	 * device_status, the driver MUST wait for a read of device_status
>+	 * to return 0 before reinitializing the device.
>+	 * To avoid keep us here forever, we only wait for 5 seconds.
>+	 */
>+	timeout = jiffies + msecs_to_jiffies(VP_VDPA_RESET_TMOUT_MS);
>+	while (vp_modern_get_status(mdev)) {
>+		usleep_range(1000, 1500);
>+		if (time_after(jiffies, timeout)) {
>+			dev_err(&mdev->pci_dev->dev,
>+				"vp_vdpa: fail to reset device\n");
>+			return -ETIMEDOUT;
>+		}
>+	}
>+
> 	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
> 		vp_vdpa_free_irq(vp_vdpa);
>
>-- 
>2.23.0
>

The rest LGTM!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
