Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A858338592
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773287774; cv=none; b=pHHBClVe7ZznSS7M6r5GuQ6CAWCJmdVQ7bpk/VduS+9lBndU3YCGoKZDm7BPN/TDIiTXjYKjw1TYUp3R+ziM36HqCS+jnjEUY0g95zPmmCqJiUjpEUN/xmdhxNVpLKYasB+n7b1xxJOILepY1iIq+kD/GBs5sgJNttsER43SudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773287774; c=relaxed/simple;
	bh=BZcmOnFzH0h9DWUYDI26EzYxCrbvOKctXklmYPT55UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/AdN91H4K21Qd4uuxHw7Ufhzu8MC6c/l5U18Bdz2sQfgQsJ+zMuhTkdw22CbExI2hfKlhueCfJkTkKyNDNDSB/rwqbE4cB+9A6tTzjG+tk6COfwSDhpXGKphw3s9Gp3hJHlR5nsxeNvZxwQbBg2rOjxFNzZbNwve9sneRcI2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrHqFDTO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrHqFDTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773287771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LeKhPdUBp3iriLJztPdNdYIJ+XH9X63QOedaoxTA7oA=;
	b=KrHqFDTOCMqQagrbwTGH+cJZKsH0FADISHTD+UPqjc66hVrH85ckoCEWV+5Dh0vTlqbAyf
	KoIlrn0w9eEbGRQEMUrptlQtqkgVal+ayVrF9lp9ocyssgJWU8h9I9gwBRyZV6AOj37Tqg
	ArWlZx8T8RJ7F22SrdFvfKJwWcBifnw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-72CgkkjvNTeRG8dv7x41Iw-1; Wed, 11 Mar 2026 23:56:08 -0400
X-MC-Unique: 72CgkkjvNTeRG8dv7x41Iw-1
X-Mimecast-MFC-AGG-ID: 72CgkkjvNTeRG8dv7x41Iw_1773287767
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-359812e4fefso1029397a91.1
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 20:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773287767; x=1773892567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LeKhPdUBp3iriLJztPdNdYIJ+XH9X63QOedaoxTA7oA=;
        b=LLu9SGnC4SuQqUtNsuxN0z3jpiOJ1qNZuy0mO4qtXi88pUeHXjojxlyQmRzU3PvlCJ
         kNBJcBOFEM/GnL095aQ/8TSll8ukIzHavRgvAjjt9rauHKB/qir3v1sC5/RPLuh8hrUu
         XweNKcfGC2G86v79U4id/SXOikgT25lXeq1gdq0oFT3y2/OZkNeyNwAeGNHTWXZsL3Bx
         a3guDmDbe7e2J6IufAIDwRu0KI3vem5Y/N/SO1Ziusi5WL2WA5+J1pgOpQ3kbKBCJccV
         dseEncoVrpl63QWu4r2z5AbMY8wJgPamrZRXfXSHtxof7rRQ9AirJ2RnB+qHPeH55D6Y
         RNxA==
X-Forwarded-Encrypted: i=1; AJvYcCXBOsCZFnIIFDizbGHCtXwFkEBNFKxgNPCgESP5oCXqphoFYffqgYPsPn+MLImGn64mE7LnBbc4g0Fs62DD0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIXrqySl8x5J1KQWjVnFCl4GyEDNYtTy1UivCCQ5oJHHQ71xoL
	BCSNJe5kFfdTBs/80atYVFy/BPu3U0T1PoLP7svt9SuwTZzkhZtSkiChW6UVxdoKai26bAf8zUh
	3N4KTRMWyHNdLdWxP2lmcMrJ99gqJGV57Lii4s5mC/QeDVVTyPoVz/+SlBHBYkmb38s72efA2o/
	AWfQkiJ6pyPRil6+s1zyiia54Rrz67Z70NDTGVoxWd7zM=
X-Gm-Gg: ATEYQzwbLsLGXnTe4i6me+UFuj6mrTEq90C40RJ8XSIWLKrHclwo5oBZWKtDEeiddCY
	6bcEykHe2cYWijCtO54yRKxiMb0Fq+ORDXs3ZH/JPLa6G/W7uBQO+CNH8YwxCnTa5LEFzFHUlld
	9QXFoKagNlWapKfSGyYOPpGY09k6juJkLoC6+LxacBq496sS5PfR9TMfOyf+RDDfJc3HTAISh32
	8i18SIJ
X-Received: by 2002:a17:90b:4a05:b0:359:f575:cc0f with SMTP id 98e67ed59e1d1-35a119ce127mr1795414a91.6.1773287766978;
        Wed, 11 Mar 2026 20:56:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4a05:b0:359:f575:cc0f with SMTP id
 98e67ed59e1d1-35a119ce127mr1795391a91.6.1773287766552; Wed, 11 Mar 2026
 20:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-3-eperezma@redhat.com>
In-Reply-To: <20260310190759.1097506-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Mar 2026 11:55:55 +0800
X-Gm-Features: AaiRm52j5A-66lZNvpAXpR-YBZhWWSirbxidcINEXSQ5_2huUJlf-8DXty0GXJ0
Message-ID: <CACGkMEvafXSWZBsDtt5-zit5_po6U35ciP_-yhbv-MtKo4uG7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vduse: add VDUSE_GET_FEATURES ioctl
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2liidBD1Nx6M-mgD-zzFbHflY-5xboKYPb1b1s37QRg_1773287767
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
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
> v3:
> * Remove check for API_VERSION < 2
> * Add comment about struct vduse_dev_config:vduse_features is only valid
>   if VDUSE_GET_FEATURES success.
>
> v2:
> * return -EINVAL if ioctl called with version < 2, so userland visible
>   reply is kept (Jason).
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
>  include/uapi/linux/vduse.h         | 7 ++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index d1da7c15d98b..17e0358d3a68 100644
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
> @@ -2207,6 +2210,10 @@ static long vduse_ioctl(struct file *file, unsigne=
d int cmd,
>                 ret =3D vduse_destroy_dev(name);
>                 break;
>         }
> +       case VDUSE_GET_FEATURES:
> +               ret =3D put_user(vduse_features, (u64 __user *)argp);
> +               break;
> +
>         default:
>                 ret =3D -EINVAL;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 361eea511c21..e9b5f32a452d 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -33,6 +33,7 @@
>   * @vq_align: the allocation alignment of virtqueue's metadata
>   * @ngroups: number of vq groups that VDUSE device declares
>   * @nas: number of address spaces that VDUSE device declares
> + * @vduse_features: VDUSE features
>   * @reserved: for future use, needs to be initialized to zero
>   * @config_size: the size of the configuration space
>   * @config: the buffer of the configuration space
> @@ -49,7 +50,8 @@ struct vduse_dev_config {
>         __u32 vq_align;
>         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
>         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> -       __u32 reserved[11];
> +       __u64 vduse_features; /* if VDUSE_GET_FEATURES is not EINVAL */
> +       __u32 reserved[9];

If we go with VDUSE_GET_FEATURES, I'd perfer to go with
VDUSE_SET_FEATURES intead of this.

But we can hear from others.

>         __u32 config_size;
>         __u8 config[];
>  };
> @@ -63,6 +65,9 @@ struct vduse_dev_config {
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

Thanks

