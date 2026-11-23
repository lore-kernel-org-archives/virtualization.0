Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448359;
	b=TBt1EWxN+KwaUu7fH5Xm1auB6+xJ9KDQKtmnmHtYEPgblpADYCaTd43XtuNGuQOi/b4T
	 otdK4WCiDUD0ylNBC90LSdAVQfJOT0hL2n7T6HomvG3O8ojyIAMfdAABdzOr7gHZyn74i
	 JOXqtib6bQYWsqPcbSD80vE/Oilz9Xdfz5Wab/cF/RnpcbQSRwLRmVjtpoY2kaAi9PGbV
	 TPjSVk/yvt1ZJRoRLUM/Hhm2yfImSd2lY5ShDVBluiBZkLiRhhmlLu0DNGhXLgbMOK60K
	 cLyquZHjWc4jYcP4SJW6XU1XH0mZBfBwdpHnP0N4AnCx9bpOsLpq+OTYv54fggjIqnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448359;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
	b=ryQZ4ajwKhrG3oC7PPjpCAvsztGpYjYQjnxBl3cJJ+KS8v0Q7QQ3i5RL51ybR5xCor3k
	 qWxwzm7C7+sdWiMaxqCnPPrzLMJoyS2HbnjlO2MnBoPsrci4h0k+DuH1CkKHOfRzD3DkD
	 LNxc44oetvd/Nm0Y7WbdVJCUtfRsM2AhCUUBHE0G+Db0NgUMFIm36VVAcCb1qvaeRKAVl
	 cU/FGbG0Y5G08QW320JPoVmvZgyBsae02Q1PqfxhmXIVOsC6JmnovsbBVuMtRF5lDJuZK
	 ay1mVb5Kz3v2c3j4bo24QNyC9mr9LMgoOi19ajr3iRr80MT5LTzD+Yjdr1or3fVxHvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a57uxpBZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E69606A32A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 15:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E69606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a57uxpBZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795448357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
	b=a57uxpBZDLHfrmCork62OYqreU7S3HBuK/1ZQ79lOPU+fnvQ54ohkGBTxEOedtHGRO6bh7
	nj+cg014VjsEwONjnpXIEOcDUB+b4pwxyjoaT2z6Zq+zXYBgHUVnBALWRgKSoqOghHAZSZ
	OQJu7eFXIGOJS3pJXoEYfDRgY5HHzXs=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-HwjdOAX2MtiISTk-xkZGXw-1; Mon, 23 Nov 2026 15:39:15 +0000
X-MC-Unique: HwjdOAX2MtiISTk-xkZGXw-1
X-Mimecast-MFC-AGG-ID: HwjdOAX2MtiISTk-xkZGXw_1795448354
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-677c4ca2265so5570430d50.2
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 07:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448354; x=1796053154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHGeO62t+HFnsrJIv0BtafcJl/YZUNb4ktd3CTqJklc=;
        b=dodTdzNJYaVTEv7zKF8i9onz9Vp7rPERLBV6S3EnH2RqBVtIbkQ8Nht6X3ioxrtrnb
         Vqp0+LStmoJajoLz69I0UNsCmDrNY/3iAgfbRdQvdrBqxWVb4+mX1h2Zkx0YzIBosOUI
         DKD3c8Sb9SdvbNzVJVN0B6wnEROJmcKoAlFrbCaw880fmIG3TxbWVtlyJ0VrEyFuZ9J6
         xoLJcdydfoBcWB9XhSku2rEaNK1tnC+4f3xDlPmoZjPc0D8o1YPdowYckXpJfQMwZgtb
         VM+u4KZ82UhvSw0QtB5Izc/v6KevNDfbwFbISfQV9CLV+u970YiX7nPC+j7EPzdvW1mM
         ckCw==
X-Forwarded-Encrypted: i=1; AL+hErH4Q/IsR2YdEWPcvU4nEns3D1psZJhcIFHbv8RirOfjXEWVpQWGLIEeqP8WrTyR5n0lD9kFV2xwYV8LSx9cPg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+CKKxIEe4aEqDhRPXXioue7qk2iJ99iyBD9RJTuszKQ2mHFM5j
	0f70qvhYMQrPnFNH5pliBZ2xm0tSbPOFhT4ca38eZH05jHaDRsAdseocIJ945277b1NqRdlbclX
	MFjmr+7KU2KcA6MpEcKbBpgNwf+tE70JY3mDqrz31dzGwPj5GEr6ZpI33dZ/UHcbKYoYuQhHA8N
	c/UIRahyDtaON1vlLNp9c3cwPunfgSZX0nZhu9HYbYh9E=
X-Gm-Gg: AZFdTZdauA7ifevD1wrE/ShYqOf4mclCMcr20oNl1FcMXySoiJTdUR9eU4fTaQyWokv
	2cmAM+dBqoeF+TvgD/fhXKRQptSCkV+lfibmnkrCpYtP11rQ/ymyW/iJ1WEc2KqNXeiIIvHWmmd
	RNiiEqrA7sckyMgavCOtROgQEiVHw5scyVvjBlb+CQtL1hlY7IW4KoULrCq6J0CWJ3NlfAluyA2
	G7A4ByInwgIW0AaPmMKFoPszjitqvJwqVJ7eq7eVpp1RV1yaYlxCxlAQSA=
X-Received: by 2002:a05:690e:1248:b0:67d:b995:a5c3 with SMTP id 956f58d0204a3-67df44b55admr4416368d50.70.1795448354420;
        Mon, 23 Nov 2026 07:39:14 -0800 (PST)
X-Received: by 2002:a05:690e:1248:b0:67d:b995:a5c3 with SMTP id
 956f58d0204a3-67df44b55admr4416353d50.70.1795448354006; Mon, 23 Nov 2026
 07:39:14 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-4-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-4-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 16:38:36 +0100
X-Gm-Features: Aa3M54o_X1llfaYVgrhNMk5-QtVPWRJiZP6Jl7gQZsBvDw4xjjtYogw0lgFiv-A
Message-ID: <CAJaqyWeKT3A2A5OHiB47j1P+e8BSoAbtJ9XaGLjU+kKOzOusMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Increase the maximum virtqueue size
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QA-TzDpl22XnblPcw_Mr9DMKaf_81-ibLtF-GbiY_vY_1795448354
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> mlx5_vdpa has always advertised a maximum virtqueue size of 256 through
> .get_vq_num_max(), while accepting any queue size in .set_vq_num(). The
> hardware handles larger rings just fine and users have been running with
> 1024-entry queues (e.g. QEMU's virtio-net rx_queue_size/tx_queue_size)
> since the driver was introduced.
>
> The commit in the fixes tag vhost-vdpa enforces the advertised maximum
> on VHOST_SET_VRING_NUM, so configuring a 1024-entry queue fails with
> -EINVAL.
>
> Advertise 1024 which is the max that qemu uses today. The device itself
> supports more but doesn't advertise it in any way.
>
> The Fixes tag points at the vhost-vdpa commit rather than at the driver
> because that is where the mismatch became user visible. It also keeps
> this change out of trees without the vhost enforcement, where virtio-vdpa
> would otherwise start creating 1024-entry rings instead of 256.
>
> Fixes: ccb1dc7c527f ("vhost/vdpa: reject VRING_NUM larger than device max=
")

Is it worth backporting this change? Nothing should break (or be
broken because of the 256 vq size), it sounds like an improvement to
me.

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Cc: stable@vger.kernel.org
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 7a39b0bbbee3..f1c5f72032a3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2965,7 +2965,7 @@ static void mlx5_vdpa_set_config_cb(struct vdpa_dev=
ice *vdev, struct vdpa_callba
>         ndev->config_cb =3D *cb;
>  }
>
> -#define MLX5_VDPA_MAX_VQ_ENTRIES 256
> +#define MLX5_VDPA_MAX_VQ_ENTRIES 1024
>  static u16 mlx5_vdpa_get_vq_num_max(struct vdpa_device *vdev)
>  {
>         return MLX5_VDPA_MAX_VQ_ENTRIES;
> --
> 2.54.0
>

