Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F314286
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178054; cv=none; b=jqzU2Ycu888pqiUIkEZpE44UC+Zmjm25VKZoo8qUSsl1S6S4Kb5oV1hlWZdVAS9XPC8YbTQ/qxVWVRPARGjM25NgQcOd0DreaQ6lbFp9JvGlcFilrSD3jpLBW3fE6G+Tr+gReTZgtQI/viVn7qvkrveLE2OunXZFHqc/tMqCPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178054; c=relaxed/simple;
	bh=cfjQM25yTQ1oYukoHM/4sk9Mb9tnVDRfK+TEIQlB36c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5HxNmjyXOVLsa4myk3r7njR4td2BWEJZirwRLTpzzKq9tZKaMmiMR7mChqMLese2+w5eXedsnNgDr6ja4fgVnrSxxc9u36YA9yGrhHGlzzSoRwn1fNJX9MuJj+NzOj85FJbSRYrpINjc326P5/qd4NZHfu9RgfA72CERIn0kaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhYJguLY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhYJguLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758178050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0X5Mq6S55OXp4r4W/9smlxOerZYu2Fic0M02R4tmyc=;
	b=HhYJguLYl80UWVrRcYC82GD8GgkQwD7pTxgeql+x4WYec6SXBqtd3Wz6KOniOe6VXDEx88
	sEXngdrsiIOW70Hb6W5ZirRHplwZ/mFuH7XKIBe2WO+249cBth2/tTydIJESMAZxLr5OsD
	CL93WW4tp0VEwEkpmK7sSUQtAITeIH0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-5uzExe7fMf2UNTIuLL6y1A-1; Thu, 18 Sep 2025 02:47:29 -0400
X-MC-Unique: 5uzExe7fMf2UNTIuLL6y1A-1
X-Mimecast-MFC-AGG-ID: 5uzExe7fMf2UNTIuLL6y1A_1758178049
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71d60183b47so6583857b3.0
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 23:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178049; x=1758782849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0X5Mq6S55OXp4r4W/9smlxOerZYu2Fic0M02R4tmyc=;
        b=vrx8QsOGGQywdxyMdDKuMou8ejaQPJZJNWd8DuGWhRhy5+M/60sYzhh3bSHEly6yYq
         l40Nk1cbA3zQPmfQBSaKFvbW+WfiSsFrRDGqaItsJXDYg+QM/NGHYnJTPHAhEi7PFQHS
         t7wlFD+4Z+cI6ygLbNQ/7Y5tgUyyjQX4bbqB0EXE0EAysJj7b/qP7Nhn8iMmpB27VYNQ
         nIt3AQGuilO0R4tp9Unhg+53Dwg9HaHX0AGInygp3uB2QVi1X2jKf3N1c2HKvNv6NvTL
         3Kgu/GY8lV9Z3EvZZsd2GM2SNmeIS4vZIgIghMb+0hcuFj5fba4m9WGt1lziSFdVrdmq
         4nbg==
X-Forwarded-Encrypted: i=1; AJvYcCXmsURnqI0IGpOwdYkXZZNPEEjS60I52+nGJA7p747aVCKNEC54dfxdsWPmFyNX+qeg/ba/0jaruqHubrHimA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6HgoslTYV4oa3bUjtuczCoyOPMqsnXH08MzUv71WoT7mvh2AC
	tVdagAswtpfTotV9cIhFyl46Fe4a0sN99XVZUGmKnHT8U1UChTCam5uqs3vu1rEk+Gdy4PjZWCk
	h+EV+6TJfA0awYcbSs+HTlmZMmprYrNySi1o5HaJbGeI3RwwEzayjSMN45atRNluD/YUWukuJUj
	qhbel8Ayx9la+WeY6FgTywW8KKeXx9dWov3SRayC98fGM=
X-Gm-Gg: ASbGnctr42By3iJED4CJ51WCrhaqLk4SC4IlF2nFooHZpCLaOrHE0RmqyAoUMGHXPI0
	wUq914+15W5dx7A3ogXxHopkYs9MRH/q7GUsP2GRrXnXZEHWseIzK2BlTMFapCOQuzRx8au04VC
	S19m8VPX3oMEWAIgFlxh2Zp0s3KmKP9a7FGOuU6q9yxNb8dFBVU110PjvRxfjVsDDnTCXo0vAwj
	Sb2l+Ht
X-Received: by 2002:a05:690c:9988:b0:723:b92e:ed56 with SMTP id 00721157ae682-73890ea5196mr43252117b3.16.1758178048884;
        Wed, 17 Sep 2025 23:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtWUxPpH3q7p45RtQcJT6VmkJu5FDz35ly0AcRLeC7kpsbGC5mFAsDL/XvZXEIoMOGYZHucWyKkSq4h01EveY=
X-Received: by 2002:a05:690c:9988:b0:723:b92e:ed56 with SMTP id
 00721157ae682-73890ea5196mr43251977b3.16.1758178048447; Wed, 17 Sep 2025
 23:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-4-eperezma@redhat.com>
 <CACGkMEv+FxECjhxfEKjZJcqXKc=c7RogAk6wdptBymTvL0fz1Q@mail.gmail.com>
 <CAJaqyWeFDSXQtUnZG_O226YBu1Zy_L8ws_UMDGVTMA=YfrGcFg@mail.gmail.com> <CACGkMEtyKWwLfb17U3+7SZ_T-NrYhMpYfcCegVarjq_Xen2s6g@mail.gmail.com>
In-Reply-To: <CACGkMEtyKWwLfb17U3+7SZ_T-NrYhMpYfcCegVarjq_Xen2s6g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 18 Sep 2025 08:46:52 +0200
X-Gm-Features: AS18NWDynDPG5supk8jJr5cUBBXF1FuGEc0yMxOdHYHebmT0V26AffKFVRlZc3E
Message-ID: <CAJaqyWe5iEdQDhaVJRam+Fzz3gG4YGOG6J-dknc5LYYey2hcKA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l2z1d15FvBZp9Gz4gnYD0P2ECkYPB0_c9UbSdh9vKP4_1758178049
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Sep 17, 2025 at 11:42=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Sep 17, 2025 at 10:37=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 9:08=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > This allows sepparate the different virtqueues in groups that share=
s the
> > > > same address space.  Asking the VDUSE device for the groups of the =
vq at
> > > > the beginning as they're needed for the DMA API.
> > > >
> > > > Allocating 3 vq groups as net is the device that need the most grou=
ps:
> > > > * Dataplane (guest passthrough)
> > > > * CVQ
> > > > * Shadowed vrings.
> > > >
> > > > Future versions of the series can include dynamic allocation of the
> > > > groups array so VDUSE can declare more groups.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > v2:
> > > > * Now the vq group is in vduse_vq_config struct instead of issuing =
one
> > > >   VDUSE message per vq.
> > > >
> > > > v1:
> > > > * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxim=
e)
> > > >
> > > > RFC v3:
> > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a l=
ower
> > > >   value to reduce memory consumption, but vqs are already limited t=
o
> > > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > > * Remove the descs vq group capability as it will not be used and w=
e can
> > > >   add it on top.
> > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > * Move the valid vq groups range check to vduse_validate_config.
> > > >
> > > > RFC v2:
> > > > * Cache group information in kernel, as we need to provide the vq m=
ap
> > > >   tokens properly.
> > > > * Add descs vq group to optimize SVQ forwarding and support indirec=
t
> > > >   descriptors out of the box.
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++=
----
> > > >  include/uapi/linux/vduse.h         | 12 +++++++---
> > > >  2 files changed, 41 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 2b6a8958ffe0..42f8807911d4 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -59,6 +59,7 @@ struct vduse_virtqueue {
> > > >         struct vdpa_vq_state state;
> > > >         bool ready;
> > > >         bool kicked;
> > > > +       u32 vq_group;
> > > >         spinlock_t kick_lock;
> > > >         spinlock_t irq_lock;
> > > >         struct eventfd_ctx *kickfd;
> > > > @@ -115,6 +116,7 @@ struct vduse_dev {
> > > >         u8 status;
> > > >         u32 vq_num;
> > > >         u32 vq_align;
> > > > +       u32 ngroups;
> > > >         struct vduse_umem *umem;
> > > >         struct mutex mem_lock;
> > > >         unsigned int bounce_size;
> > > > @@ -593,6 +595,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa=
_device *vdpa, u16 idx,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +
> > > > +       return dev->vqs[idx]->vq_group;
> > >
> > > I wonder if we should fail if VDUSE_VQ_SETUP is not set by userspace?
> > >
> >
> > I'm kind of ok with implementing it, but I see it as redundant as if
> > the VDUSE device does not call the vq max size will be 0 anyway.
>
> Is this better to fail (I meant return int instead of a u32, probably
> require changes in the vdpa core)?
>

Sending a new series with this.

> >
> > > > +}
> > > > +
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -790,6 +799,7 @@ static const struct vdpa_config_ops vduse_vdpa_=
config_ops =3D {
> > > >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> > > >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> > > >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > > > +       .get_vq_group           =3D vduse_get_vq_group,
> > > >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> > > >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> > > >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > > > @@ -1253,12 +1263,21 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >                 if (config.index >=3D dev->vq_num)
> > > >                         break;
> > > >
> > > > -               if (!is_mem_zero((const char *)config.reserved,
> > > > -                                sizeof(config.reserved)))
> > > > +               if (dev->api_version < VDUSE_API_VERSION_1 && confi=
g.group)
> > > > +                       break;
> > > > +
> > > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1 &&
> > > > +                   config.group > dev->ngroups)
> > > > +                       break;
> > > > +
> > > > +               if (config.reserved1 ||
> > > > +                   !is_mem_zero((const char *)config.reserved2,
> > > > +                                sizeof(config.reserved2)))
> > > >                         break;
> > >
> > > What's the reason for having this check? I mean if we don't check thi=
s
> > > since the day0, it might be too late to do that.
> > >
> >
> > It's been checked from day0, both reserved1 and reserved2 were
> > included in the config.reserved before the patch, and the replaced
> > lines already checked with is_mem_zero [1].
>
> Ok. I see.
>
> >
> > > >
> > > >                 index =3D array_index_nospec(config.index, dev->vq_=
num);
> > > >                 dev->vqs[index]->num_max =3D config.max_size;
> > > > +               dev->vqs[index]->vq_group =3D config.group;
> > > >                 ret =3D 0;
> > > >                 break;
> > > >         }
> > > > @@ -1738,12 +1757,19 @@ static bool features_is_valid(struct vduse_=
dev_config *config)
> > > >         return true;
> > > >  }
> > > >
> > > > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > > > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > > > +                                 u64 api_version)
> > > >  {
> > > >         if (!is_mem_zero((const char *)config->reserved,
> > > >                          sizeof(config->reserved)))
> > > >                 return false;
> > > >
> > > > +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > > > +               return false;
> > >
> > > Better with ngroups > 1?
> > >
> >
> > Same here. The kernel in the master branch already returns false if
> > that position of "reserved" is 1, and we are changing the behavior if
> > we don't include the 1 too.
> >
> > > > +
> > > > +       if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups=
 > 0xffff)
> > > > +               return false;
> > > > +
> > > >         if (config->vq_align > PAGE_SIZE)
> > > >                 return false;
> > > >
> > > > @@ -1859,6 +1885,7 @@ static int vduse_create_dev(struct vduse_dev_=
config *config,
> > > >         dev->device_features =3D config->features;
> > > >         dev->device_id =3D config->device_id;
> > > >         dev->vendor_id =3D config->vendor_id;
> > > > +       dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngro=
ups ?: 1);
> > > >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> > > >         if (!dev->name)
> > > >                 goto err_str;
> > > > @@ -1937,7 +1964,7 @@ static long vduse_ioctl(struct file *file, un=
signed int cmd,
> > > >                         break;
> > > >
> > > >                 ret =3D -EINVAL;
> > > > -               if (vduse_validate_config(&config) =3D=3D false)
> > > > +               if (!vduse_validate_config(&config, control->api_ve=
rsion))
> > > >                         break;
> > > >
> > > >                 buf =3D vmemdup_user(argp + size, config.config_siz=
e);
> > > > @@ -2018,7 +2045,7 @@ static int vduse_dev_init_vdpa(struct vduse_d=
ev *dev, const char *name)
> > > >
> > > >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->de=
v,
> > > >                                  &vduse_vdpa_config_ops, &vduse_map=
_ops,
> > > > -                                1, 1, name, true);
> > > > +                                dev->ngroups, 1, name, true);
> > > >         if (IS_ERR(vdev))
> > > >                 return PTR_ERR(vdev);
> > > >
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.=
h
> > > > index ccb92a1efce0..a3d51cf6df3a 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -31,6 +31,7 @@
> > > >   * @features: virtio features
> > > >   * @vq_num: the number of virtqueues
> > > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > > > + * @ngroups: number of vq groups that VDUSE device declares
> > > >   * @reserved: for future use, needs to be initialized to zero
> > > >   * @config_size: the size of the configuration space
> > > >   * @config: the buffer of the configuration space
> > > > @@ -45,7 +46,8 @@ struct vduse_dev_config {
> > > >         __u64 features;
> > > >         __u32 vq_num;
> > > >         __u32 vq_align;
> > > > -       __u32 reserved[13];
> > > > +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > > +       __u32 reserved[12];
> > > >         __u32 config_size;
> > > >         __u8 config[];
> > > >  };
> > > > @@ -122,14 +124,18 @@ struct vduse_config_data {
> > > >   * struct vduse_vq_config - basic configuration of a virtqueue
> > > >   * @index: virtqueue index
> > > >   * @max_size: the max size of virtqueue
> > > > - * @reserved: for future use, needs to be initialized to zero
> > > > + * @reserved1: for future use, needs to be initialized to zero
> > > > + * @group: virtqueue group
> > > > + * @reserved2: for future use, needs to be initialized to zero
> > > >   *
> > > >   * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
> > > >   */
> > > >  struct vduse_vq_config {
> > > >         __u32 index;
> > > >         __u16 max_size;
> > > > -       __u16 reserved[13];
> > > > +       __u16 reserved1;
> > > > +       __u32 group;
> > >
> > > This makes me think if u16 is sufficient as I see:
> > >
> > >         u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
> > >
> > > The index is u16 but the group is u32 ...
> > >
> >
> > That's a very good point, but I got the reverse logic actually :). All
> > the vhost userland ioctls use an unsigned int (=3D=3Du32) already, so
> > VDUSE should keep going with that. If any, get_vq_group (and similar)
> > kernel internal API should move to u32 to keep up with userland API.
>
> Ok, I see this:
>
> struct vhost_vring_state {
>         unsigned int index;
>         unsigned int num;
> };
>
> It is just a little bit weird that we leave a hole.
>

I don't like the hole in the struct either, but I find it cosmetic
compared to the drawbacks of the alternatives. I find it even more
cosmetic seeing that 6.17 is approaching :).

