Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AA1411DE
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153997; cv=none; b=U3FuzgNvgL+TA++nuIeFpIiDEZhSBxDfIaXUeJECjT/rDlPP4NMlrsyoJcnOj7d1YIKDCCUgMCVEdzReJiLV4mrLLgxZYSYhCBl3DAliMYmQDU0v4UXCsco2wiixbiznrAvb0eRTaI8HdoL8Br0X6LwoTyiO2QfgwDPFs3X9wvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153997; c=relaxed/simple;
	bh=evbjhUsyPEtlXMWP7fJNY7yQ2DKYSAvfprUo+XQmWKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Efs14Vfjkhf5WSPqYt4KD3TLr00yhT7GU1kszozkB7CmZl5wgo4cexAZ9OFRAGoCoxT++iuLCLnIYYqzz7wsu3thi9pMz71TLf2qicQ6OvLb8g0eDRBsopm+O2FretYLnDDeMyFYBqsH/3AMaxGlwJFIJ/ayo/tYrKJri1ueGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I6oY8Dg/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I6oY8Dg/"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340ba29d518so1426683a91.3
        for <virtualization@lists.linux.dev>; Sun, 02 Nov 2025 23:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762153994; x=1762758794; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+arHJcPoueo1Yi6g0ODC3rA/HeIdq0Ft6URIehR7l9M=;
        b=I6oY8Dg/voyKHR9jkSclU9fdV9+jQxMVUztKftzk2CLKgx1RuD7el1Q+qmCK53CZe8
         o0oAm+Yg8g80uzGWFUFkKoD4vFiMXTClQ2wYiwZ6LfMt3hOofwVQHbXMDFwQd4zxFTxf
         CvK24jhpHvKdCAf3xTEk43NmVxxtjvw3zdXYaW+f1eADf2VEk53X2yUc07uUko2L2cnR
         6ELuczWrDUbBvzEXynOIqmM+lhKwOaKrUe4v0xBEMplCbslvWj28eEIytKho4TWHJTPv
         afsUY8ttjQmg56m3XNtMVGMqVlEwtAts45NZgp+FsOz7JvyXJzvcjoOp0+rCGVQ5ewY3
         8aLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762153994; x=1762758794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+arHJcPoueo1Yi6g0ODC3rA/HeIdq0Ft6URIehR7l9M=;
        b=Ca4eWykFWNi3uVoO0AN9sUNJ+V9+z2GkUo7Saz5s9RnBFawj/iHjjtBRRxhZqGtBwP
         +cCtRI3JD/eUNgXkzRrUhmS3wX49BY3lUr+4GrUn5sH4nzdS+7Dz/3IpjbFXmI+ujfg+
         pRqip3q22qsoWm4QUX6HS1EHCi/r7xc91ZY1zIxUoAGs5EbRZF2YeB3qN9f7bQkPHpdx
         Ni+I4LXh2T73+E9hE8cMC4xkbhT7v+ty9mLxBn0q0Znq4o9vhzN4KbjoH3uzF0LOiO0E
         JCwvmMiEpO2NpU3x37tfPKtSPfvzoVAFDjbXBCiaBNiEVdKAaH5QE0x+SAicOr4hIeLD
         kz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoOEx94mYmeJwcq2vrsxpua2MVbmwyZqJTzmmAHVbjaiLkU/MhNJCdo1hn/Mpzxpktm9ERcE+6YgLQwApHqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwiPKWf5u0qi0/QWEplp9GwTQcPkw4rmw5wHu1hc2hRnAPdjc8
	0LUovJHXVUIvYyPxTwvR4dcSItwGUMoPqbUDuusHfrCNcmOwPa0A11H0+KmVUbGqazK+aG4Z7fW
	WTA+MdK3ZDjjyLqucvB1jfYwi1th28Yga3vvob8AP
X-Gm-Gg: ASbGncv8VUU6v1Elf6r6pBk2njx0xedOKwZs720BsAKXv/aKBRfmTQeAFAXeBBYElNM
	fHKB1AQTAAmeXJHNVW66MtHptLgAM2Zr2go2qPFOP78DNQhc2tM1vvDIRzcuXMcGMu+hJCOS8PN
	ZvuAmTbH6aUroGHSyf5qOjn/mPb5LrgOWgJS7JZRFwL9KKD4dOj8EjVuWXdmHZ+JAIoWSrEwfeP
	lWActBTbED1eQPfE0GYRfYVExng2BGP9eZsdJJ1B3A79Rl3I5jUzGqJor5+4odmV4Ck5MqULVqB
	nMU7dFoYaIYnDWCczeVP5FktfX8H
X-Google-Smtp-Source: AGHT+IGJrw3q48WCws5tAboLKA5HMrjEMWxK5exJRzbYZ4564Qe9iW/p3tDgnBsJrrTFDzBQhennpwUHlSTKJlLdqME=
X-Received: by 2002:a17:90b:1844:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-3410134ab67mr4207631a91.28.1762153994360; Sun, 02 Nov 2025
 23:13:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
 <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
 <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
 <CAJaqyWe31w=Z--Sh6ufwvhaBsBaKypUjHzLy9qm6NyDJM-NgDQ@mail.gmail.com>
 <CACycT3sKofWfottqAzRWscCWNaodnqXiFtvuhSv7Pqz1F0+90A@mail.gmail.com> <CAJaqyWdzeOsTG2YT3wJCuoFMffDmGXAsPp4GwL+Jq1h-O8h9SQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdzeOsTG2YT3wJCuoFMffDmGXAsPp4GwL+Jq1h-O8h9SQ@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 3 Nov 2025 15:13:03 +0800
X-Gm-Features: AWmQ_bnykAMm-QJbaW-_COhdsSaaNbVE6YqgjS_EX3fUVMKS6M_CbkcsHb9IiIA
Message-ID: <CACycT3u4AS3=8sQuDhLWoyg5ExTPyfDf8GTB23pAepGZizMBhQ@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 2:41=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Nov 3, 2025 at 3:55=E2=80=AFAM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Fri, Oct 31, 2025 at 10:09=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@bytedan=
ce.com> wrote:
> > > >
> > > > On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@by=
tedance.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <epe=
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
> > > > > > >
> > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > ---
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
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 +++++++++++++++++++=
+---------
> > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -41,6 +41,7 @@
> > > > > > >
> > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > @@ -86,7 +87,14 @@ struct vduse_umem {
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
> > > > > > > +       struct vduse_as *as;
> > > > > > >         struct vduse_dev *dev;
> > > > > > >  };
> > > > > > >
> > > > > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > > > > >         struct vduse_vdpa *vdev;
> > > > > > >         struct device *dev;
> > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > +       struct vduse_as *as;
> > > > > > >         char *name;
> > > > > > >         struct mutex lock;
> > > > > > >         spinlock_t msg_lock;
> > > > > > > @@ -122,9 +130,8 @@ struct vduse_dev {
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
> > > > > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vd=
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
> > > > > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct=
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
> > > > > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct f=
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
> > > > > > > +       mutex_lock(&dev->domain_lock);
> > > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > > +       mutex_unlock(&dev->domain_lock);
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
> > > > > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map=
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
> > > > > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vd=
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
> > > > > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse=
_vdpa_config_ops =3D {
> > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinit=
y,
> > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > >  };
> > > > > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_de=
vice(union virtio_map token,
> > > > > > >                 return;
> > > > > > >
> > > > > > >         vdev =3D token.group->dev;
> > > > > > > -       domain =3D vdev->domain;
> > > > > > > -
> > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > +       domain =3D token.group->as->domain;
> > > > > > >         vduse_domain_sync_single_for_device(domain, dma_addr,=
 size, dir);
> > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > >  }
> > > > > > >
> > > > > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map t=
oken,
> > > > > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cp=
u(union virtio_map token,
> > > > > > >                 return;
> > > > > > >
> > > > > > >         vdev =3D token.group->dev;
> > > > > > > -       domain =3D vdev->domain;
> > > > > > > -
> > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > +       domain =3D token.group->as->domain;
> > > > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, si=
ze, dir);
> > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > >  }
> > > > > > >
> > > > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token,=
 struct page *page,
> > > > > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(un=
ion virtio_map token, struct page *page,
> > > > > > >  {
> > > > > > >         struct vduse_dev *vdev;
> > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > +       dma_addr_t r;
> > > > > > >
> > > > > > >         if (!token.group)
> > > > > > >                 return DMA_MAPPING_ERROR;
> > > > > > >
> > > > > > >         vdev =3D token.group->dev;
> > > > > > > -       domain =3D vdev->domain;
> > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > >
> > > > > > The mutex_lock can't be used here since the dma ops might be ca=
lled in
> > > > > > atomic context. And I think we can just remove it since creatio=
n and
> > > > > > deletion operations of the iova domain are guaranteed not to ex=
ecute
> > > > > > concurrently with I/O operations.
> > > > > >
> > > > >
> > > > > That would be great indeed! Can you expand on this, what protects=
 here
> > > > > from the moment the two syscalls are issues from userland?
> > > > >
> > > >
> > > > The domain mutex lock is introduced in commit
> > > > d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova domain
> > > > creation"). It's used to prevent concurrent execution between
> > > > vdpa_dev_add() and some vduse device ioctl which needs to access th=
e
> > > > iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dma op=
s
> > > > would not be called until vdpa_dev_add() completed, so the mutex lo=
ck
> > > > is not needed.
> > > >
> > >
> > > Yes, but the usage is extended here to also protect from concurrent
> > > calls to vduse_dev_map_page and vduse_set_group_asid or similar.
> > >
> > > So I guess the best is to replace it with a spinlock or RCU.
> > >
> >
> > OK, I see, we simply aim to prevent concurrent access to the group->as
> > variable here. But I wonder if the .set_group_asid function can be
> > called during I/O.
>
> At least a malicious userland app could do it.
>
> > I think the unmap_page() would fail if we change
> > the group->as between map_page() and unmap_page().
>
> I guess a SIGSEGV or similar could be a valid outcome of that, but we
> need to protect the "as" pointer anyway.
>
> > Besides, it seems
> > that .set_group_asid is only called in the vhost-vdpa case currently,
> > but the dma ops such as map_page/unmap_page only service the
> > virtio-vdpa case, so they would not be called concurrently with
> > .set_group_asid now.
> >
>
> That's totally true but a malicious app can do it anyway. So it is
> better to protect it properly.
>

Actually there is no interface for userspace to call .set_group_asid
if the vduse device is binded to the virtio-vdpa driver.

> Preparing a new version with a spinlock or RCU, thanks!
>

If so, we'd better introduce a new RCU lock here rather than using the
domain lock.

Thanks,
Yongji
