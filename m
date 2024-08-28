Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9C17799F
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849380; cv=none; b=pDRcCavIG3WZ6GeoZ3i3DaPlR+jhotyZXq8PMKM8NGUE0My8mF0dVZfvfLMeftX+c2gA+6uOupN6uDwi0QtqooL/rP0DDXEtjhMRpC62pQYgNwyGQ8hpw3tVXnvqgTUQzn+oAP4jCkjXgboRXzy2FqsEm/ivbBO2JSQerylUBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849380; c=relaxed/simple;
	bh=OmG9UKSRalPMPedgGvQtdSaHxT80qp6qKysD1sivNj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+GbbrszDfUmKPtmbxt/m5mr03+A5WvH/uok7nePBmgPG8/4SDDJJvwagobgw/lsHRBfxhHc8tWNDMf23W3NplDNIXF9qA2Sf5h2lHVQ4ua1+tEJJ8gttwGTvQb+yT6xrvTTe5ySC3ytiV75GrewVHkEuqgkPLR5w3uTPnp4fPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUylkC5S; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUylkC5S"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED95E60A94
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33Z4OJ0S-OqW for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Aug 2024 12:49:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 31EA460A5A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31EA460A5A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JUylkC5S
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31EA460A5A
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724849376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mG84mpdNAxgJt+MjSaUaK5oPD2+XnDBYY0BR3c+Z6I0=;
	b=JUylkC5SsZW2PaMrEwxIo1RAldQtENaRl+oJ2YTXvBViFAQL+lU7BRbKfPQBS0Vjj/PUrW
	zGwdYJ7JU1qHVZC9SiTu1UpTV5/GhzKYaca2ClLmnqLpa9y1KpoEKnQFXUxiYVoQ+85rne
	BpE0u+fILhj+frkXvV7OVYe+G9mEMUY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-VJ0jGoFuOh-vvauXVTgNqQ-1; Wed, 28 Aug 2024 08:49:35 -0400
X-MC-Unique: VJ0jGoFuOh-vvauXVTgNqQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6cf78470a56so51639727b3.3
        for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 05:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724849375; x=1725454175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG84mpdNAxgJt+MjSaUaK5oPD2+XnDBYY0BR3c+Z6I0=;
        b=ro6Zf0PDy2WPEXbjZnig0wf6Wz1zQGRla5moZyBSOTtL00uqjQ3OnLy7CINugxX9vU
         1LvGMxu9Owr3OJzPt0tiX/f2+SOvQiG68P0AVMRXIX2GcSgDYN96/QXZ4Og3Rio2dZta
         TiE/zjxFuFN1L+9lLEaRioyI+HWRuwan0sg7xw5qX6tun4H9c4iCe+YNWB2zzYVql8NU
         qJi/T+oShyx6z8AomP03V20MRsJrTy3PxVoJ05UZg4zyzrqseUB9K/o1/Xxcaa4vTARR
         v8jlM2G6aWt0lRzSzWU7tvDJ+gR1rNhlnITS4/qZFzE54/zE+l1aol1j9Xy9MlO6Wi7L
         MvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb/GQ6SDllqeCJXjufH1q4xz3ejDe6b+Bb5Adtv0sffSnPFwJv9HXSlbibUWvW0W/XZc0Rb/VenpA+cQyXWQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxnHtyv4nVzWfDNnTOv1cPKrexsWVidUz8BVhnlGflB1AwRxMEm
	jBrNbPfaNQNT4kGs4wwT8HTXorILeqkwubdvWHsK6i2eD5kkDuuASClKr2mUGXQB1sRLz4GIJ3y
	KcbP74D7fZmAkTb71MjzzORM1Bh0CF79s1/XwizKmwGKyhvaSszNV8lb7J7fk5KOpvni6um2huc
	rg15LZy5cG4fiZjieUIoSJdkt/Z9cbLxRG3qfCwEdl9FbgEDN0+jRubw==
X-Received: by 2002:a05:690c:2c8f:b0:64a:956b:c063 with SMTP id 00721157ae682-6c629065714mr152681447b3.39.1724849375217;
        Wed, 28 Aug 2024 05:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd7nnhKwMBHGzXZsGM1fq6Gzr4+LPrJ+cQ8cp3h+LjdAk8VlTS8UTQRv1TB09r6RylwmJ7164mFinpLkrgGxQ=
X-Received: by 2002:a05:690c:2c8f:b0:64a:956b:c063 with SMTP id
 00721157ae682-6c629065714mr152681307b3.39.1724849374930; Wed, 28 Aug 2024
 05:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <20240816090159.1967650-10-dtatulea@nvidia.com>
In-Reply-To: <20240816090159.1967650-10-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 28 Aug 2024 14:48:59 +0200
Message-ID: <CAJaqyWcnJwfwyGKqx62OdSXrVH4gA701E-j5soChG0ZfTUsi9Q@mail.gmail.com>
Subject: Re: [PATCH vhost v2 09/10] vdpa/mlx5: Small improvement for change_num_qps()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Tariq Toukan <tariqt@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:03=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> change_num_qps() has a lot of multiplications by 2 to convert
> the number of VQ pairs to number of VQs. This patch simplifies
> the code by doing the VQP -> VQ count conversion at the beginning
> in a variable.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 65063c507130..d1a01c229110 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2219,16 +2219,17 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct=
 mlx5_vdpa_dev *mvdev, u8 cmd)
>  static int change_num_qps(struct mlx5_vdpa_dev *mvdev, int newqps)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> -       int cur_qps =3D ndev->cur_num_vqs / 2;
> +       int cur_vqs =3D ndev->cur_num_vqs;
> +       int new_vqs =3D newqps * 2;
>         int err;
>         int i;
>
> -       if (cur_qps > newqps) {
> -               err =3D modify_rqt(ndev, 2 * newqps);
> +       if (cur_vqs > new_vqs) {
> +               err =3D modify_rqt(ndev, new_vqs);
>                 if (err)
>                         return err;
>
> -               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)=
 {
> +               for (i =3D cur_vqs - 1; i >=3D new_vqs; i--) {
>                         struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
>
>                         if (is_resumable(ndev))
> @@ -2237,27 +2238,27 @@ static int change_num_qps(struct mlx5_vdpa_dev *m=
vdev, int newqps)
>                                 teardown_vq(ndev, mvq);
>                 }
>
> -               ndev->cur_num_vqs =3D 2 * newqps;
> +               ndev->cur_num_vqs =3D new_vqs;
>         } else {
> -               ndev->cur_num_vqs =3D 2 * newqps;
> -               for (i =3D cur_qps * 2; i < 2 * newqps; i++) {
> +               ndev->cur_num_vqs =3D new_vqs;
> +               for (i =3D cur_vqs; i < new_vqs; i++) {
>                         struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
>
>                         err =3D mvq->initialized ? resume_vq(ndev, mvq) :=
 setup_vq(ndev, mvq, true);
>                         if (err)
>                                 goto clean_added;
>                 }
> -               err =3D modify_rqt(ndev, 2 * newqps);
> +               err =3D modify_rqt(ndev, new_vqs);
>                 if (err)
>                         goto clean_added;
>         }
>         return 0;
>
>  clean_added:
> -       for (--i; i >=3D 2 * cur_qps; --i)
> +       for (--i; i >=3D cur_vqs; --i)
>                 teardown_vq(ndev, &ndev->vqs[i]);
>
> -       ndev->cur_num_vqs =3D 2 * cur_qps;
> +       ndev->cur_num_vqs =3D cur_vqs;
>
>         return err;
>  }
> --
> 2.45.1
>

