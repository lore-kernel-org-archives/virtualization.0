Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD7286402
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138525; cv=none; b=p0z0noSjIJEJ8HFr93gfQGQl3BGcI0NhS2mqfjFe6hK3D4o2dFzVErc/kvKA+ZyPaEg5WZN3aL8jnyz1D6zlPNGz5eHZKNWLDeldynvFY0AB6twTRDlR73X7ayNCCHsMpJHb2adg5NLZH+dO/QeZCLg4rnqvyqfBGjf+sGNHw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138525; c=relaxed/simple;
	bh=PqFCCHzTiYITqvejiw8AZSoVtEzqoElZZMqFjID5Lzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bps5iqpPcTCo0pk363QsUcKgfQkM7j/+63bjiG6R1cFo4G3MzU/+lpP/GtFKHCdg70hFrsgYlyfM4IeVP98qc+kGU37F62K6uKzfU68+ZoHN7zk5ue14NUmUAi5JWCq/00JrtrtvRM+3lLtd3RN7x5wl+zSMtkF9EavvW7qm3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cBCXAtoU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cBCXAtoU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3407f385dd0so2209171a91.1
        for <virtualization@lists.linux.dev>; Sun, 02 Nov 2025 18:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762138522; x=1762743322; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIdxmPrkrTjOQzqHGXgVhbFwLluagz8KQWIczvWtkIU=;
        b=cBCXAtoUDCw2wZNUZ9snk6tNtfQ6yRQ+qyvHv32U/g8rQsz460a5yHHcTumOYLL//V
         0xN4c5WD3GhbSm03oUay/mBjLLfGkeoFmeXeiZlqdP93YoeDLn7rI2LK1mUT6IdPtYeT
         rB+4dZNCiBRr8W563ThZwY/Fbr0r16kRezHDOzyFm0KwMR5SBzlYR2sTCFxg+e2oelBt
         DRQkT9Ff0wFyheGOMMpzg7SHX5to4VAN60DWkUN3jgZ+r+p9m7sFy5U0y1gpWY6TIJWs
         bztisA8PNuKt5iuklCZRACyOZsEiu37J03P+f6E263+NQKFpPRreEgQvBEGM+DIYncBg
         I7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762138522; x=1762743322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIdxmPrkrTjOQzqHGXgVhbFwLluagz8KQWIczvWtkIU=;
        b=uKBxcR4rZiElA/su4G1aZE1NR6qEQAbxA46FZHYGX5cGbxHZyMm3Z00Mcmmyj0QC6T
         tm5UGOWPMwmAQ6AJYVVc6YIr+8sOAbrj2ewWnnoKBf6PhqAHU+bstUVeXFnSwVfXRcGh
         vozBZyHuLP6k+IBSP+BXQOAksD+j5u8WhizY2PeAnOd+QAYhAaPYAFm5OwhL4Aqm/Vpi
         6lRnrnOao0xcfSmo9w7S9wC1epgX4xEN1N7SCIyx389qZfF+PZuAv6C5kmuNON+1+L2M
         21spiBs7cL/EjrE2n+kldLBQquDFd8IAFxQ2QQYUf+tvZTvgBuW/slm4G0CwhNfPXIY4
         bPeA==
X-Forwarded-Encrypted: i=1; AJvYcCXLf59oSzbv0yiWQQtIev14HaV+P2FkVddHImYr8MV+wv22BKZkBxH3XVnFl1FhzRqZuN29CYq4+cjwAfmaZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn7FbnmZAFBj7EGDkA493IS/oEn3zdwCplVxfUJAUGCqVZsWyt
	s8shvIdvLHz57DzhXiqz9Fjr8Vu7ix84jDsc8gOj5oZVgb90iLEZVMrmA0bIZVxwB7GGocOWA4w
	IW5F5up2Za/WSzDotdslOhyrTThRZ2X5zYrQwK5Ws
X-Gm-Gg: ASbGnctXD/VxK352Xap12sK+PM9mmUxIiYKCVbWAWyAnfdUxqo6qg7GbS5kh3uxjtiZ
	KYRz+aGs3d7XZ4DSyKCQ+0jIQIXSXmoWD7pgq5JPbchw3kn65cXXhXLK6q4MqzMC1BC8QEXomCb
	e+OFZBvKl2i8AbJWEgIdIVM2XGEMut/rb8rTGuZnxurtcMIilXOpXx34eFU+iDG7SFXjZa4hwaY
	QKzsh6iXpVcghhpHRe90EPVwGVv47D/BGwwE+j7WKIPqhWm5ECMqouCI5LSQD2InHiNhVAqZUoh
	CxOjJfKYHHEKhvyaBryrIdT6SW1C
X-Google-Smtp-Source: AGHT+IGmaQsyBDbf2SNS7JU4J6ZIiE1C7BLIc6gTi77zduqymO9YGOjw690/ouxDrnqsiauW6+/3LclLaRNTEzrk5Ds=
X-Received: by 2002:a17:903:41cc:b0:295:7b85:2f5f with SMTP id
 d9443c01a7336-2957b8530eemr46739405ad.31.1762138522448; Sun, 02 Nov 2025
 18:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
 <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
 <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com> <CAJaqyWe31w=Z--Sh6ufwvhaBsBaKypUjHzLy9qm6NyDJM-NgDQ@mail.gmail.com>
In-Reply-To: <CAJaqyWe31w=Z--Sh6ufwvhaBsBaKypUjHzLy9qm6NyDJM-NgDQ@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 3 Nov 2025 10:55:11 +0800
X-Gm-Features: AWmQ_bnv6KTe8RF60M9yCCZqzcdlxzCRZ38-wVYDEdJsJvfeLX9Fg9xcqCbn2GM
Message-ID: <CACycT3sKofWfottqAzRWscCWNaodnqXiFtvuhSv7Pqz1F0+90A@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:09=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@bytedance.c=
om> wrote:
> >
> > On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@byteda=
nce.com> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > Add support for assigning Address Space Identifiers (ASIDs) to ea=
ch VQ
> > > > > group.  This enables mapping each group into a distinct memory sp=
ace.
> > > > >
> > > > > Now that the driver can change ASID in the middle of operation, t=
he
> > > > > domain that each vq address point is also protected by domain_loc=
k.
> > > > >
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > v8:
> > > > > * Revert the mutex to rwlock change, it needs proper profiling to
> > > > >   justify it.
> > > > >
> > > > > v7:
> > > > > * Take write lock in the error path (Jason).
> > > > >
> > > > > v6:
> > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSIO=
N_1) ?/
> > > > >   (MST).
> > > > > * Fix struct name not matching in the doc.
> > > > >
> > > > > v5:
> > > > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB=
_GET_FD
> > > > >   ioctl (Jason).
> > > > > * Properly set domain bounce size to divide equally between nas (=
Jason).
> > > > > * Exclude "padding" member from the only >V1 members in
> > > > >   vduse_dev_request.
> > > > >
> > > > > v4:
> > > > > * Divide each domain bounce size between the device bounce size (=
Jason).
> > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > * Change if (x && (y || z)) return to if (x) { if (y) return; if =
(z)
> > > > >   return; } (Jason)
> > > > > * Change a bad multiline comment, using @ caracter instead of * (=
Jason).
> > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > >
> > > > > v3:
> > > > > * Get the vduse domain through the vduse_as in the map functions
> > > > >   (Jason).
> > > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic num=
ber
> > > > >   (Jason)
> > > > >
> > > > > v2:
> > > > > * Convert the use of mutex to rwlock.
> > > > >
> > > > > RFC v3:
> > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a=
 lower
> > > > >   value to reduce memory consumption, but vqs are already limited=
 to
> > > > >   that value and userspace VDUSE is able to allocate that many vq=
s.
> > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > * Move the umem mutex to asid struct so there is no contention be=
tween
> > > > >   ASIDs.
> > > > >
> > > > > RFC v2:
> > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the fi=
rst
> > > > >   part of the struct is the same.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++---=
------
> > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -41,6 +41,7 @@
> > > > >
> > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > > > >         struct mm_struct *mm;
> > > > >  };
> > > > >
> > > > > +struct vduse_as {
> > > > > +       struct vduse_iova_domain *domain;
> > > > > +       struct vduse_umem *umem;
> > > > > +       struct mutex mem_lock;
> > > > > +};
> > > > > +
> > > > >  struct vduse_vq_group {
> > > > > +       struct vduse_as *as;
> > > > >         struct vduse_dev *dev;
> > > > >  };
> > > > >
> > > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > > >         struct vduse_vdpa *vdev;
> > > > >         struct device *dev;
> > > > >         struct vduse_virtqueue **vqs;
> > > > > -       struct vduse_iova_domain *domain;
> > > > > +       struct vduse_as *as;
> > > > >         char *name;
> > > > >         struct mutex lock;
> > > > >         spinlock_t msg_lock;
> > > > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > > > >         u32 vq_num;
> > > > >         u32 vq_align;
> > > > >         u32 ngroups;
> > > > > -       struct vduse_umem *umem;
> > > > > +       u32 nas;
> > > > >         struct vduse_vq_group *groups;
> > > > > -       struct mutex mem_lock;
> > > > >         unsigned int bounce_size;
> > > > >         struct mutex domain_lock;
> > > > >  };
> > > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vduse_=
dev *dev, u8 status)
> > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > >  }
> > > > >
> > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asi=
d,
> > > > >                                   u64 start, u64 last)
> > > > >  {
> > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct vdu=
se_dev *dev,
> > > > >                 return -EINVAL;
> > > > >
> > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > -       msg.req.iova.start =3D start;
> > > > > -       msg.req.iova.last =3D last;
> > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > +               msg.req.iova.start =3D start;
> > > > > +               msg.req.iova.last =3D last;
> > > > > +       } else {
> > > > > +               msg.req.iova_v2.start =3D start;
> > > > > +               msg.req.iova_v2.last =3D last;
> > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > +       }
> > > > >
> > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > >  }
> > > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct file =
*file, poll_table *wait)
> > > > >         return mask;
> > > > >  }
> > > > >
> > > > > +/* Force set the asid to a vq group without a message to the VDU=
SE device */
> > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > > > +                                      unsigned int group, unsign=
ed int asid)
> > > > > +{
> > > > > +       mutex_lock(&dev->domain_lock);
> > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > +       mutex_unlock(&dev->domain_lock);
> > > > > +}
> > > > > +
> > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > >  {
> > > > >         int i;
> > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > >
> > > > >         /* The coherent mappings are handled in vduse_dev_free_co=
herent() */
> > > > > -       if (domain && domain->bounce_map)
> > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > +               struct vduse_iova_domain *domain =3D dev->as[i].d=
omain;
> > > > > +
> > > > > +               if (domain && domain->bounce_map)
> > > > > +                       vduse_domain_reset_bounce_map(domain);
> > > > > +       }
> > > > > +
> > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > >
> > > > >         down_write(&dev->rwsem);
> > > > >
> > > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(str=
uct vdpa_device *vdpa, u16 idx)
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsign=
ed int group,
> > > > > +                               unsigned int asid)
> > > > > +{
> > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > +       int r;
> > > > > +
> > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > +
> > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > +       if (r < 0)
> > > > > +               return r;
> > > > > +
> > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16=
 idx,
> > > > >                                 struct vdpa_vq_state *state)
> > > > >  {
> > > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa_d=
evice *vdpa,
> > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > >         int ret;
> > > > >
> > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb)=
;
> > > > >         if (ret)
> > > > >                 return ret;
> > > > >
> > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MA=
X);
> > > > >         if (ret) {
> > > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > > +               vduse_domain_clear_map(dev->as[asid].domain, iotl=
b);
> > > > >                 return ret;
> > > > >         }
> > > > >
> > > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_vdp=
a_config_ops =3D {
> > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > >         .free                   =3D vduse_vdpa_free,
> > > > >  };
> > > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_device=
(union virtio_map token,
> > > > >                 return;
> > > > >
> > > > >         vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > -
> > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > +       domain =3D token.group->as->domain;
> > > > >         vduse_domain_sync_single_for_device(domain, dma_addr, siz=
e, dir);
> > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > >  }
> > > > >
> > > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token=
,
> > > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(un=
ion virtio_map token,
> > > > >                 return;
> > > > >
> > > > >         vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > -
> > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > +       domain =3D token.group->as->domain;
> > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, =
dir);
> > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > >  }
> > > > >
> > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, str=
uct page *page,
> > > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(union =
virtio_map token, struct page *page,
> > > > >  {
> > > > >         struct vduse_dev *vdev;
> > > > >         struct vduse_iova_domain *domain;
> > > > > +       dma_addr_t r;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return DMA_MAPPING_ERROR;
> > > > >
> > > > >         vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > +       mutex_lock(&vdev->domain_lock);
> > > >
> > > > The mutex_lock can't be used here since the dma ops might be called=
 in
> > > > atomic context. And I think we can just remove it since creation an=
d
> > > > deletion operations of the iova domain are guaranteed not to execut=
e
> > > > concurrently with I/O operations.
> > > >
> > >
> > > That would be great indeed! Can you expand on this, what protects her=
e
> > > from the moment the two syscalls are issues from userland?
> > >
> >
> > The domain mutex lock is introduced in commit
> > d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova domain
> > creation"). It's used to prevent concurrent execution between
> > vdpa_dev_add() and some vduse device ioctl which needs to access the
> > iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dma ops
> > would not be called until vdpa_dev_add() completed, so the mutex lock
> > is not needed.
> >
>
> Yes, but the usage is extended here to also protect from concurrent
> calls to vduse_dev_map_page and vduse_set_group_asid or similar.
>
> So I guess the best is to replace it with a spinlock or RCU.
>

OK, I see, we simply aim to prevent concurrent access to the group->as
variable here. But I wonder if the .set_group_asid function can be
called during I/O. I think the unmap_page() would fail if we change
the group->as between map_page() and unmap_page(). Besides, it seems
that .set_group_asid is only called in the vhost-vdpa case currently,
but the dma ops such as map_page/unmap_page only service the
virtio-vdpa case, so they would not be called concurrently with
.set_group_asid now.

Thanks,
Yongji
