Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E327FB27
	for <virtualization@lists.linux.dev>; Fri,  5 Sep 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062070; cv=none; b=LNHrKEk/wWYStzS2pnwHISlb3kragq0+jeCcD26xjCdbTGAzK6arFLygHzaiKFGO2/et/UaVP0S9bN4gZdYA9tKJhps16Xru4zjl7T1/4lCO4cgUbEdH6Vzwjm8JZGKX7ZaNUv6eod6piBeen9KuB9JTF+r6TQCsi3v8UNg2SBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062070; c=relaxed/simple;
	bh=/74Z3X+uD87EcMsB6yk8ZXYmFiHeoQO6IR7FqqFeIKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRGduki5sxLtT3/9RTsGiaReQfZivWkYhI9M/lOa0AbD/iwj17A58ou5TaS581gb5tbIOXzuP/XikK4qpmQaFm2fc0pmUJBSRsOoRnQxIifrX+e1MSg3IpLJ42jM7pjJoQl4ktw21VtiDuk9Q8Qm3OdrcnR/S0+V6O07i15NnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnEV4C2I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnEV4C2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757062065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JN32umJtcpXVPeX5VacSIko68Vpte1UknXqFDZxt9dY=;
	b=hnEV4C2IHLifotTKH5FVZZ1V9gThkwKQm4pCX8+/Tpc000u+INVMpU9y+Fe5e98tjyNSqf
	VcRI4CmDDSEv2a9gY9VcNldmCPKwPn7iIlzO4kLii3TXE9oawuwZ8ckJ+A9KsDyU8HwnAL
	+86LvSgEbM6gXTr6VBKOGxrfObclGvY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-YG0utKXaPXuP2azDFtswYQ-1; Fri, 05 Sep 2025 04:47:42 -0400
X-MC-Unique: YG0utKXaPXuP2azDFtswYQ-1
X-Mimecast-MFC-AGG-ID: YG0utKXaPXuP2azDFtswYQ_1757062062
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso1915933a91.0
        for <virtualization@lists.linux.dev>; Fri, 05 Sep 2025 01:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062061; x=1757666861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN32umJtcpXVPeX5VacSIko68Vpte1UknXqFDZxt9dY=;
        b=JAB3NSD1iU3AgWOv/g6SyAvoRRUpMMP9VnrwfkGAtLS/wdVW0A/oDTjtuRqoDu9424
         +v8VJGbHvUgJXEiDMB2AMhKdzzexXi0djt+wtyq/sw3+G8aaIm0DG3rCEtATI9UoqVfX
         chpBZsvqtSD1zpppYDtDvgzNCSKGoxxVSxYT3Sn1JJabsBqHFnndXgnVtM2wFvcjlKO5
         wXuj1m7CLgh7z5XvwWWSAgVjoZUcDXq7/IT8Mwz4RhO2xTFhY+Sp6fuLe9EHbZYsNRfo
         DIKEcAwfLEaqlElHNPpCC1ItKzrLogRFhb5BdEmfZpOaT9fEv+u7GqYH3zGZFr9jeLoB
         2dDw==
X-Forwarded-Encrypted: i=1; AJvYcCW5fIBoRaLMMtI5PbMrj88pl0w0T5c6vdzXPVwQV+mnjGhzHYW9H993BXQ+4r5sHRvGqziDsMalVuY4Gjxpew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx85mBUp9RH2gGBQ8LWdqeBoKyFJPFJ685lwhJxZM+ELQcUVyu4
	7utMYfbmLAJiori5pXqic2BhBUanaLYDAWO6BcrZPwKmaqfQiBsn8Tg477TTUUz3P95Ud+e/3zh
	RdsVqv2HuXhVo6jSjPBHmdQ7wrPwJwbZV3Klab9d7h8Z/1w9WtKYPoYwAIB/B+Mmcr9Rv6+7siU
	F/L7Iz9vq0KWc92NJSCPvRUhmlzIo22CxhEHQf+pruniE=
X-Gm-Gg: ASbGncvtb2L5+23NaqwpixEBRxZ5yi3KUFJZyeBccarPO/0o6gYenR0wRyOvOHuBwB+
	651Ti1yseYWjqrRiQp9Rwwuv5POBopu+gRAsnSLsLUVol19a6Y7WITdovBaO+VPKWSod9oYqD/P
	xz3J21v6df8FeZK1LBAVlhS4V+o3i0WKCWPaqc53eDNTjcbO2Poui5H4y4245+fE3LqKfoM1Rb4
	zG+dsYRXA==
X-Received: by 2002:a17:90b:1c07:b0:327:be5f:8014 with SMTP id 98e67ed59e1d1-328156e36b4mr25414054a91.34.1757062061422;
        Fri, 05 Sep 2025 01:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6aJbcJq9tiNYjG67nXqIHQ1wbtbtO3VggZPeVvnvVDR/gz01fzjSq7ziByOvVvnVxqf3O402m1L3hap9pNW0=
X-Received: by 2002:a17:90b:1c07:b0:327:be5f:8014 with SMTP id
 98e67ed59e1d1-328156e36b4mr25414034a91.34.1757062060940; Fri, 05 Sep 2025
 01:47:40 -0700 (PDT)
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
 <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com>
 <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com>
 <CACGkMEudOzDUzVr8i8PbeJ2q81vzBtEVDZKu=67R5y+p_9j8Bw@mail.gmail.com> <CACGkMEuPTzY1WD-yJri3q7pmx0D3DCNOD=iLJ2rpzx12K9370A@mail.gmail.com>
In-Reply-To: <CACGkMEuPTzY1WD-yJri3q7pmx0D3DCNOD=iLJ2rpzx12K9370A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Sep 2025 10:47:04 +0200
X-Gm-Features: Ac12FXwJo7hdeYjG_Cf-_TIhUxAoxK650HLtuWRJk35-dbiYua0PIBlzad4l8k8
Message-ID: <CAJaqyWcQwkpRZdKJBSHhtfLXfL5gb2_z8j-OsqSy3pPa+ZvYxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cxge8KTNp6iIlyoip233rcM1VMKxEgQVhQD3KJ6UHJc_1757062062
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Sep 4, 2025 at 11:08=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Sep 3, 2025 at 6:31=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <ep=
erezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez =
<eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > This allows sepparate the different virtqueues in groups =
that shares the
> > > > > > > > > same address space.  Asking the VDUSE device for the grou=
ps of the vq at
> > > > > > > > > the beginning as they're needed for the DMA API.
> > > > > > > > >
> > > > > > > > > Allocating 3 vq groups as net is the device that need the=
 most groups:
> > > > > > > > > * Dataplane (guest passthrough)
> > > > > > > > > * CVQ
> > > > > > > > > * Shadowed vrings.
> > > > > > > > >
> > > > > > > > > Future versions of the series can include dynamic allocat=
ion of the
> > > > > > > > > groups array so VDUSE can declare more groups.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > ---
> > > > > > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already th=
e bit (Maxime)
> > > > > > > > >
> > > > > > > > > RFC v3:
> > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was =
set to a lower
> > > > > > > > >   value to reduce memory consumption, but vqs are already=
 limited to
> > > > > > > > >   that value and userspace VDUSE is able to allocate that=
 many vqs.
> > > > > > > > > * Remove the descs vq group capability as it will not be =
used and we can
> > > > > > > > >   add it on top.
> > > > > > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > > > > > * Move the valid vq groups range check to vduse_validate_=
config.
> > > > > > > > >
> > > > > > > > > RFC v2:
> > > > > > > > > * Cache group information in kernel, as we need to provid=
e the vq map
> > > > > > > > >   tokens properly.
> > > > > > > > > * Add descs vq group to optimize SVQ forwarding and suppo=
rt indirect
> > > > > > > > >   descriptors out of the box.
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++=
++++++++++++--
> > > > > > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > > > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers=
/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > > > > > >         struct vdpa_vq_state state;
> > > > > > > > >         bool ready;
> > > > > > > > >         bool kicked;
> > > > > > > > > +       u32 vq_group;
> > > > > > > > >         spinlock_t kick_lock;
> > > > > > > > >         spinlock_t irq_lock;
> > > > > > > > >         struct eventfd_ctx *kickfd;
> > > > > > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > > > > > >         u8 status;
> > > > > > > > >         u32 vq_num;
> > > > > > > > >         u32 vq_align;
> > > > > > > > > +       u32 ngroups;
> > > > > > > > >         struct vduse_umem *umem;
> > > > > > > > >         struct mutex mem_lock;
> > > > > > > > >         unsigned int bounce_size;
> > > > > > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(s=
truct vdpa_device *vdpa, u16 idx,
> > > > > > > > >         return 0;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, =
u16 idx)
> > > > > > > > > +{
> > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > +
> > > > > > > > > +       return dev->vqs[idx]->vq_group;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *v=
dpa, u16 idx,
> > > > > > > > >                                 struct vdpa_vq_state *sta=
te)
> > > > > > > > >  {
> > > > > > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(stru=
ct vdpa_device *vdpa)
> > > > > > > > >         return dev->status;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > > > > > +{
> > > > > > > > > +       /* All vqs and descs must be in vq group 0 if ngr=
oups < 2 */
> > > > > > > > > +       if (dev->ngroups < 2)
> > > > > > > > > +               return 0;
> > > > > > > > > +
> > > > > > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) =
{
> > > > > > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > +               int ret;
> > > > > > > > > +
> > > > > > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > > > > > +               msg.req.vq_group.index =3D i;
> > > > > > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > +               if (ret)
> > > > > > > > > +                       return ret;
> > > > > > > > > +
> > > > > > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_gro=
up.group;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vd=
pa, u8 status)
> > > > > > > > >  {
> > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(st=
ruct vdpa_device *vdpa, u8 status)
> > > > > > > > >         if (vduse_dev_set_status(dev, status))
> > > > > > > > >                 return;
> > > > > > > > >
> > > > > > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEA=
TURES_OK) &&
> > > > > > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > > > > > +                       return;
> > > > > > > >
> > > > > > > > I may lose some context but I think we've agreed that we ne=
ed to
> > > > > > > > extend the status response for this instead of having multi=
ple
> > > > > > > > indepdent response.
> > > > > > > >
> > > > > > >
> > > > > > > My understanding was it is ok to start with this version by [=
1]. We
> > > > > > > can even make it asynchronous on top if we find this is a bot=
tleneck
> > > > > > > and the VDUSE device would need no change, would that work?
> > > > > >
> > > > > > I think I need to understand why we can not defer this to get_g=
roup_asid() call.
> > > > > >
> > > > >
> > > > > Because we need to know the vq_groups->asid mapping in other call=
s
> > > > > like set_group_asid or get_vq_group.
> > > >
> > > > I think we don't need the mapping of those, or anything I miss?
> > > >
> > >
> > > If the kernel module does not ask the userland device for the actual
> > > vq group of a virtqueue, what should it return in vduse_get_vq_group?
> > > 0 for all vqs, even if the CVQ is in vq group 1?
> >
> > Since the topology is fixed I think userspace should provide this when
> > creating a device.
> >

The topology is not fixed: The CVQ may be either the vq #2 or the last
one depending if mq has been negotiated or not.

So it cannot be provided at device creation, but only after feature negotia=
tion.

> > >
> > > That's also valid for vduse_get_vq_map, which return is assumed not t=
o
> > > change in all the life of the device as it is not protected by a
> > > mutex.
> > >
> > > > And the vq to group mappings could be piggy backed by the device
> > > > creation request.
> > > >
> > >
> > > I'm not sure, I think it involves a vduse request per asid or vq grou=
p
> > > operation. Even get_vq_map. But I'm open to explore this possibility
> > > for sure.
> >
> > Something like this?
> >
> > struct vduse_vq_config {
> >         __u32 index;
> >         __u16 max_size;
> >         __u16 reserved[13];
> > };
>
> I meant this actually:
>
> struct vduse_vq_config {
>          __u32 index;
>          __u16 max_size;
>          __u16 group;
>          __u16 reserved[12];
>  };
>

This is very interesting, the device should call VDUSE_VQ_SETUP in the
middle processing the VDUSE_SET_STATUS message, checking for
FEATURES_OK. Ok let's move to that, thanks!

