Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD65206E67
	for <virtualization@lists.linux.dev>; Tue, 29 Oct 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212779; cv=none; b=uEV/8Y9wuAE4Ttfvl3oiJ+c7n71yYxGDzky40lAE99xV34IlDNuxHQ3CZaTEBbLbYC+tMja5454GR7wUodbNBbj0aMmzNI+VpkddHn+V5L6mdrz+ENo7HqZ3iffBzLwckoW2LNuPcddEo2/6WlP16fOhPNymBMx9FDFtbjhhQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212779; c=relaxed/simple;
	bh=Aq7YRb1kx/rReKryEzPZ5nl/U1uAZud74I+ytPcEugA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO5p+qViwyRfrLvMxDceKCYMiGuyYNUv4GXUJcb8AZOB++Xd0VlUIl11nLXH2uNqMrB/AHD1qTjUuTUPJvLB5W2zg45O4KyES9vhn63+fy+yeF47kvg0Hbbv6aMSGXs/Uuyof/BaQQx+u/5eSgtB5Dpy8rf8tlV2xHJTI5ymW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK3BG2rP; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK3BG2rP"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2689e7a941fso3154920fac.3
        for <virtualization@lists.linux.dev>; Tue, 29 Oct 2024 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730212776; x=1730817576; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=42kCCY8RKDB4UpaiW6c/w64Igamtz7Kta3ZJotw+UUU=;
        b=dK3BG2rP+MFAHxZeiBC8/TQVzoMH5BRWe2/Vk0SRXrg+ybxiCMQBEhtjEqsFp6HWKD
         NuN+ikb1qbm6qMZWQOBhA9mmrub1MvInac4ZNk8wCp59RhLvH+SCKEDqrmJ2uMXAvAQa
         NNZrFJSkAMGV2PljzX96WRPezVVbhGlm77XEqWu8QnTExOEff0yXrXNa+gMP/69WZZcr
         jIIXCXxdmSnOWyhrOTXjqgnLSq4Gj10JMgfLm28w5TBJpdk1sG7ULZH1RzJcvVXN2hia
         m7IlkD0RKGRX0hSWX23YUz7TG2JnYSvjSyENuF8Bn1D1Z61Pc+Cud5v+9miQQOhmHXdz
         0TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730212776; x=1730817576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42kCCY8RKDB4UpaiW6c/w64Igamtz7Kta3ZJotw+UUU=;
        b=u/BxjG+8zRZUatEJukWeoDYeNyheyBdsYnhBUwn0k2An58N5ZW5YElApu6jzN1kSWt
         LD5NEMpg2xugOcbvCSGja3kut9GIFNnrRbRqpA+tmm9nZAFaP0FxM4bODEa4Rivwgs7P
         2zOuGvboVkF9KshlRU7LF1+LOzmFtChwCIR4FjWn0DQz/QrRsy8FZIVGz7ieq1uGwirB
         paPZEQGHRR5nKakjveVrfF8OnLTIJBCx3AeWrTZGNjU0Zs/uHTVI8VG2QPTtU5w9icBQ
         XDlTeuRZiHBgiCY9I87L/LetL+AkbadEurIlwSXpiKouE70gJ+6C+79Zo6ozeeCKWz3j
         zjsA==
X-Gm-Message-State: AOJu0YzaSclCbsN6rs9WkEhuVLBsDAFIKf/cy5T6xGDbNdyAevDhIpm5
	6ovXOWLjdfXliPnDlp06I1ppO2djAzQtluTWkgMAy7xXZMi7GqwTIN0yHQi2SydpUk/wGJT9xBk
	IUCQ7Xph9TY/rRk/E5oRtQIPCqcY=
X-Google-Smtp-Source: AGHT+IH/Wq9pdPA4tznCDvaxkxnUoYk3qs59FGEbC+pTQIr2YMsc3ygiR2ERf2+ddD/F/zgbiKW749beDbVcfRt7riM=
X-Received: by 2002:a05:6870:e38e:b0:288:666b:9c5e with SMTP id
 586e51a60fabf-29051b4d530mr9716393fac.17.1730212776181; Tue, 29 Oct 2024
 07:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240920090649.42295-1-eguan@linux.alibaba.com>
In-Reply-To: <20240920090649.42295-1-eguan@linux.alibaba.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 29 Oct 2024 15:39:24 +0100
Message-ID: <CAM9Jb+iYf0kjwK3OXc90NMrYEkJnWJmQNdg+MLd7DOpaFXADLA@mail.gmail.com>
Subject: Re: [PATCH] virtio-pmem: reset device before delete vqs on device removal
To: Eryu Guan <eguan@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"

+CC MST

> We should not update virtqueue status while device is in DRIVER_OK
> status, so reset device first then delete vqs.
>
> Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>

Looks good to me.
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com

> ---
>  drivers/nvdimm/virtio_pmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index c9b97aeabf85..55ffb0e6976b 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -139,8 +139,8 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
>         struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
>
>         nvdimm_bus_unregister(nvdimm_bus);
> -       vdev->config->del_vqs(vdev);
>         virtio_reset_device(vdev);
> +       vdev->config->del_vqs(vdev);
>  }
>
>  static unsigned int features[] = {
> --
> 2.26.1.107.gefe3874
>
