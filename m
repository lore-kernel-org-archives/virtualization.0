Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6882DE71A
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885249; cv=none; b=YbCVmNyvwGmqVE4DNujgdJnluUOdri5shNLsxO+hupORgHYyFGg0R5mA1nVwpFlr35u94mGuW/q1OvIAUHp93rUYgbJWMBBqip0uSrejviOLnfYkHwwYGHNItXZdbsMraYESTwOJjKwEK0G2zyr3RzMU9z+FsSDA5NGkolHu7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885249; c=relaxed/simple;
	bh=6VPWOdFBF6rRqKIzINPp+yDsrQQv5D2JFUneeYieV70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS7pPLFpbegfuxlvmwBVBaLa5AGvhmUlLYtn6V8UXRr3JvV13Bx9/M/cLxNed75L+ulofJJ93EmQXP/kywfriwscd7NI1ND3thx6eMht2U8PotuR52igElGpnrJUsbpFu+OTu5LbtG1U0aPs5AwGcJMwVzS+dKdiox1oJ5/89GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcHKANtT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcHKANtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756885246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4LAt2WRO8kSFLIa32uL4kKJ+Zm5Jrcb4Q/28wUR1i4=;
	b=DcHKANtTcavfSeoh64gRROmbUdru6hl81RzI83cT5p/PogVy4Kzrd85Xipv7vab8ixXtf5
	yuspysXGnRVuJjVgyW2sj3/UhmCBBlBjbjo8KbCDogamvtyQcFwJpb9+VzrzEwGMYLZidK
	HluICEMeBfnNHeQ7VLVpBabhROC+HtE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-rXiJ6xoQPGW69kZ-SxbV2A-1; Wed, 03 Sep 2025 03:40:43 -0400
X-MC-Unique: rXiJ6xoQPGW69kZ-SxbV2A-1
X-Mimecast-MFC-AGG-ID: rXiJ6xoQPGW69kZ-SxbV2A_1756885242
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso881501a91.1
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 00:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885242; x=1757490042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4LAt2WRO8kSFLIa32uL4kKJ+Zm5Jrcb4Q/28wUR1i4=;
        b=kZjoQ0fRXRONvZwvxjJRtaa1Pek1gB2mQWMN1FkwDBDzF+Jl/I3ImYHhNb8SDgx8G3
         hPcOHydZYMFRt7w026rAsq96zTKHyZQkQiDO4RzI0Xz59y+2Ru1UyZ3Mr4eF7GcslN3Q
         VeA5BmsrlHPcAFn7PJtz1FfUBQe8Rp2L2CxLltreigeMwAfwtgXY0PBM9YpNGX9U6S6u
         j70ChISQnyAfJ678SmL98hnhKygkbLNjtCDVNAYHD61vLJ7smpDz3zTTJUAW78T7nz0e
         mj4y1X9JwpdXzNjOIvWBTp8idmkfzoiDlEiCALLapKqdvugEIZb3gGlKgry0zhdYs34s
         LdSA==
X-Forwarded-Encrypted: i=1; AJvYcCUrKb6xaEFxpV6fcgjRTdZ13bB4u57T41s/yO9ybkS64WI4kmeXLkrc1wFY81BHFUk6XNB5ngCwCUtcS6IMgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJvBB/Luqc8oBjw580BoxXC/clmssv2eHtr0/Vxp/PbRMxTkeW
	Xbq2sE5NMJCjwWBHzrt2MjfNgXbJSyxanlmfuI4UGcAPQe/TxneWiBobFDG5rGM6yPNaeueKxl/
	4T797mjWLy7CYDNYWiYwsTBMGIEEFqhre4HjOiK02tP9MVLDNQ1A8lBr5joVq6JREO764lZUdN4
	pfYcCdLbPWtI1GtYrDDhgqsY8wHOQJuDbDkgTfqYIw0Z4=
X-Gm-Gg: ASbGncsHi0/l12cF2TIQ2LwPp9CtFaYRNmBXKM691tVLcesyXRY3xIT/h8dcJwzqUzM
	C83K8+yWW+xcE938O5Ye4/C1GTdjeHJMoDvVKFEVaG2lm9bjhazHpUK7WG/Wwr7SACy85bT1NrM
	4mhFfJd68+7AwzNMgqBMZCow==
X-Received: by 2002:a17:90b:1c06:b0:327:faa6:b5b7 with SMTP id 98e67ed59e1d1-328156e2eb4mr17484193a91.17.1756885241990;
        Wed, 03 Sep 2025 00:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2D+tunKE0kpnVXWblaZ0xPi9LkHXkvVFVTag9Z+KZnqiABGP1w0GL6Mdoi2l6ZEfY6XJhCwxHfR4+efLG43g=
X-Received: by 2002:a17:90b:1c06:b0:327:faa6:b5b7 with SMTP id
 98e67ed59e1d1-328156e2eb4mr17484153a91.17.1756885241337; Wed, 03 Sep 2025
 00:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
 <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
 <CACGkMEsUjfPadVi8Qr8L723mbQ_21WG7e07mDd79KDHFNn_AFw@mail.gmail.com> <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com>
In-Reply-To: <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 15:40:29 +0800
X-Gm-Features: Ac12FXzSvObKwGD-XIPbp-CGM5DYKP6-tGxp6Rb7tpvG20l0mngZhofZPSSayKM
Message-ID: <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jm4-u3gMfjmMAZPMl_Cd-fA3O71X-yZivtl9Li2tAFU_1756885242
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
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
> > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (M=
axime)
> > > > >
> > > > > RFC v3:
> > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a=
 lower
> > > > >   value to reduce memory consumption, but vqs are already limited=
 to
> > > > >   that value and userspace VDUSE is able to allocate that many vq=
s.
> > > > > * Remove the descs vq group capability as it will not be used and=
 we can
> > > > >   add it on top.
> > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > * Move the valid vq groups range check to vduse_validate_config.
> > > > >
> > > > > RFC v2:
> > > > > * Cache group information in kernel, as we need to provide the vq=
 map
> > > > >   tokens properly.
> > > > > * Add descs vq group to optimize SVQ forwarding and support indir=
ect
> > > > >   descriptors out of the box.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++=
++++--
> > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > >         struct vdpa_vq_state state;
> > > > >         bool ready;
> > > > >         bool kicked;
> > > > > +       u32 vq_group;
> > > > >         spinlock_t kick_lock;
> > > > >         spinlock_t irq_lock;
> > > > >         struct eventfd_ctx *kickfd;
> > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > >         u8 status;
> > > > >         u32 vq_num;
> > > > >         u32 vq_align;
> > > > > +       u32 ngroups;
> > > > >         struct vduse_umem *umem;
> > > > >         struct mutex mem_lock;
> > > > >         unsigned int bounce_size;
> > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vd=
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
> > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16=
 idx,
> > > > >                                 struct vdpa_vq_state *state)
> > > > >  {
> > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_=
device *vdpa)
> > > > >         return dev->status;
> > > > >  }
> > > > >
> > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > +{
> > > > > +       /* All vqs and descs must be in vq group 0 if ngroups < 2=
 */
> > > > > +       if (dev->ngroups < 2)
> > > > > +               return 0;
> > > > > +
> > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > +               int ret;
> > > > > +
> > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > +               msg.req.vq_group.index =3D i;
> > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +
> > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.group=
;
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 s=
tatus)
> > > > >  {
> > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdp=
a_device *vdpa, u8 status)
> > > > >         if (vduse_dev_set_status(dev, status))
> > > > >                 return;
> > > > >
> > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK=
) &&
> > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > +                       return;
> > > >
> > > > I may lose some context but I think we've agreed that we need to
> > > > extend the status response for this instead of having multiple
> > > > indepdent response.
> > > >
> > >
> > > My understanding was it is ok to start with this version by [1]. We
> > > can even make it asynchronous on top if we find this is a bottleneck
> > > and the VDUSE device would need no change, would that work?
> >
> > I think I need to understand why we can not defer this to get_group_asi=
d() call.
> >
>
> Because we need to know the vq_groups->asid mapping in other calls
> like set_group_asid or get_vq_group.

I think we don't need the mapping of those, or anything I miss?

And the vq to group mappings could be piggy backed by the device
creation request.

>
> We could add a boolean on each virtqueue to track if we know its
> virtqueue group and then only ask VDUSE device it if needed, would
> that work?

Thanks

>

