Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDA20332
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 04:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710735710; cv=none; b=dotUDUpVmGp71XbLWgKORVpk/bXPbVBl4U6Ub4v2a/krHT5mgVE2eODpHzr78tADEm360lwhjgPQFyGn69h4YAFTck08q7jDtvN+kWZ3FgVs5cTxvdz2NV5r7uiIAwFBhh2ZUjLYrh7DT8RojqVpTmswJGsfAYKvHyYpYrabC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710735710; c=relaxed/simple;
	bh=jXwxnWKC278FCPKzxn5dtNNJKkks0/4+IM645aS8Wgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkM6owXrgkF7yqAaePAeKP8SRgR3DI/PkWxaEwqZ+mkY3kttNzMSUE9vEhg5hzIb/LG1PvmKGtHFHppjO0WNY4I2iOqb0tTWNH2T/JXj0004PzBl6T8MJp3aFw+JofNo81oYndT5od1oQyLDMHkNg7t6g9k6BxaioECqod8wSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmEsRQ+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmEsRQ+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710735707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXOp18MAMc2Wngpp/ezxSDL4vZtwEunhnfSnOaIjTt8=;
	b=ZmEsRQ+hzno2/9QKnQ26srwnWTTqh6mrQFfWVpz3PBkhaBosFv8iXq/JQN9t/jdvpXN2VS
	hSuknXwTxiIXwWsD/pAyZkUpPxXuXvSb1Jn78MpHGiPnNBjSIp6NBm4p7rjf6RDUu2oZsX
	hDeQWwWa+ve/AAnIdUhV7la12U+awGo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-nC70cTWvPxi2Vkipys_sew-1; Mon, 18 Mar 2024 00:21:45 -0400
X-MC-Unique: nC70cTWvPxi2Vkipys_sew-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so2597831a12.2
        for <virtualization@lists.linux.dev>; Sun, 17 Mar 2024 21:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710735705; x=1711340505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXOp18MAMc2Wngpp/ezxSDL4vZtwEunhnfSnOaIjTt8=;
        b=u8oMO/TJ0fcdZBpixgb7wneqIT55dcJ/nMiuJSuYNOcReMHE9NiJDOWqVrWU3NY3R4
         D6U/1sAW5efBFec0EFyYkXInBxiSsSGbv2ZAMUJL5AmeVVeF7lo88WokWwMH5qRMYOhK
         bNhgKoo1A/agyMZosZYmgVAFsHiJnWniY3Flf3Ktp4yapF9EQMboYHGRr3Lasy6TyAOE
         Td48uO6WxCCC5BeG1bELt8MljdEPjTfAPy2P5+Iq/wToyS0VMRwDWPerHN2QK7l//mbD
         tTRsu1UpnF3yjRFp1P0kg8O3r3aVKkG6gAtHhjfDn7JJcVHWRdOhcpVruCg0AdzfY/Z2
         hZuA==
X-Forwarded-Encrypted: i=1; AJvYcCVpbq0iAaPxN3JxarFhqdGoyLPCwK7AO6eFXycGVKRZ0nnyWISvdLYj1EclT3s1C2G6f5NT7LW/qDzP+06OWC7bYFXKsRR8SMr2cGhuE/8=
X-Gm-Message-State: AOJu0YziT0u+pLM+m76DWIfThm+YKuSrhSr2vv096wszXDE0Ou1iPvtc
	ylXei+rPSmdmWomY6ppihmeudk8HN4ZEGTI0UhNpxQ0gfs7n1gGTy9F+ZCuOoO75Q3UAj7LvBsh
	dULieCGcJ8vM46EktndjAGNKAVBVVZfquwmjSybeNnvatLKzocvK3gzIqH1gPNhhTUvsTCvhmxs
	Z/8quqelJN5pg6IsSezRGDsAfg5XTIwlETLEUzOyE=
X-Received: by 2002:a05:6a20:6f08:b0:1a3:5350:2c30 with SMTP id gt8-20020a056a206f0800b001a353502c30mr5869750pzb.33.1710735704876;
        Sun, 17 Mar 2024 21:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBJek8s3/OVbNG+tCGXDCZ2t5Ckhzr/aXQfHWLo7ucpmlSGIP/0UgxRsfvFwBl+nAXpFGB5McRaRKJzHz9Yho=
X-Received: by 2002:a05:6a20:6f08:b0:1a3:5350:2c30 with SMTP id
 gt8-20020a056a206f0800b001a353502c30mr5869740pzb.33.1710735704560; Sun, 17
 Mar 2024 21:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240315103125.1817-1-gavin.liu@jaguarmicro.com>
In-Reply-To: <20240315103125.1817-1-gavin.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Mar 2024 12:21:33 +0800
Message-ID: <CACGkMEuxub5Res+UbhTvzv+GvhFtQpo3CU7chORLRpe-XPxwYA@mail.gmail.com>
Subject: Re: [PATCH] virtio_config: add device ready status check
To: "gavin.liu" <gavin.liu@jaguarmicro.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, 
	angus.chen@jaguarmicro.com, yuxue.liu@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 6:31=E2=80=AFPM gavin.liu <gavin.liu@jaguarmicro.co=
m> wrote:
>
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
>
> Under the VDPA framework, when the VDPA driver of a device sets the statu=
s
> to DRIVER OK,success is not guaranteed. The virtio driver should provide
> some protection or notification.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---
>  drivers/block/virtio_blk.c    |  4 +++-
>  drivers/net/virtio_net.c      |  7 ++++++-
>  include/linux/virtio_config.h | 14 ++++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 42dea7601d87..14cabf662705 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1535,7 +1535,9 @@ static int virtblk_probe(struct virtio_device *vdev=
)
>                 set_disk_ro(vblk->disk, 1);
>
>         virtblk_update_capacity(vblk, false);
> -       virtio_device_ready(vdev);
> +       err =3D virtio_device_ready_safe(vdev);
> +       if (err)
> +               goto out_cleanup_disk;
>
>         /*
>          * All steps that follow use the VQs therefore they need to be
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..0431fc9095ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4808,7 +4808,12 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>                 goto free_failover;
>         }
>
> -       virtio_device_ready(vdev);
> +       err =3D virtio_device_ready_safe(vdev);
> +       if (err) {
> +               pr_debug("virtio_net: setting device ready failed\n");
> +               rtnl_unlock();
> +               goto free_unregister_netdev;
> +       }
>
>         _virtnet_set_queues(vi, vi->curr_queue_pairs);
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index da9b271b54db..de4e864952ef 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -301,6 +301,20 @@ void virtio_device_ready(struct virtio_device *dev)
>         dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
>
> +static inline
> +int virtio_device_ready_safe(struct virtio_device *dev)
> +{
> +       u8 status;
> +
> +       virtio_device_ready(dev);
> +       status =3D dev->config->get_status(dev);
> +       if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +               WARN_ON(1);
> +               return -EINVAL;

The seems to be a violation of the virtio spec:

Section 3.1.1 Driver Requirements: Device Initialization said

"""
Set the DRIVER_OK status bit. At this point the device is =E2=80=9Clive=E2=
=80=9D.
"""

Or why did you need to read the status back and check?

Thanks

> +       }
> +       return 0;
> +}
> +
>  static inline
>  const char *virtio_bus_name(struct virtio_device *vdev)
>  {
> --
> 2.43.0
>

