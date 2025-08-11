Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC351E9915
	for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905925; cv=none; b=rTfFpZb68f919ZpQ0kGnBqn54RDTV3Ay7GnJp7stmgpjRmOQo9TBTGNa4BweVqoCbXuU5+SvGwDKcw0zYvse+Z0POBS1HHj1hr2Aubug++z6Kv08cxrheSfeD/WRWjW1PBx01JBKBfiDEGEy+fqrrhkxbUIPmReb6Mh4257OcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905925; c=relaxed/simple;
	bh=axX42gfmuRTzHHY8Rggs7YfjK8wvRrx7qKsMCogre7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCuFH+mHW07uW2lynLabf6bXmz9le5+YuTRlqsVOwrOKrxgs+r+nQeJQoRJoziq5tnSyN1WbPmtNwM7r3DK6ChOEMbN8JD2ZwZwbHBLD6L3YU2tSMOAXC6n3s0mKlmJaYMKBTDCgUuEqdryUmr/qxvf/UBNFpZATS925YM2vwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bK3wHAPU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK3wHAPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754905922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=razzMAqxuDRq/lWoy/+ZlGcAwpJZlfJPFJRW2KQpfjg=;
	b=bK3wHAPUaKFi0/tObPMGhBIqfpsy3Xowl5OesmlQ1osNdYlw4HhfghNzXOvF8Zur05Tncd
	BxRhuEzzpRUZ8A5Gcjr+uQ4wgrnsAVXyiChNYumhv6onmyKX0fLPs3RwOw5w5TXbKsixXp
	h3IoUpFnNkM6aVR+/LzUEULW5u2wIuI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-YWpeJDuFO3i9uN6SvGGJqw-1; Mon, 11 Aug 2025 05:52:01 -0400
X-MC-Unique: YWpeJDuFO3i9uN6SvGGJqw-1
X-Mimecast-MFC-AGG-ID: YWpeJDuFO3i9uN6SvGGJqw_1754905920
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3217aae3f90so3785540a91.0
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 02:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905920; x=1755510720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=razzMAqxuDRq/lWoy/+ZlGcAwpJZlfJPFJRW2KQpfjg=;
        b=MCIEmI32NbNatpI2D5pOShCudQmACGbn0rKy87oc9r93+bjycysmUtUNlDV0kO9KYu
         KQGiKNDWDwvHvYXtQgjKgmifQK2YZKjH7d/06A+j0gQe4AmGxtjNWzS8HeqQZHBNOQj2
         fHLTttCYJX4RZzeo3Ah+rUSxrt9xcESgFQuTGAGhLfUN9ls8UTxbfAe+w4IrgT0GQ/c8
         rTL67cNDNj8UPNpIuNz940Jp9iRZ/wjQWAxjvQk8Mh2jTp0WbnzkSmXSs1POG9oxprh1
         x8V7ZlYgN9T/s1uzK0McT0zxSDScXdi2773wt1ERKngQQJiLy7JJv2l7zhNQ9USkPxcv
         y5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbVa5QZVMCJkq2/WMTE6izkofPxtZGa2gWpZ/Kcx01Odf6G77WddW9xgWhSnglkyvWPo8GIHUpN1plDpFXGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE5+L4feVzJ+6PSqvxeXtDcHEZD52IuRqVT6NEgtRakleeSmaQ
	d9IZw7OWdAPa4jeZYVqcrXPdXN8Sk7CJZPm2IclG0sZVxXvBwjlpRN5mfgGISx6wHbtVuM411r0
	mXlyILykawoq/RdkxPBDeagkUR8O4nEk6f/xYzTVdJ8m8aShT9rpK/JAfUxrtgmnx3rp3VeqFnu
	cRWHz3b04a82Dl1utDpWMxUApCuLbEb4N13zHWC6qW+4c=
X-Gm-Gg: ASbGncuj39ADElDu5QGfPxFKqQ8ob0ISg7MP9kvbOcpQFpLfq6Amiiov7kwIdqYFOep
	uIc1RGF8NRLOXpwGni+tAcq0S9akjezFBsJ+MiVoU9OWTa3jiJrNq2SEwfYGC6bFAM0oZDFz5w8
	zyqvXx/gWxemUCsbLLeQiU
X-Received: by 2002:a17:90b:3e4b:b0:316:3972:b9d0 with SMTP id 98e67ed59e1d1-321838a7672mr19437886a91.0.1754905920382;
        Mon, 11 Aug 2025 02:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB/yM/8ypLq6xwy/TruMnl9ahp7f+nmV8xLhik2xEvyabJQhr8Z7KY0fGCQQSaiIhFrrAYRZVophIJxdQK/oA=
X-Received: by 2002:a17:90b:3e4b:b0:316:3972:b9d0 with SMTP id
 98e67ed59e1d1-321838a7672mr19437865a91.0.1754905919952; Mon, 11 Aug 2025
 02:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
 <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
In-Reply-To: <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Aug 2025 11:51:23 +0200
X-Gm-Features: Ac12FXwrY-EVjwroQmqKFrxwtn9Y_wEqtBPW6dBCT8tOtZhcmkI7hEVjO2_jb50
Message-ID: <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QPd8-kmrUxcSYyOAqocLJraJtiQKD_n1LgZEJGykX_M_1754905920
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:10=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
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
> > * Cache group information in kernel, as we need to provide the vq map
> >   tokens properly.
> > * Add descs vq group to optimize SVQ forwarding and support indirect
> >   descriptors out of the box.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 71 +++++++++++++++++++++++++++++-
> >  include/uapi/linux/vduse.h         | 19 +++++++-
> >  2 files changed, 88 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index d858c4389cc1..d1f6d00a9c71 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -46,6 +46,11 @@
> >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
> >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> >
> > +/*
> > + * Let's make it 3 for simplicity.
> > + */
> > +#define VDUSE_MAX_VQ_GROUPS 3
>
> I think we can release this to something like 64. Otherwise we might
> bump the version again just to increase the limitation? Or having a
> sysfs entry like bounce_size?
>

I think it should not be linked to the version, but it is true there
is no way for VDUSE devices to check the maximum VQ groups / ASID that
the kernel supports.

To handle as bounce_size seems the best option, good point. I'll send
a new version with that!

> > +
> >  #define IRQ_UNBOUND -1
> >
> >  struct vduse_virtqueue {
> > @@ -58,6 +63,8 @@ struct vduse_virtqueue {
> >         struct vdpa_vq_state state;
> >         bool ready;
> >         bool kicked;
> > +       u32 vq_group;
> > +       u32 vq_desc_group;
> >         spinlock_t kick_lock;
> >         spinlock_t irq_lock;
> >         struct eventfd_ctx *kickfd;
> > @@ -114,6 +121,7 @@ struct vduse_dev {
> >         u8 status;
> >         u32 vq_num;
> >         u32 vq_align;
> > +       u32 ngroups;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> > @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
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
> > +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +       return dev->vqs[idx]->vq_desc_group;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_devic=
e *vdpa)
> >         return dev->status;
> >  }
> >
> > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > +{
> > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > +               return 0;
> > +
> > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > +               struct vduse_dev_msg msg =3D { 0 };
> > +               int ret;
> > +
> > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > +               msg.req.vq_group.index =3D i;
> > +               ret =3D vduse_dev_msg_sync(dev, &msg);
>
> I fail to understand why the default group mapping is not done during
> device creation.
>

Because it changes depending on the features.

If a new device has 5 virtqueues and the device wants to isolate the
CVQ, the CVQ position depends on the features that the guest's acks:
* If MQ is acked the isolated vq is #5
* If MQ is not acked the isolated vq is #3.

> > +               if (ret)
> > +                       return ret;
> > +
> > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> > +
> > +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.num;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> >  {
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +       u8 previous_status =3D dev->status;
> >
> >         if (vduse_dev_set_status(dev, status))
> >                 return;
> >
> > +       if ((dev->status ^ previous_status) &
> > +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> > +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> > +               if (vduse_fill_vq_groups(dev))
>
> Can we merge the two messages into a single one? Or can we use a
> shared memory for storing such mapping?
>
> For example, if we have 256 queues it would be very slow.
>

To merge it in the same message is good to me, sure. To make it a
table in shm seems more complicated, unless we accept a void * in the
reply and VDUSE uses copy_from_user. If that is ok here, then sure.

