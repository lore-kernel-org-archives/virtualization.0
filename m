Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869E16E881
	for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195569; cv=none; b=H86bD4TgB09N3RqIlNuzwIjqT6CDdl2bEk4UCB/5X3uLBZoBimGuUWkjITx718cuLOcqaE6vbT85iM/iJ7P0hfmwInPk/myS9ZJrxXej8TPBxPaQhuzNmpoIf1O9Vr/zBRUxxsK88AzDi73svXAVOAimNZvNq7gbZqUs6rsbWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195569; c=relaxed/simple;
	bh=fT/rUz7KLw47ie7gQBlOBi/uaQUpPAuVBwYVvWuy8mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aCp9V23CyJWRb486wEd5k4Z046SVnAeGXda/OyygGRqsP0elvI1hhghDIbMgPdevbWge+Y5MVBxdbMr1Y6LgZz7g17rLUU9rNXmWeFZSi9uh1rZcUmhPRleTpvC5CmYewKLhqM2wMF///8gdWNO+Eg+fDTE4ACcKKcnubdj+bS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxDqcu89; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxDqcu89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718195566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfQZDtLT+q+ZIAPC3OZ+JW6AZ+Ih2QY45mLdNIYr7/k=;
	b=SxDqcu89aRzdlpHFGBMYTivMCeGcRGV7TZS6zb1wprxypyv0wQVR5sOwJwdjscXZ+o13nC
	O6d4s+aRVmP815j0cnptZ4cqRXVsN1xyWzQp3Zm0CN+r6loCzPjBvqXS/I2lmLBrC3ZgyI
	Dg0UShkwl+pgji9cP8kbm+nDw9Dyfxg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-X6JLGcs1NkWsNDLNVpnxuw-1; Wed, 12 Jun 2024 08:32:43 -0400
X-MC-Unique: X6JLGcs1NkWsNDLNVpnxuw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42120e033e2so11205575e9.0
        for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 05:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718195562; x=1718800362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfQZDtLT+q+ZIAPC3OZ+JW6AZ+Ih2QY45mLdNIYr7/k=;
        b=KmIsxP0H47fr5b+uIuJVx7ACUF7ycyfA76ATBYdG0iC999t/XOSrLIe7cjHQoFmYuT
         k19c1Fm6gINWeHRkqAYpiDygMAibxQfzjtUQyNilUQuQOLgicNVZS/zMgc4YNlMq3XiE
         QYRBxmxwTmexazVFY5sbl2pbyrQ+T4zeaU3DpHoA9ImLc/C3nRwzxhGKAjkIRY0MrEkX
         Ju0y6pcRRYCaUchJ5IEUn7HefJSBL3azygmnxwKsX81jeZmhWHvGjsbXgab+7e7UQqlI
         FT9aNshVBQieA8KU/7GnJr3CKbsQp2+57VAXRDo6h8YrmDZKcZ2qvuBIdtLp3bL8YoM/
         SK/g==
X-Forwarded-Encrypted: i=1; AJvYcCX7ffBvntu54DQqNg/td5bfHdQa3x8ZsZFlKLDgorHwxeivbnuxf4x8BXyT19XxsmZyYKLfzomwDYV7HjjiFMJ/Ju3xvk8WpwPgUxxMAY0=
X-Gm-Message-State: AOJu0Yw1zcPxf41JbAzvz45Srsm20XVXXXvTV3d35SaoHzStatYsbfNo
	M1H7BpeVvdREGj/VOtxJ5iiTTJTlx5n3iHA+e8G83KggEQEby3OpQ7fOxQfIgqLcDX4SYn+XO+W
	HHFQk8BJ0Mw5BglfPBkxOjFpxj1OejGtQb1WYQk7UdKj4YQzjtDPlrVzfHVd0TpYD
X-Received: by 2002:a05:600c:5008:b0:421:81c1:65fa with SMTP id 5b1f17b1804b1-422862a749fmr18009445e9.13.1718195562047;
        Wed, 12 Jun 2024 05:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX1J/727VlQKp+bnqlzO56bmec4Mvp/egLF2T+bKHvyiF7Rt8TUW+mf2Itz3LGm+3KTeWuYg==
X-Received: by 2002:a05:600c:5008:b0:421:81c1:65fa with SMTP id 5b1f17b1804b1-422862a749fmr18009125e9.13.1718195561469;
        Wed, 12 Jun 2024 05:32:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:39eb:4161:d39d:43e6:41f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229447eaa5sm18672645e9.48.2024.06.12.05.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:32:40 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:32:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
Message-ID: <20240612083001-mutt-send-email-mst@kernel.org>
References: <20240530101823.1210161-1-schalla@marvell.com>
 <CACGkMEsxPfck-Ww6CHSod5wP5xLOpS3t2B8qhTL0=PoE3koCGQ@mail.gmail.com>
 <DS0PR18MB5368E02C4DE7AA96CCD299E0A0F82@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEs+s7JEvLXBdyQbj36Y8WSbHXqF2d9HNP3v7CPRPoocXg@mail.gmail.com>
 <DS0PR18MB5368CD9E8E3432A9D19D8C8FA0C02@DS0PR18MB5368.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR18MB5368CD9E8E3432A9D19D8C8FA0C02@DS0PR18MB5368.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 12, 2024 at 09:22:43AM +0000, Srujana Challa wrote:
> 
> > Subject: Re: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
> > 
> > On Tue, Jun 4, 2024 at 5:29 PM Srujana Challa <schalla@marvell.com> wrote:
> > >
> > > > Subject: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
> > > >
> > > > Prioritize security for external emails: Confirm sender and content
> > > > safety before clicking links or opening attachments
> > > >
> > > > --------------------------------------------------------------------
> > > > -- On Thu, May 30, 2024 at 6:18 PM Srujana Challa
> > > > <schalla@marvell.com>
> > > > wrote:
> > > > >
> > > > > This commit introduces support for an UNSAFE, no-IOMMU mode in the
> > > > > vhost-vdpa driver. When enabled, this mode provides no device
> > > > > isolation, no DMA translation, no host kernel protection, and
> > > > > cannot be used for device assignment to virtual machines. It
> > > > > requires RAWIO permissions and will taint the kernel.
> > > > > This mode requires enabling the
> > > > "enable_vhost_vdpa_unsafe_noiommu_mode"
> > > > > option on the vhost-vdpa driver. This mode would be useful to get
> > > > > better performance on specifice low end machines and can be
> > > > > leveraged by embedded platforms where applications run in controlled
> > environment.
> > > >
> > > > I wonder if it's better to do it per driver:
> > > >
> > > > 1) we have device that use its own IOMMU, one example is the mlx5
> > > > vDPA device
> > > > 2) we have software devices which doesn't require IOMMU at all (but
> > > > still with
> > > > protection)
> > >
> > > If I understand correctly, you’re suggesting that we create a module
> > > parameter specific to the vdpa driver. Then, we can add a flag to the ‘struct
> > vdpa_device’
> > > and set that flag within the vdpa driver based on the module parameter.
> > > Finally, we would use this flag to taint the kernel and go in no-iommu
> > > path in the vhost-vdpa driver?
> > 
> > If it's possible, I would like to avoid changing the vDPA core.
> > 
> > Thanks
> According to my understanding of the discussion at the
> https://lore.kernel.org/all/20240422164108-mutt-send-email-mst@kernel.org,
> Michael has suggested focusing on implementing a no-IOMMU mode in vdpa.
> Michael, could you please confirm if it's fine to transfer all these relevant
> modifications to Marvell's vdpa driver?
> 
> Thanks.


All I said is that octeon driver can be merged without this support.
Then work on no-iommu can start separately.


Whether this belongs in the driver or the core would depend on
what the use-case is. I have not figured it out yet.
What you describe seems generic not card-specific though.
Jason why do you  want this in the driver?

> > 
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > ---
> > > > >  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++++
> > > > >  1 file changed, 23 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c index
> > > > > bc4a51e4638b..d071c30125aa 100644
> > > > > --- a/drivers/vhost/vdpa.c
> > > > > +++ b/drivers/vhost/vdpa.c
> > > > > @@ -36,6 +36,11 @@ enum {
> > > > >
> > > > >  #define VHOST_VDPA_IOTLB_BUCKETS 16
> > > > >
> > > > > +bool vhost_vdpa_noiommu;
> > > > > +module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > > > +                  vhost_vdpa_noiommu, bool, 0644);
> > > > > +MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > > "Enable
> > > > > +UNSAFE, no-IOMMU mode.  This mode provides no device isolation,
> > > > > +no DMA translation, no host kernel protection, cannot be used for
> > > > > +device assignment to virtual machines, requires RAWIO
> > > > > +permissions, and will taint the kernel.  If you do not know what this is
> > for, step away.
> > > > > +(default: false)");
> > > > > +
> > > > >  struct vhost_vdpa_as {
> > > > >         struct hlist_node hash_link;
> > > > >         struct vhost_iotlb iotlb;
> > > > > @@ -60,6 +65,7 @@ struct vhost_vdpa {
> > > > >         struct vdpa_iova_range range;
> > > > >         u32 batch_asid;
> > > > >         bool suspended;
> > > > > +       bool noiommu_en;
> > > > >  };
> > > > >
> > > > >  static DEFINE_IDA(vhost_vdpa_ida); @@ -887,6 +893,10 @@ static
> > > > > void vhost_vdpa_general_unmap(struct vhost_vdpa *v,  {
> > > > >         struct vdpa_device *vdpa = v->vdpa;
> > > > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > > > +
> > > > > +       if (v->noiommu_en)
> > > > > +               return;
> > > > > +
> > > > >         if (ops->dma_map) {
> > > > >                 ops->dma_unmap(vdpa, asid, map->start, map->size);
> > > > >         } else if (ops->set_map == NULL) { @@ -980,6 +990,9 @@
> > > > > static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb
> > *iotlb,
> > > > >         if (r)
> > > > >                 return r;
> > > > >
> > > > > +       if (v->noiommu_en)
> > > > > +               goto skip_map;
> > > > > +
> > > > >         if (ops->dma_map) {
> > > > >                 r = ops->dma_map(vdpa, asid, iova, size, pa, perm, opaque);
> > > > >         } else if (ops->set_map) { @@ -995,6 +1008,7 @@ static int
> > > > > vhost_vdpa_map(struct vhost_vdpa *v,
> > > > struct vhost_iotlb *iotlb,
> > > > >                 return r;
> > > > >         }
> > > > >
> > > > > +skip_map:
> > > > >         if (!vdpa->use_va)
> > > > >                 atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
> > > > >
> > > > > @@ -1298,6 +1312,7 @@ static int vhost_vdpa_alloc_domain(struct
> > > > vhost_vdpa *v)
> > > > >         struct vdpa_device *vdpa = v->vdpa;
> > > > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > > >         struct device *dma_dev = vdpa_get_dma_dev(vdpa);
> > > > > +       struct iommu_domain *domain;
> > > > >         const struct bus_type *bus;
> > > > >         int ret;
> > > > >
> > > > > @@ -1305,6 +1320,14 @@ static int vhost_vdpa_alloc_domain(struct
> > > > vhost_vdpa *v)
> > > > >         if (ops->set_map || ops->dma_map)
> > > > >                 return 0;
> > > > >
> > > > > +       domain = iommu_get_domain_for_dev(dma_dev);
> > > > > +       if ((!domain || domain->type == IOMMU_DOMAIN_IDENTITY) &&
> > > > > +           vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO)) {
> > > > > +               add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > > > +               dev_warn(&v->dev, "Adding kernel taint for noiommu
> > > > > + on
> > > > device\n");
> > > > > +               v->noiommu_en = true;
> > > > > +               return 0;
> > > > > +       }
> > > > >         bus = dma_dev->bus;
> > > > >         if (!bus)
> > > > >                 return -EFAULT;
> > > > > --
> > > > > 2.25.1
> > > > >
> > >
> 

