Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DA17624F
	for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947818; cv=none; b=XMEUXC0jFkqUMII2pzXNy5nuouMoj5ymKD7iUreC3zxSEGI/JPyMLhjKzhxOw925jxn8nMP1L/EUQHlaLD2HAPTlb9MOaBoORLZM0KHVVnEDfkNBe2eJ3jSGhoz9lFjY0WEJqldob29bEHCXpwgXaN+9khAlG034sLZMYxPAtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947818; c=relaxed/simple;
	bh=bEWpONHSiaCAL9nHTlh72m5L9gCK+vPqYF1cUXGkcns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lRIeCuWE+Xo9Az7Z1Ro1Lg16w2+DuixOv5eeDLXc0+rfav7G2VWn0xZ/9VFFEyEQ0iTKWaxzr3/q0eeorlag472Z8R5FIZOnHyUIiE/TaibpS+EY6vkR/0gHUiXUVFfyhieezUs178L76uVse090sdlVMU5+1AdsHMYTppRAvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RO48jPGS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RO48jPGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725947815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZA8O0UwD0kMNADQRx8cL0+Q6S43BimlTMl9M84XCyQ=;
	b=RO48jPGSqHoRIwMTer/lTz8MueumZ56G562FkkRW0EFOj0wvy9l28HYXJpVTn/JbTe8A8Y
	h8MYfqcfWNChZsa+kVuV8vSHfWltQ1PSDOep1T+sxyhT7QkamPJK4lrq4akNF+wBYTS9K7
	8xtjto2DIKsHe5fWt5oFCOdbwf2IGjQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-pS07rp_SNVOK53HrhR1dYw-1; Tue, 10 Sep 2024 01:56:54 -0400
X-MC-Unique: pS07rp_SNVOK53HrhR1dYw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b9617ab0so2168754f8f.3
        for <virtualization@lists.linux.dev>; Mon, 09 Sep 2024 22:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947813; x=1726552613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZA8O0UwD0kMNADQRx8cL0+Q6S43BimlTMl9M84XCyQ=;
        b=pJwrCtnwqpIdIO4Tad3TUlWFidSGKcYMEs1q4UYfGDdO2M7x81dVmJcb3/A/WzvMAD
         PSaPU15IdWqoMt+cGjqSoC7VB7tYs06L0cYjEEM4xvOwhiy8h8kVhr7O7sXA46J4Ar8b
         fXHpVuZZUOrOuc9R//7x9QVagdEPWOn4LwlOB8SRxljLY1qX1ekPyNFQ1ri4Ww+Mf7R+
         zWDFmiuR6EUGe8fBwWX76QuBylvd1vHS1f/tELfOvG7wgr0eRA7waM/9KGJTtsKeyW7F
         8lp3feBWS9kxhbtDYQTIDVgk28AiJFmXK0xhJMDnmb6X6og1K+3/5SsKcJkyvJQ2gBj8
         8KYg==
X-Forwarded-Encrypted: i=1; AJvYcCU5TEB9QBqJdae8WYOPTNIBxN/o7R0KV4yVp8gg6AL0mDv2G7rs00xIhrqZ4HX2zGLeOm7vZuMqFjEjamrQFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YySd6r78x4GZC3yH8j25u+qBJu5f8fBs1VvMtSuSI+AotG7HA5F
	zWGqCtIIzX/ws8PsV3FPXF25FZtMBwoUFyWxJw59E+sC+w9zlAW4V5kZJXVRAwTbYVLGluTO1YO
	eu0DFNsukZK/8F2RyDK8Nz38XW/FQVfkxQXKpSEtgnHGtez+jINO6hcVfS+mNF10ZbzCyPUlV
X-Received: by 2002:a5d:59a6:0:b0:374:c8a0:5d05 with SMTP id ffacd0b85a97d-37892703fffmr7100621f8f.50.1725947812544;
        Mon, 09 Sep 2024 22:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmH3ot6bgXVUW/zJPiXkkj2YR5CszEUT5J/sC3K2/NdHA+7IFqm4HuH7IreAVy/9UyFfpHww==
X-Received: by 2002:a5d:59a6:0:b0:374:c8a0:5d05 with SMTP id ffacd0b85a97d-37892703fffmr7100608f8f.50.1725947811429;
        Mon, 09 Sep 2024 22:56:51 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b7f1sm98936555e9.48.2024.09.09.22.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:56:50 -0700 (PDT)
Date: Tue, 10 Sep 2024 01:56:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
Message-ID: <20240910015607-mutt-send-email-mst@kernel.org>
References: <20240530101823.1210161-1-schalla@marvell.com>
 <20240717054547-mutt-send-email-mst@kernel.org>
 <DS0PR18MB536893E8C3A628A95BF8DDA0A0AD2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEtQ3SWBpS-00BBCJxoUK5AQRB=FhKGEqigh81GTbRf61A@mail.gmail.com>
 <20240722034957-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368298DAEA53CF7F9710B46A0A92@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240723070326-mutt-send-email-mst@kernel.org>
 <DS0PR18MB53689BE0C0DFDBD86D396515A0BF2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <DS0PR18MB53684A307C08D17276A465EEA0952@DS0PR18MB5368.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR18MB53684A307C08D17276A465EEA0952@DS0PR18MB5368.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Aug 28, 2024 at 09:08:13AM +0000, Srujana Challa wrote:
> > Subject: RE: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
> > 
> > > On Tue, Jul 23, 2024 at 07:10:52AM +0000, Srujana Challa wrote:
> > > > > On Mon, Jul 22, 2024 at 03:22:22PM +0800, Jason Wang wrote:
> > > > > > On Fri, Jul 19, 2024 at 11:40 PM Srujana Challa
> > > > > > <schalla@marvell.com>
> > > > > wrote:
> > > > > > >
> > > > > > > > On Thu, May 30, 2024 at 03:48:23PM +0530, Srujana Challa wrote:
> > > > > > > > > This commit introduces support for an UNSAFE, no-IOMMU
> > > > > > > > > mode in the vhost-vdpa driver. When enabled, this mode
> > > > > > > > > provides no device isolation, no DMA translation, no host
> > > > > > > > > kernel protection, and cannot be used for device
> > > > > > > > > assignment to virtual machines. It requires RAWIO
> > > > > > > > > permissions and will taint the
> > > kernel.
> > > > > > > > > This mode requires enabling the
> > > > > > > > "enable_vhost_vdpa_unsafe_noiommu_mode"
> > > > > > > > > option on the vhost-vdpa driver. This mode would be useful
> > > > > > > > > to get better performance on specifice low end machines
> > > > > > > > > and can be leveraged by embedded platforms where
> > > > > > > > > applications run in controlled
> > > > > environment.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > >
> > > > > > > > Thought hard about that.
> > > > > > > > I think given vfio supports this, we can do that too, and
> > > > > > > > the extension is
> > > > > small.
> > > > > > > >
> > > > > > > > However, it looks like setting this parameter will
> > > > > > > > automatically change the behaviour for existing userspace
> > > > > > > > when
> > > > > IOMMU_DOMAIN_IDENTITY is set.
> > > > Our initial thought was to support only for no-iommu case, in which
> > > > domain
> > > itself
> > > > won't be exist.   So, we can modify the code as below to check for only
> > > presence of domain.
> > > > I think,  only handling of no-iommu case wouldn't effect the
> > > > existing
> > > userspace.
> > > > +   if ((!domain) && vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO))
> > {
> > >
> > > I would prefer some explicit action.
> > > Just not specifying a domain is something I'd like to keep reserved
> > > for something of more wide usefulness.
> > Can we introduce a new feature like VHOST_BACKEND_F_NOIOMMU in
> > VHOST_VDPA_BACKEND_FEATURES?  We can have below logic based on this
> > feature bit negotiation.
> > Thanks.
> Michael, could you please confirm if adding a new feature to VHOST_VDPA_BACKEND_FEATURES
> is an appropriate solution to support no-IOMMU for the vhost-vdpa backend?


Yes. So the idea is to require both a module parameter, and a
flag set by userspace, to make sure users do not mistakenly
try to assign such devices to VMs.

Thanks.

> > >
> > >
> > > > > > > >
> > > > > > > > I suggest a new domain type for use just for this purpose.
> > > > > >
> > > > > > I'm not sure I get this, we want to bypass IOMMU, so it doesn't
> > > > > > even have a doman.
> > > > >
> > > > > yes, a fake one. or come up with some other flag that userspace will set.
> > > > >
> > > > > > > This way if host has
> > > > > > > > an iommu, then the same kernel can run both VMs with
> > > > > > > > isolation and unsafe embedded apps without.
> > > > > > > Could you provide further details on this concept? What
> > > > > > > criteria would determine the configuration of the new domain
> > > > > > > type? Would this require a boot parameter similar to
> > > > > > > IOMMU_DOMAIN_IDENTITY, such as
> > > > > iommu.passthrough=1 or iommu.pt?
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > >  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++++
> > > > > > > > >  1 file changed, 23 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > > > index bc4a51e4638b..d071c30125aa 100644
> > > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > > @@ -36,6 +36,11 @@ enum {
> > > > > > > > >
> > > > > > > > >  #define VHOST_VDPA_IOTLB_BUCKETS 16
> > > > > > > > >
> > > > > > > > > +bool vhost_vdpa_noiommu;
> > > > > > > > >
> > > +module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > > > > > > > +              vhost_vdpa_noiommu, bool, 0644);
> > > > > > > > >
> > > +MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > > > > > > "Enable
> > > > > > > > > +UNSAFE, no-IOMMU mode.  This mode provides no device
> > > > > > > > > +isolation, no DMA translation, no host kernel protection,
> > > > > > > > > +cannot be used for device assignment to virtual machines,
> > > > > > > > > +requires RAWIO permissions, and will taint the kernel.
> > > > > > > > > +If you do not know what this is
> > > > > for, step away.
> > > > > > > > > +(default: false)");
> > > > > > > > > +
> > > > > > > > >  struct vhost_vdpa_as {
> > > > > > > > >     struct hlist_node hash_link;
> > > > > > > > >     struct vhost_iotlb iotlb; @@ -60,6 +65,7 @@ struct
> > > > > > > > > vhost_vdpa {
> > > > > > > > >     struct vdpa_iova_range range;
> > > > > > > > >     u32 batch_asid;
> > > > > > > > >     bool suspended;
> > > > > > > > > +   bool noiommu_en;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  static DEFINE_IDA(vhost_vdpa_ida); @@ -887,6 +893,10 @@
> > > > > > > > > static void vhost_vdpa_general_unmap(struct vhost_vdpa *v,  {
> > > > > > > > >     struct vdpa_device *vdpa = v->vdpa;
> > > > > > > > >     const struct vdpa_config_ops *ops = vdpa->config;
> > > > > > > > > +
> > > > > > > > > +   if (v->noiommu_en)
> > > > > > > > > +           return;
> > > > > > > > > +
> > > > > > > > >     if (ops->dma_map) {
> > > > > > > > >             ops->dma_unmap(vdpa, asid, map->start, map->size);
> > > > > > > > >     } else if (ops->set_map == NULL) { @@ -980,6 +990,9 @@
> > > > > > > > > static int vhost_vdpa_map(struct vhost_vdpa *v,
> > > > > > > > struct vhost_iotlb *iotlb,
> > > > > > > > >     if (r)
> > > > > > > > >             return r;
> > > > > > > > >
> > > > > > > > > +   if (v->noiommu_en)
> > > > > > > > > +           goto skip_map;
> > > > > > > > > +
> > > > > > > > >     if (ops->dma_map) {
> > > > > > > > >             r = ops->dma_map(vdpa, asid, iova, size, pa, perm, opaque);
> > > > > > > > >     } else if (ops->set_map) { @@ -995,6 +1008,7 @@ static
> > > > > > > > > int vhost_vdpa_map(struct vhost_vdpa *v,
> > > > > > > > struct vhost_iotlb *iotlb,
> > > > > > > > >             return r;
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > > > +skip_map:
> > > > > > > > >     if (!vdpa->use_va)
> > > > > > > > >             atomic64_add(PFN_DOWN(size),
> > > > > > > > > &dev->mm->pinned_vm);
> > > > > > > > >
> > > > > > > > > @@ -1298,6 +1312,7 @@ static int
> > > > > > > > > vhost_vdpa_alloc_domain(struct
> > > > > > > > vhost_vdpa *v)
> > > > > > > > >     struct vdpa_device *vdpa = v->vdpa;
> > > > > > > > >     const struct vdpa_config_ops *ops = vdpa->config;
> > > > > > > > >     struct device *dma_dev = vdpa_get_dma_dev(vdpa);
> > > > > > > > > +   struct iommu_domain *domain;
> > > > > > > > >     const struct bus_type *bus;
> > > > > > > > >     int ret;
> > > > > > > > >
> > > > > > > > > @@ -1305,6 +1320,14 @@ static int
> > > > > > > > > vhost_vdpa_alloc_domain(struct
> > > > > > > > vhost_vdpa *v)
> > > > > > > > >     if (ops->set_map || ops->dma_map)
> > > > > > > > >             return 0;
> > > > > > > > >
> > > > > > > > > +   domain = iommu_get_domain_for_dev(dma_dev);
> > > > > > > > > +   if ((!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
> > > &&
> > > > > > > > > +       vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO)) {
> > > > > > > >
> > > > > > > > So if userspace does not have CAP_SYS_RAWIO instead of
> > > > > > > > failing with a permission error the functionality changes silently?
> > > > > > > > That's confusing, I think.
> > > > > > > Yes, you are correct. I will modify the code to return error
> > > > > > > when vhost_vdpa_noiommu is set and CAP_SYS_RAWIO is not set.
> > > > > > >
> > > > > > > Thanks.
> > > > > > > >
> > > > > > > >
> > > > > > > > > +           add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > > > > > > > +           dev_warn(&v->dev, "Adding kernel taint for
> > > > > > > > > + noiommu on
> > > > > > > > device\n");
> > > > > > > > > +           v->noiommu_en = true;
> > > > > > > > > +           return 0;
> > > > > > > > > +   }
> > > > > > > > >     bus = dma_dev->bus;
> > > > > > > > >     if (!bus)
> > > > > > > > >             return -EFAULT;
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > >
> > > >
> 

