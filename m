Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38232FF660
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142947; cv=none; b=OaNKR+4gIpRQwButXNTw2mG1tzwiByfgK+93n4jSodrZan8fdOK1VPMSqqYHh4ZJvUtVBOFVwgg7t+aW/ucJ1l6JcNPpBjwgK8uG2Ih+sjxIpcOUXa0b/Dwwu/P3z2dojijmSf5umAkd7fPD/zVpGuhnX4FSDIfQ8/8MOgYexQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142947; c=relaxed/simple;
	bh=GDOuQ8e7rvpZZLraol9f9m6nY0aGOhLFU9xUo6o3hB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Km+J9oi84bxlpzyS6aiJDarCkUnUpXv6AAi09g1JYWF5dxrVG63TXV5n2uuFoHbzfcxPbzgdbUr1h6hnAoh8CDFP2zy5Rw8ANP1lKa1x/tSt7sAz67ip8JalhHSYZtJiBuAYsmn9EmgYre5JJb0a1sDvJw5NidGK4MLm+lBoiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tx+/0imr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx+/0imr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755142944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w97hjv5i+uwmkU+KfwU9kkYWprz91mHI8ezeUK8Eabo=;
	b=Tx+/0imr1MeWgCNe4M7QFzD4jQ2rJ8Fr0bt+HdPZrWKwOcAsmhL3wwRJAg1gM4W7fGV4jO
	Dz3k+W85A3Qw5SO75jANwb7TWHI5WI3h09bQgtyyua5Y8FFwDJDVqaIYKqKplQGKJ9gXCY
	mIsvd6hb1fCaxoipb67xfnPz6D9XgV8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-KVZvlfR_MfCMF3dzyWTjvw-1; Wed, 13 Aug 2025 23:42:21 -0400
X-MC-Unique: KVZvlfR_MfCMF3dzyWTjvw-1
X-Mimecast-MFC-AGG-ID: KVZvlfR_MfCMF3dzyWTjvw_1755142940
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32326e6b1deso486979a91.3
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 20:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142940; x=1755747740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w97hjv5i+uwmkU+KfwU9kkYWprz91mHI8ezeUK8Eabo=;
        b=LoUb3B5AOnTNTSd9DxgfUshOA8CjuaGg2tZgg1fSqvrBvns6EwNG5soUU49TMNGL6K
         eGH35AVCS4JX35IazTXjS26yP76taga0zRO/gLXfXJLiHzf384kk5GfN4FHwPAoI3ALT
         JEA/Ap/47H4jfWf/ymdUSp37QrU9dmxYYREg9XYyJfnn7CILWpATod3vFuS9ABJjwHWP
         uTP68Yn1gLcoT0y/GG224wszW9ttKVJV8/NkmShXN8ymcpvZzuUARzG/z2ciRvIR2cB/
         kwHBeK6LexLDnXGqejAVXIu8Pc4TZgiii4Eu4C0Y+NYMRfl/kX93jqPaifK/d3s4W4bV
         IN2w==
X-Forwarded-Encrypted: i=1; AJvYcCV3SiEuIt1FI76OcoXQjw3WBbC2cgLXZUHWtF9Sqs2OWT5GsD1uOZSo6iASgTlyh3dQtzrrTiY5xkCtvIUtcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTC012beKB/BfBtbL6Y8zPIHvItKs/uwH5Ntj1RZL/kQWlz0Vw
	5QmcKvHLR2ru2d5uEsCXtdsN33h3GbWsg4H3wPO3jSB3t0FI4nInGICpWQ1d2H5rUb2frlSoQxa
	xxMWdz3nD7SmVHRQ79Dgl1vmx4chO+RwLDvPb6JnDoa/gfvhTSCNAf6I6SdydBYj5RC33z+jvJ6
	fJHnm3rKMmzbm8i43fNynbMlkyKrnBgN/T5dyqH0gDQ5g=
X-Gm-Gg: ASbGncuPQyJh1X0lCvWNP8YFKJ6rrTpFnf8vguIa933pM/FEFbNUlMajkY9DCx/Ab6G
	kjMPu/iUU5vkmt2a1x7pTT4Xjwxj4hozdN3aF0+KIw5seE1TWUhxk6D9fqpnCuW0oBc+WQQGlAJ
	5ASme9XJO9DoVq+bjhZ3NFwA==
X-Received: by 2002:a17:90b:390f:b0:31e:ff94:3fba with SMTP id 98e67ed59e1d1-32327b58070mr2569935a91.24.1755142940029;
        Wed, 13 Aug 2025 20:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSvA6j4t0b5QEgBDxuYCwcd5Oei9P0Low20mXXvsuHEvsnzUysQd5NWOj+uF+Cn9ZIvD6ke761fuj+QMqLtN0=
X-Received: by 2002:a17:90b:390f:b0:31e:ff94:3fba with SMTP id
 98e67ed59e1d1-32327b58070mr2569889a91.24.1755142939498; Wed, 13 Aug 2025
 20:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
 <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
 <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com>
 <CACGkMEuZq2NaS9icynhrgZtXQ26fDFFpFrP3bUwDXLCR6uN4qw@mail.gmail.com> <CAJaqyWfB-nxpdtv+HRPB=7oc-MmquZ=7-mDqdVi42Mwf28CX7A@mail.gmail.com>
In-Reply-To: <CAJaqyWfB-nxpdtv+HRPB=7oc-MmquZ=7-mDqdVi42Mwf28CX7A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 11:42:07 +0800
X-Gm-Features: Ac12FXy1uiD6tKU5aMf7QAGhLniCOlqEn8-Wqgzk-g3rBHK3mItWz4VQoUaEPmY
Message-ID: <CACGkMEuVngGjgPZXnajiPC+pcbt+dr6jqKRQr8OcX7HK1W3WNQ@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Le21b4fEEV7YFHaslZhdZRnDN0UeN8z8lrInmzZQz50_1755142940
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:12=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Aug 12, 2025 at 5:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Aug 11, 2025 at 5:52=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Mon, Aug 11, 2025 at 5:10=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma=
@redhat.com> wrote:
> > > > >
> > > > > This allows sepparate the different virtqueues in groups that sha=
res the
> > > > > same address space.  Asking the VDUSE device for the groups of th=
e vq at
> > > > > the beginning as they're needed for the DMA API.
> > > > >
> > > > > Allocating 3 vq groups as net is the device that need the most gr=
oups:
> > > > > * Dataplane (guest passthrough)
> > > > > * CVQ
> > > > > * Shadowed vrings.
> > > > >
> > > > > Future versions of the series can include dynamic allocation of t=
he
> > > > > groups array so VDUSE can declare more groups.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > v2:
> > > > > * Cache group information in kernel, as we need to provide the vq=
 map
> > > > >   tokens properly.
> > > > > * Add descs vq group to optimize SVQ forwarding and support indir=
ect
> > > > >   descriptors out of the box.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 71 ++++++++++++++++++++++++=
+++++-
> > > > >  include/uapi/linux/vduse.h         | 19 +++++++-
> > > > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index d858c4389cc1..d1f6d00a9c71 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -46,6 +46,11 @@
> > > > >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 10=
24)
> > > > >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> > > > >
> > > > > +/*
> > > > > + * Let's make it 3 for simplicity.
> > > > > + */
> > > > > +#define VDUSE_MAX_VQ_GROUPS 3
> > > >
> > > > I think we can release this to something like 64. Otherwise we migh=
t
> > > > bump the version again just to increase the limitation? Or having a
> > > > sysfs entry like bounce_size?
> > > >
> > >
> > > I think it should not be linked to the version, but it is true there
> > > is no way for VDUSE devices to check the maximum VQ groups / ASID tha=
t
> > > the kernel supports.
> > >
> > > To handle as bounce_size seems the best option, good point. I'll send
> > > a new version with that!
> > >
> > > > > +
> > > > >  #define IRQ_UNBOUND -1
> > > > >
> > > > >  struct vduse_virtqueue {
> > > > > @@ -58,6 +63,8 @@ struct vduse_virtqueue {
> > > > >         struct vdpa_vq_state state;
> > > > >         bool ready;
> > > > >         bool kicked;
> > > > > +       u32 vq_group;
> > > > > +       u32 vq_desc_group;
> > > > >         spinlock_t kick_lock;
> > > > >         spinlock_t irq_lock;
> > > > >         struct eventfd_ctx *kickfd;
> > > > > @@ -114,6 +121,7 @@ struct vduse_dev {
> > > > >         u8 status;
> > > > >         u32 vq_num;
> > > > >         u32 vq_align;
> > > > > +       u32 ngroups;
> > > > >         struct vduse_umem *umem;
> > > > >         struct mutex mem_lock;
> > > > >         unsigned int bounce_size;
> > > > > @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vd=
pa_device *vdpa, u16 idx,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > > > +{
> > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +
> > > > > +       return dev->vqs[idx]->vq_group;
> > > > > +}
> > > > > +
> > > > > +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16=
 idx)
> > > > > +{
> > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +
> > > > > +       return dev->vqs[idx]->vq_desc_group;
> > > > > +}
> > > > > +
> > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16=
 idx,
> > > > >                                 struct vdpa_vq_state *state)
> > > > >  {
> > > > > @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa=
_device *vdpa)
> > > > >         return dev->status;
> > > > >  }
> > > > >
> > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > +{
> > > > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > > > +               return 0;
> > > > > +
> > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > +               int ret;
> > > > > +
> > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > +               msg.req.vq_group.index =3D i;
> > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > >
> > > > I fail to understand why the default group mapping is not done duri=
ng
> > > > device creation.
> > > >
> > >
> > > Because it changes depending on the features.
> > >
> > > If a new device has 5 virtqueues and the device wants to isolate the
> > > CVQ, the CVQ position depends on the features that the guest's acks:
> > > * If MQ is acked the isolated vq is #5
> > > * If MQ is not acked the isolated vq is #3.
> >
> > I see we are still damaged by the design of the cvq index. But this is
> > just a static branch not a dynamic one. If we can find ways to make it
> > static it would be better.
> >
> > >
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +
> > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> > > > > +
> > > > > +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +
> > > > > +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.=
num;
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 s=
tatus)
> > > > >  {
> > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +       u8 previous_status =3D dev->status;
> > > > >
> > > > >         if (vduse_dev_set_status(dev, status))
> > > > >                 return;
> > > > >
> > > > > +       if ((dev->status ^ previous_status) &
> > > > > +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> > > > > +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > +               if (vduse_fill_vq_groups(dev))
> > > >
> > > > Can we merge the two messages into a single one? Or can we use a
> > > > shared memory for storing such mapping?
> > > >
> > > > For example, if we have 256 queues it would be very slow.
> > > >
> > >
> > > To merge it in the same message is good to me, sure.
> >
> > We can start from this if we can't find a way to provision vq to group
> > mapping during device creation.
> >
>
> Note that I don't think it is worth implementing these in this series,
> but to add them on top in another one. Because I don't think we will
> find devices with a lot of virtqueues for now. But here are some ideas
> to mitigate the startup time cost:
>
> 1) Support more than one virtqueue in the same vduse request / reply
> Something like:
> vduse_dev_response{
>   u32 req_id;
>   u32 result;
>   union {
>     ...
>     struct vduse_vq_group {
>       u32 num_vqs_requested;
>       struct {
>         u32 vq_idx;
>         u32 vq_group;
>       } vqs[15];
>     }
>     u32 padding[32];
>   }
> }
>
> Choosing 15 to fill the current size of vduse_dev_response struct.
>
> 2) Pointer chasing in the struct written
>
> Same as previous, but the vqs struct is actually a pointer in
> userspace. This way it can be arbitrarily big.
>
> vduse_dev_response{
>   u32 req_id;
>   u32 result;
>   union {
>     ...
>     struct vduse_vq_group {
>       u32 num_vqs_requested;
>       struct {
>         u32 vq_idx;
>         u32 vq_group;
>       } *vqs;
>     }
>     u32 padding[32];
>   }
> }
>
> I cannot locate any use of this in write() data, but it is more or
> less common in ioctl.
>
> 3) Allow VQ_GROUP_BATCH_BEGIN and _END, similar to how memory map
> works in vhost_vdpa. As many vq_group response as needed in between.
>
> +) Assume that any vq not mentioned in the reply is vq group 0.

Or make VDUSE io_uring compatible.  (Anyhow it looks like another topic).

I'm fine if Michael and others are fine with starting with merging the
message. It's worth trying to reduce the userspace/kernel interaction
as much as possible.

Thanks

>
>
> > > To make it a
> > > table in shm seems more complicated, unless we accept a void * in the
> > > reply and VDUSE uses copy_from_user. If that is ok here, then sure.
> > >
> >
> > This looks tricky indeed.
> >
> > Thanks
> >
>

