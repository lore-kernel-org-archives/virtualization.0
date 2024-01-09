Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4336B1B
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDsOpJZU"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 601C5409E7
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:38:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 601C5409E7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PDsOpJZU
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZeSmU8NnUKx1
	for <virtualization@lists.linux-foundation.org>;
	Tue,  9 Jan 2024 11:38:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AE7CF409E6
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:38:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE7CF409E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704800333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2KHtwWJsxpW21yW1HeRr38zmDlSiokTXP6mx3ysxiI=;
	b=PDsOpJZUWfQ1c+TbjJiQKqrch9UNWOmBFuURiXq6XYSVCtEAI9xKIfcdd6ClbtzibEVuxN
	v4hUA3DiUSuLIwOEOid0iHcN9PFWJQLNF2qrdxdy4wVbn2za70C30ml8rmGsEI8KhTJq8m
	GlhPSxmikrwX5ge3bBOAPoRvkSryNyw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-_arGNXHyPxuyfId9imIkyA-1; Tue, 09 Jan 2024 06:38:52 -0500
X-MC-Unique: _arGNXHyPxuyfId9imIkyA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5f69158f32eso37011717b3.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jan 2024 03:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704800332; x=1705405132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2KHtwWJsxpW21yW1HeRr38zmDlSiokTXP6mx3ysxiI=;
        b=MfOGP9V3ipctDfZkoZEpCVwgFbbadjGrDUpk1Y88GAAwoLS5BBj4JGizWWzWfPWIDL
         LhDyI4EbhFGlTh5eCeRdS8ZnLSN5naSwtkF3RRwZScBcqdYfqE/qmNQpiC2L+euulz44
         H3+U/E16ApfDyFmkG4KUZlKfon1vwRGmtS8eKPtd/nPoictc8Iwy32K8U4l7Ixl5kB0z
         KPIHUvHGjO/bFRcoLlToT0OBAjmQG6gcJgAZF0CaoPydiDXLTu30jtWW0tlTgmcifwhi
         O1QcAfiZ1GcOku+5LYDswYxjtmtXZy4d/yt9ukd5G1xWCilq6/vrZfh+RHKFrOV3ZsNO
         3FZg==
X-Gm-Message-State: AOJu0YztWaonSCTYDLLuDNK1ZBtW8ZGRz07d1axS2RdgAwLtufetl6G6
	nJkSnpZE0Db/d5QuC8u9mqvGCmcBFZHVHcqB+5jPfVwvzrEhm/a9EgPaEYbJkmObI7cHbilha5L
	ZSEi2jhmbnV+FUc9iwFQ8NEqQC5hz1uhBdcZUzrnZMIdB9jSenS2/mADOguIK6dhsSA==
X-Received: by 2002:a81:7b07:0:b0:5f9:2256:5ad8 with SMTP id w7-20020a817b07000000b005f922565ad8mr1283428ywc.90.1704800331761;
        Tue, 09 Jan 2024 03:38:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrPfFI6jj8BO9UxzydSFzI12LofZZDf1mXLgqZA0eJByqMfyMiFqsUTjau9HOuPkP/s3h5jokc5K+rlk7t/sw=
X-Received: by 2002:a81:7b07:0:b0:5f9:2256:5ad8 with SMTP id
 w7-20020a817b07000000b005f922565ad8mr1283419ywc.90.1704800331475; Tue, 09 Jan
 2024 03:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com> <20240109111025.1320976-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-3-maxime.coquelin@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 9 Jan 2024 12:38:15 +0100
Message-ID: <CAJaqyWd9OYHqshDgYmP4X2pyvuAkQXuvttjKuAeMpvBira3FqQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vduse: Temporarily fail if control queue feature requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:11=E2=80=AFPM Maxime Coquelin
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

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

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
>

