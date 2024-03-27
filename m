Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7236B0A
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530554; cv=none; b=LQKk8ILOF+wfR05OR1sp5yo04+WRI2Ee9lmiOGGDUw8LSDUaI78MEn6OkiBgLaNIgn9BklB3NGeQgfnsLweFLPwW8uOA7q4Fmr/VrhVxo4OoxdANXpnbh9KKgm2tetzAZHP0oMgCpO0jTSi0Jhs5sn/09+brNoKbWFQRoC20XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530554; c=relaxed/simple;
	bh=oycWeHZoc4HFDl3X6OSlh68zAovOinIaWcnaZm5TJ7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfCmZAn8jnv31iAUfpzA6ktkNOuqFwyN5uqSJ43VyKGj/ab+MAyaNFXFYnh8glt8b8WO4zYyVx6hkCVpOZUvIitfB3idK8uZmUtiC4R0hU2J80vJEfbjByo/xlKiT9vedxPKNWkY6hcM9K/OpeS+zlPe/ZRPrWbaw0BnxGQlh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOAfzCuq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOAfzCuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711530551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiUO7iPSPavIkRv/nSLB+20MvgfvmGJfy8IPlO0GJ2M=;
	b=LOAfzCuqbVbx0FZRm83PgdS2+6ujQd5M0SqGyeCr33lzmcBgBAGTrl+/pBRPM/NhN8MynT
	5XM78VN+VG4eG55iaqaE4hBHRY9tgheeEKiReT1aeZUiZDooKUHyOHaDmXfTUnbjO/5/Qu
	rcNEH7ZLWLUMrN97Ql9DiMJNDWoLGgQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-WlbKV8bMP5m7-5HaRJrgMg-1; Wed, 27 Mar 2024 05:09:09 -0400
X-MC-Unique: WlbKV8bMP5m7-5HaRJrgMg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so5037471a12.1
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 02:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711530548; x=1712135348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiUO7iPSPavIkRv/nSLB+20MvgfvmGJfy8IPlO0GJ2M=;
        b=TEpHEbvxFu4oN45t+sKuM3c0sR13mq2++YCafQhHFcDueWkhft1ag+nA4mcEbynM/P
         A5FF/UenACmqcPsxDqXNmvy8Rd5PJB9+xPVfm8H9QiYT1dn3E/qwW5beedrrJ6N5ZCz9
         KHYkm34RANR8BazfdL+Ba+F/wmpicz2nQlnTGifNG2F+mhwmYn/MEdcQvhQlooWB6ofx
         VV2HpzrTwNZrFRoB1+kn0DXvU83m9ilu/hb+0DATUdjkgtSUQ31r0aHx4R9MUn/huG3E
         lHV5FSQDAVWMDkiHrULyiYzCIjjs91YhumjDU3ZquOZqldN1Lwb6ZcQpb2GUpHzviZBM
         3+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+hUk4b+hR9GMBhUU2cbuWf9KyDf3R8yoRHwsHCe4AUei0Oi3co6BvzhWpx8MBysAbb+iCX3pR2R56EOo/6/QtPFjt3TL3RGyFyIM4G9c=
X-Gm-Message-State: AOJu0Yxm2BeHlAXhnEqVeCLeXJNCb2M0cq/pwhzfw1U/ZKPAInWCIifu
	v9hcBLRixooWLJX9dXJJUOagCWQIWqXxUgA6OWj0L6is/88Sx+qVM85E1WVk3H1PMtbgNOpckh0
	WCdi7/s7mkLVMhP6JIGRluVj+PNs7ls2kOdyxzL7zrsKAuzEGb5lsRMWWwRD1yAqQcDEmb0vc6w
	tADizo6lkQ20394HQopyL7z/+eIXYRxJuqS+URUiF8WDlwNmE=
X-Received: by 2002:a17:90a:6581:b0:2a0:4c3b:2c39 with SMTP id k1-20020a17090a658100b002a04c3b2c39mr3854624pjj.23.1711530548357;
        Wed, 27 Mar 2024 02:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tW6F7qZe1Du7rhci+GrM9/pq6pNY9ImSzOjZdt98cUB1LtGctHbGEdhdQAtSqBjEaTzuTsGNpS1MIZsG1uo=
X-Received: by 2002:a17:90a:6581:b0:2a0:4c3b:2c39 with SMTP id
 k1-20020a17090a658100b002a04c3b2c39mr3854612pjj.23.1711530548014; Wed, 27 Mar
 2024 02:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240321025920-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 17:08:57 +0800
Message-ID: <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > From: Rong Wang <w_angrong@163.com>
> >
> > Once enable iommu domain for one device, the MSI
> > translation tables have to be there for software-managed MSI.
> > Otherwise, platform with software-managed MSI without an
> > irq bypass function, can not get a correct memory write event
> > from pcie, will not get irqs.
> > The solution is to obtain the MSI phy base address from
> > iommu reserved region, and set it to iommu MSI cookie,
> > then translation tables will be created while request irq.
> >
> > Change log
> > ----------
> >
> > v1->v2:
> > - add resv iotlb to avoid overlap mapping.
> > v2->v3:
> > - there is no need to export the iommu symbol anymore.
> >
> > Signed-off-by: Rong Wang <w_angrong@163.com>
>
> There's in interest to keep extending vhost iotlb -
> we should just switch over to iommufd which supports
> this already.

IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
makes vDPA run without a backporting of full IOMMUFD in the production
environment. I think it's worth.

If you worry about the extension, we can just use the vhost iotlb
existing facility to do this.

Thanks

>
> > ---
> >  drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 56 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index ba52d128aeb7..28b56b10372b 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -49,6 +49,7 @@ struct vhost_vdpa {
> >       struct completion completion;
> >       struct vdpa_device *vdpa;
> >       struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> > +     struct vhost_iotlb resv_iotlb;
> >       struct device dev;
> >       struct cdev cdev;
> >       atomic_t opened;
> > @@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
> >  static int vhost_vdpa_reset(struct vhost_vdpa *v)
> >  {
> >       v->in_batch =3D 0;
> > +     vhost_iotlb_reset(&v->resv_iotlb);
> >       return _compat_vdpa_reset(v);
> >  }
> >
> > @@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(stru=
ct vhost_vdpa *v,
> >           msg->iova + msg->size - 1 > v->range.last)
> >               return -EINVAL;
> >
> > +     if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> > +                                     msg->iova + msg->size - 1))
> > +             return -EINVAL;
> > +
> >       if (vhost_iotlb_itree_first(iotlb, msg->iova,
> >                                   msg->iova + msg->size - 1))
> >               return -EEXIST;
> >
> > +
> >       if (vdpa->use_va)
> >               return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
> >                                        msg->uaddr, msg->perm);
> > @@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct =
kiocb *iocb,
> >       return vhost_chr_write_iter(dev, from);
> >  }
> >
> > +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, s=
truct device *dma_dev,
> > +     struct vhost_iotlb *resv_iotlb)
> > +{
> > +     struct list_head dev_resv_regions;
> > +     phys_addr_t resv_msi_base =3D 0;
> > +     struct iommu_resv_region *region;
> > +     int ret =3D 0;
> > +     bool with_sw_msi =3D false;
> > +     bool with_hw_msi =3D false;
> > +
> > +     INIT_LIST_HEAD(&dev_resv_regions);
> > +     iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> > +
> > +     list_for_each_entry(region, &dev_resv_regions, list) {
> > +             ret =3D vhost_iotlb_add_range_ctx(resv_iotlb, region->sta=
rt,
> > +                             region->start + region->length - 1,
> > +                             0, 0, NULL);
> > +             if (ret) {
> > +                     vhost_iotlb_reset(resv_iotlb);
> > +                     break;
> > +             }
> > +
> > +             if (region->type =3D=3D IOMMU_RESV_MSI)
> > +                     with_hw_msi =3D true;
> > +
> > +             if (region->type =3D=3D IOMMU_RESV_SW_MSI) {
> > +                     resv_msi_base =3D region->start;
> > +                     with_sw_msi =3D true;
> > +             }
> > +     }
> > +
> > +     if (!ret && !with_hw_msi && with_sw_msi)
> > +             ret =3D iommu_get_msi_cookie(domain, resv_msi_base);
> > +
> > +     iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> > +
> > +     return ret;
> > +}
> > +
> >  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> >  {
> >       struct vdpa_device *vdpa =3D v->vdpa;
> > @@ -1335,11 +1381,16 @@ static int vhost_vdpa_alloc_domain(struct vhost=
_vdpa *v)
> >
> >       ret =3D iommu_attach_device(v->domain, dma_dev);
> >       if (ret)
> > -             goto err_attach;
> > +             goto err_alloc_domain;
> >
> > -     return 0;
> > +     ret =3D vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->resv=
_iotlb);
> > +     if (ret)
> > +             goto err_attach_device;
> >
> > -err_attach:
> > +     return 0;
> > +err_attach_device:
> > +     iommu_detach_device(v->domain, dma_dev);
> > +err_alloc_domain:
> >       iommu_domain_free(v->domain);
> >       v->domain =3D NULL;
> >       return ret;
> > @@ -1595,6 +1646,8 @@ static int vhost_vdpa_probe(struct vdpa_device *v=
dpa)
> >               goto err;
> >       }
> >
> > +     vhost_iotlb_init(&v->resv_iotlb, 0, 0);
> > +
> >       r =3D dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
> >       if (r)
> >               goto err;
> > --
> > 2.27.0
> >
>

