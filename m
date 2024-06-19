Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED3130E20
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794620; cv=none; b=Iq5RN5mEhfj0H2cXn2moHX6HO4kvrGVFe/XPAK8gToHT5q3pw0OH6edWOe3JHEabjAYu5+ff9K4J8Wpeb9RxOLw7edSYTRR8I2dEulZ3GMDL4Cl7XeePx26qaQ3U6qAviH/um2s6hmRdljzJ9sqdfpqeVBxmd1c8+x3JJgieJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794620; c=relaxed/simple;
	bh=4smyqk//gciZ2tfr+0FYpp38iYLlwv1szyuA5ggeH4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb2GRwSh+OIOmObddm10fQHnp859FlQfu8BmXjDY//oJujkhS+1QyPrGsj1fqR4j26ZV1waKheppiy9eChByasr+jmenHMsNMdhioOOFAjiRPyFa0R+7T01y+bn2Bd83qTb1dFj7QDVUxKkTvZ/6bFLWUwg+frQ5nDv7r8WnjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGmNlQfd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGmNlQfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZbrAKeWPPaFJmvloNszCVxus289ALpCaWtq/6RLHQ=;
	b=VGmNlQfdae3s1lXGKpNCfo6UR5Nf3II/2ttFvRyQE20xyRK+7tBPPLLF8HPqt+QjoC8OUQ
	wLqAd5s39apk14u81N7bwIFR3IJe1fGDuhGTtVcM5185F4kyI5bWL2Ggu4sJrT6H3OsbuI
	5bF+o3KCSKhkLWaAzANeVR48LQPprfg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-30nCqKgWPO-XW7c_LWoE2w-1; Wed, 19 Jun 2024 06:56:56 -0400
X-MC-Unique: 30nCqKgWPO-XW7c_LWoE2w-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-dff189c7e65so9702060276.1
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 03:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794615; x=1719399415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjZbrAKeWPPaFJmvloNszCVxus289ALpCaWtq/6RLHQ=;
        b=gszdOwwxWcLVKbNBPlqgzvI2H3rg1rDVyYxLQysMn6YSOVTMnaQ/pi26Oznu091sl8
         47IMc1C44PzK4WltFNHbrmJBmzIowg8gUv1rZU1Y5Cvhx0lCp0Uf4evDR+Xdqhrnu8gk
         Td3jCJCYAJXRBdvGTvdlIJRLj9vIPhxriHCDGgRLNE8X/Q2i/6Dm9nKL+RUrfYXHfQpe
         jkXcyjw7wJAQcwHc1JSBgeUQKktUuH9w9urNdr78RRfZhnqfyjpLbIwZLZaClVH33FxQ
         vOpGMHM7yR24ET7u/KFHZDeslWQLyoqJ0VmLtpT9X1ue0DNzxNIu6kJPHcw2EJpqxS96
         TdMA==
X-Forwarded-Encrypted: i=1; AJvYcCWg0D7vyJt1Qzd3TtKBRpx/ZdmG1ZpOTOXLanEQvOr/Ehg4I9h2W0HzbEHnubghvb9q1OFCqkJ5w6H9lKNvOTtmdi0oJeCOO0Nwac3ufxg=
X-Gm-Message-State: AOJu0YxXHJcDv2e+S45iogYYl1IbjACi3HfvCFxZaQQqrsQwwoIm3ciG
	nFpzjc2z/5Cf8E0Y5ce25jDdxMnV6Ynk4hyLg9OqIK3OURo3vJXoujmMIowfCSFKBAyDdU6Lh4F
	Cxr5TM1ANf2sFZYI/vcigadHIBXd9t8/mCi99Ly6AUTLN9MmiGMZFBidUAQIjUmzrsnhkYNsyuT
	p+W6SFrvYIe8FG8FayPLY8cI6TIlO1G5MkEWb/yPc=
X-Received: by 2002:a05:6902:18c8:b0:dff:2f78:a5e2 with SMTP id 3f1490d57ef6-e02be20b9fbmr3077308276.48.1718794615597;
        Wed, 19 Jun 2024 03:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBUNHSRsqjjtkqh3anCM1rUWgihsBSlpbQwcOBllw4ugAGeY3IlZgXoYdaWC9Vjxq0GasRjZJb7rLeAgR/w+0=
X-Received: by 2002:a05:6902:18c8:b0:dff:2f78:a5e2 with SMTP id
 3f1490d57ef6-e02be20b9fbmr3077292276.48.1718794615243; Wed, 19 Jun 2024
 03:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-4-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-4-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:56:19 +0200
Message-ID: <CAJaqyWe_ShF4HkhxsdHjgaBAMwCvw10_t9Wk_-A0QyPT+zFEbQ@mail.gmail.com>
Subject: Re: [PATCH vhost 04/23] vdpa/mlx5: Drop redundant check in teardown_virtqueues()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The check is done inside teardown_vq().
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index b4d9ef4f66c8..96782b34e2b2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2559,16 +2559,10 @@ static int setup_virtqueues(struct mlx5_vdpa_dev =
*mvdev)
>
>  static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
>  {
> -       struct mlx5_vdpa_virtqueue *mvq;
>         int i;
>
> -       for (i =3D ndev->mvdev.max_vqs - 1; i >=3D 0; i--) {
> -               mvq =3D &ndev->vqs[i];
> -               if (!mvq->initialized)
> -                       continue;
> -
> -               teardown_vq(ndev, mvq);
> -       }
> +       for (i =3D ndev->mvdev.max_vqs - 1; i >=3D 0; i--)
> +               teardown_vq(ndev, &ndev->vqs[i]);
>  }
>
>  static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
>
> --
> 2.45.1
>

