Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4FDC4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 05:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07ADB40143;
	Thu, 10 Nov 2022 05:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07ADB40143
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ChxRo4Rs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2p-d_PkP6aV6; Thu, 10 Nov 2022 05:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 87314400E7;
	Thu, 10 Nov 2022 05:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87314400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48D5AC0032;
	Thu, 10 Nov 2022 05:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4086AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 05:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20F5760AE1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 05:20:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20F5760AE1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ChxRo4Rs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1o97t3UMY1vb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 05:20:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A988607FE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A988607FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 05:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668057599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u96povSyy2sjnCyKRqs1RgXf1LgZIt4bA4dxaS0z0zE=;
 b=ChxRo4RsUYh7v1trYIi5KB35MGFgnUZeGXqP/r/KQ0XvCwrl6zx3Vdg99hFftHhdcoeH9D
 gc0WTCpBmuPMICcCB0XapzSjWiJsX0n2jIzTl+1bFFgoF45UTikUURDYO4fw1aOTPTbIWc
 U9aMQS2PGuNGaXgzhOVKdvTpKBytC6g=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-xaGqrgW4MA-YaxpUoApK3Q-1; Thu, 10 Nov 2022 00:19:57 -0500
X-MC-Unique: xaGqrgW4MA-YaxpUoApK3Q-1
Received: by mail-oi1-f198.google.com with SMTP id
 c11-20020a056808138b00b0035a17dd854dso300869oiw.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 21:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u96povSyy2sjnCyKRqs1RgXf1LgZIt4bA4dxaS0z0zE=;
 b=hq3WOhFasDAoelNVBc75r5j4VRWyeLnsnZLbQng/idVNtI/tj8echbj3sfkaurngM0
 D8UHf2XKcrBw6cUdZUHfz2I5XyrVlFSqc6lQt1QijadfudjKA5zkEynzXAv7422nhgBF
 WtKTHZ7xJKFVk5bWg9+8jNwMqv3Y9NSWPDGRFphBh94Hvo4brh5CoPv5R4nHKRwjcb9m
 bG5XiDUVRsZnW/1I7ulcuPmyhWCo5T+Wqt/6WUa8RhJVZy/LozWu+QilC17T9PSb8swC
 YZOSqzbox6qAbvDqfmdR6YdjVi+nAL/9C3G8nh7dPJfy9VTyTetgy54NYUTbA0RPKKnO
 uGAA==
X-Gm-Message-State: ACrzQf15cRPjkRan9m4ZwnplnSYUs4M1zrGmSZ84b+Y2WbNkomFqBgu+
 PZ5n+Z6pEwQQdLJ7s4m/hFS5+16IdKRr4CWjI9q8ITOLrtbpWQKeMvhbJJibHK6Dt9FsQDPhaBp
 wnit4xt5cifoMw3V4BlMCJbI+yUBMSIaSn1lwDP0JS8ipPYyv739DnEPd+g==
X-Received: by 2002:a9d:604f:0:b0:66c:64d6:1bb4 with SMTP id
 v15-20020a9d604f000000b0066c64d61bb4mr1101194otj.201.1668057597228; 
 Wed, 09 Nov 2022 21:19:57 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4tuNP7BSB9zdQWeAKCzstnEdGCPMlhRznQ9ZOEaMVRUjE1XOzntcNKT6xzKnDAKkwAAV+02rcn5e/H1U1+DX0=
X-Received: by 2002:a9d:604f:0:b0:66c:64d6:1bb4 with SMTP id
 v15-20020a9d604f000000b0066c64d61bb4mr1101189otj.201.1668057597016; Wed, 09
 Nov 2022 21:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
 <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
 <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20221110000433-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221110000433-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Nov 2022 13:19:45 +0800
Message-ID: <CACGkMEsc79Q+Sqbsxyqb2xhNHcQrphgdTh=QLS6zre3wfFwwNw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
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

On Thu, Nov 10, 2022 at 1:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 10, 2022 at 03:30:59AM +0000, Angus Chen wrote:
> > Hi Jason.
> >
> > > -----Original Message-----
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Wednesday, November 2, 2022 1:34 PM
> > > To: Angus Chen <angus.chen@jaguarmicro.com>
> > > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > > linux-kernel@vger.kernel.org; lingshan.zhu@intel.com
> > > Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
> > >
> > > On Tue, Nov 1, 2022 at 7:17 PM Angus Chen <angus.chen@jaguarmicro.com>
> > > wrote:
> > > >
> > > > Virtio_crypto use max_data_queues+1 to setup vqs,
> > > > we use vp_modern_get_num_queues to protect the vq range in setup_vq.
> > > > We could enter index >= vp_modern_get_num_queues(mdev) in setup_vq
> > > > if common->num_queues is not set well,and it return -ENOENT.
> > > > It is better to use -EINVAL instead.
> > >
> > > I'm not sure I get this. It would be better to describe:
> > >
> > > 1) what kind of issues can we see if we return -ENOENT
> > > 2) why -EINVAL can help in this case
> > >
> > > Thanks
> > Thank you for your reply.
> > We use a robot to test our dpu to get the return value of probe.
> >  We often get ENOENT form ' setup_vq ' function because of device error.
> > Most of time, my device can't handle queue_enable well.
> > This time,we get 'ENOENT' because the device set max_data_queues bigger than num_queues.
> >
> > I think EINVAL is used when the value of some parameter is wrong.
>
> I think I agree. Jason?

I'm fine with this then.

Thanks

>
> > Btw,it not a big deal,I can modify the robot to workaround.
> >
> > >
> > > >
> > > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci_modern.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_pci_modern.c
> > > b/drivers/virtio/virtio_pci_modern.c
> > > > index c3b9f2761849..edf2e18014cd 100644
> > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > @@ -303,7 +303,7 @@ static struct virtqueue *setup_vq(struct
> > > virtio_pci_device *vp_dev,
> > > >         int err;
> > > >
> > > >         if (index >= vp_modern_get_num_queues(mdev))
> > > > -               return ERR_PTR(-ENOENT);
> > > > +               return ERR_PTR(-EINVAL);
> > > >
> > > >         /* Check if queue is either not available or already active. */
> > > >         num = vp_modern_get_queue_size(mdev, index);
> > > > --
> > > > 2.25.1
> > > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
