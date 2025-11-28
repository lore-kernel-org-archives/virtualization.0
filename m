Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9F265629
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764297614; cv=none; b=lbhZeWusSl/T9ny1ZCr4aX3IINaX2HW7okoCrwbSefsn47x+KOunZCJyJgsOq+GrIqSYALZQQIfjXo0EEJhM/XHuGKhyyE15XKRKB8kNAQKjPhy/1q39fSyeRz5MY5N8NUCMIFRPuqaYYkwgytiNdoxtSg3sQ8qKDVDftjio7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764297614; c=relaxed/simple;
	bh=nqBlYAzg6qxQEMzgk9fJKhYVwAMlfJjMd6zbIrDkIsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRkrBOlLUqhSPE3OGyyXc9Oafdr8G6VB2YDQjEeqztWMKiqozeHwnZ4mbxLD24viFeU8b/inAuMLaEd+0hbuxAujjfhXb9k7Km+gq5TOLkjxOLOpYkakZwDspKHu3xpyzrVB+GqtetR1eJCti6NLOiKfSn591z2CAvJuz4mbgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpawTn2F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpawTn2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764297611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgfHeihlC+8u1mHu0tUzhZgmVFrgBxrrACIpxiuhkOQ=;
	b=VpawTn2FWrrz6b6wvwwu2luXQozS7FmUL7f27upK0CA/LfcAzAl+kdbY90w+n1REhZEp6i
	FZNEQ2TWQV9pKOX2cBcoWGKSLsUnwk9VNfaYTUFPg1LpJE1CxWFGcx3LbS3Sa2fQ5yY1Mh
	Z3r9pFMgL7QFrKVm15NNjgzYjn1POMo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-rf69yQikPM-krcgyyffUxw-1; Thu, 27 Nov 2025 21:40:10 -0500
X-MC-Unique: rf69yQikPM-krcgyyffUxw-1
X-Mimecast-MFC-AGG-ID: rf69yQikPM-krcgyyffUxw_1764297609
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343e262230eso1429320a91.2
        for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 18:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764297609; x=1764902409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgfHeihlC+8u1mHu0tUzhZgmVFrgBxrrACIpxiuhkOQ=;
        b=RGqQs756DXhAPj6kdsDYUkqNoK06pWqHfbjq418R9UiirbOaI7H1yBp18jAikQNRQZ
         ezsNOoX/Oq+TWBJUldXXTbDg28LhDzgSl+9D4Gxmwj0lef8AJQym+Tj3vMaASjUxYjWm
         OG3d1hlBpmWX70slUWvlUGHAiyuKFUSoqBVmhTL7egUHXWIatJpeK78vtLYRddsF4X1Q
         hOEXkT70ziL5Qef6LT6biJpGz3KDOKjnpbmLvCtP+SZerda1/PvUYgrjAU3OrmRGCyjV
         SWyfoKUvN9yYauFDsL4CxV5uTEUM59TYlFg4ah3TYL64zU2ZtKY7g+Gd9P3yj8mw/On5
         jMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqdbkxLaXwI7rC3M5556Bhj+Yl9MZ7EQjldUSvBRf7bUVTDJcYXfzy0M713Yum+OBmW6aKwEYAC02KzCCkdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRVgQTEfhCsK/DaBtMH1UO6H6z3DevgsVolql3zguBKiAitwPe
	lAHqCGlhUFq1r41DXXfJSZ+L9QV9zVwfHAl9kPN2zkt8UOIw/sHTKsOh9YbbmjO6hT6/ahPNP/R
	2l8BIvk7B5LLqDD6gqrhorJ2RrGbA37yBcEWKhG0K5b34FBbNnNwy8gvj98cIM0s48IbrF6HsLG
	+KP+kH/vMKORkeL4gY4FeQW02gV4GbF7WRzQE+hEushCI=
X-Gm-Gg: ASbGncuAE2x/ruteuSLZxKLr0ZFGheVadbCrSMgzwJLwBPX+bcliZkrBbAKZob0boPQ
	Lenar2EN4xtwiZvEGDXDx3JJHQHjF1p1xiGDl7dsvkwosI4RQiMSHX/hfpgy1Gdg6VC5nGMg4cW
	Y/EQGmrPrwboLx7SSAbMR9EVHYrw3YwTru2lMcc97xo5dG5krtG3KYkiSpDztQLfBC
X-Received: by 2002:a17:90b:1c04:b0:340:dd2c:a3da with SMTP id 98e67ed59e1d1-3475ebe6a55mr11921905a91.8.1764297609155;
        Thu, 27 Nov 2025 18:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4wo+b8mDxiFvbp2FfPvxTIFKnSoRJlDC8td/QTiw0D2SXKZ1egJpMpwXj6ItWG1NiPOtXpEz0QFH1u2tvrDA=
X-Received: by 2002:a17:90b:1c04:b0:340:dd2c:a3da with SMTP id
 98e67ed59e1d1-3475ebe6a55mr11921862a91.8.1764297608647; Thu, 27 Nov 2025
 18:40:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1764225384.git.mst@redhat.com> <637e182e139980e5930d50b928ba5ac072d628a9.1764225384.git.mst@redhat.com>
In-Reply-To: <637e182e139980e5930d50b928ba5ac072d628a9.1764225384.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Nov 2025 10:39:57 +0800
X-Gm-Features: AWmQ_bm__a-YRsaDl414Cee-_MAMOHTjKQ-R-ohBFRIeA6P5kRzykoXAUMexjlk
Message-ID: <CACGkMEsw7mgQdJieHz6CT3p5Pew=vH1qp5H2BSag_55w+q9Vnw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] vhost: switch to arrays of feature bits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, Mike Christie <michael.christie@oracle.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bfb6B7fgJTPPP8Y4WQPjasLg8ryk0D7Vt01wornwGyw_1764297609
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 2:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> The current interface where caller has to know in which 64 bit chunk
> each bit is, is inelegant and fragile.
> Let's simply use arrays of bits.
> By using unroll macros text size grows only slightly.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c   | 19 ++++++++++---------
>  drivers/vhost/scsi.c  |  9 ++++++---
>  drivers/vhost/test.c  |  6 +++++-
>  drivers/vhost/vhost.h | 42 ++++++++++++++++++++++++++++++++++--------
>  drivers/vhost/vsock.c | 10 ++++++----
>  5 files changed, 61 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index d057ea55f5ad..f8ed39337f56 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -69,15 +69,15 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero C=
opy TX;"
>
>  #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >=3D (__force u32)VHO=
ST_DMA_DONE_LEN)
>
> -static const u64 vhost_net_features[VIRTIO_FEATURES_U64S] =3D {
> -       VHOST_FEATURES |
> -       (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> -       (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> -       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> -       (1ULL << VIRTIO_F_RING_RESET) |
> -       (1ULL << VIRTIO_F_IN_ORDER),
> -       VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> -       VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
> +static const int vhost_net_bits[] =3D {
> +       VHOST_FEATURES,
> +       VHOST_NET_F_VIRTIO_NET_HDR,
> +       VIRTIO_NET_F_MRG_RXBUF,
> +       VIRTIO_F_ACCESS_PLATFORM,
> +       VIRTIO_F_RING_RESET,
> +       VIRTIO_F_IN_ORDER,
> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> +       VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
>  };
>
>  enum {
> @@ -1720,6 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n=
)
>  static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>                             unsigned long arg)
>  {
> +       const DEFINE_VHOST_FEATURES_ARRAY(vhost_net_features, vhost_net_b=
its);
>         u64 all_features[VIRTIO_FEATURES_U64S];
>         struct vhost_net *n =3D f->private_data;
>         void __user *argp =3D (void __user *)arg;
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 98e4f68f4e3c..f43c1fe9fad9 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -197,11 +197,14 @@ enum {
>  };
>
>  /* Note: can't set VIRTIO_F_VERSION_1 yet, since that implies ANY_LAYOUT=
. */
> -enum {
> -       VHOST_SCSI_FEATURES =3D VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_H=
OTPLUG) |
> -                                              (1ULL << VIRTIO_SCSI_F_T10=
_PI)
> +static const int vhost_scsi_bits[] =3D {
> +       VHOST_FEATURES,
> +       VIRTIO_SCSI_F_HOTPLUG,
> +       VIRTIO_SCSI_F_T10_PI
>  };
>
> +#define VHOST_SCSI_FEATURES VHOST_FEATURES_U64(vhost_scsi_bits, 0)
> +
>  #define VHOST_SCSI_MAX_TARGET  256
>  #define VHOST_SCSI_MAX_IO_VQ   1024
>  #define VHOST_SCSI_MAX_EVENT   128
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 94cd09f36f59..f592b2f548e8 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -28,7 +28,11 @@
>   */
>  #define VHOST_TEST_PKT_WEIGHT 256
>
> -#define VHOST_TEST_FEATURES VHOST_FEATURES
> +static const int vhost_test_bits[] =3D {
> +       VHOST_FEATURES
> +};
> +
> +#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)

Did you mean vhost_test_bits actually?

Thanks

