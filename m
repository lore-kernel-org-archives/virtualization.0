Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09D19D8A8
	for <virtualization@lists.linux.dev>; Mon,  8 Sep 2025 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297574; cv=none; b=eSlBsulOFcoWc8/ahzAcuEsFyH1cFOb08FHjMLcbSD4zt40BnrildLWgoeVURb/WScZ7jdh5ds0AvMvIwTzw18vaHbNvT5/IFxfn268HNZfXWbSyR1/yN1vGRtW3iW91xTRCTgtEWbxzjEyaA4hDno4S3atjySzJa2h/FqeIdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297574; c=relaxed/simple;
	bh=rH5V0FEWA/4OTC2w3xtP2uEnhbXBnOIqXqYpBxQzC80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIhIra/qMLRgknlQmARy9F1NdegxK2yPTqr4SOlaDJ0giU2fs01PJz3CYO4ktYMIDTmjIOZ7+HbYrm01gEybK2VWfk1dKvn0mcwEnBf5cXcRgAxb+ktdZYFgVqFYyNaQgnkLU1osEo963kpkaWSVaeuM/rAz+jMmJZEIJ6EnuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aF1k8Uxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF1k8Uxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757297570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWpPh0mHESgML0G8Lfix+KcLD7sLsvv/p81owY9SAiI=;
	b=aF1k8UxmjYq/9zM49x1eUB2UuzNRQWC4PndHkrZa5SZ9gHeHNHCdps7j4ACgaE1gALdVaI
	4zkxssKWN30FqKNlA0F23zBjPSApNJQmf4Q/LRMQh2wbizk/4i7oZ8jQMCwpex5Y3Lv8Rv
	u6JipEQTyLUdNY8NPNk3pZvD3DgWbWg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-VjF0Zqn_OgG_EVVnW8ke4w-1; Sun, 07 Sep 2025 22:12:48 -0400
X-MC-Unique: VjF0Zqn_OgG_EVVnW8ke4w-1
X-Mimecast-MFC-AGG-ID: VjF0Zqn_OgG_EVVnW8ke4w_1757297568
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24b2b347073so51992725ad.1
        for <virtualization@lists.linux.dev>; Sun, 07 Sep 2025 19:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297567; x=1757902367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWpPh0mHESgML0G8Lfix+KcLD7sLsvv/p81owY9SAiI=;
        b=FdEVAILOufRpcKBaPpCNFEFH+a0ekrx7nEZCkzK0uFss6che72tf2T/m3q3iKWBkd7
         2YFpamU8lbGGu3rJv5mn75z6V3+g4gvHTIZq4PtvcvONm8x7M9VaaTF+DoDIRFY2Bv1a
         XAjwF8A1bcGKLpcl56Jmw1jxjKz/9+rHAl48GHA1nnCR53XR11S36H4DP1iexBYxFzTz
         vFFhhJZwZ3sbaNuejl3h5MTMnMjt3ukexqbjkfzuSDFp8/XLcbhYYhwlBXP7mDNlMsad
         M20WO5zBfBUJwfCWLCQ0uQPdxsO6DujoAUDP6YIEWombEnn4Gs6dyUPs0PhOUF6UIMMT
         fxKg==
X-Forwarded-Encrypted: i=1; AJvYcCXAa8uQS0bQuY97SnVmvJ4ftu8udzqbIVRELrpR2JP9sPIJRSJDOHwxgFlEx0aYmSrOAFLi5hpM68SlwqgwDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeATfMNnhX0o6uTNDwP3SM3cYPqzkjDslTjIWTtvbmISxcTgo/
	LL/sC8rjuuda1h2Ef4sVmgxfCJU8qv0n+qQbERF8ZOC+IPDwPUKciNONmJPN9m86zb+ZmTeTYxo
	+AydyjVQYPt0+CLxvXx7Pqo7yr0m5zS68wYCoOBJlbAUnhv33gwHxieWsVe8B0AHkIj1uILwUio
	LGalFDC0TfXvgpAsFI9KpqrZu+M8xPgKXzn2LP9sv+XFQ=
X-Gm-Gg: ASbGncuooLyCRwoHFmb//z0kgODt9GKmMzvwTDM8a7sDnQ3YrdVI9FAZvdDx7BqsTqL
	GxBJmAbmya9CWmKHIgBi7sr9vg2ShkqFSdbiUrC3kismef5EVtmG8/QlnVMToDPfPBPn44sNCRX
	NZHnmkzx2DHEaIqHdoOD6j
X-Received: by 2002:a17:90b:2684:b0:32b:6223:259 with SMTP id 98e67ed59e1d1-32d43eff89amr7569647a91.13.1757297567526;
        Sun, 07 Sep 2025 19:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSsiHEivkn+VQ6VUepAa6sQD7ojw5EVHfUx0SY58PVFB/0bDm63pxJKrggybbW9h3yTFhYqCxMsJKv6UAgIhE=
X-Received: by 2002:a17:90b:2684:b0:32b:6223:259 with SMTP id
 98e67ed59e1d1-32d43eff89amr7569617a91.13.1757297566988; Sun, 07 Sep 2025
 19:12:46 -0700 (PDT)
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
 <CACGkMEudOzDUzVr8i8PbeJ2q81vzBtEVDZKu=67R5y+p_9j8Bw@mail.gmail.com>
 <CACGkMEuPTzY1WD-yJri3q7pmx0D3DCNOD=iLJ2rpzx12K9370A@mail.gmail.com> <CAJaqyWcQwkpRZdKJBSHhtfLXfL5gb2_z8j-OsqSy3pPa+ZvYxw@mail.gmail.com>
In-Reply-To: <CAJaqyWcQwkpRZdKJBSHhtfLXfL5gb2_z8j-OsqSy3pPa+ZvYxw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Sep 2025 10:12:35 +0800
X-Gm-Features: Ac12FXwWAIz3NJeQs1U3UclbDxwZ7ptExqduje8uhFztt_0bqAoCJ9Ey3D8bTZ0
Message-ID: <CACGkMEsX+D2_12xGDxusO3+BR2bqqXodHHjLy_4TJCpm96jRTA@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cjtNfNuZwzrwYfxay1mKSlNDgPpZjHEa9KlHjQ33H8M_1757297568
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:47=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Thu, Sep 4, 2025 at 5:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Sep 4, 2025 at 11:08=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 6:31=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Wed, Sep 3, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <=
eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9re=
z <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This allows sepparate the different virtqueues in group=
s that shares the
> > > > > > > > > > same address space.  Asking the VDUSE device for the gr=
oups of the vq at
> > > > > > > > > > the beginning as they're needed for the DMA API.
> > > > > > > > > >
> > > > > > > > > > Allocating 3 vq groups as net is the device that need t=
he most groups:
> > > > > > > > > > * Dataplane (guest passthrough)
> > > > > > > > > > * CVQ
> > > > > > > > > > * Shadowed vrings.
> > > > > > > > > >
> > > > > > > > > > Future versions of the series can include dynamic alloc=
ation of the
> > > > > > > > > > groups array so VDUSE can declare more groups.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already =
the bit (Maxime)
> > > > > > > > > >
> > > > > > > > > > RFC v3:
> > > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It wa=
s set to a lower
> > > > > > > > > >   value to reduce memory consumption, but vqs are alrea=
dy limited to
> > > > > > > > > >   that value and userspace VDUSE is able to allocate th=
at many vqs.
> > > > > > > > > > * Remove the descs vq group capability as it will not b=
e used and we can
> > > > > > > > > >   add it on top.
> > > > > > > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > > > > > > * Move the valid vq groups range check to vduse_validat=
e_config.
> > > > > > > > > >
> > > > > > > > > > RFC v2:
> > > > > > > > > > * Cache group information in kernel, as we need to prov=
ide the vq map
> > > > > > > > > >   tokens properly.
> > > > > > > > > > * Add descs vq group to optimize SVQ forwarding and sup=
port indirect
> > > > > > > > > >   descriptors out of the box.
> > > > > > > > > > ---
> > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++=
++++++++++++++--
> > > > > > > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > > > > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drive=
rs/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > > > > > > >         struct vdpa_vq_state state;
> > > > > > > > > >         bool ready;
> > > > > > > > > >         bool kicked;
> > > > > > > > > > +       u32 vq_group;
> > > > > > > > > >         spinlock_t kick_lock;
> > > > > > > > > >         spinlock_t irq_lock;
> > > > > > > > > >         struct eventfd_ctx *kickfd;
> > > > > > > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > > > > > > >         u8 status;
> > > > > > > > > >         u32 vq_num;
> > > > > > > > > >         u32 vq_align;
> > > > > > > > > > +       u32 ngroups;
> > > > > > > > > >         struct vduse_umem *umem;
> > > > > > > > > >         struct mutex mem_lock;
> > > > > > > > > >         unsigned int bounce_size;
> > > > > > > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state=
(struct vdpa_device *vdpa, u16 idx,
> > > > > > > > > >         return 0;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa=
, u16 idx)
> > > > > > > > > > +{
> > > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > > +
> > > > > > > > > > +       return dev->vqs[idx]->vq_group;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device =
*vdpa, u16 idx,
> > > > > > > > > >                                 struct vdpa_vq_state *s=
tate)
> > > > > > > > > >  {
> > > > > > > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(st=
ruct vdpa_device *vdpa)
> > > > > > > > > >         return dev->status;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > > > > > > +{
> > > > > > > > > > +       /* All vqs and descs must be in vq group 0 if n=
groups < 2 */
> > > > > > > > > > +       if (dev->ngroups < 2)
> > > > > > > > > > +               return 0;
> > > > > > > > > > +
> > > > > > > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i=
) {
> > > > > > > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > +               int ret;
> > > > > > > > > > +
> > > > > > > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > > > > > > +               msg.req.vq_group.index =3D i;
> > > > > > > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > +               if (ret)
> > > > > > > > > > +                       return ret;
> > > > > > > > > > +
> > > > > > > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_g=
roup.group;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static void vduse_vdpa_set_status(struct vdpa_device *=
vdpa, u8 status)
> > > > > > > > > >  {
> > > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(=
struct vdpa_device *vdpa, u8 status)
> > > > > > > > > >         if (vduse_dev_set_status(dev, status))
> > > > > > > > > >                 return;
> > > > > > > > > >
> > > > > > > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_F=
EATURES_OK) &&
> > > > > > > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > > > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > > > > > > +                       return;
> > > > > > > > >
> > > > > > > > > I may lose some context but I think we've agreed that we =
need to
> > > > > > > > > extend the status response for this instead of having mul=
tiple
> > > > > > > > > indepdent response.
> > > > > > > > >
> > > > > > > >
> > > > > > > > My understanding was it is ok to start with this version by=
 [1]. We
> > > > > > > > can even make it asynchronous on top if we find this is a b=
ottleneck
> > > > > > > > and the VDUSE device would need no change, would that work?
> > > > > > >
> > > > > > > I think I need to understand why we can not defer this to get=
_group_asid() call.
> > > > > > >
> > > > > >
> > > > > > Because we need to know the vq_groups->asid mapping in other ca=
lls
> > > > > > like set_group_asid or get_vq_group.
> > > > >
> > > > > I think we don't need the mapping of those, or anything I miss?
> > > > >
> > > >
> > > > If the kernel module does not ask the userland device for the actua=
l
> > > > vq group of a virtqueue, what should it return in vduse_get_vq_grou=
p?
> > > > 0 for all vqs, even if the CVQ is in vq group 1?
> > >
> > > Since the topology is fixed I think userspace should provide this whe=
n
> > > creating a device.
> > >
>
> The topology is not fixed: The CVQ may be either the vq #2 or the last
> one depending if mq has been negotiated or not.
>
> So it cannot be provided at device creation, but only after feature negot=
iation.

You are correct. This has been discussed before.

Thanks

