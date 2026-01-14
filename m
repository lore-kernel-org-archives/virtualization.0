Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9059322C6D
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378934; cv=none; b=Rg7+irMlNO0h8Sry0RjI5ZHlS5CLJ+Vj2sIil1rvFDd89UincMW6gFGy/Upf2N3FeWY9yxSVg6RKL2I6cJkbzI6/TAeWvqbQOKVtSvIYeIDTC7zYXDL7uJnXHxL/Y6kDYmeoyAQJYdLIaPBUBnJowQYfww/hR9PJ0b6NNJxZQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378934; c=relaxed/simple;
	bh=JMC0lK/dGegpvRoxB8pjMqk2FEznq4nyvgRJN+sXLV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED18BNf0W8FA1oyt/IqiyYQylD5wjlUEdrn8j2xzmaPXnGgwTNpY75LeNtr3f8m07F0+YrDN8HeMgMt+pcHFWSxI5lTq9p0LOd2xg7+psTSrxnbtGm9G0D72RIRIv9kSt2c6DStzOFp0ZMUMdQnTbB93vXM10mc7QzcjlEhkuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWOvGxP1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWOvGxP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768378927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaqbAyWIfkI2QiFbL6cRhZyKmh1Wdh2UMd2W7NWfl1w=;
	b=PWOvGxP1sll6Nw2nmeDJis24sfWGYhA1EsuiKajfGNwTt7b5z27R1udZzDi+eQj7MT+HL9
	K0MV1yKrS1A6A7yOkmlGPAt3/XSrlccEDjqtuecCbiw43Vpo9BZFA+JJlPnjslWp+byuiv
	6arwDoYi9RCjgdnDfP1cULTZ37LrAYE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-7YHy6WxrO7uosu3mUT2b2g-1; Wed, 14 Jan 2026 03:22:05 -0500
X-MC-Unique: 7YHy6WxrO7uosu3mUT2b2g-1
X-Mimecast-MFC-AGG-ID: 7YHy6WxrO7uosu3mUT2b2g_1768378924
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59b7972367fso2907232e87.1
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 00:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378924; x=1768983724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eaqbAyWIfkI2QiFbL6cRhZyKmh1Wdh2UMd2W7NWfl1w=;
        b=hPpf2Gkf3zdV5h+ab/ZifOabFlN1CsPomgss8eKhVmlJvTB+sw/1QPInS64emZdw/c
         SgbBgaUeE/mkmwLfXmBF9RRvHtVY+qT0M3zYvMETpQDZV8IO8HxEFSYbVMq0VWoGPfhH
         r/H/D+jZ//yIirokyxz0Cjdusd6ZFv8AwbJRIiV7iMhdo8P+40NKO6LeVo2lAXeDEVJR
         YpaExNFOupGuyJSDlsbKlDbpMHdKDpJE9igWsQLMzhbhDOBl3QzMbA/WBk/GcvQ1pkJs
         x62bJ6vV3zspgqZQUyliKTG5IE4i8U2FczOFZVlGlPqqDVSpgtQo7iKDcd22zUNKRWUm
         mOyg==
X-Forwarded-Encrypted: i=1; AJvYcCVdQ05ejcnfN6Yws1J09V73qNDeBIg/FCL6+CuJ/ZQvjKURHj2YDYNj4cU0+oiJOkMCZMuQrI9HTRJQ27g6qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmIMSlt8p9v1sFyRBLNuGve7QK4rgZ2RDwXxUuC/ulWozXb51g
	oUNlIPpldjBpyFC91KHJ0AlQ2vWKzqWAD3LFcn0T7KyDmganPERVBhVOquZPcCq62FX2FBQsQTu
	NV+GEuNNepnIjfad88xAE3TG/XZtHkoPaK31YSNpJ3GWPma2ewFJLZzRy7zaGX/R8JweaGzPI3D
	nbt96CC8hWq/ksgedJ3zhdf7iO2QBhgKOCvdcXl7nIdvc=
X-Gm-Gg: AY/fxX5N9qU6iV9M9JJkJIFrPTHRD7lTS534P6QBiaJnkm4CBLkPk2Q11cgtVr4oFdO
	puFoiz4ZtcdatEHyQ3i3IwEjZ2jXiBbRdiJw5r9DCia4c+zIQ2sQDxSnL9RVvpluq6h07LcTHKl
	SQyrayqREVfztbD2RTlAwIO8yt+pcNGF71FtelcugF+3J8gIGZxJCgmMyz1vKczT5Ezw==
X-Received: by 2002:a05:6512:a96:b0:59a:123e:69ab with SMTP id 2adb3069b0e04-59ba152456cmr474074e87.10.1768378923136;
        Wed, 14 Jan 2026 00:22:03 -0800 (PST)
X-Received: by 2002:a05:6512:a96:b0:59a:123e:69ab with SMTP id
 2adb3069b0e04-59ba152456cmr474052e87.10.1768378922304; Wed, 14 Jan 2026
 00:22:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-12-eperezma@redhat.com>
 <CACGkMEsg+LPe7K7m85+CffGHtJqMhdMSu7GcegbKvTq6SCFBZQ@mail.gmail.com>
 <CAJaqyWebFjFcrg_us+r5i0-04r_OCu-L0LaEROo0bpX6wMhn5w@mail.gmail.com> <CACGkMEvivccnwrVfWwzBoW7L01nEi13k=5p4n86vU5NExCq_VA@mail.gmail.com>
In-Reply-To: <CACGkMEvivccnwrVfWwzBoW7L01nEi13k=5p4n86vU5NExCq_VA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 14 Jan 2026 09:21:24 +0100
X-Gm-Features: AZwV_QgNsMx0L8DeaAciKV9RIoYSpBVQFx7Mx8h01k_YV2N0VAgnZuxWg4FlDmQ
Message-ID: <CAJaqyWeyDqO0SMaOr9j=qsVAY05mg6VqLrbEGgVNp7bNANv=-g@mail.gmail.com>
Subject: Re: [PATCH v11 11/12] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E8rb9zOlg8RYNIQ7wHiJoXJgcEQukbmNfKPvTB0g5x8_1768378924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Jan 13, 2026 at 10:39=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Tue, Jan 13, 2026 at 7:23=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Jan 9, 2026 at 11:25=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Add support for assigning Address Space Identifiers (ASIDs) to each=
 VQ
> > > > group.  This enables mapping each group into a distinct memory spac=
e.
> > > >
> > > > The vq group to ASID association is protected by a rwlock now.  But=
 the
> > > > mutex domain_lock keeps protecting the domains of all ASIDs, as som=
e
> > > > operations like the one related with the bounce buffer size still
> > > > requires to lock all the ASIDs.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > >
> > > > ---
> > > > Future improvements can include performance optimizations on top li=
ke
> > > > ore to RCU or thread synchronized atomics, or hardening by tracking=
 ASID
> > > > or ASID hashes on unused bits of the DMA address.
> > > >
> > > > Tested virtio_vdpa by adding manually two threads in vduse_set_stat=
us:
> > > > one of them modifies the vq group 0 ASID and the other one map and =
unmap
> > > > memory continuously.  After a while, the two threads stop and the u=
sual
> > > > work continues.  Test with version 0, version 1 with the old ioctl,=
 and
> > > > verion 1 with the new ioctl.
> > > >
> > > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  =
A few
> > > > workaround were needed in some parts:
> > > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forw=
ard
> > > >   the enable message to the userland device.  This will be solved i=
n the
> > > >   future.
> > > > * Share the suspended state between all vhost devices in QEMU:
> > > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947=
.html
> > > > * Implement a fake VDUSE suspend vdpa operation callback that alway=
s
> > > >   returns true in the kernel.  DPDK suspend the device at the first
> > > >   GET_VRING_BASE.
> > > > * Remove the CVQ blocker in ASID.
> > > >
> > > > The driver vhost_vdpa was also tested with version 0, version 1 wit=
h the
> > > > old ioctl, version 1 with the new ioctl but only one ASID, and vers=
ion 1
> > > > with many ASID.
> > >
> > > I think we'd better update the Documentation/userspace-api/vduse.rst
> > > for the new uAPI.
> > >
> >
> > Good point! I'll do it for the next version, thanks!
> >
> > > >
> > > > ---
> > > > v11:
> > > > * Remove duplicated free_pages_exact in vduse_domain_free_coherent
> > > >   (Jason).
> > > > * Do not take the vq groups lock if nas =3D=3D 1.
> > > > * Do not reset the vq group ASID in vq reset (Jason).  Removed extr=
a
> > > >   function vduse_set_group_asid_nomsg, not needed anymore.
> > > > * Move the vduse_iotlb_entry_v2 argument to a new ioctl, as argumen=
t
> > > >   didn't match the previous VDUSE_IOTLB_GET_FD.
> > > > * Move the asid < dev->nas check to vdpa core.
> > > >
> > > > v10:
> > > > * Back to rwlock version so stronger locks are used.
> > > > * Take out allocations from rwlock.
> > > > * Forbid changing ASID of a vq group after DRIVER_OK (Jason)
> > > > * Remove bad fetching again of domain variable in
> > > >   vduse_dev_max_mapping_size (Yongji).
> > > > * Remove unused vdev definition in vdpa map_ops callbacks (kernel t=
est
> > > >   robot).
> > > >
> > > > v9:
> > > > * Replace mutex with rwlock, as the vdpa map_ops can run from atomi=
c
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
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 392 ++++++++++++++++++++-----=
----
> > > >  include/uapi/linux/vduse.h         |  63 ++++-
> > > >  2 files changed, 333 insertions(+), 122 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index bf437816fd7d..8227b5e9f3f6 100644
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
> > > > @@ -86,7 +87,15 @@ struct vduse_umem {
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
> > > > +       rwlock_t as_lock;
> > > > +       struct vduse_as *as; /* Protected by as_lock */
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
> > > > @@ -439,11 +453,14 @@ static __poll_t vduse_dev_poll(struct file *f=
ile, poll_table *wait)
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
> > > >
> > > >         down_write(&dev->rwsem);
> > > >
> > > > @@ -622,6 +639,31 @@ static union virtio_map vduse_get_vq_map(struc=
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
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1)
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
> > > > +       write_lock(&dev->groups[group].as_lock);
> > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > +       write_unlock(&dev->groups[group].as_lock);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -793,13 +835,13 @@ static int vduse_vdpa_set_map(struct vdpa_dev=
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
> > > > @@ -842,6 +884,7 @@ static const struct vdpa_config_ops vduse_vdpa_=
config_ops =3D {
> > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > >         .reset                  =3D vduse_vdpa_reset,
> > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > >         .free                   =3D vduse_vdpa_free,
> > > >  };
> > > > @@ -850,32 +893,38 @@ static void vduse_dev_sync_single_for_device(=
union virtio_map token,
> > > >                                              dma_addr_t dma_addr, s=
ize_t size,
> > > >                                              enum dma_data_directio=
n dir)
> > > >  {
> > > > -       struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > >
> > > >         if (!token.group)
> > > >                 return;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_lock(&token.group->as_lock);
> > >
> > > I suggest to factor this and unlock out into helpers.
> > >
> >
> > I'm moving to scroped guards.
> >
> > > >
> > > > +       domain =3D token.group->as->domain;
> > > >         vduse_domain_sync_single_for_device(domain, dma_addr, size,=
 dir);
> > > > +
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > >  }
> > > >
> > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > > >                                              dma_addr_t dma_addr, s=
ize_t size,
> > > >                                              enum dma_data_directio=
n dir)
> > > >  {
> > > > -       struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > >
> > > >         if (!token.group)
> > > >                 return;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_lock(&token.group->as_lock);
> > > >
> > > > +       domain =3D token.group->as->domain;
> > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, di=
r);
> > > > +
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > >  }
> > > >
> > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struc=
t page *page,
> > > > @@ -883,38 +932,45 @@ static dma_addr_t vduse_dev_map_page(union vi=
rtio_map token, struct page *page,
> > > >                                      enum dma_data_direction dir,
> > > >                                      unsigned long attrs)
> > > >  {
> > > > -       struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > > +       dma_addr_t r;
> > > >
> > > >         if (!token.group)
> > > >                 return DMA_MAPPING_ERROR;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_lock(&token.group->as_lock);
> > > > +       domain =3D token.group->as->domain;
> > > > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir=
, attrs);
> > > >
> > > > -       return vduse_domain_map_page(domain, page, offset, size, di=
r, attrs);
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > > +
> > > > +       return r;
> > > >  }
> > > >
> > > >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_=
t dma_addr,
> > > >                                  size_t size, enum dma_data_directi=
on dir,
> > > >                                  unsigned long attrs)
> > > >  {
> > > > -       struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > >
> > > >         if (!token.group)
> > > >                 return;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_lock(&token.group->as_lock);
> > > > +
> > > > +       domain =3D token.group->as->domain;
> > > > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs)=
;
> > > >
> > > > -       return vduse_domain_unmap_page(domain, dma_addr, size, dir,=
 attrs);
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > >  }
> > > >
> > > >  static void *vduse_dev_alloc_coherent(union virtio_map token, size=
_t size,
> > > >                                       dma_addr_t *dma_addr, gfp_t f=
lag)
> > > >  {
> > > > -       struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > >         unsigned long iova;
> > > >         void *addr;
> > > > @@ -927,8 +983,10 @@ static void *vduse_dev_alloc_coherent(union vi=
rtio_map token, size_t size,
> > > >         if (!addr)
> > > >                 return NULL;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_lock(&token.group->as_lock);
> > > > +
> > > > +       domain =3D token.group->as->domain;
> > > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > > >                                            (dma_addr_t *)&iova, add=
r);
> > > >         if (!addr)
> > > > @@ -936,9 +994,14 @@ static void *vduse_dev_alloc_coherent(union vi=
rtio_map token, size_t size,
> > > >
> > > >         *dma_addr =3D (dma_addr_t)iova;
> > > >
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > > +
> > > >         return addr;
> > > >
> > > >  err:
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > >         free_pages_exact(addr, size);
> > > >         return NULL;
> > > >  }
> > > > @@ -947,31 +1010,39 @@ static void vduse_dev_free_coherent(union vi=
rtio_map token, size_t size,
> > > >                                     void *vaddr, dma_addr_t dma_add=
r,
> > > >                                     unsigned long attrs)
> > > >  {
> > > > -       struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > >
> > > >         if (!token.group)
> > > >                 return;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_lock(&token.group->as_lock);
> > > >
> > > > +       domain =3D token.group->as->domain;
> > > >         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> > > > +
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > > +
> > > >         free_pages_exact(vaddr, size);
> > > >  }
> > > >
> > > >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t=
 dma_addr)
> > > >  {
> > > > -       struct vduse_dev *vdev;
> > > > -       struct vduse_iova_domain *domain;
> > > > +       size_t bounce_size;
> > > >
> > > >         if (!token.group)
> > > >                 return false;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_lock(&token.group->as_lock);
> > > > +
> > > > +       bounce_size =3D token.group->as->domain->bounce_size;
> > > > +
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > >
> > > > -       return dma_addr < domain->bounce_size;
> > > > +       return dma_addr < bounce_size;
> > > >  }
> > > >
> > > >  static int vduse_dev_mapping_error(union virtio_map token, dma_add=
r_t dma_addr)
> > > > @@ -983,16 +1054,20 @@ static int vduse_dev_mapping_error(union vir=
tio_map token, dma_addr_t dma_addr)
> > > >
> > > >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> > > >  {
> > > > -       struct vduse_dev *vdev;
> > > > -       struct vduse_iova_domain *domain;
> > > > +       size_t bounce_size;
> > > >
> > > >         if (!token.group)
> > > >                 return 0;
> > > >
> > > > -       vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_lock(&token.group->as_lock);
> > > > +
> > > > +       bounce_size =3D token.group->as->domain->bounce_size;
> > > > +
> > > > +       if (token.group->dev->nas > 1)
> > > > +               read_unlock(&token.group->as_lock);
> > > >
> > > > -       return domain->bounce_size;
> > > > +       return bounce_size;
> > > >  }
> > > >
> > > >  static const struct virtio_map_ops vduse_map_ops =3D {
> > > > @@ -1132,39 +1207,40 @@ static int vduse_dev_queue_irq_work(struct =
vduse_dev *dev,
> > > >         return ret;
> > > >  }
> > > >
> > > > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> > > >                                 u64 iova, u64 size)
> > > >  {
> > > >         int ret;
> > > >
> > > > -       mutex_lock(&dev->mem_lock);
> > > > +       mutex_lock(&dev->as[asid].mem_lock);
> > > >         ret =3D -ENOENT;
> > > > -       if (!dev->umem)
> > > > +       if (!dev->as[asid].umem)
> > > >                 goto unlock;
> > > >
> > > >         ret =3D -EINVAL;
> > > > -       if (!dev->domain)
> > > > +       if (!dev->as[asid].domain)
> > > >                 goto unlock;
> > > >
> > > > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bou=
nce_size)
> > > > +       if (dev->as[asid].umem->iova !=3D iova ||
> > > > +           size !=3D dev->as[asid].domain->bounce_size)
> > > >                 goto unlock;
> > > >
> > > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > -       unpin_user_pages_dirty_lock(dev->umem->pages,
> > > > -                                   dev->umem->npages, true);
> > > > -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > > > -       mmdrop(dev->umem->mm);
> > > > -       vfree(dev->umem->pages);
> > > > -       kfree(dev->umem);
> > > > -       dev->umem =3D NULL;
> > > > +       vduse_domain_remove_user_bounce_pages(dev->as[asid].domain)=
;
> > > > +       unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> > > > +                                   dev->as[asid].umem->npages, tru=
e);
> > > > +       atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].ume=
m->mm->pinned_vm);
> > > > +       mmdrop(dev->as[asid].umem->mm);
> > > > +       vfree(dev->as[asid].umem->pages);
> > > > +       kfree(dev->as[asid].umem);
> > > > +       dev->as[asid].umem =3D NULL;
> > > >         ret =3D 0;
> > > >  unlock:
> > > > -       mutex_unlock(&dev->mem_lock);
> > > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > > >         return ret;
> > > >  }
> > > >
> > > >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > > > -                             u64 iova, u64 uaddr, u64 size)
> > > > +                             u32 asid, u64 iova, u64 uaddr, u64 si=
ze)
> > > >  {
> > > >         struct page **page_list =3D NULL;
> > > >         struct vduse_umem *umem =3D NULL;
> > > > @@ -1172,14 +1248,14 @@ static int vduse_dev_reg_umem(struct vduse_=
dev *dev,
> > > >         unsigned long npages, lock_limit;
> > > >         int ret;
> > > >
> > > > -       if (!dev->domain || !dev->domain->bounce_map ||
> > > > -           size !=3D dev->domain->bounce_size ||
> > > > +       if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_=
map ||
> > > > +           size !=3D dev->as[asid].domain->bounce_size ||
> > > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > > >                 return -EINVAL;
> > > >
> > > > -       mutex_lock(&dev->mem_lock);
> > > > +       mutex_lock(&dev->as[asid].mem_lock);
> > > >         ret =3D -EEXIST;
> > > > -       if (dev->umem)
> > > > +       if (dev->as[asid].umem)
> > > >                 goto unlock;
> > > >
> > > >         ret =3D -ENOMEM;
> > > > @@ -1203,7 +1279,7 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > > >                 goto out;
> > > >         }
> > > >
> > > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].do=
main,
> > > >                                                  page_list, pinned)=
;
> > > >         if (ret)
> > > >                 goto out;
> > > > @@ -1216,7 +1292,7 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > > >         umem->mm =3D current->mm;
> > > >         mmgrab(current->mm);
> > > >
> > > > -       dev->umem =3D umem;
> > > > +       dev->as[asid].umem =3D umem;
> > > >  out:
> > > >         if (ret && pinned > 0)
> > > >                 unpin_user_pages(page_list, pinned);
> > > > @@ -1227,7 +1303,7 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > > >                 vfree(page_list);
> > > >                 kfree(umem);
> > > >         }
> > > > -       mutex_unlock(&dev->mem_lock);
> > > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > > >         return ret;
> > > >  }
> > > >
> > > > @@ -1248,43 +1324,46 @@ static void vduse_vq_update_effective_cpu(s=
truct vduse_virtqueue *vq)
> > > >  }
> > > >
> > > >  static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
> > > > -                                struct vduse_iotlb_entry *entry,
> > > > +                                struct vduse_iotlb_entry_v2 *entry=
,
> > > >                                  struct file **f, uint64_t *capabil=
ity)
> > > >  {
> > > > +       u32 asid;
> > > >         int r =3D -EINVAL;
> > > >         struct vhost_iotlb_map *map;
> > > >         const struct vdpa_map_file *map_file;
> > > >
> > > > -       if (entry->start > entry->last)
> > > > +       if (entry->v1.start > entry->v1.last || entry->asid >=3D de=
v->nas)
> > > >                 return -EINVAL;
> > > >
> > > > +       asid =3D array_index_nospec(entry->asid, dev->nas);
> > > >         mutex_lock(&dev->domain_lock);
> > > > -       if (!dev->domain)
> > > > +
> > > > +       if (!dev->as[asid].domain)
> > > >                 goto out;
> > > >
> > > > -       spin_lock(&dev->domain->iotlb_lock);
> > > > -       map =3D vhost_iotlb_itree_first(dev->domain->iotlb, entry->=
start,
> > > > -                                     entry->last);
> > > > +       spin_lock(&dev->as[asid].domain->iotlb_lock);
> > > > +       map =3D vhost_iotlb_itree_first(dev->as[asid].domain->iotlb=
,
> > > > +                                     entry->v1.start, entry->v1.la=
st);
> > > >         if (map) {
> > > >                 if (f) {
> > > >                         map_file =3D (struct vdpa_map_file *)map->o=
paque;
> > > >                         *f =3D get_file(map_file->file);
> > > >                 }
> > > > -               entry->offset =3D map_file->offset;
> > > > -               entry->start =3D map->start;
> > > > -               entry->last =3D map->last;
> > > > -               entry->perm =3D map->perm;
> > > > +               entry->v1.offset =3D map_file->offset;
> > > > +               entry->v1.start =3D map->start;
> > > > +               entry->v1.last =3D map->last;
> > > > +               entry->v1.perm =3D map->perm;
> > > >                 if (capability) {
> > > >                         *capability =3D 0;
> > > >
> > > > -                       if (dev->domain->bounce_map && map->start =
=3D=3D 0 &&
> > > > -                           map->last =3D=3D dev->domain->bounce_si=
ze - 1)
> > > > +                       if (dev->as[asid].domain->bounce_map && map=
->start =3D=3D 0 &&
> > > > +                           map->last =3D=3D dev->as[asid].domain->=
bounce_size - 1)
> > > >                                 *capability |=3D VDUSE_IOVA_CAP_UME=
M;
> > > >                 }
> > > >
> > > >                 r =3D 0;
> > > >         }
> > > > -       spin_unlock(&dev->domain->iotlb_lock);
> > > > +       spin_unlock(&dev->as[asid].domain->iotlb_lock);
> > > >
> > > >  out:
> > > >         mutex_unlock(&dev->domain_lock);
> > > > @@ -1302,12 +1381,29 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >                 return -EPERM;
> > > >
> > > >         switch (cmd) {
> > > > -       case VDUSE_IOTLB_GET_FD: {
> > > > -               struct vduse_iotlb_entry entry;
> > > > +       case VDUSE_IOTLB_GET_FD:
> > > > +       case VDUSE_IOTLB_GET_FD2: {
> > >
> > > I would rename this as GET_FD_ASID
> >
> > It does not scale very well. What if we add more fields to the
> > reserved members of the ioctl argument?
>
> New ioctl then? Or you meant we can know which fields are meaningful
> according to the api version or other?
>

(I think it is clear with the rest of the mail but I'll make my point
clear here in case I'm missing anything).

I meant that having N iotlb entry properties and one ioctl per
properties combinations does not scale very well.

If we add another property that makes 3 ioctl already. Let's say we
also want to return the iotlb capability too. That makes GET_FD_ASID,
GET_FD_CAPABILITY, and GET_FD_ASID_CAPABILITY to return both of them.

If we add another one, that makes 15, and so on.

Compared with that approach, VDUSE_IOTLB_REG_UMEM did the right thing
from the beginning: It reserves space so the size can grow in the
future based on conditions (API version, feature flags, ioctl argument
flags...).

> >
> > > but I wonder the reason for the new
> > > ioctl. I think we can deduce it from the API version,
> >
> > It's in the changelog but let me know if I should expand there.
> >
> > The reason for a new ioctl is that the previous one is defined in the
> > uapi with a struct size that is not able to hold the addition of the
> > asid. From the documentation [1]:
> >
> > "the command number encodes the sizeof(data_type) value in a 13-bit or
> > 14-bit integer"
> >
> > I'm not sure if any sanitizer checks this or if it will be implemented
> > in the future though. My interpretation of the next section of the
> > ioctl documentation "Interface versions" also recommends creating a
> > new versioned ioctl.
> >
> > Sadly I didn't realize this in the first versions so I introduced it la=
ter.
>
> You're right.
>
> >
> > > for example, you
> > > didn't introduce VDUSE_IOTLB_REG_UMEM2.
> > >
> >
> > VDUSE_IOTLB_REG_UMEM already has room for extension in the form of
> > reserved members that must be zero in the master branch.
>
> Right.
>
> >
> > > > +               struct vduse_iotlb_entry_v2 entry =3D {0};
> > > >                 struct file *f =3D NULL;
> > > >
> > > > +               ret =3D -ENOIOCTLCMD;
> > > > +               if (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > +                   cmd =3D=3D VDUSE_IOTLB_GET_FD2)
> > > > +                       break;
> > > > +
> > > >                 ret =3D -EFAULT;
> > > > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > > > +               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2) {
> > > > +                       if (copy_from_user(&entry, argp, sizeof(ent=
ry)))
> > > > +                               break;
> > > > +               } else {
> > > > +                       if (copy_from_user(&entry.v1, argp,
> > > > +                                          sizeof(entry.v1)))
> > > > +                               break;
> > > > +               }
> > > > +
> > > > +               ret =3D -EINVAL;
> > > > +               if (!is_mem_zero((const char *)entry.reserved,
> > > > +                                sizeof(entry.reserved)))
> > > >                         break;
> > > >
> > > >                 ret =3D vduse_dev_iotlb_entry(dev, &entry, &f, NULL=
);
> > > > @@ -1318,12 +1414,19 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >                 if (!f)
> > > >                         break;
> > > >
> > > > -               ret =3D -EFAULT;
> > > > -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> > > > +               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2)
> > > > +                       ret =3D copy_to_user(argp, &entry,
> > > > +                                          sizeof(entry));
> > > > +               else
> > > > +                       ret =3D copy_to_user(argp, &entry.v1,
> > > > +                                          sizeof(entry.v1));
> > > > +
> > > > +               if (ret) {
> > > > +                       ret =3D -EFAULT;
> > > >                         fput(f);
> > > >                         break;
> > > >                 }
> > > > -               ret =3D receive_fd(f, NULL, perm_to_file_flags(entr=
y.perm));
> > > > +               ret =3D receive_fd(f, NULL, perm_to_file_flags(entr=
y.v1.perm));
> > > >                 fput(f);
> > > >                 break;
> > > >         }
> > > > @@ -1468,6 +1571,7 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > > >         }
> > > >         case VDUSE_IOTLB_REG_UMEM: {
> > > >                 struct vduse_iova_umem umem;
> > > > +               u32 asid;
> > > >
> > > >                 ret =3D -EFAULT;
> > > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > > @@ -1475,17 +1579,21 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >
> > > >                 ret =3D -EINVAL;
> > > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > > -                                sizeof(umem.reserved)))
> > > > +                                sizeof(umem.reserved)) ||
> > > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > +                    umem.asid !=3D 0) || umem.asid >=3D dev->nas)
> > > >                         break;
> > > >
> > > >                 mutex_lock(&dev->domain_lock);
> > > > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > > > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > > > +               ret =3D vduse_dev_reg_umem(dev, asid, umem.iova,
> > > >                                          umem.uaddr, umem.size);
> > > >                 mutex_unlock(&dev->domain_lock);
> > > >                 break;
> > > >         }
> > > >         case VDUSE_IOTLB_DEREG_UMEM: {
> > > >                 struct vduse_iova_umem umem;
> > > > +               u32 asid;
> > > >
> > > >                 ret =3D -EFAULT;
> > > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > > @@ -1493,17 +1601,22 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >
> > > >                 ret =3D -EINVAL;
> > > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > > -                                sizeof(umem.reserved)))
> > > > +                                sizeof(umem.reserved)) ||
> > > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > +                    umem.asid !=3D 0) ||
> > > > +                    umem.asid >=3D dev->nas)
> > > >                         break;
> > > > +
> > > >                 mutex_lock(&dev->domain_lock);
> > > > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > > > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > > > +               ret =3D vduse_dev_dereg_umem(dev, asid, umem.iova,
> > > >                                            umem.size);
> > > >                 mutex_unlock(&dev->domain_lock);
> > > >                 break;
> > > >         }
> > > >         case VDUSE_IOTLB_GET_INFO: {
> > > >                 struct vduse_iova_info info;
> > > > -               struct vduse_iotlb_entry entry;
> > > > +               struct vduse_iotlb_entry_v2 entry;
> > > >
> > > >                 ret =3D -EFAULT;
> > > >                 if (copy_from_user(&info, argp, sizeof(info)))
> > > > @@ -1513,15 +1626,23 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >                                  sizeof(info.reserved)))
> > > >                         break;
> > > >
> > > > -               entry.start =3D info.start;
> > > > -               entry.last =3D info.last;
> > > > +               if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > +                       if (info.asid)
> > > > +                               break;
> > > > +               } else if (info.asid >=3D dev->nas)
> > > > +                       break;
> > > > +
> > > > +               entry.v1.start =3D info.start;
> > > > +               entry.v1.last =3D info.last;
> > > > +               entry.asid =3D info.asid;
> > > >                 ret =3D vduse_dev_iotlb_entry(dev, &entry, NULL,
> > > >                                             &info.capability);
> > > >                 if (ret < 0)
> > > >                         break;
> > > >
> > > > -               info.start =3D entry.start;
> > > > -               info.last =3D entry.last;
> > > > +               info.start =3D entry.v1.start;
> > > > +               info.last =3D entry.v1.last;
> > > > +               info.asid =3D entry.asid;
> > > >
> > > >                 ret =3D -EFAULT;
> > > >                 if (copy_to_user(argp, &info, sizeof(info)))
> > > > @@ -1543,8 +1664,10 @@ static int vduse_dev_release(struct inode *i=
node, struct file *file)
> > > >         struct vduse_dev *dev =3D file->private_data;
> > > >
> > > >         mutex_lock(&dev->domain_lock);
> > > > -       if (dev->domain)
> > > > -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_si=
ze);
> > > > +       for (int i =3D 0; i < dev->nas; i++)
> > > > +               if (dev->as[i].domain)
> > > > +                       vduse_dev_dereg_umem(dev, i, 0,
> > > > +                                            dev->as[i].domain->bou=
nce_size);
> > > >         mutex_unlock(&dev->domain_lock);
> > > >         spin_lock(&dev->msg_lock);
> > > >         /* Make sure the inflight messages can processed after reco=
nncection */
> > > > @@ -1763,7 +1886,6 @@ static struct vduse_dev *vduse_dev_create(voi=
d)
> > > >                 return NULL;
> > > >
> > > >         mutex_init(&dev->lock);
> > > > -       mutex_init(&dev->mem_lock);
> > > >         mutex_init(&dev->domain_lock);
> > > >         spin_lock_init(&dev->msg_lock);
> > > >         INIT_LIST_HEAD(&dev->send_list);
> > > > @@ -1814,8 +1936,11 @@ static int vduse_destroy_dev(char *name)
> > > >         idr_remove(&vduse_idr, dev->minor);
> > > >         kvfree(dev->config);
> > > >         vduse_dev_deinit_vqs(dev);
> > > > -       if (dev->domain)
> > > > -               vduse_domain_destroy(dev->domain);
> > > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > > +               if (dev->as[i].domain)
> > > > +                       vduse_domain_destroy(dev->as[i].domain);
> > > > +       }
> > > > +       kfree(dev->as);
> > > >         kfree(dev->name);
> > > >         kfree(dev->groups);
> > > >         vduse_dev_destroy(dev);
> > > > @@ -1862,12 +1987,17 @@ static bool vduse_validate_config(struct vd=
use_dev_config *config,
> > > >                          sizeof(config->reserved)))
> > > >                 return false;
> > > >
> > > > -       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > > > +       if (api_version < VDUSE_API_VERSION_1 &&
> > > > +           (config->ngroups || config->nas))
> > > >                 return false;
> > > >
> > > > -       if (api_version >=3D VDUSE_API_VERSION_1 &&
> > > > -           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GR=
OUPS))
> > > > -               return false;
> > > > +       if (api_version >=3D VDUSE_API_VERSION_1) {
> > > > +               if (!config->ngroups || config->ngroups > VDUSE_DEV=
_MAX_GROUPS)
> > > > +                       return false;
> > > > +
> > > > +               if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
> > > > +                       return false;
> > > > +       }
> > > >
> > > >         if (config->vq_align > PAGE_SIZE)
> > > >                 return false;
> > > > @@ -1932,7 +2062,8 @@ static ssize_t bounce_size_store(struct devic=
e *device,
> > > >
> > > >         ret =3D -EPERM;
> > > >         mutex_lock(&dev->domain_lock);
> > > > -       if (dev->domain)
> > > > +       /* Assuming that if the first domain is allocated, all are =
allocated */
> > > > +       if (dev->as[0].domain)
> > > >                 goto unlock;
> > >
> > > Should we update the per as bounce size here, and if yes, how to
> > > synchronize with need_sync()?
> > >
> >
> > No, per as bounce size is still not allocated. It is stored in the
> > per->as[i].domain we check that it is not allocated in this
> > conditional [2].
>
> Exactly.
>
> Thanks
>

