Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA628DD8
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703618; cv=none; b=QxW12JogImGLHbVura5yrI9GBdeauZBPdQCmmEC3D4xYqyBTGb1bld2l1yuyCDADKyQyJtQyvVi8maGlg75ARqpabD5xU0UYJsq120ma/MD2bexoHppsR248d4Zy4g0SalcDLJTOG3J0mTpXHk0NaL8G25EDhPDNqVLma0S+OdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703618; c=relaxed/simple;
	bh=ZzOyyShpi+BiQtFAim7d9NqPxf08YSqXbBroJ+fc20s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nviWza2vl5TmGCFUjS5tnsQB1n7ZLx+VJ4HfZ/jnyTsOerCzy5jU3N9cXa+JnLDJ8ltjB3Hlq0F+MD9naI0FCHDMJ7Dbho6sd6kJ6BFOTzCADqlpnTSunDSV57TB5gOM2kJFAvfu54F27iAju7HuU3n1qJ5aq4oy0nBvHtQUpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blqDfH/M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blqDfH/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711703615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M29eATaMP812c87lcBCnQpGGf3JpvPt6m4mFibtAKn0=;
	b=blqDfH/Ma+dP0DjyNnvkXNDG9Ved7hWRvXiKbscYZbBUPjP5cDCDLT+hvOhe/YLlNJAbsM
	ZSLhpBYTVvgp2/cgOhWlC1SY9Fckz6fu0uWCkVMQImO1mKeuEgtforrWLVss2huXsaltqX
	zexBV1kxjTtRIcAeBVnGO+W15IdNG0k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-8NDIlJVqM5C_1tm2GMB1tg-1; Fri, 29 Mar 2024 05:13:33 -0400
X-MC-Unique: 8NDIlJVqM5C_1tm2GMB1tg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4147e733d20so8788295e9.1
        for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 02:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703612; x=1712308412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M29eATaMP812c87lcBCnQpGGf3JpvPt6m4mFibtAKn0=;
        b=VgbfUbUfl+ah2nW0HnG73O91Z/emmPgcdlN2GmGyaZ/zC0E20XfJ1Mqfk4+y+5lTcS
         0ZxcYw6rCkAQsLgQmEyUrP/SyiQV0f3H5Dq2qgYX50eU1mcx+KGSGV5fPsWoWUQohLT/
         D0iUphLRDlTUSmvROvloC3nEsM5Xyhgg1uGikEEujJUxvSQk/5CKhU7hCYr5TZjhisTr
         ULirQkAhZ4LQd4gJdu/T8TxVsn+//8cWJDiMFJaguFq/eZ7BV1/fjPou30QHX1xTtufT
         JT0DzjFQKHsvCZuhHwfbPlPBlvvFKhnuA8srMYLAS1AhEtXtKUeDxvpzFd4FLPLbOIxk
         vX1A==
X-Forwarded-Encrypted: i=1; AJvYcCWLLZUsVMSg6bhAyGwDHCxSvtCfNUqNuz3SvgQnKA4HKyGTaSiuT02X30TgJRABGR5I61HXOMOYDqW5P5k8jkCPAMt1CEgW9rijb6BpP5c=
X-Gm-Message-State: AOJu0YwPzUR5cB1ZW9lML8ndYXCYOAI6UV+KvOWklmqz6lp29w3lANML
	8kftaWdW4oWnwtIQcK4xcx9Z/C3K9z1b/XK+42oxBSQl2jkMFlV959vfTm0rKVZJzYWyutCqbw2
	OQ3iGfvtFJ1rne4baN4moJGjY4MANx5M/+E1PxHc9cKLvrBLAu4sqJxf3DP4HP8vTN3r+BeWs
X-Received: by 2002:a05:600c:5253:b0:413:f3f0:c591 with SMTP id fc19-20020a05600c525300b00413f3f0c591mr1643227wmb.41.1711703611682;
        Fri, 29 Mar 2024 02:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaT97DmM3XHKaPJzW87s7ILZ0Tic5EcrjSdHB6wE1GOPhFxPAb4mZrXHL6ciaT1JEf0Tu2eg==
X-Received: by 2002:a05:600c:5253:b0:413:f3f0:c591 with SMTP id fc19-20020a05600c525300b00413f3f0c591mr1643199wmb.41.1711703611093;
        Fri, 29 Mar 2024 02:13:31 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b004147b824b08sm4832088wmo.7.2024.03.29.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:13:30 -0700 (PDT)
Date: Fri, 29 Mar 2024 05:13:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20240329051117-mutt-send-email-mst@kernel.org>
References: <20240320101912.28210-1-w_angrong@163.com>
 <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 27, 2024 at 05:08:57PM +0800, Jason Wang wrote:
> On Thu, Mar 21, 2024 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > From: Rong Wang <w_angrong@163.com>
> > >
> > > Once enable iommu domain for one device, the MSI
> > > translation tables have to be there for software-managed MSI.
> > > Otherwise, platform with software-managed MSI without an
> > > irq bypass function, can not get a correct memory write event
> > > from pcie, will not get irqs.
> > > The solution is to obtain the MSI phy base address from
> > > iommu reserved region, and set it to iommu MSI cookie,
> > > then translation tables will be created while request irq.
> > >
> > > Change log
> > > ----------
> > >
> > > v1->v2:
> > > - add resv iotlb to avoid overlap mapping.
> > > v2->v3:
> > > - there is no need to export the iommu symbol anymore.
> > >
> > > Signed-off-by: Rong Wang <w_angrong@163.com>
> >
> > There's in interest to keep extending vhost iotlb -
> > we should just switch over to iommufd which supports
> > this already.
> 
> IOMMUFD is good but VFIO supports this before IOMMUFD.

You mean VFIO migrated to IOMMUFD but of course they keep supporting
their old UAPI? OK and point being?

> This patch
> makes vDPA run without a backporting of full IOMMUFD in the production
> environment. I think it's worth.

Where do we stop? saying no to features is the only tool maintainers
have to make cleanups happen, otherwise people will just keep piling
stuff up.

> If you worry about the extension, we can just use the vhost iotlb
> existing facility to do this.
> 
> Thanks
> 
> >
> > > ---
> > >  drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 56 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index ba52d128aeb7..28b56b10372b 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -49,6 +49,7 @@ struct vhost_vdpa {
> > >       struct completion completion;
> > >       struct vdpa_device *vdpa;
> > >       struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> > > +     struct vhost_iotlb resv_iotlb;
> > >       struct device dev;
> > >       struct cdev cdev;
> > >       atomic_t opened;
> > > @@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
> > >  static int vhost_vdpa_reset(struct vhost_vdpa *v)
> > >  {
> > >       v->in_batch = 0;
> > > +     vhost_iotlb_reset(&v->resv_iotlb);
> > >       return _compat_vdpa_reset(v);
> > >  }
> > >
> > > @@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> > >           msg->iova + msg->size - 1 > v->range.last)
> > >               return -EINVAL;
> > >
> > > +     if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> > > +                                     msg->iova + msg->size - 1))
> > > +             return -EINVAL;
> > > +
> > >       if (vhost_iotlb_itree_first(iotlb, msg->iova,
> > >                                   msg->iova + msg->size - 1))
> > >               return -EEXIST;
> > >
> > > +
> > >       if (vdpa->use_va)
> > >               return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
> > >                                        msg->uaddr, msg->perm);
> > > @@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
> > >       return vhost_chr_write_iter(dev, from);
> > >  }
> > >
> > > +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, struct device *dma_dev,
> > > +     struct vhost_iotlb *resv_iotlb)
> > > +{
> > > +     struct list_head dev_resv_regions;
> > > +     phys_addr_t resv_msi_base = 0;
> > > +     struct iommu_resv_region *region;
> > > +     int ret = 0;
> > > +     bool with_sw_msi = false;
> > > +     bool with_hw_msi = false;
> > > +
> > > +     INIT_LIST_HEAD(&dev_resv_regions);
> > > +     iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> > > +
> > > +     list_for_each_entry(region, &dev_resv_regions, list) {
> > > +             ret = vhost_iotlb_add_range_ctx(resv_iotlb, region->start,
> > > +                             region->start + region->length - 1,
> > > +                             0, 0, NULL);
> > > +             if (ret) {
> > > +                     vhost_iotlb_reset(resv_iotlb);
> > > +                     break;
> > > +             }
> > > +
> > > +             if (region->type == IOMMU_RESV_MSI)
> > > +                     with_hw_msi = true;
> > > +
> > > +             if (region->type == IOMMU_RESV_SW_MSI) {
> > > +                     resv_msi_base = region->start;
> > > +                     with_sw_msi = true;
> > > +             }
> > > +     }
> > > +
> > > +     if (!ret && !with_hw_msi && with_sw_msi)
> > > +             ret = iommu_get_msi_cookie(domain, resv_msi_base);
> > > +
> > > +     iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > >  {
> > >       struct vdpa_device *vdpa = v->vdpa;
> > > @@ -1335,11 +1381,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > >
> > >       ret = iommu_attach_device(v->domain, dma_dev);
> > >       if (ret)
> > > -             goto err_attach;
> > > +             goto err_alloc_domain;
> > >
> > > -     return 0;
> > > +     ret = vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->resv_iotlb);
> > > +     if (ret)
> > > +             goto err_attach_device;
> > >
> > > -err_attach:
> > > +     return 0;
> > > +err_attach_device:
> > > +     iommu_detach_device(v->domain, dma_dev);
> > > +err_alloc_domain:
> > >       iommu_domain_free(v->domain);
> > >       v->domain = NULL;
> > >       return ret;
> > > @@ -1595,6 +1646,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> > >               goto err;
> > >       }
> > >
> > > +     vhost_iotlb_init(&v->resv_iotlb, 0, 0);
> > > +
> > >       r = dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
> > >       if (r)
> > >               goto err;
> > > --
> > > 2.27.0
> > >
> >

