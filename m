Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9B5C3A5A7
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 06:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6031040441;
	Tue,  6 Dec 2022 06:49:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6031040441
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TKRUNXF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gq-M9KH-aJ5B; Tue,  6 Dec 2022 06:49:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DCA5940124;
	Tue,  6 Dec 2022 06:49:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCA5940124
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97852C0033;
	Tue,  6 Dec 2022 06:49:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31F3BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 06:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12F3140221
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 06:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12F3140221
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TKRUNXF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WGZvJC9SEFWB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 06:49:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F12F40206
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F12F40206
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 06:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670309385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7QRyJRGQed93e2oV6hVf2UMdunRy1tEcmm8rpx7XzZU=;
 b=TKRUNXF67eD5QHn0SiQ7pPeDF54VUmpwIDu8BofZLJtK8DBPf+Vj64vXk7+jK396lK0qip
 36OrQNrzP41QBNfk7AqtGvITrvqglkEuW3Ov46SUBWQcR87oGjWvu800IGd7EYhhekOmXZ
 HOrsAgDAaJwLgKeOnB/kF3qrJWtRwA8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-3AkZDRrVOAWyNME5wLdeAQ-1; Tue, 06 Dec 2022 01:49:41 -0500
X-MC-Unique: 3AkZDRrVOAWyNME5wLdeAQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 l5-20020a9d7a85000000b0066ec7926f9cso2566880otn.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 22:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7QRyJRGQed93e2oV6hVf2UMdunRy1tEcmm8rpx7XzZU=;
 b=MQPoD8pr7S3fOaaOaWNWIiXd3P8b1gwnVBQh8LIPRDjflBcpskCFNAUN7kNfA2Lte5
 Om5/Dzvo5fpiVQlh/hqLOMNQ3ni8z3dibn/SO6qzvvmX2AsqmV8rM6ZNF3LVB2orfBvW
 +/q92Ojhs1sM4zROd29DBLGtZG5QkzPmXrNIymNOt0wXYJoHVR/jL0SZtCvRbob/kmXw
 NJyhcYaCvGZgjQeUqotZe+YnrXxd/uLc7WKtKzzx0MHI5Tik+dsUdqCJZByT/Ti+vEFC
 Om1JveguNvAIeDq2M9JNfSMMfMNZQsgbZNAZl6v7h/Zp2Hor+wIhix6VFYH4geis6UPy
 MRFw==
X-Gm-Message-State: ANoB5pkzCnmjkrhcByzaCh53Joml0xtfS0rFyLeo8N7eoh7yfZEvIOW1
 FOyuL2wxMZ5DyKR1TBsyoBNsoqtuldxZDw4ZFYH+fYgPku+fayD2osWcZ0RYOhyH6ZrmwWtupln
 gjYKAKmMN7mUjnuka7FtJoKG70sS04W/95AeUblStS90Qm/japfRCF46Hug==
X-Received: by 2002:aca:1a12:0:b0:35c:303d:fe37 with SMTP id
 a18-20020aca1a12000000b0035c303dfe37mr4109210oia.35.1670309381036; 
 Mon, 05 Dec 2022 22:49:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7urHFr1rQgu43Jv9t4mhvIUwJQg2Mtgyn1pJiXbECS3dwGfV2OghH/gQ+LHnS49/OMVb20eZKwEEwoRHHncto=
X-Received: by 2002:aca:1a12:0:b0:35c:303d:fe37 with SMTP id
 a18-20020aca1a12000000b0035c303dfe37mr4109200oia.35.1670309380861; Mon, 05
 Dec 2022 22:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20221206021321.2400-1-longpeng2@huawei.com>
In-Reply-To: <20221206021321.2400-1-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Dec 2022 14:49:29 +0800
Message-ID: <CACGkMEtRw6Zk7BMNJOUPNsWquGof9vLiHRX8FovzpnE48unhXw@mail.gmail.com>
Subject: Re: [PATCH v2] vp_vdpa: harden the logic of set status
To: "Longpeng(Mike)" <longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Dec 6, 2022 at 10:13 AM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> 1. We should not set status to 0 when invoking vp_vdpa_set_status(),
>    trigger a warning in that case.
>
> 2. The driver MUST wait for a read of device_status to return 0 before
>    reinitializing the device. But we also don't want to keep us in an
>    infinite loop forever, so wait for 5s if we try to reset the device.
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
> Changes v1->v2:
>   - use WARN_ON instead of BUG_ON. [Stefano]
>   - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
>   - use usleep_range instead of msleep (checkpatch). [Longpeng]
>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 13701c2a1963..a2d3b13ac646 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -214,6 +214,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>         struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>         u8 s = vp_vdpa_get_status(vdpa);
>
> +       /* We should never be setting status to 0. */
> +       WARN_ON(status == 0);
> +
>         if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>             !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>                 vp_vdpa_request_irq(vp_vdpa);
> @@ -222,14 +225,33 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>         vp_modern_set_status(mdev, status);
>  }
>
> +#define VP_VDPA_RESET_TMOUT_MS 5000 /* 5s */
> +
>  static int vp_vdpa_reset(struct vdpa_device *vdpa, bool clear)
>  {
>         struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>         struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>         u8 s = vp_vdpa_get_status(vdpa);
> +       unsigned long timeout;
>
>         vp_modern_set_status(mdev, 0);
>
> +       /*
> +        * As the virtio v1.1 spec (4.1.4.3.2) says: After writing 0 to
> +        * device_status, the driver MUST wait for a read of device_status
> +        * to return 0 before reinitializing the device.
> +        * To avoid keep us here forever, we only wait for 5 seconds.

s/keep/keeping/

> +        */
> +       timeout = jiffies + msecs_to_jiffies(VP_VDPA_RESET_TMOUT_MS);
> +       while (vp_modern_get_status(mdev)) {
> +               usleep_range(1000, 1500);
> +               if (time_after(jiffies, timeout)) {
> +                       dev_err(&mdev->pci_dev->dev,
> +                               "vp_vdpa: fail to reset device\n");
> +                       return -ETIMEDOUT;
> +               }

Any chance to use readx_poll_timeout() here?

Thanks

> +       }
> +
>         if (s & VIRTIO_CONFIG_S_DRIVER_OK)
>                 vp_vdpa_free_irq(vp_vdpa);
>
> --
> 2.23.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
