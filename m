Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0114BC2EF
	for <virtualization@lists.linux.dev>; Mon,  9 Jun 2025 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749449035; cv=none; b=avlCV+eZugQmNyoGR9eMBHCgL30gHND8sawFyvKhnq7UD4Mczny/Hon1HBIL8FQW5Oe3/w0h3PifZflMaWFlyvsALZdQoiiPpL+0b8vXTpPNtE3XMpjVRYY+aoNWxUQgMze3yYJN66ky3BRaa9SS3eWdyLBSNxGHKNBdbC3HRJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749449035; c=relaxed/simple;
	bh=anEx6Q1GORcMM4MFVE7AVvzYMmB51/GyYJ6QBMW7MHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTMIrx4p+A3m58cJ86Xo9Nbwhla+8tZ0CzrBxEJJAoZOb3TJZcUUKeIXQB9w+CRF6dOVPzh3zXdtVlJq3Q4XryDbPPuU9AtJt9OHlcdcEewfuDMJwJHWqZL/cdwYCwE/34dvjpfWUPYViPjDw82WCv7+6zw/GAMRjyQUBueMfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lh4PuXQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh4PuXQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749449032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26Xl/SrnqgZY2jjisEpGNY3Vm9gOd2QFFVcwc1l+xOQ=;
	b=Lh4PuXQySGW6JHQeeB3zeCNZYab5raRqPy7IwmkuRtn+0IB/IhM9bDMCRvHL2ev/m6MhQt
	x/WN0MMNgVnh6Dx/mWAeWPXDlfpoYbitkBJPJ+WZ3wwiar6/HoWI5XBKLfR1GqDCiQrBIp
	/DyafhEdEiJ2itBmSh1Wgw17yhuzGK4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-i1EXiPe5Mx-gFLbdJuKNIQ-1; Mon, 09 Jun 2025 02:03:51 -0400
X-MC-Unique: i1EXiPe5Mx-gFLbdJuKNIQ-1
X-Mimecast-MFC-AGG-ID: i1EXiPe5Mx-gFLbdJuKNIQ_1749449030
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2ede156ec4so4838599a12.0
        for <virtualization@lists.linux.dev>; Sun, 08 Jun 2025 23:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749449030; x=1750053830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26Xl/SrnqgZY2jjisEpGNY3Vm9gOd2QFFVcwc1l+xOQ=;
        b=XeAr6G5Vz4qRomJ0qvLdhjOTluJpTE8DLfV29CNUqByJ67XyYsVip5krtLW1VLhZ61
         sJwJIlBCwEQHPVhlg3OI3UQVkf0eIbEwCjpGKYY5VaN6pE/LdorF2w2ByLyaCmoxG5+D
         wq0Jao8VrIPSpqBWcPyRTariJ838jQNjNQsxqE9vLg15+tuJxG9tjEwU5ricnGa9mxDE
         LfWOJ3ZX14EcFlI3mcdahgBqaZbHl2EruhjccA/Oa/qrfNX/r5W0NmGkmV22Y0QO/gr5
         t9X+oznJAJ+pxZ9qKZkBZxclip5/0rrCblOL/K5otnfcrUy+MtbeCrqvnCwvVCuLYn1i
         d8wg==
X-Forwarded-Encrypted: i=1; AJvYcCWPUA97xAkbKWXuXBGxEce2I7SIJw7jtGPm7gTSR6ZngaU+I+AIVJZd8f/3vIqOlvRC6aYujn4gCXT+3HligQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMI4dA9L2xCLVHagtrIkOfcmDbWCZo1Xdl9b8e61G8kzKcAFne
	rWa7+iMFhFAFZAFs+Uid4MYSp58agNR6MCX2/q7KPfNQeoESQxtyLSqSTt/8+g32OWvP3grK5Al
	2V3+Apmeh9pFLZg5PVVI4au4JIP+DlRfkujUK+/wNK8ogieVQjCE0i5abvZ5fdMCiSy20D31WRE
	iY4KvU168QUoGH3H+pqgrf6IF11JovQdCZMWUdxuyW1W8=
X-Gm-Gg: ASbGncvCp+k7PrQtqH7xuthzot/stfup2nGoIYBqpR7XCkarGvVPXUqfkQtinHrqD48
	2Ax8TDKPugFUrq2D1s4ppjR0lBAHMtKjPk3PNSDejtSrCq0Hnl+FG87f9DoP0z647WiI=
X-Received: by 2002:a17:90a:dfcb:b0:313:2adc:b4ca with SMTP id 98e67ed59e1d1-3134730c74bmr19832399a91.18.1749449029793;
        Sun, 08 Jun 2025 23:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzIEsXVbUWGouiGqpAoQhK7m2qxoDMUzDjFfJpFD2MvPSP2If311S68qEEZoF4hqTKgQmRcXD2byXsx2a1QRA=
X-Received: by 2002:a17:90a:dfcb:b0:313:2adc:b4ca with SMTP id
 98e67ed59e1d1-3134730c74bmr19832354a91.18.1749449029311; Sun, 08 Jun 2025
 23:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-3-eperezma@redhat.com>
 <CACGkMEuGC6NQmfUgXj1YVyURQ6-S2YT2qkAuYQGLpqVaV75kJg@mail.gmail.com>
In-Reply-To: <CACGkMEuGC6NQmfUgXj1YVyURQ6-S2YT2qkAuYQGLpqVaV75kJg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 9 Jun 2025 08:03:13 +0200
X-Gm-Features: AX0GCFuUgwd7B_H2N-J_-v_CXDRiD3yPbsTonD8yIPnaMijsGvSSM5A1xceMDGo
Message-ID: <CAJaqyWcvHx7kwcTceN2jazT0nKNo1r5zdzqWHqpxdna-kCS1RA@mail.gmail.com>
Subject: Re: [RFC 2/6] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gi6hoWqOdV6km7Sr23wILs1S3HqvVWTtanZhY0IrCvQ_1749449030
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > The virtqueue group is the minimal set of virtqueues that must share an
> > address space.  And the address space identifier could only be attached
> > to a specific virtqueue group.  The virtqueue is attached to a
> > virtqueue group for all the life of the device.
> >
> > During vDPA device allocation, the VDUSE device needs to report the
> > number of virtqueue groups supported. At this moment only vhost_vdpa is
> > able to do it.
> >
> > This helps to isolate the environments for the virtqueue that will not
> > be assigned directly. E.g in the case of virtio-net, the control
> > virtqueue will not be assigned directly to guest.
> >
> > As we need to back the vq groups with a struct device for the file
> > operations, let's keep this number as low as possible at the moment: 2.
> > We can back one VQ group with the vduse device and the other one with
> > the vdpa device.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 44 +++++++++++++++++++++++++++++-
> >  include/uapi/linux/vduse.h         | 17 +++++++++++-
> >  2 files changed, 59 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 6a9a37351310..6fa687bc4912 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -46,6 +46,11 @@
> >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
> >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> >
> > +/*
> > + * Let's make it 2 for simplicity.
> > + */
> > +#define VDUSE_MAX_VQ_GROUPS 2
> > +
> >  #define IRQ_UNBOUND -1
> >
> >  struct vduse_virtqueue {
> > @@ -114,6 +119,7 @@ struct vduse_dev {
> >         u8 status;
> >         u32 vq_num;
> >         u32 vq_align;
> > +       u32 ngroups;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> > @@ -592,6 +598,25 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> >         return 0;
> >  }
> >
> > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +       struct vduse_dev_msg msg =3D { 0 };
> > +       int ret;
> > +
> > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > +               return 0;
> > +
> > +       msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > +       msg.req.vq_group.index =3D idx;
>
> Considering there will be a set_group_asid request, could the kernel
> cache the result so we don't need to bother with requests from
> userspace?
>

Yes we can, actually a previous version did it. But what's the use? It
is not used in the dataplane, so we reduce complexity if we don't
store it.

What's more, in the case of the net device, the vq number -> vq group
association can change in a reset as the CVQ is either the last one or
#2 if MQ is negotiated. We need to code when to reset this
association, so complexity grows even more. And the vq group are not
asked by QEMU after that point anyway.

> > +
> > +       ret =3D vduse_dev_msg_sync(dev, &msg);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return msg.resp.vq_group.num;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -789,6 +814,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > +       .get_vq_group           =3D vduse_get_vq_group,
> >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > @@ -1850,6 +1876,16 @@ static int vduse_create_dev(struct vduse_dev_con=
fig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +       if (dev->api_version >=3D 1) {
> > +               if (config->ngroups > VDUSE_MAX_VQ_GROUPS) {
> > +                       pr_err("Not creating a VDUSE device with %u vq =
groups. Max: %u",
> > +                               config->ngroups, VDUSE_MAX_VQ_GROUPS);
> > +                       goto err_ngroups;
> > +               }
> > +               dev->ngroups =3D config->ngroups ?: 1;
> > +       } else {
> > +               dev->ngroups =3D 1;
> > +       }
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> >                 goto err_str;
> > @@ -1885,6 +1921,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >         idr_remove(&vduse_idr, dev->minor);
> >  err_idr:
> >         kfree(dev->name);
> > +err_ngroups:
> >  err_str:
> >         vduse_dev_destroy(dev);
> >  err:
> > @@ -2003,13 +2040,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
> >  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name=
)
> >  {
> >         struct vduse_vdpa *vdev;
> > +       __u32 ngroups =3D 1;
> >         int ret;
> >
> >         if (dev->vdev)
> >                 return -EEXIST;
> >
> > +       if (vdev->dev->api_version >=3D VDUSE_API_VERSION_1)
> > +               ngroups =3D vdev->dev->ngroups;
> > +
> >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> > -                                &vduse_vdpa_config_ops, 1, 1, name, tr=
ue);
> > +                                &vduse_vdpa_config_ops, ngroups, 1, na=
me,
> > +                                true);
> >         if (IS_ERR(vdev))
> >                 return PTR_ERR(vdev);
> >
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 9a56d0416bfe..a779bcddac58 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -45,7 +45,8 @@ struct vduse_dev_config {
> >         __u64 features;
> >         __u32 vq_num;
> >         __u32 vq_align;
> > -       __u32 reserved[13];
> > +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > +       __u32 reserved[12];
> >         __u32 config_size;
> >         __u8 config[];
> >  };
> > @@ -160,6 +161,16 @@ struct vduse_vq_state_packed {
> >         __u16 last_used_idx;
> >  };
> >
> > +/**
> > + * struct vduse_vq_group - virtqueue group
> > + * @num: Index of the virtqueue group
> > + * @num: Group
> > + */
> > +struct vduse_vq_group {
> > +       __u32 index;
> > +       __u32 num;
> > +};
> > +
> >  /**
> >   * struct vduse_vq_info - information of a virtqueue
> >   * @index: virtqueue index
> > @@ -182,6 +193,7 @@ struct vduse_vq_info {
> >         union {
> >                 struct vduse_vq_state_split split;
> >                 struct vduse_vq_state_packed packed;
> > +               struct vduse_vq_group group;
> >         };
> >         __u8 ready;
> >  };
> > @@ -274,6 +286,7 @@ enum vduse_req_type {
> >         VDUSE_GET_VQ_STATE,
> >         VDUSE_SET_STATUS,
> >         VDUSE_UPDATE_IOTLB,
> > +       VDUSE_GET_VQ_GROUP,
> >  };
> >
> >  /**
> > @@ -328,6 +341,7 @@ struct vduse_dev_request {
> >                 struct vduse_vq_state vq_state;
> >                 struct vduse_dev_status s;
> >                 struct vduse_iova_range iova;
> > +               struct vduse_vq_group vq_group; /* Only if vduse api ve=
rsion >=3D 1 */
> >                 __u32 padding[32];
>
> This should be [31] otherwise we break the uAPI?
>
> >         };
> >  };
> > @@ -350,6 +364,7 @@ struct vduse_dev_response {
> >         __u32 reserved[4];
> >         union {
> >                 struct vduse_vq_state vq_state;
> > +               struct vduse_vq_group vq_group; /* Only if vduse api ve=
rsion >=3D 1 */
> >                 __u32 padding[32];
>
> And here?
>

Yes, thank you for both catches!

> Thanks
>
> >         };
> >  };
> > --
> > 2.49.0
> >
>

