Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835723D0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S1No8ktQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17F3A613C0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 03:21:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17F3A613C0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=S1No8ktQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ETi0z-cnayY
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 03:21:06 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B01AB613F0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 03:21:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B01AB613F0
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3bc1414b48eso4123957b6e.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jan 2024 19:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704856864; x=1705461664; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj6N1efk3sr0CxuJFT4Q8DbyNJU3YuHTNbSj/LQf1lo=;
        b=S1No8ktQS+TjKQiagzP2FLFOTEF6nYn93m9tcRX+HXZ7rGud5TNYr94j/BFoZ/qY9S
         kAbWkZUZbpSNVIqA39lyIjKUIl0QjixTrFW7HVRjVjwxcT7xCjPCQ9IVLfwF8+fmaM0D
         Mkvv0H6cRiQ8mh/lCuBvHY51VNNQYXYn0pj1noa9/Lxl4uIRyXvmKIZqUhLwBB0CSInt
         5imuJ/49x9vYi+lKMdCI/YQcSI7o04Mvg+hlXlCFT71E/ZP4zcg8BRz6vsI080q4L7fe
         L4PClZScrFyXHe8a50o0UGcE9FaI7SFamJb83J6AFjzQDzYd6j00USKgLPIJTq8eAqGk
         iupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704856864; x=1705461664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj6N1efk3sr0CxuJFT4Q8DbyNJU3YuHTNbSj/LQf1lo=;
        b=BM4YPY7UL/wPRnkh55VTJneVAwu3cIZJYZIpmbdID0JUpHq9l77loUfV/wFKGOjwi3
         FqXvu7dtqCsHVtrgu8kxNPHFA46xdLqoLQerfmqhTph/SSOHrrq5mAyk91bHOMe24ROU
         /l24waLlcC+wZDXdP3M1q5d1s/n5tkQhGb0mKctGHqVmcKxa/RzSEhSiycqNorbSRqA6
         s76IzGinJOqG/CyMf/NztXY7SvF2V/KEoDelXB2ZTP99dvxJjrapUxnlSVSG67r3dF/1
         9mC4xJCOb+kNLIDvreGlPsja08IqexuKHZBvtnWaJ42pmI8cC+bWsAYNRtW+jezgYmrs
         tvfg==
X-Gm-Message-State: AOJu0YwItdFGXRfp+2rZ7ag2vOPjlUvPt4ACjB7vvyGTHSxswzjw3fiV
	52Pl6VQnaVwbHUgb2nVEm5jHPQzXPwG/+UmV8WGqiVSqqeGV
X-Google-Smtp-Source: AGHT+IGqXBEnKCM1dvGMoY/czMMwAslKtHfI0G8Legil0uTORf6Ps32W3HONIOQQ6Wj1YhsNUXuxTrWSMk4LPpxazTg=
X-Received: by 2002:a05:6808:1919:b0:3bc:9167:4e62 with SMTP id
 bf25-20020a056808191900b003bc91674e62mr507670oib.40.1704856864530; Tue, 09
 Jan 2024 19:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com> <20240109111025.1320976-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-3-maxime.coquelin@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 10 Jan 2024 11:20:53 +0800
Message-ID: <CACycT3sjYzh7Df9M1Bfxk_pWc7Am6AmjQv8_vu6fA2fhP2+7mg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vduse: Temporarily fail if control queue feature requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, David Marchand <david.marchand@redhat.com>, 
	Cindy Lu <lulu@redhat.com>
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

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

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
