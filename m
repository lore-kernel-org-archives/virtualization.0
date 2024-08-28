Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A13BBEF
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809869; cv=none; b=NStJOTIKTI+PKfSyVQt0zO8zLP7pFTQINzfMN4NeqCMjgwascH+woMTCj1S7ZZ503weo0AEhMaXwQLI7bwbUZl8yK+AP1Qt4hOSSbbY2xMuaaGNHhhXA5W2J7W+bsZsabZ/cQ0Oi4PGLrAPLt7MqX3bODFomDQnTqvr+VoGAmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809869; c=relaxed/simple;
	bh=dlPiZE9UsVdiSzOssXECUvjgzOPBHS+oMoLqV4guW5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phMAYCdkFQFeyiW/6HwVuwD6kcb5lnSO3PVxGyko7dfJFJiU6tSPx+Lot498Xc8OulUQ+lU2BZtJAFAtf1aTa3cHfRruq71riet4fGDCzOF1twVvZmuSqfe1mPRH2bwyN6BLoIqF/cEA2VoxIhD8G897Kn2IgmS6b+KGil/oYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKJ+eeMV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKJ+eeMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724809865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SADuPLHhKHraivDPODLiG4GLxA55cT4kHD3QSt+2lnc=;
	b=AKJ+eeMVI8t8P6FcRHAxQeU0yi7sDaFaqdIduNSJnFlgwzqd0bOBIpkQ7be4RGoSiG0gd1
	v+7d0XZJjRF3Sr1KC3ky76yWRR3wc9Qc85YYgWFvX45L/TCJRWiTCrPJ91ydw8R9jtUTMe
	slVzWbdRXSLfCfqPSaKFRsU3nlZUPxc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Ph5ia1rkOnaKz1U38aOBwA-1; Tue, 27 Aug 2024 21:51:04 -0400
X-MC-Unique: Ph5ia1rkOnaKz1U38aOBwA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71434a51126so5956355b3a.0
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 18:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724809863; x=1725414663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SADuPLHhKHraivDPODLiG4GLxA55cT4kHD3QSt+2lnc=;
        b=QpodVjtsFyUprtNG/ZaRHIcScIciDN5bETenfpTDXYxoQijBwzCVIUZ7DyvxO09Rsh
         mztcjHqdZn16UpcAyaKrrRG9bK1KORGOkP2cSUd31LfvFIOaCE3nYuJz68MLjSjXBKJT
         iY9sZ9lWMTTczL9awn/uRIH1N55i6Bh/BnEGIrYS/Fuo1a9Qiye8yKg80stAacA8gGHU
         iDJQcV3KIRlHx8KY5id72mcOZp1TkhjA7/ZngrPb7A0JNTHwvRz3QX413UTmvvkZ8i35
         8zD3R+3Um2xFmGn2gDMY/Zzp57W+GdIRXQY2OZg+kJWW0xSuHZ01gBUNa+OEXEkrCsNX
         JCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9lz9AxNPZlWz6Lu2qntcpjY34i9DVn6Qnl1ZkFUOoXVBpqTF/gv7fFFh72HBG2xFZTB0B3phBl87Z6hpGLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWh1p9V23rlqCRagmTmrFEA5VbdKTFIeElS7pokP9KY90O+4yS
	6qUSg703x6E/ZlhH9saKeLJ49splxLXyHGUkg1By+Uk5VKQ2NuhcMoI8WhoSlY635D6cpg2L5t5
	1eUdNW99KQ0jGJ6cbJDp+HYO71SQrF/lPwdHK427bYGhxNra7LlJm6cBKsaj21OEWTFT3X7M2q1
	3WuzbZckbtUrLGrt8RhGtvCVY0fhdhTAndTjPp4DM=
X-Received: by 2002:a05:6a21:390:b0:1c2:8949:5bb3 with SMTP id adf61e73a8af0-1cc8b5de03cmr15587187637.42.1724809863058;
        Tue, 27 Aug 2024 18:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTGYaHxDUCFoz3sVyJEz0o0EgiqCq9q9BiHhHhGXBcCKahsfo/m5FcPKzHJP0PMipLm1Ah8Whvbr+TsP77s/Q=
X-Received: by 2002:a05:6a21:390:b0:1c2:8949:5bb3 with SMTP id
 adf61e73a8af0-1cc8b5de03cmr15587164637.42.1724809862462; Tue, 27 Aug 2024
 18:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
In-Reply-To: <20240827160256.2446626-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Aug 2024 09:50:50 +0800
Message-ID: <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, si-wei.liu@oracle.com, 
	Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> When the vdpa device is configured without a specific MAC
> address, the vport MAC address is used. However, this
> address can be 0 which prevents the driver from properly
> configuring the MPFS and breaks steering.
>
> The solution is to simply generate a random MAC address
> when no MAC is set on the nic vport.
>
> Now it's possible to create a vdpa device without a
> MAC address and run qemu with this device without needing
> to configure an explicit MAC address.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(Adding Cindy for double checking if it has any side effect on Qemu side)

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index fa78e8288ebb..1c26139d02fe 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                 err =3D mlx5_query_nic_vport_mac_address(mdev, 0, 0, conf=
ig->mac);
>                 if (err)
>                         goto err_alloc;
> +
> +               if (is_zero_ether_addr(config->mac))
> +                       eth_random_addr(config->mac);
>         }
>
>         if (!is_zero_ether_addr(config->mac)) {
> --
> 2.45.1
>

