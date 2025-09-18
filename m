Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4225275AFE
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178690; cv=none; b=sDIds3vazcJ9K9qoGnmMnVWmkqwAeUvS+epoJpxCcCe6P2XP+mDPjsOdS+26nmubsASkon7SPk3oAPwoifDRQMbpDUw/nUcBRNa52xdLb/kgPCA/X68h9dYm2D3fKydaB84d3ysZZlwJ1D9SsmhF5oqysWMimpAr7T43+2Eh4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178690; c=relaxed/simple;
	bh=R7TW946OH+hXdp2lJqw/vuo/xZj4l/mvJZLlwT0uv8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBPeP9njO4MNQtdsDPP9g/HM+HZAKQkzcPmTL87sR2C0F5t+++FM5mWsEnZk+P7rh/tgVMpA12j0RgA+alGDDvmkd+3NS0I5SuZGXKrkPZSlQ3OYmkj19/HsMRL372Mzv2u3zXdH7KqvgyPjILvBoK1//mMi0JMwazdlKXK1vaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7owsfA0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7owsfA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758178686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vn+Ayzi6ofDDmgE+RZfIe5LUtoLGLHC1/HBefnpGOQw=;
	b=B7owsfA0mlO0C6b7NOHPZh3S5Gtm8eRpFz+RZNrzZLjFEBjj1Ns1UyDw/hUAL8CzLQAY8y
	dVTF05Wy+shIhQbP18GjEy6i7rhMcxRWJzAr94cFm5lSxZ+xh34kyS9BbiltEefAFIFyEx
	SrNwkkkPV0xZISM5D5X1bemr8E1Pths=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-XzzVgxKRO_CDqn_aPxZ7oA-1; Thu, 18 Sep 2025 02:58:05 -0400
X-MC-Unique: XzzVgxKRO_CDqn_aPxZ7oA-1
X-Mimecast-MFC-AGG-ID: XzzVgxKRO_CDqn_aPxZ7oA_1758178685
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63152c9dfe4so343651d50.0
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 23:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178685; x=1758783485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn+Ayzi6ofDDmgE+RZfIe5LUtoLGLHC1/HBefnpGOQw=;
        b=aggQai/puF9FYXS4o7+llAfo+J7fHGvgHgT5LvAJR2/EsSFvAA+xp1KveyUmlVVDhy
         U4mlkKBTQfdRT4FoGJOlVJs+I8/lWCg74e2QkQkAPc3R4iz9VlAiFe+7jRBrUtYvnKzM
         Cz3aP86lO2cKcK9awX2qtClZkxWQtJ53xY+HIWqpsj9LNlNMkDEy1ZMRVFkgYJMNgLCo
         EgfBzR0D/8ndKToFCU19xXO2DoZ89a2ULRWNWxLnR9josQTzbHvdHGaMIfTYhRJhBqes
         7KQWV+hkNjlUcsVAypnUknyte+sfJVnLc4ZAhqGh5C0J5uIFPEH5JeVqSyiHoSL/laKS
         M/jw==
X-Forwarded-Encrypted: i=1; AJvYcCUHBk0Kj9cMnQV12kEVTvdNuNGLCrAiPDfxqdBVq0olKbvWzJf7tFxwP6LlL4IxXqr3A6PUTSAUVjOq8UuBLg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6aJmoHoOlDRlVEA6nYgieZXyWmYenDzkzkmB9hxxRlZo6B1gM
	XQE5JSXHpHDGAWJL2uLLiz1ZWKyWjN45tuiVbRqzdtHKuH7qptpp+8l+2rYuldiQ0Cx6P9PsOu5
	JsFKRYX7OUeyAsTZuZDjAxW0LWSVDKHlvvAP0VSawKg9AtMSRiwkmtbSMR6XfJlk8ORQjzOX+SM
	cA+zFC94FLVhSWsGYsV8dgpwmDdsr1YtHLsEYHJ5uCmhA=
X-Gm-Gg: ASbGncsOkBzBz0lSYNE1bFUZGJFb4YlYTA3iTSKok5/59ZlM9unzU7gVl1hkhEe59rS
	qGJNKkeLudw1pPPCqsRnAaxtGEh09dxfzwWq9l4cb7MFJt6R7cJoNuJF7Nr9cQVoBBfj57vscGi
	zgw4rxyws2jD6mtcKoRzjYs2Eg/jCnAi1sG6eEHQzzLqo6/J97MbWNPQaAshl63ikHlm0TbUJMm
	nfnFy+6
X-Received: by 2002:a05:690e:160a:b0:633:c0de:3b66 with SMTP id 956f58d0204a3-633c0de3e60mr412756d50.36.1758178684008;
        Wed, 17 Sep 2025 23:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYNhqSJsglC1qU1ufr23vLfWdxRNYy2PzS7ieQhQ9fmEeWuJOMgPrvAxnelAvRGLdEutRvnDfR+jVkW7OsuEE=
X-Received: by 2002:a05:690e:160a:b0:633:c0de:3b66 with SMTP id
 956f58d0204a3-633c0de3e60mr412743d50.36.1758178683327; Wed, 17 Sep 2025
 23:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-7-eperezma@redhat.com>
 <CACGkMEu4F8Spw-=ve0w45CmJhEkBMtDdRCYNDorA6NxunkuDaw@mail.gmail.com>
 <CAJaqyWfqNX6E89Z4Yz373V6r1xLzJVNon5A_fCdU=79nAk6CRQ@mail.gmail.com> <CACGkMEurRDttMmrKzA8Wc4afBZi7T8wbLMfFS1wAEgabbVbAtA@mail.gmail.com>
In-Reply-To: <CACGkMEurRDttMmrKzA8Wc4afBZi7T8wbLMfFS1wAEgabbVbAtA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 18 Sep 2025 08:57:25 +0200
X-Gm-Features: AS18NWB9r1WEsIPlLyOPokayD9_cDFVBHxi2IR8TJ4FtAjiX0S_32aGo9VAY_0E
Message-ID: <CAJaqyWc725Ep6MJR8=7jJdqSnJs25X++qPx0tRfGOnQr=5H2yw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ii8e22ZtaCwtMCJmLvVlLPrryjL_3GFF4rjQU1x1_wQ_1758178685
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Sep 18, 2025 at 12:41=E2=80=AFAM Eugenio Perez Martin
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
>
> Ok, but having it in a group seems odd. A better place is to move it to t=
he as?
>

If we move to the as, we need to take the lock this way:

read_lock(vduse_vq_group->as->dev->domain_lock)

But the lock is protecting the vduse_vq_group->as change itself, as
other ioctls (SET_GROUP_ASID mainly) can modify it concurrently.

We can assume that *as will always point to a valid as, its change
will be atomic, and all the as->dev points to the exact same
vduse_dev. I can buy that, but it is a race anyway.

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
>
> I think it would be better if we can change (see my reply in previous pat=
ch).
>
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
>
> See my reply for whether we need to make it as an array in the last
> patch. I meant basically we only need to change them once, but this
> series touches this twice.
>
> Thanks
>

