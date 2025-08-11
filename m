Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F219F40B
	for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754881811; cv=none; b=Gh6GfqUk/EfSNkSXjVCzLhFjLEfaDxFprJNZ4qeWX5NxNEe5gmvkDSfTFFCgt05lEmZNVWhqaGaMVvCdcZ0V7ab4IA8hm6GpVwjx+Ytnt7UELgpvOKKlaM+5Agfl0G9qeSyzCGkyrJU5Wwz+Xi6aTUgmDFe4dY6dNwsFqzjsDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754881811; c=relaxed/simple;
	bh=gmFBvAsAXFhHJ5DXWqnrqxnDPhs8jC4gkrep2Sry10g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P05iZH1/nPO5UFSDw2MrBcQ44sD5xjGF/Z1pXuJTytxRmW9hT/9cHJrTUiTqktoYVLqGEfxJoXpclC1reZRhL01D8US0LMfNx0/iqYp6CO/CENylQvQTC+I5OuE5qTxviZeQ/Hjmq+z7F7lv3giqSmIjRCt5bOfHsYnUGY7zeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvCTxMZF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvCTxMZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754881808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20ghAhTra6izBIEKTsU0crmKM6rj8P8UsO71njZ+5PA=;
	b=hvCTxMZFP8i58sGaaIA8HROrryMVZp4BFkAcrQPxHSvkF0TY1lcr/IT5yiEvJamkwMplXW
	grHQkw5hm+IousxsYXf9Uw23GZe2s2dZ2EctvQCE+Kc4VAytgEPHNwpva6+x/H3V1hu5L8
	+MHQqP4KrU94kZ32V24GM2+ojbWTdVI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-RZjV4RJHNnCpuZ_Wss7rrg-1; Sun, 10 Aug 2025 23:10:06 -0400
X-MC-Unique: RZjV4RJHNnCpuZ_Wss7rrg-1
X-Mimecast-MFC-AGG-ID: RZjV4RJHNnCpuZ_Wss7rrg_1754881794
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31ea6231678so4374523a91.0
        for <virtualization@lists.linux.dev>; Sun, 10 Aug 2025 20:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754881794; x=1755486594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20ghAhTra6izBIEKTsU0crmKM6rj8P8UsO71njZ+5PA=;
        b=PHM6G1NQsS3TRtVotjYQjxgB2/Fw2bBqHC5YS3mcIIx42I1D/TZNaH+aAl9OxqpcVe
         mBlv8b/Hv+PTYEMLd81DnNcwoC8WRSuzSi5U8vHusM4cAKf5w2t0a9BUXI/Rgmz2BcTe
         nO/naWaEIkJWqiFvS8xYU5SM+zXHEHCUfqc/t7jf7y9WfTKKfM1mUMl/JRqobc0dKdwS
         /CZ3067M77zDvMHM8bz8YRmwT/OgBpJM4ou92xQwd2FzHLoTbr2Xh27DvyDtSVXe/Kij
         KqEuyA1blCdjBmNsG2Dfj7JfpUia90rcq4fPnyS+K0OAO8Wwoav2Y391kUaoidOwS2tF
         AVJg==
X-Forwarded-Encrypted: i=1; AJvYcCUN6SNRssy/8K33zqKhUI5Xej4d5LztVAF9dazwIToSMJNv0VB4Nvv8Iij/V0kFWd+fRV+2d9mBCKwIqC+WsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJ/fh8xt1uuCLSeafzfZnmUSXIT08ZHvEAtOQ4i/NbcBXJKmSL
	28OK8AXY20O9QEgvZheI8tdMB2NGDOhW4gq/6U5bCizomYs9iPwi48C6d+yia5CMrllOMNGxKwh
	l/3WSGuLRcwa6Zscb8yTXuL748P5+ASPiHgvOP81BHyRpe5i5PBTXyjcCE9SwBlUOZqRDSjotcP
	rnUBmr2RylsgBzxo0eybOmuZJ8jf7PR5mQ0XuMp6qsiWE=
X-Gm-Gg: ASbGncsfr08glMr16aj489Qs7UP/nzyrQHwSjKnZVEahCijpebs8vMQsCLgSwoNVYQz
	taXd65fVehM34qxUIOdk9Ix4Mw/nUin93AN1LWowZVmKbP5DZFfT7wyiRzQ/WhtTQ0mFFcqPLrW
	aaSXn4s8I96aEjGxhlfao=
X-Received: by 2002:a17:90b:4986:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-3218439db43mr18155725a91.8.1754881794073;
        Sun, 10 Aug 2025 20:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Fs7VVa0FzIKzinv2kEUKLby94eOvwISEi+KslRsbTo/SBws2naemJhmXAHJ7/cbZMrOelyftz/so8ltFrO8=
X-Received: by 2002:a17:90b:4986:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-3218439db43mr18155700a91.8.1754881793611; Sun, 10 Aug 2025
 20:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Aug 2025 11:09:42 +0800
X-Gm-Features: Ac12FXyd2NEMDD86QVQx-BBNPdp7ly5Y3cms8CTZ-KwtgAbSfMFH_t9eySwY9kY
Message-ID: <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QTkENTiG43H717SJWfZc_bS1jOyr1wEgPv3zjjFkYMU_1754881794
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> This allows sepparate the different virtqueues in groups that shares the
> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
>
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
>
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 71 +++++++++++++++++++++++++++++-
>  include/uapi/linux/vduse.h         | 19 +++++++-
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index d858c4389cc1..d1f6d00a9c71 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -46,6 +46,11 @@
>  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
> +/*
> + * Let's make it 3 for simplicity.
> + */
> +#define VDUSE_MAX_VQ_GROUPS 3

I think we can release this to something like 64. Otherwise we might
bump the version again just to increase the limitation? Or having a
sysfs entry like bounce_size?

> +
>  #define IRQ_UNBOUND -1
>
>  struct vduse_virtqueue {
> @@ -58,6 +63,8 @@ struct vduse_virtqueue {
>         struct vdpa_vq_state state;
>         bool ready;
>         bool kicked;
> +       u32 vq_group;
> +       u32 vq_desc_group;
>         spinlock_t kick_lock;
>         spinlock_t irq_lock;
>         struct eventfd_ctx *kickfd;
> @@ -114,6 +121,7 @@ struct vduse_dev {
>         u8 status;
>         u32 vq_num;
>         u32 vq_align;
> +       u32 ngroups;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa_devic=
e *vdpa, u16 idx,
>         return 0;
>  }
>
> +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +
> +       return dev->vqs[idx]->vq_group;
> +}
> +
> +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +
> +       return dev->vqs[idx]->vq_desc_group;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_device =
*vdpa)
>         return dev->status;
>  }
>
> +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> +{
> +       if (dev->api_version < VDUSE_API_VERSION_1)
> +               return 0;
> +
> +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> +               struct vduse_dev_msg msg =3D { 0 };
> +               int ret;
> +
> +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> +               msg.req.vq_group.index =3D i;
> +               ret =3D vduse_dev_msg_sync(dev, &msg);

I fail to understand why the default group mapping is not done during
device creation.

> +               if (ret)
> +                       return ret;
> +
> +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> +
> +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> +               ret =3D vduse_dev_msg_sync(dev, &msg);
> +               if (ret)
> +                       return ret;
> +
> +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.num;
> +       }
> +
> +       return 0;
> +}
> +
>  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       u8 previous_status =3D dev->status;
>
>         if (vduse_dev_set_status(dev, status))
>                 return;
>
> +       if ((dev->status ^ previous_status) &
> +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> +               if (vduse_fill_vq_groups(dev))

Can we merge the two messages into a single one? Or can we use a
shared memory for storing such mapping?

For example, if we have 256 queues it would be very slow.

Thanks

