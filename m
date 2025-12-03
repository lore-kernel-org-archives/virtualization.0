Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39522068F
	for <virtualization@lists.linux.dev>; Wed,  3 Dec 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764748703; cv=none; b=Z1pWpPdUr5W0eg10pJl/ZhdoqtxqP6K/zO/sIYgmEAczD100bKymDJtuQKbu1O74z4vzhSTChCHgZvMfJdvYpdwQk6XcMQXdxIWBPPzF3kmb9xE72NFhmy8EUCu0vowh0/5EuteKZVgdHfEtULqM+XeIA+nef2n3Qbq7KfRhZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764748703; c=relaxed/simple;
	bh=WcfZn25MaEqPLx1Tur7jJUCrAFfWT9hJX3mT8zARFQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiAw9Oos1cs1S9peSjNEGmbpjDHp/CWsCdCy/MAqAQG1/GvlShi7KA2qgD87/Wa3cDYf5nRm7EU/zjKryBze0QwLCTYvZowJ9alQeBIaLDp2VELpthIlYe3P4Qkwb4OZHpkzlXomVM2RmFq98FkX4RcL9DgXT9Q3fZcSA9BmkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlWTc1mq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlWTc1mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764748699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBG9Vod8UMIjlmnalZRyqVDH5LrVL9+1sNtkxEX1QpA=;
	b=GlWTc1mq10Y4ey+SlKVpfMFyBQDUn2Dawg1VC3xbiZoHfWpFMdWGmMhgT8SNOgMfxryztc
	UjmLVgrfoog/3bYcDG4uBDnmKriO/ghotipu2DcXiwvEwcwz5p4yNB4Oq5a5tvOgVdSJCf
	T24v4bU8rJBcRs5GZqY3CrVC6of2Nak=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-64ik0C3QP7-yux91ahEqbw-1; Wed, 03 Dec 2025 02:58:18 -0500
X-MC-Unique: 64ik0C3QP7-yux91ahEqbw-1
X-Mimecast-MFC-AGG-ID: 64ik0C3QP7-yux91ahEqbw_1764748698
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-787fdf1b574so71556197b3.1
        for <virtualization@lists.linux.dev>; Tue, 02 Dec 2025 23:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764748697; x=1765353497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EBG9Vod8UMIjlmnalZRyqVDH5LrVL9+1sNtkxEX1QpA=;
        b=iJ72HThDbEK6+RMAOiMdWw+73pGUJCdEmweYEmbEa4P90nj1YBeE+H1rlANn2d7R0A
         Qh85Mmy1Tm0cWs2gVmX/XaP5u7B2KxjnEFtv4Y37fOB9V+5NXOeEEaNpCgYVukfQBmm6
         KdH7wGXsI19wIjHfIFW/isNABF93EKsTkF8UXyGJywtxFM8OKE1dIi16ykimMvgZgyQO
         eLNifMggH6qmoTxyNPkzNxkOi01KjraK9HJy+rVWVQoB/x++U7H5IvM0aEkTTF+Orv+h
         7O4TZ3ODvMDbRVH9PJSBIZAyn/MpKuqvYxIf1Z903/t5lPeyMrXk2XuZm0GIXoEm6wvf
         C/qw==
X-Forwarded-Encrypted: i=1; AJvYcCXS9NTyf9BeVYtTem/Z49S/uegiQtmGU9H7utJnsqZ6kxVP6pRUBok5TYxfZNlDGMaKWQztvQ+diqsdOCZnxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsly51CxHC/RihBSzv4eLgVDpgG1wPcv3yD2suYg97bIxD4bWa
	/34t/Oi83T7Dp9JIT1jNuQ25tikTVy8kvT1HMIumUnoSBZBqmUWtOlp3BmfGUzNMStk/vsGfeIK
	+9vA2OPtrDocYw1IUX9HI4TcMXv42bQkI3kdtNAKWpLtg00zfXGQu7BA8ouvRPeX5psuxyckH+f
	AKB+8WyD27R6a8t984aZU430ZVRSckhzuiSD+fXk92vuc=
X-Gm-Gg: ASbGncvVjQGISrlEEs/C3PVa7khK+2sbg/TbUrvrtfZQth/l2c7HaidfaWeSfQd9AsA
	wD/Q5EStm6mffXvL1sEhV7zZY9AS+wuLruXWjwUGvU2nD4yT3ukv9Z3mFJffa3QEbqMQsaDxUQE
	GzpbF7DthmZOxrI6lDVWcibX9gbZ7A0u7bIcUvPipiM+90QDMzvhHgGca5BbK2UoEGqGU=
X-Received: by 2002:a05:690c:4908:b0:786:56ec:e3c6 with SMTP id 00721157ae682-78c0c05cb1bmr12364607b3.55.1764748697329;
        Tue, 02 Dec 2025 23:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhFouLAME5ejSGqcbJUxdQffHGGdgDkARZJukkkgKyph9DLCoJ3Bk4HCeweiADiJh5y8vsoxvo9LqJvCpd/Mo=
X-Received: by 2002:a05:690c:4908:b0:786:56ec:e3c6 with SMTP id
 00721157ae682-78c0c05cb1bmr12364337b3.55.1764748696748; Tue, 02 Dec 2025
 23:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
 <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com>
 <CAJaqyWdgGmnaQ3=j-6S9E4mfPSHc872FQZfVna_eX_UnipX2UA@mail.gmail.com>
 <CACGkMEuzAo2jRgUwkxhM=bgS4a4NvpP6BYZB1zed00C6J8eiyg@mail.gmail.com>
 <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com> <CACGkMEtMyte91bbdb0hfUo+YgSpZdjoWe0meKwbDc18CfWdATA@mail.gmail.com>
In-Reply-To: <CACGkMEtMyte91bbdb0hfUo+YgSpZdjoWe0meKwbDc18CfWdATA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Dec 2025 08:57:40 +0100
X-Gm-Features: AWmQ_bmWcr37KyXRhIeQ8mm8o6WRDDScouW_nvT5-8M0RQLFIqUAU6VVe8_Imv8
Message-ID: <CAJaqyWfsuSobzdr522NvXHAZmczFvOB4vBUAfeOjfnz6GewP1A@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: en1U7rVt4prTuO0BGmf3HAuDZScnn6Jl_WCIENEyae0_1764748698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:38=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Nov 19, 2025 at 5:27=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Nov 19, 2025 at 3:39=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 8:16=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Mon, Nov 17, 2025 at 5:23=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Fri, Nov 14, 2025 at 7:25=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=A9rez <e=
perezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Add support for assigning Address Space Identifiers (ASIDs)=
 to each VQ
> > > > > > > > group.  This enables mapping each group into a distinct mem=
ory space.
> > > > > > > >
> > > > > > > > Now that the driver can change ASID in the middle of operat=
ion, the
> > > > > > > > domain that each vq address point is also protected by doma=
in_lock.
> > > > > > >
> > > > > > > Maybe it's better to document what is protected by RCU and ho=
w.
> > > > > > >
> > > > > >
> > > > > > I added the _rcu annotation but I can expand it for sure. I can=
 also
> > > > > > modify the commit message.
> > > > > >
> > > > > > > More below.
> > > > > > >
> > > > > > > >
> > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > > I forgot to remove this, my bad!
> > > > > >
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > ---
> > > > > > > > v9:
> > > > > > > > * Replace mutex with RCU, as the vdpa map_ops can run from =
atomic
> > > > > > > >   context.
> > > > > > > >
> > > > > > > > v8:
> > > > > > > > * Revert the mutex to rwlock change, it needs proper profil=
ing to
> > > > > > > >   justify it.
> > > > > > > >
> > > > > > > > v7:
> > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > >
> > > > > > > > v6:
> > > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_=
VERSION_1) ?/
> > > > > > > >   (MST).
> > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > >
> > > > > > > > v5:
> > > > > > > > * Properly return errno if copy_to_user returns >0 in VDUSE=
_IOTLB_GET_FD
> > > > > > > >   ioctl (Jason).
> > > > > > > > * Properly set domain bounce size to divide equally between=
 nas (Jason).
> > > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > > >   vduse_dev_request.
> > > > > > > >
> > > > > > > > v4:
> > > > > > > > * Divide each domain bounce size between the device bounce =
size (Jason).
> > > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) retur=
n; if (z)
> > > > > > > >   return; } (Jason)
> > > > > > > > * Change a bad multiline comment, using @ caracter instead =
of * (Jason).
> > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > > >
> > > > > > > > v3:
> > > > > > > > * Get the vduse domain through the vduse_as in the map func=
tions
> > > > > > > >   (Jason).
> > > > > > > > * Squash with the patch creating the vduse_as struct (Jason=
).
> > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a mag=
ic number
> > > > > > > >   (Jason)
> > > > > > > >
> > > > > > > > v2:
> > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > >
> > > > > > > > RFC v3:
> > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was se=
t to a lower
> > > > > > > >   value to reduce memory consumption, but vqs are already l=
imited to
> > > > > > > >   that value and userspace VDUSE is able to allocate that m=
any vqs.
> > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > > * Move the umem mutex to asid struct so there is no content=
ion between
> > > > > > > >   ASIDs.
> > > > > > > >
> > > > > > > > RFC v2:
> > > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so =
the first
> > > > > > > >   part of the struct is the same.
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 +++++++++++++++++=
+++---------
> > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > >  2 files changed, 314 insertions(+), 109 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index 97be04f73fbf..ff95ed56f22d 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -11,6 +11,7 @@
> > > > > > > >  #include "linux/virtio_net.h"
> > > > > > > >  #include <linux/init.h>
> > > > > > > >  #include <linux/module.h>
> > > > > > > > +#include <linux/rcupdate.h>
> > > > > > > >  #include <linux/cdev.h>
> > > > > > > >  #include <linux/device.h>
> > > > > > > >  #include <linux/eventfd.h>
> > > > > > > > @@ -41,6 +42,7 @@
> > > > > > > >
> > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > @@ -86,7 +88,14 @@ struct vduse_umem {
> > > > > > > >         struct mm_struct *mm;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +struct vduse_as {
> > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > +       struct mutex mem_lock;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > >  struct vduse_vq_group {
> > > > > > > > +       struct vduse_as *as __rcu;
> > > > > > > >         struct vduse_dev *dev;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > >         struct device *dev;
> > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > +       struct vduse_as *as;
> > > > > > > >         char *name;
> > > > > > > >         struct mutex lock;
> > > > > > > >         spinlock_t msg_lock;
> > > > > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > > > > >         u32 vq_num;
> > > > > > > >         u32 vq_align;
> > > > > > > >         u32 ngroups;
> > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > +       u32 nas;
> > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > -       struct mutex mem_lock;
> > > > > > > >         unsigned int bounce_size;
> > > > > > > >         struct mutex domain_lock;
> > > > > > > >  };
> > > > > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct =
vduse_dev *dev, u8 status)
> > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u=
32 asid,
> > > > > > > >                                   u64 start, u64 last)
> > > > > > > >  {
> > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(stru=
ct vduse_dev *dev,
> > > > > > > >                 return -EINVAL;
> > > > > > > >
> > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > +       } else {
> > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > +       }
> > > > > > > >
> > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > >  }
> > > > > > > > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct=
 file *file, poll_table *wait)
> > > > > > > >         return mask;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +/* Force set the asid to a vq group without a message to t=
he VDUSE device */
> > > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *d=
ev,
> > > > > > > > +                                      unsigned int group, =
unsigned int asid)
> > > > > > > > +{
> > > > > > > > +       /*
> > > > > > > > +        * Two concurrent updates to this pointer are valid=
 as they cannot
> > > > > > > > +        * point to an invalid region.  It is ok for them t=
o race as long as
> > > > > > > > +        * the readers see a consistent state through RCU.
> > > > > > > > +        */
> > > > > > > > +       rcu_assign_pointer(dev->groups[group].as, &dev->as[=
asid]);
> > > > > > >
> > > > > > > I'd expect at least a synchronize_rcu() here to wait for the =
read is done?
> > > > > > >
> > > > > >
> > > > > > What's the use? The only thing left here is to return from
> > > > > > vduse_set_group_asid_nomsg, and we don't need to wait for reade=
rs
> > > > > > here, do we?
> > > > >
> > > > > See below.
> > > > >
> > > > > >
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > > >  {
> > > > > > > >         int i;
> > > > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > > > >
> > > > > > > >         /* The coherent mappings are handled in vduse_dev_f=
ree_coherent() */
> > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > +               struct vduse_iova_domain *domain =3D dev->a=
s[i].domain;
> > > > > > > > +
> > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > +                       vduse_domain_reset_bounce_map(domai=
n);
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > > > >
> > > > > > > >         down_write(&dev->rwsem);
> > > > > > > >
> > > > > > > > @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_m=
ap(struct vdpa_device *vdpa, u16 idx)
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, =
unsigned int group,
> > > > > > > > +                               unsigned int asid)
> > > > > > > > +{
> > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > +       int r;
> > > > > > > > +
> > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > > > > > +               return -EINVAL;
> > > > > > > > +
> > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > +
> > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > +       if (r < 0)
> > > > > > > > +               return r;
> > > > > > > > +
> > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdp=
a, u16 idx,
> > > > > > > >                                 struct vdpa_vq_state *state=
)
> > > > > > > >  {
> > > > > > > > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct =
vdpa_device *vdpa,
> > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > >         int ret;
> > > > > > > >
> > > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, =
iotlb);
> > > > > > > >         if (ret)
> > > > > > > >                 return ret;
> > > > > > > >
> > > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MA=
X);
> > > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULL=
ONG_MAX);
> > > > > > > >         if (ret) {
> > > > > > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > > > > > +               vduse_domain_clear_map(dev->as[asid].domain=
, iotlb);
> > > > > > > >                 return ret;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vdu=
se_vdpa_config_ops =3D {
> > > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affin=
ity,
> > > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > > >  };
> > > > > > > > @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for=
_device(union virtio_map token,
> > > > > > > >                                              enum dma_data_=
direction dir)
> > > > > > > >  {
> > > > > > > >         struct vduse_dev *vdev;
> > > > > > > > +       struct vduse_as *as;
> > > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > >
> > > > > > > >         if (!token.group)
> > > > > > > >                 return;
> > > > > > > >
> > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > -
> > > > > > > > +       rcu_read_lock();
> > > > > > > > +       as =3D rcu_dereference(token.group->as);
> > > > > > > > +       domain =3D as->domain;
> > > > > > > > +       rcu_read_unlock();
> > > > > > > >         vduse_domain_sync_single_for_device(domain, dma_add=
r, size, dir);
> > > > > > >
> > > > > > > This is suspicious, at least we should do rcu_read_unlock() a=
fter
> > > > > > > vduse_domain_sync_single_for_device(), otherwise I don't see =
how RCU
> > > > > > > works.
> > > > > > >
> > > > > >
> > > > > > RCU is protecting that the address space pointer of the vq grou=
p is
> > > > > > not modified concurrently with the access. Ideally, this should=
 be a
> > > > > > full lock, but just making sure that all accesses from the read=
er are
> > > > > > coherent is enough. Userspace should expect nothing if it uses =
the map
> > > > > > and modifies the vq group ASID at the same time anyway, but the=
 kernel
> > > > > > needs to be sure that it does not see intermediate states. TBH,=
 we
> > > > > > could move to a READ_ONCE / WRITE_ONCE, would that be more clea=
r?
> > > > >
> > > > > Using READ_ONCE/WRITE_ONCE() needs to make sure the ordering is
> > > > > handled correctly.
> > > > >
> > > > > But I meant what happens if
> > > > >
> > > > > [cpu0]rcu_read_lock()
> > > > > [cpu0]as =3D rcu_dereference(token.group->as)
> > > > > [cpu0]...
> > > > > [cpu0]rcu_read_unlock()
> > > > > [cpu1]rcu_assign_pointer(token.group->as)
> > > > > [cpu0]vduse_domain_sync_single_for_device()
> > > > >
> > > >
> > > > That should go ok. What I'm trying to protect here is the iteration=
s
> > > > in vduse_domain_sync_single_for_device -> vduse_domain_bounce.
> > > >
> > > > I'm going to embed that function here in
> > > > vduse_dev_sync_single_for_device and omit RCU and some details to m=
ake
> > > > the point easier:
> > > >
> > > > vduse_dev_sync_single_for_device(union virtio_map token, dma_addr_t
> > > > iova, size_t size, ...) {
> > > >   read_lock(&token.group->as->domain);
> > > >   while (size)
> > > >     map =3D token.group->as->domain->bounce_maps[iova];
> > > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > > >
> > > >     ...
> > > >     page =3D token_group->as->domain->bounce_maps
> > > >     addr =3D kmap_local_page(page);
> > > >     do_bounce(map->orig_phys, addr, sz, dir);
> > > >     kunmap_local(addr);
> > > >     size -=3D sz;
> > > >     iova +=3D sz;
> > > >   }
> > > >   read_unlock(&token.group->as->domain);
> > > > }
> > >
> > > Right, so I meant for rwlock like semantic (let's forget the sleeping=
 here).
> > >
> > > vduse_set_group_asid_nomsg() should use "write lock" so it must wait
> > > for the "read lock" to be done.
> >
> > No, it doesn't need to wait as long as the reader part uses its own cop=
y.
>
> It probably won't crash but I meant if we have logic issues. For
> example, once set_group_asid() return, there should still be a pending
> DMA that is using the old as.
>
> >
> > > But this is not the logic that is
> > > implemented in this patch as there's no synchronize_rcu() in the
> > > vduse_set_group_asid_nomsg().
> >
> > We only set the pointer on the writer's side, we do nothing like
> > freeing resources. Should we set the pointer before or after
> > syncrhonize_rcu()? What do we need to do on the other side of
> > syncrhonize_rcu()?
>
> Usually we don't need special care on the read side. But as discussed,
> synchronize_rcu() is not a must but we need to explain why it is safe
> and I'm not sure Michael is fine with that.
> If we just want to make sure the order of publish and read, we can
> switch to use smp_store_release() and smp_load_acqurie().
>
> >
> > > We need to explain why set_group_asid()
> > > doesn't need to wait and if this is true, we probably don't need RCU
> > > but to make sure the load/store is atomic.
> > >
> >
> > What about:
> >
> > * It does not matter if other thread modify group->as as long as the
> > reader uses the same as for all its operation. It performs a local
> > copy for that reason.
> > * It does not matter if multiple threads modify group->as as long as
> > the update is atomic.
>
> See above reply.
>
> >
> > ?
> >
> > > >
> > > > Now, depending on the point where another execution thread changes
> > > > token_group->as and how the compiler has chosen to generate the
> > > > machine code, the outcome could be:
> > > > 1) The domain read lock of one ASID is taken but the domain lock of
> > > > another as is unlocked.
> > > > 2) We iterate until iova is ok for the ASID we're handling, but not
> > > > for the other one. So we access an invalid offset in
> > > > bounce_maps[iova].
> > > >
> > > > And I guess there are other possible outcomes too.
> > > >
> > > > So I need to make sure that the pointer accesses in all
> > > > vduse_domain_bounce is coherent.
> > >
> > > I'm not sure I got here, but it looks like it accepts a domain
> > > parameter and is protected by the bounce lock so we are probably fine
> > > here?
> > >
> >
> > The bounce lock only protects the iotlb tree, not the pointer to that
> > iotlb tree.
> >
> > > > I'm ok if it takes the one before the
> > > > concurrent call to vduse_set_group_asid_nomsg or the one after that=
,
> > > > as the lifetime of all domains are bound to the device. But it cann=
ot
> > > > change in the middle of the operation:
> > > >
> > > > vduse_dev_sync_single_for_device(union virtio_map token, dma_addr_t
> > > > iova, size_t size, ...) {
> > > >   as =3D token.group->as;
> > > >   // Tell the compiler to never replace "as" by "token.group->as" a=
fter this.
> > > >   read_lock(&as->domain);
> > > >   while (size)
> > > >     map =3D as->domain->bounce_maps[iova];
> > > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > > >
> > > >     ...
> > > >     page =3D as->domain->bounce_maps
> > > >     addr =3D kmap_local_page(page);
> > > >     do_bounce(map->orig_phys, addr, sz, dir);
> > > >     kunmap_local(addr);
> > > >     size -=3D sz;
> > > >     iova +=3D sz;
> > > >   }
> > > >   read_unlock(&as->domain);
> > > > }
> > > >
> > > > That can be done in many ways. Probably the read_lock is already
> > > > enough but it is not explicit that it is protecting token.group->as=
,
> > > > and future changes could remove it. To me, RCU is the most clear wa=
y
> > > > to do it, but even a volatile read (READ_ONCE?) would do.
> > >
> > > I wonder if another group rwlock is sufficient here:
> > >
> > > for set_group_as_id()
> > >
> > > write_lock(&dev->groups[group].lock);
> > > dev->groups[group].as =3D &dev->as[asid];
> > > write_unlock(&dev->groups[group].lock);
> > >
> > > for the case where we need defer as
> > >
> > > read_lock(&dev->groups[group].lock);
> > > as =3D dev->groups[group].as;
> > > //using as
> > > read_unlock(&dev->groups[group].lock);
> > >
> > > If this works, we don't need to bother with thinking if the
> > > wait/synchronizre_rcu() is really needed or not?
> > >
> >
> > A rwlock is sufficient but we need to modify the allocation code
> > somehow. Also, I thought we wanted to avoid the overhead of taking the
> > read lock in the DMA ops too.
>
> Right, but it would always be a balance. We can make sure it works
> correctly first then do optimization on top.
>
> >
> > Another disadvantage of the lock vs RCU or READ_ONCE is that the vq
> > group ASID change needs to wait for the DMA operation to finish
> > instead of just applying for the next DMA ops. Not like vq group ASID
> > change would be in the hot path anyway, just pointing it out.
> >
> > > >
> > > > > If this is not an issue, RCU is not a must, but please explain wh=
y.
> > > > > If this is an issue, we need to fix it.
> > > > >
> > > > > It's basically a question that
> > > > >
> > > > > 1) should we need to wait for the DMA to be completed before assi=
gning
> > > > > to the new as
> > > >
> > > > I don't think so, it is valid to assign a new as and let the ongoin=
g
> > > > operation to continue. It is racy and the operation could fail, but
> > > > the kernel just returns an error and doesn't access invalid memory =
or
> > > > similar.
> > >
> > > See below.
> > >
> > > >
> > > > > 2) should we track the set_group_asid() for the group that has pe=
nding
> > > > > DMA to avoid potential issue
> > > > >
> > > >
> > > > No, the group will outlive the operation as it is bound to the devi=
ce.
> > >
> > > I meant e.g the DMA could be triggered by the device. For example, th=
e
> > > device may try to trigger an interrupt when the kernel is trying to
> > > assign a new asid. So I wonder if guest can use this to poke Qemu's
> > > memory etc.
> >
> > I'm not sure I get this point. If QEMU changes the ASID of the vq
> > group sent to the guest the race does not matter anymore: it is
> > explicitly opening the possibility from the guest to poke QEMU's
> > memory unless the guest is totally paused.
>
> Basically what I meant, assuming group0.as =3D as0
>
> cpu0] dma_map(group0.as, addr, DMA_FROM_DEVICE)
> cpu1] set_group_asid(group0.as, as1)
> cpu0] dma_unmap(group0.as, addr, DMA_FROM_DEVICE)
>
> cpu0 may read as1 while it wants as0 actually?
>

Yes, kind of. That's my point: adding synchronization at vduse level
does not fix it.

There is no way to do that call from vhost/vdpa or userland, as there
is no way to get the AS of a vq group, only to set it. The closest
thing is to add a cache at that level, but that implies to add
mutithreading sync on that upper layer, either vhost/vdpa or userland,
not in VDUSE.

From vhost/vdpa level, all mapping calls (.set_map, .dma_map,
.dma_unmap) calls take the ASID directly, not the vq group. So the
call to set_group_asid does not need to access the vq group.

Now let's say that we add that vdpa_ops callback (and ioctls) that
maps and unmap based on a vq_group. And all of the operations
(dma_map, set_group_asid, and dma_unmap) are serialized by taking the
same mutex. cpu0 still may dma_unmap over as0 if set_group_asid is not
properly serialized at vhost/vdpa or userland level:

void* thread0_func(void* arg) {
struct {
        int vq_group =3D 0,
        int iova, size, perm, ...
    } s;
    int fd =3D (intptr_t)arg;

    ioctl(fd, VHOST_VDPA_VQ_GROUP_DMA_MAP, &s);
    // TODO: Signal thread0 that it can proceed with SET_GROUP_ASID
    // TODO: Wait until thread0 complete SET_GROUP_ASID

    ioctl(fd, VHOST_VDPA_VQ_GROUP_DMA_UNMAP, &data);

    return NULL;
}

void* thread1_func(void* arg) {
    struct vhost_vring_state s =3D {
        .index =3D 0,
        .num =3D 1,
    };
    int fd =3D (int)(intptr_t)arg;

    // TODO: Wait until thread2 calls dma_map
    ioctl(fd, VHOST_VDPA_SET_GROUP_ASID, &s)
    // TODO: Signal thread2 that can proceed with dma_unmap

    return NULL;
}

int main() {
    pthread_t thread0, thread1;
    int fd =3D open("/dev/vhost-vdpa-0", ...)

    pthread_create(&thread0, NULL, thread0_func, (void *)(intptr_t)fd);
    pthread_create(&thread1, NULL, thread1_func, (void *)(intptr_t)fd);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    return EXIT_SUCCESS;
}
---

We need something to synchronize at userland level here, filling the TODOs.

We can replace the hypothetical VHOST_VDPA_VQ_GROUP_DMA_MAP and _UNMAP
with access to vqs, and the result is the same: The userland
application is the one that needs to serialize the access from thread0
if it wants predictive outcome against the accesses from thread1.
There is no way to do it at vduse level.

We need some syncrhonization to avoid malicious or buggy userland to
mess things, that's for sure. So DMA_MAP and DMA_UNMAP does not half
update the iotlb tree. And I'll send the next version with rwlock,
protecting as much as possible. But I want to make clear that it will
not avoid the race you describe here.

> >
> > > But if you mean we depend on the IOTLB to guard against
> > > this, I'm fine, but let's document why we don't need it and how the
> > > IOTLB layer can help to eliminate such risk.
> > >
> >
> > No, I'm not happy about letting iotlb lock to protect this too as
> > they're at different levels actually: One is protecting iotlb trees
> > modifications while they're being read and the other is protecting the
> > ASID assignment to different vq groups. To reuse them means a
> > modification in any tree blocks the change of vq group ASID, for
> > example.
> >
> > > Anyhow, tracking and failing seems to be more robust.
> >
> > I'm not sure I get this. If a DMA read starts in one ASID and then
> > QEMU changes the ASID of the vq group, do you prefer it to fail rather
> > than continue reading from the original ASID?
>
> If possible, it would be better.
>

It's hard for me to think in some way that does not add a lot of
overhead or it is very complex. But it is good to know this is
acceptable.

> > It seems hard to
> > communicate that the ASID has changed to the DMA operation callback.
>
> Maybe we can encode this into iova.
>

I'm adding the full rwlock, but can you expand on your idea on this?
It would be great to have it documented in case we need future
optimizations.

