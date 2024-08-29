Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3567581F
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724906983; cv=none; b=dinlxTnADPScZUkbyaU+Bh14cfitaasqnMaOvJJxMNk8Nd6ZUEQmkkJEBQwsiJ//zKaD2ur4SY3cr9Mo86zkBsTO+RaU573zkQ5Kte+cBWfwMnWMFPEinNPexffyR3F0Q4rTZWwCesJT6HxNBSE4VGe/H2ibF2E2icihARiyo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724906983; c=relaxed/simple;
	bh=DULz1wwF4kdm3KYLQG5LDL/4PQ4uZSYOtMOIgeVVc58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dS+Kgcz5GiXZRlI8coLfg8lQi/BkojvIEEWLrIyPFsYU8CGNJnStSFg01rUo3xPwhc8I7mKmdM88sBDrpXyskizpceqRw/bzFp7LsrceNszIyi9Y7u1Bq5eor8XfyXG4xKV/Iy5feqt2AapflLwm48PNHxS0Ssek6FNmUfn+f5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfzeS4dp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfzeS4dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724906979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03Qf/XIbw5qKyffaKvRyGbHN12QPCb2FcgD6gnCFY+0=;
	b=AfzeS4dpbTnzqSrUCoZ5j6kQchdzKNJWHW5fVdJW8stcP3pZ+k2l5y52cGKhGhFk30cFa1
	O8OHoN9Clk+Fpdxv+6/e0qe66ZZDhyWhdPm+9fs6+cO4f+fKyPqdQcl8ve0qtSypGSpd30
	gNPDWAq279dxKP1kO7+TA5GRwdcsC6c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-9nO8gTq2NZaQSUVWghY-Jg-1; Thu, 29 Aug 2024 00:49:37 -0400
X-MC-Unique: 9nO8gTq2NZaQSUVWghY-Jg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d40752d653so262203a91.0
        for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 21:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724906976; x=1725511776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03Qf/XIbw5qKyffaKvRyGbHN12QPCb2FcgD6gnCFY+0=;
        b=TVa4myry56zdFNvi5s1gHcs885KGQtMa/pRSS4diOUAK/Awbzag+33vLnoo/zie1o8
         Em18fwgffh2+fETf7VHf/0R3u/kaHhOQOznZ+oeEmAA1RvW9TnWtBxA8Q/JSzUQZDgVI
         vZXXz9fjEc15X3Deg0KnnttkQvHmFPD3UfehOSfinxPPeBU+TQv4u7U9hWXJqMywGCU8
         l9URGzZ289TlQC8ZDJBX/gsi1DUUiuAH12zOKKrx+4r+uLMC7UT4P1wEyS0teg1z1Syp
         b6LCsSabIUh/x7HQyO1Px/CwgdN6WvizMVBncSkG8iIuqJbNlYECExzMBAeTt4mgkHxg
         BWzg==
X-Forwarded-Encrypted: i=1; AJvYcCXjVN44SsyYQMsGYs3P9VdYVEik6+N7JHljdmoUamgZdWhHRqGBkV+Wrx9exbd6g0opoIuMAvNJRB6m64DoDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkIOtXq9z0KyRWsCDtewzvtOI2r2KXV5lCVAMoCTnjFDWp4rga
	RbAoQDUoRLbnMRJ5GMssiJwB9PdLDYu6Tr2T7YBPZN9iUXeGERbg/8sVx7ZMqlUFTPXHl9pT3Uu
	v+nnS8PtYy4g7w123D53TJkRCkxmok8HDaC/SaO5dLNstiMihY8Ie5/7yL3RHJ6xxc9aimCD5+c
	JPt3QU+6d6HbCOUHn/x380a96PXfCluoDJGjJWTow=
X-Received: by 2002:a17:90b:3e84:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2d85618881dmr1458620a91.5.1724906976446;
        Wed, 28 Aug 2024 21:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUGAFR6tSH8vk5Ale6DnmiWQGUFCR8vJCc+FkyW8/X5qJjXCZMcxqDXb4gGd/1Grp2C5tsk8mzua6j1X27QYY=
X-Received: by 2002:a17:90b:3e84:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2d85618881dmr1458599a91.5.1724906975803; Wed, 28 Aug 2024
 21:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Aug 2024 12:49:24 +0800
Message-ID: <CACGkMEs2wDLBq3_5KDOHou3g8Cxhm9Dx8eXy7JnX0R8ZYqinZA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, bilbao@vt.edu, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, cratiu@nvidia.com, 
	lingshan.zhu@intel.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:16=E2=80=AFAM Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> From: Carlos Bilbao <cbilbao@digitalocean.com>
>
> mlx5_vdpa vDPA devices currently don't support reporting or setting the
> speed and duplex and hence should be UNKNOWN instead of zero.
>
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
>  drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
>  include/uapi/linux/vdpa.h         |  2 ++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index fa78e8288ebb..319f5c6121de 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>         init_rwsem(&ndev->reslock);
>         config =3D &ndev->config;
>
> +       /*
> +        * mlx5_vdpa vDPA devices currently don't support reporting or
> +        * setting the speed or duplex.
> +        */
> +       config->speed  =3D SPEED_UNKNOWN;
> +       config->duplex =3D DUPLEX_UNKNOWN;
> +
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>                 err =3D config_func_mtu(mdev, add_config->net.mtu);
>                 if (err)
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4dbd2e55a288..abde23e0041d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -15,6 +15,7 @@
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/virtio_ids.h>
> +#include <uapi/linux/ethtool.h>
>
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level =
operations. */
> @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk=
_buff *msg, u64 features,
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>  }
>
> +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 featu=
res,
> +                                       struct virtio_net_config *config)
> +{
> +       __le32 speed =3D cpu_to_le32(SPEED_UNKNOWN);
> +
> +       return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &=
speed);
> +}
> +
> +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 feat=
ures,
> +                                       struct virtio_net_config *config)
> +{
> +       u8 duplex =3D DUPLEX_UNKNOWN;
> +
> +       return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex),=
 &duplex);
> +}
> +
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_=
buff *msg)
>  {
>         struct virtio_net_config config =3D {};
> @@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_devi=
ce *vdev, struct sk_buff *ms
>         if (vdpa_dev_net_status_config_fill(msg, features_device, &config=
))
>                 return -EMSGSIZE;
>
> +       if (vdpa_dev_net_speed_config_fill(msg, features_device, &config)=
)
> +               return -EMSGSIZE;
> +
> +       if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config=
))
> +               return -EMSGSIZE;
> +
>         return vdpa_dev_net_mq_config_fill(msg, features_device, &config)=
;
>  }
>
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 842bf1201ac4..1c64ee0dd7b1 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -43,6 +43,8 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
>         VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
>         VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
> +       VDPA_ATTR_DEV_NET_CFG_SPEED,            /* u32 */
> +       VDPA_ATTR_DEV_NET_CFG_DUPLEX,           /* u8 */

This should be an independent patch as it allows vdpa tool to
provision speed and duplex.

But a fundamental question is if we need such provisioning?

Thanks

>
>         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>         VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> --
> 2.34.1
>

