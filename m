Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E84403
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGNPx1de"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 589D183F00
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 02:45:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 589D183F00
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LGNPx1de
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-lzVsaETbne
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 02:45:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D26483ED8
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 02:45:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D26483ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704422745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42T2XOYsv/Q/QxGLaFEK4T7TNmI9rS29RX3cDmclaks=;
	b=LGNPx1deMfUnI6QyNnLMc7eZBKQ5d39Oeoeh3QN0TVxhkAXQn7KVssH0bs785HOjKq0Pg+
	/enj+c73y+Khig7u59/0MRsMb9ziI05P/1E2APFP6PTC/DE8wn4ibNAqY+BjbzSZDpOfde
	1bv4lty6GjkBLfQCuT5yzmMJfmdSWWQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-VoKJf6MmMbOWWkbe2fW2sw-1; Thu, 04 Jan 2024 21:45:44 -0500
X-MC-Unique: VoKJf6MmMbOWWkbe2fW2sw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28c6215dc43so683469a91.3
        for <virtualization@lists.linux-foundation.org>; Thu, 04 Jan 2024 18:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422743; x=1705027543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42T2XOYsv/Q/QxGLaFEK4T7TNmI9rS29RX3cDmclaks=;
        b=Dpi83X9MKV/KXD7Sx//tfmtp7vJfTX2ltGDTZicW4gVsXfAw0BGXBkCP201R8uU099
         XUj+2xBpsBrXnHyldi/IFaNM7csmi0q70md/Q0K8/a4/PACV1YhpTPHeBj/Qj335qbRN
         rAn9JebjJngMboyiuReUvf0GmpyM23GQl3XqKUbnzhFGEctDZsXaWroYs6FRr9IdpBq0
         BG9xhNEXB4L+/WblHQHSoz8KIioaqi0yjUZA+I9YSLaK3FmDNZ96W9FwXwACposhAndy
         Rl98IuAcjy1mEm592StVabHMRlQTVgSycuM2Er6LZaKCwIU5qafS0FYsUADzTy6hEC/z
         T9AA==
X-Gm-Message-State: AOJu0YxVdrbLsaoE82jHXGRH5dD3csJL2hdVxDgeVp5n73TvfeXP7y8d
	YYTPZpBoKZtSnk+724EuCOXgAmwcZa6cMapERW/FfHu+M0jxI67a2kobtkWqz1dqb6pZ/Ow5e3M
	hHXYQvk2dP8PsjqPTMhKIgij3hu6em0DUA0n2yUiR985iMSyIJVXw/xqRd7Xnxos00w==
X-Received: by 2002:a17:90a:f2c2:b0:28c:f48c:c875 with SMTP id gt2-20020a17090af2c200b0028cf48cc875mr1383846pjb.45.1704422743332;
        Thu, 04 Jan 2024 18:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU4D4ZC5TBDtzGS71F/hn8ITZAmo7xpBZ+HC+qYcgCmxUeB9oZgTh3hKy8a98xMCSDKoul/pup8VWm2YAwB8E=
X-Received: by 2002:a17:90a:f2c2:b0:28c:f48c:c875 with SMTP id
 gt2-20020a17090af2c200b0028cf48cc875mr1383834pjb.45.1704422743011; Thu, 04
 Jan 2024 18:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com> <20240104153753.2931026-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-3-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Jan 2024 10:45:32 +0800
Message-ID: <CACGkMEtmTY0ux8pw8VQ8SAdgGty=rM1VRkh6c-qBVSaqhYuURw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] vduse: Temporarily fail if control queue features requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:38=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
>
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's fail features check if any control-queue related
> feature is requested.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0486ff672408..94f54ea2eb06 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -28,6 +28,7 @@
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_ring.h>
>  #include <linux/mod_devicetable.h>
>
>  #include "iova_domain.h"
> @@ -46,6 +47,15 @@
>
>  #define IRQ_UNBOUND -1
>
> +#define VDUSE_NET_INVALID_FEATURES_MASK         \
> +       (BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |        \
> +        BIT_ULL(VIRTIO_NET_F_CTRL_RX)   |      \
> +        BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |      \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) | \
> +        BIT_ULL(VIRTIO_NET_F_MQ) |             \
> +        BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |  \
> +        BIT_ULL(VIRTIO_NET_F_RSS))

We need to make this as well:

VIRTIO_NET_F_CTRL_GUEST_OFFLOADS

Other than this,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -1680,6 +1690,9 @@ static bool features_is_valid(struct vduse_dev_conf=
ig *config)
>         if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
>                         (config->features & (1ULL << VIRTIO_BLK_F_CONFIG_=
WCE)))
>                 return false;
> +       else if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       (config->features & VDUSE_NET_INVALID_FEATURES_MA=
SK))
> +               return false;
>
>         return true;
>  }
> --
> 2.43.0
>

