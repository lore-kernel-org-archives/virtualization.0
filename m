Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17531D54FE
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777716; cv=none; b=pzMzrnX6z6AC29c1F1tLSqdkqtV/MFKVnvQ77dPXe4v8fZ4YCfZcnhSvYflhlAT5QWDomox4XXJ6X2Ud4BNYgW/wlJttzypqO/g0iy7MBeLiyaeI7XhlGtcTNj7+ITYJBS9IRyMUN04U6PPAtfNf9QdTS8YpD6gVpdiPlX3Eh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777716; c=relaxed/simple;
	bh=IX7onM6t1g0yXJzmKnn+MXAxwpV3bvYo1FiZM0KxHHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HibHqMDkRdyptDfsf4VHeeAi0GfUWzOUUdvgD+qC0/uRdq7tIWZE8ojIOeG2EsVjBfaM+TkwxEz0QMDrmlDp6iTttpGaGrEXvMBDICF+9ZYgSgPgqS7dELsGkZL+WjA0clZ5D5xonaQt2/bvqhndnR9Ky77T2qse11am/MCSVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTqXaRiI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTqXaRiI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749777712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bo2h+PBuf6+NkM+R+zMkzsJv1u407l6kqDz6OFPMQnw=;
	b=KTqXaRiIBawY71BaxpNarYEupYzvtCnNh7ZU67epqySU+o7R/g+lQFQ7OZN+9EmyAffnWp
	A6Kp6l/xUgwXdSk8QEPcSk2tuBEw+u73XIny1sRtHGrnVhjRjSXojYaLybRxy17EWOXpUz
	aRR/dMhubc9M2Gd8E3aQeE4dUVlT+y0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-cMVYHXLhMieMF94IZvpwYg-1; Thu, 12 Jun 2025 21:21:51 -0400
X-MC-Unique: cMVYHXLhMieMF94IZvpwYg-1
X-Mimecast-MFC-AGG-ID: cMVYHXLhMieMF94IZvpwYg_1749777710
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b16b35ea570so1569806a12.0
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 18:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749777710; x=1750382510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bo2h+PBuf6+NkM+R+zMkzsJv1u407l6kqDz6OFPMQnw=;
        b=h+GW4z1tT64F3k6N57TDLA6VjbOzL727OwcZImhIXv+Gv5kSNaLexSNarNEUg0iOj+
         e4DHnar3x3fulM13g+k9LOlXbBZ/c9JldbxS4FaupRnpcMVWnajxnzYxe8q+WnllVKW3
         +GwSKl6TMlwFExmvzx197n+aTRhXk57K6O2wTdUqj153WJAjdJa+bixOdoQyv9/fpu9f
         lX0CFSflrhhM4qZ/zbNk8Oi5ec6BXoaJNXRj5aowfuc1s7hRBXKl6NBnPXmi7kDVCGu8
         q+MdfAxr+ow6W9vaEvi+RqJSOw6DP/BYUrhbsXVRf2sfPMNcw4DL5yqOoqz8wl+Hf0ef
         8d7g==
X-Forwarded-Encrypted: i=1; AJvYcCW5QUJtpwyh1Tvcbr6YZHQJ5s4aPxjCJ860YAtg3XHeGWbpjk+L4LGBMqr5C8t3xh5C4kPH6QAEMyRh9CoajQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdsocXjK6hplJvOmxQsCkdyIxH6/JGLPyIU67DCgFpu4WyJcGR
	Y3BMosg2ob+I1eVAjhJmDkET7mcQnWoNjqOFQ5oLACe7lbCU36tsJgjWD6kefMRN3i645PgcdZ6
	WDZKod91peMU6+8e7KTLZ8RjTtYcTkVJX3Bf97nksRz5V0rImtSH+qk7b0uM92IUs7//TU+K2mw
	ZRrgSZgMWem9smyp0YbVyVVqhZZg/vAH3XU0xsQHfyd5I=
X-Gm-Gg: ASbGncuZuGsN1BQ1cOf1FJHXIRsBViijTLibOWH7iRKbxKh9YBxujuZdKOdFguuouvy
	KZtjniMXU5K7iRQJtn6K9JMs2ZTK0rzFaUUmvlne1xgdpCOrbNp5hDlyhrZQYysHEj+zdb59oDy
	3h
X-Received: by 2002:a05:6a20:4313:b0:215:d565:3026 with SMTP id adf61e73a8af0-21facf02d6fmr1516032637.20.1749777710059;
        Thu, 12 Jun 2025 18:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDCgi+6KEbKPeKZnuLUI1OYWmJjOb+6Hl6QFU/vx2LYDntag09IMPv0ItuHB3BuA02QSlKplbLb/5kAYMOqgk=
X-Received: by 2002:a05:6a20:4313:b0:215:d565:3026 with SMTP id
 adf61e73a8af0-21facf02d6fmr1515989637.20.1749777709394; Thu, 12 Jun 2025
 18:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-4-eperezma@redhat.com>
 <CACGkMEvNMc_Ja09=OknFH0obUtW8nGz5aiee9tZVhn+N58w70w@mail.gmail.com> <CAJaqyWcjA_9e+4K=KG5uwRuY-5xLkUf9=4P0zjdQ3z8gd4cxNQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcjA_9e+4K=KG5uwRuY-5xLkUf9=4P0zjdQ3z8gd4cxNQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Jun 2025 09:21:38 +0800
X-Gm-Features: AX0GCFuJJoyFfcf9SPPhcsbtnhqsZ-uLi-k6hnHqjAddex24gISkRo0p_4IKazM
Message-ID: <CACGkMEvT_1ngR9Cs1A6ghNhZtyXiAb7qZq-Xj=7NWOzO9o5C=w@mail.gmail.com>
Subject: Re: [RFC 3/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5M-P4QudOFH2zd-7puHXucw2aDJII39amS038IqNuvw_1749777710
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:25=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jun 12, 2025 at 2:30=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > Make one IOTLB domain per address space, and allow the driver to assi=
gn
> > > each ASID to a vq group.  Each address space via an dedicated identif=
ier
> > > (ASID).
> > >
> > > During vDPA device allocation, the VDUSE device needs to report the
> > > number of address spaces supported.  Then the vdpa driver is able to
> > > configure them.  At this moment only vhost_vdpa is able to do it.
> > >
> > > This helps to isolate the environments for the virtqueue that will no=
t
> > > be assigned directly.  E.g in the case of virtio-net, the control
> > > virtqueue will not be assigned directly to guest.
> > >
> > > TODO: Ideally, umem should not be duplicated.  But it is hard or
> > > impossible to refactor everything around one single umem.  So should =
we
> > > continue with device specifying umem per vq group?
> >
> > This is a good question.
> >
> > I think umem should be bound to address space and umem needs to be isol=
ated.
> >
> > For the issue of complexity, we can simply extend the vduse_iova_umem
> > to have an asid field. But it looks like it needs more work as:
> >
> > struct vduse_iova_umem {
> >         __u64 uaddr;
> >         __u64 iova;
> >         __u64 size;
> >         __u64 reserved[3];
> > };
> >
> > Do we have a way to know if reserved is used or not (as we are lacking
> > a flag field anyhow ....).
> >
>
> I'd say that we should work the same way as the rest of the structs:
> We add the asid field, and if the API v1 is negotiated we handle it as
> ASID. If it is not negotiated, it is reserved.

Ok, that makes sense.

>
> > So we probably need a new uAPI like vduse_iova_umem_v2 that includes a
> > flag field at least.
> >
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 250 +++++++++++++++++++++------=
--
> > >  include/uapi/linux/vduse.h         |  38 ++++-
> > >  2 files changed, 216 insertions(+), 72 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 6fa687bc4912..d51e4f26fe72 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -51,6 +51,11 @@
> > >   */
> > >  #define VDUSE_MAX_VQ_GROUPS 2
> > >
> > > +/*
> > > + * Let's make it 2 for simplicity.
> > > + */
> > > +#define VDUSE_MAX_ASID 2
> >
> > Similar to previous patch, it's better to increase this otherwise we
> > need new uAPI or it requires the userspace to probe the maximum value
> > once we decide to change it in the future.
> >
>
> I'm ok with this, but what is a good max value? UINT32_MAX seems excessiv=
e?

Maybe 64 or 256.

>
> This requires us to allocate arrays for both vduse_dev->domain and
> vduse_dev->umem, so we need to set a reasonable value.

Could we do the allocation based on the userspace privionsing?

>
> > > +
> > >  #define IRQ_UNBOUND -1
> > >
> > >  struct vduse_virtqueue {
> > > @@ -92,7 +97,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_iova_domain *domain[VDUSE_MAX_ASID];
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -120,7 +125,8 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > -       struct vduse_umem *umem;
> > > +       u32 nas;
> > > +       struct vduse_umem *umem[VDUSE_MAX_ASID];
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         struct mutex domain_lock;
> > > @@ -436,11 +442,14 @@ static __poll_t vduse_dev_poll(struct file *fil=
e, poll_table *wait)
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > >
> > >         /* The coherent mappings are handled in vduse_dev_free_cohere=
nt() */
> > > -       if (domain && domain->bounce_map)
> > > -               vduse_domain_reset_bounce_map(domain);
> > > +       for (i =3D 0; i < dev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D dev->domain[i];
> > > +
> > > +               if (domain && domain->bounce_map)
> > > +                       vduse_domain_reset_bounce_map(domain);
> > > +       }
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > @@ -617,6 +626,23 @@ static u32 vduse_get_vq_group(struct vdpa_device=
 *vdpa, u16 idx)
> > >         return msg.resp.vq_group.num;
> > >  }
> > >
> > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned i=
nt group,
> > > +                               unsigned int asid)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > +               return -EINVAL;
> > > +
> > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > +       msg.req.vq_group_asid.group =3D group;
> > > +       msg.req.vq_group_asid.asid =3D asid;
> > > +
> > > +       return vduse_dev_msg_sync(dev, &msg);
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -788,13 +814,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
e *vdpa,
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         int ret;
> > >
> > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > +       ret =3D vduse_domain_set_map(dev->domain[asid], iotlb);
> > >         if (ret)
> > >                 return ret;
> > >
> > >         ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > >         if (ret) {
> > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > +               vduse_domain_clear_map(dev->domain[asid], iotlb);
> > >                 return ret;
> > >         }
> > >
> > > @@ -837,6 +863,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > >
> > > @@ -845,9 +872,12 @@ static void vduse_dev_sync_single_for_device(str=
uct device *dev,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > >
> > > -       vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> > > +       for (int i =3D 0; i < vdev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D vdev->domain[i];
> >
> > Interesting, I thought there could be a way to deduce the iova domain
> > from the dma device since virtio supports per virtqueue dma device
> > now. For example, I don't see get_vq_dma_dev() implemented in this
> > patch.
>
> vhost_vdpa does not interact with it so it was not needed for the RFC.
> For example, the simulator does not implement it either and it works
> with ASID.

Right, the reason for it is:

1) in vdpasim_create() we assign vdpa device as the device device:

vdpasim->vdpa.dma_dev =3D dev;

2) since the vDPA device itself can't do DMA, it tricks the DMA ops to use =
a PA
3) we do 1:1 mapping in vringh IOTLB by default to make the PA trick work:

               vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX, 0,
                                      VHOST_MAP_RW);

4) This trick works the case oneday virtio_vdpa may use
set_group_asid() as well, as all the AS are using PA

Note that it's 2) that is blamed by the DMA maintainer.

It looks different from VDUSE here:

1) VDUSE has its own dma_ops, each as is backed by different IOVA
domain as well as IOVA address
2) vduse_domain_sync_single_for_device() will trigger unnecessary
IOTLB synchronizations

>
> > But anyhow maybe we need to revisit this point as DMA
> > mainatiner ask to fix the abuse of the dma device so we don't need a
> > trick for dma dev anymore if we design the new mapping API in virtio
> > core correctly.
> >
> > > +
> > > +               vduse_domain_sync_single_for_device(domain, dma_addr,=
 size, dir);
> > > +       }
> > >  }
> > >
> > >  static void vduse_dev_sync_single_for_cpu(struct device *dev,
> > > @@ -855,9 +885,12 @@ static void vduse_dev_sync_single_for_cpu(struct=
 device *dev,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > >
> > > -       vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > > +       for (int i =3D 0; i < vdev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D vdev->domain[i];
> > > +
> > > +               vduse_domain_sync_single_for_cpu(domain, dma_addr, si=
ze, dir);
> > > +       }
> > >  }
> > >
> > >  static dma_addr_t vduse_dev_map_page(struct device *dev, struct page=
 *page,
> > > @@ -866,7 +899,7 @@ static dma_addr_t vduse_dev_map_page(struct devic=
e *dev, struct page *page,
> > >                                      unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D vdev->domain[0];
> >
> > Any reason that we need to assume asid 0 in this case?
> >
>
> At this moment, virtio_vdpa is the only one using these functions and
> it is not able to change ASID. So this must be 0 for the moment. But
> yes, this should be better addressed by knowing what vq group is this
> referring to.

My plan is to

1) introduce map_ops() in the virtio_device()
2) in PCI, it will be converted to DMA ops
3) for vDPA, it will be converted to vDPA specific ops
4) get_vq_dma_dev() will be converted to get_vq_map_token(), so each
vq could provide it's own token
5) when the virtio core tries to do mapping, it will pass per vq dma
token as parameters
6) so vduse here can receive a per virtqueue token where it can map it
to group then ASID

>
> > >
> > >         return vduse_domain_map_page(domain, page, offset, size, dir,=
 attrs);
> > >  }
> > > @@ -876,7 +909,7 @@ static void vduse_dev_unmap_page(struct device *d=
ev, dma_addr_t dma_addr,
> > >                                 unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D vdev->domain[0];
> > >
> > >         return vduse_domain_unmap_page(domain, dma_addr, size, dir, a=
ttrs);
> > >  }
> > > @@ -886,7 +919,7 @@ static void *vduse_dev_alloc_coherent(struct devi=
ce *dev, size_t size,
> > >                                         unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D vdev->domain[0];
> > >         unsigned long iova;
> > >         void *addr;
> > >
> > > @@ -906,17 +939,25 @@ static void vduse_dev_free_coherent(struct devi=
ce *dev, size_t size,
> > >                                         unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D vdev->domain[0];
> > >
> > >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, att=
rs);
> > >  }
> > >
> > > +/* TODO check if this is correct */
> > >  static size_t vduse_dev_max_mapping_size(struct device *dev)
> > >  {
> > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       size_t max_mapping_size =3D 0;
> > > +
> > > +       for (int i =3D 0; i < vdev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D vdev->domain[i];
> > >
> > > -       return domain->bounce_size;
> > > +               if (domain->bounce_size > max_mapping_size)
> > > +                       max_mapping_size =3D domain->bounce_size;
> > > +       }
> > > +
> > > +       return max_mapping_size;
> > >  }
> > >
> > >  static const struct dma_map_ops vduse_dev_dma_ops =3D {
> > > @@ -1054,31 +1095,32 @@ static int vduse_dev_queue_irq_work(struct vd=
use_dev *dev,
> > >         return ret;
> > >  }
> > >
> > > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> > >                                 u64 iova, u64 size)
> > >  {
> > >         int ret;
> > >
> > >         mutex_lock(&dev->mem_lock);
> > >         ret =3D -ENOENT;
> > > -       if (!dev->umem)
> > > +       if (!dev->umem[asid])
> > >                 goto unlock;
> > >
> > >         ret =3D -EINVAL;
> > > -       if (!dev->domain)
> > > +       if (!dev->domain[asid])
> > >                 goto unlock;
> > >
> > > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounc=
e_size)
> > > +       if (dev->umem[asid]->iova !=3D iova ||
> > > +           size !=3D dev->domain[asid]->bounce_size)
> > >                 goto unlock;
> > >
> > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > -       unpin_user_pages_dirty_lock(dev->umem->pages,
> > > -                                   dev->umem->npages, true);
> > > -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > > -       mmdrop(dev->umem->mm);
> > > -       vfree(dev->umem->pages);
> > > -       kfree(dev->umem);
> > > -       dev->umem =3D NULL;
> > > +       vduse_domain_remove_user_bounce_pages(dev->domain[asid]);
> > > +       unpin_user_pages_dirty_lock(dev->umem[asid]->pages,
> > > +                                   dev->umem[asid]->npages, true);
> > > +       atomic64_sub(dev->umem[asid]->npages, &dev->umem[asid]->mm->p=
inned_vm);
> > > +       mmdrop(dev->umem[asid]->mm);
> > > +       vfree(dev->umem[asid]->pages);
> > > +       kfree(dev->umem[asid]);
> > > +       dev->umem[asid] =3D NULL;
> > >         ret =3D 0;
> > >  unlock:
> > >         mutex_unlock(&dev->mem_lock);
> > > @@ -1086,7 +1128,7 @@ static int vduse_dev_dereg_umem(struct vduse_de=
v *dev,
> > >  }
> > >
> > >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > > -                             u64 iova, u64 uaddr, u64 size)
> > > +                             u32 asid, u64 iova, u64 uaddr, u64 size=
)
> > >  {
> > >         struct page **page_list =3D NULL;
> > >         struct vduse_umem *umem =3D NULL;
> > > @@ -1094,14 +1136,14 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > >         unsigned long npages, lock_limit;
> > >         int ret;
> > >
> > > -       if (!dev->domain || !dev->domain->bounce_map ||
> > > -           size !=3D dev->domain->bounce_size ||
> > > +       if (!dev->domain[asid] || !dev->domain[asid]->bounce_map ||
> > > +           size !=3D dev->domain[asid]->bounce_size ||
> > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > >                 return -EINVAL;
> > >
> > >         mutex_lock(&dev->mem_lock);
> > >         ret =3D -EEXIST;
> > > -       if (dev->umem)
> > > +       if (dev->umem[asid])
> > >                 goto unlock;
> > >
> > >         ret =3D -ENOMEM;
> > > @@ -1125,7 +1167,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >                 goto out;
> > >         }
> > >
> > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->domain[asid],
> > >                                                  page_list, pinned);
> > >         if (ret)
> > >                 goto out;
> > > @@ -1138,7 +1180,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >         umem->mm =3D current->mm;
> > >         mmgrab(current->mm);
> > >
> > > -       dev->umem =3D umem;
> > > +       dev->umem[asid] =3D umem;
> > >  out:
> > >         if (ret && pinned > 0)
> > >                 unpin_user_pages(page_list, pinned);
> > > @@ -1181,26 +1223,42 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >
> > >         switch (cmd) {
> > >         case VDUSE_IOTLB_GET_FD: {
> > > -               struct vduse_iotlb_entry entry;
> > > +               struct vduse_iotlb_entry_v2 entry =3D {};
> > > +               struct vduse_iotlb_entry entry_old;
> > >                 struct vhost_iotlb_map *map;
> > >                 struct vdpa_map_file *map_file;
> > >                 struct file *f =3D NULL;
> > >
> > >                 ret =3D -EFAULT;
> > > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > > -                       break;
> > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > > +                       if (copy_from_user(&entry, argp, sizeof(entry=
)))
> > > +                               break;
> > > +               } else {
> > > +                       if (copy_from_user(&entry_old, argp,
> > > +                                          sizeof(entry_old)))
> > > +                               break;
> > > +
> > > +                       entry.offset =3D entry_old.offset;
> > > +                       entry.start =3D entry_old.start;
> > > +                       entry.last =3D entry_old.last;
> > > +                       entry.perm =3D entry_old.perm;
> >
> > I wonder if a new ioctl is needed.
> >
>
> The problem is that vduse_iotlb_entry is already used in full, can we
> extend the argument size without introducing the new ioctl?

Yes, I think it should work if VDUSE_API_VERSION_1 makes sense.

>
> > > +               }
> > >
> > >                 ret =3D -EINVAL;
> > >                 if (entry.start > entry.last)
> > >                         break;
> > >
> > > +               if (entry.asid >=3D dev->nas)
> > > +                       break;
> > > +
> > >                 mutex_lock(&dev->domain_lock);
> > > -               if (!dev->domain) {
> > > +               /* TODO accessing an array with idx from userspace, m=
itigations? */
> > > +               if (!dev->domain[entry.asid]) {
> > >                         mutex_unlock(&dev->domain_lock);
> > >                         break;
> > >                 }
> > > -               spin_lock(&dev->domain->iotlb_lock);
> > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > > +               spin_lock(&dev->domain[entry.asid]->iotlb_lock);
> > > +               map =3D vhost_iotlb_itree_first(dev->domain[entry.asi=
d]->iotlb,
> > >                                               entry.start, entry.last=
);
> > >                 if (map) {
> > >                         map_file =3D (struct vdpa_map_file *)map->opa=
que;
> > > @@ -1210,7 +1268,7 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> > >                         entry.last =3D map->last;
> > >                         entry.perm =3D map->perm;
> > >                 }
> > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > +               spin_unlock(&dev->domain[entry.asid]->iotlb_lock);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 ret =3D -EINVAL;
> > >                 if (!f)
> > > @@ -1360,12 +1418,18 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                         break;
> > >
> > >                 ret =3D -EINVAL;
> > > +               /* TODO: Using asid from userspace, need to mitigate?=
 */
> > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > -                                sizeof(umem.reserved)))
> > > +                                sizeof(umem.reserved)) ||
> > > +                   !is_mem_zero((const char *)umem.reserved2,
> > > +                                sizeof(umem.reserved2)) ||
> > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > +                    umem.asid !=3D 0) ||
> > > +                    umem.asid >=3D dev->nas)
> >
> > This is probably a hint that we need a new uAPI, see my comment for cha=
ngelog.
> >
> > >                         break;
> > >
> > >                 mutex_lock(&dev->domain_lock);
> > > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > > +               ret =3D vduse_dev_reg_umem(dev, umem.asid, umem.iova,
> > >                                          umem.uaddr, umem.size);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 break;
> > > @@ -1378,15 +1442,23 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                         break;
> > >
> > >                 ret =3D -EINVAL;
> > > +               /* TODO: Using asid from userspace, need to mitigate?=
 */
> > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > -                                sizeof(umem.reserved)))
> > > +                                sizeof(umem.reserved)) ||
> > > +                   !is_mem_zero((const char *)umem.reserved2,
> > > +                                sizeof(umem.reserved2)) ||
> > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > +                    umem.asid !=3D 0) ||
> > > +                    umem.asid >=3D dev->nas)
> > >                         break;
> > > +
> > >                 mutex_lock(&dev->domain_lock);
> > > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > > +               ret =3D vduse_dev_dereg_umem(dev, umem.asid, umem.iov=
a,
> > >                                            umem.size);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 break;
> > >         }
> > > +       /* TODO can we merge this with GET_FD? */
> > >         case VDUSE_IOTLB_GET_INFO: {
> > >                 struct vduse_iova_info info;
> > >                 struct vhost_iotlb_map *map;
> > > @@ -1399,27 +1471,32 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                 if (info.start > info.last)
> > >                         break;
> > >
> > > +               if (info.asid >=3D dev->nas)
> > > +                       break;
> > > +
> > >                 if (!is_mem_zero((const char *)info.reserved,
> > >                                  sizeof(info.reserved)))
> > >                         break;
> > >
> > >                 mutex_lock(&dev->domain_lock);
> > > -               if (!dev->domain) {
> > > +               /* TODO asid comes from userspace. mitigations? */
> > > +               if (!dev->domain[info.asid]) {
> > >                         mutex_unlock(&dev->domain_lock);
> > >                         break;
> > >                 }
> > > -               spin_lock(&dev->domain->iotlb_lock);
> > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > > +               spin_lock(&dev->domain[info.asid]->iotlb_lock);
> > > +               map =3D vhost_iotlb_itree_first(dev->domain[info.asid=
]->iotlb,
> > >                                               info.start, info.last);
> > >                 if (map) {
> > >                         info.start =3D map->start;
> > >                         info.last =3D map->last;
> > >                         info.capability =3D 0;
> > > -                       if (dev->domain->bounce_map && map->start =3D=
=3D 0 &&
> > > -                           map->last =3D=3D dev->domain->bounce_size=
 - 1)
> > > +                       if (dev->domain[info.asid]->bounce_map &&
> > > +                           map->start =3D=3D 0 &&
> > > +                           map->last =3D=3D dev->domain[info.asid]->=
bounce_size - 1)
> > >                                 info.capability |=3D VDUSE_IOVA_CAP_U=
MEM;
> > >                 }
> > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > +               spin_unlock(&dev->domain[info.asid]->iotlb_lock);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 if (!map)
> > >                         break;
> > > @@ -1444,8 +1521,13 @@ static int vduse_dev_release(struct inode *ino=
de, struct file *file)
> > >         struct vduse_dev *dev =3D file->private_data;
> > >
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (dev->domain)
> > > -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size=
);
> > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > +               if (dev->domain[i]) {
> > > +                       vduse_dev_dereg_umem(dev, i, 0,
> > > +                                            dev->domain[i]->bounce_s=
ize);
> > > +                       dev->domain[i] =3D NULL;
> > > +               }
> > > +       }
> > >         mutex_unlock(&dev->domain_lock);
> > >         spin_lock(&dev->msg_lock);
> > >         /* Make sure the inflight messages can processed after reconn=
cection */
> > > @@ -1715,8 +1797,10 @@ static int vduse_destroy_dev(char *name)
> > >         idr_remove(&vduse_idr, dev->minor);
> > >         kvfree(dev->config);
> > >         vduse_dev_deinit_vqs(dev);
> > > -       if (dev->domain)
> > > -               vduse_domain_destroy(dev->domain);
> > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > +               if (dev->domain[i])
> > > +                       vduse_domain_destroy(dev->domain[i]);
> > > +       }
> > >         kfree(dev->name);
> > >         vduse_dev_destroy(dev);
> > >         module_put(THIS_MODULE);
> > > @@ -1824,7 +1908,7 @@ static ssize_t bounce_size_store(struct device =
*device,
> > >
> > >         ret =3D -EPERM;
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (dev->domain)
> > > +       if (dev->domain[0] && dev->domain[1])
> > >                 goto unlock;
> > >
> > >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > > @@ -1882,9 +1966,18 @@ static int vduse_create_dev(struct vduse_dev_c=
onfig *config,
> > >                                 config->ngroups, VDUSE_MAX_VQ_GROUPS)=
;
> > >                         goto err_ngroups;
> > >                 }
> > > +
> > > +               if (config->nas > VDUSE_MAX_ASID) {
> > > +                       pr_err("Not creating a VDUSE device with %u a=
sid. Max: %u",
> > > +                               config->nas, VDUSE_MAX_ASID);
> > > +                       goto err_nas;
> > > +               }
> > > +
> > >                 dev->ngroups =3D config->ngroups ?: 1;
> > > +               dev->nas =3D config->nas ?: 1;
> > >         } else {
> > >                 dev->ngroups =3D 1;
> > > +               dev->nas =3D 1;
> > >         }
> > >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> > >         if (!dev->name)
> > > @@ -1923,6 +2016,7 @@ static int vduse_create_dev(struct vduse_dev_co=
nfig *config,
> > >         kfree(dev->name);
> > >  err_ngroups:
> > >  err_str:
> > > +err_nas:
> > >         vduse_dev_destroy(dev);
> > >  err:
> > >         return ret;
> > > @@ -2015,7 +2109,6 @@ static int vduse_open(struct inode *inode, stru=
ct file *file)
> > >         if (!control)
> > >                 return -ENOMEM;
> > >
> > > -       control->api_version =3D VDUSE_API_VERSION;
> > >         file->private_data =3D control;
> > >
> > >         return 0;
> > > @@ -2040,17 +2133,15 @@ static struct vduse_mgmt_dev *vduse_mgmt;
> > >  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *na=
me)
> > >  {
> > >         struct vduse_vdpa *vdev;
> > > -       __u32 ngroups =3D 1;
> > > +       __u32 ngroups =3D dev->ngroups;
> > >         int ret;
> > >
> > >         if (dev->vdev)
> > >                 return -EEXIST;
> > >
> > > -       if (vdev->dev->api_version >=3D VDUSE_API_VERSION_1)
> > > -               ngroups =3D vdev->dev->ngroups;
> > > -
> > > +       /* TODO do we need to store ngroups and nas? vdpa device alre=
ady store it for us */
> > >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> > > -                                &vduse_vdpa_config_ops, ngroups, 1, =
name,
> > > +                                &vduse_vdpa_config_ops, ngroups, dev=
->nas, name,
> > >                                  true);
> > >         if (IS_ERR(vdev))
> > >                 return PTR_ERR(vdev);
> > > @@ -2088,11 +2179,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
> > >                 return ret;
> > >
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (!dev->domain)
> > > -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE -=
 1,
> > > -                                                 dev->bounce_size);
> > > +       ret =3D 0;
> > > +
> > > +       /* TODO we could delay the creation of the domain */
> > > +       for (int i =3D 0; i < dev->nas; ++i) {
> > > +               if (!dev->domain[i])
> > > +                       dev->domain[i] =3D vduse_domain_create(VDUSE_=
IOVA_SIZE - 1,
> > > +                                                            dev->bou=
nce_size);
> > > +               if (!dev->domain[i]) {
> > > +                       ret =3D -ENOMEM;
> > > +                       for (int j =3D 0; j < i; ++j)
> > > +                               vduse_domain_destroy(dev->domain[j]);
> > > +                       goto err_domain;
> > > +               }
> > > +       }
> > > +
> > >         mutex_unlock(&dev->domain_lock);
> > > -       if (!dev->domain) {
> > > +       if (ret =3D=3D -ENOMEM) {
> > >                 put_device(&dev->vdev->vdpa.dev);
> > >                 return -ENOMEM;
> > >         }
> > > @@ -2101,13 +2204,22 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
> > >         if (ret) {
> > >                 put_device(&dev->vdev->vdpa.dev);
> > >                 mutex_lock(&dev->domain_lock);
> > > -               vduse_domain_destroy(dev->domain);
> > > -               dev->domain =3D NULL;
> > > +               for (int i =3D 0; i < dev->nas; i++) {
> > > +                       if (dev->domain[i]) {
> > > +                               vduse_domain_destroy(dev->domain[i]);
> > > +                               dev->domain[i] =3D NULL;
> > > +                       }
> > > +               }
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 return ret;
> > >         }
> > >
> > >         return 0;
> > > +
> > > +err_domain:
> > > +       /* TODO do I need to call put_device? */
> > > +       mutex_unlock(&dev->domain_lock);
> > > +       return ret;
> > >  }
> > >
> > >  static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_dev=
ice *dev)
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index a779bcddac58..3a17a0b4e938 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -46,7 +46,8 @@ struct vduse_dev_config {
> > >         __u32 vq_num;
> > >         __u32 vq_align;
> > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > -       __u32 reserved[12];
> > > +       __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > +       __u32 reserved[11];
> > >         __u32 config_size;
> > >         __u8 config[];
> > >  };
> > > @@ -81,6 +82,17 @@ struct vduse_iotlb_entry {
> > >         __u8 perm;
> > >  };
> > >
> > > +struct vduse_iotlb_entry_v2 {
> > > +       __u64 offset;
> > > +       __u64 start;
> > > +       __u64 last;
> > > +       __u32 asid;
> > > +#define VDUSE_ACCESS_RO 0x1
> > > +#define VDUSE_ACCESS_WO 0x2
> > > +#define VDUSE_ACCESS_RW 0x3
> > > +       __u8 perm;
> > > +};
> > > +
> > >  /*
> > >   * Find the first IOVA region that overlaps with the range [start, l=
ast]
> > >   * and return the corresponding file descriptor. Return -EINVAL mean=
s the
> > > @@ -171,6 +183,16 @@ struct vduse_vq_group {
> > >         __u32 num;
> > >  };
> > >
> > > +/**
> > > + * struct vduse_vq_group - virtqueue group
> > > + @ @group: Index of the virtqueue group
> > > + * @asid: Address space ID of the group
> > > + */
> > > +struct vduse_vq_group_asid {
> > > +       __u32 group;
> > > +       __u32 asid;
> > > +};
> > > +
> > >  /**
> > >   * struct vduse_vq_info - information of a virtqueue
> > >   * @index: virtqueue index
> > > @@ -231,7 +253,9 @@ struct vduse_vq_eventfd {
> > >   * @uaddr: start address of userspace memory, it must be aligned to =
page size
> > >   * @iova: start of the IOVA region
> > >   * @size: size of the IOVA region
> > > + * @asid: Address space ID of the IOVA region
> > >   * @reserved: for future use, needs to be initialized to zero
> > > + * @reserved2: for future use, needs to be initialized to zero
> > >   *
> > >   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> > >   * ioctls to register/de-register userspace memory for IOVA regions
> > > @@ -240,7 +264,9 @@ struct vduse_iova_umem {
> > >         __u64 uaddr;
> > >         __u64 iova;
> > >         __u64 size;
> > > -       __u64 reserved[3];
> > > +       __u32 asid;
> > > +       __u32 reserved[1];
> >
> > Basically, I'm not sure we can assume reserved to be zero for API_VERSI=
ON =3D=3D 1.
> >
>
> Why not? The ioctl returns -EINVAL if it is not 0, so either an v0 or
> v1 ioctl user must set it if it wants the ioctl to return success.

Typo, I mean API_VERSION =3D=3D 0. It is reserved but the kernel doesn't
mandate it to be zero. But it doesn't matter probably as it will be
ruled by API_VERSION as you explain above.

>
> > > +       __u64 reserved2[2];
> >
> > Any reasons we can't reuse reserved array?
> >
>
> I don't get this comment, we're reusing it, isn't it? I'm just
> splitting the u64[3] into u32[1]+u64[2]. Maybe it is more elegant to
> use an u32[5] or similar?

Yes, I mean reuse the u32 array. (but not a must I guess unless the
ABI is stable).

>
> > >  };
> > >
> > >  /* Register userspace memory for IOVA regions */
> > > @@ -264,7 +290,8 @@ struct vduse_iova_info {
> > >         __u64 last;
> > >  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > >         __u64 capability;
> > > -       __u64 reserved[3];
> > > +       __u64 asid; /* Only if device API version >=3D 1 */
> > > +       __u64 reserved[2];
> >
> > Same here.
> >
> > >  };
> > >
> > >  /*
> > > @@ -287,6 +314,7 @@ enum vduse_req_type {
> > >         VDUSE_SET_STATUS,
> > >         VDUSE_UPDATE_IOTLB,
> > >         VDUSE_GET_VQ_GROUP,
> > > +       VDUSE_SET_VQ_GROUP_ASID,
> > >  };
> > >
> > >  /**
> > > @@ -342,6 +370,8 @@ struct vduse_dev_request {
> > >                 struct vduse_dev_status s;
> > >                 struct vduse_iova_range iova;
> > >                 struct vduse_vq_group vq_group; /* Only if vduse api =
version >=3D 1 */
> > > +               /* Only if vduse api version >=3D 1 */
> > > +               struct vduse_vq_group_asid vq_group_asid;
> >
> > This seems to break the uAPI as sizeof(struct vduse_dev_request) change=
s.
> >
>
> It should not change. vduse_vq_group is 64 bits, smaller than padding
> which is 32bits*32 =3D 1024bits. And they're both in the same union.

You're right.

>
> > >                 __u32 padding[32];
> > >         };
> > >  };
> > > @@ -365,6 +395,8 @@ struct vduse_dev_response {
> > >         union {
> > >                 struct vduse_vq_state vq_state;
> > >                 struct vduse_vq_group vq_group; /* Only if vduse api =
version >=3D 1 */
> > > +               /* Only if vduse api version >=3D 1 */
> > > +               struct vduse_vq_group_asid vq_group_asid;
> >
> > Same here.
> >
>
> Same reply :).

Yes.

>
> > >                 __u32 padding[32];
> > >         };
> > >  };
> > > --
> > > 2.49.0
> > >
> >
> > Thanks
> >
>

Thanks

