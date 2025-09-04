Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20BB1E520D
	for <virtualization@lists.linux.dev>; Thu,  4 Sep 2025 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955839; cv=none; b=Oj434YcAY/DMSaVtYheL2Dwm68GF8jI5cT7SPSY1gfdlO6mN08/WcvlVyiteZjL0AD4BB6Z68U28Go8S/2N9Zw/VSOacqJHpSglrRXLXJuFhGVbtkImKhaNZWYX/JoUWd0O/2cTOvVRHtcCZ3FwWytc+OsrZvlcbNrv2ncq6rlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955839; c=relaxed/simple;
	bh=TZhWSoFjQY5w2WWSbxQVGFziVgRuSlXr4SLtpPc7hIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbZ53QGRunDRjO+eS4hbotUQMH+K7GnNqxp54TB0csTzYTymfUL/HbnWiFoU0ZrtDOqALNojXBX8gZ3Z/+3YQOWsZANsIjv4UFCO4/UiBSOCB7mkLRcx6IPDTypHKDc3HIoJZrohMwoTbiBZhmcA8BP6C1wCdz73GPr8bdXySP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqGK6y29; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqGK6y29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756955832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCiDn5H04rkZjFCYtNUdEvadwxb+GPvXtkL8Ot360us=;
	b=eqGK6y29cjybQsEBc7yGn9QxDa8wLroMWXkk8Omj22vZkCt+q8M0zazbgShsldhOdykt6I
	NSzK0HqXumDYKZS1VFeL5qi/XmjrUuAyuG/6rPk2uQpId74EkFxf14LHs/9sbWLt24JWwu
	CRqHJq3wWXVEFt1rC7lZXfao8US4rPQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-CcB--qWRMC2K1-Rh87X0PA-1; Wed, 03 Sep 2025 23:17:05 -0400
X-MC-Unique: CcB--qWRMC2K1-Rh87X0PA-1
X-Mimecast-MFC-AGG-ID: CcB--qWRMC2K1-Rh87X0PA_1756955825
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4d3ab49a66so656557a12.3
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 20:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756955824; x=1757560624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCiDn5H04rkZjFCYtNUdEvadwxb+GPvXtkL8Ot360us=;
        b=k/YEafdyG257me2uNfbTuCCMQA7VRlR2XyZKijDZcxLFFQlrb1eNXszYydiYU/kBlL
         LTn6S04xIAyC3/gJzpgCmE48vP1idRLnX2EKbz9L0o/+TGivCGwGrKniyNHN+pMME6zy
         Nou1tAP7+4g4YSeGGaXScKE6/8c8cnnDDa1ALBByALyESp+TqgB4Egzl0aq5ZYtWgeDe
         f/mqMIOUrNmdPvoIe6jJzFFajnx1TJy/uhKFbikv2r8aoSczbck+S0AadVdoxQDCpxZ/
         byApCV1RQrccP6cpVJpB9/wGRaU74PJiH4nBBD59qOlhOTZhRU+4/y0AkDLfbApXIuSi
         BCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJx4bz+0ho5Q/XWW+Od9yMZYeAFTVYtwZnRt2G69ejMiEBrmBPzuGWbqWaxu2Pq2bqNjmhyqpjckAZEhiIwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxePjTzL+l0EYoZRAivjzmsTVTqXoGr6Gw+Z1iZ6f2JO/TD1Ef3
	omgzQkfXi2oxuxOel5Re1ZjQSD4bDw4pda+qiIUQX+Gifj4Fh5XU0QJ8DN2uUAxHKXx+n8Vwjhb
	QLlcZWPuZejqBOjH3dQA768hKY6yM+G08LOpQkpJJToVqqoL9OTV/SsFYE5vtv122p27vhRTdQP
	OJgN0plDXvChSG10KU5JfX2o8RRefLAlvSvNAneD4S0bI=
X-Gm-Gg: ASbGncs0fZxon1Mm9A/SLwKICUOCDKtKl16cKg18OEX2HiWW/rM3nPCUrLcQcNqLw/5
	CYQ8IgOh3+lBJzGHXbH4K1Bf6uCBb81dIN4uaXb9j42V3HhO2CtBoGEvl79S71UKFlSlr0n6yK1
	ZLVTaZ1yjkFj5YTsVPFJQ=
X-Received: by 2002:a17:90a:d2c8:b0:31f:11d6:cea0 with SMTP id 98e67ed59e1d1-328156de009mr22638039a91.27.1756955329910;
        Wed, 03 Sep 2025 20:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhtUhnk2gyKH6P1Jrm7ejAxw8eDAf7V9I9M9HYnNF7GQqVJDL2YIWt2o/utv2qYF1Sj5kxTQGZLIaBtlkLp/I=
X-Received: by 2002:a17:90a:d2c8:b0:31f:11d6:cea0 with SMTP id
 98e67ed59e1d1-328156de009mr22637997a91.27.1756955328664; Wed, 03 Sep 2025
 20:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
 <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
 <CACGkMEsUjfPadVi8Qr8L723mbQ_21WG7e07mDd79KDHFNn_AFw@mail.gmail.com>
 <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com>
 <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com> <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Sep 2025 11:08:37 +0800
X-Gm-Features: Ac12FXw8ic7ZwoLUEnZNWeifQxpZmliXNdhzIdygh1SO4VzbUs1hcqr5FGbeVik
Message-ID: <CACGkMEudOzDUzVr8i8PbeJ2q81vzBtEVDZKu=67R5y+p_9j8Bw@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J9fJxeWbzFOf-oouvyaw8zwNTDpUNnXSCbGUkEq2TDI_1756955825
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 6:31=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, Sep 3, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > This allows sepparate the different virtqueues in groups that=
 shares the
> > > > > > > same address space.  Asking the VDUSE device for the groups o=
f the vq at
> > > > > > > the beginning as they're needed for the DMA API.
> > > > > > >
> > > > > > > Allocating 3 vq groups as net is the device that need the mos=
t groups:
> > > > > > > * Dataplane (guest passthrough)
> > > > > > > * CVQ
> > > > > > > * Shadowed vrings.
> > > > > > >
> > > > > > > Future versions of the series can include dynamic allocation =
of the
> > > > > > > groups array so VDUSE can declare more groups.
> > > > > > >
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bi=
t (Maxime)
> > > > > > >
> > > > > > > RFC v3:
> > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set =
to a lower
> > > > > > >   value to reduce memory consumption, but vqs are already lim=
ited to
> > > > > > >   that value and userspace VDUSE is able to allocate that man=
y vqs.
> > > > > > > * Remove the descs vq group capability as it will not be used=
 and we can
> > > > > > >   add it on top.
> > > > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > > > * Move the valid vq groups range check to vduse_validate_conf=
ig.
> > > > > > >
> > > > > > > RFC v2:
> > > > > > > * Cache group information in kernel, as we need to provide th=
e vq map
> > > > > > >   tokens properly.
> > > > > > > * Add descs vq group to optimize SVQ forwarding and support i=
ndirect
> > > > > > >   descriptors out of the box.
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++=
++++++++--
> > > > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > > > >         struct vdpa_vq_state state;
> > > > > > >         bool ready;
> > > > > > >         bool kicked;
> > > > > > > +       u32 vq_group;
> > > > > > >         spinlock_t kick_lock;
> > > > > > >         spinlock_t irq_lock;
> > > > > > >         struct eventfd_ctx *kickfd;
> > > > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > > > >         u8 status;
> > > > > > >         u32 vq_num;
> > > > > > >         u32 vq_align;
> > > > > > > +       u32 ngroups;
> > > > > > >         struct vduse_umem *umem;
> > > > > > >         struct mutex mem_lock;
> > > > > > >         unsigned int bounce_size;
> > > > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struc=
t vdpa_device *vdpa, u16 idx,
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 =
idx)
> > > > > > > +{
> > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > +
> > > > > > > +       return dev->vqs[idx]->vq_group;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa,=
 u16 idx,
> > > > > > >                                 struct vdpa_vq_state *state)
> > > > > > >  {
> > > > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct v=
dpa_device *vdpa)
> > > > > > >         return dev->status;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > > > +{
> > > > > > > +       /* All vqs and descs must be in vq group 0 if ngroups=
 < 2 */
> > > > > > > +       if (dev->ngroups < 2)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > > > +               int ret;
> > > > > > > +
> > > > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > > > +               msg.req.vq_group.index =3D i;
> > > > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > +               if (ret)
> > > > > > > +                       return ret;
> > > > > > > +
> > > > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.g=
roup;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, =
u8 status)
> > > > > > >  {
> > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct=
 vdpa_device *vdpa, u8 status)
> > > > > > >         if (vduse_dev_set_status(dev, status))
> > > > > > >                 return;
> > > > > > >
> > > > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURE=
S_OK) &&
> > > > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > > > +                       return;
> > > > > >
> > > > > > I may lose some context but I think we've agreed that we need t=
o
> > > > > > extend the status response for this instead of having multiple
> > > > > > indepdent response.
> > > > > >
> > > > >
> > > > > My understanding was it is ok to start with this version by [1]. =
We
> > > > > can even make it asynchronous on top if we find this is a bottlen=
eck
> > > > > and the VDUSE device would need no change, would that work?
> > > >
> > > > I think I need to understand why we can not defer this to get_group=
_asid() call.
> > > >
> > >
> > > Because we need to know the vq_groups->asid mapping in other calls
> > > like set_group_asid or get_vq_group.
> >
> > I think we don't need the mapping of those, or anything I miss?
> >
>
> If the kernel module does not ask the userland device for the actual
> vq group of a virtqueue, what should it return in vduse_get_vq_group?
> 0 for all vqs, even if the CVQ is in vq group 1?

Since the topology is fixed I think userspace should provide this when
creating a device.

>
> That's also valid for vduse_get_vq_map, which return is assumed not to
> change in all the life of the device as it is not protected by a
> mutex.
>
> > And the vq to group mappings could be piggy backed by the device
> > creation request.
> >
>
> I'm not sure, I think it involves a vduse request per asid or vq group
> operation. Even get_vq_map. But I'm open to explore this possibility
> for sure.

Something like this?

struct vduse_vq_config {
        __u32 index;
        __u16 max_size;
        __u16 reserved[13];
};

?

Thanks

>
> > >
> > > We could add a boolean on each virtqueue to track if we know its
> > > virtqueue group and then only ask VDUSE device it if needed, would
> > > that work?
> >
> > Thanks
> >
> > >
> >
>

