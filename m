Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4D22B8C5
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040315; cv=none; b=O+r5OFOccOlgI7++OFiFuCzymU+aj6FFfup/RPrBnBVKjDOps66p1XzbRfkFHrvebzJVNWUb+y32OpuS6aOuoM3XYOA9mdqOsWhLRGMYT8IIqRVYUpk4jlDsJtdxY+OpDpSCOS1oNsSWDs9f6cHSl5Fw55DDZAa6vAEA6PyGwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040315; c=relaxed/simple;
	bh=HXIwlL3HQnPksEFfL0LyWXvXKjTNZiC04FIK5Shws4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng6yIidMJ9EtAqWMuuNkj5TrwnToWX7Tijb9RAAg7pU+yYinNd901XX1D3cOQ6mqXrF60tDtCviEmIoMjuePVMmS4UhEhVaY+r/kt6/ORO9k2z780nuw2vZgaJG9fiP67UMF3wIQ0LpfhXQmt0lbvJ/OboIqhDXp4G84BMW4oL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZbiNKnP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZbiNKnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766040310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZ/Uc8lTPJzkfBpP+OM3fWj5zp9Ke1vPbLQLFThXHgU=;
	b=WZbiNKnPwPYOQiwks68n52X4qxuyWn6YTwrluzIaZfxcpVrYESDOqeZEqsesdqxjMoCRDL
	lxFjuE3yjgQURBJPc4pv89LM9qdXtTbtcdRVXpiMCY20r+T0jZ6HJ+8szKg95u66DOTNkh
	aOOjAmV1DXHEhDo8JUVJROp5dWsLqnA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-gnuXNTycOJe5GdUljZA_gA-1; Thu, 18 Dec 2025 01:45:08 -0500
X-MC-Unique: gnuXNTycOJe5GdUljZA_gA-1
X-Mimecast-MFC-AGG-ID: gnuXNTycOJe5GdUljZA_gA_1766040308
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f47c0e60so8179965ad.3
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 22:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766040308; x=1766645108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZ/Uc8lTPJzkfBpP+OM3fWj5zp9Ke1vPbLQLFThXHgU=;
        b=wsx1NZ9s5roZLaLcsHxUdG9nZpxgt3iUvkHdRd8vSPNNbtnP1aiKIaeM+3q+YIx5qT
         7upIXD64iB2/mETCVkIZd8w3gsB2KcmLvOCMIyh9Em5hp4LKarvVCGLvomj5JPn/RrYr
         evOALJIguRe/WSy0o7aJoVBHInsRDzJIDwymxOJ4wl72kqD/2i9ENG8jde8w//x0YxHJ
         YX9oAyQj2U0MGW344b/ejIjdc8NOU8TCsdIbZ/Ks8osC2Pi+1RerSUyuYFuGTnH2VH5v
         ehLiatozBrowGyKhNLbjjsMfzt13S9Mn3w1gT68sItbWdk503FWKsgOKTAgYD5xSV5hW
         E8iA==
X-Forwarded-Encrypted: i=1; AJvYcCU18+XXmIh+PkdEKDleRctl33UV7gV8MCMJFp5y/htR7t9MksdBMte/y+5dEJAJvgaW59bEcJsJeFRKfMc2dA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEqleTg0dlVXuSIPgL7kBcL1v7eiY446AVifyvT/gkWyma+Lro
	U1n8mOwMOWNyQ3tpuKECGSA2bAmds+XjkUUqM1y/VVzwF9i82XnRmHNsfy24LYl0PWZx8DrT+e9
	A0i866SL/Z9aOZVoAFkO/Nghi8FpdStZIitIXhA1oc+8aHutrIn4P37w+S9spUWU1pjGMhpRZkp
	ZI69el8fbUl58OD1lF3NTgqvevDCF65abTZwEt3PQ1EWM=
X-Gm-Gg: AY/fxX5rO56H+KjGPim4IcI1MIwKlSNHQ+H0oFzw29mkhp39pYllX0kufuR/L7IAmmw
	8SlHOiWGmlsm+FNUeVpqU+5Bp20ctWo7PSrgW0lRCXWGj7bD3YIpi8ELZF/5SrDgu4C2ap3RFJb
	eMwNNCz0VyAljJc1myblBYUPf16LN6VDZSaAD3TUYfuckimPxeRFSxJYxElZX6IvExt4E=
X-Received: by 2002:a17:902:d4c8:b0:2a0:b4f6:5595 with SMTP id d9443c01a7336-2a0b4f65742mr134631255ad.50.1766040307453;
        Wed, 17 Dec 2025 22:45:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFAYDmALq9vVQJIf9QztflrSbwgPJCz8Dboib42+GI1J4CMCXEGUiVARnh1tRLrERVuHwPB19Nk+aq1NESTRs=
X-Received: by 2002:a17:902:d4c8:b0:2a0:b4f6:5595 with SMTP id
 d9443c01a7336-2a0b4f65742mr134630985ad.50.1766040306741; Wed, 17 Dec 2025
 22:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-8-eperezma@redhat.com>
In-Reply-To: <20251217112414.2374672-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Dec 2025 14:44:54 +0800
X-Gm-Features: AQt7F2q2r00DLkD17znk_gCMKZNen9jk2O2CMHndiKjdxsTxynK59DWL-wElEVU
Message-ID: <CACGkMEs6-j8h7X8navZGC0wraan4WSLO3NMFx++Fe0uaExWZmA@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KXeS8XYV1lwWk4WJSo2Y6XR4P0-RR-plwEJ4cXQ_HmU_1766040308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> The vq group to ASID association is protected by a rwlock now.  But the
> mutex domain_lock keeps protecting the domains of all ASIDs, as some
> operations like the one related with the bounce buffer size still
> requires to lock all the ASIDs.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> ---
> Future improvements can include performance optimizations on top could
> move to per-ASID locks, or hardening by tracking ASID or ASID hashes on
> unused bits of the DMA address.
>
> Tested virtio_vdpa by adding manually two threads in vduse_set_status:
> one of them modifies the vq group 0 ASID and the other one map and unmap
> memory continuously.  After a while, the two threads stop and the usual
> work continues.
>
> Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A few
> workaround were needed in some parts:
> * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forward
>   the enable message to the userland device.  This will be solved in the
>   future.
> * Share the suspended state between all vhost devices in QEMU:
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.html
> * Implement a fake VDUSE suspend vdpa operation callback that always
>   returns true in the kernel.  DPDK suspend the device at the first
>   GET_VRING_BASE.
> * Remove the CVQ blocker in ASID.
>
> ---
> v10:
> * Back to rwlock version so stronger locks are used.
> * Take out allocations from rwlock.
> * Forbid changing ASID of a vq group after DRIVER_OK (Jason)
> * Remove bad fetching again of domain variable in
>   vduse_dev_max_mapping_size (Yongji).
> * Remove unused vdev definition in vdpa map_ops callbacks (kernel test
>   robot).
>
> v9:
> * Replace mutex with rwlock, as the vdpa map_ops can run from atomic
>   context.
>
> v8:
> * Revert the mutex to rwlock change, it needs proper profiling to
>   justify it.
>
> v7:
> * Take write lock in the error path (Jason).
>
> v6:
> * Make vdpa_dev_add use gotos for error handling (MST).
> * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?/
>   (MST).
> * Fix struct name not matching in the doc.
>
> v5:
> * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
>   ioctl (Jason).
> * Properly set domain bounce size to divide equally between nas (Jason).
> * Exclude "padding" member from the only >V1 members in
>   vduse_dev_request.
>
> v4:
> * Divide each domain bounce size between the device bounce size (Jason).
> * revert unneeded addr =3D NULL assignment (Jason)
> * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
>   return; } (Jason)
> * Change a bad multiline comment, using @ caracter instead of * (Jason).
> * Consider config->nas =3D=3D 0 as a fail (Jason).
>
> v3:
> * Get the vduse domain through the vduse_as in the map functions
>   (Jason).
> * Squash with the patch creating the vduse_as struct (Jason).
> * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
>   (Jason)
>
> v2:
> * Convert the use of mutex to rwlock.
>
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
>   VDUSE_IOTLB_GET_INFO.
> * Use of array_index_nospec in VDUSE device ioctls.
> * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> * Move the umem mutex to asid struct so there is no contention between
>   ASIDs.
>
> RFC v2:
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
>   part of the struct is the same.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 366 +++++++++++++++++++----------
>  include/uapi/linux/vduse.h         |  53 ++++-
>  2 files changed, 295 insertions(+), 124 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 767abcb7e375..786ab2378825 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -41,6 +41,7 @@
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
>  #define VDUSE_DEV_MAX_GROUPS 0xffff
> +#define VDUSE_DEV_MAX_AS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -86,7 +87,15 @@ struct vduse_umem {
>         struct mm_struct *mm;
>  };
>
> +struct vduse_as {
> +       struct vduse_iova_domain *domain;
> +       struct vduse_umem *umem;
> +       struct mutex mem_lock;

Not related to this patch. But If I was not wrong we have 1:1 mapping
between domain and as. If this is true, can we use bounce_lock instead
of a new mem_lock? Since I see mem_lock is only used for synchronizing
umem reg/degreg which has been synchronized with domain rwlock.

> +};
> +
>  struct vduse_vq_group {
> +       rwlock_t as_lock;
> +       struct vduse_as *as; /* Protected by as_lock */
>         struct vduse_dev *dev;
>  };
>
> @@ -94,7 +103,7 @@ struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
> -       struct vduse_iova_domain *domain;
> +       struct vduse_as *as;
>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -122,9 +131,8 @@ struct vduse_dev {
>         u32 vq_num;
>         u32 vq_align;
>         u32 ngroups;
> -       struct vduse_umem *umem;
> +       u32 nas;
>         struct vduse_vq_group *groups;
> -       struct mutex mem_lock;
>         unsigned int bounce_size;
>         struct mutex domain_lock;
>  };
> @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev=
, u8 status)
>         return vduse_dev_msg_sync(dev, &msg);
>  }
>
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
>                                   u64 start, u64 last)
>  {
>         struct vduse_dev_msg msg =3D { 0 };
> @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *=
dev,
>                 return -EINVAL;
>
>         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> -       msg.req.iova.start =3D start;
> -       msg.req.iova.last =3D last;
> +       if (dev->api_version < VDUSE_API_VERSION_1) {
> +               msg.req.iova.start =3D start;
> +               msg.req.iova.last =3D last;
> +       } else {
> +               msg.req.iova_v2.start =3D start;
> +               msg.req.iova_v2.last =3D last;
> +               msg.req.iova_v2.asid =3D asid;
> +       }
>
>         return vduse_dev_msg_sync(dev, &msg);
>  }
> @@ -436,14 +450,29 @@ static __poll_t vduse_dev_poll(struct file *file, p=
oll_table *wait)
>         return mask;
>  }
>
> +/* Force set the asid to a vq group without a message to the VDUSE devic=
e */
> +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> +                                      unsigned int group, unsigned int a=
sid)
> +{
> +       write_lock(&dev->groups[group].as_lock);
> +       dev->groups[group].as =3D &dev->as[asid];
> +       write_unlock(&dev->groups[group].as_lock);
> +}
> +
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>         int i;
> -       struct vduse_iova_domain *domain =3D dev->domain;
>
>         /* The coherent mappings are handled in vduse_dev_free_coherent()=
 */
> -       if (domain && domain->bounce_map)
> -               vduse_domain_reset_bounce_map(domain);
> +       for (i =3D 0; i < dev->nas; i++) {
> +               struct vduse_iova_domain *domain =3D dev->as[i].domain;
> +
> +               if (domain && domain->bounce_map)
> +                       vduse_domain_reset_bounce_map(domain);

Btw, I see this:

void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain)
{
        if (!domain->bounce_map)
                return;

        spin_lock(&domain->iotlb_lock);
        if (!domain->bounce_map)
                goto unlock;


The counbe_map is checked twice, let's fix that.

> +       }
> +
> +       for (i =3D 0; i < dev->ngroups; i++)
> +               vduse_set_group_asid_nomsg(dev, i, 0);

Note that this function still does:

                vq->vq_group =3D 0;

Which is wrong.

>
>         down_write(&dev->rwsem);
>
> @@ -623,6 +652,30 @@ static union virtio_map vduse_get_vq_map(struct vdpa=
_device *vdpa, u16 idx)
>         return ret;
>  }
>
> +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int g=
roup,
> +                               unsigned int asid)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int r;
> +
> +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> +           group >=3D dev->ngroups || asid >=3D dev->nas ||
> +           dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> +               return -EINVAL;

If we forbid setting group asid for !DRIVER_OK, why do we still need a
rwlock? All we need to do is to synchronize set_group_asid() with
set_status()/reset()?

Or if you want to synchronize map ops with set_status() that looks
like an independent thing (hardening).

> +
> +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> +       msg.req.vq_group_asid.group =3D group;
> +       msg.req.vq_group_asid.asid =3D asid;
> +
> +       r =3D vduse_dev_msg_sync(dev, &msg);
> +       if (r < 0)
> +               return r;
> +
> +       vduse_set_group_asid_nomsg(dev, group, asid);

I'm not sure this has been discussed before, but I think it would be
better to introduce a new ioctl to get group -> as mapping. This helps
to avoid vduse_dev_msg_sync() as much as possible. And it doesn't
require the userspace to poll vduse fd before DRIVER_OK.

> +       return 0;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -794,13 +847,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
dpa,
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         int ret;
>
> -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
>         if (ret)
>                 return ret;
>
> -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
>         if (ret) {
> -               vduse_domain_clear_map(dev->domain, iotlb);
> +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
>                 return ret;
>         }
>
> @@ -843,6 +896,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .set_group_asid         =3D vduse_set_group_asid,
>         .get_vq_map             =3D vduse_get_vq_map,
>         .free                   =3D vduse_vdpa_free,
>  };
> @@ -851,32 +905,30 @@ static void vduse_dev_sync_single_for_device(union =
virtio_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       read_lock(&token.group->as_lock);

I think we could optimize the lock here. E.g when nas is 1, we don't
need any lock in fact.

> +       domain =3D token.group->as->domain;
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
> +       read_unlock(&token.group->as_lock);
>  }
>
>  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       read_lock(&token.group->as_lock);
> +       domain =3D token.group->as->domain;
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> +       read_unlock(&token.group->as_lock);
>  }
>
>  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page=
 *page,
> @@ -884,38 +936,38 @@ static dma_addr_t vduse_dev_map_page(union virtio_m=
ap token, struct page *page,
>                                      enum dma_data_direction dir,
>                                      unsigned long attrs)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
> +       dma_addr_t r;
>
>         if (!token.group)
>                 return DMA_MAPPING_ERROR;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> +       read_lock(&token.group->as_lock);
> +       domain =3D token.group->as->domain;
> +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, attr=
s);
> +       read_unlock(&token.group->as_lock);
>
> -       return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
> +       return r;
>  }
>
>  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_=
addr,
>                                  size_t size, enum dma_data_direction dir=
,
>                                  unsigned long attrs)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> -       return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
> +       read_lock(&token.group->as_lock);
> +       domain =3D token.group->as->domain;
> +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> +       read_unlock(&token.group->as_lock);
>  }
>
>  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t siz=
e,
>                                       dma_addr_t *dma_addr, gfp_t flag)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>         unsigned long iova;
>         void *addr;
> @@ -928,18 +980,21 @@ static void *vduse_dev_alloc_coherent(union virtio_=
map token, size_t size,
>         if (!addr)
>                 return NULL;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> +       *dma_addr =3D (dma_addr_t)iova;

Any reason we need to touch *dma_addr here? It might trigger UBSAN/KMSAN.

> +       read_lock(&token.group->as_lock);
> +       domain =3D token.group->as->domain;
>         addr =3D vduse_domain_alloc_coherent(domain, size,
>                                            (dma_addr_t *)&iova, addr);
>         if (!addr)
>                 goto err;
>
>         *dma_addr =3D (dma_addr_t)iova;
> +       read_unlock(&token.group->as_lock);
>
>         return addr;
>
>  err:
> +       read_unlock(&token.group->as_lock);
>         free_pages_exact(addr, size);
>         return NULL;
>  }
> @@ -948,31 +1003,30 @@ static void vduse_dev_free_coherent(union virtio_m=
ap token, size_t size,
>                                     void *vaddr, dma_addr_t dma_addr,
>                                     unsigned long attrs)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       read_lock(&token.group->as_lock);
> +       domain =3D token.group->as->domain;
>         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> +       read_unlock(&token.group->as_lock);
>         free_pages_exact(vaddr, size);
>  }
>
>  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_a=
ddr)
>  {
> -       struct vduse_dev *vdev;
> -       struct vduse_iova_domain *domain;
> +       size_t bounce_size;
>
>         if (!token.group)
>                 return false;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> +       read_lock(&token.group->as_lock);
> +       bounce_size =3D token.group->as->domain->bounce_size;
> +       read_unlock(&token.group->as_lock);
>
> -       return dma_addr < domain->bounce_size;
> +       return dma_addr < bounce_size;
>  }
>
>  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dm=
a_addr)
> @@ -984,16 +1038,16 @@ static int vduse_dev_mapping_error(union virtio_ma=
p token, dma_addr_t dma_addr)
>
>  static size_t vduse_dev_max_mapping_size(union virtio_map token)
>  {
> -       struct vduse_dev *vdev;
> -       struct vduse_iova_domain *domain;
> +       size_t bounce_size;
>
>         if (!token.group)
>                 return 0;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> +       read_lock(&token.group->as_lock);
> +       bounce_size =3D token.group->as->domain->bounce_size;
> +       read_unlock(&token.group->as_lock);
>
> -       return domain->bounce_size;
> +       return bounce_size;
>  }
>
>  static const struct virtio_map_ops vduse_map_ops =3D {
> @@ -1133,39 +1187,40 @@ static int vduse_dev_queue_irq_work(struct vduse_=
dev *dev,
>         return ret;
>  }
>
> -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
>                                 u64 iova, u64 size)
>  {
>         int ret;
>
> -       mutex_lock(&dev->mem_lock);
> +       mutex_lock(&dev->as[asid].mem_lock);
>         ret =3D -ENOENT;
> -       if (!dev->umem)
> +       if (!dev->as[asid].umem)
>                 goto unlock;
>
>         ret =3D -EINVAL;
> -       if (!dev->domain)
> +       if (!dev->as[asid].domain)
>                 goto unlock;
>
> -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_si=
ze)
> +       if (dev->as[asid].umem->iova !=3D iova ||
> +           size !=3D dev->as[asid].domain->bounce_size)
>                 goto unlock;
>
> -       vduse_domain_remove_user_bounce_pages(dev->domain);
> -       unpin_user_pages_dirty_lock(dev->umem->pages,
> -                                   dev->umem->npages, true);
> -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> -       mmdrop(dev->umem->mm);
> -       vfree(dev->umem->pages);
> -       kfree(dev->umem);
> -       dev->umem =3D NULL;
> +       vduse_domain_remove_user_bounce_pages(dev->as[asid].domain);
> +       unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> +                                   dev->as[asid].umem->npages, true);
> +       atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].umem->mm-=
>pinned_vm);
> +       mmdrop(dev->as[asid].umem->mm);
> +       vfree(dev->as[asid].umem->pages);
> +       kfree(dev->as[asid].umem);
> +       dev->as[asid].umem =3D NULL;
>         ret =3D 0;
>  unlock:
> -       mutex_unlock(&dev->mem_lock);
> +       mutex_unlock(&dev->as[asid].mem_lock);
>         return ret;
>  }
>
>  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> -                             u64 iova, u64 uaddr, u64 size)
> +                             u32 asid, u64 iova, u64 uaddr, u64 size)
>  {
>         struct page **page_list =3D NULL;
>         struct vduse_umem *umem =3D NULL;
> @@ -1173,14 +1228,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
>         unsigned long npages, lock_limit;
>         int ret;
>
> -       if (!dev->domain || !dev->domain->bounce_map ||
> -           size !=3D dev->domain->bounce_size ||
> +       if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_map ||
> +           size !=3D dev->as[asid].domain->bounce_size ||
>             iova !=3D 0 || uaddr & ~PAGE_MASK)
>                 return -EINVAL;
>
> -       mutex_lock(&dev->mem_lock);
> +       mutex_lock(&dev->as[asid].mem_lock);
>         ret =3D -EEXIST;
> -       if (dev->umem)
> +       if (dev->as[asid].umem)
>                 goto unlock;
>
>         ret =3D -ENOMEM;
> @@ -1204,7 +1259,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev=
,
>                 goto out;
>         }
>
> -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].domain,
>                                                  page_list, pinned);
>         if (ret)
>                 goto out;
> @@ -1217,7 +1272,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev=
,
>         umem->mm =3D current->mm;
>         mmgrab(current->mm);
>
> -       dev->umem =3D umem;
> +       dev->as[asid].umem =3D umem;
>  out:
>         if (ret && pinned > 0)
>                 unpin_user_pages(page_list, pinned);
> @@ -1228,7 +1283,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev=
,
>                 vfree(page_list);
>                 kfree(umem);
>         }
> -       mutex_unlock(&dev->mem_lock);
> +       mutex_unlock(&dev->as[asid].mem_lock);
>         return ret;
>  }
>
> @@ -1260,47 +1315,66 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>
>         switch (cmd) {
>         case VDUSE_IOTLB_GET_FD: {
> -               struct vduse_iotlb_entry entry;
> +               struct vduse_iotlb_entry_v2 entry;

Nit: if we stick entry and do copy_from_user() twice it might save
lots of unnecessary changes.

>                 struct vhost_iotlb_map *map;
>                 struct vdpa_map_file *map_file;
>                 struct file *f =3D NULL;
> +               u32 asid;
>
>                 ret =3D -EFAULT;
> -               if (copy_from_user(&entry, argp, sizeof(entry)))
> -                       break;
> +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> +                       if (copy_from_user(&entry, argp, sizeof(entry)))
> +                               break;
> +               } else {
> +                       entry.asid =3D 0;
> +                       if (copy_from_user(&entry.v1, argp,
> +                                          sizeof(entry.v1)))
> +                               break;
> +               }
>
>                 ret =3D -EINVAL;
> -               if (entry.start > entry.last)
> +               if (entry.v1.start > entry.v1.last)
> +                       break;
> +
> +               if (entry.asid >=3D dev->nas)
>                         break;
>
>                 mutex_lock(&dev->domain_lock);
> -               if (!dev->domain) {
> +               asid =3D array_index_nospec(entry.asid, dev->nas);
> +               if (!dev->as[asid].domain) {
>                         mutex_unlock(&dev->domain_lock);
>                         break;
>                 }
> -               spin_lock(&dev->domain->iotlb_lock);
> -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> -                                             entry.start, entry.last);
> +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> +               map =3D vhost_iotlb_itree_first(dev->as[asid].domain->iot=
lb,
> +                                             entry.v1.start, entry.v1.la=
st);
>                 if (map) {
>                         map_file =3D (struct vdpa_map_file *)map->opaque;
>                         f =3D get_file(map_file->file);
> -                       entry.offset =3D map_file->offset;
> -                       entry.start =3D map->start;
> -                       entry.last =3D map->last;
> -                       entry.perm =3D map->perm;
> +                       entry.v1.offset =3D map_file->offset;
> +                       entry.v1.start =3D map->start;
> +                       entry.v1.last =3D map->last;
> +                       entry.v1.perm =3D map->perm;
>                 }
> -               spin_unlock(&dev->domain->iotlb_lock);
> +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
>                 mutex_unlock(&dev->domain_lock);
>                 ret =3D -EINVAL;
>                 if (!f)
>                         break;
>
> -               ret =3D -EFAULT;
> -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> +               if (dev->api_version >=3D VDUSE_API_VERSION_1)
> +                       ret =3D copy_to_user(argp, &entry,
> +                                          sizeof(entry));
> +               else
> +                       ret =3D copy_to_user(argp, &entry.v1,
> +                                          sizeof(entry.v1));
> +
> +               if (ret) {
> +                       ret =3D -EFAULT;
>                         fput(f);
>                         break;
>                 }
> -               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.perm=
));
> +               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.v1.p=
erm));
>                 fput(f);
>                 break;
>         }
> @@ -1445,6 +1519,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>         }
>         case VDUSE_IOTLB_REG_UMEM: {
>                 struct vduse_iova_umem umem;
> +               u32 asid;
>
>                 ret =3D -EFAULT;
>                 if (copy_from_user(&umem, argp, sizeof(umem)))
> @@ -1452,17 +1527,21 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>
>                 ret =3D -EINVAL;
>                 if (!is_mem_zero((const char *)umem.reserved,
> -                                sizeof(umem.reserved)))
> +                                sizeof(umem.reserved)) ||
> +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> +                    umem.asid !=3D 0) || umem.asid >=3D dev->nas)
>                         break;
>
>                 mutex_lock(&dev->domain_lock);
> -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> +               asid =3D array_index_nospec(umem.asid, dev->nas);
> +               ret =3D vduse_dev_reg_umem(dev, asid, umem.iova,
>                                          umem.uaddr, umem.size);
>                 mutex_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_DEREG_UMEM: {
>                 struct vduse_iova_umem umem;
> +               u32 asid;
>
>                 ret =3D -EFAULT;
>                 if (copy_from_user(&umem, argp, sizeof(umem)))
> @@ -1470,10 +1549,15 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>
>                 ret =3D -EINVAL;
>                 if (!is_mem_zero((const char *)umem.reserved,
> -                                sizeof(umem.reserved)))
> +                                sizeof(umem.reserved)) ||
> +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> +                    umem.asid !=3D 0) ||
> +                    umem.asid >=3D dev->nas)
>                         break;
> +
>                 mutex_lock(&dev->domain_lock);
> -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> +               asid =3D array_index_nospec(umem.asid, dev->nas);
> +               ret =3D vduse_dev_dereg_umem(dev, asid, umem.iova,
>                                            umem.size);
>                 mutex_unlock(&dev->domain_lock);
>                 break;
> @@ -1481,6 +1565,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>         case VDUSE_IOTLB_GET_INFO: {

Btw I see this:

                dev->vqs[index]->vq_group =3D config.group;

In VDUSE_VQ_SETUP:

I wonder what's the reason that it is not a part of CREATE_DEV? I
meant it might be racy if DMA happens between CREATE_DEV and
VDUSE_VQ_SETUP.

>                 struct vduse_iova_info info;
>                 struct vhost_iotlb_map *map;
> +               u32 asid;
>
>                 ret =3D -EFAULT;
>                 if (copy_from_user(&info, argp, sizeof(info)))
> @@ -1494,23 +1579,31 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                                  sizeof(info.reserved)))
>                         break;
>
> +               if (dev->api_version < VDUSE_API_VERSION_1) {
> +                       if (info.asid)
> +                               break;
> +               } else if (info.asid >=3D dev->nas)
> +                       break;
> +
>                 mutex_lock(&dev->domain_lock);
> -               if (!dev->domain) {
> +               asid =3D array_index_nospec(info.asid, dev->nas);
> +               if (!dev->as[asid].domain) {
>                         mutex_unlock(&dev->domain_lock);
>                         break;
>                 }
> -               spin_lock(&dev->domain->iotlb_lock);
> -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> +               map =3D vhost_iotlb_itree_first(dev->as[asid].domain->iot=
lb,
>                                               info.start, info.last);
>                 if (map) {
>                         info.start =3D map->start;
>                         info.last =3D map->last;
>                         info.capability =3D 0;
> -                       if (dev->domain->bounce_map && map->start =3D=3D =
0 &&
> -                           map->last =3D=3D dev->domain->bounce_size - 1=
)
> +                       if (dev->as[asid].domain->bounce_map &&
> +                           map->start =3D=3D 0 &&
> +                           map->last =3D=3D dev->as[asid].domain->bounce=
_size - 1)
>                                 info.capability |=3D VDUSE_IOVA_CAP_UMEM;
>                 }
> -               spin_unlock(&dev->domain->iotlb_lock);
> +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
>                 mutex_unlock(&dev->domain_lock);
>                 if (!map)
>                         break;
> @@ -1535,8 +1628,10 @@ static int vduse_dev_release(struct inode *inode, =
struct file *file)
>         struct vduse_dev *dev =3D file->private_data;
>
>         mutex_lock(&dev->domain_lock);
> -       if (dev->domain)
> -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> +       for (int i =3D 0; i < dev->nas; i++)
> +               if (dev->as[i].domain)
> +                       vduse_dev_dereg_umem(dev, i, 0,
> +                                            dev->as[i].domain->bounce_si=
ze);
>         mutex_unlock(&dev->domain_lock);
>         spin_lock(&dev->msg_lock);
>         /* Make sure the inflight messages can processed after reconncect=
ion */
> @@ -1755,7 +1850,6 @@ static struct vduse_dev *vduse_dev_create(void)
>                 return NULL;
>
>         mutex_init(&dev->lock);
> -       mutex_init(&dev->mem_lock);
>         mutex_init(&dev->domain_lock);
>         spin_lock_init(&dev->msg_lock);
>         INIT_LIST_HEAD(&dev->send_list);
> @@ -1806,8 +1900,11 @@ static int vduse_destroy_dev(char *name)
>         idr_remove(&vduse_idr, dev->minor);
>         kvfree(dev->config);
>         vduse_dev_deinit_vqs(dev);
> -       if (dev->domain)
> -               vduse_domain_destroy(dev->domain);
> +       for (int i =3D 0; i < dev->nas; i++) {
> +               if (dev->as[i].domain)
> +                       vduse_domain_destroy(dev->as[i].domain);
> +       }
> +       kfree(dev->as);
>         kfree(dev->name);
>         kfree(dev->groups);
>         vduse_dev_destroy(dev);
> @@ -1854,12 +1951,17 @@ static bool vduse_validate_config(struct vduse_de=
v_config *config,
>                          sizeof(config->reserved)))
>                 return false;
>
> -       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> +       if (api_version < VDUSE_API_VERSION_1 &&
> +           (config->ngroups || config->nas))
>                 return false;
>
> -       if (api_version >=3D VDUSE_API_VERSION_1 &&
> -           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
> -               return false;
> +       if (api_version >=3D VDUSE_API_VERSION_1) {
> +               if (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_G=
ROUPS)
> +                       return false;
> +
> +               if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
> +                       return false;
> +       }
>
>         if (config->vq_align > PAGE_SIZE)
>                 return false;
> @@ -1924,7 +2026,8 @@ static ssize_t bounce_size_store(struct device *dev=
ice,
>
>         ret =3D -EPERM;
>         mutex_lock(&dev->domain_lock);
> -       if (dev->domain)
> +       /* Assuming that if the first domain is allocated, all are alloca=
ted */
> +       if (dev->as[0].domain)
>                 goto unlock;

Not for this patch but I don't understand why we need to check dev->domain =
here.

>
>         ret =3D kstrtouint(buf, 10, &bounce_size);
> @@ -1983,8 +2086,17 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>                               GFP_KERNEL);
>         if (!dev->groups)
>                 goto err_vq_groups;
> -       for (u32 i =3D 0; i < dev->ngroups; ++i)
> +       for (u32 i =3D 0; i < dev->ngroups; ++i) {
>                 dev->groups[i].dev =3D dev;
> +               rwlock_init(&dev->groups[i].as_lock);
> +       }
> +
> +       dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : confi=
g->nas;
> +       dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
> +       if (!dev->as)
> +               goto err_as;
> +       for (int i =3D 0; i < dev->nas; i++)
> +               mutex_init(&dev->as[i].mem_lock);
>
>         dev->name =3D kstrdup(config->name, GFP_KERNEL);
>         if (!dev->name)
> @@ -2022,6 +2134,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>  err_idr:
>         kfree(dev->name);
>  err_str:
> +       kfree(dev->as);
> +err_as:
>         kfree(dev->groups);
>  err_vq_groups:
>         vduse_dev_destroy(dev);
> @@ -2147,7 +2261,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *de=
v, const char *name)
>
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>                                  &vduse_vdpa_config_ops, &vduse_map_ops,
> -                                dev->ngroups, 1, name, true);
> +                                dev->ngroups, dev->nas, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
> @@ -2162,7 +2276,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev,=
 const char *name,
>                         const struct vdpa_dev_set_config *config)
>  {
>         struct vduse_dev *dev;
> -       int ret;
> +       size_t domain_bounce_size;
> +       int ret, i;
>
>         mutex_lock(&vduse_lock);
>         dev =3D vduse_find_dev(name);
> @@ -2176,29 +2291,38 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>                 return ret;
>
>         mutex_lock(&dev->domain_lock);
> -       if (!dev->domain)
> -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> -                                                 dev->bounce_size);
> -       mutex_unlock(&dev->domain_lock);
> -       if (!dev->domain) {
> -               ret =3D -ENOMEM;
> -               goto domain_err;
> +       ret =3D 0;
> +
> +       domain_bounce_size =3D dev->bounce_size / dev->nas;
> +       for (i =3D 0; i < dev->nas; ++i) {
> +               dev->as[i].domain =3D vduse_domain_create(VDUSE_IOVA_SIZE=
 - 1,
> +                                                       domain_bounce_siz=
e);
> +               if (!dev->as[i].domain) {
> +                       ret =3D -ENOMEM;
> +                       goto err;
> +               }
>         }
>
> +       mutex_unlock(&dev->domain_lock);
> +
>         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> -       if (ret) {
> -               goto register_err;
> -       }
> +       if (ret)
> +               goto err_register;
>
>         return 0;
>
> -register_err:
> +err_register:
>         mutex_lock(&dev->domain_lock);
> -       vduse_domain_destroy(dev->domain);
> -       dev->domain =3D NULL;
> +
> +err:
> +       for (int j =3D 0; j < i; j++) {
> +               if (dev->as[j].domain) {
> +                       vduse_domain_destroy(dev->as[j].domain);
> +                       dev->as[j].domain =3D NULL;
> +               }
> +       }
>         mutex_unlock(&dev->domain_lock);
>
> -domain_err:
>         put_device(&dev->vdev->vdpa.dev);
>
>         return ret;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index a3d51cf6df3a..da2c5e47990e 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -47,7 +47,8 @@ struct vduse_dev_config {
>         __u32 vq_num;
>         __u32 vq_align;
>         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> -       __u32 reserved[12];
> +       __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> +       __u32 reserved[11];
>         __u32 config_size;
>         __u8 config[];
>  };
> @@ -82,6 +83,18 @@ struct vduse_iotlb_entry {
>         __u8 perm;
>  };
>
> +/**
> + * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA reg=
ion in an ASID
> + * @v1: the original vduse_iotlb_entry
> + * @asid: address space ID of the IOVA region
> + *
> + * Structure used by VDUSE_IOTLB_GET_FD ioctl to find an overlapped IOVA=
 region.
> + */
> +struct vduse_iotlb_entry_v2 {
> +       struct vduse_iotlb_entry v1;
> +       __u32 asid;
> +};
> +
>  /*
>   * Find the first IOVA region that overlaps with the range [start, last]
>   * and return the corresponding file descriptor. Return -EINVAL means th=
e
> @@ -166,6 +179,16 @@ struct vduse_vq_state_packed {
>         __u16 last_used_idx;
>  };
>
> +/**
> + * struct vduse_vq_group_asid - virtqueue group ASID
> + * @group: Index of the virtqueue group
> + * @asid: Address space ID of the group
> + */
> +struct vduse_vq_group_asid {
> +       __u32 group;
> +       __u32 asid;
> +};
> +
>  /**
>   * struct vduse_vq_info - information of a virtqueue
>   * @index: virtqueue index
> @@ -225,6 +248,7 @@ struct vduse_vq_eventfd {
>   * @uaddr: start address of userspace memory, it must be aligned to page=
 size
>   * @iova: start of the IOVA region
>   * @size: size of the IOVA region
> + * @asid: Address space ID of the IOVA region
>   * @reserved: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> @@ -234,7 +258,8 @@ struct vduse_iova_umem {
>         __u64 uaddr;
>         __u64 iova;
>         __u64 size;
> -       __u64 reserved[3];
> +       __u32 asid;
> +       __u32 reserved[5];
>  };
>
>  /* Register userspace memory for IOVA regions */
> @@ -248,6 +273,7 @@ struct vduse_iova_umem {
>   * @start: start of the IOVA region
>   * @last: last of the IOVA region
>   * @capability: capability of the IOVA region
> + * @asid: Address space ID of the IOVA region, only if device API versio=
n >=3D 1
>   * @reserved: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> @@ -258,7 +284,8 @@ struct vduse_iova_info {
>         __u64 last;
>  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
>         __u64 capability;
> -       __u64 reserved[3];
> +       __u32 asid; /* Only if device API version >=3D 1 */
> +       __u32 reserved[5];
>  };
>
>  /*
> @@ -280,6 +307,7 @@ enum vduse_req_type {
>         VDUSE_GET_VQ_STATE,
>         VDUSE_SET_STATUS,
>         VDUSE_UPDATE_IOTLB,
> +       VDUSE_SET_VQ_GROUP_ASID,
>  };
>
>  /**
> @@ -314,6 +342,18 @@ struct vduse_iova_range {
>         __u64 last;
>  };
>
> +/**
> + * struct vduse_iova_range - IOVA range [start, last] if API_VERSION >=
=3D 1
> + * @start: start of the IOVA range
> + * @last: last of the IOVA range
> + * @asid: address space ID of the IOVA range
> + */
> +struct vduse_iova_range_v2 {
> +       __u64 start;
> +       __u64 last;
> +       __u32 asid;
> +};
> +
>  /**
>   * struct vduse_dev_request - control request
>   * @type: request type
> @@ -322,6 +362,8 @@ struct vduse_iova_range {
>   * @vq_state: virtqueue state, only index field is available
>   * @s: device status
>   * @iova: IOVA range for updating
> + * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
> + * @vq_group_asid: ASID of a virtqueue group
>   * @padding: padding
>   *
>   * Structure used by read(2) on /dev/vduse/$NAME.
> @@ -334,6 +376,11 @@ struct vduse_dev_request {
>                 struct vduse_vq_state vq_state;
>                 struct vduse_dev_status s;
>                 struct vduse_iova_range iova;
> +               /* Following members but padding exist only if vduse api
> +                * version >=3D 1
> +                */;
> +               struct vduse_iova_range_v2 iova_v2;
> +               struct vduse_vq_group_asid vq_group_asid;
>                 __u32 padding[32];
>         };
>  };
> --
> 2.52.0
>

Thanks

