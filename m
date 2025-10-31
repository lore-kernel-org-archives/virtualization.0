Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3330FC2D
	for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892290; cv=none; b=Qdtrj2azqc3JAMrGTtBfMW8gReLDqs1Kc1wIZWD2z8NAr46gzqTwrVMYXfgDUT/GRyl0KRGAHJP/w10dlcOJ/5YMH9poeUHWJ7tFzqfpHqoMsmsHiestPMiOUdQ9kCE4/62hebPcQY+IK0YHw5QjSm+MnRUcE0cLsHQnlSQdLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892290; c=relaxed/simple;
	bh=LYoxxD7A9LaJtKznfbw8DA6ubROWoQExBvQKqwzcF+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Movdc2HxLmoBGElniaiSAQIomygVGH4BHqvKD30pLzfIZNxqP6uOtBG2GmZeOEBbMD0Dmx9Ed6/x/cRNx12Ab8qGN6Pn1MqA7L3itA8OVJSDFqev5yty6/N2D2jWoqiUDPUVhnv2OrCHDLOw1xAgJXj+FOlQ31isiTcg3ySDqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtCfwl6J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtCfwl6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761892287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KOssj7wkA/xl6jWcLdWThOpLTHiPKSdvNkzYZXdE0U=;
	b=PtCfwl6JTruTnPbf31JB++wVSJ6DFBU3FbYj/7hlJ8DMNJMEuB0/LK1a6TbUiTXSsSXOf2
	K7vzgv9Qv9OtuEzD9SzDy7CAB01HT38g0yo1bETsPsQ6r7DxrOCnbh2Tbghypzl/SWJewX
	ZhJnvAbYLI105lrAwwvyEK69sfNcjsI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-FSv4jGuKNk2Op5os1sswhA-1; Fri, 31 Oct 2025 02:31:26 -0400
X-MC-Unique: FSv4jGuKNk2Op5os1sswhA-1
X-Mimecast-MFC-AGG-ID: FSv4jGuKNk2Op5os1sswhA_1761892285
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7848264ead5so29989297b3.1
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 23:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761892285; x=1762497085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KOssj7wkA/xl6jWcLdWThOpLTHiPKSdvNkzYZXdE0U=;
        b=qOyhSo5uLodZbkyuAcYT3VQF/A79Jg3tYq9JUSNdVP2MAanmkQcLMAi6iKYTdfeD9W
         NfnUfRfAJL6gHJSpmGRgXYRhu/icl6+95SmxS/MOqjM1mA21D76zcJcc6F8BN3Pte3Zn
         KI+acqaKBj63t5VXwGATJyBfEYe7swO3Le/UTFLaToYKIfzDnfx5BZNs+rcZ2QA6RqYk
         xefyCDQgXr/uYNP1t76QLkDlKsYPySXuzO/WhM67IsJxqyK6BTTmGfIF1cMZRDk7yfYf
         0/FfC/GJvcs99XeyRqtchokfJUZFKnHFuPy0+HvcdXoQD4mtb5m7DyRMeRr3Qt7+wXfX
         9kjw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Qey5aFou5TlgqkendYQXs940KSzbFPPZIHKCRJnnH/AlZtYkh088QZXzbDQy8ZNESxBhVFrxc4w2y2hmpw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5Gd9HfuVZGi3CXuU3kPastAX4IKJ7FIltkb4aKcev+e3NK9kb
	jCSY67rfJUDze935ai4b5ccku2eOt+qi/Nx77mRSw6ltZS5PUVWSalHpDMIGUUqOKYMdfhn5rYd
	Ql80z+IdYdQkvQFCxV7+1p9RtKIRI8Zq8T0andP8UiIzg29M0B+B0UnjMNuH9Wj7AZHPSLe+pfI
	0H/yJ8U6WZBt6BZHOEnR7AlJfGy7AAPWKOpB3NgI/WMoY=
X-Gm-Gg: ASbGncvy+K7nRUWfiWWU+phRJPHVY55xLq4UI5bZxP8zgapUEd//oibFTmD41P5+Nkz
	NdIMRL9FZv2Xh3MqXfOjJzujtSndtqNb89uBiNaifFaQu6BoeR6QCnBhJKGX6jpWJt51u7kMEL5
	fso3NsnlYIPQ+H+dOUNtg1ztRCIfRBDKm/WvQwaZ/+gkPnlcyhywLAq1xNcP4jSZXXvbK2N0Xee
	goJfEMjUMJnSt2vc6xmYru2/zETALKPhwa3aoSH3Vc93w==
X-Received: by 2002:a05:690c:4c13:b0:780:f22a:5633 with SMTP id 00721157ae682-786484c348dmr22010737b3.34.1761892285215;
        Thu, 30 Oct 2025 23:31:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0pYcVMVFc96qXD6K/Ql1OUWHm6ne7uyRXVYQ20rOyxJK0kOMWBQTxd8VPgJa41heC2gwXU87aR5LL3XdlGRM=
X-Received: by 2002:a05:690c:4c13:b0:780:f22a:5633 with SMTP id
 00721157ae682-786484c348dmr22010557b3.34.1761892284818; Thu, 30 Oct 2025
 23:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
In-Reply-To: <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 31 Oct 2025 07:30:47 +0100
X-Gm-Features: AWmQ_bm8WJvnMLLzQzvgkCul3JNIK5iJLUIxcaAGBScA42BuVqe75HotHCNVTtI
Message-ID: <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x0O0PaMfeXOEDwLxJw3mXrHhwfqaa5VhpcAusqbn9qg_1761892285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
>
> On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > Now that the driver can change ASID in the middle of operation, the
> > domain that each vq address point is also protected by domain_lock.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v8:
> > * Revert the mutex to rwlock change, it needs proper profiling to
> >   justify it.
> >
> > v7:
> > * Take write lock in the error path (Jason).
> >
> > v6:
> > * Make vdpa_dev_add use gotos for error handling (MST).
> > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?=
/
> >   (MST).
> > * Fix struct name not matching in the doc.
> >
> > v5:
> > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_F=
D
> >   ioctl (Jason).
> > * Properly set domain bounce size to divide equally between nas (Jason)=
.
> > * Exclude "padding" member from the only >V1 members in
> >   vduse_dev_request.
> >
> > v4:
> > * Divide each domain bounce size between the device bounce size (Jason)=
.
> > * revert unneeded addr =3D NULL assignment (Jason)
> > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> >   return; } (Jason)
> > * Change a bad multiline comment, using @ caracter instead of * (Jason)=
.
> > * Consider config->nas =3D=3D 0 as a fail (Jason).
> >
> > v3:
> > * Get the vduse domain through the vduse_as in the map functions
> >   (Jason).
> > * Squash with the patch creating the vduse_as struct (Jason).
> > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> >   (Jason)
> >
> > v2:
> > * Convert the use of mutex to rwlock.
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> >   VDUSE_IOTLB_GET_INFO.
> > * Use of array_index_nospec in VDUSE device ioctls.
> > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > * Move the umem mutex to asid struct so there is no contention between
> >   ASIDs.
> >
> > RFC v2:
> > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> >   part of the struct is the same.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++---------
> >  include/uapi/linux/vduse.h         |  53 ++++-
> >  2 files changed, 292 insertions(+), 109 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 97be04f73fbf..c6909d73d06d 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -41,6 +41,7 @@
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > +#define VDUSE_DEV_MAX_AS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -86,7 +87,14 @@ struct vduse_umem {
> >         struct mm_struct *mm;
> >  };
> >
> > +struct vduse_as {
> > +       struct vduse_iova_domain *domain;
> > +       struct vduse_umem *umem;
> > +       struct mutex mem_lock;
> > +};
> > +
> >  struct vduse_vq_group {
> > +       struct vduse_as *as;
> >         struct vduse_dev *dev;
> >  };
> >
> > @@ -94,7 +102,7 @@ struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> >         struct vduse_virtqueue **vqs;
> > -       struct vduse_iova_domain *domain;
> > +       struct vduse_as *as;
> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > @@ -122,9 +130,8 @@ struct vduse_dev {
> >         u32 vq_num;
> >         u32 vq_align;
> >         u32 ngroups;
> > -       struct vduse_umem *umem;
> > +       u32 nas;
> >         struct vduse_vq_group *groups;
> > -       struct mutex mem_lock;
> >         unsigned int bounce_size;
> >         struct mutex domain_lock;
> >  };
> > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vduse_dev *d=
ev, u8 status)
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> >
> > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> >                                   u64 start, u64 last)
> >  {
> >         struct vduse_dev_msg msg =3D { 0 };
> > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev=
 *dev,
> >                 return -EINVAL;
> >
> >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > -       msg.req.iova.start =3D start;
> > -       msg.req.iova.last =3D last;
> > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > +               msg.req.iova.start =3D start;
> > +               msg.req.iova.last =3D last;
> > +       } else {
> > +               msg.req.iova_v2.start =3D start;
> > +               msg.req.iova_v2.last =3D last;
> > +               msg.req.iova_v2.asid =3D asid;
> > +       }
> >
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct file *file,=
 poll_table *wait)
> >         return mask;
> >  }
> >
> > +/* Force set the asid to a vq group without a message to the VDUSE dev=
ice */
> > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > +                                      unsigned int group, unsigned int=
 asid)
> > +{
> > +       mutex_lock(&dev->domain_lock);
> > +       dev->groups[group].as =3D &dev->as[asid];
> > +       mutex_unlock(&dev->domain_lock);
> > +}
> > +
> >  static void vduse_dev_reset(struct vduse_dev *dev)
> >  {
> >         int i;
> > -       struct vduse_iova_domain *domain =3D dev->domain;
> >
> >         /* The coherent mappings are handled in vduse_dev_free_coherent=
() */
> > -       if (domain && domain->bounce_map)
> > -               vduse_domain_reset_bounce_map(domain);
> > +       for (i =3D 0; i < dev->nas; i++) {
> > +               struct vduse_iova_domain *domain =3D dev->as[i].domain;
> > +
> > +               if (domain && domain->bounce_map)
> > +                       vduse_domain_reset_bounce_map(domain);
> > +       }
> > +
> > +       for (i =3D 0; i < dev->ngroups; i++)
> > +               vduse_set_group_asid_nomsg(dev, i, 0);
> >
> >         down_write(&dev->rwsem);
> >
> > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(struct vd=
pa_device *vdpa, u16 idx)
> >         return ret;
> >  }
> >
> > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int=
 group,
> > +                               unsigned int asid)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +       struct vduse_dev_msg msg =3D { 0 };
> > +       int r;
> > +
> > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > +               return -EINVAL;
> > +
> > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > +       msg.req.vq_group_asid.group =3D group;
> > +       msg.req.vq_group_asid.asid =3D asid;
> > +
> > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > +       if (r < 0)
> > +               return r;
> > +
> > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > +       return 0;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
*vdpa,
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >         int ret;
> >
> > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> >         if (ret)
> >                 return ret;
> >
> > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> >         if (ret) {
> > -               vduse_domain_clear_map(dev->domain, iotlb);
> > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> >                 return ret;
> >         }
> >
> > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .set_group_asid         =3D vduse_set_group_asid,
> >         .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_device(union=
 virtio_map token,
> >                 return;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       mutex_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> > +       mutex_unlock(&vdev->domain_lock);
> >  }
> >
> >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(union vi=
rtio_map token,
> >                 return;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       mutex_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> > +       mutex_unlock(&vdev->domain_lock);
> >  }
> >
> >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct pa=
ge *page,
> > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(union virtio=
_map token, struct page *page,
> >  {
> >         struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> > +       dma_addr_t r;
> >
> >         if (!token.group)
> >                 return DMA_MAPPING_ERROR;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       mutex_lock(&vdev->domain_lock);
>
> The mutex_lock can't be used here since the dma ops might be called in
> atomic context. And I think we can just remove it since creation and
> deletion operations of the iova domain are guaranteed not to execute
> concurrently with I/O operations.
>

That would be great indeed! Can you expand on this, what protects here
from the moment the two syscalls are issues from userland?

