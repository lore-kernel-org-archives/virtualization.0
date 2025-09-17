Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7C314D36
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123749; cv=none; b=kz7aSBaaumzZZe+apeGKFK0NrByM41WLOhRG/RLdgqyYfYXpKwQ4H485MCiEOyZbE33ADKMf+OGS8zXCLvDHQanD34586As2R3QWCfJksJTrMGqF1/gqqCuobPuT8Qpe4Oxpt7esz9sCHvN5mgq9VoDeFjFZbzes3hPzi4KBhjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123749; c=relaxed/simple;
	bh=P9Q70W+Ic4EYe9oyW2PKBgA+8S/F5OLM4eIJ/534w8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpxASnUhOFyEIR63BHMh6anV3947RKDpX+f4CF6N7OtDM2CfFTjdqo1M83QSlmP2MQDAzOWGGp5gdRWKXmKG7jBhBfFsr6V2+rf6qBkVZuto6BnijOPVLY3QsM9VT0cYFIH4WtxeuTydUH9mzr000VUmQIgFza22ocMrAelCffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnRbxsYw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnRbxsYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758123746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPN0dHRPryDKWq/zm65+OG6eMpi/ANVf5sCNoaNPxU0=;
	b=gnRbxsYwJ5rK0nMx1NBs3HQbUC7kVYVxHCkxeMSdEDo9g1i3a2QAFrrK88C9i3eFTZ/YU2
	3KMC0LPNMFlvQ5F6ac0fL06wrhx/dql2fbabhkMCOGulLez0PN5Txnk1tDkIz5yYsGMjjF
	7iEjJRQtZOKIaAkh829VoYVp5iXbyw0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-KI9UWVW4NruV_M86g0t9yQ-1; Wed, 17 Sep 2025 11:42:19 -0400
X-MC-Unique: KI9UWVW4NruV_M86g0t9yQ-1
X-Mimecast-MFC-AGG-ID: KI9UWVW4NruV_M86g0t9yQ_1758123738
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55f6f4dea68so4525980e87.0
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 08:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123738; x=1758728538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPN0dHRPryDKWq/zm65+OG6eMpi/ANVf5sCNoaNPxU0=;
        b=bdW/eK7SJtiCJKHZMl5kvR+PRfHIVL+4CcFk5CCX8P8NGlHpJpldi82sRm82mg5lo2
         JVjmBAXD6/QOqDbb+M/L2JkxVV9NZ6r41EXVwAfTrKui74dJYfbM8+jOt3ysYryRm4xh
         NLNF1N5LDo106VwgJ0BUUYbRrb4Td0yaMaRZEhgHoOVqRY4FcqesC11Y0iaK/1t9CBL/
         tcEzKHAqITkbpqYjrtpuoofyNk4AzIDs5PNNmUub+3HDcp++OIaSGlETOfRIa1r4m62L
         UoJNPZBdogLRFkUThdsfu8peUQBBpr4fUARJAf7dnjdOFkynfWRFjmY2M2ctksQPINrB
         FM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUi5Q+8/nXVA3rk+5EPj/iOQ+60hcJHEU5cP10XscXhgeSVDtc3TT3KLXtBd7/Qd3U9pEbKGxR6V4bmatL/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3c2Wigun4sLJIUq57niH+DOLCWzPGOkK2pKy0S1wpSZgg2KP2
	y86eYxX9l1911WBriPemjb0b6VjlrtpLaZ84uziI8XpinaLNXzGeqCV0e5U+S7CqYvaMBOPfEmB
	7w2H8jHi2EwZYCGbtoTXgA19ZWOrmAwCWb7Cq8a7vkHwuzfp7nnRZn1EQ/turvzFCXH+0sl7LhB
	Z7aorZ+sB6asAFDJbXgXTKwyPUKRf1knjQHR/NEHJNFAg=
X-Gm-Gg: ASbGnctExQT4bvE2vlXIdoHysAgZxJdXT8HlGCIzWNgxF6eadculUkQQcxyx9vBc1zD
	vQKUACX7Q6fDStr3CNCvRTB91fkbT5sLm0N2INpBRDV3GuGshONvOxufJPb519cw59pe0TBvc1R
	MU3sYZV+3h2O2arsAh8pAbJlwPHKsTaxkiO3+5xoiHlklTR/Uvg/tHdbKanXQUTsE9n6TvI4dmH
	3tLLSaV
X-Received: by 2002:a05:6512:3356:b0:55f:6c3b:7b3d with SMTP id 2adb3069b0e04-57798e1b87cmr808677e87.28.1758123737705;
        Wed, 17 Sep 2025 08:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQgQl/SvTIW2Wu/CQXxSmO3uRQElCvs5sMTx4nuA8wLFKACymUD+rNx8WqXB2KN/JPB3IpQtvWYVJ7pVsPeHY=
X-Received: by 2002:a05:6512:3356:b0:55f:6c3b:7b3d with SMTP id
 2adb3069b0e04-57798e1b87cmr808659e87.28.1758123737156; Wed, 17 Sep 2025
 08:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-4-eperezma@redhat.com>
 <CACGkMEv+FxECjhxfEKjZJcqXKc=c7RogAk6wdptBymTvL0fz1Q@mail.gmail.com>
In-Reply-To: <CACGkMEv+FxECjhxfEKjZJcqXKc=c7RogAk6wdptBymTvL0fz1Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 17:41:36 +0200
X-Gm-Features: AS18NWBYrdLBzT8YdeFrpJVn8K6S6deW49UHj3MfDqaTA-ihjHdxVryUX_buU0w
Message-ID: <CAJaqyWeFDSXQtUnZG_O226YBu1Zy_L8ws_UMDGVTMA=YfrGcFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KhoLg6bR54TeI5TUWGMAcR3b5Mji_f_7Qc6WOTyW2b0_1758123738
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Sep 16, 2025 at 9:08=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > This allows sepparate the different virtqueues in groups that shares th=
e
> > same address space.  Asking the VDUSE device for the groups of the vq a=
t
> > the beginning as they're needed for the DMA API.
> >
> > Allocating 3 vq groups as net is the device that need the most groups:
> > * Dataplane (guest passthrough)
> > * CVQ
> > * Shadowed vrings.
> >
> > Future versions of the series can include dynamic allocation of the
> > groups array so VDUSE can declare more groups.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v2:
> > * Now the vq group is in vduse_vq_config struct instead of issuing one
> >   VDUSE message per vq.
> >
> > v1:
> > * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove the descs vq group capability as it will not be used and we ca=
n
> >   add it on top.
> > * Do not ask for vq groups in number of vq groups < 2.
> > * Move the valid vq groups range check to vduse_validate_config.
> >
> > RFC v2:
> > * Cache group information in kernel, as we need to provide the vq map
> >   tokens properly.
> > * Add descs vq group to optimize SVQ forwarding and support indirect
> >   descriptors out of the box.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++----
> >  include/uapi/linux/vduse.h         | 12 +++++++---
> >  2 files changed, 41 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 2b6a8958ffe0..42f8807911d4 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -59,6 +59,7 @@ struct vduse_virtqueue {
> >         struct vdpa_vq_state state;
> >         bool ready;
> >         bool kicked;
> > +       u32 vq_group;
> >         spinlock_t kick_lock;
> >         spinlock_t irq_lock;
> >         struct eventfd_ctx *kickfd;
> > @@ -115,6 +116,7 @@ struct vduse_dev {
> >         u8 status;
> >         u32 vq_num;
> >         u32 vq_align;
> > +       u32 ngroups;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> > @@ -593,6 +595,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> >         return 0;
> >  }
> >
> > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +       return dev->vqs[idx]->vq_group;
>
> I wonder if we should fail if VDUSE_VQ_SETUP is not set by userspace?
>

I'm kind of ok with implementing it, but I see it as redundant as if
the VDUSE device does not call the vq max size will be 0 anyway.

> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -790,6 +799,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > +       .get_vq_group           =3D vduse_get_vq_group,
> >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > @@ -1253,12 +1263,21 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                 if (config.index >=3D dev->vq_num)
> >                         break;
> >
> > -               if (!is_mem_zero((const char *)config.reserved,
> > -                                sizeof(config.reserved)))
> > +               if (dev->api_version < VDUSE_API_VERSION_1 && config.gr=
oup)
> > +                       break;
> > +
> > +               if (dev->api_version >=3D VDUSE_API_VERSION_1 &&
> > +                   config.group > dev->ngroups)
> > +                       break;
> > +
> > +               if (config.reserved1 ||
> > +                   !is_mem_zero((const char *)config.reserved2,
> > +                                sizeof(config.reserved2)))
> >                         break;
>
> What's the reason for having this check? I mean if we don't check this
> since the day0, it might be too late to do that.
>

It's been checked from day0, both reserved1 and reserved2 were
included in the config.reserved before the patch, and the replaced
lines already checked with is_mem_zero [1].

> >
> >                 index =3D array_index_nospec(config.index, dev->vq_num)=
;
> >                 dev->vqs[index]->num_max =3D config.max_size;
> > +               dev->vqs[index]->vq_group =3D config.group;
> >                 ret =3D 0;
> >                 break;
> >         }
> > @@ -1738,12 +1757,19 @@ static bool features_is_valid(struct vduse_dev_=
config *config)
> >         return true;
> >  }
> >
> > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > +                                 u64 api_version)
> >  {
> >         if (!is_mem_zero((const char *)config->reserved,
> >                          sizeof(config->reserved)))
> >                 return false;
> >
> > +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +               return false;
>
> Better with ngroups > 1?
>

Same here. The kernel in the master branch already returns false if
that position of "reserved" is 1, and we are changing the behavior if
we don't include the 1 too.

> > +
> > +       if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups > 0=
xffff)
> > +               return false;
> > +
> >         if (config->vq_align > PAGE_SIZE)
> >                 return false;
> >
> > @@ -1859,6 +1885,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +       dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups =
?: 1);
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> >                 goto err_str;
> > @@ -1937,7 +1964,7 @@ static long vduse_ioctl(struct file *file, unsign=
ed int cmd,
> >                         break;
> >
> >                 ret =3D -EINVAL;
> > -               if (vduse_validate_config(&config) =3D=3D false)
> > +               if (!vduse_validate_config(&config, control->api_versio=
n))
> >                         break;
> >
> >                 buf =3D vmemdup_user(argp + size, config.config_size);
> > @@ -2018,7 +2045,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
dev, const char *name)
> >
> >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> >                                  &vduse_vdpa_config_ops, &vduse_map_ops=
,
> > -                                1, 1, name, true);
> > +                                dev->ngroups, 1, name, true);
> >         if (IS_ERR(vdev))
> >                 return PTR_ERR(vdev);
> >
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index ccb92a1efce0..a3d51cf6df3a 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -31,6 +31,7 @@
> >   * @features: virtio features
> >   * @vq_num: the number of virtqueues
> >   * @vq_align: the allocation alignment of virtqueue's metadata
> > + * @ngroups: number of vq groups that VDUSE device declares
> >   * @reserved: for future use, needs to be initialized to zero
> >   * @config_size: the size of the configuration space
> >   * @config: the buffer of the configuration space
> > @@ -45,7 +46,8 @@ struct vduse_dev_config {
> >         __u64 features;
> >         __u32 vq_num;
> >         __u32 vq_align;
> > -       __u32 reserved[13];
> > +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > +       __u32 reserved[12];
> >         __u32 config_size;
> >         __u8 config[];
> >  };
> > @@ -122,14 +124,18 @@ struct vduse_config_data {
> >   * struct vduse_vq_config - basic configuration of a virtqueue
> >   * @index: virtqueue index
> >   * @max_size: the max size of virtqueue
> > - * @reserved: for future use, needs to be initialized to zero
> > + * @reserved1: for future use, needs to be initialized to zero
> > + * @group: virtqueue group
> > + * @reserved2: for future use, needs to be initialized to zero
> >   *
> >   * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
> >   */
> >  struct vduse_vq_config {
> >         __u32 index;
> >         __u16 max_size;
> > -       __u16 reserved[13];
> > +       __u16 reserved1;
> > +       __u32 group;
>
> This makes me think if u16 is sufficient as I see:
>
>         u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
>
> The index is u16 but the group is u32 ...
>

That's a very good point, but I got the reverse logic actually :). All
the vhost userland ioctls use an unsigned int (=3D=3Du32) already, so
VDUSE should keep going with that. If any, get_vq_group (and similar)
kernel internal API should move to u32 to keep up with userland API.

[1] https://patchew.org/linux/20250606115012.1331551-1-eperezma@redhat.com/=
20250606115012.1331551-4-eperezma@redhat.com/

