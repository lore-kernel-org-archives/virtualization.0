Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02D38DF9
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381766; cv=none; b=OtD06i8XNpetVOhgNmjAaB2+izZ7pANW6FlHOUgjpWaGWSyO5oBw+UXMfiYgeUXkDimlNtFHuGGQSWmoLfH79lg9E5aPtx4rCtNfikcoDZWfXag+c1DQ3M5xiaT4/JlveyNeioCh0QxgCtaDLWSut/rvVyNVk16o1d249WIxKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381766; c=relaxed/simple;
	bh=g7CYloUrmQIHkUPfJKL7YvCVxrmIw9B8j7nXzxNVISw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si7YaAqxEZdyCdmoIxg/FNe/AUvQH+XbnuAgJGwaS15RhxiExYFp1D3hrOqfBzektNvsT1+RXTmY78mTnjxd1uWV2PkfQjoccakZM8VLwqQhY3++qCBN1hBQ0n5Ylh42aRkFU5G4UexMLBTiPPPPiS8ttC8Qh3UHZ5XRay+uj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsJCBkTu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsJCBkTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763381761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDxz4grUjwmEJBJvav8wuDrMfMnyUvBFkLLgfaCP/IM=;
	b=fsJCBkTuseS95IXi9CRLNgoaD3nlt3Coe1GR4/pI48tiGltTxqVcC0Yz/uv+H0ArBrWmFL
	BKKSxv3ynIRx3bdWdVGHiKcYhcqXgkAcIv52Oq4CI4ORHdRKHFFb6Ul7UCGecc9AmW3Iih
	uVkonW8BefJG4vOM5ZzSLk2T1Tk/ZYg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ZAExjUB5OaCBIeweJK-oBg-1; Mon, 17 Nov 2025 07:16:00 -0500
X-MC-Unique: ZAExjUB5OaCBIeweJK-oBg-1
X-Mimecast-MFC-AGG-ID: ZAExjUB5OaCBIeweJK-oBg_1763381759
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63f9c4e3701so885486d50.1
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 04:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763381759; x=1763986559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDxz4grUjwmEJBJvav8wuDrMfMnyUvBFkLLgfaCP/IM=;
        b=Oxnmxtj2fmAPi7SMmTO3JheFxF1sgm58WT3SzFMZy850XPdeMy2kSS3pSpNsRQhi7L
         QPZnHr/+Sy8Jwt9aO0OBHj4ySGaFAYeIMPP6gxasm/V4jFupSPN5kXi8HEmkkI/vaFhh
         5pirhWYFjqxiVKNPFD0pPTjX3T4JtSjDIOHgxmWZJS1VLHAKWNvcdTufPRle6ZqGp2hH
         G9XznihgKzYv2Teg7Vj50osodZK0v/o9VcnuCU9Facg9jWiyRbtPMUBUITVgycs6jF62
         1lbXZgJ9+Vbkuv/caQkfq2saOIciTp5w4MOTeyGKUCZ4NMG0IpeMLqUuceIfOpyX+jMU
         tV5g==
X-Forwarded-Encrypted: i=1; AJvYcCVXofhGWS7jGazuMC5pNyyd44TKYZRIauzbNH3WHSCIvbyyFSyx/SfNtsDXo73wzcwCVxPAolp34VMPCiU7Jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgiSScPYjNKGbAtoXBsUeQfwx9fO/Y5vLs2G28HP+2cZLH6QrZ
	LEa1xXE8npNzbpjQDuLFNIuNPqt0T5yPEn/3cBdOgvgTlBEj9Ug0hDl6Av2CMvQ38iyhJXEexT1
	Vpzx/WAT1qCAsonC8xxvR4DK1UiZ1zMiRRTVrv5F50v3gRdTgZ/A/zUEKiNd1PrB75OOAZLfYsM
	/1ZvYQeqlPGsdxJR3smDNKVteS5/ZJ7XCHX61wdOQ1V7UNtpXqV6OFjg==
X-Gm-Gg: ASbGncsdWECc4SFPIKLNR0STe18I/8irtlDNY+M8JYEmXjYmUg0dBwbM9+/gvLBQN1J
	K8gR6tiGnqE7j79efw6LLfvh0MtMxDxNTtI5cK6S//eZwgHC3B/1PlUFpNTwOI1veI2yNVuah76
	BbhP8pECwj5u4uRb5E49/vkuqelPtJK7QrMjK/NmgbOcvMQ5iH1VwIteEA
X-Received: by 2002:a53:d058:0:20b0:63f:b545:9981 with SMTP id 956f58d0204a3-641e74db9fbmr9164806d50.2.1763381759044;
        Mon, 17 Nov 2025 04:15:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbmQ+0pUmyUJR6cxc1mPicVqvRj7yBDdpq9vJmMkQLaojgv4EVixV46LW5x0u/lDiYjrLABsSxvrW2C8OnWCs=
X-Received: by 2002:a53:d058:0:20b0:63f:b545:9981 with SMTP id
 956f58d0204a3-641e74db9fbmr9164786d50.2.1763381758608; Mon, 17 Nov 2025
 04:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com> <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com>
In-Reply-To: <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 17 Nov 2025 13:15:21 +0100
X-Gm-Features: AWmQ_bn0qPo0yneLtQDYEMkaey4DVPnH8oxo0k_7Q6kbuEikIIrgrcUqNvobvhk
Message-ID: <CAJaqyWdgGmnaQ3=j-6S9E4mfPSHc872FQZfVna_eX_UnipX2UA@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R13zwLDE61BmRZN4HsocX2XqdMJzOhqWmHhNWwJcfkQ_1763381759
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Nov 14, 2025 at 7:25=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Add support for assigning Address Space Identifiers (ASIDs) to each=
 VQ
> > > > group.  This enables mapping each group into a distinct memory spac=
e.
> > > >
> > > > Now that the driver can change ASID in the middle of operation, the
> > > > domain that each vq address point is also protected by domain_lock.
> > >
> > > Maybe it's better to document what is protected by RCU and how.
> > >
> >
> > I added the _rcu annotation but I can expand it for sure. I can also
> > modify the commit message.
> >
> > > More below.
> > >
> > > >
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > I forgot to remove this, my bad!
> >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > v9:
> > > > * Replace mutex with RCU, as the vdpa map_ops can run from atomic
> > > >   context.
> > > >
> > > > v8:
> > > > * Revert the mutex to rwlock change, it needs proper profiling to
> > > >   justify it.
> > > >
> > > > v7:
> > > > * Take write lock in the error path (Jason).
> > > >
> > > > v6:
> > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_=
1) ?/
> > > >   (MST).
> > > > * Fix struct name not matching in the doc.
> > > >
> > > > v5:
> > > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_G=
ET_FD
> > > >   ioctl (Jason).
> > > > * Properly set domain bounce size to divide equally between nas (Ja=
son).
> > > > * Exclude "padding" member from the only >V1 members in
> > > >   vduse_dev_request.
> > > >
> > > > v4:
> > > > * Divide each domain bounce size between the device bounce size (Ja=
son).
> > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z=
)
> > > >   return; } (Jason)
> > > > * Change a bad multiline comment, using @ caracter instead of * (Ja=
son).
> > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > >
> > > > v3:
> > > > * Get the vduse domain through the vduse_as in the map functions
> > > >   (Jason).
> > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic numbe=
r
> > > >   (Jason)
> > > >
> > > > v2:
> > > > * Convert the use of mutex to rwlock.
> > > >
> > > > RFC v3:
> > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a l=
ower
> > > >   value to reduce memory consumption, but vqs are already limited t=
o
> > > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > >   VDUSE_IOTLB_GET_INFO.
> > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > * Move the umem mutex to asid struct so there is no contention betw=
een
> > > >   ASIDs.
> > > >
> > > > RFC v2:
> > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the firs=
t
> > > >   part of the struct is the same.
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 ++++++++++++++++++++-----=
----
> > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > >  2 files changed, 314 insertions(+), 109 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 97be04f73fbf..ff95ed56f22d 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include "linux/virtio_net.h"
> > > >  #include <linux/init.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/rcupdate.h>
> > > >  #include <linux/cdev.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/eventfd.h>
> > > > @@ -41,6 +42,7 @@
> > > >
> > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > @@ -86,7 +88,14 @@ struct vduse_umem {
> > > >         struct mm_struct *mm;
> > > >  };
> > > >
> > > > +struct vduse_as {
> > > > +       struct vduse_iova_domain *domain;
> > > > +       struct vduse_umem *umem;
> > > > +       struct mutex mem_lock;
> > > > +};
> > > > +
> > > >  struct vduse_vq_group {
> > > > +       struct vduse_as *as __rcu;
> > > >         struct vduse_dev *dev;
> > > >  };
> > > >
> > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > >         struct vduse_vdpa *vdev;
> > > >         struct device *dev;
> > > >         struct vduse_virtqueue **vqs;
> > > > -       struct vduse_iova_domain *domain;
> > > > +       struct vduse_as *as;
> > > >         char *name;
> > > >         struct mutex lock;
> > > >         spinlock_t msg_lock;
> > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > >         u32 vq_num;
> > > >         u32 vq_align;
> > > >         u32 ngroups;
> > > > -       struct vduse_umem *umem;
> > > > +       u32 nas;
> > > >         struct vduse_vq_group *groups;
> > > > -       struct mutex mem_lock;
> > > >         unsigned int bounce_size;
> > > >         struct mutex domain_lock;
> > > >  };
> > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_de=
v *dev, u8 status)
> > > >         return vduse_dev_msg_sync(dev, &msg);
> > > >  }
> > > >
> > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > > >                                   u64 start, u64 last)
> > > >  {
> > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse=
_dev *dev,
> > > >                 return -EINVAL;
> > > >
> > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > -       msg.req.iova.start =3D start;
> > > > -       msg.req.iova.last =3D last;
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > +               msg.req.iova.start =3D start;
> > > > +               msg.req.iova.last =3D last;
> > > > +       } else {
> > > > +               msg.req.iova_v2.start =3D start;
> > > > +               msg.req.iova_v2.last =3D last;
> > > > +               msg.req.iova_v2.asid =3D asid;
> > > > +       }
> > > >
> > > >         return vduse_dev_msg_sync(dev, &msg);
> > > >  }
> > > > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct file *f=
ile, poll_table *wait)
> > > >         return mask;
> > > >  }
> > > >
> > > > +/* Force set the asid to a vq group without a message to the VDUSE=
 device */
> > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > > +                                      unsigned int group, unsigned=
 int asid)
> > > > +{
> > > > +       /*
> > > > +        * Two concurrent updates to this pointer are valid as they=
 cannot
> > > > +        * point to an invalid region.  It is ok for them to race a=
s long as
> > > > +        * the readers see a consistent state through RCU.
> > > > +        */
> > > > +       rcu_assign_pointer(dev->groups[group].as, &dev->as[asid]);
> > >
> > > I'd expect at least a synchronize_rcu() here to wait for the read is =
done?
> > >
> >
> > What's the use? The only thing left here is to return from
> > vduse_set_group_asid_nomsg, and we don't need to wait for readers
> > here, do we?
>
> See below.
>
> >
> > > > +}
> > > > +
> > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > >  {
> > > >         int i;
> > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > >
> > > >         /* The coherent mappings are handled in vduse_dev_free_cohe=
rent() */
> > > > -       if (domain && domain->bounce_map)
> > > > -               vduse_domain_reset_bounce_map(domain);
> > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > +               struct vduse_iova_domain *domain =3D dev->as[i].dom=
ain;
> > > > +
> > > > +               if (domain && domain->bounce_map)
> > > > +                       vduse_domain_reset_bounce_map(domain);
> > > > +       }
> > > > +
> > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > >
> > > >         down_write(&dev->rwsem);
> > > >
> > > > @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_map(struc=
t vdpa_device *vdpa, u16 idx)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned=
 int group,
> > > > +                               unsigned int asid)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > +       int r;
> > > > +
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > +               return -EINVAL;
> > > > +
> > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > +       msg.req.vq_group_asid.group =3D group;
> > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > +
> > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > +       if (r < 0)
> > > > +               return r;
> > > > +
> > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct vdpa_dev=
ice *vdpa,
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > >         int ret;
> > > >
> > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX)=
;
> > > >         if (ret) {
> > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb)=
;
> > > >                 return ret;
> > > >         }
> > > >
> > > > @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vduse_vdpa_=
config_ops =3D {
> > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > >         .reset                  =3D vduse_vdpa_reset,
> > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > >         .free                   =3D vduse_vdpa_free,
> > > >  };
> > > > @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for_device(=
union virtio_map token,
> > > >                                              enum dma_data_directio=
n dir)
> > > >  {
> > > >         struct vduse_dev *vdev;
> > > > +       struct vduse_as *as;
> > > >         struct vduse_iova_domain *domain;
> > > >
> > > >         if (!token.group)
> > > >                 return;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > -
> > > > +       rcu_read_lock();
> > > > +       as =3D rcu_dereference(token.group->as);
> > > > +       domain =3D as->domain;
> > > > +       rcu_read_unlock();
> > > >         vduse_domain_sync_single_for_device(domain, dma_addr, size,=
 dir);
> > >
> > > This is suspicious, at least we should do rcu_read_unlock() after
> > > vduse_domain_sync_single_for_device(), otherwise I don't see how RCU
> > > works.
> > >
> >
> > RCU is protecting that the address space pointer of the vq group is
> > not modified concurrently with the access. Ideally, this should be a
> > full lock, but just making sure that all accesses from the reader are
> > coherent is enough. Userspace should expect nothing if it uses the map
> > and modifies the vq group ASID at the same time anyway, but the kernel
> > needs to be sure that it does not see intermediate states. TBH, we
> > could move to a READ_ONCE / WRITE_ONCE, would that be more clear?
>
> Using READ_ONCE/WRITE_ONCE() needs to make sure the ordering is
> handled correctly.
>
> But I meant what happens if
>
> [cpu0]rcu_read_lock()
> [cpu0]as =3D rcu_dereference(token.group->as)
> [cpu0]...
> [cpu0]rcu_read_unlock()
> [cpu1]rcu_assign_pointer(token.group->as)
> [cpu0]vduse_domain_sync_single_for_device()
>

That should go ok. What I'm trying to protect here is the iterations
in vduse_domain_sync_single_for_device -> vduse_domain_bounce.

I'm going to embed that function here in
vduse_dev_sync_single_for_device and omit RCU and some details to make
the point easier:

vduse_dev_sync_single_for_device(union virtio_map token, dma_addr_t
iova, size_t size, ...) {
  read_lock(&token.group->as->domain);
  while (size)
    map =3D token.group->as->domain->bounce_maps[iova];
    sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);

    ...
    page =3D token_group->as->domain->bounce_maps
    addr =3D kmap_local_page(page);
    do_bounce(map->orig_phys, addr, sz, dir);
    kunmap_local(addr);
    size -=3D sz;
    iova +=3D sz;
  }
  read_unlock(&token.group->as->domain);
}

Now, depending on the point where another execution thread changes
token_group->as and how the compiler has chosen to generate the
machine code, the outcome could be:
1) The domain read lock of one ASID is taken but the domain lock of
another as is unlocked.
2) We iterate until iova is ok for the ASID we're handling, but not
for the other one. So we access an invalid offset in
bounce_maps[iova].

And I guess there are other possible outcomes too.

So I need to make sure that the pointer accesses in all
vduse_domain_bounce is coherent. I'm ok if it takes the one before the
concurrent call to vduse_set_group_asid_nomsg or the one after that,
as the lifetime of all domains are bound to the device. But it cannot
change in the middle of the operation:

vduse_dev_sync_single_for_device(union virtio_map token, dma_addr_t
iova, size_t size, ...) {
  as =3D token.group->as;
  // Tell the compiler to never replace "as" by "token.group->as" after thi=
s.
  read_lock(&as->domain);
  while (size)
    map =3D as->domain->bounce_maps[iova];
    sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);

    ...
    page =3D as->domain->bounce_maps
    addr =3D kmap_local_page(page);
    do_bounce(map->orig_phys, addr, sz, dir);
    kunmap_local(addr);
    size -=3D sz;
    iova +=3D sz;
  }
  read_unlock(&as->domain);
}

That can be done in many ways. Probably the read_lock is already
enough but it is not explicit that it is protecting token.group->as,
and future changes could remove it. To me, RCU is the most clear way
to do it, but even a volatile read (READ_ONCE?) would do.

> If this is not an issue, RCU is not a must, but please explain why.
> If this is an issue, we need to fix it.
>
> It's basically a question that
>
> 1) should we need to wait for the DMA to be completed before assigning
> to the new as

I don't think so, it is valid to assign a new as and let the ongoing
operation to continue. It is racy and the operation could fail, but
the kernel just returns an error and doesn't access invalid memory or
similar.

> 2) should we track the set_group_asid() for the group that has pending
> DMA to avoid potential issue
>

No, the group will outlive the operation as it is bound to the device.

> >
> > The function vduse_domain uses its own lock to protect concurrent
> > access to the maps of the ASID itself, as they were needed before
> > implementing ASID already.
>
> Thanks
>
> >
> > > >  }
> > > >
> > > > @@ -868,14 +927,17 @@ static void vduse_dev_sync_single_for_cpu(uni=
on virtio_map token,
> > > >                                              enum dma_data_directio=
n dir)
> > > >  {
> > > >         struct vduse_dev *vdev;
> > > > +       struct vduse_as *as;
> > > >         struct vduse_iova_domain *domain;
> > > >
> > > >         if (!token.group)
> > > >                 return;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > -
> > > > +       rcu_read_lock();
> > > > +       as =3D rcu_dereference(token.group->as);
> > > > +       domain =3D as->domain;
> > > > +       rcu_read_unlock();
> > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, di=
r);
> > > >  }
> > > >
> > > > @@ -885,15 +947,21 @@ static dma_addr_t vduse_dev_map_page(union vi=
rtio_map token, struct page *page,
> > > >                                      unsigned long attrs)
> > > >  {
> > > >         struct vduse_dev *vdev;
> > > > +       struct vduse_as *as;
> > > >         struct vduse_iova_domain *domain;
> > > > +       dma_addr_t r;
> > > >
> > > >         if (!token.group)
> > > >                 return DMA_MAPPING_ERROR;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       rcu_read_lock();
> > > > +       as =3D rcu_dereference(token.group->as);
> > > > +       domain =3D as->domain;
> > > > +       rcu_read_unlock();
> > > > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir=
, attrs);
> > >
> > > Same here.
> > >
> > > Thanks
> > >
> >
>

