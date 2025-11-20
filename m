Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181B78F4A
	for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763602686; cv=none; b=gXc+0hb3Xwu+1zbLJ+NTe+c3ug4uC/Ta21tEIK0FDjDyOMLcfUEQeya8HSdYwAQBu0M3SdiSIz1ZNtCA9tZrC+urbqxrGvv/TBF60V+aRlWFsNVoHg8hheOW1nfpwhJCTXwZlWVfdRLsgaNC8e1vnUbpleUCwzplk1fd9lreTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763602686; c=relaxed/simple;
	bh=/9UJ9tRvUF4j9OsNlIwOsIt/ZgBJKMKP5YtMRbDZbyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSZBlghybCVx2E6Z6BFDyQf6kmi1SyQy3EIEheePM4p3d2waDh94uib9McwLZt72msIPuZGH9AeUt7jMlxVwEcFQP38bSFlo7/VOksm2Sq7EUN9DBgpub9gxzLgjOvuGaCiPL5j1YQig+ypNDwAgSvjBSl2qBWqDODqFU6MS0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWdZ2jz8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWdZ2jz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763602681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ9XJMHCgOlsbxJOOagLpFMjwiGOoix6XjB7CUGBLrk=;
	b=SWdZ2jz8B2DhZ6RVJ54AwqIFETziqbfLCsgBEEmTdl/LNxQMnJsvvp6Ifw/v8KpO7h6JbL
	xWbquzp9PJqaqCfpwKlRJDeZGRch1C3NuMwep/sxydjiUk3pPB/Jg84yQj/VpJB771nxgl
	mG7xDeB3KeoUOVVFKnYlC3xxGFxekEQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-oVOT23GnMpi8vMILMWlxQw-1; Wed, 19 Nov 2025 20:37:59 -0500
X-MC-Unique: oVOT23GnMpi8vMILMWlxQw-1
X-Mimecast-MFC-AGG-ID: oVOT23GnMpi8vMILMWlxQw_1763602679
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3437b43eec4so454215a91.3
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 17:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763602678; x=1764207478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJ9XJMHCgOlsbxJOOagLpFMjwiGOoix6XjB7CUGBLrk=;
        b=bGZSe5kj3d9WGiYKIvwEjVezHX6/9S2HIzCkx3tOp8JjSwkBPDi98nQAl/NBHTaIQm
         g6vS6zSqgSdgZhcdQ1QoPEd8bsijncNTt23vCpPkExLCK6P/BcCvf/WwHrQNwJ/FNpsE
         r5+TzE0UumqIhRrdw0/PvGOnzLuorCWX0xrRbSa57wQPyiv0Iy1Ry0fTPSJ8/hirXytZ
         +N1PEk0e/Fm3say1j7C/WGWRWsDS5V5tBJnsXoR77wPLsNHs4aL9jIMRGCkJMfy9JwvK
         Ofa5ks/fPCf6rH/xrdetfXDJv851qZXaB5HT6ZgEehB+tsUSEC6ESkkGXGV0pkkM2Sk7
         MhZA==
X-Forwarded-Encrypted: i=1; AJvYcCXjIyVfSU7pux7AKX5FolGd6YVTrXSGYfuUItNj2Tk4XSFGWUBm29bQ5q2x7dQNJEdhn2qwCmZvKHYF/87fWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywvlx+CjabYrR9MkZ2JkPgMlwboGFvAzwiWHT5JFGNF5VR0rD4X
	nv3+t7V0WKk3u/J+SB8FYt2uK2ZenJKOOniSWBK1vTTk2Ce36dgAxlf1KDXzavNeG+HYBmm4IVb
	NA4vsA2Ylg6mUqWnSfJ23oRZt4jaJOMNnRGz/CYg5vKzk2lIeqaxBxM7/tMFyeiBCjVzG+zI9mM
	0HG0kI1Z6M9NFXhGzKHLtclUs6f753a6kNYR3QpBM1jQQ=
X-Gm-Gg: ASbGncuvFy+07CRBATV+F7UHpBfMdheHkLgOW0iMMxDJEJ6xJWDDLIOfv7mAfMcu8j1
	w5HREC1a7CDpTJK/wOPJBN3YcXcpJTU5DT2ODPrhj3wjw8RQnmz5UuYF6L0H9HjOvKgsIAevawU
	6nCbRfzeq8Q/GkG12JdGsVq67X4okyVqwS0rQ3lePisw0wqsBcMrDEBG3v0lMOU9k=
X-Received: by 2002:a17:90b:5343:b0:341:8ac7:24d3 with SMTP id 98e67ed59e1d1-3472854a1camr1137019a91.34.1763602678322;
        Wed, 19 Nov 2025 17:37:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTQCLgnYdurHGnJMphcAFEpClk32lz64nyjGvg4isLXL7ggEwL1B8zy6poXo65bgrB9FoU5J9231nlJdzcx44=
X-Received: by 2002:a17:90b:5343:b0:341:8ac7:24d3 with SMTP id
 98e67ed59e1d1-3472854a1camr1137000a91.34.1763602677744; Wed, 19 Nov 2025
 17:37:57 -0800 (PST)
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
 <CACGkMEuzAo2jRgUwkxhM=bgS4a4NvpP6BYZB1zed00C6J8eiyg@mail.gmail.com> <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com>
In-Reply-To: <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Nov 2025 09:37:43 +0800
X-Gm-Features: AWmQ_bnPUphiGrYxui5NAVqllY5_EbgILtVJj4TZ4suFMy9-WmWdZ_el96E52dg
Message-ID: <CACGkMEtMyte91bbdb0hfUo+YgSpZdjoWe0meKwbDc18CfWdATA@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qkY0sApR3M0Xf66TXlPtjGAEXk9eLN12SyHVuuRWjC8_1763602679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 5:27=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Nov 19, 2025 at 3:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Nov 17, 2025 at 8:16=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 5:23=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Fri, Nov 14, 2025 at 7:25=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > Add support for assigning Address Space Identifiers (ASIDs) t=
o each VQ
> > > > > > > group.  This enables mapping each group into a distinct memor=
y space.
> > > > > > >
> > > > > > > Now that the driver can change ASID in the middle of operatio=
n, the
> > > > > > > domain that each vq address point is also protected by domain=
_lock.
> > > > > >
> > > > > > Maybe it's better to document what is protected by RCU and how.
> > > > > >
> > > > >
> > > > > I added the _rcu annotation but I can expand it for sure. I can a=
lso
> > > > > modify the commit message.
> > > > >
> > > > > > More below.
> > > > > >
> > > > > > >
> > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > I forgot to remove this, my bad!
> > > > >
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > > v9:
> > > > > > > * Replace mutex with RCU, as the vdpa map_ops can run from at=
omic
> > > > > > >   context.
> > > > > > >
> > > > > > > v8:
> > > > > > > * Revert the mutex to rwlock change, it needs proper profilin=
g to
> > > > > > >   justify it.
> > > > > > >
> > > > > > > v7:
> > > > > > > * Take write lock in the error path (Jason).
> > > > > > >
> > > > > > > v6:
> > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VE=
RSION_1) ?/
> > > > > > >   (MST).
> > > > > > > * Fix struct name not matching in the doc.
> > > > > > >
> > > > > > > v5:
> > > > > > > * Properly return errno if copy_to_user returns >0 in VDUSE_I=
OTLB_GET_FD
> > > > > > >   ioctl (Jason).
> > > > > > > * Properly set domain bounce size to divide equally between n=
as (Jason).
> > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > >   vduse_dev_request.
> > > > > > >
> > > > > > > v4:
> > > > > > > * Divide each domain bounce size between the device bounce si=
ze (Jason).
> > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) return;=
 if (z)
> > > > > > >   return; } (Jason)
> > > > > > > * Change a bad multiline comment, using @ caracter instead of=
 * (Jason).
> > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > >
> > > > > > > v3:
> > > > > > > * Get the vduse domain through the vduse_as in the map functi=
ons
> > > > > > >   (Jason).
> > > > > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic=
 number
> > > > > > >   (Jason)
> > > > > > >
> > > > > > > v2:
> > > > > > > * Convert the use of mutex to rwlock.
> > > > > > >
> > > > > > > RFC v3:
> > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set =
to a lower
> > > > > > >   value to reduce memory consumption, but vqs are already lim=
ited to
> > > > > > >   that value and userspace VDUSE is able to allocate that man=
y vqs.
> > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > * Move the umem mutex to asid struct so there is no contentio=
n between
> > > > > > >   ASIDs.
> > > > > > >
> > > > > > > RFC v2:
> > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so th=
e first
> > > > > > >   part of the struct is the same.
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 +++++++++++++++++++=
+---------
> > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > >  2 files changed, 314 insertions(+), 109 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index 97be04f73fbf..ff95ed56f22d 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -11,6 +11,7 @@
> > > > > > >  #include "linux/virtio_net.h"
> > > > > > >  #include <linux/init.h>
> > > > > > >  #include <linux/module.h>
> > > > > > > +#include <linux/rcupdate.h>
> > > > > > >  #include <linux/cdev.h>
> > > > > > >  #include <linux/device.h>
> > > > > > >  #include <linux/eventfd.h>
> > > > > > > @@ -41,6 +42,7 @@
> > > > > > >
> > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > @@ -86,7 +88,14 @@ struct vduse_umem {
> > > > > > >         struct mm_struct *mm;
> > > > > > >  };
> > > > > > >
> > > > > > > +struct vduse_as {
> > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > +       struct vduse_umem *umem;
> > > > > > > +       struct mutex mem_lock;
> > > > > > > +};
> > > > > > > +
> > > > > > >  struct vduse_vq_group {
> > > > > > > +       struct vduse_as *as __rcu;
> > > > > > >         struct vduse_dev *dev;
> > > > > > >  };
> > > > > > >
> > > > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > > > >         struct vduse_vdpa *vdev;
> > > > > > >         struct device *dev;
> > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > +       struct vduse_as *as;
> > > > > > >         char *name;
> > > > > > >         struct mutex lock;
> > > > > > >         spinlock_t msg_lock;
> > > > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > > > >         u32 vq_num;
> > > > > > >         u32 vq_align;
> > > > > > >         u32 ngroups;
> > > > > > > -       struct vduse_umem *umem;
> > > > > > > +       u32 nas;
> > > > > > >         struct vduse_vq_group *groups;
> > > > > > > -       struct mutex mem_lock;
> > > > > > >         unsigned int bounce_size;
> > > > > > >         struct mutex domain_lock;
> > > > > > >  };
> > > > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vd=
use_dev *dev, u8 status)
> > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > >  }
> > > > > > >
> > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32=
 asid,
> > > > > > >                                   u64 start, u64 last)
> > > > > > >  {
> > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct=
 vduse_dev *dev,
> > > > > > >                 return -EINVAL;
> > > > > > >
> > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > +       } else {
> > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > +       }
> > > > > > >
> > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > >  }
> > > > > > > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct f=
ile *file, poll_table *wait)
> > > > > > >         return mask;
> > > > > > >  }
> > > > > > >
> > > > > > > +/* Force set the asid to a vq group without a message to the=
 VDUSE device */
> > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev=
,
> > > > > > > +                                      unsigned int group, un=
signed int asid)
> > > > > > > +{
> > > > > > > +       /*
> > > > > > > +        * Two concurrent updates to this pointer are valid a=
s they cannot
> > > > > > > +        * point to an invalid region.  It is ok for them to =
race as long as
> > > > > > > +        * the readers see a consistent state through RCU.
> > > > > > > +        */
> > > > > > > +       rcu_assign_pointer(dev->groups[group].as, &dev->as[as=
id]);
> > > > > >
> > > > > > I'd expect at least a synchronize_rcu() here to wait for the re=
ad is done?
> > > > > >
> > > > >
> > > > > What's the use? The only thing left here is to return from
> > > > > vduse_set_group_asid_nomsg, and we don't need to wait for readers
> > > > > here, do we?
> > > >
> > > > See below.
> > > >
> > > > >
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > >  {
> > > > > > >         int i;
> > > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > > >
> > > > > > >         /* The coherent mappings are handled in vduse_dev_fre=
e_coherent() */
> > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > +               struct vduse_iova_domain *domain =3D dev->as[=
i].domain;
> > > > > > > +
> > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > +                       vduse_domain_reset_bounce_map(domain)=
;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > > >
> > > > > > >         down_write(&dev->rwsem);
> > > > > > >
> > > > > > > @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_map=
(struct vdpa_device *vdpa, u16 idx)
> > > > > > >         return ret;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, un=
signed int group,
> > > > > > > +                               unsigned int asid)
> > > > > > > +{
> > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > +       int r;
> > > > > > > +
> > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > > > > +               return -EINVAL;
> > > > > > > +
> > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > +
> > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > +       if (r < 0)
> > > > > > > +               return r;
> > > > > > > +
> > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa,=
 u16 idx,
> > > > > > >                                 struct vdpa_vq_state *state)
> > > > > > >  {
> > > > > > > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct vd=
pa_device *vdpa,
> > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > >         int ret;
> > > > > > >
> > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, io=
tlb);
> > > > > > >         if (ret)
> > > > > > >                 return ret;
> > > > > > >
> > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX)=
;
> > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLON=
G_MAX);
> > > > > > >         if (ret) {
> > > > > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > > > > +               vduse_domain_clear_map(dev->as[asid].domain, =
iotlb);
> > > > > > >                 return ret;
> > > > > > >         }
> > > > > > >
> > > > > > > @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vduse=
_vdpa_config_ops =3D {
> > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinit=
y,
> > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > >  };
> > > > > > > @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for_d=
evice(union virtio_map token,
> > > > > > >                                              enum dma_data_di=
rection dir)
> > > > > > >  {
> > > > > > >         struct vduse_dev *vdev;
> > > > > > > +       struct vduse_as *as;
> > > > > > >         struct vduse_iova_domain *domain;
> > > > > > >
> > > > > > >         if (!token.group)
> > > > > > >                 return;
> > > > > > >
> > > > > > >         vdev =3D token.group->dev;
> > > > > > > -       domain =3D vdev->domain;
> > > > > > > -
> > > > > > > +       rcu_read_lock();
> > > > > > > +       as =3D rcu_dereference(token.group->as);
> > > > > > > +       domain =3D as->domain;
> > > > > > > +       rcu_read_unlock();
> > > > > > >         vduse_domain_sync_single_for_device(domain, dma_addr,=
 size, dir);
> > > > > >
> > > > > > This is suspicious, at least we should do rcu_read_unlock() aft=
er
> > > > > > vduse_domain_sync_single_for_device(), otherwise I don't see ho=
w RCU
> > > > > > works.
> > > > > >
> > > > >
> > > > > RCU is protecting that the address space pointer of the vq group =
is
> > > > > not modified concurrently with the access. Ideally, this should b=
e a
> > > > > full lock, but just making sure that all accesses from the reader=
 are
> > > > > coherent is enough. Userspace should expect nothing if it uses th=
e map
> > > > > and modifies the vq group ASID at the same time anyway, but the k=
ernel
> > > > > needs to be sure that it does not see intermediate states. TBH, w=
e
> > > > > could move to a READ_ONCE / WRITE_ONCE, would that be more clear?
> > > >
> > > > Using READ_ONCE/WRITE_ONCE() needs to make sure the ordering is
> > > > handled correctly.
> > > >
> > > > But I meant what happens if
> > > >
> > > > [cpu0]rcu_read_lock()
> > > > [cpu0]as =3D rcu_dereference(token.group->as)
> > > > [cpu0]...
> > > > [cpu0]rcu_read_unlock()
> > > > [cpu1]rcu_assign_pointer(token.group->as)
> > > > [cpu0]vduse_domain_sync_single_for_device()
> > > >
> > >
> > > That should go ok. What I'm trying to protect here is the iterations
> > > in vduse_domain_sync_single_for_device -> vduse_domain_bounce.
> > >
> > > I'm going to embed that function here in
> > > vduse_dev_sync_single_for_device and omit RCU and some details to mak=
e
> > > the point easier:
> > >
> > > vduse_dev_sync_single_for_device(union virtio_map token, dma_addr_t
> > > iova, size_t size, ...) {
> > >   read_lock(&token.group->as->domain);
> > >   while (size)
> > >     map =3D token.group->as->domain->bounce_maps[iova];
> > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > >
> > >     ...
> > >     page =3D token_group->as->domain->bounce_maps
> > >     addr =3D kmap_local_page(page);
> > >     do_bounce(map->orig_phys, addr, sz, dir);
> > >     kunmap_local(addr);
> > >     size -=3D sz;
> > >     iova +=3D sz;
> > >   }
> > >   read_unlock(&token.group->as->domain);
> > > }
> >
> > Right, so I meant for rwlock like semantic (let's forget the sleeping h=
ere).
> >
> > vduse_set_group_asid_nomsg() should use "write lock" so it must wait
> > for the "read lock" to be done.
>
> No, it doesn't need to wait as long as the reader part uses its own copy.

It probably won't crash but I meant if we have logic issues. For
example, once set_group_asid() return, there should still be a pending
DMA that is using the old as.

>
> > But this is not the logic that is
> > implemented in this patch as there's no synchronize_rcu() in the
> > vduse_set_group_asid_nomsg().
>
> We only set the pointer on the writer's side, we do nothing like
> freeing resources. Should we set the pointer before or after
> syncrhonize_rcu()? What do we need to do on the other side of
> syncrhonize_rcu()?

Usually we don't need special care on the read side. But as discussed,
synchronize_rcu() is not a must but we need to explain why it is safe
and I'm not sure Michael is fine with that.
If we just want to make sure the order of publish and read, we can
switch to use smp_store_release() and smp_load_acqurie().

>
> > We need to explain why set_group_asid()
> > doesn't need to wait and if this is true, we probably don't need RCU
> > but to make sure the load/store is atomic.
> >
>
> What about:
>
> * It does not matter if other thread modify group->as as long as the
> reader uses the same as for all its operation. It performs a local
> copy for that reason.
> * It does not matter if multiple threads modify group->as as long as
> the update is atomic.

See above reply.

>
> ?
>
> > >
> > > Now, depending on the point where another execution thread changes
> > > token_group->as and how the compiler has chosen to generate the
> > > machine code, the outcome could be:
> > > 1) The domain read lock of one ASID is taken but the domain lock of
> > > another as is unlocked.
> > > 2) We iterate until iova is ok for the ASID we're handling, but not
> > > for the other one. So we access an invalid offset in
> > > bounce_maps[iova].
> > >
> > > And I guess there are other possible outcomes too.
> > >
> > > So I need to make sure that the pointer accesses in all
> > > vduse_domain_bounce is coherent.
> >
> > I'm not sure I got here, but it looks like it accepts a domain
> > parameter and is protected by the bounce lock so we are probably fine
> > here?
> >
>
> The bounce lock only protects the iotlb tree, not the pointer to that
> iotlb tree.
>
> > > I'm ok if it takes the one before the
> > > concurrent call to vduse_set_group_asid_nomsg or the one after that,
> > > as the lifetime of all domains are bound to the device. But it cannot
> > > change in the middle of the operation:
> > >
> > > vduse_dev_sync_single_for_device(union virtio_map token, dma_addr_t
> > > iova, size_t size, ...) {
> > >   as =3D token.group->as;
> > >   // Tell the compiler to never replace "as" by "token.group->as" aft=
er this.
> > >   read_lock(&as->domain);
> > >   while (size)
> > >     map =3D as->domain->bounce_maps[iova];
> > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > >
> > >     ...
> > >     page =3D as->domain->bounce_maps
> > >     addr =3D kmap_local_page(page);
> > >     do_bounce(map->orig_phys, addr, sz, dir);
> > >     kunmap_local(addr);
> > >     size -=3D sz;
> > >     iova +=3D sz;
> > >   }
> > >   read_unlock(&as->domain);
> > > }
> > >
> > > That can be done in many ways. Probably the read_lock is already
> > > enough but it is not explicit that it is protecting token.group->as,
> > > and future changes could remove it. To me, RCU is the most clear way
> > > to do it, but even a volatile read (READ_ONCE?) would do.
> >
> > I wonder if another group rwlock is sufficient here:
> >
> > for set_group_as_id()
> >
> > write_lock(&dev->groups[group].lock);
> > dev->groups[group].as =3D &dev->as[asid];
> > write_unlock(&dev->groups[group].lock);
> >
> > for the case where we need defer as
> >
> > read_lock(&dev->groups[group].lock);
> > as =3D dev->groups[group].as;
> > //using as
> > read_unlock(&dev->groups[group].lock);
> >
> > If this works, we don't need to bother with thinking if the
> > wait/synchronizre_rcu() is really needed or not?
> >
>
> A rwlock is sufficient but we need to modify the allocation code
> somehow. Also, I thought we wanted to avoid the overhead of taking the
> read lock in the DMA ops too.

Right, but it would always be a balance. We can make sure it works
correctly first then do optimization on top.

>
> Another disadvantage of the lock vs RCU or READ_ONCE is that the vq
> group ASID change needs to wait for the DMA operation to finish
> instead of just applying for the next DMA ops. Not like vq group ASID
> change would be in the hot path anyway, just pointing it out.
>
> > >
> > > > If this is not an issue, RCU is not a must, but please explain why.
> > > > If this is an issue, we need to fix it.
> > > >
> > > > It's basically a question that
> > > >
> > > > 1) should we need to wait for the DMA to be completed before assign=
ing
> > > > to the new as
> > >
> > > I don't think so, it is valid to assign a new as and let the ongoing
> > > operation to continue. It is racy and the operation could fail, but
> > > the kernel just returns an error and doesn't access invalid memory or
> > > similar.
> >
> > See below.
> >
> > >
> > > > 2) should we track the set_group_asid() for the group that has pend=
ing
> > > > DMA to avoid potential issue
> > > >
> > >
> > > No, the group will outlive the operation as it is bound to the device=
.
> >
> > I meant e.g the DMA could be triggered by the device. For example, the
> > device may try to trigger an interrupt when the kernel is trying to
> > assign a new asid. So I wonder if guest can use this to poke Qemu's
> > memory etc.
>
> I'm not sure I get this point. If QEMU changes the ASID of the vq
> group sent to the guest the race does not matter anymore: it is
> explicitly opening the possibility from the guest to poke QEMU's
> memory unless the guest is totally paused.

Basically what I meant, assuming group0.as =3D as0

cpu0] dma_map(group0.as, addr, DMA_FROM_DEVICE)
cpu1] set_group_asid(group0.as, as1)
cpu0] dma_unmap(group0.as, addr, DMA_FROM_DEVICE)

cpu0 may read as1 while it wants as0 actually?

>
> > But if you mean we depend on the IOTLB to guard against
> > this, I'm fine, but let's document why we don't need it and how the
> > IOTLB layer can help to eliminate such risk.
> >
>
> No, I'm not happy about letting iotlb lock to protect this too as
> they're at different levels actually: One is protecting iotlb trees
> modifications while they're being read and the other is protecting the
> ASID assignment to different vq groups. To reuse them means a
> modification in any tree blocks the change of vq group ASID, for
> example.
>
> > Anyhow, tracking and failing seems to be more robust.
>
> I'm not sure I get this. If a DMA read starts in one ASID and then
> QEMU changes the ASID of the vq group, do you prefer it to fail rather
> than continue reading from the original ASID?

If possible, it would be better.

> It seems hard to
> communicate that the ASID has changed to the DMA operation callback.

Maybe we can encode this into iova.

>
> > For example,
> > kernel swiotlb has a layer to track whether the address that is being
> > unmapped is mapped before. In our case we should make sure when race
> > happens, isolation via ASID won't be broken.
> >
>
> Right but it cannot protect if the iotlb is valid in the second ASID
> but just points to a different physical / virtual page.
>

Thanks

