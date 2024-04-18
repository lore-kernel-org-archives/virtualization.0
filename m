Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279512B75
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422563; cv=none; b=JGBobA6+NkcA8od4obE2823dUH+JCq+u3q0uQ+0M+FSVbQdUaT9KIjZMx005E//yQvm5tvs15eFw72rkvqs9DyKEUWURqC6nNsDVM1y35lqsC/ZxWPonwZcRMXieYpMxNF5bS8LCU/IazigFnyHjFd/xah3y0joajhYmTVoBnhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422563; c=relaxed/simple;
	bh=uTYEKgXv0eBXXEpY3jK1fZd6YdqS230eJksfciw6oD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvTeGCtBSG3kUNYjzSpwB++SIRyotOLsaUcrXCzOq7kcqDeUGUfCPJnk3hGfEJQTSdsVarImULpQNrCKb3DgCVJRCUbnqJ2L0z/7Dto+JsjFEH1Xd0r8+rKAeiY9tzPVhoMehk8dswmVKsqeYY72OIl9IQSpHwZt69ORsFQNDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TccbuPnq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TccbuPnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713422561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEWjIuCSr8kkahHYj05QdOTlEm9mjcsK9j5UgFZ/k5M=;
	b=TccbuPnqoE5pynlEO79hjEU+HQ6sAWjYMxglXl8Co0St0GjLpL9jCOmtDUYV4ipMKCBLGH
	3KGgZ9yT4FKiy8FlAfG3HzcTG1FuZyHMteJnhi494kLh2DpiwrMWlltBmkdKMc6lIDyd5q
	hvCNkvwlKww0NYTeF+uPOZ+9hJfAzHA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-DqPEO-OKNV2X7hc1RcJogw-1; Thu, 18 Apr 2024 02:42:39 -0400
X-MC-Unique: DqPEO-OKNV2X7hc1RcJogw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a5d989e820so781333a91.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422558; x=1714027358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEWjIuCSr8kkahHYj05QdOTlEm9mjcsK9j5UgFZ/k5M=;
        b=CJJJiIHGp2gAaFtAk+UkGg6OUp0U7FYLb0+qKn97jlOL1srBc09KVVHMCKJi35DjRz
         4Hd9vle6DFpeqkH/RhN+fjCCpEKgHFDyyGtn/xSJpsoUG5fPUAATACiuvRButknB667g
         eLTe5r4b6ZPlwKop/IzJXDivVJdQRKw5toqWfA7Af4WnnIsfjvobwKFMFl6GQDgM3742
         8QsXZQbJSVcUwPnolUDazpNP30TDYBeLirEerl372TRucS/99slJKA+aCpzR0LBfxTUw
         Y659le/Ixkyf++clea4trXYmrmZKCVBFCdQT3/iyMXd433rXa50o2S/KYlNSLEigE/ED
         K+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWb759sWcIJcucO2aWtDmD6mOYz5R6sRXivZkywIBDGcbtXmxaJSExC7Q2u7UEKMRXTfa5TEflD5DmeEz98ls3CU57lOOgAWANO6jE8MQ=
X-Gm-Message-State: AOJu0Ywl4kxMGmtICRsGlHv/RVcViKwW5dGspQ+dSnNMXHQ0G1XN0EwK
	sRkO/wkFVcxkjPMYHi/uoxY2cCEtAizkKwUg+oCqpF70hfr1a3UzHKt/wyA3U7/Z8YVorlhBj4y
	vQYtQ4N1/mKw6LidDyXjPUXgrc7ap1I7bQN6GNiz++ddDTF+nb3T/Il7nxj2EfNVZ0FgTvZVkoi
	n6tTanZfW5q4fxreK1upxfN8Zsy3wd1CZ2uyyCxmI=
X-Received: by 2002:a17:90a:f0c3:b0:2a5:c9b2:fb53 with SMTP id fa3-20020a17090af0c300b002a5c9b2fb53mr1672125pjb.40.1713422558585;
        Wed, 17 Apr 2024 23:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP4VeoGUcsJ+M1k+EH0yckJ6Bn4LMuCZMqM5wTKg70OkDVyqOSIkGnQJL8ITQ9iL5VQbw9/CsbaWkKUQ0UVac=
X-Received: by 2002:a17:90a:f0c3:b0:2a5:c9b2:fb53 with SMTP id
 fa3-20020a17090af0c300b002a5c9b2fb53mr1672110pjb.40.1713422558324; Wed, 17
 Apr 2024 23:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240416193039.272997-1-danielj@nvidia.com> <20240416193039.272997-4-danielj@nvidia.com>
In-Reply-To: <20240416193039.272997-4-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:42:27 +0800
Message-ID: <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command VQ.
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:31=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> The command VQ will no longer be protected by the RTNL lock. Use a
> spinlock to protect the control buffer header and the VQ.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0ee192b45e1e..d02f83a919a7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -282,6 +282,7 @@ struct virtnet_info {
>
>         /* Has control virtqueue */
>         bool has_cvq;
> +       spinlock_t cvq_lock;

Spinlock is instead of mutex which is problematic as there's no
guarantee on when the driver will get a reply. And it became even more
serious after 0d197a147164 ("virtio-net: add cond_resched() to the
command waiting loop").

Any reason we can't use mutex?

Thanks

>
>         /* Host can handle any s/g split between our header and packet da=
ta */
>         bool any_header_sg;
> @@ -2529,6 +2530,7 @@ static bool virtnet_send_command(struct virtnet_inf=
o *vi, u8 class, u8 cmd,
>         /* Caller should know better */
>         BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
>
> +       guard(spinlock)(&vi->cvq_lock);
>         vi->ctrl->status =3D ~0;
>         vi->ctrl->hdr.class =3D class;
>         vi->ctrl->hdr.cmd =3D cmd;
> @@ -4818,8 +4820,10 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>             virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>                 vi->any_header_sg =3D true;
>
> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
>                 vi->has_cvq =3D true;
> +               spin_lock_init(&vi->cvq_lock);
> +       }
>
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
>                 mtu =3D virtio_cread16(vdev,
> --
> 2.34.1
>

