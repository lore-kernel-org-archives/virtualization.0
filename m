Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81D212541
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079956; cv=none; b=Bk3rpQHlHokQIIN89N5gazvoZuepuu1E29giv6naBZfxhtPgFmBtJJBjIxGTb2yU2UKtYZ7kCWvIyhve7pvxL4varcN6jPrluRokJCxFP/oapcnOYslJ6thXE+Ybp85wfeV+ZrRuypu5meGxShQeOqSJwBDGkWrC+UlyPsRwRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079956; c=relaxed/simple;
	bh=DSepXi7+wgxrvRLcEEpk7COlGGzMzmwUYw+2mA16qJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1cW/NLDbHG0h49/ymh+hnRpGv/NudRMoNppRsO8HTn3EfAURhjGSUl3Cfx7EkrKkB21hVTy2pTjvgFSA2ll1nwHee+MhuHQfg3K3HQbSFye7ymA+qG47RToHuMCIa55B+kDnhV8yyP7EPQPu9n6lKI4R457EQUVdfObpoI4Xu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hz9ccC1B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hz9ccC1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755079953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHixBqtVWa3TXGCBa7l2LROeCBnEtW1Ef55PxSt8KWM=;
	b=hz9ccC1BseSmTWrFyn8Ups/wrcpZBK0+8EOfEREzRwMx6nglV4WmK97P534+AfKThnJxIJ
	1TmPoVGV4LdTY1kDskapctypuGxT9YfCPBliqx7iw+ZkCrS+Znb/vEDqWLZls1CD6Fx2Yy
	IiB/8pPjoLD5Iukw978YQRTA4JWJiSk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-dyQOwDDYOdShxQ7mknlOjg-1; Wed, 13 Aug 2025 06:12:30 -0400
X-MC-Unique: dyQOwDDYOdShxQ7mknlOjg-1
X-Mimecast-MFC-AGG-ID: dyQOwDDYOdShxQ7mknlOjg_1755079949
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-243013cd91bso15521365ad.0
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 03:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079949; x=1755684749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHixBqtVWa3TXGCBa7l2LROeCBnEtW1Ef55PxSt8KWM=;
        b=vmewcXansgqzU6IQ997cJJLr30g84BeowwkwiSL31OhTp8EI9yB9uxGOJTwTECYuYa
         k1na9Gye/FfUeDihQUBMSh+5kggvwQUOs5irBOVzrqlJhjy0twNwjlU6AQgnACctXQ4j
         JVG87XFgpFg915I7wclVBm2Cl66UiQ8VkdklPkQUS7Ycg3rtuSGYyelNwtLDXmTRZ3P1
         eJVypslIr7SuliMKgXo34YNNq7Ni1E67s5/P1X4CBfKwh0IJjyMHFAHRAtqETwNoSg8S
         J/m5dx1xYtxeWHbXGi2pDTSrhvndnsfHob94teI001jJ404Sg7P8zE9lp46ZR8QrSpN6
         ftjg==
X-Forwarded-Encrypted: i=1; AJvYcCWX3C2XkwsIXVnqErJPSOuzpfLiBoY7J4KuTaRN7RFaPldc3/FjX0QhZYoISwTnfu+c0ZkunA5TAQutJI8AOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBcZj9k8YrWxHab85avnM/f4LVTVHdcWbG3Lm6tfWWYzcudzyb
	snhAUzxIT7n/tAcZ+njCd7oCvySKByvokhuAH22p1oQFP9Ci4puHMcMuz4qGaCkh8dHoP18cji1
	koHulZXLXvLPCy9PB+HIjiQMpWNuU6jr6Uep8vEg3aexGoJXzdOm8zh65zTNSPAXVMJYVn5ceAO
	O+7SxpvcfGkZ8zEK/g+d/mrNdXRo/8TpabmYUavC8peis=
X-Gm-Gg: ASbGncug2DBUTwAHgavxRDj9KNf1/pX6HBcwwhTeH6HNKmXaqE9KoJWagBltLoZ04zF
	OwPeyxofMVqsRaWH/rh0+QnwWSoiqzYF5l62EM4ClhLMzE8jPocwg+irUU/Bf3J5UFIOzhft0aq
	HrqcMjz7eAfhQns6uui7N1U+vEO1eHMC403XhLYEX8Z/IkuvJ033fJRUY=
X-Received: by 2002:a17:903:22c3:b0:240:763d:e999 with SMTP id d9443c01a7336-2430d2240fbmr35242755ad.29.1755079948992;
        Wed, 13 Aug 2025 03:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKzaQylKARSlIDWyBCSLUNt17OsJJBw0HSyy1Q001ndr62TtyS4PIe+aETqHAl+HIv9I9mY6Cg7F2MRsnofy4=
X-Received: by 2002:a17:903:22c3:b0:240:763d:e999 with SMTP id
 d9443c01a7336-2430d2240fbmr35242435ad.29.1755079948503; Wed, 13 Aug 2025
 03:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
 <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
 <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com> <CACGkMEuZq2NaS9icynhrgZtXQ26fDFFpFrP3bUwDXLCR6uN4qw@mail.gmail.com>
In-Reply-To: <CACGkMEuZq2NaS9icynhrgZtXQ26fDFFpFrP3bUwDXLCR6uN4qw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 12:11:52 +0200
X-Gm-Features: Ac12FXycNx9KHVG8siXjBVSykHaY3kyogXA38fKEKaMS0Ey8sg-AajQbZJtJYh8
Message-ID: <CAJaqyWfB-nxpdtv+HRPB=7oc-MmquZ=7-mDqdVi42Mwf28CX7A@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CCsjBMSwkhlSaA3fZ6FLMA1J9FDhGHReFgYV_ZVYC44_1755079949
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 5:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Aug 11, 2025 at 5:52=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 5:10=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
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
> > > > * Cache group information in kernel, as we need to provide the vq m=
ap
> > > >   tokens properly.
> > > > * Add descs vq group to optimize SVQ forwarding and support indirec=
t
> > > >   descriptors out of the box.
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 71 ++++++++++++++++++++++++++=
+++-
> > > >  include/uapi/linux/vduse.h         | 19 +++++++-
> > > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index d858c4389cc1..d1f6d00a9c71 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -46,6 +46,11 @@
> > > >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024=
)
> > > >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> > > >
> > > > +/*
> > > > + * Let's make it 3 for simplicity.
> > > > + */
> > > > +#define VDUSE_MAX_VQ_GROUPS 3
> > >
> > > I think we can release this to something like 64. Otherwise we might
> > > bump the version again just to increase the limitation? Or having a
> > > sysfs entry like bounce_size?
> > >
> >
> > I think it should not be linked to the version, but it is true there
> > is no way for VDUSE devices to check the maximum VQ groups / ASID that
> > the kernel supports.
> >
> > To handle as bounce_size seems the best option, good point. I'll send
> > a new version with that!
> >
> > > > +
> > > >  #define IRQ_UNBOUND -1
> > > >
> > > >  struct vduse_virtqueue {
> > > > @@ -58,6 +63,8 @@ struct vduse_virtqueue {
> > > >         struct vdpa_vq_state state;
> > > >         bool ready;
> > > >         bool kicked;
> > > > +       u32 vq_group;
> > > > +       u32 vq_desc_group;
> > > >         spinlock_t kick_lock;
> > > >         spinlock_t irq_lock;
> > > >         struct eventfd_ctx *kickfd;
> > > > @@ -114,6 +121,7 @@ struct vduse_dev {
> > > >         u8 status;
> > > >         u32 vq_num;
> > > >         u32 vq_align;
> > > > +       u32 ngroups;
> > > >         struct vduse_umem *umem;
> > > >         struct mutex mem_lock;
> > > >         unsigned int bounce_size;
> > > > @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa=
_device *vdpa, u16 idx,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +
> > > > +       return dev->vqs[idx]->vq_group;
> > > > +}
> > > > +
> > > > +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 i=
dx)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +
> > > > +       return dev->vqs[idx]->vq_desc_group;
> > > > +}
> > > > +
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_d=
evice *vdpa)
> > > >         return dev->status;
> > > >  }
> > > >
> > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > +{
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > > +               return 0;
> > > > +
> > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > +               int ret;
> > > > +
> > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > +               msg.req.vq_group.index =3D i;
> > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > >
> > > I fail to understand why the default group mapping is not done during
> > > device creation.
> > >
> >
> > Because it changes depending on the features.
> >
> > If a new device has 5 virtqueues and the device wants to isolate the
> > CVQ, the CVQ position depends on the features that the guest's acks:
> > * If MQ is acked the isolated vq is #5
> > * If MQ is not acked the isolated vq is #3.
>
> I see we are still damaged by the design of the cvq index. But this is
> just a static branch not a dynamic one. If we can find ways to make it
> static it would be better.
>
> >
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +
> > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> > > > +
> > > > +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +
> > > > +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.nu=
m;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 sta=
tus)
> > > >  {
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +       u8 previous_status =3D dev->status;
> > > >
> > > >         if (vduse_dev_set_status(dev, status))
> > > >                 return;
> > > >
> > > > +       if ((dev->status ^ previous_status) &
> > > > +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> > > > +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> > > > +               if (vduse_fill_vq_groups(dev))
> > >
> > > Can we merge the two messages into a single one? Or can we use a
> > > shared memory for storing such mapping?
> > >
> > > For example, if we have 256 queues it would be very slow.
> > >
> >
> > To merge it in the same message is good to me, sure.
>
> We can start from this if we can't find a way to provision vq to group
> mapping during device creation.
>

Note that I don't think it is worth implementing these in this series,
but to add them on top in another one. Because I don't think we will
find devices with a lot of virtqueues for now. But here are some ideas
to mitigate the startup time cost:

1) Support more than one virtqueue in the same vduse request / reply
Something like:
vduse_dev_response{
  u32 req_id;
  u32 result;
  union {
    ...
    struct vduse_vq_group {
      u32 num_vqs_requested;
      struct {
        u32 vq_idx;
        u32 vq_group;
      } vqs[15];
    }
    u32 padding[32];
  }
}

Choosing 15 to fill the current size of vduse_dev_response struct.

2) Pointer chasing in the struct written

Same as previous, but the vqs struct is actually a pointer in
userspace. This way it can be arbitrarily big.

vduse_dev_response{
  u32 req_id;
  u32 result;
  union {
    ...
    struct vduse_vq_group {
      u32 num_vqs_requested;
      struct {
        u32 vq_idx;
        u32 vq_group;
      } *vqs;
    }
    u32 padding[32];
  }
}

I cannot locate any use of this in write() data, but it is more or
less common in ioctl.

3) Allow VQ_GROUP_BATCH_BEGIN and _END, similar to how memory map
works in vhost_vdpa. As many vq_group response as needed in between.

+) Assume that any vq not mentioned in the reply is vq group 0.


> > To make it a
> > table in shm seems more complicated, unless we accept a void * in the
> > reply and VDUSE uses copy_from_user. If that is ok here, then sure.
> >
>
> This looks tricky indeed.
>
> Thanks
>

