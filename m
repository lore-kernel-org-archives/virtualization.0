Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF903185E60
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023811; cv=none; b=CQ75FJG0q6pvA8xG/PYdxBw5M9ANrkpbjc97KVGAGil36bbNN3ngxQz1EA0mqM4WKenf+GS9m1Qi9XZ8zJQCfzfiT4cugV/xCLea6leCJiTSMOyb8VWjXQI8QBbAGhr2SuMgGBaymVrV16MmGTFE3D5vvk2l5hzIGvox8j7xQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023811; c=relaxed/simple;
	bh=yAl9WkIF75Z5792jsKO6kzvCg4MDRUb7mflCnX2qKpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJljG8Ag9SBig04dQRw3Jhk5Zj1c8XTAkaSF4ntF/jpFSsx7BaJJVEw4sZuoU0Fo8RJvJzyR3n/aP2yC4NAOCqz7fj47LCxdn4zkUe6b+P05BOgRDpCwG7W92OdYtxcSOW0o8D8Z9cGnqAS+rznONgJaxFyjAwCJowpCxFvTjlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBxtOUuC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBxtOUuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n91rt4myNGjgsOAzA53ROWPaLTAmQTcNbTctluHszT0=;
	b=SBxtOUuCG3UlM9L0/b3N7Zp77cLVVF/US/TUsTxSeC4nGfSDpFDOGtesjWotgxUshvV+gP
	EIwjVhCiokLUL+H7l1ohcTqZFqrUGNCQ6PE3zQg6TsVzHg1IGVSj/8Sr0ZHZtpTQ4ylrEO
	kgA8yuEyI+RtcviyB5wlmgkJquZH3Mk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-YWK4UADOMeaTm7t3WEVUPw-1; Wed, 03 Jul 2024 12:23:27 -0400
X-MC-Unique: YWK4UADOMeaTm7t3WEVUPw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58c98ce7d00so1068179a12.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 09:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023806; x=1720628606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n91rt4myNGjgsOAzA53ROWPaLTAmQTcNbTctluHszT0=;
        b=S37w7bHrUYcB+yKJ4z+sMRnhbxc/IVGM5uBqxs4jW4eJd9U/5LuzjYCTyEwvEIVvZ/
         p5xVsctxWFA83pzKwNepsBjOyuGMlhL++JOlHqFmVkZ6/bq62BYY7gXDIHfpFxtgVZpb
         RxpJdvsrYf1YQmLCrOw/zCZge7VJkAAQv5v9/0YLo7UKcLvfNxPmYmwimf9SPQR98xnX
         Tx6TIWz3KipmAXW5sSGfM1hXSUxZmTI0y9gt1WCpoktPN7qvkKIwYgFudg8IKRnYLvmg
         WdeTOhrVJTlGxgWLrN09LNZ4vnLpyOUMJlJbMUKpmZk49MtEsJmtqm2ym84MIiwroGDX
         KDzw==
X-Forwarded-Encrypted: i=1; AJvYcCUCcdtGmA9URSNsjYRsfgCjaLNaHVedSCL0eUtc/98/iA4iWJC5lY6qxKs4gQBswDarrZTFqBad4TjuBKO3RHu0V9NliqniME7DIiRxxkQ=
X-Gm-Message-State: AOJu0YyXVtb0jKNdQ01xdxmoxurfJfYHUw2FFt92wxGAZxVTHa/0PTXx
	h0N8+nukKou0NhQfa6jI01ySPmdBxVyQ5ArV6EA6L/W/RnLySr4zki+FH52qYHN4vGFkKsbd5aO
	D8Ab6rpKY1jNJx9TBQdsbzD0Tu/NTE7TuDkuLfCzM/r89JYAKY8GHsh4K7hF/GqaclPoJPPfZCJ
	oaCB719jzYhe8fDWdC1Os/Dut1bPvi4p5fwrgWnWE=
X-Received: by 2002:a05:6402:1cc1:b0:57c:6188:875a with SMTP id 4fb4d7f45d1cf-587a0637437mr7847853a12.26.1720023806606;
        Wed, 03 Jul 2024 09:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDKcKhOUx+NmAMpJL8tgtpN3L8p4uaUWiZMnuqg99iVFuWIDVp5qSLrtsQb/GpER4ZLfVxi176Yy0Dko+cScU=
X-Received: by 2002:a05:6402:1cc1:b0:57c:6188:875a with SMTP id
 4fb4d7f45d1cf-587a0637437mr7847840a12.26.1720023806248; Wed, 03 Jul 2024
 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:22:47 +0200
Message-ID: <CAJaqyWccNsTo16CzUmSwNLFw2CTinrQ47YQ2JjRndyHLeRVFNg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 19/24] vdpa/mlx5: Forward error in suspend/resume device
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Start using the suspend/resume_vq() error return codes previously added.
>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e65d488f7a08..ce1f6a1f36cd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3436,22 +3436,25 @@ static int mlx5_vdpa_suspend(struct vdpa_device *=
vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       int err;
>
>         mlx5_vdpa_info(mvdev, "suspending device\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       suspend_vqs(ndev);
> +       err =3D suspend_vqs(ndev);
>         mlx5_vdpa_cvq_suspend(mvdev);
>         mvdev->suspended =3D true;
>         up_write(&ndev->reslock);
> -       return 0;
> +
> +       return err;
>  }
>
>  static int mlx5_vdpa_resume(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev;
> +       int err;
>
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>
> @@ -3459,10 +3462,11 @@ static int mlx5_vdpa_resume(struct vdpa_device *v=
dev)
>
>         down_write(&ndev->reslock);
>         mvdev->suspended =3D false;
> -       resume_vqs(ndev);
> +       err =3D resume_vqs(ndev);
>         register_link_notifier(ndev);
>         up_write(&ndev->reslock);
> -       return 0;
> +
> +       return err;
>  }
>
>  static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
>
> --
> 2.45.1
>

