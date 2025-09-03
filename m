Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F01CEAC2
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895467; cv=none; b=pRNk2YN3Lmf5VEX88EsKjYBZ5djqg8P0pKCRbWRS7xBVWWpxrcjJf8oZixMEKf4cBCDkDPu0vuTxNzHUa+sZqTjQMXTeEBwgJYC3cS6IlVYv6eyrsMhjarGlU6vx3rWxH9x5qd7CuGZ9XdlwqCEFdOEwpdTbuUKyzx7qcZuZr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895467; c=relaxed/simple;
	bh=IsuuiCOQW6pAhmbbZCIZ+Wm7t2WtLltTUDeVFIkXfYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tg1sH1shBDCX9M87gpYRyzSAPkQ++vlazmeMupe9ZSoAnTLsTcnf3Mnr38fQgONtDHDWAPcifn9X1tLA70nzM1NFApPgu47PnuGA6bxilsW5Iq5sbPFo8CBH1weyeI5NUeIrWvjX/a92+l9tD+I/4VGkjKCVgv94LSUS+KeNyzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlUQRrZX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlUQRrZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756895462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qOsf15T960mtb9sS5UAjuBpUtscmR9jTiZsmS/xmDw=;
	b=AlUQRrZXB+5CEzPm0Zc8eaWN2wc4oZxUUl7iP7dzKofdxGcUqVWVn7WyEnWUmHbmM+s4cl
	6GTJ0aaMyC6BC6360xf9AOgV5bRR6KuMnYk/YLX1g9RN+8Ax1y+uVMsvi9Fte+BkYtQLld
	MQ6FYqJxVYyi66dawG7KGavsbU8mDjk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-jEqMcJAHPw2ikzFWhswCnQ-1; Wed, 03 Sep 2025 06:31:01 -0400
X-MC-Unique: jEqMcJAHPw2ikzFWhswCnQ-1
X-Mimecast-MFC-AGG-ID: jEqMcJAHPw2ikzFWhswCnQ_1756895460
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329ee88fb47so2153645a91.2
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 03:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895460; x=1757500260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qOsf15T960mtb9sS5UAjuBpUtscmR9jTiZsmS/xmDw=;
        b=xRF57Qj/6VlrFXTRGpzzVUk3CNjLbkji9yGPGyKa9qvkpDMd4dos3v1OHbxqUQabXw
         COY9VdQ5Oqq2Mu9Kq4a/As6tMrA4Xq40Glv2EeaCiuSY1/R4GjOHc00Kgm6qNUbRN8Lf
         fqjVcbPFLph2mgOAVttKWH4+A/DU7Pfd4j6QNnT4VfZjjxAcj9unPT9bdkq/Dyf5EN1Z
         exNE4/n0/K61kTgOxAody3matXi3FPl50E1P1+sX368gXJ2All7o7TXTwKQlwu15JJAq
         /ogNqE4JkG9oWXEHs2MCvHZO8/WY0CKVMf4HU2Zn5Jlfme1H3CjQytL75vpny4DHVeIX
         pTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEn50ILCpMwlMYaQ0J58HWw3RIYwa1+qF1b83ugxYDF8FkS5FtWgoIldH2MUa+pT7cPIFxIgRg5ZRLY0ZCgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJh4NIj2ooggf7f3sALUuR/KEa4NljH05avcUE06ewuvGWAvl+
	1K2gayshcI0OKsYcCDE0krJlwIU6r28+IC1fqSqTmXGaK5VWirmg86VIVhC7BhH4IYWM/7oG50A
	fG6S99GqxYYcMy+aaXNjn20o2M+QtnyT9mGh+aLDJcZpIjdPZ/mFj6tpxeTwYLWTw20YZsTSCuj
	QwCz8bNWphypWMCBmPYQTDfcEG7rXtjaONsW+GXAPDjng=
X-Gm-Gg: ASbGncsBSKLz1DvQuzXNxDe+1EDdasmu1PJt6sAQ6SGqXHJLnPGBnC3cElVX4/lsEs1
	dhZgvmcJ3iMmbc9J1vSMSTvbySEygRjU4BjPBUeIuhBCtgh8NbIhDGQq3uVByEsqmjeeFmHmiEZ
	tNC2q8h3jod4MEbvU7KJn3lg==
X-Received: by 2002:a17:90b:4d06:b0:327:dc81:b39e with SMTP id 98e67ed59e1d1-32815452f34mr16840645a91.13.1756895459902;
        Wed, 03 Sep 2025 03:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENP9nmb5WCwP8PtA5pBQnIUN1yc0WNZA+WYg3GqoWssXzlUN9eByNc1YtWgslytrfrBNmIaV4iioNjmPdJcgY=
X-Received: by 2002:a17:90b:4d06:b0:327:dc81:b39e with SMTP id
 98e67ed59e1d1-32815452f34mr16840617a91.13.1756895459516; Wed, 03 Sep 2025
 03:30:59 -0700 (PDT)
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
 <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com> <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com>
In-Reply-To: <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Sep 2025 12:30:22 +0200
X-Gm-Features: Ac12FXyu0knImzGvvLa58v0X2WkieIda6A4AeG8uSRmXTSAwzO7KVryCu8N8Hb8
Message-ID: <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CCjsc5ojhAn5-zLHr2a20uK9jC7VOMbN0oTEEm7qu3Q_1756895460
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <epere=
zma@redhat.com> wrote:
> > > > > >
> > > > > > This allows sepparate the different virtqueues in groups that s=
hares the
> > > > > > same address space.  Asking the VDUSE device for the groups of =
the vq at
> > > > > > the beginning as they're needed for the DMA API.
> > > > > >
> > > > > > Allocating 3 vq groups as net is the device that need the most =
groups:
> > > > > > * Dataplane (guest passthrough)
> > > > > > * CVQ
> > > > > > * Shadowed vrings.
> > > > > >
> > > > > > Future versions of the series can include dynamic allocation of=
 the
> > > > > > groups array so VDUSE can declare more groups.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > ---
> > > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit =
(Maxime)
> > > > > >
> > > > > > RFC v3:
> > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to=
 a lower
> > > > > >   value to reduce memory consumption, but vqs are already limit=
ed to
> > > > > >   that value and userspace VDUSE is able to allocate that many =
vqs.
> > > > > > * Remove the descs vq group capability as it will not be used a=
nd we can
> > > > > >   add it on top.
> > > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > > * Move the valid vq groups range check to vduse_validate_config=
.
> > > > > >
> > > > > > RFC v2:
> > > > > > * Cache group information in kernel, as we need to provide the =
vq map
> > > > > >   tokens properly.
> > > > > > * Add descs vq group to optimize SVQ forwarding and support ind=
irect
> > > > > >   descriptors out of the box.
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++=
++++++--
> > > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > > >         struct vdpa_vq_state state;
> > > > > >         bool ready;
> > > > > >         bool kicked;
> > > > > > +       u32 vq_group;
> > > > > >         spinlock_t kick_lock;
> > > > > >         spinlock_t irq_lock;
> > > > > >         struct eventfd_ctx *kickfd;
> > > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > > >         u8 status;
> > > > > >         u32 vq_num;
> > > > > >         u32 vq_align;
> > > > > > +       u32 ngroups;
> > > > > >         struct vduse_umem *umem;
> > > > > >         struct mutex mem_lock;
> > > > > >         unsigned int bounce_size;
> > > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct =
vdpa_device *vdpa, u16 idx,
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 id=
x)
> > > > > > +{
> > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > +
> > > > > > +       return dev->vqs[idx]->vq_group;
> > > > > > +}
> > > > > > +
> > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u=
16 idx,
> > > > > >                                 struct vdpa_vq_state *state)
> > > > > >  {
> > > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdp=
a_device *vdpa)
> > > > > >         return dev->status;
> > > > > >  }
> > > > > >
> > > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > > +{
> > > > > > +       /* All vqs and descs must be in vq group 0 if ngroups <=
 2 */
> > > > > > +       if (dev->ngroups < 2)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > > +               int ret;
> > > > > > +
> > > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > > +               msg.req.vq_group.index =3D i;
> > > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > +               if (ret)
> > > > > > +                       return ret;
> > > > > > +
> > > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.gro=
up;
> > > > > > +       }
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8=
 status)
> > > > > >  {
> > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct v=
dpa_device *vdpa, u8 status)
> > > > > >         if (vduse_dev_set_status(dev, status))
> > > > > >                 return;
> > > > > >
> > > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_=
OK) &&
> > > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > > +                       return;
> > > > >
> > > > > I may lose some context but I think we've agreed that we need to
> > > > > extend the status response for this instead of having multiple
> > > > > indepdent response.
> > > > >
> > > >
> > > > My understanding was it is ok to start with this version by [1]. We
> > > > can even make it asynchronous on top if we find this is a bottlenec=
k
> > > > and the VDUSE device would need no change, would that work?
> > >
> > > I think I need to understand why we can not defer this to get_group_a=
sid() call.
> > >
> >
> > Because we need to know the vq_groups->asid mapping in other calls
> > like set_group_asid or get_vq_group.
>
> I think we don't need the mapping of those, or anything I miss?
>

If the kernel module does not ask the userland device for the actual
vq group of a virtqueue, what should it return in vduse_get_vq_group?
0 for all vqs, even if the CVQ is in vq group 1?

That's also valid for vduse_get_vq_map, which return is assumed not to
change in all the life of the device as it is not protected by a
mutex.

> And the vq to group mappings could be piggy backed by the device
> creation request.
>

I'm not sure, I think it involves a vduse request per asid or vq group
operation. Even get_vq_map. But I'm open to explore this possibility
for sure.

> >
> > We could add a boolean on each virtqueue to track if we know its
> > virtqueue group and then only ask VDUSE device it if needed, would
> > that work?
>
> Thanks
>
> >
>

