Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CD15FD13
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634541; cv=none; b=gRWgBwQflWLlFaXwBgWz6aygvyzh/pVWLoqi5DXN4qng8aFA9w8/eYdLEZs3yHpMKO5s0PIFLCd2RBl/xsdW4OBTeK8PAjSJrlZGgUEbv+gnZSH/MItJVz7Mw5oRlzuKGmaUeCY9AnnIHfTzOfLIcSk3xGfi3Iw8KKfm88Jjw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634541; c=relaxed/simple;
	bh=f+fV8aZHLjNJDmqj0f9UlS/89ETfJ+867t5eBxYZL68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae0P9XphWvl2t63BZ9QQwElyt8LIYBugO6RPzwDD5+WvxbezVWFaihP81tQy7ucX5z6kxlacOUZ2UGR6lCrwlYXaMdPLoOHpR+iovVthyZnLdZZrTdKKqeQnCXcpXFZnFC0/FO6PhWxYT6+Y5tlWLnO7ckJJg9ce/BSMJlBMmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gE7qVl0j; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gE7qVl0j"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4036280E65
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lu9SLCCAYIy3 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 07:48:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7940F80E62
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7940F80E62
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gE7qVl0j
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7940F80E62
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721634538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9Wijau/U3n0K7Jlrn8r30G3DxAJjcM6+ifaqnBRTZQ=;
	b=gE7qVl0j0tirf63JdaCAimgciov1V9jp4LZWXn+IEQO8cttqw4rXvyq7YjG8kuufT59Nvy
	nTbEYaFWt4tydLrR4CvCeqAGVyFGCr3NOSm4rHOSeIFz4L9FnIg02wlIKnCuMAvcE89Xui
	KEeB/IlX3PVAAZTVl8/OEkTj+nmzqTs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-1L6wwjtaOF-w02r5tCoEuw-1; Mon, 22 Jul 2024 03:48:57 -0400
X-MC-Unique: 1L6wwjtaOF-w02r5tCoEuw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cd72aa5328so314457a91.2
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 00:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634536; x=1722239336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9Wijau/U3n0K7Jlrn8r30G3DxAJjcM6+ifaqnBRTZQ=;
        b=AuBh7RG/xaJN1W3j83PpEdpM/cIninoL0r/HEVQxn6D+6YhJCBPULYcjndiFn2ICJG
         AGmeJi67ZttTGvq3RYo2h46e5QHe0zLbivOZFhG2quXBE3Nxd8laUJhKjRA9pAIgAeOE
         csdSugTMFKehstF13su2m0kxKI0tG99uY502C84xk9zHG/iYMukmqhmiYn/qn0H3Cimw
         QnojOjWC56dB8RWR0mVcd3itXxVbEjIQ0phIrjSPOZhtDVGze6NmkNZNPFOQyoxpebY9
         UGQXXoy+MOzlAGyOWIr0rKxoZG31qf9dFm+Ub2g8hppB/YGH5iklgNr8yK10QdDD/r7h
         RJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCURaQcGls8setodPG7OHo2dNqr5yf9Ezn+H6W4VyDgFqZ9mATScrTi7XY5w1qilKzJIa59PwYIHFMRJbdpa8RUnyderr8jlXKvkrG1ZgwvSrGczPCo7y5xmyw==
X-Gm-Message-State: AOJu0Yxt6lgnEICfVWwiFEbc7MYMZE7ReYk19uXC5M7Hkvx//bQB3a4k
	LoTumXv5i8b6TEXohpYXyIwchlxyOpXt1pAhhaGmb4A16C4UgCvbrMAwj4SUdVF/+0DmaAkxf+0
	p1Np9mszEawB1stFNII8HLZcR+a41PEWFIsLrT89qQGw+gFyuvVwpOfVjHFzfyjnzCWkLFJeJEt
	fDrci7Sq8l9akDeGD5Y+HtiISZcFSlrBN0026fNmSqpgc8Hf2G3KzZPA==
X-Received: by 2002:a17:90b:1997:b0:2c9:8020:1b51 with SMTP id 98e67ed59e1d1-2cd273f776dmr2791080a91.3.1721634535898;
        Mon, 22 Jul 2024 00:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXRzsCMJv/6tknO7a6u+ZBcL+U7UQuyw2cdT0yYEkm2DsQ1rWAMN0KuDM6A4GO1xcfnMyjBEi8/MfpUnx4Ou0=
X-Received: by 2002:a17:90b:1997:b0:2c9:8020:1b51 with SMTP id
 98e67ed59e1d1-2cd273f776dmr2791063a91.3.1721634535409; Mon, 22 Jul 2024
 00:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:48:44 +0800
Message-ID: <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ecfc16151d61..415b527a9c72 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
>         destroy_workqueue(wq);
>         mgtdev->ndev =3D NULL;
>  }
> +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> +                             struct vdpa_device *dev,
> +                             const struct vdpa_dev_set_config *add_confi=
g)
> +{
> +       struct mlx5_vdpa_dev *mvdev;
> +       struct mlx5_vdpa_net *ndev;
> +       struct mlx5_core_dev *mdev;
> +       struct virtio_net_config *config;
> +       struct mlx5_core_dev *pfmdev;
> +       int err =3D -EOPNOTSUPP;
> +
> +       mvdev =3D to_mvdev(dev);
> +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       mdev =3D mvdev->mdev;
> +       config =3D &ndev->config;
> +
> +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> +               if (!err)
> +                       memcpy(config->mac, add_config->net.mac, ETH_ALEN=
);
> +       }
> +       return err;

Similar to net simulator, how could be serialize the modification to
mac address:

1) from vdpa tool
2) via control virtqueue

Thanks

> +}
>
>  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
>         .dev_add =3D mlx5_vdpa_dev_add,
>         .dev_del =3D mlx5_vdpa_dev_del,
> +       .dev_set_attr =3D mlx5_vdpa_set_attr,
>  };
>
>  static struct virtio_device_id id_table[] =3D {
> --
> 2.45.0
>

