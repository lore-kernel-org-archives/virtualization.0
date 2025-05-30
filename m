Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAB1898F8
	for <virtualization@lists.linux.dev>; Fri, 30 May 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748589725; cv=none; b=ULFXKoXv82w/buMnNQVJnsbUFAvuXJ6sdWftiI9GnpcVGybjVFjT6Vnuf3xecIk+OT7to3/pKQ6nDtjNCiHwo4cSWqELq8caJZAvQI3btlUWXpG0AGm8N0t/Gy8XinU2zDcC+Zs78eEiaFusfqwQPy2PjxF3jOF4/hYGTlaO8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748589725; c=relaxed/simple;
	bh=qXkisE7VqD51yKouULNp9l74lMboUFqrKQL5xYfnOj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axkvtJ7DwNHeIsc8kiArSot8SgmVPuRcwr0BN8pV+Ft6+HE7CUch79aQeXiMDkJz/98uUYvDRQ/MTv3pMyg7VcU8BYdlchmNUFG5XtPoz1nqc7I+0HnhaAlID6HJ4xPONuCeQ7UAyLpWvGkHBZ6J7XlkfsX4N6rObPKeRG/9QIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Px7kw2oy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Px7kw2oy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748589720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmkVP+uhasaLbURIs12Cbav5wTMej3hFnwYbbQ+hjbo=;
	b=Px7kw2oyPl3n1x7Rr82kKnED4Qm0ve9ijO6sTIlh7F0MGXqg84L35K0oXdH92Fx9aNUzfK
	nnEQ6PHTbFkK2Kq5tSrH3J3k0+L2fX/6u74Lq2zGiiIcgz8HfdxLpHsb7awCuiP/o/WG76
	9exR6DtzQ1kdVVFf0nVtjghmZJwc5mA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-tRIwgHMEO_6M3D7fgYiiBQ-1; Fri, 30 May 2025 03:21:59 -0400
X-MC-Unique: tRIwgHMEO_6M3D7fgYiiBQ-1
X-Mimecast-MFC-AGG-ID: tRIwgHMEO_6M3D7fgYiiBQ_1748589718
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311d670ad35so1644471a91.3
        for <virtualization@lists.linux.dev>; Fri, 30 May 2025 00:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748589718; x=1749194518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmkVP+uhasaLbURIs12Cbav5wTMej3hFnwYbbQ+hjbo=;
        b=E3eSZm8ieL0X1F6MEDqR6xTAIbPw4E8ii3hI/TGemfxhAAVQ9w7NpzINNmpNf420L4
         Obuh0ZHK/2zaro9tVmZkZb7L8Y2i/IGPvEkK47y2QRwfmHd7a69tgx3uZmbuL8Izfq/6
         vCLzHWodKPEWJHggOH/9aAMic1eov6qApEKLfPyWZDpa73tIbG3HK8v4JsBNFYUOjISP
         BdHNggFIR0+b2dHkRD/99+DP2U09uZtHwNIZlZ6RPUuZelRhWACE1VQCqMr/Ek77Om2K
         wR16NRFotw5Ec6/EL0yiE/eau2/IGxKJYbbRUr13+ZIRYyJy1WRUu31bbmxf3EGgxhZt
         YYyA==
X-Forwarded-Encrypted: i=1; AJvYcCUtKuj4VpFJrbw2NOOICD/BB+wMPmxcpMbO9cAg+wkslFPbVLOGrUEtzPiS9YhU97fb0BGIRCqDINXlUkGA9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOLQ5wQyA8a1aak5Zjl/EeQOolS1gFmiZYuL3sYqlUfxqP2B99
	tvYTyAhskoLSn+7mKz0BgN6tajz7BCwwO32IyMcbYRj7erC35g8mA7PpomAfUiWmvVcsDObS3ts
	JeaQ0lNJWa+we9vfsx87hu2L5RVmy74ATjFvNjAK15qIG3xjztSYVO+wMYqicfk+sZmyBE8b1L8
	YtxYUQPeisFE1/AgG4GxBj/+a15joctP8KKvEiw69SJeM=
X-Gm-Gg: ASbGncs8FOnYmzZJnLSRctas7s5bWSwHFDtDEGDkbHGM74YdDAB1yH2NzxYib0Ka4zd
	5CcKNHXncvKOYYwwZDfWSNvKSNIFZqYtWAbKFjTiQVvRR8UKci8MlmKf2VRaE0J+l1Ma9
X-Received: by 2002:a17:90b:2f8c:b0:311:f2bd:dc23 with SMTP id 98e67ed59e1d1-31241735c16mr3959061a91.15.1748589718004;
        Fri, 30 May 2025 00:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq0txzqdTiLc6XdEgPp3LFgOJf68f9fcV9c27gVZrTx/1a5AxvxvGj5zXv4GGHDJ6XqZeHJ5Hi/5gKhPtFt+M=
X-Received: by 2002:a17:90b:2f8c:b0:311:f2bd:dc23 with SMTP id
 98e67ed59e1d1-31241735c16mr3959032a91.15.1748589717562; Fri, 30 May 2025
 00:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <7808f2f7e484987b95f172fffb6c71a5da20ed1e.1748503784.git.viresh.kumar@linaro.org>
In-Reply-To: <7808f2f7e484987b95f172fffb6c71a5da20ed1e.1748503784.git.viresh.kumar@linaro.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 May 2025 09:21:19 +0200
X-Gm-Features: AX0GCFtgQ2X-0AoBTHg5OW599d01liZonZ-1_cIwnv6fwLwvw9hXAXBcivLWZWc
Message-ID: <CAJaqyWdp3MJJBB1EpEhCQH+9XCtYvEhePMf1D4ADW9eUZDttjg@mail.gmail.com>
Subject: Re: [PATCH] virtio-vdpa: Remove virtqueue list
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NATJghfMXrLUo1F5C1b3mGLiZawmhlxiNmCw50CK0eE_1748589718
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 9:30=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The virtio vdpa implementation creates a list of virtqueues, while the
> same is already available in the struct virtio_device.
>
> This list is never traversed though, and only the pointer to the struct
> virtio_vdpa_vq_info is used in the callback, where the virtqueue pointer
> could be directly used.
>
> Remove the unwanted code to simplify the driver.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Only build tested.
> ---
>  drivers/virtio/virtio_vdpa.c | 44 +++---------------------------------
>  1 file changed, 3 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 1f60c9d5cb18..e25610e3393a 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -28,19 +28,6 @@ struct virtio_vdpa_device {
>         struct virtio_device vdev;
>         struct vdpa_device *vdpa;
>         u64 features;
> -
> -       /* The lock to protect virtqueue list */
> -       spinlock_t lock;
> -       /* List of virtio_vdpa_vq_info */
> -       struct list_head virtqueues;
> -};
> -
> -struct virtio_vdpa_vq_info {
> -       /* the actual virtqueue */
> -       struct virtqueue *vq;
> -
> -       /* the list node for the virtqueues list */
> -       struct list_head node;
>  };
>
>  static inline struct virtio_vdpa_device *
> @@ -135,9 +122,9 @@ static irqreturn_t virtio_vdpa_config_cb(void *privat=
e)
>
>  static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
>  {
> -       struct virtio_vdpa_vq_info *info =3D private;
> +       struct virtqueue *vq =3D private;
>
> -       return vring_interrupt(0, info->vq);
> +       return vring_interrupt(0, vq);
>  }
>
>  static struct virtqueue *
> @@ -145,18 +132,15 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, un=
signed int index,
>                      void (*callback)(struct virtqueue *vq),
>                      const char *name, bool ctx)
>  {
> -       struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vdev)=
;
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>         struct device *dma_dev;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> -       struct virtio_vdpa_vq_info *info;
>         bool (*notify)(struct virtqueue *vq) =3D virtio_vdpa_notify;
>         struct vdpa_callback cb;
>         struct virtqueue *vq;
>         u64 desc_addr, driver_addr, device_addr;
>         /* Assume split virtqueue, switch to packed if necessary */
>         struct vdpa_vq_state state =3D {0};
> -       unsigned long flags;
>         u32 align, max_num, min_num =3D 1;
>         bool may_reduce_num =3D true;
>         int err;
> @@ -179,10 +163,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, uns=
igned int index,
>         if (ops->get_vq_ready(vdpa, index))
>                 return ERR_PTR(-ENOENT);
>
> -       /* Allocate and fill out our active queue description */
> -       info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> -       if (!info)
> -               return ERR_PTR(-ENOMEM);
>         if (ops->get_vq_size)
>                 max_num =3D ops->get_vq_size(vdpa, index);
>         else
> @@ -217,7 +197,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>
>         /* Setup virtqueue callback */
>         cb.callback =3D callback ? virtio_vdpa_virtqueue_cb : NULL;
> -       cb.private =3D info;
> +       cb.private =3D vq;
>         cb.trigger =3D NULL;
>         ops->set_vq_cb(vdpa, index, &cb);
>         ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
> @@ -248,13 +228,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, uns=
igned int index,
>
>         ops->set_vq_ready(vdpa, index, 1);
>
> -       vq->priv =3D info;
> -       info->vq =3D vq;
> -
> -       spin_lock_irqsave(&vd_dev->lock, flags);
> -       list_add(&info->node, &vd_dev->virtqueues);
> -       spin_unlock_irqrestore(&vd_dev->lock, flags);
> -
>         return vq;
>
>  err_vq:
> @@ -263,7 +236,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>         ops->set_vq_ready(vdpa, index, 0);
>         /* VDPA driver should make sure vq is stopeed here */
>         WARN_ON(ops->get_vq_ready(vdpa, index));
> -       kfree(info);
>         return ERR_PTR(err);
>  }
>
> @@ -272,20 +244,12 @@ static void virtio_vdpa_del_vq(struct virtqueue *vq=
)
>         struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vq->v=
dev);
>         struct vdpa_device *vdpa =3D vd_dev->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> -       struct virtio_vdpa_vq_info *info =3D vq->priv;
>         unsigned int index =3D vq->index;
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&vd_dev->lock, flags);
> -       list_del(&info->node);
> -       spin_unlock_irqrestore(&vd_dev->lock, flags);
>
>         /* Select and deactivate the queue (best effort) */
>         ops->set_vq_ready(vdpa, index, 0);
>
>         vring_del_virtqueue(vq);
> -
> -       kfree(info);
>  }
>
>  static void virtio_vdpa_del_vqs(struct virtio_device *vdev)
> @@ -501,8 +465,6 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa=
)
>         vd_dev->vdev.dev.release =3D virtio_vdpa_release_dev;
>         vd_dev->vdev.config =3D &virtio_vdpa_config_ops;
>         vd_dev->vdpa =3D vdpa;
> -       INIT_LIST_HEAD(&vd_dev->virtqueues);
> -       spin_lock_init(&vd_dev->lock);
>
>         vd_dev->vdev.id.device =3D ops->get_device_id(vdpa);
>         if (vd_dev->vdev.id.device =3D=3D 0)
> --
> 2.31.1.272.g89b43f80a514
>

