Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D9441F
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588340; cv=none; b=dLonOZbmUQw2fGdU4j1cqaXcyXKf5AJDhwMkwdp/zs5U/XNES7ZDOjjaXayK/Wue/qHcdGC6f06FeyYntWOOpA5/+DiCd2z9iZ8AQ+qVkqTyi3CHXQc4Os7WYm9H8tOuxcxOqxP7PzuwTqVJoImoAdJnbR9iKzjfz5HkYoQ4vcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588340; c=relaxed/simple;
	bh=k8B6CyPX87IjUzz7seUSs4GVLFkNFi53nX/v1ygsxqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pb40nplhYF6v92ONq4M3xhISEZJzyYY3FfPEzo9KE1ZQRlN71Akp0TyfUf8k2JoygVjmGkifvZKEXgZkLgr4v8p4PUR77CVroBgOcWweNXZm4kaFWEBVC1qbbGtTk4wPR1Xj/WqsUwOYTbU+JeCCYHk9NCm2pBxeJUf3RIgtWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WA0XD5lG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WA0XD5lG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718588336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzIM7qnWYIFeQ+gqXw747w+YYItd7hOOn+I2wLHGpfY=;
	b=WA0XD5lGvlYvv6Cm+BIpn557ObtcUBfN2Kx9C+bq3hgCM9KtqbaZep/RDrvjY2yNvXaAGq
	0+1JonctgFzPnc1ybP4J2BqAuowEGgiCfRwVR2ecYB5w5B1Ya0zY9bYMzLm1R2AHoJ0BeP
	eIMLPGjHKWQNN0vmOgvppBUh7d8H0GM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-cIo8b6yYM9WuNjn_z9xmnw-1; Sun, 16 Jun 2024 21:38:55 -0400
X-MC-Unique: cIo8b6yYM9WuNjn_z9xmnw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c2dfbc48easo4177355a91.2
        for <virtualization@lists.linux.dev>; Sun, 16 Jun 2024 18:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718588334; x=1719193134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzIM7qnWYIFeQ+gqXw747w+YYItd7hOOn+I2wLHGpfY=;
        b=wGn2KiqgiP3FV2vlXXZayYfJ9mSS5sFCW+jUaJ2lsaQnwLt8mQ9NDV4IhTyy53ciIU
         gvSd4tizLSvOUYJhsBkrmuyaw/4WXME7vQERPiJtAqawvg3u3V1gp4Urk5ZagYwJG9Zs
         FV6YBTKOmnnOtBv73+zAz5uT1okYwWsUg1nC5pUjozdSwL+HZHBOrZVit5+0Dq8vJGU9
         kkScwbC6R0Oa3XAa365NQvsDj+r0eCeZuFX1GfoWWhGeYae6fLkI3FuM0OM+9zhhC0tg
         u42/RJ3uHGdSfyVEn8aPenQkwt4n7vVIzvYRMTGLjX9MWk/ooHoEeNukuM11ldwSFPMx
         Zksw==
X-Forwarded-Encrypted: i=1; AJvYcCWRDJXiQvoodxC4EglH/EHnnsoF4mo2Bh4ts2NvTDrgBgP8quVfbi2Iu7ftvv4DGu/LAf5aKC/7LpWgh0q8mwfyddVXwT7h472v40Q7CSU=
X-Gm-Message-State: AOJu0YzAlkIBEQne4AJC/vMM99YF7H6JhGsToPdMuNNLv338ShTdoCCn
	Ns3bCVc4O2SazmvpEpTtHFh/BFgLYWc3Ghvg5YQ7YKhjz7AmlKxv15QPDsLNtsCLoVeapwg4M24
	qRQ3bpcLs4ROAV1OHcK+bj1w6rcUND8hlZ5pAh2zn5sU8R/86DxKQWB0f3FOg+4RVUxAoL0VWPG
	jo93x2VwU/yglgXr4cgpfOA7iqPaEsDVX8X/ps99I=
X-Received: by 2002:a17:90b:211:b0:2c4:eab5:1973 with SMTP id 98e67ed59e1d1-2c4eab519e5mr6160863a91.7.1718588333987;
        Sun, 16 Jun 2024 18:38:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwZz7p7KBMVoKQsWbUa2YZvpl3gfjWd+0CYkYTRuUauj3YoG4KAqcmyRmQsUjcTV4F78QvUvhymm8jDxyuwoo=
X-Received: by 2002:a17:90b:211:b0:2c4:eab5:1973 with SMTP id
 98e67ed59e1d1-2c4eab519e5mr6160851a91.7.1718588333562; Sun, 16 Jun 2024
 18:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530101823.1210161-1-schalla@marvell.com> <CACGkMEsxPfck-Ww6CHSod5wP5xLOpS3t2B8qhTL0=PoE3koCGQ@mail.gmail.com>
 <DS0PR18MB5368E02C4DE7AA96CCD299E0A0F82@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEs+s7JEvLXBdyQbj36Y8WSbHXqF2d9HNP3v7CPRPoocXg@mail.gmail.com>
 <DS0PR18MB5368CD9E8E3432A9D19D8C8FA0C02@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240612083001-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240612083001-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:38:41 +0800
Message-ID: <CACGkMEtzm9PHP5OoM-3-4e7JPvPmGn2vdLtzx03gzWfDv6OjkQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Vamsi Krishna Attunuru <vattunuru@marvell.com>, 
	Shijith Thotton <sthotton@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
	Jerin Jacob <jerinj@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 8:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jun 12, 2024 at 09:22:43AM +0000, Srujana Challa wrote:
> >
> > > Subject: Re: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mo=
de
> > >
> > > On Tue, Jun 4, 2024 at 5:29=E2=80=AFPM Srujana Challa <schalla@marvel=
l.com> wrote:
> > > >
> > > > > Subject: [EXTERNAL] Re: [PATCH] vdpa: Add support for no-IOMMU mo=
de
> > > > >
> > > > > Prioritize security for external emails: Confirm sender and conte=
nt
> > > > > safety before clicking links or opening attachments
> > > > >
> > > > > -----------------------------------------------------------------=
---
> > > > > -- On Thu, May 30, 2024 at 6:18=E2=80=AFPM Srujana Challa
> > > > > <schalla@marvell.com>
> > > > > wrote:
> > > > > >
> > > > > > This commit introduces support for an UNSAFE, no-IOMMU mode in =
the
> > > > > > vhost-vdpa driver. When enabled, this mode provides no device
> > > > > > isolation, no DMA translation, no host kernel protection, and
> > > > > > cannot be used for device assignment to virtual machines. It
> > > > > > requires RAWIO permissions and will taint the kernel.
> > > > > > This mode requires enabling the
> > > > > "enable_vhost_vdpa_unsafe_noiommu_mode"
> > > > > > option on the vhost-vdpa driver. This mode would be useful to g=
et
> > > > > > better performance on specifice low end machines and can be
> > > > > > leveraged by embedded platforms where applications run in contr=
olled
> > > environment.
> > > > >
> > > > > I wonder if it's better to do it per driver:
> > > > >
> > > > > 1) we have device that use its own IOMMU, one example is the mlx5
> > > > > vDPA device
> > > > > 2) we have software devices which doesn't require IOMMU at all (b=
ut
> > > > > still with
> > > > > protection)
> > > >
> > > > If I understand correctly, you=E2=80=99re suggesting that we create=
 a module
> > > > parameter specific to the vdpa driver. Then, we can add a flag to t=
he =E2=80=98struct
> > > vdpa_device=E2=80=99
> > > > and set that flag within the vdpa driver based on the module parame=
ter.
> > > > Finally, we would use this flag to taint the kernel and go in no-io=
mmu
> > > > path in the vhost-vdpa driver?
> > >
> > > If it's possible, I would like to avoid changing the vDPA core.
> > >
> > > Thanks
> > According to my understanding of the discussion at the
> > https://lore.kernel.org/all/20240422164108-mutt-send-email-mst@kernel.o=
rg,
> > Michael has suggested focusing on implementing a no-IOMMU mode in vdpa.
> > Michael, could you please confirm if it's fine to transfer all these re=
levant
> > modifications to Marvell's vdpa driver?
> >
> > Thanks.
>
>
> All I said is that octeon driver can be merged without this support.
> Then work on no-iommu can start separately.
>
>
> Whether this belongs in the driver or the core would depend on
> what the use-case is. I have not figured it out yet.
> What you describe seems generic not card-specific though.
> Jason why do you  want this in the driver?

For two reasons:

1) no-IOMMU mode have security implications, make it per driver is
less intrusive
2) I don't know what does "no-IOMMU" mean for software device or
device with on-chip IOMMU

Thanks

>
> > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > ---
> > > > > >  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++++
> > > > > >  1 file changed, 23 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c index
> > > > > > bc4a51e4638b..d071c30125aa 100644
> > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > @@ -36,6 +36,11 @@ enum {
> > > > > >
> > > > > >  #define VHOST_VDPA_IOTLB_BUCKETS 16
> > > > > >
> > > > > > +bool vhost_vdpa_noiommu;
> > > > > > +module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > > > > +                  vhost_vdpa_noiommu, bool, 0644);
> > > > > > +MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode,
> > > > > "Enable
> > > > > > +UNSAFE, no-IOMMU mode.  This mode provides no device isolation=
,
> > > > > > +no DMA translation, no host kernel protection, cannot be used =
for
> > > > > > +device assignment to virtual machines, requires RAWIO
> > > > > > +permissions, and will taint the kernel.  If you do not know wh=
at this is
> > > for, step away.
> > > > > > +(default: false)");
> > > > > > +
> > > > > >  struct vhost_vdpa_as {
> > > > > >         struct hlist_node hash_link;
> > > > > >         struct vhost_iotlb iotlb;
> > > > > > @@ -60,6 +65,7 @@ struct vhost_vdpa {
> > > > > >         struct vdpa_iova_range range;
> > > > > >         u32 batch_asid;
> > > > > >         bool suspended;
> > > > > > +       bool noiommu_en;
> > > > > >  };
> > > > > >
> > > > > >  static DEFINE_IDA(vhost_vdpa_ida); @@ -887,6 +893,10 @@ static
> > > > > > void vhost_vdpa_general_unmap(struct vhost_vdpa *v,  {
> > > > > >         struct vdpa_device *vdpa =3D v->vdpa;
> > > > > >         const struct vdpa_config_ops *ops =3D vdpa->config;
> > > > > > +
> > > > > > +       if (v->noiommu_en)
> > > > > > +               return;
> > > > > > +
> > > > > >         if (ops->dma_map) {
> > > > > >                 ops->dma_unmap(vdpa, asid, map->start, map->siz=
e);
> > > > > >         } else if (ops->set_map =3D=3D NULL) { @@ -980,6 +990,9=
 @@
> > > > > > static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_io=
tlb
> > > *iotlb,
> > > > > >         if (r)
> > > > > >                 return r;
> > > > > >
> > > > > > +       if (v->noiommu_en)
> > > > > > +               goto skip_map;
> > > > > > +
> > > > > >         if (ops->dma_map) {
> > > > > >                 r =3D ops->dma_map(vdpa, asid, iova, size, pa, =
perm, opaque);
> > > > > >         } else if (ops->set_map) { @@ -995,6 +1008,7 @@ static =
int
> > > > > > vhost_vdpa_map(struct vhost_vdpa *v,
> > > > > struct vhost_iotlb *iotlb,
> > > > > >                 return r;
> > > > > >         }
> > > > > >
> > > > > > +skip_map:
> > > > > >         if (!vdpa->use_va)
> > > > > >                 atomic64_add(PFN_DOWN(size), &dev->mm->pinned_v=
m);
> > > > > >
> > > > > > @@ -1298,6 +1312,7 @@ static int vhost_vdpa_alloc_domain(struct
> > > > > vhost_vdpa *v)
> > > > > >         struct vdpa_device *vdpa =3D v->vdpa;
> > > > > >         const struct vdpa_config_ops *ops =3D vdpa->config;
> > > > > >         struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> > > > > > +       struct iommu_domain *domain;
> > > > > >         const struct bus_type *bus;
> > > > > >         int ret;
> > > > > >
> > > > > > @@ -1305,6 +1320,14 @@ static int vhost_vdpa_alloc_domain(struc=
t
> > > > > vhost_vdpa *v)
> > > > > >         if (ops->set_map || ops->dma_map)
> > > > > >                 return 0;
> > > > > >
> > > > > > +       domain =3D iommu_get_domain_for_dev(dma_dev);
> > > > > > +       if ((!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENTI=
TY) &&
> > > > > > +           vhost_vdpa_noiommu && capable(CAP_SYS_RAWIO)) {
> > > > > > +               add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > > > > +               dev_warn(&v->dev, "Adding kernel taint for noio=
mmu
> > > > > > + on
> > > > > device\n");
> > > > > > +               v->noiommu_en =3D true;
> > > > > > +               return 0;
> > > > > > +       }
> > > > > >         bus =3D dma_dev->bus;
> > > > > >         if (!bus)
> > > > > >                 return -EFAULT;
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > >
> >
>

