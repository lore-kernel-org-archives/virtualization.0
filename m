Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6934C140
	for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919757; cv=none; b=M+4Duz7dpKM8KGkaPMZ06l2wY4teCNYAJpvL2dDe7dXLR4ee18WeWNvPGw+I6ctQJ045NVoXqE1tw1ZQ1lfy3tmz1ZhHeJ1GaESqi/hQlsw5qQSqKID2BgV4jn3RYUj8SiGtVpuDJlmDjunv9DkpPOg05vetUmKhcC6g6+uhHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919757; c=relaxed/simple;
	bh=cKi5u5kKlJDSFWBeitxoarMtPoIQFmFvqpw5hBsjDas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr7skCMNrhTllljNwqc+tDKVlxWqrs0EiZsCkZJddjhuHyPbWaLqVHys8dtqlszpNI/I0U8mIIqG1GI0UsinzBlLsn1kaTMySdnjOGClR5RuMntjioFkLv+ycI2pf1NXilol9U6lYNjE9wf/jfPQmb6iHZCI6nPTM8lIlBMcZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOR0Nvsl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOR0Nvsl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761919754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uM4ttKk22d8PZmTgVE4g81Ky8Fy3SL6iz8meVLdYIsw=;
	b=YOR0Nvsl1yraC86Rtv0ftDcOMSEsMCxIWfyUV7ij3hDCvNMK5OgFIwoCdpfEtCT76F5vUv
	UFGsWfB0E1rIYWJE0efntIgL1ea4T0jeUYHh/zoEwjmEKhmWIAu0rv+Fsah4R346Cr/9B4
	ULq78pIHGysK+dni1jEcBoge4mGIh+E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-QZ6PEkmNP1qhc-sBDQ_Uog-1; Fri, 31 Oct 2025 10:09:12 -0400
X-MC-Unique: QZ6PEkmNP1qhc-sBDQ_Uog-1
X-Mimecast-MFC-AGG-ID: QZ6PEkmNP1qhc-sBDQ_Uog_1761919751
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-592f33729c6so1181236e87.0
        for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 07:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761919751; x=1762524551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uM4ttKk22d8PZmTgVE4g81Ky8Fy3SL6iz8meVLdYIsw=;
        b=TtwJfA8nQPyvEqA32soP2IcnW1YSCaiJ9azhhCPYmvYiayek0/ERuU5zqOD2Fbhb/R
         tODy1cUtGt8ecBmZPpJbUV7iqY6jFizDrXd9PdDMU6myxFnn35qRBYan7E/xi2rV2gs3
         +vljGSkuOrMBZ+Jucbgsm0E6ezmKE+ZScq6GCXroEL8c8yfGQ2kPn0d158osKEpYrZAG
         M1BeChT3CHDlAXRhYAVmh1M5tjnElMSa92R3yaw/CQRl/3amWRUqD4poGPRxcTMXqDJe
         6sSCIoXR7BVoOLg8RiFpe7wSxzBUmHxIM7zQfslrHEPsh046IJmQX1P5ml2s+eaMBhLu
         eMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMJaNLr7rEO7+XbwOLSPfEZmjfY3Dk4br1cSdqRiFYgVO4dEUlVY0/JjybISW/uL89uS6cBWa89mjADdipqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3F73OdgAEoAtmRpWRyjjTRJBZ1I1xALRvLZ4ieY4VHSh+Aswe
	dZwr6Y4mH6waZbJKhPwlLI5+7TyFF/wwpY6T5mC+CoGnys5eltiJOi1FDSqpdH4vP77bK+Eg4+a
	fvqSCNuiOHPKtFsSGocDzgT7DnhnjiXHue8GmAUalpMSax747/Zbgv5/tFny5AKbPCWmYdCWYQA
	CtzXbMqdcunQOpEePJKZdOVqitltmIFZBzJF+M5Zxl3C0=
X-Gm-Gg: ASbGncsccOTjP+mYFdlqbiBq6mNWA160FfnyFouCaAQlecigD7aKOeNYev2kSdP9Oc4
	4PfIoCoPq5kbaMajO0xTTDM9JPixv8OJ5xxp2ro6ggFbThf2c+ZoJgTXjFisgRH6McCdOvBG1J1
	dM4bS7reQOwTbdEflfieE02NU+rYHPVDb8opPw2iT/kOGGHrmv2ddplD15n2N1Iq92+mt/9kGBO
	9RCq39NNs1mHe/aOfQxrQKs8pL1EGUVXryctnjyaOblDg==
X-Received: by 2002:a05:6512:a93:b0:583:903e:b59d with SMTP id 2adb3069b0e04-5941d4ff177mr1243054e87.7.1761919750343;
        Fri, 31 Oct 2025 07:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPUSne/fXeoSzWHtk1fLIQjJ1IX5ONWCLElKOL4D6Rr46BElzxp0Xbz/bC6904Q7mtlL0eNE87lHPP2zSNEuM=
X-Received: by 2002:a05:6512:a93:b0:583:903e:b59d with SMTP id
 2adb3069b0e04-5941d4ff177mr1243048e87.7.1761919749860; Fri, 31 Oct 2025
 07:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
 <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com> <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
In-Reply-To: <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 31 Oct 2025 15:08:29 +0100
X-Gm-Features: AWmQ_bkK8-t8DBBNr6izZz4YnZoStha-_i4aQBGOg8SPJUsZ5oRy9LfhqixlVJU
Message-ID: <CAJaqyWe31w=Z--Sh6ufwvhaBsBaKypUjHzLy9qm6NyDJM-NgDQ@mail.gmail.com>
Subject: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XGuCJHFp43SBRaQdRHWEOGvzPmo3opCTdnwPl8sIW_A_1761919751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Add support for assigning Address Space Identifiers (ASIDs) to each=
 VQ
> > > > group.  This enables mapping each group into a distinct memory spac=
e.
> > > >
> > > > Now that the driver can change ASID in the middle of operation, the
> > > > domain that each vq address point is also protected by domain_lock.
> > > >
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
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
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++-----=
----
> > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -41,6 +41,7 @@
> > > >
> > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > @@ -86,7 +87,14 @@ struct vduse_umem {
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
> > > > +       struct vduse_as *as;
> > > >         struct vduse_dev *dev;
> > > >  };
> > > >
> > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > >         struct vduse_vdpa *vdev;
> > > >         struct device *dev;
> > > >         struct vduse_virtqueue **vqs;
> > > > -       struct vduse_iova_domain *domain;
> > > > +       struct vduse_as *as;
> > > >         char *name;
> > > >         struct mutex lock;
> > > >         spinlock_t msg_lock;
> > > > @@ -122,9 +130,8 @@ struct vduse_dev {
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
> > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vduse_de=
v *dev, u8 status)
> > > >         return vduse_dev_msg_sync(dev, &msg);
> > > >  }
> > > >
> > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > > >                                   u64 start, u64 last)
> > > >  {
> > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct vduse=
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
> > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct file *f=
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
> > > > +       mutex_lock(&dev->domain_lock);
> > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > +       mutex_unlock(&dev->domain_lock);
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
> > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(struc=
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
> > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa_dev=
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
> > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_vdpa_=
config_ops =3D {
> > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > >         .reset                  =3D vduse_vdpa_reset,
> > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > >         .free                   =3D vduse_vdpa_free,
> > > >  };
> > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_device(u=
nion virtio_map token,
> > > >                 return;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > -
> > > > +       mutex_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->as->domain;
> > > >         vduse_domain_sync_single_for_device(domain, dma_addr, size,=
 dir);
> > > > +       mutex_unlock(&vdev->domain_lock);
> > > >  }
> > > >
> > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(unio=
n virtio_map token,
> > > >                 return;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > -
> > > > +       mutex_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->as->domain;
> > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, di=
r);
> > > > +       mutex_unlock(&vdev->domain_lock);
> > > >  }
> > > >
> > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struc=
t page *page,
> > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(union vi=
rtio_map token, struct page *page,
> > > >  {
> > > >         struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > > +       dma_addr_t r;
> > > >
> > > >         if (!token.group)
> > > >                 return DMA_MAPPING_ERROR;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       mutex_lock(&vdev->domain_lock);
> > >
> > > The mutex_lock can't be used here since the dma ops might be called i=
n
> > > atomic context. And I think we can just remove it since creation and
> > > deletion operations of the iova domain are guaranteed not to execute
> > > concurrently with I/O operations.
> > >
> >
> > That would be great indeed! Can you expand on this, what protects here
> > from the moment the two syscalls are issues from userland?
> >
>
> The domain mutex lock is introduced in commit
> d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova domain
> creation"). It's used to prevent concurrent execution between
> vdpa_dev_add() and some vduse device ioctl which needs to access the
> iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dma ops
> would not be called until vdpa_dev_add() completed, so the mutex lock
> is not needed.
>

Yes, but the usage is extended here to also protect from concurrent
calls to vduse_dev_map_page and vduse_set_group_asid or similar.

So I guess the best is to replace it with a spinlock or RCU.

