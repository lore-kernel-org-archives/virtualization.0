Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C42D063A
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871867; cv=none; b=hCGt+vLGljdi8ckux3JUe8WXWwFuMci/ydciZw6gsC7mPxnjOt+RMakrmTpHsLnYGwoh6wXOqLTQahqSRUFmyK0kjC+/qlKa6x+aArOXPssfOrLz+SPWq8VlmggJgl+Z5jUMcgXIKkSys+gAzReRgjMC9Q35yvG1jXyMoDBQAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871867; c=relaxed/simple;
	bh=A7ssKPkqIDibigKVgV/mQDJH2sZnTU82jjxAnNgso+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsVqKi2eHTXsoNyXA6iFL73D75Tuti6ZUcuxv5B0iaxfy523bFdqbmpUr5qa9H50Xe68yzynt7+stUFDDzuxR/DiBV6EvfqFAvFIqnJaiM6rh3JgVAO60sRSrLLv84Vcu0eSaVmgmGRQDisdi4yHZ18/kv3Bp/6uTBL0tUe7F8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNDzK1gr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNDzK1gr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756871863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FMeOQhsZ/Bz1a50krITAkDUmAVmdmpSJmIX2uvA258=;
	b=jNDzK1grk2vG6+332citlnmNEs915zokpMVBxqujLTKhJzOwDI55ZAeNXd0LYvKF1FJFzP
	zsTawslik6xUYqEWN2M3qxlBJUX2/wwe0NDoIgxU/UX4ZiBf3govhdci0AjS7dHz34zmP6
	2U6HFXpzMbI30dbfUnWxGRXB3VpnP6Q=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-782VKwRCNLG-jD8bsmUgEA-1; Tue, 02 Sep 2025 23:57:39 -0400
X-MC-Unique: 782VKwRCNLG-jD8bsmUgEA-1
X-Mimecast-MFC-AGG-ID: 782VKwRCNLG-jD8bsmUgEA_1756871858
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-248eec89618so65163275ad.1
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 20:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756871858; x=1757476658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FMeOQhsZ/Bz1a50krITAkDUmAVmdmpSJmIX2uvA258=;
        b=UEsniPZTHyc3ePaqA38g0K1cCaH9TniQBjfZl4RsLM2ysrtCCqgbCabjxitzQAgtoX
         VqUmYHH3xcCXurCAEtcsmia9XF3g4m1VYc8jiQUsY3YiuINrSGwNlDZjkB/SUetjNSZB
         RALeiKOdF3cPpK0cgidhJA3x5lN9842Pg0n2IDAPzHpfNfOd+bkuwIRyuPGyY0SseP2n
         uQCy7weM08D8PPDrHezy8J2bvwZUn7hRMVAxIsiYubZ+WLaiCr90AvJCLUcXjsbY3eJD
         XuTr+k7WJraiijV0xVHnyQ6MKL+MBvF11NzHdS6qo+Y9yYlZsSYyx4H2TiyVZQ3zr2RL
         kkcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4GkNmlJF0jFUWtBkdqf25Zm0zl7ZHqAUDLVnAumZkpLwIRaggTdBIzgjrCRsdK/25i8+7zGPDPPkBj/z9Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgjAcHsATNxGqauOnN5DMcIiYCdgLrie4QvmxYQcc1O1qXkbWZ
	zcGiUr7JnBpNWNodEHpGuy+vJc92lV9Zeg+bgmfjvlZClCDo447BUIxoHmswageIZ56NPwNETqz
	IoMv4I+Vj8RjihI9IX42CZW+mezCVX6V16XW+oTUiZcOfwmjcAPtZwXDtb1DKuSO76BMFVFNA8X
	2xp5Z60g9ViD92TKXqqEsWWoIgxjvXc4lHxUwVVhIgNjQ=
X-Gm-Gg: ASbGncsFiyGWMkzoWPrJ8bG7+gI0V32E1DcUGLih7eGJhvTKB5HDGa8YNqzr402FiIx
	bc/l2fVqpJIwWqDi/Sl2W6AUTyJi8ttxHBibRk+NulfVz8udIQiGE/38QGO6RzKZdu/aMkJ62J6
	53XoD1JEa1MuBtWhX3AAVDYA==
X-Received: by 2002:a17:903:3c45:b0:246:4eb3:9c08 with SMTP id d9443c01a7336-24944870a65mr173393645ad.5.1756871857878;
        Tue, 02 Sep 2025 20:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkE3iE/jqdcUHOgbC8sPvuCPSZCKKD0K/m8LwLji6un3PH2aumk05za/muG1bJ4viYeIzj5Ff9OEL5hv3VF8o=
X-Received: by 2002:a17:903:3c45:b0:246:4eb3:9c08 with SMTP id
 d9443c01a7336-24944870a65mr173393355ad.5.1756871857260; Tue, 02 Sep 2025
 20:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com> <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
In-Reply-To: <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 11:57:26 +0800
X-Gm-Features: Ac12FXxQzUUcpGjD91I8f81-ocOtOBSKHxA1qUyDeVHyGayy8sNvtEGSiahbZ0Y
Message-ID: <CACGkMEuoH3J9HwRU_G5wsDoeP7EjYfUU-aCDRbsjmcv45OG2mw@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H3n2HfXV7AOftngpWuGTolFj0HRSCwgyo4nOjbN2AGw_1756871858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > This allows sepparate the different virtqueues in groups that shares =
the
> > > same address space.  Asking the VDUSE device for the groups of the vq=
 at
> > > the beginning as they're needed for the DMA API.
> > >
> > > Allocating 3 vq groups as net is the device that need the most groups=
:
> > > * Dataplane (guest passthrough)
> > > * CVQ
> > > * Shadowed vrings.
> > >
> > > Future versions of the series can include dynamic allocation of the
> > > groups array so VDUSE can declare more groups.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxim=
e)
> > >
> > > RFC v3:
> > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a low=
er
> > >   value to reduce memory consumption, but vqs are already limited to
> > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > * Remove the descs vq group capability as it will not be used and we =
can
> > >   add it on top.
> > > * Do not ask for vq groups in number of vq groups < 2.
> > > * Move the valid vq groups range check to vduse_validate_config.
> > >
> > > RFC v2:
> > > * Cache group information in kernel, as we need to provide the vq map
> > >   tokens properly.
> > > * Add descs vq group to optimize SVQ forwarding and support indirect
> > >   descriptors out of the box.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++++++=
--
> > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index e7bced0b5542..0f4e36dd167e 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > >         struct vdpa_vq_state state;
> > >         bool ready;
> > >         bool kicked;
> > > +       u32 vq_group;
> > >         spinlock_t kick_lock;
> > >         spinlock_t irq_lock;
> > >         struct eventfd_ctx *kickfd;
> > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > >         u8 status;
> > >         u32 vq_num;
> > >         u32 vq_align;
> > > +       u32 ngroups;
> > >         struct vduse_umem *umem;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_d=
evice *vdpa, u16 idx,
> > >         return 0;
> > >  }
> > >
> > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +
> > > +       return dev->vqs[idx]->vq_group;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_devi=
ce *vdpa)
> > >         return dev->status;
> > >  }
> > >
> > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > +{
> > > +       /* All vqs and descs must be in vq group 0 if ngroups < 2 */
> > > +       if (dev->ngroups < 2)
> > > +               return 0;
> > > +
> > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > +               struct vduse_dev_msg msg =3D { 0 };
> > > +               int ret;
> > > +
> > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > +               msg.req.vq_group.index =3D i;
> > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.group;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 statu=
s)
> > >  {
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdpa_de=
vice *vdpa, u8 status)
> > >         if (vduse_dev_set_status(dev, status))
> > >                 return;
> > >
> > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK) &&
> > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > +               if (vduse_fill_vq_groups(dev))
> > > +                       return;
> >
> > I may lose some context but I think we've agreed that we need to
> > extend the status response for this instead of having multiple
> > indepdent response.
> >
>
> My understanding was it is ok to start with this version by [1]. We
> can even make it asynchronous on top if we find this is a bottleneck
> and the VDUSE device would need no change, would that work?
>
> > > +
> > >         dev->status =3D status;
> > >  }
> > >
> > > @@ -789,6 +825,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> > >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> > >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > > +       .get_vq_group           =3D vduse_get_vq_group,
> > >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> > >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> > >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > > @@ -1737,12 +1774,19 @@ static bool features_is_valid(struct vduse_de=
v_config *config)
> > >         return true;
> > >  }
> > >
> > > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > > +                                 u64 api_version)
> > >  {
> > >         if (!is_mem_zero((const char *)config->reserved,
> > >                          sizeof(config->reserved)))
> > >                 return false;
> > >
> > > +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > > +               return false;
> > > +
> > > +       if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups >=
 0xffff)
> > > +               return false;
> >
> > Let's use a macro instead of magic number.
> >
>
> The rest of the limits are hardcoded, but I'm ok with changing this.
> Is UINT16_MAX ok here, or do you prefer something like MAX_NGROUPS and
> MAX_ASID?

MAX_NGROUPS and MAX_ASID seem to be better.

Thanks

>
> [...]
>
> [1] https://patchew.org/linux/20250807115752.1663383-1-eperezma@redhat.co=
m/20250807115752.1663383-3-eperezma@redhat.com/#CACGkMEuVngGjgPZXnajiPC+pcb=
t+dr6jqKRQr8OcX7HK1W3WNQ@mail.gmail.com
>

