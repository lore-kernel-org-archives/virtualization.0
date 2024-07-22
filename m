Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32315884D
	for <virtualization@lists.linux.dev>; Mon, 22 Jul 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634666; cv=none; b=Ds4KnP0sFr7xbN0/zn0QeS3fj6VFPH5YQ4fxqYDH/UyXLG3Ui4eG4ju5b1cdKZhj4+UNLT2Y8NOWwgzZJR3bKOAM40tkcKpAzLs8Oo5D1TGXOFY5fZfIov/ghKJJtNyp52zxNs3RiClytdqON0BOZt2608IpycJIZG11AQODnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634666; c=relaxed/simple;
	bh=kM6B4WAqrzKJYRnZ3i57Pt1wk2HOfSOUPmwzvzL2Eqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VQtl75hdvQs++sAKpuDog+uIHhpGIHdloh7a6sfhp3gB5YpvUxGgjTKLJTh17xmgROlUak9Wrqf95K9cAVp2tPC1ehBASXpHiO09VhMIsTtHRYBqaNPWaIQr7dZB+8gTwqEy6bI58m9eA+7b5YFkGcrnq+STRgtzyZbB1IYBqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgHQY1F3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgHQY1F3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721634663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4m+0XDjcJxkqMhrA2nKcWximGlfkXdZjIEPwvCiPVg=;
	b=fgHQY1F3zq7xixL7ZJb2brvqQvSkHSAA8+m/QMuRSwHbPHqvH4XyW4mWiB3wr6uqzNwXS9
	gKfimzgTq+E4EtAScsF/QNj13KGAQ6wcxmoDSGPrD0xP0DGKJPHlH3lEhp2Cu5HwxMf6pW
	oSDC9+A1zUM44DR5Zv7dXSX/MJ9Kk9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-oQem2zcoNKmVjOjBasS9ow-1; Mon, 22 Jul 2024 03:51:01 -0400
X-MC-Unique: oQem2zcoNKmVjOjBasS9ow-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4266fbae4c6so30068225e9.0
        for <virtualization@lists.linux.dev>; Mon, 22 Jul 2024 00:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634660; x=1722239460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4m+0XDjcJxkqMhrA2nKcWximGlfkXdZjIEPwvCiPVg=;
        b=eqfSb+tJS3xEdd9aPNbmmKl9aYcsDNkcV8JlYlCX5dp9AdhO1wIZHqJNbUNmJzZvNx
         l8SRxkrGNzRZxZZITfydnttNLWr6OjqFxNl08hnPhIlI5dx/ob6eAbMClHVkLiO/RC20
         pwPIj3wNG/8/ELVTUIqT88Lf685qpr+UADQiJQmNEBD4vdthbtr7QZkKvAiW5dhI2b68
         cDYNPEjb8Zvi9OEebnxTp55XlUTNbmfLdgPCuEod+AMVCbBIutonWhXw3xdtDE/A1rlY
         LypUDLQFDui15CXQ0g+A+wHXi3nyEUbWoQUEKbTQcXgw8Y83bgASZRGJAhbnQxPgPy9C
         zvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpYdN4tR6qxa/sUIu8U0/JecBgwzjr2TPQu+6zeqXmDcxFsCNlvQ0xlU9gda8QxBL4GB/9r+ULUDU/SJCBkpofH8HnfNYUb7PpbcB9pyY=
X-Gm-Message-State: AOJu0Yxm8O7OQnbely9q5fofuPRPYcAre7TnkJzd8oOZOekLbzRos9yi
	KYvFRamR1Y4/sXHXUzdkaAXyQVf7MgDQG0aCvBr0PrjdEx80CMf+jCY9ao6S8+wuRQQ2eUP/eBG
	/PV4V57Ae6HQ1tMyG6vP7LTWgxZk1aKG/pRvn3c+upeu94NKEhXfwq/epGuQHjGKD
X-Received: by 2002:a05:600c:1c9a:b0:426:5b29:b5c8 with SMTP id 5b1f17b1804b1-427dc5584e3mr34941925e9.28.1721634659997;
        Mon, 22 Jul 2024 00:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER9CrSDIlh48t2FoOJgwrt+CviGGbRpwDi/tE9y0nnBt94oBE08Sl1oSSe2KOtiibfXqbzEg==
X-Received: by 2002:a05:600c:1c9a:b0:426:5b29:b5c8 with SMTP id 5b1f17b1804b1-427dc5584e3mr34941625e9.28.1721634659331;
        Mon, 22 Jul 2024 00:50:59 -0700 (PDT)
Received: from redhat.com (mob-5-90-115-88.net.vodafone.it. [5.90.115.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a53ccfsm143632605e9.11.2024.07.22.00.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:50:58 -0700 (PDT)
Date: Mon, 22 Jul 2024 03:50:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
Message-ID: <20240722034957-mutt-send-email-mst@kernel.org>
References: <20240530101823.1210161-1-schalla@marvell.com>
 <20240717054547-mutt-send-email-mst@kernel.org>
 <DS0PR18MB536893E8C3A628A95BF8DDA0A0AD2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEtQ3SWBpS-00BBCJxoUK5AQRB=FhKGEqigh81GTbRf61A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtQ3SWBpS-00BBCJxoUK5AQRB=FhKGEqigh81GTbRf61A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 22, 2024 at 03:22:22PM +0800, Jason Wang wrote:
> On Fri, Jul 19, 2024 at 11:40 PM Srujana Challa <schalla@marvell.com> wrote:
> >
> > > On Thu, May 30, 2024 at 03:48:23PM +0530, Srujana Challa wrote:
> > > > This commit introduces support for an UNSAFE, no-IOMMU mode in the
> > > > vhost-vdpa driver. When enabled, this mode provides no device
> > > > isolation, no DMA translation, no host kernel protection, and cannot
> > > > be used for device assignment to virtual machines. It requires RAWIO
> > > > permissions and will taint the kernel.
> > > > This mode requires enabling the
> > > "enable_vhost_vdpa_unsafe_noiommu_mode"
> > > > option on the vhost-vdpa driver. This mode would be useful to get
> > > > better performance on specifice low end machines and can be leveraged
> > > > by embedded platforms where applications run in controlled environment.
> > > >
> > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > >
> > > Thought hard about that.
> > > I think given vfio supports this, we can do that too, and the extension is small.
> > >
> > > However, it looks like setting this parameter will automatically change the
> > > behaviour for existing userspace when IOMMU_DOMAIN_IDENTITY is set.
> > >
> > > I suggest a new domain type for use just for this purpose.
> 
> I'm not sure I get this, we want to bypass IOMMU, so it doesn't even
> have a doman.

yes, a fake one. or come up with some other flag that userspace
will set.

> > This way if host has
> > > an iommu, then the same kernel can run both VMs with isolation and unsafe
> > > embedded apps without.
> > Could you provide further details on this concept? What criteria would determine
> > the configuration of the new domain type? Would this require a boot parameter
> > similar to IOMMU_DOMAIN_IDENTITY, such as iommu.passthrough=1 or iommu.pt?
> 
> Thanks
> 
> > >
> > > > ---
> > > >  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c index
> > > > bc4a51e4638b..d071c30125aa 100644
> > > > --- a/drivers/vhost/vdpa.c
> > > > +++ b/drivers/vhost/vdpa.c
> > > > @@ -36,6 +36,11 @@ enum {
> > > >
> > > >  #define VHOST_VDPA_IOTLB_BUCKETS 16
> > > >
> > > > +bool vhost_vdpa_noiommu;
> > > > +module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > > +              vhost_vdpa_noiommu, bool, 0644);
> > > > +MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > "Enable
> > > > +UNSAFE, no-IOMMU mode.  This mode provides no device isolation, no
> > > > +DMA translation, no host kernel protection, cannot be used for device
> > > > +assignment to virtual machines, requires RAWIO permissions, and will
> > > > +taint the kernel.  If you do not know what this is for, step away.
> > > > +(default: false)");
> > > > +
> > > >  struct vhost_vdpa_as {
> > > >     struct hlist_node hash_link;
> > > >     struct vhost_iotlb iotlb;
> > > > @@ -60,6 +65,7 @@ struct vhost_vdpa {
> > > >     struct vdpa_iova_range range;
> > > >     u32 batch_asid;
> > > >     bool suspended;
> > > > +   bool noiommu_en;
> > > >  };
> > > >
> > > >  static DEFINE_IDA(vhost_vdpa_ida);
> > > > @@ -887,6 +893,10 @@ static void vhost_vdpa_general_unmap(struct
> > > > vhost_vdpa *v,  {
> > > >     struct vdpa_device *vdpa = v->vdpa;
> > > >     const struct vdpa_config_ops *ops = vdpa->config;
> > > > +
> > > > +   if (v->noiommu_en)
> > > > +           return;
> > > > +
> > > >     if (ops->dma_map) {
> > > >             ops->dma_unmap(vdpa, asid, map->start, map->size);
> > > >     } else if (ops->set_map == NULL) {
> > > > @@ -980,6 +990,9 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
> > > struct vhost_iotlb *iotlb,
> > > >     if (r)
> > > >             return r;
> > > >
> > > > +   if (v->noiommu_en)
> > > > +           goto skip_map;
> > > > +
> > > >     if (ops->dma_map) {
> > > >             r = ops->dma_map(vdpa, asid, iova, size, pa, perm, opaque);
> > > >     } else if (ops->set_map) {
> > > > @@ -995,6 +1008,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
> > > struct vhost_iotlb *iotlb,
> > > >             return r;
> > > >     }
> > > >
> > > > +skip_map:
> > > >     if (!vdpa->use_va)
> > > >             atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
> > > >
> > > > @@ -1298,6 +1312,7 @@ static int vhost_vdpa_alloc_domain(struct
> > > vhost_vdpa *v)
> > > >     struct vdpa_device *vdpa = v->vdpa;
> > > >     const struct vdpa_config_ops *ops = vdpa->config;
> > > >     struct device *dma_dev = vdpa_get_dma_dev(vdpa);
> > > > +   struct iommu_domain *domain;
> > > >     const struct bus_type *bus;
> > > >     int ret;
> > > >
> > > > @@ -1305,6 +1320,14 @@ static int vhost_vdpa_alloc_domain(struct
> > > vhost_vdpa *v)
> > > >     if (ops->set_map || ops->dma_map)
> > > >             return 0;
> > > >
> > > > +   domain = iommu_get_domain_for_dev(dma_dev);
> > > > +   if ((!domain || domain->type == IOMMU_DOMAIN_IDENTITY) &&
> > > > +       vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO)) {
> > >
> > > So if userspace does not have CAP_SYS_RAWIO instead of failing with a
> > > permission error the functionality changes silently?
> > > That's confusing, I think.
> > Yes, you are correct. I will modify the code to return error when vhost_vdpa_noiommu
> > is set and CAP_SYS_RAWIO is not set.
> >
> > Thanks.
> > >
> > >
> > > > +           add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > > +           dev_warn(&v->dev, "Adding kernel taint for noiommu on
> > > device\n");
> > > > +           v->noiommu_en = true;
> > > > +           return 0;
> > > > +   }
> > > >     bus = dma_dev->bus;
> > > >     if (!bus)
> > > >             return -EFAULT;
> > > > --
> > > > 2.25.1
> >

