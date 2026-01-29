Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A8346AC2
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652650; cv=none; b=tYdnepB0mTu5dCI4FpyaquF9v6SAwFAmOx2HxVP7QMgO5hW1Aq0CCCaJr5VNO1W3ZUNRGGphrsSqPOx5UWsWKR8uejS/ZqXfwEJTAwGxoNTrxiNCy/T/qi4Cyt6jzIyLvWTIV4ym/ww0iVP3T/aSVlRxwd0sxRmyP1VquaPItUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652650; c=relaxed/simple;
	bh=wvihzst/jKcDAcpowxwSWL2U4JH/z9wiZvESEqZ73/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hidzTH5+0YdhYUjEmGZzzIa5B2pGZdV2RVPjTAdGYWdCg9s2tzAtniJoi1U2rKIsOSUG9SFWbqkhECU8EIuQe9IBVY1lfRXLh3/fmVjf5JbaYbILLD93hnjOe6mgaUtfbt/qIuNBt7fVQY6TJfTI5jLLJYDIjC4zBX3Kol2Hp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNZd8mWo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNZd8mWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769652644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpsjzM8o4+ZDwslK5V4RONLi8jG5jAYafBS61HAPtQM=;
	b=DNZd8mWoSz3E0/GhPwUdUSxaLbk7W5GekojXbZslN04ojph1lFCFKK+zAySaMMXe5o9zoB
	2Kd2KlWb32sgsxY2dqCX/Rk7z3rL2I/QrVei95/sPx7ST+fDqXxeZeq2ARmADVQ4TMArTv
	TggEDjD/aGFHV3oJE4DezWhblGRkRo8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Gktm28sVMDW7opnVaVg7Uw-1; Wed, 28 Jan 2026 21:10:43 -0500
X-MC-Unique: Gktm28sVMDW7opnVaVg7Uw-1
X-Mimecast-MFC-AGG-ID: Gktm28sVMDW7opnVaVg7Uw_1769652642
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c5d203988so816930a91.3
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 18:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769652642; x=1770257442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UpsjzM8o4+ZDwslK5V4RONLi8jG5jAYafBS61HAPtQM=;
        b=ttq2uvh71xvugOiRlyWkJVNGVwHU+NYrCTnijr7EecA3I1YCY+Nu6NYhX6/kCK9dG8
         fNNHAwVX25o/1Or6cfO+KYBKD1vvSmSdIq9xiOggCxpT8zUqCGTImJxHMjNXBWxz7aaF
         +UTTxok9OC21A7u9BWvPv/uak+/mLcdnu/gp7pnQ45EIPxVTrUiZEiVkRdcUHNQeWBYB
         MZIRVaDvIx76Mf2uSALV/qw7dfzX/X7QNCSro6hfk6EIGL7qH7igrFLb3758t+oqLbHH
         REl/0R4aL4ZdZc7U5g75qSVYu/rwW2tpVE5FsULH2vtfNCLliov9ywNPstVA+JzC8NSg
         wv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzXK1fHOKOLSQ0o0kpB4zUPIoiPE3f8P/biNzTuU8RaBSC9LSxXeldu/qAHMyrpDcOOiy94t15i2zyV48/rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVzEJ8WUmdqzOi9S59u0V/0oEaXBYucT3K16xVivGjDcypgx/m
	hQzNPZWVAXP6P9Kx4IG4ziGQ+J3a9A6pUfH285hLTr0BFXQzdc6YfnAUOt3kABaePAmfUSZb3gi
	6IpBtkOlZlHUZIH84QX/yiS0m5Cud7FSlPc/q7MRj3yZEgmfgcuMZQJD7fO1M5HJ7nA3fNDrmMW
	fnk1tc/HLgyuUP6dHSPYyltUSK9qkB0WaY6zKJsLkGhIE=
X-Gm-Gg: AZuq6aKeWNxr8OcsWhM9ex4RUeNw2n2Zhf1JKFKXPRk79HKCfxBAwa5t4JnDZTqQeLP
	ktIg01cJV3flvkPdLhLeuy8kEntDiiXG9WIAGs3WT7jHeCify3gy+xJ0ULWEKA8LbYPtRRn3ywb
	D5fNJ8vjmmFaxHOfWEYt+1+EILgISJhitm858b3+pcIfoUw8SpJBvN2GftY5Vwy//x
X-Received: by 2002:a17:90a:d404:b0:352:bd7c:ddbd with SMTP id 98e67ed59e1d1-353fed846d8mr6495830a91.23.1769652641906;
        Wed, 28 Jan 2026 18:10:41 -0800 (PST)
X-Received: by 2002:a17:90a:d404:b0:352:bd7c:ddbd with SMTP id
 98e67ed59e1d1-353fed846d8mr6495805a91.23.1769652641410; Wed, 28 Jan 2026
 18:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-5-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jan 2026 10:10:29 +0800
X-Gm-Features: AZwV_QgRPVFBrvldkII4HIOAtVzzSG8ZQ39h4w_11OiXLtO8E7PigPPM1RlZauc
Message-ID: <CACGkMEtmw-ofTt-EVH7o4dwZEk7qtXCuAsXyb7R71693UW9-RA@mail.gmail.com>
Subject: Re: [PATCH 4/6] vduse: add VDUSE_GET_FEATURES ioctl
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vyoo3a8hIzfn9K0jdPbgBQFzgWbDF18TJL8UBcaoarg_1769652642
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add an ioctl to allow VDUSE instances to query the available features
> supported by the kernel module.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> A simple u64 bitmap is used for feature flags. While a flexible array
> could support indefinite expansion, 64 bits is sufficient for the
> foreseeable future and simplifies the implementation.
>
> Also, dev_dbg is used for logging rather than dev_err as these can be
> triggered from userspace.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         |  7 ++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 551ccde0b856..e7da69c2ad71 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -52,6 +52,9 @@
>
>  #define IRQ_UNBOUND -1
>
> +/* Supported VDUSE features */
> +static const uint64_t vduse_features;
> +
>  /*
>   * VDUSE instance have not asked the vduse API version, so assume 0.
>   *
> @@ -1977,6 +1980,19 @@ static bool vduse_validate_config(struct vduse_dev=
_config *config,
>                          sizeof(config->reserved)))
>                 return false;
>
> +       if (api_version < VDUSE_API_VERSION_2) {
> +               if (config->vduse_features) {
> +                       dev_dbg(vduse_ctrl_dev,
> +                               "config->vduse_features with version %llu=
",
> +                               api_version);
> +                       return false;
> +               }
> +       } else {
> +               if (config->vduse_features & ~vduse_features)
> +                       return false;
> +       }
> +
> +
>         if (api_version < VDUSE_API_VERSION_1 &&
>             (config->ngroups || config->nas))
>                 return false;
> @@ -2237,6 +2253,18 @@ static long vduse_ioctl(struct file *file, unsigne=
d int cmd,
>                 ret =3D vduse_destroy_dev(name);
>                 break;
>         }
> +       case VDUSE_GET_FEATURES:
> +               if (control->api_version < VDUSE_API_VERSION_2) {
> +                       dev_dbg(vduse_ctrl_dev,
> +                               "VDUSE_GET_FEATURES ioctl with version %l=
lu",
> +                               control->api_version);
> +                       ret =3D -ENOIOCTLCMD;

Should we stick to -EINVAL (see below)?


> +                       break;
> +               }
> +
> +               ret =3D put_user(vduse_features, (u64 __user *)argp);
> +               break;
> +
>         default:
>                 ret =3D -EINVAL;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index dea89ed281a7..1f68e556cbf2 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -37,6 +37,7 @@
>   * @vq_align: the allocation alignment of virtqueue's metadata
>   * @ngroups: number of vq groups that VDUSE device declares
>   * @nas: number of address spaces that VDUSE device declares
> + * @vduse_features: VDUSE features
>   * @reserved: for future use, needs to be initialized to zero
>   * @config_size: the size of the configuration space
>   * @config: the buffer of the configuration space
> @@ -53,7 +54,8 @@ struct vduse_dev_config {
>         __u32 vq_align;
>         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
>         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> -       __u32 reserved[11];
> +       __u64 vduse_features;
> +       __u32 reserved[9];
>         __u32 config_size;
>         __u8 config[];
>  };
> @@ -67,6 +69,9 @@ struct vduse_dev_config {
>   */
>  #define VDUSE_DESTROY_DEV      _IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MA=
X])
>
> +/* Get the VDUSE supported features */
> +#define VDUSE_GET_FEATURES     _IOR(VDUSE_BASE, 0x04, __u64)
> +
>  /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
>
>  /**
> --
> 2.52.0
>

Thanks

