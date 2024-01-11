Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EC17C6
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCf7xr0O"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5597B43791
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5597B43791
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LCf7xr0O
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjHyJF-2sSXG
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 03:11:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A4E343666
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:11:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A4E343666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704942669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVa1KzmyYYorAZDdtVUttYweORkac6xnCaVp9EWXlys=;
	b=LCf7xr0ObBWj/b57CIK7lkilrjr9ki0jYMmnDNVoBk342nXg0x99O8OFmTM9ajiZmmXNm7
	HPb4WcBNX7Ug6hJT5HT7olGbQd+Hcdj9VCUNarHiw6PiKGg+CjV14E67M36OlS5Vqx2pBg
	w+3Ac1bQ/9jF6nvhqsiPLner2LDlihM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-KnSfJ2PyNmit0EFubhFbiQ-1; Wed, 10 Jan 2024 22:11:08 -0500
X-MC-Unique: KnSfJ2PyNmit0EFubhFbiQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ddec7b52e7so2107400a34.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 19:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704942667; x=1705547467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVa1KzmyYYorAZDdtVUttYweORkac6xnCaVp9EWXlys=;
        b=fS61/ytAGOUjoW1hEHPkjIo2ZmuBAdVYl0cSi7Y6pOFUzY7K6EQjGbaUwsgNzvuhk2
         9wP/nYgfY5hf569FDUr+af+e3aWdzutnCg8HBGI4yHCtLfudcw0mc0K0KrvkW2VhspOr
         6h+7DLZDx+RtZWTcGiAPI4eXzbu/8ZEPIb/X0N2/giJgTH054W0JeeaMe2sAYXQq39K4
         X4s4JOG2FxniU8RbFQQsPuT4J8FosCbp06lR7euu4x925tOumRuQ4WCHxy6hDwbbZ5Oj
         8M/PLZr1s4aJChsDWoMKL/XR/6ZNB8YmJFjsAIYDWWx2A1ORI0qfcRuuOd/I6Rqpu/Qq
         K9Jg==
X-Gm-Message-State: AOJu0YwqBkbZIpjpKo4T/9lMJTSeA5Xe0Hjf7G9YVs8sIB3ZvB0GMmlH
	AhJuJVku8Lrr3prtX3fQtPg3aMb2aVE2qcx/aYpggTd/6BzQpsKeUlPlNm5h+aZOZDVo3dW3Zui
	Myn2rT404HQj/ynFogvQwjAbRb08IFf3FqtLJ7XRjROWDhK0MS0Si1i9Y/2omhTEyLQ==
X-Received: by 2002:a9d:5e04:0:b0:6dc:4f4:f4e0 with SMTP id d4-20020a9d5e04000000b006dc04f4f4e0mr513030oti.45.1704942667359;
        Wed, 10 Jan 2024 19:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3wjIYR0PBvhYK3NGeTYrBLBnxAsEX+Am38TXiw81014PUC3WFBBHfaa4wMD9BO+8kt2Y+dPM3b702gUqtdwI=
X-Received: by 2002:a9d:5e04:0:b0:6dc:4f4:f4e0 with SMTP id
 d4-20020a9d5e04000000b006dc04f4f4e0mr513017oti.45.1704942667121; Wed, 10 Jan
 2024 19:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com> <20240109111025.1320976-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-3-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:10:56 +0800
Message-ID: <CACGkMEuOCAKwn-4dC4pd8qbBP+0sYCBa4-TpVabN238-WOFUBw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vduse: Temporarily fail if control queue feature requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:10=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
>
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's fail features check if control-queue feature is
> requested.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index a5af6d4077b8..00f3f562ab5d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -8,6 +8,7 @@
>   *
>   */
>
> +#include "linux/virtio_net.h"
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/cdev.h>
> @@ -28,6 +29,7 @@
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_ring.h>
>  #include <linux/mod_devicetable.h>
>
>  #include "iova_domain.h"
> @@ -1680,6 +1682,9 @@ static bool features_is_valid(struct vduse_dev_conf=
ig *config)
>         if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
>                         (config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_W=
CE)))
>                 return false;
> +       else if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       (config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)=
))
> +               return false;
>
>         return true;
>  }
> --
> 2.43.0
>

