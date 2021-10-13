Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC0C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:34:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D9E610D0
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97D9E610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6544A80CE1;
	Wed, 13 Oct 2021 12:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B4afCYvqlRDv; Wed, 13 Oct 2021 12:34:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B0AB80CD6;
	Wed, 13 Oct 2021 12:34:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D55A7C000F;
	Wed, 13 Oct 2021 12:34:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B527C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AE99406CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:34:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LTG9N7P7b7fK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:34:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76E35406CC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634128450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d84AXMduXw/8Km/NIT8YUkLd6M81nYmWKKr313pRpIo=;
 b=YEj/7fc64EDjMrfv9AUNg/tapWeM1dsijQktvQnlxz+XVlcXcj5VuOlT7PpR8VLvCQPo1T
 WySw3YYrlvfniNoGOFTk44yreR9l1QFlD2UVS0myxofj6b/HQ7PZdsHLbNvPR+VZMHJ096
 5A7YPpqjKAjcGn5MlOveiASJ+DN7Xm8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-pUVNQV88M3KbglbKYGGQtw-1; Wed, 13 Oct 2021 08:34:09 -0400
X-MC-Unique: pUVNQV88M3KbglbKYGGQtw-1
Received: by mail-wr1-f69.google.com with SMTP id
 r16-20020adfb1d0000000b00160bf8972ceso1845646wra.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d84AXMduXw/8Km/NIT8YUkLd6M81nYmWKKr313pRpIo=;
 b=TqwgDfwwnjp/KPVkNcEl1hOZHWKVOLfolnxNzs9jxuRKWp5cofCs++cOsOPM38Weki
 KlQ9R+hg4hU6ItdhQB6pPWd3m3/90Kbz4EwizcoKuZ747KccUZyFCPV1OyE5ztJrlYL8
 8ZMeqA6/jRbdmR7b7qpBtNweX+Vf/z4oA2UR2ze0oY91WncRxahHjUhgxXtBLNue6Zdz
 s4MMGuCGme8q7rV4Gi5vVY9fvy1YVcUz7ys/n1FVni+6hL6GS/LkvYsghun/E2lHE78w
 eyGqyeAAcF7/mmV0mKjC0TSH/J0NRZUIRVGVamjdtakRUBPrDSzI6vutKYwQjrKAoypu
 6HVw==
X-Gm-Message-State: AOAM532Zu303REWTGrUKbV7tYVPfLA/cQHsWcx+gV6LxLgFYqKy1qnrJ
 WSq4gu2e405t/js1ewLBBWdeKNtpvMAb9HutjRTd7uGGFnTAtBrR28h1MwaFIKfR0D6ndNA0WoA
 /1oC0Vq0DnddqcpqwzZ8aBs8sMiP32kv1lxzNl1az+g==
X-Received: by 2002:a1c:2904:: with SMTP id p4mr12662216wmp.49.1634128448214; 
 Wed, 13 Oct 2021 05:34:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8n9NAMz+t0x8zBkvT5LDu1f5qH1sDQrMJVOCWJVJRE/i4NTl67BMompop8PD/BnqoRi241Q==
X-Received: by 2002:a1c:2904:: with SMTP id p4mr12662190wmp.49.1634128447989; 
 Wed, 13 Oct 2021 05:34:07 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id z5sm6484694wmp.26.2021.10.13.05.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:34:07 -0700 (PDT)
Date: Wed, 13 Oct 2021 08:34:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] vduse: Fix race condition between resetting and irq
 injecting
Message-ID: <20211013083335-mutt-send-email-mst@kernel.org>
References: <20210929083050.88-1-xieyongji@bytedance.com>
 <20211013070657-mutt-send-email-mst@kernel.org>
 <CACycT3tSP-Vxt_u+ow71ZzxBjKuGycZ1LqUrbjQ6Ew3ehX7kqw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3tSP-Vxt_u+ow71ZzxBjKuGycZ1LqUrbjQ6Ew3ehX7kqw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Oct 13, 2021 at 08:30:40PM +0800, Yongji Xie wrote:
> On Wed, Oct 13, 2021 at 7:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 29, 2021 at 04:30:50PM +0800, Xie Yongji wrote:
> > > The interrupt might be triggered after a reset since there is
> > > no synchronization between resetting and irq injecting.
> >
> > In fact, irq_lock is already used to synchronize with
> > irqs. Why isn't taking and releasing it enough?
> >
> 
> For example:
> 
> CPU 0
>                   CPU1
> ---------
>                       --------
> vduse_dev_ioctl()
>   check DRIVER_OK
> 
>                         vduse_dev_reset()
> 
>                           flush_work(&vq->inject);
>     queue_work(vduse_irq_wq, &vq->inject);
> 
>                         virtio_vdpa_probe()
> 
>                           virtio_vdpa_find_vqs()
>    vduse_vq_irq_inject()
>      vq->cb.callback(vq->cb.private);
> 
>                         set DRIVER_OK
> 
> In the above case, the irq callback is still triggered before DRIVER_OK is set.
> 
> But now I found it seems to be better to just check DRIVER_OK again in
> vduse_vq_irq_inject().

And then pesumably make sure each time we set status
it's done under the irq lock?

> > > And it
> > > might break something if the interrupt is delayed until a new
> > > round of device initialization.
> > >
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 37 +++++++++++++++++++++++++------------
> > >  1 file changed, 25 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index cefb301b2ee4..841667a896dd 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -80,6 +80,7 @@ struct vduse_dev {
> > >       struct vdpa_callback config_cb;
> > >       struct work_struct inject;
> > >       spinlock_t irq_lock;
> > > +     struct rw_semaphore rwsem;
> > >       int minor;
> > >       bool broken;
> > >       bool connected;
> >
> > What does this lock protect? Use a more descriptive name pls,
> > and maybe add a comment.
> >
> 
> This lock is used to ensure there is no more inflight irq kwork after reset.
> 
> >
> > > @@ -410,6 +411,8 @@ static void vduse_dev_reset(struct vduse_dev *dev)
> > >       if (domain->bounce_map)
> > >               vduse_domain_reset_bounce_map(domain);
> > >
> > > +     down_write(&dev->rwsem);
> > > +
> > >       dev->status = 0;
> > >       dev->driver_features = 0;
> > >       dev->generation++;
> > > @@ -443,6 +446,8 @@ static void vduse_dev_reset(struct vduse_dev *dev)
> > >               flush_work(&vq->inject);
> > >               flush_work(&vq->kick);
> > >       }
> > > +
> > > +     up_write(&dev->rwsem);
> > >  }
> > >
> > >  static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
> > > @@ -885,6 +890,23 @@ static void vduse_vq_irq_inject(struct work_struct *work)
> > >       spin_unlock_irq(&vq->irq_lock);
> > >  }
> > >
> > > +static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > > +                                 struct work_struct *irq_work)
> > > +{
> > > +     int ret = -EINVAL;
> > > +
> > > +     down_read(&dev->rwsem);
> > > +     if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +             goto unlock;
> > > +
> > > +     ret = 0;
> > > +     queue_work(vduse_irq_wq, irq_work);
> > > +unlock:
> > > +     up_read(&dev->rwsem);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >                           unsigned long arg)
> > >  {
> >
> >
> > so that's a lot of overhead for an irq.
> > Normally the way to address races like this is to add
> > flushing to the reset path, not locking to irq path.
> >
> 
> Yes, we already call flush_work() in the reset path.
> 
> Thanks,
> Yongji

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
