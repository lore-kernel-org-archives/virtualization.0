Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090E1862A
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248059; cv=none; b=HseG+6ro+enVl9BLC7m1iOTYehOUj9iGnquIQ1VV2WaFpqFR7cRCk4JXCdQIuvUPm3Rs+84WhL08BvWZ/h0OHntkDatsSLJUHLzi99C4siB6R7zoipq8weEexSJXyXVn69BMix7jpNN+A5dREjR/y2S2Arq9LDnQ/QW+aMGWVUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248059; c=relaxed/simple;
	bh=5Fni602xHchYpxPdTcYCTVw//3a3r040DpHjPy7SYlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a47YFv6e21S+qUoaJKeqFJv5C+EE0QET35CwdHshqtmFt1aSqvJfuCNLpn+ovUcTpElSqlwZTzYY+HeoZF0bomD0XVZTKvBO6F/67bIMmdSpb1qA28ZcwbnI5wdA5/kO+2bpXmw/DBqhGI2/jsq6z2ppd7IJj3HRVusNDZo45FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9Awlmgs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9Awlmgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758248056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhXQJcm18r1fRICoyY3jJGgG6dYg+cQKWyC8/KK3RaA=;
	b=A9AwlmgsxPPSQ+VDrsvHBi7xUe54wAhzVMqZYKp3eOR4ZH7qqpU0bhFc35Emm8zNHkvNMw
	WcjNPXRkWfA/h1/PQbziGULJoVkepYRN/DkO+RZouqqoQ6HJICusdfEKJdXDguUe1GZzNj
	5Bomv7unE/eiMxvOJoSUwmcIYZOwvdw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-1xhn8roFOLqZDnFlI997_w-1; Thu, 18 Sep 2025 22:14:14 -0400
X-MC-Unique: 1xhn8roFOLqZDnFlI997_w-1
X-Mimecast-MFC-AGG-ID: 1xhn8roFOLqZDnFlI997_w_1758248054
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso2190020a91.1
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 19:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248053; x=1758852853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhXQJcm18r1fRICoyY3jJGgG6dYg+cQKWyC8/KK3RaA=;
        b=lmjplJNnZj5ZMhbfSObuIy3LmpVRH6j9tQ/YAxIPB2vxojj70VE2fEIYcSG7i4+s4E
         Di8TN0DAApbxRi/F9v8qeRKAn3L/0CTXWxDzYzE7PSHbo9wZSuYIinAfJWcz+pmnVoDt
         Z0jf93sTABa8Qc1SGHMClNGJVUmNY1k3aWZyPfXdmoI/LjMioDu/6pxDl6vVeVJ7wIzJ
         zadjVj71bSIaHSXJ06iuhCjZsWKMLgUFGf0dywzvhv42Tc4S1ruXaKNf2OoQepep9QS4
         blNu+FI3bg1P44RGIsjmwVyMCBcSq6R3ydFW+rLQL+j26hawFCDoY4QfAoM6YPqWR900
         i6dw==
X-Forwarded-Encrypted: i=1; AJvYcCUxe4zftgyVotRC2KR3n1skgmcgC2MFsJsG6tlnr/+ynMjR+sMRd+G+dGR6P0svcF1uuD/3K776niTR+wQt+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr7lvqdTsYvh1mk6cvuScGKm+rr/9qrlfQ8U2E66aK/jz5iq6/
	SMO5/3mBJlQMs5lRLYjzFapkjnqyyTcspdz/0H/N6/oHb3As6DRqETzJA5GaxUuPg+sJlfTV10O
	njijjo65OZrsDOfq7KoE6bDfSkxTio2zT7zCOdy65FYnxccCoNd4WInIExwkATlKP0lHUsDvpwQ
	XS8xCiGOVjhk43Ciz9PmlUS/rdylPkSFr1v5mF7YocVAU=
X-Gm-Gg: ASbGncvYVm2uqswJmVqFBCujAH+DZygP13njNsUEkUqb8bSSBNsL1q3rtnX2LoWEt1u
	jO59VxI0YAWFGctd5n8XM24Z89LuQ9wEnDpibnqLsAUlHQxBatgHA4/aIIqPSYNagpViP+r03D0
	OpVALkAQzI16sl+jEBjQ==
X-Received: by 2002:a17:90b:3c06:b0:32d:17ce:49d5 with SMTP id 98e67ed59e1d1-33098245d63mr1682013a91.23.1758248053349;
        Thu, 18 Sep 2025 19:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFarl+3DEd2+pvo4jR8tEGHBPJsJbZHNh7bSuWKxmhqRTUAKZFLD9OXM5FaRKJsfa8qlyzbHmEw4n6/Z/Isa7o=
X-Received: by 2002:a17:90b:3c06:b0:32d:17ce:49d5 with SMTP id
 98e67ed59e1d1-33098245d63mr1681962a91.23.1758248052659; Thu, 18 Sep 2025
 19:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-7-eperezma@redhat.com>
 <CACGkMEu4F8Spw-=ve0w45CmJhEkBMtDdRCYNDorA6NxunkuDaw@mail.gmail.com>
 <CAJaqyWfqNX6E89Z4Yz373V6r1xLzJVNon5A_fCdU=79nAk6CRQ@mail.gmail.com> <CAJaqyWfg1Rtz_1f1+DmOG1_87bBUdp4J64TwsAA3v6VKM2sszA@mail.gmail.com>
In-Reply-To: <CAJaqyWfg1Rtz_1f1+DmOG1_87bBUdp4J64TwsAA3v6VKM2sszA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 10:14:01 +0800
X-Gm-Features: AS18NWDpssmSp_HI2nEcVBP6znub0DKVpIvq-bkvhP10bQ6pSdj31s9J-4sDJp4
Message-ID: <CACGkMEtszQeZLTegxEbjODYxu-giTvURu=pKj4kYTHQYoKOzkQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RmYuZnWmLSXXSFFQIfben1L8BU5Tvcz-_SteJXMqXF4_1758248054
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:22=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Sep 17, 2025 at 6:40=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Sep 17, 2025 at 10:56=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Add support for assigning Address Space Identifiers (ASIDs) to each=
 VQ
> > > > group.  This enables mapping each group into a distinct memory spac=
e.
> > > >
> > > > Now that the driver can change ASID in the middle of operation, the
> > > > domain that each vq address point is also protected by domain_lock.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > v2:
> > > > * Convert the use of mutex to rwlock.
> > > >
> > > > RFC v3:
> > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a l=
ower
> > > >   value to reduce memory consumption, but vqs are already limited t=
o
> > > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > >   VDUSE_IOTLB_GET_INFO.
> > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > * Move the umem mutex to asid struct so there is no contention betw=
een
> > > >   ASIDs.
> > > >
> > > > RFC v2:
> > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the firs=
t
> > > >   part of the struct is the same.
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 324 +++++++++++++++++++++----=
----
> > > >  include/uapi/linux/vduse.h         |  51 ++++-
> > > >  2 files changed, 284 insertions(+), 91 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index b45b1d22784f..06b7790380b7 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -93,6 +93,7 @@ struct vduse_as {
> > > >  };
> > > >
> > > >  struct vduse_vq_group_int {
> > > > +       struct vduse_iova_domain *domain;
> > > >         struct vduse_dev *dev;
> > >
> > > This confuses me, I think it should be an asid. And the vduse_dev
> > > pointer seems to be useless here.
> > >
> >
> > The *dev pointer is used to take the rwlock, in case the vhost driver
> > calls VHOST_VDPA_SET_GROUP_ASID (or equivalent) at the same time
> > vduse_dev_sync_single_for_device (or _for_cpu, or equivalent) run.
> >
> > > >  };
> > > >
> > > > @@ -100,7 +101,7 @@ struct vduse_dev {
> > > >         struct vduse_vdpa *vdev;
> > > >         struct device *dev;
> > > >         struct vduse_virtqueue **vqs;
> > > > -       struct vduse_as as;
> > > > +       struct vduse_as *as;
> > > >         char *name;
> > > >         struct mutex lock;
> > > >         spinlock_t msg_lock;
> > > > @@ -128,6 +129,7 @@ struct vduse_dev {
> > > >         u32 vq_num;
> > > >         u32 vq_align;
> > > >         u32 ngroups;
> > > > +       u32 nas;
> > > >         struct vduse_vq_group_int *groups;
> > > >         unsigned int bounce_size;
> > > >         rwlock_t domain_lock;
> > > > @@ -318,7 +320,7 @@ static int vduse_dev_set_status(struct vduse_de=
v *dev, u8 status)
> > > >         return vduse_dev_msg_sync(dev, &msg);
> > > >  }
> > > >
> > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > > >                                   u64 start, u64 last)
> > > >  {
> > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > @@ -327,8 +329,14 @@ static int vduse_dev_update_iotlb(struct vduse=
_dev *dev,
> > > >                 return -EINVAL;
> > > >
> > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > -       msg.req.iova.start =3D start;
> > > > -       msg.req.iova.last =3D last;
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > +               msg.req.iova.start =3D start;
> > > > +               msg.req.iova.last =3D last;
> > > > +       } else {
> > > > +               msg.req.iova_v2.start =3D start;
> > > > +               msg.req.iova_v2.last =3D last;
> > > > +               msg.req.iova_v2.asid =3D asid;
> > > > +       }
> > > >
> > > >         return vduse_dev_msg_sync(dev, &msg);
> > > >  }
> > > > @@ -440,14 +448,29 @@ static __poll_t vduse_dev_poll(struct file *f=
ile, poll_table *wait)
> > > >         return mask;
> > > >  }
> > > >
> > > > +/* Force set the asid to a vq group without a message to the VDUSE=
 device */
> > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > > +                                      unsigned int group, unsigned=
 int asid)
> > > > +{
> > > > +       write_lock(&dev->domain_lock);
> > > > +       dev->groups[group].domain =3D dev->as[asid].domain;
> > >
> > > I think it would be better to stick the group->as an indirection whic=
h
> > > should be .
> > >
> > > dev->groups.asid =3D asid;
> > >
> > > Or
> > >
> > > dev->group->as =3D as;
> > >
> >
> > That involves an extra memory jump for functions that may be in the
> > hot path. I've not profiled it, but I'm ok with changing it that way
> > if you prefer.
> >
> > > > +       write_unlock(&dev->domain_lock);
> > > > +}
> > > > +
> > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > >  {
> > > >         int i;
> > > > -       struct vduse_iova_domain *domain =3D dev->as.domain;
> > > >
> > > >         /* The coherent mappings are handled in vduse_dev_free_cohe=
rent() */
> > > > -       if (domain && domain->bounce_map)
> > > > -               vduse_domain_reset_bounce_map(domain);
> > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > +               struct vduse_iova_domain *domain =3D dev->as[i].dom=
ain;
> > > > +
> > > > +               if (domain && domain->bounce_map)
> > > > +                       vduse_domain_reset_bounce_map(domain);
> > > > +       }
> > > > +
> > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > >
> > > >         down_write(&dev->rwsem);
> > > >
> > > > @@ -621,6 +644,29 @@ static union virtio_map vduse_get_vq_map(struc=
t vdpa_device *vdpa, u16 idx)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned=
 int group,
> > > > +                               unsigned int asid)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > +       int r;
> > > > +
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > +               return -EINVAL;
> > > > +
> > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > +       msg.req.vq_group_asid.group =3D group;
> > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > +
> > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > +       if (r < 0)
> > > > +               return r;
> > > > +
> > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -792,13 +838,13 @@ static int vduse_vdpa_set_map(struct vdpa_dev=
ice *vdpa,
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > >         int ret;
> > > >
> > > > -       ret =3D vduse_domain_set_map(dev->as.domain, iotlb);
> > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX)=
;
> > > >         if (ret) {
> > > > -               vduse_domain_clear_map(dev->as.domain, iotlb);
> > > > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb)=
;
> > > >                 return ret;
> > > >         }
> > > >
> > > > @@ -841,6 +887,7 @@ static const struct vdpa_config_ops vduse_vdpa_=
config_ops =3D {
> > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > >         .reset                  =3D vduse_vdpa_reset,
> > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > >         .free                   =3D vduse_vdpa_free,
> > > >  };
> > > > @@ -850,9 +897,12 @@ static void vduse_dev_sync_single_for_device(u=
nion virtio_map token,
> > > >                                              enum dma_data_directio=
n dir)
> > > >  {
> > > >         struct vduse_dev *vdev =3D token.group->dev;
> > > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > > +       struct vduse_iova_domain *domain;
> > > >
> > > > +       read_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->domain;
> > > >         vduse_domain_sync_single_for_device(domain, dma_addr, size,=
 dir);
> > > > +       read_unlock(&vdev->domain_lock);
> > > >  }
> > > >
> > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > > > @@ -860,9 +910,12 @@ static void vduse_dev_sync_single_for_cpu(unio=
n virtio_map token,
> > > >                                              enum dma_data_directio=
n dir)
> > > >  {
> > > >         struct vduse_dev *vdev =3D token.group->dev;
> > > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > > +       struct vduse_iova_domain *domain;
> > > >
> > > > +       read_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->domain;
> > >
> > > I think the domain is better fetched via vduse_as.
> > >
> > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, di=
r);
> > > > +       read_unlock(&vdev->domain_lock);
> > > >  }
> > > >
> > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struc=
t page *page,
> > > > @@ -871,9 +924,15 @@ static dma_addr_t vduse_dev_map_page(union vir=
tio_map token, struct page *page,
> > > >                                      unsigned long attrs)
> > > >  {
> > > >         struct vduse_dev *vdev =3D token.group->dev;
> > > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > > +       struct vduse_iova_domain *domain;
> > > > +       dma_addr_t r;
> > > >
> > > > -       return vduse_domain_map_page(domain, page, offset, size, di=
r, attrs);
> > > > +       read_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->domain;
> > > > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir=
, attrs);
> > > > +       read_unlock(&vdev->domain_lock);
> > > > +
> > > > +       return r;
> > > >  }
> > > >
> > > >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_=
t dma_addr,
> > > > @@ -881,27 +940,31 @@ static void vduse_dev_unmap_page(union virtio=
_map token, dma_addr_t dma_addr,
> > > >                                  unsigned long attrs)
> > > >  {
> > > >         struct vduse_dev *vdev =3D token.group->dev;
> > > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > > +       struct vduse_iova_domain *domain;
> > > >
> > > > -       return vduse_domain_unmap_page(domain, dma_addr, size, dir,=
 attrs);
> > > > +       read_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->domain;
> > > > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs)=
;
> > > > +       read_unlock(&vdev->domain_lock);
> > > >  }
> > > >
> > > >  static void *vduse_dev_alloc_coherent(union virtio_map token, size=
_t size,
> > > >                                       dma_addr_t *dma_addr, gfp_t f=
lag)
> > > >  {
> > > >         struct vduse_dev *vdev =3D token.group->dev;
> > > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > > +       struct vduse_iova_domain *domain;
> > > >         unsigned long iova;
> > > > -       void *addr;
> > > > +       void *addr =3D NULL;
> > > >
> > > >         *dma_addr =3D DMA_MAPPING_ERROR;
> > > > +       read_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->domain;
> > > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > > >                                            (dma_addr_t *)&iova, fla=
g);
> > > > -       if (!addr)
> > > > -               return NULL;
> > > > -
> > > > -       *dma_addr =3D (dma_addr_t)iova;
> > > > +       if (addr)
> > > > +               *dma_addr =3D (dma_addr_t)iova;
> > > >
> > > > +       read_unlock(&vdev->domain_lock);
> > > >         return addr;
> > > >  }
> > > >
> > > > @@ -910,17 +973,26 @@ static void vduse_dev_free_coherent(union vir=
tio_map token, size_t size,
> > > >                                     unsigned long attrs)
> > > >  {
> > > >         struct vduse_dev *vdev =3D token.group->dev;
> > > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > > +       struct vduse_iova_domain *domain;
> > > >
> > > > +       read_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->domain;
> > > >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, a=
ttrs);
> > > > +       read_unlock(&vdev->domain_lock);
> > > >  }
> > > >
> > > >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t=
 dma_addr)
> > > >  {
> > > >         struct vduse_dev *vdev =3D token.group->dev;
> > > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > > +       struct vduse_iova_domain *domain;
> > > > +       size_t bounce_size;
> > > >
> > > > -       return dma_addr < domain->bounce_size;
> > > > +       read_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->domain;
> > > > +       bounce_size =3D domain->bounce_size;
> > > > +       read_unlock(&vdev->domain_lock);
> > > > +
> > > > +       return dma_addr < bounce_size;
> > > >  }
> > > >
> > > >  static int vduse_dev_mapping_error(union virtio_map token, dma_add=
r_t dma_addr)
> > > > @@ -933,9 +1005,15 @@ static int vduse_dev_mapping_error(union virt=
io_map token, dma_addr_t dma_addr)
> > > >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> > > >  {
> > > >         struct vduse_dev *vdev =3D token.group->dev;
> > > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > > +       struct vduse_iova_domain *domain;
> > > > +       size_t bounce_size;
> > > > +
> > > > +       read_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->domain;
> > > > +       bounce_size =3D domain->bounce_size;
> > > > +       read_unlock(&vdev->domain_lock);
> > > >
> > > > -       return domain->bounce_size;
> > > > +       return bounce_size;
> > > >  }
> > > >
> > > >  static const struct virtio_map_ops vduse_map_ops =3D {
> > > > @@ -1075,39 +1153,40 @@ static int vduse_dev_queue_irq_work(struct =
vduse_dev *dev,
> > > >         return ret;
> > > >  }
> > > >
> > > > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> > > >                                 u64 iova, u64 size)
> > > >  {
> > > >         int ret;
> > > >
> > > > -       mutex_lock(&dev->as.mem_lock);
> > > > +       mutex_lock(&dev->as[asid].mem_lock);
> > > >         ret =3D -ENOENT;
> > > > -       if (!dev->as.umem)
> > > > +       if (!dev->as[asid].umem)
> > > >                 goto unlock;
> > > >
> > > >         ret =3D -EINVAL;
> > > > -       if (!dev->as.domain)
> > > > +       if (!dev->as[asid].domain)
> > > >                 goto unlock;
> > > >
> > > > -       if (dev->as.umem->iova !=3D iova || size !=3D dev->as.domai=
n->bounce_size)
> > > > +       if (dev->as[asid].umem->iova !=3D iova ||
> > > > +           size !=3D dev->as[asid].domain->bounce_size)
> > > >                 goto unlock;
> > > >
> > > > -       vduse_domain_remove_user_bounce_pages(dev->as.domain);
> > > > -       unpin_user_pages_dirty_lock(dev->as.umem->pages,
> > > > -                                   dev->as.umem->npages, true);
> > > > -       atomic64_sub(dev->as.umem->npages, &dev->as.umem->mm->pinne=
d_vm);
> > > > -       mmdrop(dev->as.umem->mm);
> > > > -       vfree(dev->as.umem->pages);
> > > > -       kfree(dev->as.umem);
> > > > -       dev->as.umem =3D NULL;
> > > > +       vduse_domain_remove_user_bounce_pages(dev->as[asid].domain)=
;
> > > > +       unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> > > > +                                   dev->as[asid].umem->npages, tru=
e);
> > > > +       atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].ume=
m->mm->pinned_vm);
> > > > +       mmdrop(dev->as[asid].umem->mm);
> > > > +       vfree(dev->as[asid].umem->pages);
> > > > +       kfree(dev->as[asid].umem);
> > > > +       dev->as[asid].umem =3D NULL;
> > >
> > > We can avoid those changeset if we do those in the previous correctly
> > > as it said it would make as an array.
> > >
> >
> > I'm not following it. Is that different from squashing this patch with
> > the previous one? I'm ok with doing it, but this changes are needed
> > either way.
> >
> > > >         ret =3D 0;
> > > >  unlock:
> > > > -       mutex_unlock(&dev->as.mem_lock);
> > > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > > >         return ret;
> > > >  }
> > > >
> > > >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > > > -                             u64 iova, u64 uaddr, u64 size)
> > > > +                             u32 asid, u64 iova, u64 uaddr, u64 si=
ze)
> > > >  {
> > > >         struct page **page_list =3D NULL;
> > > >         struct vduse_umem *umem =3D NULL;
> > > > @@ -1115,14 +1194,14 @@ static int vduse_dev_reg_umem(struct vduse_=
dev *dev,
> > > >         unsigned long npages, lock_limit;
> > > >         int ret;
> > > >
> > > > -       if (!dev->as.domain || !dev->as.domain->bounce_map ||
> > > > -           size !=3D dev->as.domain->bounce_size ||
> > > > +       if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_=
map ||
> > > > +           size !=3D dev->as[asid].domain->bounce_size ||
> > > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > > >                 return -EINVAL;
> > > >
> > > > -       mutex_lock(&dev->as.mem_lock);
> > > > +       mutex_lock(&dev->as[asid].mem_lock);
> > > >         ret =3D -EEXIST;
> > > > -       if (dev->as.umem)
> > > > +       if (dev->as[asid].umem)
> > > >                 goto unlock;
> > > >
> > > >         ret =3D -ENOMEM;
> > > > @@ -1146,7 +1225,7 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > > >                 goto out;
> > > >         }
> > > >
> > > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->as.domain,
> > > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].do=
main,
> > > >                                                  page_list, pinned)=
;
> > > >         if (ret)
> > > >                 goto out;
> > > > @@ -1159,7 +1238,7 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > > >         umem->mm =3D current->mm;
> > > >         mmgrab(current->mm);
> > > >
> > > > -       dev->as.umem =3D umem;
> > > > +       dev->as[asid].umem =3D umem;
> > > >  out:
> > > >         if (ret && pinned > 0)
> > > >                 unpin_user_pages(page_list, pinned);
> > > > @@ -1170,7 +1249,7 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > > >                 vfree(page_list);
> > > >                 kfree(umem);
> > > >         }
> > > > -       mutex_unlock(&dev->as.mem_lock);
> > > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > > >         return ret;
> > > >  }
> > > >
> > > > @@ -1202,47 +1281,66 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >
> > > >         switch (cmd) {
> > > >         case VDUSE_IOTLB_GET_FD: {
> > > > -               struct vduse_iotlb_entry entry;
> > > > +               struct vduse_iotlb_entry_v2 entry;
> > > >                 struct vhost_iotlb_map *map;
> > > >                 struct vdpa_map_file *map_file;
> > > >                 struct file *f =3D NULL;
> > > > +               u32 asid;
> > > >
> > > >                 ret =3D -EFAULT;
> > > > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > > > -                       break;
> > > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > > > +                       if (copy_from_user(&entry, argp, sizeof(ent=
ry)))
> > > > +                               break;
> > > > +               } else {
> > > > +                       entry.asid =3D 0;
> > > > +                       if (copy_from_user(&entry.v1, argp,
> > > > +                                          sizeof(entry.v1)))
> > > > +                               break;
> > > > +               }
> > > >
> > > >                 ret =3D -EINVAL;
> > > > -               if (entry.start > entry.last)
> > > > +               if (entry.v1.start > entry.v1.last)
> > > > +                       break;
> > > > +
> > > > +               if (entry.asid >=3D dev->nas)
> > > >                         break;
> > > >
> > > >                 read_lock(&dev->domain_lock);
> > > > -               if (!dev->as.domain) {
> > > > +               asid =3D array_index_nospec(entry.asid, dev->nas);
> > > > +               if (!dev->as[asid].domain) {
> > > >                         read_unlock(&dev->domain_lock);
> > > >                         break;
> > > >                 }
> > > > -               spin_lock(&dev->as.domain->iotlb_lock);
> > > > -               map =3D vhost_iotlb_itree_first(dev->as.domain->iot=
lb,
> > > > -                                             entry.start, entry.la=
st);
> > > > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > > > +               map =3D vhost_iotlb_itree_first(dev->as[asid].domai=
n->iotlb,
> > > > +                                             entry.v1.start, entry=
.v1.last);
> > > >                 if (map) {
> > > >                         map_file =3D (struct vdpa_map_file *)map->o=
paque;
> > > >                         f =3D get_file(map_file->file);
> > > > -                       entry.offset =3D map_file->offset;
> > > > -                       entry.start =3D map->start;
> > > > -                       entry.last =3D map->last;
> > > > -                       entry.perm =3D map->perm;
> > > > +                       entry.v1.offset =3D map_file->offset;
> > > > +                       entry.v1.start =3D map->start;
> > > > +                       entry.v1.last =3D map->last;
> > > > +                       entry.v1.perm =3D map->perm;
> > > >                 }
> > > > -               spin_unlock(&dev->as.domain->iotlb_lock);
> > > > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> > > >                 read_unlock(&dev->domain_lock);
> > > >                 ret =3D -EINVAL;
> > > >                 if (!f)
> > > >                         break;
> > > >
> > > >                 ret =3D -EFAULT;
> > > > -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> > > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1)
> > > > +                       ret =3D copy_to_user(argp, &entry,
> > > > +                                          sizeof(entry));
> > > > +               else
> > > > +                       ret =3D copy_to_user(argp, &entry.v1,
> > > > +                                          sizeof(entry.v1));
> > > > +
> > > > +               if (ret) {
> > > >                         fput(f);
> > > >                         break;
> > > >                 }
> > > > -               ret =3D receive_fd(f, NULL, perm_to_file_flags(entr=
y.perm));
> > > > +               ret =3D receive_fd(f, NULL, perm_to_file_flags(entr=
y.v1.perm));
> > >
> > > Nit: if we copy_from_user() twice and stick entry for v1 format, we
> > > can avoid a lot of lines of changes.
> > >
> >
> > Let me draft something and put it as a reply here to check I'm
> > understanding your proposal.
> >
>
> We need a "struct vduse_iotlb_entry_v2" sooner or later anyway because
> we need to finish with the corresponding copy_to_user. Either that, or
> duplicate the copy_to_user too with something like:
> copy_to_user(argp, &entry_vq, sizeof(entry_v1);
> copy_to_user(argp + sizeof(struct vduse_iotlb_entry), &asid, sizeof(asid)=
;
>
> Saving the struct vduse_iotlb_entry_v2, this is the only change I can
> do in that direction (from this patch):
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 7da248f5616c..555b0fa079de 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1341,14 +1341,13 @@ static long vduse_dev_ioctl(struct file *file,
> unsigned int cmd,
>                 u32 asid;
>
>                 ret =3D -EFAULT;
> -               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> -                       if (copy_from_user(&entry, argp, sizeof(entry)))
> -                               break;
> -               } else {
> +               if (copy_from_user(&entry.v1, argp, sizeof(entry.v1)))
> +                       break;
> +               if (dev->api_version < VDUSE_API_VERSION_1) {
>                         entry.asid =3D 0;
> -                       if (copy_from_user(&entry.v1, argp,
> -                                          sizeof(entry.v1)))
> -                               break;
> +               } else if (copy_from_user(&entry.asid, argp,
> +                                         sizeof(entry.asid))) {
> +                       break;
>                 }
>
>                 ret =3D -EINVAL;

Ok, I see, just choose the one that is easier for you.

Thanks

