Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797021D3F2
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770883629; cv=none; b=nUwSIrKqOd8fzRQm0sLZiDZNyxoRWCXPpexExb5phv2YQ7/+euy05rls6uojUBXkRDQ3oaY9GU+hAc/1VE5P6w1zX7aGHwcPXAxBn9d//EE2SHIQTe0ykGuNELbrhs+NKfysUbgrs8QgwfaD+G7RPkcMPdza5bqUaZHcTZqhT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770883629; c=relaxed/simple;
	bh=Z3+dtIELm9MBOil80TvrlZA/hw8XFPCYjR69yDFviso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKpiCKrjcb+Rp0q9xykp2fCXRUNXWxtbOEDkMu7sikmLtRrGD/5YuB1Ux9rpe8v+FcN5dlJawHNp8D0gswFySf9kZhgPhaE7SQLFwBHE4NDxVkjTdJvPwuGwJT6oeKMcq7cM5BmEdftIwgq6gxkC2PzzMvXdBn8Nz/CenwTgdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/vS7g7J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/vS7g7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770883627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQP/ZQyNeJyM96N8F6ROGB/0l89bGnM395m7PjIY3DQ=;
	b=P/vS7g7J3tlAKNLFvG4gO62AO9a7c1xoZ6zLpQ7V4vOVJrBd4IVVGGXUGMiZrqUWUQOots
	87rJ3d4sJjGyw5tKys6GwUmnZ/aDpEVwDQeQXlyPL5MwYSos+VV7Lum2REjqjWOL9mpme6
	wFdSItnKGzvQ735LrGXqljLq4Nlo9/Q=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-2FLUFgkUNU-y2TXo6kgJvQ-1; Thu, 12 Feb 2026 03:07:06 -0500
X-MC-Unique: 2FLUFgkUNU-y2TXo6kgJvQ-1
X-Mimecast-MFC-AGG-ID: 2FLUFgkUNU-y2TXo6kgJvQ_1770883625
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a9638b0422so33743785ad.3
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 00:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770883625; x=1771488425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQP/ZQyNeJyM96N8F6ROGB/0l89bGnM395m7PjIY3DQ=;
        b=sQlc4xiErm+UBZwonFS+ImVkftfElCmnMwCIM6BEyTwHd/j6DFETC9984FXis3Vx7T
         79w1DYLUZd2dpXvYBvYIKzs4hAVnAU/Mip6H8EfRB3Z5HC4IKoDbh6px7V72XJCfee+C
         7T+x17i1E1ItHaaJCzprXzaLUOQofR512WnvALzlUiOdiaeYd9Ry2TfOTFHh+rq/YBxB
         XC8nQnfZzB7B1bDRoThFLqx5z2ypI4w7FdsjqL3QL8Qb/5fH4IsyWJrwvoqOvZT0L8WN
         HbCAJi1V3BpVmZE2r7vQfBq4WIY/3dYwQYENtnoNlDHjg19+L/mTCE5e/BelooWEAXAZ
         CLQA==
X-Forwarded-Encrypted: i=1; AJvYcCUEaBBzZCD12a5uBYQNvVevjTnZvXxUWMUTwUSmYKrGKcPZjckKAwbpuTGvzoR2qpa6iOtwdyBI0uRF9XtjEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi0yJp5EI15pb6X+wCUN7zv8gkPnILs/c6KlBofw2G4GkStzsm
	1JnyOgyO84Bq2uS+OkW7BXfr4kd0ydCFIeZc0b9rvJG6481lqmMpD5WEj2RqRpx9Bn2K2FdbN2n
	ApqiNJG6zhiTRYZt93a03phv19snhmEA1OrmcngZE2fVSULDZp0D2rFl09Czwa4OqUqyJJA/z5l
	ASC2FXHg42Gp5mWhgIyZO9OBhODg8stuKCWjwpHj7vB6o=
X-Gm-Gg: AZuq6aLnos6jya0RvsWTtzhpauW8mPtm2nrJo//EhP8Yv+RMGKnt5Sdp771Bw32HKmR
	V/A5Oqw0zKg6W2f1zO7Dr/yFDSip1O+Yy6DGtiPpaDjhvBR7TkLbP0TE5JWMzQS+vLy9XCp59Ou
	kiDb1fCl1D6Miv15+g7OyLRz69Q7RHueeRkthkk+dNPRwQZ2tEdfXYN0s76STx88/c4n0+jTD3K
	wUT0Y4=
X-Received: by 2002:a17:902:da83:b0:2aa:3ec2:3774 with SMTP id d9443c01a7336-2ab399a122amr20673625ad.16.1770883624844;
        Thu, 12 Feb 2026 00:07:04 -0800 (PST)
X-Received: by 2002:a17:902:da83:b0:2aa:3ec2:3774 with SMTP id
 d9443c01a7336-2ab399a122amr20673375ad.16.1770883624390; Thu, 12 Feb 2026
 00:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260210082554.1582553-1-eperezma@redhat.com> <20260210082554.1582553-4-eperezma@redhat.com>
In-Reply-To: <20260210082554.1582553-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Feb 2026 16:06:52 +0800
X-Gm-Features: AZwV_Qg_dCR4UK7rdf2ZCqNRREl0xszk-SGjufW7yvPcR3g1H7j5DhS89Tgh1Fc
Message-ID: <CACGkMEtmnV5xJ6crnfTr5Nk8tZe437OgqB22yTOJ+nnrb0LcPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J4n6Wcg-zMO3m0uRweMBkitKk3q0rb5KT7EbO6ks-8g_1770883625
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 4:26=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
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
> v2:
> * return -EINVAL if ioctl called with version < 2, so userland visible
>   reply is kept (Jason).
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         |  7 ++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index d1da7c15d98b..7458cbaed4c7 100644
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
> @@ -1947,6 +1950,19 @@ static bool vduse_validate_config(struct vduse_dev=
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
> @@ -2207,6 +2223,18 @@ static long vduse_ioctl(struct file *file, unsigne=
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
> +                       ret =3D -EINVAL;
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
> index 27832d46084c..8898d9daa777 100644
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

Nit: Should we document " /* if VDUSE_API_VERSION >=3D 2 */

But I have an open question, is this better to just introduce a
VDUSE_SET_FEATURES then we can do negotiation to avoid bumping API
versions?

Thanks

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
> 2.53.0
>

