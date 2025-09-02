Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096C2F90F9
	for <virtualization@lists.linux.dev>; Tue,  2 Sep 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814212; cv=none; b=tplafktxZjGsdsrJzKGZ/Tp60dqewkXmD+0d15dcZytxtBME+Vut0R727LAN9psmE/Xg9fOeEEl/rrouwpOikeLzPHqCjKwiqEkpyYenzwC32yQkWS9bOYOxmtOCHIQy8GEdc+1Af1saqDC55mqx/ndVxxuyh/wZlF7DlmsJ8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814212; c=relaxed/simple;
	bh=b1YlHgbmyU5wicKUR7DIncYAaRMKAJOWSkzUNdu5Jmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JChp6mhTtwYLVwBs/umQt+FvGyv8uBirz6lJJhA4Pb/FRSSe7RiZ+DLoHPzwREIWadNfSXWiMK+B2S306Feiju34dTr4QzQ82CiiSN0UvKvbNBTue9/WbE5TOVSSDSQf0IC9dAnRc9/RrzWm/KjkCt2XzWUMJVv3p18YEIvHWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkJdaPOm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkJdaPOm"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so9555420a12.3
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756814209; x=1757419009; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbUyaSyIRtchuH7yFzxitK+3O6e452pD2yav2xjr5N0=;
        b=dkJdaPOmeGI8A6/5J2hD1AiexzLjlIsChCQxf8yamMTbbDenZRiqTbkxFx04yhklOp
         aW3cBjp0Pvs0fN8h7yP3BCngZ1+6Y5i4QMY54xHHS/gnJvr4OlqZTYr6Fp70UwM/VImR
         Ss6vjI2ZzKnNb5yhQjn9tBOzeA0N8KHG+m8CUViZhvxd6JkvITvgu2NND1UrMIihglgm
         vCRykFzq524kCDp8Ed0iVcHHAkUV9qnhkWb/boufa0DxbR7RkB+PUL6eo6P66o46CLZ7
         7f0v7PHQqTGwFLDBdrK5fNbTOmQCAo+0Im8jlZ3nJXQ8QGBzgCe4Djxd6KRornrPPy4C
         kh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814209; x=1757419009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbUyaSyIRtchuH7yFzxitK+3O6e452pD2yav2xjr5N0=;
        b=PSKUBrYAGoji3eYwSkCaKOZwboI7BbtIZHtod5Hkr0Nxskrq5ZVeIRJav5EsMvZDVZ
         brlS4Uq3HX2nSRuFAeESf8TTEse942RHLw/RfBng7QZ5WJr3tdRnXdVKBi6/v3TUl2n3
         RojRGowJbfQALyIa+xHy2VK9hoJGfxkmhgiOtZUQNy3iuM0tt434f9/SxueV/19B1qJu
         iBDhulKJMvgevcB6hqDbLdO3rU2tyd/K5VpW9VVeim2TgdMGM3BhZI/21JUAmPDxVBed
         53egGvrK51TcCWZ1NKLSaOrJfYjlxUipdbVX05X4Z0MN7NznC9SrOqiulwBuGWSgKkKd
         ZmNg==
X-Forwarded-Encrypted: i=1; AJvYcCV477nY0p3jJht4/216SmDm2spsHFVVyHx800Af0o5mV+1VLazbxAN0py7CAahiodsjM/xFuwOHbYeHAicBCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyArOQId+vrlHJEcmU75rHBg3QnfedwWub6+Yc3+nVY+47GlAH+
	j0f3NYlrDeVt4uXfdjk4oSboWOkSBk7fLtzrlhV2PX9c2kRYUtIwLRdzGeN6a5qNo+Bulr1hceZ
	Ja32bK7Wwy+hChZodqJS248c8AXqkl4w=
X-Gm-Gg: ASbGncs6pd+LjAnH1JW5ysjqiqUqSjlfGKf76JUpc/UgrQz88BuUEIrrezeQB4rcURO
	zc20pOnodPLPtlJVInJ2fnYSdPBGMPwNVSU7W2Z7+4FR8WQXJX2sHQv6nzoVs1e0TYxVnuqKwWY
	DG5BPfbk7jZZR8xY4FFbS6IrlqBq7hQxzpwL7YH6UbSq7VxbW9C9OSo7+QoqejZ3b9ErVaqJAX+
	ABVng==
X-Google-Smtp-Source: AGHT+IFxuSGAS3lu7B+ojJXi7giy330zUQ+aEe+V3me6DbSYm2Y76wFDblf69yDwU0UiZi9kg9/Bf+jyiF1s8n+OQXQ=
X-Received: by 2002:a05:6402:2554:b0:61e:ae59:5f04 with SMTP id
 4fb4d7f45d1cf-61eae597256mr4093792a12.27.1756814209371; Tue, 02 Sep 2025
 04:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250829150944.233505-1-hi@alyssa.is>
In-Reply-To: <20250829150944.233505-1-hi@alyssa.is>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 2 Sep 2025 07:56:36 -0400
X-Gm-Features: Ac12FXxSr8Mq_QbTI61IlgDzDnhRy7hHUSOIvrPdEfy1Gmiv4DAgDC1ELJPYEjc
Message-ID: <CAJSP0QXd3zgMYRUQ3kCcUZ+RbZ6SHHn-kc5K4DV9C8LeU2g78A@mail.gmail.com>
Subject: Re: [PATCH] virtio_config: clarify output parameters
To: Alyssa Ross <hi@alyssa.is>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 11:10=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> This was ambiguous enough for a broken patch (206cc44588f7 ("virtio:
> reject shm region if length is zero")) to make it into the kernel, so
> make it clearer.
>
> Link: https://lore.kernel.org/r/20250816071600-mutt-send-email-mst@kernel=
.org/
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  include/linux/virtio_config.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index 8bf156dde554..7427b79d6f3d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -193,14 +193,15 @@ static inline bool virtio_has_feature(const struct =
virtio_device *vdev,
>  }
>
>  static inline void virtio_get_features(struct virtio_device *vdev,
> -                                      u64 *features)
> +                                      u64 *features_out)
>  {
>         if (vdev->config->get_extended_features) {
> -               vdev->config->get_extended_features(vdev, features);
> +               vdev->config->get_extended_features(vdev, features_out);
>                 return;
>         }
>
> -       virtio_features_from_u64(features, vdev->config->get_features(vde=
v));
> +       virtio_features_from_u64(features_out,
> +               vdev->config->get_features(vdev));
>  }
>
>  /**
> @@ -326,11 +327,11 @@ int virtqueue_set_affinity(struct virtqueue *vq, co=
nst struct cpumask *cpu_mask)
>
>  static inline
>  bool virtio_get_shm_region(struct virtio_device *vdev,
> -                          struct virtio_shm_region *region, u8 id)
> +                          struct virtio_shm_region *region_out, u8 id)
>  {
>         if (!vdev->config->get_shm_region)
>                 return false;
> -       return vdev->config->get_shm_region(vdev, region, id);
> +       return vdev->config->get_shm_region(vdev, region_out, id);
>  }
>
>  static inline bool virtio_is_little_endian(struct virtio_device *vdev)
>
> base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
> --
> 2.50.1
>
>
