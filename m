Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F109212EF7
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991153; cv=none; b=HsxjVgAbFio0NYlkQH34cDryYfMNH+3mC7iu7VVS2HQc6ptC3TELauWL7YluRaydtGwBfaM9h+6NQV2tXjRMpo+a3H3GX1fKwMJwNk9QlBL3x4ZSShUan+O/Zwif5bJZC6LWcZDDTJLC356P5DNB0UnqXHG8X8s2c5EqWgrAlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991153; c=relaxed/simple;
	bh=XVF/x0LDlBb9yXRs1bVbTtLmrXmFrENkF+22J4yL8ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQylKlfR9ezK2N/fr9Odo/tVUnd7cbvOvp08BjxqCY3m0hTo6o2I/gs5Wi39j3H2bMyxQ4q/Q2MCUn0fDjj8wCsUbtyHad5ZfCwTReMDPh7uGZkOJCQBzJPwS74v4PdAfP4o/Zmyzm+VeFeqquGW2X1TwtXnV5O/MYej9Hb7H0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crhZTEyD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crhZTEyD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730991150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ff04YcLV8SPdoJxeVSiu4v58xp2P44LYVgJtEbYZ2A=;
	b=crhZTEyDa69Fh/WYoVhBGAteI5MYHphmFLkJ9/w8Np02X8Z3H4gn+9qP7CbfxVS6uuzGWt
	T0AVz/QZSaGwQtyGRSKuBW2zyFf/F6+GNn6oBK1nSt5sumemd3e8CETzTokX43wjb2Uq04
	kOo1RCFhskEe/5oqYsIYS9JJcBy6yhs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-p6qpUojuP2G_nbaBxeLmsA-1; Thu, 07 Nov 2024 09:52:29 -0500
X-MC-Unique: p6qpUojuP2G_nbaBxeLmsA-1
X-Mimecast-MFC-AGG-ID: p6qpUojuP2G_nbaBxeLmsA
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6ea95f530fdso19070437b3.1
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 06:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730991149; x=1731595949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ff04YcLV8SPdoJxeVSiu4v58xp2P44LYVgJtEbYZ2A=;
        b=O59nSgg1VSeq42JPlvANBQ8g5avsLpeKCmM4NLXI0SipS4X28DMZfIH7QbW9mQnMLl
         pDVIM3tEYzowOmlACinyeIt1qrvRT6luiQes49Y/8AnP98XdrpkCaR8aFhHwOyAezAik
         19jdffcOb/1540rdC+YJEkt/qR0BaYa7DZGH7U7KJALVt476uElvpLY+jxWCnZbsuIIK
         7axYvq0u8D7rQqi+rPKAkjE6o33folIMrgtVOqcvia1BqEdxMmjOc94TZjSvNVsu4SkR
         rWmRS7I+WiY3FVapc5u2rta8aR3WilgHQFJbIb5Dd7wfJayjmLhl+N9Snn0y+NMiUmyu
         6v9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzwPaEbM8MV8IyHaf6FT7B682FOyRCb5cctXyA8ugvkfOrheQzN7mo7GHDQnNoIucM5TIHtgnwBR2YgT26dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYvS9O43KX8NIS1cJEvlabRjFVtFscvrDrEax0IvZ9LbQsJUlw
	qT4bMIV007bp4Gn65IRARH238UU4xcyanVWijc6rBU19B+ynpDxl2zb7qk5BUYMRWIzyeGlQbIp
	HzqnwiRT74+0uzEMPPEx0lkKhJr92+p2alN9j7yrG0mtz9HuWZTPjg+DfmBhrUz8unVO6qDncCU
	bHvCwY3SsztS0WVty7VY2iuhz92yuFQGuAEr8PZAU=
X-Received: by 2002:a05:690c:460e:b0:6e2:c13e:20e9 with SMTP id 00721157ae682-6e9d8b056ddmr313422957b3.38.1730991148929;
        Thu, 07 Nov 2024 06:52:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYqvt7/lT13XxcBmf4h4l8ghmjNiRZf2d8+XdMbFjM2u7ezJTrQtXi3YGHHMc7lpnFy6cI9XHQYWgxd3fJnwI=
X-Received: by 2002:a05:690c:460e:b0:6e2:c13e:20e9 with SMTP id
 00721157ae682-6e9d8b056ddmr313422887b3.38.1730991148691; Thu, 07 Nov 2024
 06:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241107132114.22188-1-colin.i.king@gmail.com>
In-Reply-To: <20241107132114.22188-1-colin.i.king@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Nov 2024 15:51:52 +0100
Message-ID: <CAJaqyWcp2kbm9uwzqPXi-M3AUT3P54az8SLHv0Ex7HpM7zHHhA@mail.gmail.com>
Subject: Re: [PATCH][next] virtio_vdpa: remove redundant check on desc
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NI_3Fa-T71Hxi8TT98lEH63R3Nm-InzJTCExHS0vpVw_1730991149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:21=E2=80=AFPM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> The boolean variable has_affinity is true when desc is non-null and
> ops->set_vq_affinity is non-null. Hence the call to create_affinity_masks
> does not need to check for desc being non-null is redundant when
> has_affinity is true, so it can be removed as well as the now unused
> default_affd.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/virtio/virtio_vdpa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 7364bd53e38d..1f60c9d5cb18 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -364,14 +364,13 @@ static int virtio_vdpa_find_vqs(struct virtio_devic=
e *vdev, unsigned int nvqs,
>         struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vdev)=
;
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> -       struct irq_affinity default_affd =3D { 0 };
>         struct cpumask *masks;
>         struct vdpa_callback cb;
>         bool has_affinity =3D desc && ops->set_vq_affinity;
>         int i, err, queue_idx =3D 0;
>
>         if (has_affinity) {
> -               masks =3D create_affinity_masks(nvqs, desc ? desc : &defa=
ult_affd);
> +               masks =3D create_affinity_masks(nvqs, desc);
>                 if (!masks)
>                         return -ENOMEM;
>         }
> --
> 2.39.5
>

