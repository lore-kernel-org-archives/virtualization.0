Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DF30E0C0
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763353409; cv=none; b=L2VnxebXO+EK164E0x5DyvAa64uM5g6zwvgwSyg+bLURblwuuueJJmSu46ptJ3L64c5a1h70p8TNUlIq8zuCv0ty4TIaiBAf3ZLmvZ/Mxpi9MzfoCbYQrsdT9GmlvODw6btpag1LYd2hu8HSYQ17/Kre7UATm9ZaCtM8m/jfSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763353409; c=relaxed/simple;
	bh=UuB1ymVl3PCBynv+DejhArVMgAG21Z02b09e7fLmnPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMcJb2NRLWKqsnm/UxjqoyGs0ReS3ojXYnrUj3wS88IptpuPpvu8QP3ylUMpQPxOyTOwSh0cjpnlEd3Nhr0trKS55uAvANgO4QdNJuEdkAIuR11+yS/N69a1avwtpbxPHRORQpirUxo93z/435yVJ8eqFwXkblrtIn2GZYDqAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuB4gOoh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuB4gOoh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763353405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vabH7L+TSTAmE1zjFjJg+wRf7TU6eNQQ0e+/FIztP2w=;
	b=MuB4gOohpsppf2EhnxCdw14zVrsWy+/Z+gnbnb07tsSZc4VFxfm7+BeqaQcRWuO7QgBUpe
	R+QvPBfn1iL3Au/gdhKiCpa3PUrifakSjdZrvJjn2ZchTRUqUwg5CMhru7iWO3fMlX5Vcj
	1EzCp41YHhKg6t49wCrEfdLgH63nVDc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-bjkx65liP-uVh8O3nOJ-TQ-1; Sun, 16 Nov 2025 23:23:24 -0500
X-MC-Unique: bjkx65liP-uVh8O3nOJ-TQ-1
X-Mimecast-MFC-AGG-ID: bjkx65liP-uVh8O3nOJ-TQ_1763353403
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3436d81a532so8832777a91.3
        for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 20:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763353403; x=1763958203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vabH7L+TSTAmE1zjFjJg+wRf7TU6eNQQ0e+/FIztP2w=;
        b=MES+n8GnHU/C9eXBNMeqoOXj8cmmc0lMugTe3x0+TJC8kuA5FSv0U4T+mMoXZUi+nB
         ZbdSDEiBSKJzIWetVhqvfkvQETGPI3UxTbIKFzy/uYFcNitY8B9WRyyNwq/dwvUjhw5/
         dhttZYX/fo+vBHzocfeZekD59QM8mxOl3hVa1sFZqVrQsdqQNua3OJqZTCJnUYMWtsTX
         ToQCn6qwZr1SMsYtF8BxKhhiMk0uWNWSJE+p+//9jhxkOQZjAz9fvwAeilRwDPufEODK
         sVxAK9V0xZ86GqcZY7D58bzbddEY+xfSfuL2GGAcoo+aZwu4i9LjdzMPsL7bE1ulSutA
         cisw==
X-Forwarded-Encrypted: i=1; AJvYcCX4UOIIduLtLizIWjqDpzgUVHEWL3ljeXnGKvhFusVOtE/YpT446SnvlCFrLyh1vlW9z4wl9Eo3Wq5IvRlA6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIrVlsgfqcvPxaiGc+RtH37JVUxYxr8SgA2GnoMURZ9EXaM8/K
	OyzTL4Qk1fYiTi5vKkGYNbF6qyGtQ6ioI8+WHWTfYV8vX0dDJozLiJ9IuxOKmn6w0O/O2J5B8FE
	pAMOMlwt/1FzET87rKGvLTDo7eAKZTHT1DJMALTTqehcvkroig1mhQ6qnVZXaKJDrowPacuxNoz
	mqV5e98zG8tHiq9LSa7IKdk+Rzgtc7Hu1/fVzdcr+FeJk=
X-Gm-Gg: ASbGncu1fPh81tZidNVTmOSYLCgu2aFjHfUw5pskNUDeuug3zKn/J61AMEDkHtOrijn
	WEmSJwKWZCQ90SIhtOr/tqJBKBCS63IUWBnI6aE/K27z1Wbk/WDuDw+Rh7Oe0AeDHFxkWLMfVGY
	3VB2LdE90TmCyHYkWB4Of8Ah2eVdSC6J/thGTSUENQoVMKdAuPoyN3OfTOivdq9dQ=
X-Received: by 2002:a17:90b:17cc:b0:340:cb39:74cd with SMTP id 98e67ed59e1d1-343fa74d17amr12009326a91.32.1763353403026;
        Sun, 16 Nov 2025 20:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRq+usT1l91eb7BjeYhZr5ZLAdevRrNfZYpOIk31ZpjtN0LtMy/9mFLkGhzMxInk8HRm8TmbME+PEHF194/B8=
X-Received: by 2002:a17:90b:17cc:b0:340:cb39:74cd with SMTP id
 98e67ed59e1d1-343fa74d17amr12009300a91.32.1763353402454; Sun, 16 Nov 2025
 20:23:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com> <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
In-Reply-To: <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Nov 2025 12:23:11 +0800
X-Gm-Features: AWmQ_bkp_0-LMGgjhKKbYp0CmmueqJN4W3zmnktxxGxt-R6ibRWckjowHwKbnPw
Message-ID: <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2bVByaPo-0VZisRU9kLB7ABA8DyxSWyL2iDToZDHthc_1763353403
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 7:25=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > Now that the driver can change ASID in the middle of operation, the
> > > domain that each vq address point is also protected by domain_lock.
> >
> > Maybe it's better to document what is protected by RCU and how.
> >
>
> I added the _rcu annotation but I can expand it for sure. I can also
> modify the commit message.
>
> > More below.
> >
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
>
> I forgot to remove this, my bad!
>
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v9:
> > > * Replace mutex with RCU, as the vdpa map_ops can run from atomic
> > >   context.
> > >
> > > v8:
> > > * Revert the mutex to rwlock change, it needs proper profiling to
> > >   justify it.
> > >
> > > v7:
> > > * Take write lock in the error path (Jason).
> > >
> > > v6:
> > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1)=
 ?/
> > >   (MST).
> > > * Fix struct name not matching in the doc.
> > >
> > > v5:
> > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET=
_FD
> > >   ioctl (Jason).
> > > * Properly set domain bounce size to divide equally between nas (Jaso=
n).
> > > * Exclude "padding" member from the only >V1 members in
> > >   vduse_dev_request.
> > >
> > > v4:
> > > * Divide each domain bounce size between the device bounce size (Jaso=
n).
> > > * revert unneeded addr =3D NULL assignment (Jason)
> > > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> > >   return; } (Jason)
> > > * Change a bad multiline comment, using @ caracter instead of * (Jaso=
n).
> > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > >
> > > v3:
> > > * Get the vduse domain through the vduse_as in the map functions
> > >   (Jason).
> > > * Squash with the patch creating the vduse_as struct (Jason).
> > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> > >   (Jason)
> > >
> > > v2:
> > > * Convert the use of mutex to rwlock.
> > >
> > > RFC v3:
> > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a low=
er
> > >   value to reduce memory consumption, but vqs are already limited to
> > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > >   VDUSE_IOTLB_GET_INFO.
> > > * Use of array_index_nospec in VDUSE device ioctls.
> > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > * Move the umem mutex to asid struct so there is no contention betwee=
n
> > >   ASIDs.
> > >
> > > RFC v2:
> > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> > >   part of the struct is the same.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 ++++++++++++++++++++-------=
--
> > >  include/uapi/linux/vduse.h         |  53 ++++-
> > >  2 files changed, 314 insertions(+), 109 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 97be04f73fbf..ff95ed56f22d 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -11,6 +11,7 @@
> > >  #include "linux/virtio_net.h"
> > >  #include <linux/init.h>
> > >  #include <linux/module.h>
> > > +#include <linux/rcupdate.h>
> > >  #include <linux/cdev.h>
> > >  #include <linux/device.h>
> > >  #include <linux/eventfd.h>
> > > @@ -41,6 +42,7 @@
> > >
> > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > +#define VDUSE_DEV_MAX_AS 0xffff
> > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > @@ -86,7 +88,14 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_as {
> > > +       struct vduse_iova_domain *domain;
> > > +       struct vduse_umem *umem;
> > > +       struct mutex mem_lock;
> > > +};
> > > +
> > >  struct vduse_vq_group {
> > > +       struct vduse_as *as __rcu;
> > >         struct vduse_dev *dev;
> > >  };
> > >
> > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_as *as;
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > -       struct vduse_umem *umem;
> > > +       u32 nas;
> > >         struct vduse_vq_group *groups;
> > > -       struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         struct mutex domain_lock;
> > >  };
> > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev =
*dev, u8 status)
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > >
> > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > >                                   u64 start, u64 last)
> > >  {
> > >         struct vduse_dev_msg msg =3D { 0 };
> > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_d=
ev *dev,
> > >                 return -EINVAL;
> > >
> > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > -       msg.req.iova.start =3D start;
> > > -       msg.req.iova.last =3D last;
> > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > +               msg.req.iova.start =3D start;
> > > +               msg.req.iova.last =3D last;
> > > +       } else {
> > > +               msg.req.iova_v2.start =3D start;
> > > +               msg.req.iova_v2.last =3D last;
> > > +               msg.req.iova_v2.asid =3D asid;
> > > +       }
> > >
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct file *fil=
e, poll_table *wait)
> > >         return mask;
> > >  }
> > >
> > > +/* Force set the asid to a vq group without a message to the VDUSE d=
evice */
> > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > +                                      unsigned int group, unsigned i=
nt asid)
> > > +{
> > > +       /*
> > > +        * Two concurrent updates to this pointer are valid as they c=
annot
> > > +        * point to an invalid region.  It is ok for them to race as =
long as
> > > +        * the readers see a consistent state through RCU.
> > > +        */
> > > +       rcu_assign_pointer(dev->groups[group].as, &dev->as[asid]);
> >
> > I'd expect at least a synchronize_rcu() here to wait for the read is do=
ne?
> >
>
> What's the use? The only thing left here is to return from
> vduse_set_group_asid_nomsg, and we don't need to wait for readers
> here, do we?

See below.

>
> > > +}
> > > +
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > >
> > >         /* The coherent mappings are handled in vduse_dev_free_cohere=
nt() */
> > > -       if (domain && domain->bounce_map)
> > > -               vduse_domain_reset_bounce_map(domain);
> > > +       for (i =3D 0; i < dev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D dev->as[i].domai=
n;
> > > +
> > > +               if (domain && domain->bounce_map)
> > > +                       vduse_domain_reset_bounce_map(domain);
> > > +       }
> > > +
> > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_map(struct =
vdpa_device *vdpa, u16 idx)
> > >         return ret;
> > >  }
> > >
> > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned i=
nt group,
> > > +                               unsigned int asid)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int r;
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > +               return -EINVAL;
> > > +
> > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > +       msg.req.vq_group_asid.group =3D group;
> > > +       msg.req.vq_group_asid.asid =3D asid;
> > > +
> > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > +       if (r < 0)
> > > +               return r;
> > > +
> > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > +       return 0;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
e *vdpa,
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         int ret;
> > >
> > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> > >         if (ret) {
> > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> > >                 return ret;
> > >         }
> > >
> > > @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > > @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for_device(un=
ion virtio_map token,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > >         struct vduse_dev *vdev;
> > > +       struct vduse_as *as;
> > >         struct vduse_iova_domain *domain;
> > >
> > >         if (!token.group)
> > >                 return;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       rcu_read_lock();
> > > +       as =3D rcu_dereference(token.group->as);
> > > +       domain =3D as->domain;
> > > +       rcu_read_unlock();
> > >         vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> >
> > This is suspicious, at least we should do rcu_read_unlock() after
> > vduse_domain_sync_single_for_device(), otherwise I don't see how RCU
> > works.
> >
>
> RCU is protecting that the address space pointer of the vq group is
> not modified concurrently with the access. Ideally, this should be a
> full lock, but just making sure that all accesses from the reader are
> coherent is enough. Userspace should expect nothing if it uses the map
> and modifies the vq group ASID at the same time anyway, but the kernel
> needs to be sure that it does not see intermediate states. TBH, we
> could move to a READ_ONCE / WRITE_ONCE, would that be more clear?

Using READ_ONCE/WRITE_ONCE() needs to make sure the ordering is
handled correctly.

But I meant what happens if

[cpu0]rcu_read_lock()
[cpu0]as =3D rcu_dereference(token.group->as)
[cpu0]...
[cpu0]rcu_read_unlock()
[cpu1]rcu_assign_pointer(token.group->as)
[cpu0]vduse_domain_sync_single_for_device()

If this is not an issue, RCU is not a must, but please explain why.
If this is an issue, we need to fix it.

It's basically a question that

1) should we need to wait for the DMA to be completed before assigning
to the new as
2) should we track the set_group_asid() for the group that has pending
DMA to avoid potential issue

>
> The function vduse_domain uses its own lock to protect concurrent
> access to the maps of the ASID itself, as they were needed before
> implementing ASID already.

Thanks

>
> > >  }
> > >
> > > @@ -868,14 +927,17 @@ static void vduse_dev_sync_single_for_cpu(union=
 virtio_map token,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > >         struct vduse_dev *vdev;
> > > +       struct vduse_as *as;
> > >         struct vduse_iova_domain *domain;
> > >
> > >         if (!token.group)
> > >                 return;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       rcu_read_lock();
> > > +       as =3D rcu_dereference(token.group->as);
> > > +       domain =3D as->domain;
> > > +       rcu_read_unlock();
> > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > >  }
> > >
> > > @@ -885,15 +947,21 @@ static dma_addr_t vduse_dev_map_page(union virt=
io_map token, struct page *page,
> > >                                      unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev;
> > > +       struct vduse_as *as;
> > >         struct vduse_iova_domain *domain;
> > > +       dma_addr_t r;
> > >
> > >         if (!token.group)
> > >                 return DMA_MAPPING_ERROR;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > +       rcu_read_lock();
> > > +       as =3D rcu_dereference(token.group->as);
> > > +       domain =3D as->domain;
> > > +       rcu_read_unlock();
> > > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, =
attrs);
> >
> > Same here.
> >
> > Thanks
> >
>

