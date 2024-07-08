Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7118641
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422387; cv=none; b=I9tlD/kGIS+20rsZZm6XmdYC0nSldCWIgEDWdd5sbmYV4ipUV6eVcg1Wc8zdG/zS31frJxf0kToNuZE+rGFOnf8l1/GvSpRTu2wMJhu/ShaH40l6ea2hUZxi8L1/paDGTMnjhoYlYaRiKPj7jUHnygrDT7N/GPIPpQwj1tJANCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422387; c=relaxed/simple;
	bh=THNdkBV6zSeKbGJ+rU746rP1p4hHLxTftUqiTNAVfmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doeSKbOKe4X9TN1jNtLgSbeAhfiVhxpHLXZr1Lyc9lCHGHC+OPTO6yDI23pFsV8UbR3uvcYbUFunNLlhqcu+KMHZLh3xifnmERSKxGwmf2fyn/2LPPmdXwRN3j0cJU6VNLn/T8kdwaTCPNleczs4KgzWKHtpU2llCpK3E9sZ0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmNOAgEC; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmNOAgEC"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A97A981000
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:06:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKDHlLyi2rAm for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 07:06:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D4B4380FFF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4B4380FFF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NmNOAgEC
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4B4380FFF
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyIJppIdQ0nDVMjomTHHFokVZU/AX+NHjK5GMHRTEbg=;
	b=NmNOAgECKqlcUfPD+S7jTqpWQi18coYbJc2QPyTVu0VXDxaOiK6Qm2g1vHf4d0ILYlbF9d
	CzMdv/36IDB6LUeulTdxIuLNDgrUXSMuLe4b/DkiE6iTZXnhhV+KCE/e8y0bwYGyaEBzJk
	+pu7LnMwIIYmzKF1k02fBlT6dCYdrUo=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-KRQZty7fOJeDMg61Ee55FA-1; Mon, 08 Jul 2024 03:06:22 -0400
X-MC-Unique: KRQZty7fOJeDMg61Ee55FA-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-48feb0d1abdso1722104137.0
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jul 2024 00:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422382; x=1721027182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyIJppIdQ0nDVMjomTHHFokVZU/AX+NHjK5GMHRTEbg=;
        b=n13rfxJOlrzpoqN3E/1HGXeEuKZy+mniCv2JyiPyjdg+tfo6192oPPX7qWUfRp8VCe
         vVkqdR5uBoGQQw/S7/KXz6T8KYTWe04HqU7eJBB9fUpKBZ7aOcN4Y83k+IqD/41EGfnJ
         H71fRoJlw+2AEULaJa/BtF+vkIFFm9q4E71nEAn98o6Yz3gf9cPDja5nBNVkq1X6omGR
         nzfrSBxyeosSZUbj0Nl2Hyrhr7A9bZ10hT790FYDgKjPn9mz75kyOooLQwHldg5TEmAh
         rAKioBbFduF0paZjwL54TNTHv5SKcbDfFwOxT6cTOtveYbnw9WyLwucipD1rV9I3TEvI
         /X1A==
X-Forwarded-Encrypted: i=1; AJvYcCUEr2ZtP5+/M52wWOrnE2vhoFftvRfStf9aoY7xOMyQuOZLRkuf+LZBsrbVZzfIOAsC1x2ouKcXQWkJmUw6jayBZBSSOOXbAIO2BDSexoOiaQ0PIrnLN2Ccww==
X-Gm-Message-State: AOJu0YxcgXk6iGhhuB5xsbpDGZrvsa4eCWNwJ4cL3dmComy8nzCB0rwd
	eZJ1PGs4/q5ocNzWTI/o0cCfPTZKz2HvHjr6BBKF0TPhuMPH1Al9PBsqiE3EYA/zsAbAA8D2GiL
	RyYb3k5MpoL1MKdCEpfJ/vcFEp/FafZFgdDJdZJMLUNfltPO7A/59MSoyMVKgCdVenu7dV3iTjU
	6t58z+JTm/xD63OZ3y5n2tKSqVmzQoGZ3PnLYo+T3B3dpiBOXb4q3lZg==
X-Received: by 2002:a67:fc49:0:b0:48f:95c4:d534 with SMTP id ada2fe7eead31-48fee85607dmr10714733137.3.1720422381818;
        Mon, 08 Jul 2024 00:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO1uc/RoshDkfTco0M6SeXuaFTZdF5eVYjCvZPJyHOCO2f2BCvZGt1Bk00xuZa9uB5eVL5bqHsQrA5BAFqNEk=
X-Received: by 2002:a67:fc49:0:b0:48f:95c4:d534 with SMTP id
 ada2fe7eead31-48fee85607dmr10714708137.3.1720422381475; Mon, 08 Jul 2024
 00:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-3-lulu@redhat.com>
In-Reply-To: <20240708064820.88955-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:06:05 +0800
Message-ID: <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index cfe962911804..a472c3c43bfd 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -414,6 +414,22 @@ static void vdpasim_net_get_config(struct vdpasim *v=
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
> +
> +       struct virtio_net_config *vio_config =3D vdpasim->config;
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               if (!is_zero_ether_addr(config->net.mac)) {
> +                       memcpy(vio_config->mac, config->net.mac, ETH_ALEN=
);
> +                       return 0;
> +               }
> +       }
> +       return -EINVAL;

I think in the previous version, we agreed to have a lock to
synchronize the writing here?

Thanks

> +}
> +
>  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
>                                      const struct vdpa_dev_set_config *co=
nfig)
>  {
> @@ -510,7 +526,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev =
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

