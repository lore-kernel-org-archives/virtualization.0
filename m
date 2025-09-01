Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD11863E
	for <virtualization@lists.linux.dev>; Mon,  1 Sep 2025 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693916; cv=none; b=a9MrVpmaxDIq1hfRt27EBwSFPD1MFnf45osaNSeHOutDo4ERk0NbSbcrVF4dyoT3OtVuuza70fxZUH+dTDU1Rfji2/sp/jwjB6rcDuvmD48WWhhxAYdM7zmxodw2jY/S6/7c3ET2V8KudgSWi1GurK2wbg/H7J5wUlQFYPZ0OB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693916; c=relaxed/simple;
	bh=siORwdMayUtw4qc5Kckui3izgWW+KqDC/hqt0/gGlSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsnoWFCWQUIhbKjgc4hQoWR4w1v61ygiBVbMoU1TrrHDvhnxAQKOOVf8AUu8hWNmjS8NFVMUBSwSAmPxYAqL/h3HzrFVkfAY4pfsgkIkcKIfRUkUrG3HL641zlSNEWPzQKA2xupmOYht94KTPQJ0uEXe3zFjSB/zCL062FjjvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+NOKOHG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+NOKOHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756693912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7v4jfKPcBEynUWEFS5XS2jfe0dwO+QCrgAQuf8pEiJU=;
	b=c+NOKOHGLGg1e18NRLDCDJniI7SmuaKrjntzt66utFmnBkVI3A8omiYKfjAHY/Rx650uVk
	Q9szxehq4HiQrBUlj5Wc2tDuf+zLDjujJg8+bIz94Btg/B29d/bDtn/2k9i15RWbC2Gij7
	GghL5l3ShYpsjIvb/KUgOytaJYBBqB8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-kH6Vi2LLM-K1t-F1bEU5UQ-1; Sun, 31 Aug 2025 22:31:51 -0400
X-MC-Unique: kH6Vi2LLM-K1t-F1bEU5UQ-1
X-Mimecast-MFC-AGG-ID: kH6Vi2LLM-K1t-F1bEU5UQ_1756693910
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c73924056so2014999a12.3
        for <virtualization@lists.linux.dev>; Sun, 31 Aug 2025 19:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756693910; x=1757298710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v4jfKPcBEynUWEFS5XS2jfe0dwO+QCrgAQuf8pEiJU=;
        b=jE4c6QwyVf6eUypsRMfoFkHFAHb2y+RTmgMOUOsKwvuuCH9jZeaUUCbHpnIMCZTULP
         h93shhZYBCEZ3aulXmO4579asbx2ianlc2vRkhu6Sru76e7AxOcqPpzax6HQ2MNkxyVd
         /mYCXpGDQ+RIvteavSBc+UDm4dO0Ta9J9evSYZzq5839BonhbXcZ9krrPXBffpJUSkGc
         bM829qqX3OcUpjmXr+JoyBpgv3W77E1Eb1dVtTqx/e6JbFtXCm3S3Wm3H9n1JYLLbYr3
         SleUzRaeFUYrpOJRLXDh40R9JgePZkZg9WfYwveHQ96e0b7R0GORkRZkPMl6Hn0RNR+x
         hUvA==
X-Forwarded-Encrypted: i=1; AJvYcCXs5J2FLSyucLxShKe2l8ekp8Fp11LrO1eM5+aeIr8QxPeHGb4eU8Sxi8zEXcxr5CfH2ooFcUR87QRolmuDmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyzva3MTquo7+3UvNKSEN0G2cfsvugCdcJJUCKu2oGQmKCtFJXU
	3geDrNCjcNtC+CCcqlRNCycoNy1mbt/snCDCv6HZWxtBWhpmNyi39uMLti36LI3II7YsJ/4X4yp
	6/b6O+6Vj2DivDwAl7yfkA5tpvVCPma6pwJFDe4a4gNRZNQzypplpja6rndPaiA9ayJ+ciEkrwI
	0mOQnPOgG9rLeQxaJe9zDtUldcWBl9Yg6jXGJJlG1GjC3mqoNxyOxjbar0
X-Gm-Gg: ASbGncsf7zwh7ey+f7M1b4rIbvYhiFRq8kZOacgEC9c6bJCuG4aTxv7IkZJFJ9d9n6V
	GfOKF2SZP1wrzsH5p2k/z9wajXVgipH9CWaU3TVZHanQDPrbbGtsGZ93e5RFslTTUaqsahHzYam
	ixGNE35+JDYMy/h9fYN8Ugjw==
X-Received: by 2002:a17:902:e751:b0:246:b467:eea9 with SMTP id d9443c01a7336-249448f7469mr82210445ad.21.1756693910156;
        Sun, 31 Aug 2025 19:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy/1HgQ1ByCI84ssI7B6m6fyh0l47ooVje3fuTJLIeZnt/DfOO9DlqV7NJcUN8/8KANq8thIA3Tbs9RO3MHDs=
X-Received: by 2002:a17:902:e751:b0:246:b467:eea9 with SMTP id
 d9443c01a7336-249448f7469mr82210135ad.21.1756693909538; Sun, 31 Aug 2025
 19:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
In-Reply-To: <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Sep 2025 10:31:38 +0800
X-Gm-Features: Ac12FXxzKO4mimnV_4Q8oNuys-OcPJJIJIw8m0w62YCSwShH75yVJpUZMoIsVBI
Message-ID: <CACGkMEtQ7byU0+4EjvwEkHC8FLQ=vb9=k8Z=7mKvvc+MhEGLug@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DtmylbEWMXmHz8GESzFVKnjI8xk_6l_VNFt6mQBqcLw_1756693910
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
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
> > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++++++--
> >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> >  2 files changed, 68 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index e7bced0b5542..0f4e36dd167e 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> >         struct vdpa_vq_state state;
> >         bool ready;
> >         bool kicked;
> > +       u32 vq_group;
> >         spinlock_t kick_lock;
> >         spinlock_t irq_lock;
> >         struct eventfd_ctx *kickfd;
> > @@ -114,6 +115,7 @@ struct vduse_dev {
> >         u8 status;
> >         u32 vq_num;
> >         u32 vq_align;
> > +       u32 ngroups;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> >         return 0;
> >  }
> >
> > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +       return dev->vqs[idx]->vq_group;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_device=
 *vdpa)
> >         return dev->status;
> >  }
> >
> > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > +{
> > +       /* All vqs and descs must be in vq group 0 if ngroups < 2 */
> > +       if (dev->ngroups < 2)
> > +               return 0;
> > +
> > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > +               struct vduse_dev_msg msg =3D { 0 };
> > +               int ret;
> > +
> > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > +               msg.req.vq_group.index =3D i;
> > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.group;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> >  {
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdpa_devi=
ce *vdpa, u8 status)
> >         if (vduse_dev_set_status(dev, status))
> >                 return;
> >
> > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK) &&
> > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > +               if (vduse_fill_vq_groups(dev))
> > +                       return;
>
> I may lose some context but I think we've agreed that we need to
> extend the status response for this instead of having multiple
> indepdent response.

Btw, I wonder why don't we get the vq group per .get_vq_group()

Thanks

>
> > +
> >         dev->status =3D status;
> >  }
> >
> > @@ -789,6 +825,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > +       .get_vq_group           =3D vduse_get_vq_group,
> >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > @@ -1737,12 +1774,19 @@ static bool features_is_valid(struct vduse_dev_=
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
> > +
> > +       if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups > 0=
xffff)
> > +               return false;
>
> Let's use a macro instead of magic number.
>
> > +
> >         if (config->vq_align > PAGE_SIZE)
> >                 return false;
> >
> > @@ -1858,6 +1902,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +       dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups =
?: 1);
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> >                 goto err_str;
> > @@ -1936,7 +1981,7 @@ static long vduse_ioctl(struct file *file, unsign=
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
> > @@ -2017,7 +2062,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
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
> > index 9a56d0416bfe..b1c0e47d71fb 100644
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
> > @@ -160,6 +162,16 @@ struct vduse_vq_state_packed {
> >         __u16 last_used_idx;
> >  };
> >
> > +/**
> > + * struct vduse_vq_group - virtqueue group
> > + * @index: Index of the virtqueue
> > + * @group: Virtqueue group
> > + */
> > +struct vduse_vq_group {
> > +       __u32 index;
> > +       __u32 group;
> > +};
> > +
> >  /**
> >   * struct vduse_vq_info - information of a virtqueue
> >   * @index: virtqueue index
> > @@ -274,6 +286,7 @@ enum vduse_req_type {
> >         VDUSE_GET_VQ_STATE,
> >         VDUSE_SET_STATUS,
> >         VDUSE_UPDATE_IOTLB,
> > +       VDUSE_GET_VQ_GROUP,
> >  };
> >
> >  /**
> > @@ -316,6 +329,7 @@ struct vduse_iova_range {
> >   * @vq_state: virtqueue state, only index field is available
> >   * @s: device status
> >   * @iova: IOVA range for updating
> > + * @vq_group: virtqueue group of a virtqueue
> >   * @padding: padding
> >   *
> >   * Structure used by read(2) on /dev/vduse/$NAME.
> > @@ -328,6 +342,8 @@ struct vduse_dev_request {
> >                 struct vduse_vq_state vq_state;
> >                 struct vduse_dev_status s;
> >                 struct vduse_iova_range iova;
> > +               /* Only if vduse api version >=3D 1 */;
> > +               struct vduse_vq_group vq_group;
> >                 __u32 padding[32];
> >         };
> >  };
> > @@ -338,6 +354,7 @@ struct vduse_dev_request {
> >   * @result: the result of request
> >   * @reserved: for future use, needs to be initialized to zero
> >   * @vq_state: virtqueue state
> > + * @vq_group: virtqueue group of a virtqueue
> >   * @padding: padding
> >   *
> >   * Structure used by write(2) on /dev/vduse/$NAME.
> > @@ -350,6 +367,8 @@ struct vduse_dev_response {
> >         __u32 reserved[4];
> >         union {
> >                 struct vduse_vq_state vq_state;
> > +               /* Only if vduse api version >=3D 1 */
> > +               struct vduse_vq_group vq_group;
> >                 __u32 padding[32];
> >         };
> >  };
> > --
> > 2.51.0
> >
>
> Thanks

