Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98527C54EBD
	for <virtualization@archiver.kernel.org>; Mon,  9 Jan 2023 09:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1962B81B69;
	Mon,  9 Jan 2023 09:17:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1962B81B69
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NYAe5+dm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ll97DFbXk5P; Mon,  9 Jan 2023 09:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E6AA81B60;
	Mon,  9 Jan 2023 09:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E6AA81B60
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32D7CC0032;
	Mon,  9 Jan 2023 09:17:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9359AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B0304056F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B0304056F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NYAe5+dm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id upKye78v_8hx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:17:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C45140144
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C45140144
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673255840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=25BMe6/yueYnQUVqJo+FFVWhclGca3esmjGYXD2LPpE=;
 b=NYAe5+dmOaGEfo927uxVc4BiN+MX3Po59rPgfk5rbO6imT8zKuHijLomm9tkIU/9jBOD+W
 HOQxtVEqmYM/Cw9lK6uEXHk8EXAKBIQr1aLpj7gIUNJpEkzXgWudwNfg7UZ5Q7Hi9KTojI
 wlf7Y+eo75OlQNipJiTwDHOJc+CRzKM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-340-2BUrpWi4PRCG7WNukgVbGg-1; Mon, 09 Jan 2023 04:17:18 -0500
X-MC-Unique: 2BUrpWi4PRCG7WNukgVbGg-1
Received: by mail-ot1-f70.google.com with SMTP id
 bq2-20020a056830388200b00672e4a07168so4119102otb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Jan 2023 01:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25BMe6/yueYnQUVqJo+FFVWhclGca3esmjGYXD2LPpE=;
 b=qtryJDaGxzq1Q0CIo6ggN6GIWZR5M/faNRmfI6su2GH6ZL9Rk22FtvOXJSwanD4WNa
 NoxMQcPf2e1T1JdE7EJwPdq9X7GUVHiNddpsOlW/3+V5eK+gPS/rYl9AEEjn5pbZSo8B
 k+Y9da4vxt3qIRS3s4xRgtgGLYTkgm07xvwCKiGbTGGwIPWfexGazFIBOzzOqlZkhiVI
 4FaXgmQ4qEZrO1Kgm+FLHOn9mUhYBWpIG88CWe/bkSxyBXKrKPJtkSrcruxEcbPx3gJK
 N5L6pbi3Q0Om8BXDpJ3f/NI68XgU4nxhydWTNn7imwuuNzc1x7AuuawdvAYkGA3PlZ9B
 ZlBg==
X-Gm-Message-State: AFqh2kpj/yZkz4iQ4CiUWd4OmjNZZvMICEWaS2bKYYvK16LYBHbK0Jqv
 tYan55mfkcNpvUgjwKmpi9YLLcgzCbEtfX35w5O3k7w5E/vB4L61LLN5WUMSPqGoRKE9pwnRXYr
 CidyYMmATdz2U4Wu5PGhTgcKB6KF4myzN9Nym1az7W0uAWatqY0ZYDfRKbg==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr3402514oah.35.1673255838110; 
 Mon, 09 Jan 2023 01:17:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVc7FkrBVh4eyyu8ylFzm+tvjw2olQNRGzYMHDAoSv2FvHTacfyMd4VFo7/SzjZzra83iQY8953Dy5c5UFkF0=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr3402505oah.35.1673255837859; Mon, 09
 Jan 2023 01:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20230104042519.170-1-longpeng2@huawei.com>
 <20230104014642-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230104014642-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Jan 2023 17:17:06 +0800
Message-ID: <CACGkMEubj2n6oWbgAg_=+b-QC_ApQzSyTJd8ZvANnuKoFMurtA@mail.gmail.com>
Subject: Re: [PATCH v3] vp_vdpa: harden the logic of set status
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, yechuan@huawei.com, huangzhichao@huawei.com,
 "Longpeng\(Mike\)" <longpeng2@huawei.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jan 4, 2023 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 04, 2023 at 12:25:19PM +0800, Longpeng(Mike) wrote:
> > From: Longpeng <longpeng2@huawei.com>
> >
> > 1. We should not set status to 0 when invoking vp_vdpa_set_status(),
> >    trigger a warning in that case.
> >
> > 2. The driver MUST wait for a read of device_status to return 0 before
> >    reinitializing the device. But we also don't want to keep us in an
> >    infinite loop forever, so wait for 5s if we try to reset the device.
> >
> > Signed-off-by: Longpeng <longpeng2@huawei.com>
> > ---
> > Changes v3->v2:
> >  - move VP_VDPA_RESET_TIMEOUT_US near the other macros. [Stefano]
> >  - refer v1.2 in comments. [Stefano]
> >  - s/keep/keeping/  [Jason]
> >  - use readx_poll_timeout. [Jason]
> >
> > Changes v1->v2:
> >  - use WARN_ON instead of BUG_ON. [Stefano]
> >  - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
> >  - use usleep_range instead of msleep (checkpatch). [Longpeng]
> >
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index d448db0c4de3..3fc496aea456 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -10,6 +10,7 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/pci.h>
> >  #include <linux/vdpa.h>
> >  #include <linux/virtio.h>
> > @@ -22,6 +23,7 @@
> >  #define VP_VDPA_QUEUE_MAX 256
> >  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> >  #define VP_VDPA_NAME_SIZE 256
> > +#define VP_VDPA_RESET_TIMEOUT_US 5000000 /* 5s */
> >
> >  struct vp_vring {
> >       void __iomem *notify;
> > @@ -214,6 +216,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> >       struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> >       u8 s = vp_vdpa_get_status(vdpa);
> >
> > +     /* We should never be setting status to 0. */
> > +     WARN_ON(status == 0);
> > +
> >       if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> >           !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> >               vp_vdpa_request_irq(vp_vdpa);
>
> Isn't this user-triggerable? What prevents that?

I think it's this in vhost_vdpa_set_status()

    if (status == 0) {
                ret = vdpa_reset(vdpa);
                if (ret)
                        return ret;

The reset was factored out to dedicated config ops.

>
> > @@ -226,10 +231,25 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
> >  {
> >       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> >       struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> > -     u8 s = vp_vdpa_get_status(vdpa);
> > +     u8 tmp, s = vp_vdpa_get_status(vdpa);
> > +     int ret;
> >
> >       vp_modern_set_status(mdev, 0);
> >
> > +     /*
> > +      * As the virtio v1.1/v1.2 spec (4.1.4.3.2) says: After writing 0 to
> > +      * device_status, the driver MUST wait for a read of device_status
> > +      * to return 0 before reinitializing the device.
> > +      * To avoid keeping us here forever, we only wait for 5 seconds.
> > +      */

5 second might not be sufficient see the discussion about sleep
instead of poll for cvq[1]

> > +     ret = readx_poll_timeout(vp_ioread8, &mdev->common->device_status, tmp,
> > +                              tmp == 0, 1000, VP_VDPA_RESET_TIMEOUT_US);
> > +     if (ret) {
> > +             dev_err(&mdev->pci_dev->dev,
> > +                     "vp_vdpa: fail to reset device, %d\n", ret);
> > +             return ret;
> > +     }
> > +
> >       if (s & VIRTIO_CONFIG_S_DRIVER_OK)
> >               vp_vdpa_free_irq(vp_vdpa);
>
> Do all callers actually check return status of reset?
> If not they will happily reinitialize the device and violate the spec.

Can we simply:

1) start with a very long timeout 1minutes etc
2) break the device when timeout?

Thanks

[1] https://www.spinics.net/lists/netdev/msg869953.html

>
>
>
> > --
> > 2.23.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
