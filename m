Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108681F932
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422207; cv=none; b=XBwgNQ/VHVGXsF1vvxOAQhvPpfdQ+vYBzMCIeB+RyTTP4xTN+/JJUpE2tm4sHCw9lMbFrDXMRcO8VZhdSb8FkyYUKh/xk4afaw5Sq15nG3I9o/ALyWUh5eLpZ5RG5LZYQOePswW3jiZTFFgKkELUh2sgoJdy9oNlmF5zraQPXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422207; c=relaxed/simple;
	bh=4b92oNgXX3IO0nNjCs2UGVAK+tN4/8tvmYGO2+9x2s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzgPlq1vWrgpfGDns0jK6YyQCKC+z4rfsr4ZqkQocYi9sMMPnVTZCjOqJ1moV6bcIj0CMLwBYDdm5wooQzFAg/SWvaOGPQ6VhV5VH3E6xD5JAitqM3DWNtCgwWTaB02SBAGwSoYJbAUWohHTleb1JHEnq9HGkTUmYqXRKFFxfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZbvx4zb; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZbvx4zb"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABD5E40459
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yANtbqz2E15s for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 07:03:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A3A6C40190
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3A6C40190
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SZbvx4zb
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3A6C40190
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xafKe1ETPl2hs7RC1pIf/UXEnXlhBd+TTx+fx4z1CYs=;
	b=SZbvx4zbg4a3Te4LDKfRES3EZGqGKLCNdv1FxzAGV9L/nyznrmQmOO/YumD/j4mB3+zPk8
	kl+LZjGmCvuQMKOi2BSVgz1jfTuzB693Da7FQT+g/wFqKCGLwLcMEoeisfZyL0rw4Hls6G
	QBIKjht1QaBz4BkzGZjXZxVhbKnl3+w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-RVyTeiCYNMKq1lCax3_nEw-1; Mon, 08 Jul 2024 03:03:19 -0400
X-MC-Unique: RVyTeiCYNMKq1lCax3_nEw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c95f737113so3758627a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jul 2024 00:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422199; x=1721026999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xafKe1ETPl2hs7RC1pIf/UXEnXlhBd+TTx+fx4z1CYs=;
        b=iH21ob4znvcgDtr59vaZfl9JMY7ymX44T2yvoAvmgKhttQ7ggvoX1buYQnFZ9xprMU
         DhORVEydcWQAUvJ6OsWrIsEdJMNimKbifvIr6lbeMhCFnOBi3qlBy375t7BUMCh+Q1yk
         raHWTQfOyuWjKr7+nnrgd4YZQ9im1Ga+gPyqPwlqMZ/ZDg7y+dUSiigPFLhEpABNVMk4
         hIV/PFARI3uGhpEeO2bZSbn2Qu1XZJ1ieWsGf8XcTCC41bi5bWmH7eWghAhuxQrhkSpA
         m0XtaZrOJQh4OmNR5ABnPY7UL9Vap3M2fxFLWk5xuK9FfuNPJ6jfv8a+2gV+n8WLuisM
         gHqw==
X-Forwarded-Encrypted: i=1; AJvYcCUir6OjqShF2xSbbPeeylUw/EXJ2hrByhDvshjhx+XA975osJ6IGEpNd2AXFHYztJ9kXaZmrt3aU7iGOgLl2kxK1DFD+F/OuZ7R5nI/yBYgp+Hs795My7RYnA==
X-Gm-Message-State: AOJu0YzWEeWAq7f4ny0/xFvHLhng+EMKw4i+aNBioqh/3gQ/myznWr2F
	vtXPY/YERykx6uKGSORx0HMsPc1r/7hdPTU5iBnbQq97VjXzwmNvH1CWn6yi2s1HYtVOg6aJUf7
	xy6aDb5F3qrqSZUjDmcgMuPeMnS3MYOBkWtp7ADteOkQ45nxFvk6xXuJ9pElt/bNZZk4iWm9Z2z
	94M6TvCUbtkYPmo3ccRF9RwPdu92cbrqkYDdDS6LAmEc3Uua0+6u43zQ==
X-Received: by 2002:a17:90a:c24d:b0:2c9:5a8b:ff7e with SMTP id 98e67ed59e1d1-2c99c5596e5mr8326629a91.25.1720422198729;
        Mon, 08 Jul 2024 00:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK2xxHaGnbVCuiq17bw6Hrfo1LzM8sgBjdKSXFir13Qe5R6l6dUaQH4ufWN/M6OQHtNf5RO7L457uGVag88zo=
X-Received: by 2002:a17:90a:c24d:b0:2c9:5a8b:ff7e with SMTP id
 98e67ed59e1d1-2c99c5596e5mr8326615a91.25.1720422198391; Mon, 08 Jul 2024
 00:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708065549.89422-1-lulu@redhat.com>
In-Reply-To: <20240708065549.89422-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:03:07 +0800
Message-ID: <CACGkMEtOP_Hz=SO+r5WQfWow3Pb-Sz552xnt0BqTgyGSuvJz_A@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:56=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device

Great.

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I guess this should be part of the series "vdpa: support set mac
address from vdpa tool" ?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 26ba7da6b410..f78701386690 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
>         destroy_workqueue(wq);
>         mgtdev->ndev =3D NULL;
>  }
> +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> +                                 struct vdpa_device *dev,
> +                                 const struct vdpa_dev_set_config *add_c=
onfig)
> +{
> +       struct mlx5_vdpa_dev *mvdev =3D to_mvdev(dev);
> +       struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_core_dev *mdev =3D mvdev->mdev;
> +       struct virtio_net_config *config =3D &ndev->config;
> +       int err;
> +       struct mlx5_core_dev *pfmdev;
> +
> +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               if (!is_zero_ether_addr(add_config->net.mac)) {
> +                       memcpy(config->mac, add_config->net.mac, ETH_ALEN=
);
> +                       pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev)=
);
> +                       err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> +                       if (err)
> +                               return -1;
> +               }
> +       }
> +       return 0;
> +}
>
>  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
>         .dev_add =3D mlx5_vdpa_dev_add,
>         .dev_del =3D mlx5_vdpa_dev_del,
> +       .dev_set_attr =3D mlx5_vdpa_set_attr_mac,

Let's rename this as we will add the support for mtu as well or not?

Thanks

>  };
>
>  static struct virtio_device_id id_table[] =3D {
> --
> 2.45.0
>

