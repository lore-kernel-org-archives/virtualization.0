Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780F157487
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764814556; cv=none; b=Y2N13CbMg0ujRSqBlzxPl06anBnD6sMvXDdrucPh5SK03eVamFythPM6izLTnSt2S+XRxFC8LUPBZe417SPdwk/sPPj2hnWK/l5tlDtipe6ov0e74jAfESZF4gCHmkPKMRkvdzSEpPgSbEzShPacsYI8uLQyVRm9Vj/u3yAVUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764814556; c=relaxed/simple;
	bh=rr2kHbOz6ajAkMndscyxXc/ZVx0G8/PNAf0bCuOicVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzc/Jfoen94AndVS+1WwfpT8TdnvyvG+wUMf9HrwWDpSh0lYsP44LvLeDiX2lHoIFBa3KjZdMM2V4eYHACMSsA05IVqmnMGmavUqrdH3RRRyWf9zk7+vdn2z3eUVSQZZ/t1gyV23wPle34ly/c1gOcg2Zvu1ujSCCtJUasP0Y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWc8iFW4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWc8iFW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764814551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6AKikdbyJNW6CH/3wrO7rStMJ8wzmFqJATiJ+9VkSP4=;
	b=DWc8iFW42iwghNp+Y+S2EQGbEhkf3XsNS44T9671zEcMGc8EIB5mLG66xB2lueNIzmymnI
	x3KBmf9g6zXKKbg0E0Bu88LVT9i2wfqDvDHQNI3lB4wwVlVTanUrFNkDdx+EkpARs1x93f
	RyewdFMP6b0Zr2eN6YLjc3dlI4A/tsk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-2hOPbP91OCi-ZG9y_qmpww-1; Wed, 03 Dec 2025 21:15:48 -0500
X-MC-Unique: 2hOPbP91OCi-ZG9y_qmpww-1
X-Mimecast-MFC-AGG-ID: 2hOPbP91OCi-ZG9y_qmpww_1764814548
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34378c914b4so745897a91.1
        for <virtualization@lists.linux.dev>; Wed, 03 Dec 2025 18:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764814547; x=1765419347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6AKikdbyJNW6CH/3wrO7rStMJ8wzmFqJATiJ+9VkSP4=;
        b=dXeIl5Kzgn9FnNYFbMnhsBIQXWN/8YSQYvcosT5cP7EPYGCyVPrqhMflJeH1oA9JRn
         PCNbDwotEpii3uTj1CaiNkbOoFh6Xp3SmVAqpQ1DZ+GpcbzldEq9y98g+E9+r7qc+VK8
         dgqql+c6UaH11i66icVMni3hpF310V2k2KA8tHFRknmYqBD5vjXLoQe9kBQYt8c54twP
         vCZ8gpKdXJqyoNQf1HJv/oxfVYfe7GOjwQ77x/1rlVITEMxL29tKVf4Z68gFO9gIyeeB
         GWet1TPQ8G+mPywm5RWZHtuN9O9ydfAJv2BpsJaomtVC05LHJNaDDIwk0B/3/hiDZAJe
         g16Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzgpn9z3XvbfIDfILUz9r6dYnQx1XXWqkWgmt2s0jEBC3dq/vpc1Ie1b2pgAKMZ4cxGHgA7T8STd7IU8n5tA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy89d3IITRGDNEc/9OitfE7UlD2bo9x3ooloMHe3DLFRCK8zsyV
	Zio03D3AtdSUIbUCUKtVncrO/hLUgS9DxOZcnMuI2A1uyCAX1kpdMsMVDrtZT2SZbtLWrzfL56w
	4rSp3WB9I6yjoZ6bq323WHaMVkQvuRPrivHXsKBchUxJgmMxxjndRvZeUFepolsALBDw51zPPmA
	J8SFWi8WkC5+xT9/7HCWr6HUDAf2ciLhblUpae7JeqvNE=
X-Gm-Gg: ASbGncvGUUpk0TbWu0pk3VIclQbqN2Lx0GvB9oZODncP2p1lWqH/EObGX9p2whfQSPt
	Etbf9iSYleonJO9JkGAMAdm97QHnWqFm/R4xm2IErh+p8/S5tN/qMYGxn328F8CimPhxyL0BrLt
	pYo36jljnZSXsUW5zLts7/HKDigyixD5B+Zus3Cu75qZVjYbtlVLQaQXpp2BYiLuoQYOg=
X-Received: by 2002:a17:90b:38ce:b0:339:cece:a99 with SMTP id 98e67ed59e1d1-349125bf317mr4155662a91.13.1764814547143;
        Wed, 03 Dec 2025 18:15:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwf/f2l9RQyzqhWoySO8VdnyCmfW2SX32eLHTLV/HkIhh6TA21Be7t2y0+e80YOwN4icsK+i8SJEaEwksOmm4=
X-Received: by 2002:a17:90b:38ce:b0:339:cece:a99 with SMTP id
 98e67ed59e1d1-349125bf317mr4155635a91.13.1764814546481; Wed, 03 Dec 2025
 18:15:46 -0800 (PST)
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
 <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com>
 <CACGkMEtMyte91bbdb0hfUo+YgSpZdjoWe0meKwbDc18CfWdATA@mail.gmail.com> <CAJaqyWfsuSobzdr522NvXHAZmczFvOB4vBUAfeOjfnz6GewP1A@mail.gmail.com>
In-Reply-To: <CAJaqyWfsuSobzdr522NvXHAZmczFvOB4vBUAfeOjfnz6GewP1A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Dec 2025 10:15:31 +0800
X-Gm-Features: AWmQ_bmVlh5PW0oRsX-UNfLAQKHUx2chDprtQaSzU6hiZELldm0nLKeH8YA-Vfk
Message-ID: <CACGkMEsJXaOszR4UfY7+y=FfP8n-z3V1N+0QpDfePvs8=RY5Bg@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i5A3mYd2kCQFrTGWzN2kxw6c556g2cqtqZrmYJaG6TQ_1764814548
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 3:58=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Thu, Nov 20, 2025 at 2:38=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Nov 19, 2025 at 5:27=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, Nov 19, 2025 at 3:39=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Mon, Nov 17, 2025 at 8:16=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Mon, Nov 17, 2025 at 5:23=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 14, 2025 at 7:25=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=A9rez =
<eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > Add support for assigning Address Space Identifiers (ASID=
s) to each VQ
> > > > > > > > > group.  This enables mapping each group into a distinct m=
emory space.
> > > > > > > > >
> > > > > > > > > Now that the driver can change ASID in the middle of oper=
ation, the
> > > > > > > > > domain that each vq address point is also protected by do=
main_lock.
> > > > > > > >
> > > > > > > > Maybe it's better to document what is protected by RCU and =
how.
> > > > > > > >
> > > > > > >
> > > > > > > I added the _rcu annotation but I can expand it for sure. I c=
an also
> > > > > > > modify the commit message.
> > > > > > >
> > > > > > > > More below.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > >
> > > > > > > I forgot to remove this, my bad!
> > > > > > >
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > ---
> > > > > > > > > v9:
> > > > > > > > > * Replace mutex with RCU, as the vdpa map_ops can run fro=
m atomic
> > > > > > > > >   context.
> > > > > > > > >
> > > > > > > > > v8:
> > > > > > > > > * Revert the mutex to rwlock change, it needs proper prof=
iling to
> > > > > > > > >   justify it.
> > > > > > > > >
> > > > > > > > > v7:
> > > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > > >
> > > > > > > > > v6:
> > > > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_AP=
I_VERSION_1) ?/
> > > > > > > > >   (MST).
> > > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > > >
> > > > > > > > > v5:
> > > > > > > > > * Properly return errno if copy_to_user returns >0 in VDU=
SE_IOTLB_GET_FD
> > > > > > > > >   ioctl (Jason).
> > > > > > > > > * Properly set domain bounce size to divide equally betwe=
en nas (Jason).
> > > > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > > > >   vduse_dev_request.
> > > > > > > > >
> > > > > > > > > v4:
> > > > > > > > > * Divide each domain bounce size between the device bounc=
e size (Jason).
> > > > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) ret=
urn; if (z)
> > > > > > > > >   return; } (Jason)
> > > > > > > > > * Change a bad multiline comment, using @ caracter instea=
d of * (Jason).
> > > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > > > >
> > > > > > > > > v3:
> > > > > > > > > * Get the vduse domain through the vduse_as in the map fu=
nctions
> > > > > > > > >   (Jason).
> > > > > > > > > * Squash with the patch creating the vduse_as struct (Jas=
on).
> > > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a m=
agic number
> > > > > > > > >   (Jason)
> > > > > > > > >
> > > > > > > > > v2:
> > > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > > >
> > > > > > > > > RFC v3:
> > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was =
set to a lower
> > > > > > > > >   value to reduce memory consumption, but vqs are already=
 limited to
> > > > > > > > >   that value and userspace VDUSE is able to allocate that=
 many vqs.
> > > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > > > * Move the umem mutex to asid struct so there is no conte=
ntion between
> > > > > > > > >   ASIDs.
> > > > > > > > >
> > > > > > > > > RFC v2:
> > > > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 s=
o the first
> > > > > > > > >   part of the struct is the same.
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 +++++++++++++++=
+++++---------
> > > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > > >  2 files changed, 314 insertions(+), 109 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers=
/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index 97be04f73fbf..ff95ed56f22d 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > @@ -11,6 +11,7 @@
> > > > > > > > >  #include "linux/virtio_net.h"
> > > > > > > > >  #include <linux/init.h>
> > > > > > > > >  #include <linux/module.h>
> > > > > > > > > +#include <linux/rcupdate.h>
> > > > > > > > >  #include <linux/cdev.h>
> > > > > > > > >  #include <linux/device.h>
> > > > > > > > >  #include <linux/eventfd.h>
> > > > > > > > > @@ -41,6 +42,7 @@
> > > > > > > > >
> > > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > > @@ -86,7 +88,14 @@ struct vduse_umem {
> > > > > > > > >         struct mm_struct *mm;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > +struct vduse_as {
> > > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > > +       struct mutex mem_lock;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > >  struct vduse_vq_group {
> > > > > > > > > +       struct vduse_as *as __rcu;
> > > > > > > > >         struct vduse_dev *dev;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > > >         struct device *dev;
> > > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > > +       struct vduse_as *as;
> > > > > > > > >         char *name;
> > > > > > > > >         struct mutex lock;
> > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > > > > > >         u32 vq_num;
> > > > > > > > >         u32 vq_align;
> > > > > > > > >         u32 ngroups;
> > > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > > +       u32 nas;
> > > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > > -       struct mutex mem_lock;
> > > > > > > > >         unsigned int bounce_size;
> > > > > > > > >         struct mutex domain_lock;
> > > > > > > > >  };
> > > > > > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struc=
t vduse_dev *dev, u8 status)
> > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev,=
 u32 asid,
> > > > > > > > >                                   u64 start, u64 last)
> > > > > > > > >  {
> > > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(st=
ruct vduse_dev *dev,
> > > > > > > > >                 return -EINVAL;
> > > > > > > > >
> > > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > > +       } else {
> > > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > >  }
> > > > > > > > > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(stru=
ct file *file, poll_table *wait)
> > > > > > > > >         return mask;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +/* Force set the asid to a vq group without a message to=
 the VDUSE device */
> > > > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev =
*dev,
> > > > > > > > > +                                      unsigned int group=
, unsigned int asid)
> > > > > > > > > +{
> > > > > > > > > +       /*
> > > > > > > > > +        * Two concurrent updates to this pointer are val=
id as they cannot
> > > > > > > > > +        * point to an invalid region.  It is ok for them=
 to race as long as
> > > > > > > > > +        * the readers see a consistent state through RCU=
.
> > > > > > > > > +        */
> > > > > > > > > +       rcu_assign_pointer(dev->groups[group].as, &dev->a=
s[asid]);
> > > > > > > >
> > > > > > > > I'd expect at least a synchronize_rcu() here to wait for th=
e read is done?
> > > > > > > >
> > > > > > >
> > > > > > > What's the use? The only thing left here is to return from
> > > > > > > vduse_set_group_asid_nomsg, and we don't need to wait for rea=
ders
> > > > > > > here, do we?
> > > > > >
> > > > > > See below.
> > > > > >
> > > > > > >
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > > > >  {
> > > > > > > > >         int i;
> > > > > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > > > > >
> > > > > > > > >         /* The coherent mappings are handled in vduse_dev=
_free_coherent() */
> > > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > > +               struct vduse_iova_domain *domain =3D dev-=
>as[i].domain;
> > > > > > > > > +
> > > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > > +                       vduse_domain_reset_bounce_map(dom=
ain);
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > > > > >
> > > > > > > > >         down_write(&dev->rwsem);
> > > > > > > > >
> > > > > > > > > @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq=
_map(struct vdpa_device *vdpa, u16 idx)
> > > > > > > > >         return ret;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa=
, unsigned int group,
> > > > > > > > > +                               unsigned int asid)
> > > > > > > > > +{
> > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > +       int r;
> > > > > > > > > +
> > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas=
)
> > > > > > > > > +               return -EINVAL;
> > > > > > > > > +
> > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > > +
> > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > +       if (r < 0)
> > > > > > > > > +               return r;
> > > > > > > > > +
> > > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > > > > +       return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *v=
dpa, u16 idx,
> > > > > > > > >                                 struct vdpa_vq_state *sta=
te)
> > > > > > > > >  {
> > > > > > > > > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struc=
t vdpa_device *vdpa,
> > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > >         int ret;
> > > > > > > > >
> > > > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain=
, iotlb);
> > > > > > > > >         if (ret)
> > > > > > > > >                 return ret;
> > > > > > > > >
> > > > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_=
MAX);
> > > > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, U=
LLONG_MAX);
> > > > > > > > >         if (ret) {
> > > > > > > > > -               vduse_domain_clear_map(dev->domain, iotlb=
);
> > > > > > > > > +               vduse_domain_clear_map(dev->as[asid].doma=
in, iotlb);
> > > > > > > > >                 return ret;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > @@ -843,6 +898,7 @@ static const struct vdpa_config_ops v=
duse_vdpa_config_ops =3D {
> > > > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_aff=
inity,
> > > > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > > > >  };
> > > > > > > > > @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_f=
or_device(union virtio_map token,
> > > > > > > > >                                              enum dma_dat=
a_direction dir)
> > > > > > > > >  {
> > > > > > > > >         struct vduse_dev *vdev;
> > > > > > > > > +       struct vduse_as *as;
> > > > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > > >
> > > > > > > > >         if (!token.group)
> > > > > > > > >                 return;
> > > > > > > > >
> > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > -
> > > > > > > > > +       rcu_read_lock();
> > > > > > > > > +       as =3D rcu_dereference(token.group->as);
> > > > > > > > > +       domain =3D as->domain;
> > > > > > > > > +       rcu_read_unlock();
> > > > > > > > >         vduse_domain_sync_single_for_device(domain, dma_a=
ddr, size, dir);
> > > > > > > >
> > > > > > > > This is suspicious, at least we should do rcu_read_unlock()=
 after
> > > > > > > > vduse_domain_sync_single_for_device(), otherwise I don't se=
e how RCU
> > > > > > > > works.
> > > > > > > >
> > > > > > >
> > > > > > > RCU is protecting that the address space pointer of the vq gr=
oup is
> > > > > > > not modified concurrently with the access. Ideally, this shou=
ld be a
> > > > > > > full lock, but just making sure that all accesses from the re=
ader are
> > > > > > > coherent is enough. Userspace should expect nothing if it use=
s the map
> > > > > > > and modifies the vq group ASID at the same time anyway, but t=
he kernel
> > > > > > > needs to be sure that it does not see intermediate states. TB=
H, we
> > > > > > > could move to a READ_ONCE / WRITE_ONCE, would that be more cl=
ear?
> > > > > >
> > > > > > Using READ_ONCE/WRITE_ONCE() needs to make sure the ordering is
> > > > > > handled correctly.
> > > > > >
> > > > > > But I meant what happens if
> > > > > >
> > > > > > [cpu0]rcu_read_lock()
> > > > > > [cpu0]as =3D rcu_dereference(token.group->as)
> > > > > > [cpu0]...
> > > > > > [cpu0]rcu_read_unlock()
> > > > > > [cpu1]rcu_assign_pointer(token.group->as)
> > > > > > [cpu0]vduse_domain_sync_single_for_device()
> > > > > >
> > > > >
> > > > > That should go ok. What I'm trying to protect here is the iterati=
ons
> > > > > in vduse_domain_sync_single_for_device -> vduse_domain_bounce.
> > > > >
> > > > > I'm going to embed that function here in
> > > > > vduse_dev_sync_single_for_device and omit RCU and some details to=
 make
> > > > > the point easier:
> > > > >
> > > > > vduse_dev_sync_single_for_device(union virtio_map token, dma_addr=
_t
> > > > > iova, size_t size, ...) {
> > > > >   read_lock(&token.group->as->domain);
> > > > >   while (size)
> > > > >     map =3D token.group->as->domain->bounce_maps[iova];
> > > > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > > > >
> > > > >     ...
> > > > >     page =3D token_group->as->domain->bounce_maps
> > > > >     addr =3D kmap_local_page(page);
> > > > >     do_bounce(map->orig_phys, addr, sz, dir);
> > > > >     kunmap_local(addr);
> > > > >     size -=3D sz;
> > > > >     iova +=3D sz;
> > > > >   }
> > > > >   read_unlock(&token.group->as->domain);
> > > > > }
> > > >
> > > > Right, so I meant for rwlock like semantic (let's forget the sleepi=
ng here).
> > > >
> > > > vduse_set_group_asid_nomsg() should use "write lock" so it must wai=
t
> > > > for the "read lock" to be done.
> > >
> > > No, it doesn't need to wait as long as the reader part uses its own c=
opy.
> >
> > It probably won't crash but I meant if we have logic issues. For
> > example, once set_group_asid() return, there should still be a pending
> > DMA that is using the old as.
> >
> > >
> > > > But this is not the logic that is
> > > > implemented in this patch as there's no synchronize_rcu() in the
> > > > vduse_set_group_asid_nomsg().
> > >
> > > We only set the pointer on the writer's side, we do nothing like
> > > freeing resources. Should we set the pointer before or after
> > > syncrhonize_rcu()? What do we need to do on the other side of
> > > syncrhonize_rcu()?
> >
> > Usually we don't need special care on the read side. But as discussed,
> > synchronize_rcu() is not a must but we need to explain why it is safe
> > and I'm not sure Michael is fine with that.
> > If we just want to make sure the order of publish and read, we can
> > switch to use smp_store_release() and smp_load_acqurie().
> >
> > >
> > > > We need to explain why set_group_asid()
> > > > doesn't need to wait and if this is true, we probably don't need RC=
U
> > > > but to make sure the load/store is atomic.
> > > >
> > >
> > > What about:
> > >
> > > * It does not matter if other thread modify group->as as long as the
> > > reader uses the same as for all its operation. It performs a local
> > > copy for that reason.
> > > * It does not matter if multiple threads modify group->as as long as
> > > the update is atomic.
> >
> > See above reply.
> >
> > >
> > > ?
> > >
> > > > >
> > > > > Now, depending on the point where another execution thread change=
s
> > > > > token_group->as and how the compiler has chosen to generate the
> > > > > machine code, the outcome could be:
> > > > > 1) The domain read lock of one ASID is taken but the domain lock =
of
> > > > > another as is unlocked.
> > > > > 2) We iterate until iova is ok for the ASID we're handling, but n=
ot
> > > > > for the other one. So we access an invalid offset in
> > > > > bounce_maps[iova].
> > > > >
> > > > > And I guess there are other possible outcomes too.
> > > > >
> > > > > So I need to make sure that the pointer accesses in all
> > > > > vduse_domain_bounce is coherent.
> > > >
> > > > I'm not sure I got here, but it looks like it accepts a domain
> > > > parameter and is protected by the bounce lock so we are probably fi=
ne
> > > > here?
> > > >
> > >
> > > The bounce lock only protects the iotlb tree, not the pointer to that
> > > iotlb tree.
> > >
> > > > > I'm ok if it takes the one before the
> > > > > concurrent call to vduse_set_group_asid_nomsg or the one after th=
at,
> > > > > as the lifetime of all domains are bound to the device. But it ca=
nnot
> > > > > change in the middle of the operation:
> > > > >
> > > > > vduse_dev_sync_single_for_device(union virtio_map token, dma_addr=
_t
> > > > > iova, size_t size, ...) {
> > > > >   as =3D token.group->as;
> > > > >   // Tell the compiler to never replace "as" by "token.group->as"=
 after this.
> > > > >   read_lock(&as->domain);
> > > > >   while (size)
> > > > >     map =3D as->domain->bounce_maps[iova];
> > > > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > > > >
> > > > >     ...
> > > > >     page =3D as->domain->bounce_maps
> > > > >     addr =3D kmap_local_page(page);
> > > > >     do_bounce(map->orig_phys, addr, sz, dir);
> > > > >     kunmap_local(addr);
> > > > >     size -=3D sz;
> > > > >     iova +=3D sz;
> > > > >   }
> > > > >   read_unlock(&as->domain);
> > > > > }
> > > > >
> > > > > That can be done in many ways. Probably the read_lock is already
> > > > > enough but it is not explicit that it is protecting token.group->=
as,
> > > > > and future changes could remove it. To me, RCU is the most clear =
way
> > > > > to do it, but even a volatile read (READ_ONCE?) would do.
> > > >
> > > > I wonder if another group rwlock is sufficient here:
> > > >
> > > > for set_group_as_id()
> > > >
> > > > write_lock(&dev->groups[group].lock);
> > > > dev->groups[group].as =3D &dev->as[asid];
> > > > write_unlock(&dev->groups[group].lock);
> > > >
> > > > for the case where we need defer as
> > > >
> > > > read_lock(&dev->groups[group].lock);
> > > > as =3D dev->groups[group].as;
> > > > //using as
> > > > read_unlock(&dev->groups[group].lock);
> > > >
> > > > If this works, we don't need to bother with thinking if the
> > > > wait/synchronizre_rcu() is really needed or not?
> > > >
> > >
> > > A rwlock is sufficient but we need to modify the allocation code
> > > somehow. Also, I thought we wanted to avoid the overhead of taking th=
e
> > > read lock in the DMA ops too.
> >
> > Right, but it would always be a balance. We can make sure it works
> > correctly first then do optimization on top.
> >
> > >
> > > Another disadvantage of the lock vs RCU or READ_ONCE is that the vq
> > > group ASID change needs to wait for the DMA operation to finish
> > > instead of just applying for the next DMA ops. Not like vq group ASID
> > > change would be in the hot path anyway, just pointing it out.
> > >
> > > > >
> > > > > > If this is not an issue, RCU is not a must, but please explain =
why.
> > > > > > If this is an issue, we need to fix it.
> > > > > >
> > > > > > It's basically a question that
> > > > > >
> > > > > > 1) should we need to wait for the DMA to be completed before as=
signing
> > > > > > to the new as
> > > > >
> > > > > I don't think so, it is valid to assign a new as and let the ongo=
ing
> > > > > operation to continue. It is racy and the operation could fail, b=
ut
> > > > > the kernel just returns an error and doesn't access invalid memor=
y or
> > > > > similar.
> > > >
> > > > See below.
> > > >
> > > > >
> > > > > > 2) should we track the set_group_asid() for the group that has =
pending
> > > > > > DMA to avoid potential issue
> > > > > >
> > > > >
> > > > > No, the group will outlive the operation as it is bound to the de=
vice.
> > > >
> > > > I meant e.g the DMA could be triggered by the device. For example, =
the
> > > > device may try to trigger an interrupt when the kernel is trying to
> > > > assign a new asid. So I wonder if guest can use this to poke Qemu's
> > > > memory etc.
> > >
> > > I'm not sure I get this point. If QEMU changes the ASID of the vq
> > > group sent to the guest the race does not matter anymore: it is
> > > explicitly opening the possibility from the guest to poke QEMU's
> > > memory unless the guest is totally paused.
> >
> > Basically what I meant, assuming group0.as =3D as0
> >
> > cpu0] dma_map(group0.as, addr, DMA_FROM_DEVICE)
> > cpu1] set_group_asid(group0.as, as1)
> > cpu0] dma_unmap(group0.as, addr, DMA_FROM_DEVICE)
> >
> > cpu0 may read as1 while it wants as0 actually?
> >
>
> Yes, kind of. That's my point: adding synchronization at vduse level
> does not fix it.
>
> There is no way to do that call from vhost/vdpa or userland, as there
> is no way to get the AS of a vq group, only to set it. The closest
> thing is to add a cache at that level, but that implies to add
> mutithreading sync on that upper layer, either vhost/vdpa or userland,
> not in VDUSE.

Probably.

>
> From vhost/vdpa level, all mapping calls (.set_map, .dma_map,
> .dma_unmap) calls take the ASID directly, not the vq group. So the
> call to set_group_asid does not need to access the vq group.
>
> Now let's say that we add that vdpa_ops callback (and ioctls) that
> maps and unmap based on a vq_group. And all of the operations
> (dma_map, set_group_asid, and dma_unmap) are serialized by taking the
> same mutex. cpu0 still may dma_unmap over as0 if set_group_asid is not
> properly serialized at vhost/vdpa or userland level:
>
> void* thread0_func(void* arg) {
> struct {
>         int vq_group =3D 0,
>         int iova, size, perm, ...
>     } s;
>     int fd =3D (intptr_t)arg;
>
>     ioctl(fd, VHOST_VDPA_VQ_GROUP_DMA_MAP, &s);
>     // TODO: Signal thread0 that it can proceed with SET_GROUP_ASID
>     // TODO: Wait until thread0 complete SET_GROUP_ASID
>
>     ioctl(fd, VHOST_VDPA_VQ_GROUP_DMA_UNMAP, &data);
>
>     return NULL;
> }
>
> void* thread1_func(void* arg) {
>     struct vhost_vring_state s =3D {
>         .index =3D 0,
>         .num =3D 1,
>     };
>     int fd =3D (int)(intptr_t)arg;
>
>     // TODO: Wait until thread2 calls dma_map

This is something exactly rwlock or synchronize_rcu() can do? Or is
this the charge of the vDPA parent to do that?

If it's the responsibility of the parent, it would be much harder for
VDUSE as the datapath is implemented in usersapce via mmap() or
umem_reg.

Looking at existing implementation:

- for mlx5e, it looks like it assumes the set_group_asid() works only
without DRIVER_OK.
- for the simulator, it looks like it can synchronize with the
datapath with the spinlock as datapath is emulated

>     ioctl(fd, VHOST_VDPA_SET_GROUP_ASID, &s)
>     // TODO: Signal thread2 that can proceed with dma_unmap

But the issue I mention is that the, from the view of the vDPA bus:

1) it offers set_group_as_id()
2) it doesn't know if virtio-vdpa or vhost-vdpa is used

So theoretically, set_group_as_id() could happen between

dma_addr =3D dma_map();

and

dma_unmap(dma_adrr);

But those two dma_addr refers to the different address space. Instead
of trying to do synchronization, maybe we can simply fail
set_group_asid if DRIVER_OK is set.

>
>     return NULL;
> }
>
> int main() {
>     pthread_t thread0, thread1;
>     int fd =3D open("/dev/vhost-vdpa-0", ...)
>
>     pthread_create(&thread0, NULL, thread0_func, (void *)(intptr_t)fd);
>     pthread_create(&thread1, NULL, thread1_func, (void *)(intptr_t)fd);
>
>     pthread_join(thread1, NULL);
>     pthread_join(thread2, NULL);
>
>     return EXIT_SUCCESS;
> }
> ---
>
> We need something to synchronize at userland level here, filling the TODO=
s.
>
> We can replace the hypothetical VHOST_VDPA_VQ_GROUP_DMA_MAP and _UNMAP
> with access to vqs, and the result is the same: The userland
> application is the one that needs to serialize the access from thread0
> if it wants predictive outcome against the accesses from thread1.
> There is no way to do it at vduse level.
>
> We need some syncrhonization to avoid malicious or buggy userland to
> mess things, that's for sure. So DMA_MAP and DMA_UNMAP does not half
> update the iotlb tree. And I'll send the next version with rwlock,
> protecting as much as possible. But I want to make clear that it will
> not avoid the race you describe here.

See above.

>
> > >
> > > > But if you mean we depend on the IOTLB to guard against
> > > > this, I'm fine, but let's document why we don't need it and how the
> > > > IOTLB layer can help to eliminate such risk.
> > > >
> > >
> > > No, I'm not happy about letting iotlb lock to protect this too as
> > > they're at different levels actually: One is protecting iotlb trees
> > > modifications while they're being read and the other is protecting th=
e
> > > ASID assignment to different vq groups. To reuse them means a
> > > modification in any tree blocks the change of vq group ASID, for
> > > example.
> > >
> > > > Anyhow, tracking and failing seems to be more robust.
> > >
> > > I'm not sure I get this. If a DMA read starts in one ASID and then
> > > QEMU changes the ASID of the vq group, do you prefer it to fail rathe=
r
> > > than continue reading from the original ASID?
> >
> > If possible, it would be better.
> >
>
> It's hard for me to think in some way that does not add a lot of
> overhead or it is very complex. But it is good to know this is
> acceptable.
>
> > > It seems hard to
> > > communicate that the ASID has changed to the DMA operation callback.
> >
> > Maybe we can encode this into iova.
> >
>
> I'm adding the full rwlock, but can you expand on your idea on this?

Encode the asid to the upper bits of IOVA, so when doing dma_unmap()
we can compare the group/as with the one that is encoded in dma_addr.
If it differs, warn or bug.

If we can make sure there's no set_group_asid() when DRIVER_OK is set,
it's not a must then (or could be treated as a kind of hardening).

> It would be great to have it documented in case we need future
> optimizations.
>

Thanks

