Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10E2907
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717632914; cv=none; b=K1m3mVeSO8NuleslN3AYRPYvsqcoZOW40u2xOwlOLRD/M+sQo77y9WF/AhpsyXjxDQ4L+S4KOg77djV1XJiVwwHoJPOSeTTloqp9VVZ0V3Rkk1d0Ahq25JGa0bxDjk3lvGxuzwAigN4li+2bq+L4R2MM6fExsNeKToO+5l1T45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717632914; c=relaxed/simple;
	bh=oIKoXH9D7HMjEDPlSiJe/WjYkAVEorZnY9G0TwPTBnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrzMXdks5/Nj3BE27zL8tNzSSRxbF2FFwX/tf7obvcQpSwTBJ22GwcJ/N9GK7FZt6JFvqecP1Ih4NK2ny7oUoqlfJMZ7Y4KDMYgKQJ5+Nbi8uMu/M3Bq2gGT0QqVeVRVYnayka0dH3F4rgAGsTu8iS6Cmr0r4HWlvJ40kH4jEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Witp8dht; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Witp8dht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717632911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8itLZ9LZNltxrv5n2ConYot247plD1jbWfo9rsEb1E=;
	b=Witp8dht4hinp3bmrD57tvkGdxb+WbtrxWVm/oazhOiSKKi86bcTNouzF1BwmBWcd4rKIS
	fSoOV0Hi9swIm1iiEVZwipPgDBMkaJWTqdRoqEdE19LngtJsmlWLoI5kH80VOl6kztdzHg
	19DxmUmJswRfT7KGtjR0kjqc/bR+IRc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-DSZuPyVnMaqXI-bFtwaGMg-1; Wed, 05 Jun 2024 20:15:10 -0400
X-MC-Unique: DSZuPyVnMaqXI-bFtwaGMg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1e6a08555so1272856a91.0
        for <virtualization@lists.linux.dev>; Wed, 05 Jun 2024 17:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717632909; x=1718237709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8itLZ9LZNltxrv5n2ConYot247plD1jbWfo9rsEb1E=;
        b=fLrTUFZqpxTdSw30pPk0Y9RmHcc/TpPyiJCk1WrTTmNLuJeJHO3zacgbBzji1tonhV
         YkeydS6zdVOlVsv7bLMBQu/PEuCZCbE8lIW8aPhJAtndeXuV5zcZayLyFVOrebG/2s9p
         wZZbQU9kphhAuIuJu00XKjmRQa6B7TYtsfO0l8nUM5EHc1r9wZZRi/QyCMmgi4SFnKmF
         2++W46lRKzxbYGkEnyvAcvXYuKB+CrLHXwmqoCbNEi4xH0tvj8aPD9bBoEAAYg2QpIS8
         VgkFd8/zB2y+I8dfenT7PQWmSqYXwXFTUZc+3NxzigEN0UZ0NX75Ppeq0gg4+KHCsvhO
         1WEg==
X-Forwarded-Encrypted: i=1; AJvYcCX9UG3inkMpQl1ilE2DrFyRuF6CbrIXMMHNynjsEg+Ga78vTj4V7rgeMfN2/j3MxUJjxRHLW8dV7adqn1m7ZCz4cz/3Jao6vqe4VZjqG5w=
X-Gm-Message-State: AOJu0YxuKtYmVY4aj3Sk29TzrL0vlHRfasLR6VjCBOBJQDlWXPv+ojRv
	LPGQoAMotKaEoJ0wjdVguWp7mC4u42wg7H3XNcXkehbLWqDoFmRKHkcT0EpA+kqeQIGhXrZcyRd
	JuvHTEY1aY0kBgu6PClPrDU2pUI4ZexVMK0df9OeBySwc1jsh+xAy9xUNvk7BDuOBSQ5EKhv0E7
	qBlwcJ9+udN9T38TdJHPpD38SUwvR+UONux9jR47Q=
X-Received: by 2002:a17:90a:985:b0:2c2:2ea9:ba59 with SMTP id 98e67ed59e1d1-2c299984248mr1520166a91.6.1717632908955;
        Wed, 05 Jun 2024 17:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCZwSAUjgUah2DqjpTr/8KkQrp+BykeD/SiOBOYDeJCoP/vG0SK294gvelnwRfXH/AfIxjhXpESqXJVRWa/d4=
X-Received: by 2002:a17:90a:985:b0:2c2:2ea9:ba59 with SMTP id
 98e67ed59e1d1-2c299984248mr1520140a91.6.1717632908527; Wed, 05 Jun 2024
 17:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530101823.1210161-1-schalla@marvell.com> <CACGkMEsxPfck-Ww6CHSod5wP5xLOpS3t2B8qhTL0=PoE3koCGQ@mail.gmail.com>
 <s5tkqdls55n535tvrlalsej44hvrzqgcdqkspyxrvnl4muard6@nyvdw7xptoze>
In-Reply-To: <s5tkqdls55n535tvrlalsej44hvrzqgcdqkspyxrvnl4muard6@nyvdw7xptoze>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 08:14:57 +0800
Message-ID: <CACGkMEuq9YWj4D58dbi3SkVmnd+RWcyhuDqZQng-_UOuXMmdZQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Add support for no-IOMMU mode
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, mst@redhat.com, vattunuru@marvell.com, 
	sthotton@marvell.com, ndabilpuram@marvell.com, jerinj@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:55=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, May 31, 2024 at 10:26:31AM GMT, Jason Wang wrote:
> >On Thu, May 30, 2024 at 6:18=E2=80=AFPM Srujana Challa <schalla@marvell.=
com> wrote:
> >>
> >> This commit introduces support for an UNSAFE, no-IOMMU mode in the
> >> vhost-vdpa driver. When enabled, this mode provides no device isolatio=
n,
> >> no DMA translation, no host kernel protection, and cannot be used for
> >> device assignment to virtual machines. It requires RAWIO permissions
> >> and will taint the kernel.
> >> This mode requires enabling the "enable_vhost_vdpa_unsafe_noiommu_mode=
"
> >> option on the vhost-vdpa driver. This mode would be useful to get
> >> better performance on specifice low end machines and can be leveraged
> >> by embedded platforms where applications run in controlled environment=
.
> >
> >I wonder if it's better to do it per driver:
> >
> >1) we have device that use its own IOMMU, one example is the mlx5 vDPA d=
evice
> >2) we have software devices which doesn't require IOMMU at all (but
> >still with protection)
>
> It worries me even if the module parameter is the best thing.
> What about a sysfs entry?

Not sure, but VFIO uses a module parameter, and using sysfs requires
some synchronization. We need either disable the write when the device
is probed or allow change the value.

Thanks

>
> Thanks,
> Stefano
>
> >
> >Thanks
> >
> >>
> >> Signed-off-by: Srujana Challa <schalla@marvell.com>
> >> ---
> >>  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++++
> >>  1 file changed, 23 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index bc4a51e4638b..d071c30125aa 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -36,6 +36,11 @@ enum {
> >>
> >>  #define VHOST_VDPA_IOTLB_BUCKETS 16
> >>
> >> +bool vhost_vdpa_noiommu;
> >> +module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
> >> +                  vhost_vdpa_noiommu, bool, 0644);
> >> +MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode, "Enable UNSAF=
E, no-IOMMU mode.  This mode provides no device isolation, no DMA translati=
on, no host kernel protection, cannot be used for device assignment to virt=
ual machines, requires RAWIO permissions, and will taint the kernel.  If yo=
u do not know what this is for, step away. (default: false)");
> >> +
> >>  struct vhost_vdpa_as {
> >>         struct hlist_node hash_link;
> >>         struct vhost_iotlb iotlb;
> >> @@ -60,6 +65,7 @@ struct vhost_vdpa {
> >>         struct vdpa_iova_range range;
> >>         u32 batch_asid;
> >>         bool suspended;
> >> +       bool noiommu_en;
> >>  };
> >>
> >>  static DEFINE_IDA(vhost_vdpa_ida);
> >> @@ -887,6 +893,10 @@ static void vhost_vdpa_general_unmap(struct vhost=
_vdpa *v,
> >>  {
> >>         struct vdpa_device *vdpa =3D v->vdpa;
> >>         const struct vdpa_config_ops *ops =3D vdpa->config;
> >> +
> >> +       if (v->noiommu_en)
> >> +               return;
> >> +
> >>         if (ops->dma_map) {
> >>                 ops->dma_unmap(vdpa, asid, map->start, map->size);
> >>         } else if (ops->set_map =3D=3D NULL) {
> >> @@ -980,6 +990,9 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, st=
ruct vhost_iotlb *iotlb,
> >>         if (r)
> >>                 return r;
> >>
> >> +       if (v->noiommu_en)
> >> +               goto skip_map;
> >> +
> >>         if (ops->dma_map) {
> >>                 r =3D ops->dma_map(vdpa, asid, iova, size, pa, perm, o=
paque);
> >>         } else if (ops->set_map) {
> >> @@ -995,6 +1008,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, s=
truct vhost_iotlb *iotlb,
> >>                 return r;
> >>         }
> >>
> >> +skip_map:
> >>         if (!vdpa->use_va)
> >>                 atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
> >>
> >> @@ -1298,6 +1312,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_=
vdpa *v)
> >>         struct vdpa_device *vdpa =3D v->vdpa;
> >>         const struct vdpa_config_ops *ops =3D vdpa->config;
> >>         struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> >> +       struct iommu_domain *domain;
> >>         const struct bus_type *bus;
> >>         int ret;
> >>
> >> @@ -1305,6 +1320,14 @@ static int vhost_vdpa_alloc_domain(struct vhost=
_vdpa *v)
> >>         if (ops->set_map || ops->dma_map)
> >>                 return 0;
> >>
> >> +       domain =3D iommu_get_domain_for_dev(dma_dev);
> >> +       if ((!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) &&
> >> +           vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO)) {
> >> +               add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> >> +               dev_warn(&v->dev, "Adding kernel taint for noiommu on =
device\n");
> >> +               v->noiommu_en =3D true;
> >> +               return 0;
> >> +       }
> >>         bus =3D dma_dev->bus;
> >>         if (!bus)
> >>                 return -EFAULT;
> >> --
> >> 2.25.1
> >>
> >
> >
>

