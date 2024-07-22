Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A71BDCF
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634507; cv=none; b=FrWd2FjrX8vXA6WZzw3VfM+TU7fF9PepjUsgbuew5afVIj+VUHK1GNHw6jlJPC8sFypQcp7g7hH62ZLEw8IlpgsbCRR0NTSbntripprk+LkyxpDKYiOBtdykxEGeTmUPCEcrOMP0LmJPFV78q9BThpcbytyEFVAUrvhzQj/vlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634507; c=relaxed/simple;
	bh=qwelGQSOHsBlu5/R+Td9lnRymixbgCg1HZ+vhkQvB5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmrMXH672huMasqx/1Zrvw/dBs63XWj7eI/gnbJo/Asj/QAHMW0igL06VWhsUWALGwGk+8KP8oG163OFWSjTS+Oe98PO11OOPBfAb4Hr6wLT9Tw2ZcgfUtey2gEXCllr6f/1S0c89lqhOtB6Uj+ybwTfnZwfSqHI9fW6SEzAnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTbO/VFi; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTbO/VFi"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60CAE80E65
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b74aplVJOVLf for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 07:48:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 88D8F80E62
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88D8F80E62
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KTbO/VFi
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 88D8F80E62
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721634503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/mcqTp3y3xN2oxPQLtpcs5nTeZV7vOd20nAM2VvMok=;
	b=KTbO/VFi5CytpzLem0P+0H6ZGGcMrjJBF0hmv4wLItT34qXYzjntyT3d9tJiWMLSU7q9Qk
	2HKjucdXULBxobGyZAysi/BYB0Ir35JeKpYANXAJN6jsyB5H2R9qxQb25QKYILqP8MEKfa
	BA7UsbRG5FQ9F3at2UoZ89vHICwY44E=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-vy6uZb0TMQaiBcWCP2TSkA-1; Mon, 22 Jul 2024 03:48:19 -0400
X-MC-Unique: vy6uZb0TMQaiBcWCP2TSkA-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-8217d09688eso1044573241.2
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 00:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634499; x=1722239299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/mcqTp3y3xN2oxPQLtpcs5nTeZV7vOd20nAM2VvMok=;
        b=dJ+dX+2JlqzLDk95L+a1L5CEE3KOoszqOvH/0WIRtmFsYdYA3yKqS9cv6DYs7TnyDx
         FejPQm8OMdFvO84QSr+EpEyKz8JFHo5qSrL001uuGgWQjBU6kH78bJlRXMyuXATmdrwt
         1ozJlewj32RGG3L599zlJIey942oHqm8cCCIIGnR2R2dTLNRjyqVEFsik29B+tAJx4nL
         vRwIJKKzDWVgtUhIJ5314TTEu2RjXJ4y9ysKzedebc/40wPnT6XkylP74jhF2zs0G3ke
         +Zk4J69yh4PQU/itYauOwkU375kO/U739dJEyaR1JZGfTerw6FIPOJEgs1HPFNtbqhcq
         RQzw==
X-Forwarded-Encrypted: i=1; AJvYcCXMBnxzPSdcRmxRmwOxvqvlAoE5OTEQsHTszgJi2Tj2IEU65aCKN1v1fHEZDrQ5/Mnfvz/f39+VN8rrNhpf4a/+r5xKhUxAPHiRo7g1/b9Xb/VIYenkhqYTxw==
X-Gm-Message-State: AOJu0Ywp+b/TJfPNCjWblkZtZo983mzUF/Og1NxHGV9R2rdGLuiWkXYa
	35YwYa1iYxnlAAxGZLs4cJ2iKCftOoALkbA2rxMHxns+/2uDRtsc1bI4kj9OhquoSJ2QsE2xM00
	iadYlUBl6Pt/OEkzkvnW8bKd8Bjmy0sMVKpd3CenLPQQYJaotp6oiX1sR+R75VJkSyyg4sH6nHA
	OMJa2MPXGlkycRl5mQVHqrVFHTwf3EUbQMd6XrMxamipmILey+kG8/Hg==
X-Received: by 2002:a05:6102:5e96:b0:48d:a5ff:2f5f with SMTP id ada2fe7eead31-49283e2b004mr4468187137.12.1721634498690;
        Mon, 22 Jul 2024 00:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAp5cOsjJMIxSSgdrU2NI/bo+MBLdUDPozloHXQyx7N7sL3/bEoMgtqLF7ISAqIr6HhTEILPOLPhO3xtGIBgs=
X-Received: by 2002:a05:6102:5e96:b0:48d:a5ff:2f5f with SMTP id
 ada2fe7eead31-49283e2b004mr4468168137.12.1721634498275; Mon, 22 Jul 2024
 00:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-3-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:48:02 +0800
Message-ID: <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
Subject: Re: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index cfe962911804..936e33e5021a 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasim *v=
dpasim, void *config)
>         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LIN=
K_UP);
>  }
>
> +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> +                               struct vdpa_device *dev,
> +                               const struct vdpa_dev_set_config *config)
> +{
> +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim, vdp=
a);
> +       struct virtio_net_config *vio_config =3D vdpasim->config;
> +
> +       mutex_lock(&vdpasim->mutex);
> +
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> +               mutex_unlock(&vdpasim->mutex);
> +               return 0;
> +       }
> +
> +       mutex_unlock(&vdpasim->mutex);

Do we need to protect:

        case VIRTIO_NET_CTRL_MAC_ADDR_SET:
read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
                                             vio_config->mac, ETH_ALEN);
                if (read =3D=3D ETH_ALEN)
                        status =3D VIRTIO_NET_OK;
                break;

As both are modifying vio_config?

Thanks

> +       return -EINVAL;
> +}
> +
>  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
>                                      const struct vdpa_dev_set_config *co=
nfig)
>  {
> @@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev =
*mdev,
>
>  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
>         .dev_add =3D vdpasim_net_dev_add,
> -       .dev_del =3D vdpasim_net_dev_del
> +       .dev_del =3D vdpasim_net_dev_del,
> +       .dev_set_attr =3D vdpasim_net_set_attr
>  };
>
>  static struct virtio_device_id id_table[] =3D {
> --
> 2.45.0
>

