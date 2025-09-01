Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAA2FB979
	for <virtualization@lists.linux.dev>; Mon,  1 Sep 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716014; cv=none; b=nn49Ffo02EIhjWofs05Ftevb15vBbm9X0YYTgNHCz9SeMggrUXym/zw/KthT5BzTjv0FGBAebqowJk/AMfbjvyL/Fd/UKAB6BvVyy30q4JYxE+tSaxLpKSWY5QWPi7H+x3o4Wa6pBp7HxAxxSYIZuW8W1pbOZTx/13yglSOPbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716014; c=relaxed/simple;
	bh=4X2CWvlgPVWfzsbQhy30kVFfDZLIXvsWlgAUwcB9Ypg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jc3zoM/A6sJD/PA5m6WbeT5J1pgYoMpQnXYgI7d54T5YDjt3ol6Q0ILFtMwq6UuA1+ho+CYvL+wtBW2R6hXHGlL81k4gN5N8VBYcpM6e48w03zJmlqAQOJlrhLFUFi1o55RaJvzUY7Fk7PgFO0GE3dioA5tr3r69brMzW5AD1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsYVzY8D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsYVzY8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756716011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+Es+FtmQYR5HXyYZrrZ0z0Shosir2um9BQMSS4egjA=;
	b=XsYVzY8Dv5y72Pa8/iliFYTWuKNc4TsnAgm7Bn/dt8e9iTH5HNOrV6x/HDqrV1jNmhNpf2
	MWJ1Hmftcp1g5lNCdFCochXXiXY4XvChWJhRDH3BOSlwRiLmCMjqYGXDaN55zSWmJAv+uu
	yhV0gOsTTqYuiiw0yhKZH8o3MwSZgXU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-PKMtVV65NhmyYKs5Uc6eLQ-1; Mon, 01 Sep 2025 04:40:09 -0400
X-MC-Unique: PKMtVV65NhmyYKs5Uc6eLQ-1
X-Mimecast-MFC-AGG-ID: PKMtVV65NhmyYKs5Uc6eLQ_1756716009
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24919af9fc7so19107415ad.3
        for <virtualization@lists.linux.dev>; Mon, 01 Sep 2025 01:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716009; x=1757320809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+Es+FtmQYR5HXyYZrrZ0z0Shosir2um9BQMSS4egjA=;
        b=tov53sFwfdK2WdaONSqqhZe/Sktf+uhcl+EABqNp/dWxrVAltgOniCqAI4rYbIw045
         Vh6g0Trl69lci5JeUzOo4ImgzFKHoSz3IFNYYmtOZ8p0NmjM1eDVqxK9WrS/OxoHZ0Ul
         5V+Yl5/fOWeGIfdnkFz6GIVZjNLfugmbaGpzzHUJhq9FV1hUNh3vk+5hdRtsmPkM2yY+
         Ka//iHKj/tjwA/K1wOpQ4W4nsTwP+Soe51XweubgCRoX8szsugWT71ASfu4bZhwEi3pQ
         M0T4p6gA7oPXcbvIBz1X5yuHWil0WupEGskna946JCVkTDamRgY37zl7T09p8yalzfr1
         mU3A==
X-Forwarded-Encrypted: i=1; AJvYcCUekdNH1FnsMZ+O6tcyOgTvkuHywP9g7WFVUfg9CZXopZhbX4o2A5vllksNBFcxJHnJBr9r3ZpimgZAB4SGRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+OzWpBSz6ggpw3PIq87iH7T9cuISbwTn6bpIPU2B3YdUcHgr2
	JS0D6avk8qkZj2vs4jDx0S9doI6p400kY7SDJXuKfpJrOf7uaHK22qcPGsjkwlPdj4s9OnbutD0
	DFmGjWJ9OeOmEEufWcn7AfLp+DQn1V2Tuz4ho9ASHTCusRTiuKsLJYHlJpObFm2J6Izfs9zfQU0
	tjv+KaQZSLA9fMk8rtOfknUkUZkhSf6M4VHlxHOYvFPNE=
X-Gm-Gg: ASbGncuIsyu1AWf8Ksw7h/k91amf2wPGntLuSMQbrl7lKvPGf1ehngmW1LZUXm7AjOe
	4uhUpeCFytemABB9xTiLx0K4aDou8Wmx3ieSV2w1FtWOZ8mG49eN+NaoW5EF7GDidvwcttJzof7
	s1Dw7d1zZ0J927B/pCsB0=
X-Received: by 2002:a17:902:f70d:b0:248:d917:a57c with SMTP id d9443c01a7336-24944ad11e1mr107308555ad.40.1756716008767;
        Mon, 01 Sep 2025 01:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExoFNMD/FkqxZq0Ff8GbOXpsN/p/2wqpcPV6iygM8eQcyA7WzgsLqmPJySc42yG23m4GKWYE67YkKdXopx47Q=
X-Received: by 2002:a17:902:f70d:b0:248:d917:a57c with SMTP id
 d9443c01a7336-24944ad11e1mr107308135ad.40.1756716008361; Mon, 01 Sep 2025
 01:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
In-Reply-To: <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 1 Sep 2025 10:39:31 +0200
X-Gm-Features: Ac12FXxPBNaVOZUytA6g5UG9keuM9opzMPjH0KW7lm_nsdhvAFd7ryYiMyPtW3A
Message-ID: <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qmmYs8UK9_4o1NSKkbyR7OVIaXSnhPNqy7c3hl-fmDY_1756716009
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
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
>

My understanding was it is ok to start with this version by [1]. We
can even make it asynchronous on top if we find this is a bottleneck
and the VDUSE device would need no change, would that work?

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

The rest of the limits are hardcoded, but I'm ok with changing this.
Is UINT16_MAX ok here, or do you prefer something like MAX_NGROUPS and
MAX_ASID?

[...]

[1] https://patchew.org/linux/20250807115752.1663383-1-eperezma@redhat.com/=
20250807115752.1663383-3-eperezma@redhat.com/#CACGkMEuVngGjgPZXnajiPC+pcbt+=
dr6jqKRQr8OcX7HK1W3WNQ@mail.gmail.com

