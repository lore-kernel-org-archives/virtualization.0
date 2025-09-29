Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3F1DEFE8
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125295; cv=none; b=eN3umWOkRdVKgMrvd43K/gJ8CcibgvipyBRs7bdrZOxkhyh/bKjRuADDi0N7Cu3zu50cv0nwhtF5Hy+U2SVAjbzuXii+LFf3Bjn4o74+EmyJ8SPMZlh5IvzROy77dCc+hW1GYZz2AAAff28eieOmq3BONvPxsqvSHi36FvOes88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125295; c=relaxed/simple;
	bh=8/E2ldD2d5q0fEc83LhadtKerq4Ej4nbZEJYOBXdJlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqvgjpUJJSDXuzfC/cpONKq+sQdjWIWG+NeLaxLA3rZZul+wraQNqPTDGt/NfP1M2kkfPuO1j5L6CqoUhUt91igaEilWGESzDom/Y/FhhgYs5ZcpWeFMNZsZzYk6DZ7S+Rb7z2r9ArmSw6nbMXdI2QvjVejUbfjdv30lWbTFDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R118SVJx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R118SVJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8maNDgdqKly9BiQbDozT3WeIIEQRXlKan+MIsttrfw=;
	b=R118SVJxCWCVnl0JMOG4V1tdBBtAfWT69C7LS+i2sxOv4C7+usKXFpdat9zzn8crG7DeNL
	iGvs+m7SSJ8QNFQVqPL+Y9tUQM+kNSCCIN8BblI9FYFEp0cGkL5mjPJJz5iVnbCRCgSZXX
	ZjOhd6lVGUKgMZvWu4M81arII+7xvKY=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-v7xF1z4EP-KOm5ww5FmZ8g-1; Mon, 29 Sep 2025 01:54:48 -0400
X-MC-Unique: v7xF1z4EP-KOm5ww5FmZ8g-1
X-Mimecast-MFC-AGG-ID: v7xF1z4EP-KOm5ww5FmZ8g_1759125288
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-60fb0c64421so5708870d50.2
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 22:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125288; x=1759730088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8maNDgdqKly9BiQbDozT3WeIIEQRXlKan+MIsttrfw=;
        b=HEAr+8hysVyBEExRVqP9WsdbNrMDHjJNdlnyJMlu9iIe0brq35VtvDla0y8wnyGkq5
         irZBcC93NUH6RZcBifufwstnnpCMz92qk6o2Ak+NcLhrs4dCQGFO0KpMWy2lA9k64eJg
         4kKjC7BvrZMO3vdDbidtmZ5uvP7m7QzOvS4fuEL/dZgwqAaF/yIilXQ88ZKOdZopkP/g
         CS9LLbqFIDJ3FypNom/T/a1HZTYXsPYgt3PgF2SldzYXXtwpJEoddCS0rB5EHJyVW/Jl
         Oiz0xKZMrxkmO0TsX7J6b479NIvLIl7cQWkuzRfOajZBllYndQS2DHVZ3KD94UOZfC4Z
         8Odw==
X-Forwarded-Encrypted: i=1; AJvYcCWcM7suNnMOuoe0KFa5SMkvOpgFn1mk6jAC9gsTmuazhnUOzB0B06xapr3t/569HWyDBndl/A9yNJTR0aUkfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOOkHX1qOqL/pvBLvZak1fN73yCQ4QpCfU3Ung3mGQaXmJMaiy
	FLqXpuwoVzaDHqE2sFW2sxaAAO3nG9gorgJ3g3wGqqVxGW4R3BBuj9ktPnDPFrZpEDt8WiZdYFN
	hJqexKwCHW1lgCmd/VoFQM9ON1KZLUzJy26bluLe+0P6cTl+zM2O0OLOOifYBejqUC9zunXiLYC
	h3zcvU7BoqMRB4iAduZhbbz80KTYVLMNpex5dMuwc37L8=
X-Gm-Gg: ASbGncsEryhG4yZm6orVLSj9FaON9+5qYMwPGAVXCjSMhAtNi2FoZsm0Ox5j2S7atZh
	PmamHcIche811JxipPNZ+XMKNo+HY/QbefQPFH5xKFsxKjErmAppYtuXimqniKoiRwku+vUAPd6
	OlaVpgfithG5+t8fvoOeUfoH/fEDHEtWMGY4QwAoC+ugyYCQ+EjqXz5hiNGs9sv9JZaCUPF5RhY
	wWHi2M6
X-Received: by 2002:a53:5009:0:b0:5f3:319c:ff0a with SMTP id 956f58d0204a3-6361a7b92ffmr12511246d50.28.1759125287872;
        Sun, 28 Sep 2025 22:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyCK8uLcphB63nbexDPDDs8eK401XtWuvD3A7MVsBqFDygM2N9TSedA53SK67ekYVbIrFtK9DFzn6x08oNE34=
X-Received: by 2002:a53:5009:0:b0:5f3:319c:ff0a with SMTP id
 956f58d0204a3-6361a7b92ffmr12511241d50.28.1759125287445; Sun, 28 Sep 2025
 22:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926105938-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926105938-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 07:54:10 +0200
X-Gm-Features: AS18NWD0M0BrNB-5ZJFshe0N4FI1QlS26_QY2sGc-me5F0QYk2o7zDGY1K4E_wg
Message-ID: <CAJaqyWfZLw8NicJA93yrz7f9m_t6e9fbkEyycTDb-pE=ARzYAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e5iV73xExiCi8oz4xu_4Ipm1DwBNGna8-Xd-IlsOXzQ_1759125288
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:59=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio P=C3=A9rez wrote:
> > This allows sepparate the different virtqueues in groups that shares th=
e
>
> separate
>

Fixing, thanks!

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
> > v5:
> > * Revert core vdpa changes (Jason).
> > * Fix group =3D=3D ngroup case in checking VQ_SETUP argument (Jason).
> >
> > v4:
> > * Revert the "invalid vq group" concept and assume 0 if not set (Jason)=
.
> > * Make config->ngroups =3D=3D 0 invalid (Jason).
> >
> > v3:
> > * Make the default group an invalid group as long as VDUSE device does
> >   not set it to some valid u32 value.  Modify the vdpa core to take tha=
t
> >   into account (Jason).
> > * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
> >
> > v2:
> > * Now the vq group is in vduse_vq_config struct instead of issuing one
> >   VDUSE message per vq.
> >
> > v1:
> > * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lowe=
r
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 46 ++++++++++++++++++++++++++----
> >  include/uapi/linux/vduse.h         | 12 ++++++--
> >  2 files changed, 50 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 2b6a8958ffe0..99e37def7a83 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -40,6 +40,7 @@
> >  #define DRV_LICENSE  "GPL v2"
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > +#define VDUSE_DEV_MAX_GROUPS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -59,6 +60,7 @@ struct vduse_virtqueue {
> >       struct vdpa_vq_state state;
> >       bool ready;
> >       bool kicked;
> > +     u32 vq_group;
> >       spinlock_t kick_lock;
> >       spinlock_t irq_lock;
> >       struct eventfd_ctx *kickfd;
> > @@ -115,6 +117,7 @@ struct vduse_dev {
> >       u8 status;
> >       u32 vq_num;
> >       u32 vq_align;
> > +     u32 ngroups;
> >       struct vduse_umem *umem;
> >       struct mutex mem_lock;
> >       unsigned int bounce_size;
> > @@ -456,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
> >               vq->driver_addr =3D 0;
> >               vq->device_addr =3D 0;
> >               vq->num =3D 0;
> > +             vq->vq_group =3D 0;
> >               memset(&vq->state, 0, sizeof(vq->state));
> >
> >               spin_lock(&vq->kick_lock);
> > @@ -593,6 +597,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> >       return 0;
> >  }
> >
> > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +     struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +     if (dev->api_version < VDUSE_API_VERSION_1)
> > +             return 0;
> > +
> > +     return dev->vqs[idx]->vq_group;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                               struct vdpa_vq_state *state)
> >  {
> > @@ -790,6 +804,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >       .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> >       .set_vq_num             =3D vduse_vdpa_set_vq_num,
> >       .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > +     .get_vq_group           =3D vduse_get_vq_group,
> >       .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> >       .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> >       .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > @@ -1253,12 +1268,24 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >               if (config.index >=3D dev->vq_num)
> >                       break;
> >
> > -             if (!is_mem_zero((const char *)config.reserved,
> > -                              sizeof(config.reserved)))
> > +             if (dev->api_version < VDUSE_API_VERSION_1 && config.grou=
p)
> > +                     break;
> > +
> > +             if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > +                     if (config.group >=3D dev->ngroups)
> > +                             break;
> > +                     if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > +                             break;
> > +             }
> > +
> > +             if (config.reserved1 ||
> > +                 !is_mem_zero((const char *)config.reserved2,
> > +                              sizeof(config.reserved2)))
> >                       break;
> >
> >               index =3D array_index_nospec(config.index, dev->vq_num);
> >               dev->vqs[index]->num_max =3D config.max_size;
> > +             dev->vqs[index]->vq_group =3D config.group;
> >               ret =3D 0;
> >               break;
> >       }
> > @@ -1738,12 +1765,20 @@ static bool features_is_valid(struct vduse_dev_=
config *config)
> >       return true;
> >  }
> >
> > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > +                               u64 api_version)
> >  {
> >       if (!is_mem_zero((const char *)config->reserved,
> >                        sizeof(config->reserved)))
> >               return false;
> >
> > +     if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +             return false;
> > +
> > +     if (api_version >=3D VDUSE_API_VERSION_1 &&
> > +         (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
> > +             return false;
> > +
> >       if (config->vq_align > PAGE_SIZE)
> >               return false;
> >
> > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >       dev->device_features =3D config->features;
> >       dev->device_id =3D config->device_id;
> >       dev->vendor_id =3D config->vendor_id;
> > +     dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups;
> >       dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >       if (!dev->name)
> >               goto err_str;
> > @@ -1937,7 +1973,7 @@ static long vduse_ioctl(struct file *file, unsign=
ed int cmd,
> >                       break;
> >
> >               ret =3D -EINVAL;
> > -             if (vduse_validate_config(&config) =3D=3D false)
> > +             if (!vduse_validate_config(&config, control->api_version)=
)
> >                       break;
> >
> >               buf =3D vmemdup_user(argp + size, config.config_size);
> > @@ -2018,7 +2054,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
dev, const char *name)
> >
> >       vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> >                                &vduse_vdpa_config_ops, &vduse_map_ops,
> > -                              1, 1, name, true);
> > +                              dev->ngroups, 1, name, true);
> >       if (IS_ERR(vdev))
> >               return PTR_ERR(vdev);
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
> >       __u64 features;
> >       __u32 vq_num;
> >       __u32 vq_align;
> > -     __u32 reserved[13];
> > +     __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > +     __u32 reserved[12];
> >       __u32 config_size;
> >       __u8 config[];
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
> >       __u32 index;
> >       __u16 max_size;
> > -     __u16 reserved[13];
> > +     __u16 reserved1;
> > +     __u32 group;
> > +     __u16 reserved2[10];
> >  };
> >
> >  /*
> > --
> > 2.51.0
>

