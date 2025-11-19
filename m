Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28C28B4FA
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519944; cv=none; b=DyfDuhaY3TTXmfxIpRNC5rUjt+IYp9A2Vg/ybrObgXptuhqPruSxqmrd60WoEeWCaO98RE0f/yhhSq3hwMbrLn5PVbv8//Fm2nUzANiJPICErUxP6KkXgaNiEs3f8N77p3IGfazmtsuWA+pb1xyG0826iBJYC3/SBkh69zE4DOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519944; c=relaxed/simple;
	bh=NBSi1zWmvs1Tt6Jd1YfJOO5gDtlt01Hm5cSoJ4JMjI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrIWXyRPSeaMzZee6gTIv318hJ1xB1pooVTVjQls0wNS8jp9q7cKHztmq3ZAepcocUtVDCg5pvV3Vk0Ce43LHmHgnN5re1B74LX9Ap16cgglfw7HqGMlpkhhTC+b/vAB/FdiHyP47/xvY57mCx37i//UAgjnYraQYt3heSznx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLJdzYzU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLJdzYzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763519940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRC/8/BjI0raQhhk0Aq2N0HX1P61yxSDhVp57VIyzVI=;
	b=MLJdzYzUdk/WK2Sw1VgBjpfYouLPsl1JW+OmEyQhz1U14FxOzyNJ6s7SYbltcyJRMVuBuP
	msUsrhMRi6sZ5uGezA+c7uyKI+5ktV+iwaJdFqlGTTVY5tPJgMe4jKAWgdgToiLcsxyEJ2
	TqEyKcSLJYrhYhvHjJsfLPjeMHo3oRQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-VwBVVie8PoaOOpuXsA2Cow-1; Tue, 18 Nov 2025 21:38:58 -0500
X-MC-Unique: VwBVVie8PoaOOpuXsA2Cow-1
X-Mimecast-MFC-AGG-ID: VwBVVie8PoaOOpuXsA2Cow_1763519937
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3418ad76023so13688453a91.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763519937; x=1764124737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRC/8/BjI0raQhhk0Aq2N0HX1P61yxSDhVp57VIyzVI=;
        b=pFGtsI4kRjwRIUkdPerd1VZzfJuvZ2jgEdxaGsQJzlAOIHnCtQKCf6eMzqfT/pQB6P
         JQiD81pVtdg5eMTGR0B0O44s+HyzbPc8fZKdUUgqzCdpAv/Fvw9C2uGUzYQw8yMET9Dd
         /9RvkWggSXcIC6QqDe3omHGnx6ss85rPnK2Jokuil9DSWzGYR1lSXtuxucKmqNN/SE1o
         O8PtwkgTEvOmUr1N+Fcj1aAfUDf2Rkkw8Hj7zv/xC316KAxtkGhhZ7mZerTP19jKA6FZ
         uiDnAdBmlMZ7IYwnPDe585eBFKqxofiXzKiL+LmVBgKCeNAAdjDxkaCfdiNuT2ffSfnX
         hPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhvq8PbVzqdzRZAx4Hc9h5x/KygL7YtJbivfACfh/Md6R7sWNVMJiq04v0mJykIY/YOlh40GuE9vXpHS0NTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw06zm95SoG31OrqknrOvBS2DKV5CkiXrtTItYBxdjh7Urx3TAx
	4BMpM8L0PHhofhyXTf2sdWT/1u703875oXwBnb483B+ohtqUp+xV29F2jJ9i7UrTziPf90yVpFo
	DKhg+6hPLOuJHZ79cOE1MCpwfD17WUsxOlQXPPAatyj/c3poE094fYutmmJPTAZajNP70J//8pk
	Gek1x70VB5Qu4AGiBysE9+PI+0+gc030oQ4F0DVXA39KY=
X-Gm-Gg: ASbGnctfbz2w1cnzMsbFg54UAPBvBb/xJ9cI37r4eD+UlD5echNDECDJBhEk1NapMZj
	F3N2Y1i729Mp5pzCOveMuNj7NCk02R/I1vKDRk0V41q0/lB/ztCR+Z7rStaVnE7xNzbzr79qujH
	bKwThx4raKSg4mS16FYyLLTTvr0lzvcIqve3WdymmBFpsRQpcu/2uF7A/Zrm30PNE=
X-Received: by 2002:a17:90b:4a8c:b0:341:761c:3330 with SMTP id 98e67ed59e1d1-343fa73b675mr21904267a91.23.1763519937040;
        Tue, 18 Nov 2025 18:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE261lC9bBkt1Ju2E98jCPo/9ULoKcYjU8Ij2IRKT6YCuKtgJwa86CTlad4SujEouXZTmmouKoWl/b+E0t1y+o=
X-Received: by 2002:a17:90b:4a8c:b0:341:761c:3330 with SMTP id
 98e67ed59e1d1-343fa73b675mr21904234a91.23.1763519936453; Tue, 18 Nov 2025
 18:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
 <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com> <CAJaqyWdgGmnaQ3=j-6S9E4mfPSHc872FQZfVna_eX_UnipX2UA@mail.gmail.com>
In-Reply-To: <CAJaqyWdgGmnaQ3=j-6S9E4mfPSHc872FQZfVna_eX_UnipX2UA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:38:44 +0800
X-Gm-Features: AWmQ_bkwwNAFLxjkQ8gG1FhUguJw3TU9cR-J63eRfwHioa0xmaWrmFAZR3lSZRk
Message-ID: <CACGkMEuzAo2jRgUwkxhM=bgS4a4NvpP6BYZB1zed00C6J8eiyg@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GCfX6hq02eGORnGUWUQI8pxcXbfZxXxsGY1sGa3qbUk_1763519937
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 8:16=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Nov 17, 2025 at 5:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Nov 14, 2025 at 7:25=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
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
> > > >
> > > > Maybe it's better to document what is protected by RCU and how.
> > > >
> > >
> > > I added the _rcu annotation but I can expand it for sure. I can also
> > > modify the commit message.
> > >
> > > > More below.
> > > >
> > > > >
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > >
> > > I forgot to remove this, my bad!
> > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > v9:
> > > > > * Replace mutex with RCU, as the vdpa map_ops can run from atomic
> > > > >   context.
> > > > >
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
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 ++++++++++++++++++++---=
------
> > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > >  2 files changed, 314 insertions(+), 109 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index 97be04f73fbf..ff95ed56f22d 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -11,6 +11,7 @@
> > > > >  #include "linux/virtio_net.h"
> > > > >  #include <linux/init.h>
> > > > >  #include <linux/module.h>
> > > > > +#include <linux/rcupdate.h>
> > > > >  #include <linux/cdev.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/eventfd.h>
> > > > > @@ -41,6 +42,7 @@
> > > > >
> > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > @@ -86,7 +88,14 @@ struct vduse_umem {
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
> > > > > +       struct vduse_as *as __rcu;
> > > > >         struct vduse_dev *dev;
> > > > >  };
> > > > >
> > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > >         struct vduse_vdpa *vdev;
> > > > >         struct device *dev;
> > > > >         struct vduse_virtqueue **vqs;
> > > > > -       struct vduse_iova_domain *domain;
> > > > > +       struct vduse_as *as;
> > > > >         char *name;
> > > > >         struct mutex lock;
> > > > >         spinlock_t msg_lock;
> > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
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
> > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_=
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
> > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vdu=
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
> > > > > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct file =
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
> > > > > +       /*
> > > > > +        * Two concurrent updates to this pointer are valid as th=
ey cannot
> > > > > +        * point to an invalid region.  It is ok for them to race=
 as long as
> > > > > +        * the readers see a consistent state through RCU.
> > > > > +        */
> > > > > +       rcu_assign_pointer(dev->groups[group].as, &dev->as[asid])=
;
> > > >
> > > > I'd expect at least a synchronize_rcu() here to wait for the read i=
s done?
> > > >
> > >
> > > What's the use? The only thing left here is to return from
> > > vduse_set_group_asid_nomsg, and we don't need to wait for readers
> > > here, do we?
> >
> > See below.
> >
> > >
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
> > > > > @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_map(str=
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
> > > > > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct vdpa_d=
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
> > > > > @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vduse_vdp=
a_config_ops =3D {
> > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > >         .free                   =3D vduse_vdpa_free,
> > > > >  };
> > > > > @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for_devic=
e(union virtio_map token,
> > > > >                                              enum dma_data_direct=
ion dir)
> > > > >  {
> > > > >         struct vduse_dev *vdev;
> > > > > +       struct vduse_as *as;
> > > > >         struct vduse_iova_domain *domain;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return;
> > > > >
> > > > >         vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > -
> > > > > +       rcu_read_lock();
> > > > > +       as =3D rcu_dereference(token.group->as);
> > > > > +       domain =3D as->domain;
> > > > > +       rcu_read_unlock();
> > > > >         vduse_domain_sync_single_for_device(domain, dma_addr, siz=
e, dir);
> > > >
> > > > This is suspicious, at least we should do rcu_read_unlock() after
> > > > vduse_domain_sync_single_for_device(), otherwise I don't see how RC=
U
> > > > works.
> > > >
> > >
> > > RCU is protecting that the address space pointer of the vq group is
> > > not modified concurrently with the access. Ideally, this should be a
> > > full lock, but just making sure that all accesses from the reader are
> > > coherent is enough. Userspace should expect nothing if it uses the ma=
p
> > > and modifies the vq group ASID at the same time anyway, but the kerne=
l
> > > needs to be sure that it does not see intermediate states. TBH, we
> > > could move to a READ_ONCE / WRITE_ONCE, would that be more clear?
> >
> > Using READ_ONCE/WRITE_ONCE() needs to make sure the ordering is
> > handled correctly.
> >
> > But I meant what happens if
> >
> > [cpu0]rcu_read_lock()
> > [cpu0]as =3D rcu_dereference(token.group->as)
> > [cpu0]...
> > [cpu0]rcu_read_unlock()
> > [cpu1]rcu_assign_pointer(token.group->as)
> > [cpu0]vduse_domain_sync_single_for_device()
> >
>
> That should go ok. What I'm trying to protect here is the iterations
> in vduse_domain_sync_single_for_device -> vduse_domain_bounce.
>
> I'm going to embed that function here in
> vduse_dev_sync_single_for_device and omit RCU and some details to make
> the point easier:
>
> vduse_dev_sync_single_for_device(union virtio_map token, dma_addr_t
> iova, size_t size, ...) {
>   read_lock(&token.group->as->domain);
>   while (size)
>     map =3D token.group->as->domain->bounce_maps[iova];
>     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
>
>     ...
>     page =3D token_group->as->domain->bounce_maps
>     addr =3D kmap_local_page(page);
>     do_bounce(map->orig_phys, addr, sz, dir);
>     kunmap_local(addr);
>     size -=3D sz;
>     iova +=3D sz;
>   }
>   read_unlock(&token.group->as->domain);
> }

Right, so I meant for rwlock like semantic (let's forget the sleeping here)=
.

vduse_set_group_asid_nomsg() should use "write lock" so it must wait
for the "read lock" to be done. But this is not the logic that is
implemented in this patch as there's no synchronize_rcu() in the
vduse_set_group_asid_nomsg(). We need to explain why set_group_asid()
doesn't need to wait and if this is true, we probably don't need RCU
but to make sure the load/store is atomic.

>
> Now, depending on the point where another execution thread changes
> token_group->as and how the compiler has chosen to generate the
> machine code, the outcome could be:
> 1) The domain read lock of one ASID is taken but the domain lock of
> another as is unlocked.
> 2) We iterate until iova is ok for the ASID we're handling, but not
> for the other one. So we access an invalid offset in
> bounce_maps[iova].
>
> And I guess there are other possible outcomes too.
>
> So I need to make sure that the pointer accesses in all
> vduse_domain_bounce is coherent.

I'm not sure I got here, but it looks like it accepts a domain
parameter and is protected by the bounce lock so we are probably fine
here?

> I'm ok if it takes the one before the
> concurrent call to vduse_set_group_asid_nomsg or the one after that,
> as the lifetime of all domains are bound to the device. But it cannot
> change in the middle of the operation:
>
> vduse_dev_sync_single_for_device(union virtio_map token, dma_addr_t
> iova, size_t size, ...) {
>   as =3D token.group->as;
>   // Tell the compiler to never replace "as" by "token.group->as" after t=
his.
>   read_lock(&as->domain);
>   while (size)
>     map =3D as->domain->bounce_maps[iova];
>     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
>
>     ...
>     page =3D as->domain->bounce_maps
>     addr =3D kmap_local_page(page);
>     do_bounce(map->orig_phys, addr, sz, dir);
>     kunmap_local(addr);
>     size -=3D sz;
>     iova +=3D sz;
>   }
>   read_unlock(&as->domain);
> }
>
> That can be done in many ways. Probably the read_lock is already
> enough but it is not explicit that it is protecting token.group->as,
> and future changes could remove it. To me, RCU is the most clear way
> to do it, but even a volatile read (READ_ONCE?) would do.

I wonder if another group rwlock is sufficient here:

for set_group_as_id()

write_lock(&dev->groups[group].lock);
dev->groups[group].as =3D &dev->as[asid];
write_unlock(&dev->groups[group].lock);

for the case where we need defer as

read_lock(&dev->groups[group].lock);
as =3D dev->groups[group].as;
//using as
read_unlock(&dev->groups[group].lock);

If this works, we don't need to bother with thinking if the
wait/synchronizre_rcu() is really needed or not?

>
> > If this is not an issue, RCU is not a must, but please explain why.
> > If this is an issue, we need to fix it.
> >
> > It's basically a question that
> >
> > 1) should we need to wait for the DMA to be completed before assigning
> > to the new as
>
> I don't think so, it is valid to assign a new as and let the ongoing
> operation to continue. It is racy and the operation could fail, but
> the kernel just returns an error and doesn't access invalid memory or
> similar.

See below.

>
> > 2) should we track the set_group_asid() for the group that has pending
> > DMA to avoid potential issue
> >
>
> No, the group will outlive the operation as it is bound to the device.

I meant e.g the DMA could be triggered by the device. For example, the
device may try to trigger an interrupt when the kernel is trying to
assign a new asid. So I wonder if guest can use this to poke Qemu's
memory etc. But if you mean we depend on the IOTLB to guard against
this, I'm fine, but let's document why we don't need it and how the
IOTLB layer can help to eliminate such risk.

Anyhow, tracking and failing seems to be more robust. For example,
kernel swiotlb has a layer to track whether the address that is being
unmapped is mapped before. In our case we should make sure when race
happens, isolation via ASID won't be broken.

Thanks

>
> > >
> > > The function vduse_domain uses its own lock to protect concurrent
> > > access to the maps of the ASID itself, as they were needed before
> > > implementing ASID already.
> >
> > Thanks
> >
> > >
> > > > >  }
> > > > >
> > > > > @@ -868,14 +927,17 @@ static void vduse_dev_sync_single_for_cpu(u=
nion virtio_map token,
> > > > >                                              enum dma_data_direct=
ion dir)
> > > > >  {
> > > > >         struct vduse_dev *vdev;
> > > > > +       struct vduse_as *as;
> > > > >         struct vduse_iova_domain *domain;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return;
> > > > >
> > > > >         vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > -
> > > > > +       rcu_read_lock();
> > > > > +       as =3D rcu_dereference(token.group->as);
> > > > > +       domain =3D as->domain;
> > > > > +       rcu_read_unlock();
> > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, =
dir);
> > > > >  }
> > > > >
> > > > > @@ -885,15 +947,21 @@ static dma_addr_t vduse_dev_map_page(union =
virtio_map token, struct page *page,
> > > > >                                      unsigned long attrs)
> > > > >  {
> > > > >         struct vduse_dev *vdev;
> > > > > +       struct vduse_as *as;
> > > > >         struct vduse_iova_domain *domain;
> > > > > +       dma_addr_t r;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return DMA_MAPPING_ERROR;
> > > > >
> > > > >         vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > +       rcu_read_lock();
> > > > > +       as =3D rcu_dereference(token.group->as);
> > > > > +       domain =3D as->domain;
> > > > > +       rcu_read_unlock();
> > > > > +       r =3D vduse_domain_map_page(domain, page, offset, size, d=
ir, attrs);
> > > >
> > > > Same here.
> > > >
> > > > Thanks
> > > >
> > >
> >
>

