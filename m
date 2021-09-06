Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88E9C433F5
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 08:01:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9890F61004
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 08:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9890F61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A01040339;
	Mon,  6 Sep 2021 08:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aYxSRoW2Jwep; Mon,  6 Sep 2021 08:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DABDD4032F;
	Mon,  6 Sep 2021 08:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA26C0023;
	Mon,  6 Sep 2021 08:01:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6639C001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 08:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E228940163
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 08:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dwv4d--trplp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 08:01:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BECE9400B9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630915266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NO6GFqxRcZJwYtn+Qe2gbxSZz+UC4dbKjNIIRf72XCk=;
 b=UuFqQ00Tm2KbrhirSrxPgY++m/Ew4rhyq7U+cUI5JrKAVmU31D6uQJEFQzGcB+mUK99jKB
 SaN/5T8yRSXswwKIsJmT/pRx6nS6tsAA32EYse4fgTjn7yV/B1T9YgamrBw+X0KoUi/YE9
 88lNIa2nP4yayQC08JhGnaTt1pg8RBc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-_eGlgFlLOCemZfM6vOOUqw-1; Mon, 06 Sep 2021 04:01:03 -0400
X-MC-Unique: _eGlgFlLOCemZfM6vOOUqw-1
Received: by mail-wm1-f72.google.com with SMTP id
 v2-20020a7bcb420000b02902e6b108fcf1so3575423wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Sep 2021 01:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NO6GFqxRcZJwYtn+Qe2gbxSZz+UC4dbKjNIIRf72XCk=;
 b=IG+UZQ6BvY5F0zmY0f8PdiZ3xx53Ra+hYX5mLd/njV1Mym3jzyNuHswapgmhh3aX95
 GE/40ZF4XiG9O4+kAzFyt553jBEmEGunSkupDJYvKfxulzuWCi8JDICgs9XuPDD04Va9
 /pPMvvKbcfV6KX2e1y7RRQbAX886L2X1qAYSdnxy1bnoVOVFrAMCAb8RQNShjzrmL2IQ
 cV7a6h5BBbFrRZYGoxkar3aRBXEtLUM1eMCJxaiXvQuSugO8CRE/e6E9I3yP3Jqzhk7B
 /a2bCbwW04eG6lK/sTlHpsT6JsOuT1pinjrKOfyDs5IdpiIyO9ZjkJRIg11EWyz/J0Nw
 rUWg==
X-Gm-Message-State: AOAM532jHDhnMkSL+nksC4ZrpXwqHxQuBm7h5PqtNzyxXsbwMpF258xV
 NGpIAaDIWEhj3PTuO3al7qsUY4gdv40zTAnxb2xAqE1iVEifc61rlsEyR6d3xUytJlnSXIBot46
 2NQzBWkZ4njnj01P96PZ8xuFfRfvo93fv1NQQfLKtSQ==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr10145306wmh.60.1630915262500; 
 Mon, 06 Sep 2021 01:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD0Y0QTVxlVRT+q0YtcHDYNCzcA75tKV0/AOdp2DwxYwSQKzP8ML7fq7xzKLKNz0GctS8Quw==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr10145288wmh.60.1630915262309; 
 Mon, 06 Sep 2021 01:01:02 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id e3sm6259897wrc.11.2021.09.06.01.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 01:01:01 -0700 (PDT)
Date: Mon, 6 Sep 2021 04:00:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v13 05/13] vdpa: Add reset callback in vdpa_config_ops
Message-ID: <20210906035338-mutt-send-email-mst@kernel.org>
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-6-xieyongji@bytedance.com>
 <20210906015524-mutt-send-email-mst@kernel.org>
 <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
 <20210906023131-mutt-send-email-mst@kernel.org>
 <CACycT3ssC1bhNzY9Pk=LPvKjMrFFavTfCKTJtR2XEiVYqDxT1Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3ssC1bhNzY9Pk=LPvKjMrFFavTfCKTJtR2XEiVYqDxT1Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 joro@8bytes.org, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, John Garry <john.garry@huawei.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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

On Mon, Sep 06, 2021 at 03:06:44PM +0800, Yongji Xie wrote:
> On Mon, Sep 6, 2021 at 2:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 06, 2021 at 02:09:25PM +0800, Yongji Xie wrote:
> > > On Mon, Sep 6, 2021 at 1:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 31, 2021 at 06:36:26PM +0800, Xie Yongji wrote:
> > > > > This adds a new callback to support device specific reset
> > > > > behavior. The vdpa bus driver will call the reset function
> > > > > instead of setting status to zero during resetting.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > >
> > > >
> > > > This does gloss over a significant change though:
> > > >
> > > >
> > > > > ---
> > > > > @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> > > > >       return vdev->dma_dev;
> > > > >  }
> > > > >
> > > > > -static inline void vdpa_reset(struct vdpa_device *vdev)
> > > > > +static inline int vdpa_reset(struct vdpa_device *vdev)
> > > > >  {
> > > > >       const struct vdpa_config_ops *ops = vdev->config;
> > > > >
> > > > >       vdev->features_valid = false;
> > > > > -     ops->set_status(vdev, 0);
> > > > > +     return ops->reset(vdev);
> > > > >  }
> > > > >
> > > > >  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > > >
> > > >
> > > > Unfortunately this breaks virtio_vdpa:
> > > >
> > > >
> > > > static void virtio_vdpa_reset(struct virtio_device *vdev)
> > > > {
> > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > >
> > > >         vdpa_reset(vdpa);
> > > > }
> > > >
> > > >
> > > > and there's no easy way to fix this, kernel can't recover
> > > > from a reset failure e.g. during driver unbind.
> > > >
> > >
> > > Yes, but it should be safe with the protection of software IOTLB even
> > > if the reset() fails during driver unbind.
> > >
> > > Thanks,
> > > Yongji
> >
> > Hmm. I don't see it.
> > What exactly will happen? What prevents device from poking at
> > memory after reset? Note that dma unmap in e.g. del_vqs happens
> > too late.
> 
> But I didn't see any problems with touching the memory for virtqueues.

Drivers make the assumption that after reset returns no new
buffers will be consumed. For example a bunch of drivers
call virtqueue_detach_unused_buf.
I can't say whether block makes this assumption anywhere.
Needs careful auditing.

> The memory should not be freed after dma unmap?

But unmap does not happen until after the reset.


> And the memory for the bounce buffer should also be safe to be
> accessed by userspace in this case.
> 
> > And what about e.g. interrupts?
> > E.g. we have this:
> >
> >         /* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
> >         vblk->vdev = NULL;
> >
> > and this is no longer true at this point.
> >
> 
> You're right. But I didn't see where the interrupt handler will use
> the vblk->vdev.

static void virtblk_done(struct virtqueue *vq)
{
        struct virtio_blk *vblk = vq->vdev->priv;

vq->vdev is the same as vblk->vdev.


> So it seems to be not too late to fix it:
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 5c25ff6483ad..ea41a7389a26 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -665,13 +665,13 @@ static void vduse_vdpa_set_config(struct
> vdpa_device *vdpa, unsigned int offset,
>  static int vduse_vdpa_reset(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +       int ret;
> 
> -       if (vduse_dev_set_status(dev, 0))
> -               return -EIO;
> +       ret = vduse_dev_set_status(dev, 0);
> 
>         vduse_dev_reset(dev);
> 
> -       return 0;
> +       return ret;
>  }
> 
>  static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> 
> Thanks,
> Yongji

Needs some comments to explain why it's done like this.

BTW device is generally wedged at this point right?
E.g. if reset during initialization fails, userspace
will still get the reset at some later point and be
confused ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
