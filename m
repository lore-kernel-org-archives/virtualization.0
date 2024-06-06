Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737B1373
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717632951; cv=none; b=CioNCvse4PuDrE6z3Iy9j5/dZ1DjC47avzjv5Q6pQ74mzeLQ0o2XM7pPsdcP9mJFpr8djP+hykqwHUi3aRzv47le08RMQLk9umSBpCq9ik8ZQj8FReeOM9K+oxt++hEDTf49DBv3mUY8cE3hU+HXQ9rxQxFk0jsbcX5UpxADkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717632951; c=relaxed/simple;
	bh=cA/V6BOvp6iC6dBplxgCw7tDDdNr8L2LEvDOHIiZXhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaAw2BWf1ktoG7n58EDh+JH2hDxJEJKBbya9xB4l9xBrccO1wvCAQMcAqEk7aEjzD0vcfY/6rlk10Zp+PyCxGFRAG2sUzbP3xEpCjGveVdctCtq7MFg+quvnY7r3EEeV0PPCYvVXwEcxEhL+Zf6zziDxzDUg8yJjAhmEOL+q1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0D58+cu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0D58+cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717632949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9OSg1uI5MgwP5qOImpDRQ7/OUQ1FY8KBSoJi1lD7fM=;
	b=Z0D58+cuvx54Q1qdNvTaxz4lkD6C+hbbXHcekrsIOEKlIhb9EJ38wEhwE4QYnbfqro/+Iw
	KyhBoVopKA1zlEMGCA4a2BYgeDFMrKFBFx1YCSDfap5L21O+qs7jNLdqN5L/uTlR5jnf4S
	CQ9bqfVVT1aMVydmJToM7uU4xmDemsI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-KAOidDd6N7-8ksbmECNEuA-1; Wed, 05 Jun 2024 20:15:47 -0400
X-MC-Unique: KAOidDd6N7-8ksbmECNEuA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6818fa37eecso339248a12.1
        for <virtualization@lists.linux.dev>; Wed, 05 Jun 2024 17:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717632946; x=1718237746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9OSg1uI5MgwP5qOImpDRQ7/OUQ1FY8KBSoJi1lD7fM=;
        b=GGMMWSRa6c7RI+QTkXkd4YVvz6oPghbQdJIYizKcn3SVRPG+RZqN1Mxae/rNH/sfvB
         YTEaN+rHlj1a/BUdynwD0Qw496XmxpX02FFuk2gNvE9C6KTHJMid5AWYFktmn6JHVeBk
         qcslGGEIHDvqo/vP52TMv4AykZBy+tLRWfaYydo6wZ9FD02XWqHavw/UGqVjN5ANR3xW
         EY+EeOZUlwBCMi6Cey8qtyfcAeb+0DK28767tHDVEBLtsLUQVhnq/6yL/RUQ0UaAT0ZZ
         sYDpE0SmOPclUkpAKUb46xaUbBJVJ63q3tSS63fr0NKtX4Wu9zO61GGTnHJ3/Md/4s2b
         Hv5w==
X-Gm-Message-State: AOJu0YzLuseP6McFl8Ugc6eAGqU/Q7/wY69P0shZIclOHUTosn+qElrg
	Wbskgdri4f0KAbs/CDrEb9q54KJ/I1zZmyM7wuas3KkAnICaMZEpjuq5h5q+0tkasmnUa57XFzA
	mLtCjMPhEr+kphX9YrClJPkbH8zmpd8Mxr7eea68xgg/L1Vf/jNpfXpz89lKSlTw4fNjmw5XzM4
	6qpRnrkJxqBY64VjQzXl1Uh/h9fnoOJxSBp/aX9wU=
X-Received: by 2002:a17:90a:ec11:b0:2bd:f751:e184 with SMTP id 98e67ed59e1d1-2c27da34c92mr5164051a91.0.1717632946478;
        Wed, 05 Jun 2024 17:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESnECJmLE8YCXmcQHFqDp4cTi+9QvYM5XtRTHCfZcfiAs1hjgOuhAt398N6CzvvljsUKIds1YH7z2vLGG+86k=
X-Received: by 2002:a17:90a:ec11:b0:2bd:f751:e184 with SMTP id
 98e67ed59e1d1-2c27da34c92mr5164030a91.0.1717632945993; Wed, 05 Jun 2024
 17:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530101823.1210161-1-schalla@marvell.com> <CACGkMEsxPfck-Ww6CHSod5wP5xLOpS3t2B8qhTL0=PoE3koCGQ@mail.gmail.com>
 <DS0PR18MB5368E02C4DE7AA96CCD299E0A0F82@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB5368E02C4DE7AA96CCD299E0A0F82@DS0PR18MB5368.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 08:15:35 +0800
Message-ID: <CACGkMEs+s7JEvLXBdyQbj36Y8WSbHXqF2d9HNP3v7CPRPoocXg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
To: Srujana Challa <schalla@marvell.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	Vamsi Krishna Attunuru <vattunuru@marvell.com>, Shijith Thotton <sthotton@marvell.com>, 
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Jerin Jacob <jerinj@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 5:29=E2=80=AFPM Srujana Challa <schalla@marvell.com>=
 wrote:
>
> > Subject: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
> >
> > Prioritize security for external emails: Confirm sender and content saf=
ety
> > before clicking links or opening attachments
> >
> > ----------------------------------------------------------------------
> > On Thu, May 30, 2024 at 6:18=E2=80=AFPM Srujana Challa <schalla@marvell=
.com>
> > wrote:
> > >
> > > This commit introduces support for an UNSAFE, no-IOMMU mode in the
> > > vhost-vdpa driver. When enabled, this mode provides no device
> > > isolation, no DMA translation, no host kernel protection, and cannot
> > > be used for device assignment to virtual machines. It requires RAWIO
> > > permissions and will taint the kernel.
> > > This mode requires enabling the
> > "enable_vhost_vdpa_unsafe_noiommu_mode"
> > > option on the vhost-vdpa driver. This mode would be useful to get
> > > better performance on specifice low end machines and can be leveraged
> > > by embedded platforms where applications run in controlled environmen=
t.
> >
> > I wonder if it's better to do it per driver:
> >
> > 1) we have device that use its own IOMMU, one example is the mlx5 vDPA
> > device
> > 2) we have software devices which doesn't require IOMMU at all (but sti=
ll with
> > protection)
>
> If I understand correctly, you=E2=80=99re suggesting that we create a mod=
ule parameter
> specific to the vdpa driver. Then, we can add a flag to the =E2=80=98stru=
ct vdpa_device=E2=80=99
> and set that flag within the vdpa driver based on the module parameter.
> Finally, we would use this flag to taint the kernel and go in no-iommu pa=
th
> in the vhost-vdpa driver?

If it's possible, I would like to avoid changing the vDPA core.

Thanks

> >
> > Thanks
> >
> > >
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > ---
> > >  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c index
> > > bc4a51e4638b..d071c30125aa 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -36,6 +36,11 @@ enum {
> > >
> > >  #define VHOST_VDPA_IOTLB_BUCKETS 16
> > >
> > > +bool vhost_vdpa_noiommu;
> > > +module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > +                  vhost_vdpa_noiommu, bool, 0644);
> > > +MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode,
> > "Enable
> > > +UNSAFE, no-IOMMU mode.  This mode provides no device isolation, no
> > > +DMA translation, no host kernel protection, cannot be used for devic=
e
> > > +assignment to virtual machines, requires RAWIO permissions, and will
> > > +taint the kernel.  If you do not know what this is for, step away.
> > > +(default: false)");
> > > +
> > >  struct vhost_vdpa_as {
> > >         struct hlist_node hash_link;
> > >         struct vhost_iotlb iotlb;
> > > @@ -60,6 +65,7 @@ struct vhost_vdpa {
> > >         struct vdpa_iova_range range;
> > >         u32 batch_asid;
> > >         bool suspended;
> > > +       bool noiommu_en;
> > >  };
> > >
> > >  static DEFINE_IDA(vhost_vdpa_ida);
> > > @@ -887,6 +893,10 @@ static void vhost_vdpa_general_unmap(struct
> > > vhost_vdpa *v,  {
> > >         struct vdpa_device *vdpa =3D v->vdpa;
> > >         const struct vdpa_config_ops *ops =3D vdpa->config;
> > > +
> > > +       if (v->noiommu_en)
> > > +               return;
> > > +
> > >         if (ops->dma_map) {
> > >                 ops->dma_unmap(vdpa, asid, map->start, map->size);
> > >         } else if (ops->set_map =3D=3D NULL) { @@ -980,6 +990,9 @@ st=
atic
> > > int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
> > >         if (r)
> > >                 return r;
> > >
> > > +       if (v->noiommu_en)
> > > +               goto skip_map;
> > > +
> > >         if (ops->dma_map) {
> > >                 r =3D ops->dma_map(vdpa, asid, iova, size, pa, perm, =
opaque);
> > >         } else if (ops->set_map) {
> > > @@ -995,6 +1008,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
> > struct vhost_iotlb *iotlb,
> > >                 return r;
> > >         }
> > >
> > > +skip_map:
> > >         if (!vdpa->use_va)
> > >                 atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
> > >
> > > @@ -1298,6 +1312,7 @@ static int vhost_vdpa_alloc_domain(struct
> > vhost_vdpa *v)
> > >         struct vdpa_device *vdpa =3D v->vdpa;
> > >         const struct vdpa_config_ops *ops =3D vdpa->config;
> > >         struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> > > +       struct iommu_domain *domain;
> > >         const struct bus_type *bus;
> > >         int ret;
> > >
> > > @@ -1305,6 +1320,14 @@ static int vhost_vdpa_alloc_domain(struct
> > vhost_vdpa *v)
> > >         if (ops->set_map || ops->dma_map)
> > >                 return 0;
> > >
> > > +       domain =3D iommu_get_domain_for_dev(dma_dev);
> > > +       if ((!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) &&
> > > +           vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO)) {
> > > +               add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > +               dev_warn(&v->dev, "Adding kernel taint for noiommu on
> > device\n");
> > > +               v->noiommu_en =3D true;
> > > +               return 0;
> > > +       }
> > >         bus =3D dma_dev->bus;
> > >         if (!bus)
> > >                 return -EFAULT;
> > > --
> > > 2.25.1
> > >
>

