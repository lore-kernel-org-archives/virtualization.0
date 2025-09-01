Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5930CD95
	for <virtualization@lists.linux.dev>; Mon,  1 Sep 2025 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756691966; cv=none; b=KAHE0+ERFKPdBPtYTA1m49cYjyS8sdP2ayou95i5O9wAVfAqhn6HB7vF9SXBBMKA5ytfUoj3/A7FOIe/KH/fqTDpL/USZF6h0RXrtwD4EffKqCp7GF4zGYITAY3eDxsG3hrlJt1T2gF8UQOtAg0k2E85mKPHfusGiRWExZGzrAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756691966; c=relaxed/simple;
	bh=hxvcKPw08t6dOgnJ88hYqLOR9p0U3nCgO7zJtSlQU0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjS6O4sBmgXXJ3zGqjMpV+FJfxwxo9aTvtMfNXtuvvfQAuquwqGjVdDUU05wSFMND4Nj57s1OAv0ukdkxRHtFSX1dzVxmVYOkzUtr5b+z+1PCoWeWht8q4DELAsuVjgPM6SGlhWKoMkzLLrkSyq/Tvp6+RxkwCaoLqvhc5v3RqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl2Q+I96; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl2Q+I96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756691963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy6pCYXTmSFNaHwV4XPd6mA/0aEtVrvyd7MZaD2NYeQ=;
	b=hl2Q+I96zxLlM9K0pdum31F6JORFtfRc0xs1kvl9HirBe6CAablhVvlwO22V2fwXau7ZK8
	Mve8J7vyWFaWo2FS+BApklVmtE/AbRNVTdLutF5bc80Avssgc0iLim1brLktS9RoiYiPWa
	0OhRPO8kIhQsP1K29nXXF7AFYGluWys=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-W-TH5ntTMpOe0VMSVIfgSA-1; Sun, 31 Aug 2025 21:59:22 -0400
X-MC-Unique: W-TH5ntTMpOe0VMSVIfgSA-1
X-Mimecast-MFC-AGG-ID: W-TH5ntTMpOe0VMSVIfgSA_1756691961
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24a9cc916baso9280185ad.2
        for <virtualization@lists.linux.dev>; Sun, 31 Aug 2025 18:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756691961; x=1757296761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy6pCYXTmSFNaHwV4XPd6mA/0aEtVrvyd7MZaD2NYeQ=;
        b=jIUiSM0UMEdPTIvwZZxXg3QwtnHO7WOp0vurFU2NERbn1lMvOtHwPxPPksh4dTbgME
         SY5vkztue9vFVk95+PHhXL3ncUULOulle2BxaHicP6OaU01D2q1RpZZrbsn5kWgtcrQc
         FRuyaGNsq0yygdfcYHmGNpIH8zTw2Ji9G8+iWlPBO74iebBcuMVmSXCTETjx3NEerT3S
         dbkP5GUyhFe0lhyFFlVyfraI07BGf1hSr1C+CW0mRfsZkv3rU8sBZ1MBrLnL0S5lmY+K
         bAdD+Ai27IDAfR5dblqUWkNFMTxqcm1PKXScQjVeSbZPNtfsR4aaA6+y2ifGUFOrzgYm
         pL2g==
X-Forwarded-Encrypted: i=1; AJvYcCVYARdh11yOFBX7jAoFNjpI1VfS9fnczM2ATLQ4FhJPeFAQf3I8YOyna/2JwBpUd3bML0ovBPgzT9HE4BHFiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFzmEhVdp2jhJGUe80Y04ejggkDDCSG1tuPKmam51qD3J0btzF
	h+qlexGnmTB2VxwoHWABl/Uo2L2iu9zMOx1tOGo7sn7boZDZ9p/Ba6lkDThCLK/7oPly8nq32Bp
	HijMrrgMIw/Ygw/Ja1HWt7WmsDAPZXrwK/Xk+v1syrT+qlLohyAC75vrnJ4M+L2rXiDhPuPiBeC
	XoCq8QecAOUtqE0BMEZ9dG/5UtgET/+0jfgHpdemJgkH4=
X-Gm-Gg: ASbGncuW9ym9waCSosMuWAv0zRq/zeOaUx0ssdKx5nSccfOvW/wnIlNvjudJI2bAQJC
	RC6B6Wc1/OQFQudOrmp0K5Eud07gBERCSkjxJEXEHwEdr7i3eBDoNP7acmrOgfC833HJR8Tiq8q
	MkjhkbxnVvCkG8sJwGkKsP
X-Received: by 2002:a17:902:cf08:b0:246:6442:19e4 with SMTP id d9443c01a7336-24944b2608cmr69245195ad.58.1756691960980;
        Sun, 31 Aug 2025 18:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgTnaAKaX1sVavgqnjJAd5HeZ8SNMZmOh35Nw4dqxmO6Pmc5GyzQXusxsEKEQ/nNV9UA+G4TjhXsA/GAxBry0=
X-Received: by 2002:a17:902:cf08:b0:246:6442:19e4 with SMTP id
 d9443c01a7336-24944b2608cmr69244915ad.58.1756691960491; Sun, 31 Aug 2025
 18:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Sep 2025 09:59:02 +0800
X-Gm-Features: Ac12FXxuRZfQdFAmVZa559oY81QvFEDH1_a-lZcT0HnKzKi5ilVU5yKnNxoJaBk
Message-ID: <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4P85miEjZDkJ1TGLEoN7xYq7J35y7Kr73T24XEkB3K8_1756691961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
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
> v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
>
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove the descs vq group capability as it will not be used and we can
>   add it on top.
> * Do not ask for vq groups in number of vq groups < 2.
> * Move the valid vq groups range check to vduse_validate_config.
>
> RFC v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++++++--
>  include/uapi/linux/vduse.h         | 21 +++++++++++-
>  2 files changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index e7bced0b5542..0f4e36dd167e 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -58,6 +58,7 @@ struct vduse_virtqueue {
>         struct vdpa_vq_state state;
>         bool ready;
>         bool kicked;
> +       u32 vq_group;
>         spinlock_t kick_lock;
>         spinlock_t irq_lock;
>         struct eventfd_ctx *kickfd;
> @@ -114,6 +115,7 @@ struct vduse_dev {
>         u8 status;
>         u32 vq_num;
>         u32 vq_align;
> +       u32 ngroups;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_devic=
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
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_device *=
vdpa)
>         return dev->status;
>  }
>
> +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> +{
> +       /* All vqs and descs must be in vq group 0 if ngroups < 2 */
> +       if (dev->ngroups < 2)
> +               return 0;
> +
> +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> +               struct vduse_dev_msg msg =3D { 0 };
> +               int ret;
> +
> +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> +               msg.req.vq_group.index =3D i;
> +               ret =3D vduse_dev_msg_sync(dev, &msg);
> +               if (ret)
> +                       return ret;
> +
> +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.group;
> +       }
> +
> +       return 0;
> +}
> +
>  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdpa_device=
 *vdpa, u8 status)
>         if (vduse_dev_set_status(dev, status))
>                 return;
>
> +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK) &&
> +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> +               if (vduse_fill_vq_groups(dev))
> +                       return;

I may lose some context but I think we've agreed that we need to
extend the status response for this instead of having multiple
indepdent response.

> +
>         dev->status =3D status;
>  }
>
> @@ -789,6 +825,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
>         .set_vq_num             =3D vduse_vdpa_set_vq_num,
>         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> +       .get_vq_group           =3D vduse_get_vq_group,
>         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
>         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
>         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> @@ -1737,12 +1774,19 @@ static bool features_is_valid(struct vduse_dev_co=
nfig *config)
>         return true;
>  }
>
> -static bool vduse_validate_config(struct vduse_dev_config *config)
> +static bool vduse_validate_config(struct vduse_dev_config *config,
> +                                 u64 api_version)
>  {
>         if (!is_mem_zero((const char *)config->reserved,
>                          sizeof(config->reserved)))
>                 return false;
>
> +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> +               return false;
> +
> +       if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups > 0xf=
fff)
> +               return false;

Let's use a macro instead of magic number.

> +
>         if (config->vq_align > PAGE_SIZE)
>                 return false;
>
> @@ -1858,6 +1902,7 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
>         dev->vendor_id =3D config->vendor_id;
> +       dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups ?:=
 1);
>         dev->name =3D kstrdup(config->name, GFP_KERNEL);
>         if (!dev->name)
>                 goto err_str;
> @@ -1936,7 +1981,7 @@ static long vduse_ioctl(struct file *file, unsigned=
 int cmd,
>                         break;
>
>                 ret =3D -EINVAL;
> -               if (vduse_validate_config(&config) =3D=3D false)
> +               if (!vduse_validate_config(&config, control->api_version)=
)
>                         break;
>
>                 buf =3D vmemdup_user(argp + size, config.config_size);
> @@ -2017,7 +2062,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *de=
v, const char *name)
>
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>                                  &vduse_vdpa_config_ops, &vduse_map_ops,
> -                                1, 1, name, true);
> +                                dev->ngroups, 1, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 9a56d0416bfe..b1c0e47d71fb 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -31,6 +31,7 @@
>   * @features: virtio features
>   * @vq_num: the number of virtqueues
>   * @vq_align: the allocation alignment of virtqueue's metadata
> + * @ngroups: number of vq groups that VDUSE device declares
>   * @reserved: for future use, needs to be initialized to zero
>   * @config_size: the size of the configuration space
>   * @config: the buffer of the configuration space
> @@ -45,7 +46,8 @@ struct vduse_dev_config {
>         __u64 features;
>         __u32 vq_num;
>         __u32 vq_align;
> -       __u32 reserved[13];
> +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> +       __u32 reserved[12];
>         __u32 config_size;
>         __u8 config[];
>  };
> @@ -160,6 +162,16 @@ struct vduse_vq_state_packed {
>         __u16 last_used_idx;
>  };
>
> +/**
> + * struct vduse_vq_group - virtqueue group
> + * @index: Index of the virtqueue
> + * @group: Virtqueue group
> + */
> +struct vduse_vq_group {
> +       __u32 index;
> +       __u32 group;
> +};
> +
>  /**
>   * struct vduse_vq_info - information of a virtqueue
>   * @index: virtqueue index
> @@ -274,6 +286,7 @@ enum vduse_req_type {
>         VDUSE_GET_VQ_STATE,
>         VDUSE_SET_STATUS,
>         VDUSE_UPDATE_IOTLB,
> +       VDUSE_GET_VQ_GROUP,
>  };
>
>  /**
> @@ -316,6 +329,7 @@ struct vduse_iova_range {
>   * @vq_state: virtqueue state, only index field is available
>   * @s: device status
>   * @iova: IOVA range for updating
> + * @vq_group: virtqueue group of a virtqueue
>   * @padding: padding
>   *
>   * Structure used by read(2) on /dev/vduse/$NAME.
> @@ -328,6 +342,8 @@ struct vduse_dev_request {
>                 struct vduse_vq_state vq_state;
>                 struct vduse_dev_status s;
>                 struct vduse_iova_range iova;
> +               /* Only if vduse api version >=3D 1 */;
> +               struct vduse_vq_group vq_group;
>                 __u32 padding[32];
>         };
>  };
> @@ -338,6 +354,7 @@ struct vduse_dev_request {
>   * @result: the result of request
>   * @reserved: for future use, needs to be initialized to zero
>   * @vq_state: virtqueue state
> + * @vq_group: virtqueue group of a virtqueue
>   * @padding: padding
>   *
>   * Structure used by write(2) on /dev/vduse/$NAME.
> @@ -350,6 +367,8 @@ struct vduse_dev_response {
>         __u32 reserved[4];
>         union {
>                 struct vduse_vq_state vq_state;
> +               /* Only if vduse api version >=3D 1 */
> +               struct vduse_vq_group vq_group;
>                 __u32 padding[32];
>         };
>  };
> --
> 2.51.0
>

Thanks

