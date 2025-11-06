Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A32C08D4
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402267; cv=none; b=oL7ZK9h21KbN8QBUQupweHD6wfSpGjY3oQ2Xr5REtta5lHmNSgAfo0DSfNNZMeXYOBmpMXVmjbW/Ska+2wSNLQyAnpmU6Yb4pMxzn2u9uRj2cemDO0z5WE+Q4cSQrQVAUvcM7p5eyW2/AxBfNODGSmDAW1HbAogffPzLtol8JZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402267; c=relaxed/simple;
	bh=Vypx43P0Hs2X8jRuOllJ3i2T4fUJdBHpZ49sS5pkgLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgkqPGIs7OmW6Asf7Zwqclt4BM9hQwLKxzl8o8dV+6evhyA+iOtRT3s9OeNdZBy9QfXo1fJBK4mnqMHnje/i0Qq9Pe/w0BUBZxruPCT0KwPnz6EzM85nTTe4jLH6oHNNHmTUC1uRNjd6+Pm9GMM145pm3a2/2sIlOaidXKqqNLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTqyIBC+; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTqyIBC+"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C039B41130
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 04:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MJ-UwTuDuPR for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Nov 2025 04:11:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BE0FB40E25
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE0FB40E25
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XTqyIBC+
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BE0FB40E25
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 04:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762402263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diXDixvU+ces4HrvG9aMeLf62bJbIofBXJ4g7RwEDSg=;
	b=XTqyIBC+bDw3ZefUX6WaZyHi14K6yu4iSHnjVDgDGBFeCLtH5zVi869SPj3vTgwXtUa9Xp
	0FX4aNjUsKQPxiR+F7ow6HwcOh5hnMGGFm9EYn/OvEbX8tz0GkSzR/MAKZ66x+k5Pxgzxb
	saNbf5U7njt5CFhyaNTE4f8SAG5QRCk=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-ZhpxAc6xNKqHI_kHtbFVhA-1; Wed, 05 Nov 2025 23:11:01 -0500
X-MC-Unique: ZhpxAc6xNKqHI_kHtbFVhA-1
X-Mimecast-MFC-AGG-ID: ZhpxAc6xNKqHI_kHtbFVhA_1762402261
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5dbc9806b6dso1085638137.2
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Nov 2025 20:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762402261; x=1763007061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diXDixvU+ces4HrvG9aMeLf62bJbIofBXJ4g7RwEDSg=;
        b=gqllBHwWeWJt+c8IHqrOoGF0hNdQmZAUXSxkDqlk/vDhEQmJMS295WZRsyZT1tdJvr
         bMbQQOfbpNv7FdwGkWwI4XVCVv0IB4ZuXyPNJMRXjQWnNIUkyj2eKrCNP3iO9j7Jhafh
         W5+t/LpTf8AdG1M/6lqsIyWrF4KISqPyN8Io2elH+IuMWNUNYCf7SDf2DIHSJx/dYlyx
         d5vG0qBWTnZojY5d69m7zmka1GHR8rLcuIk3AhemABcp2fdSFLtA9GtedZtDeLt/1sdP
         AP45DE/ixbzArq1T17WWiECmu4V1fAwhJbI9hhcKEHba0lvP2TP9U8mZ8O2DkOT/aglu
         9fOw==
X-Forwarded-Encrypted: i=1; AJvYcCVXTQX70L8JCvM+ed7HlgCq9KK+6nhGFwKpQMBHuHuqgXyipceqm+ER63HaSXyvlqDhgMsH30vSkL1zI7Eqvg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzG25fJCQiGsh6MnaNUoEhJV2ScpMuKTPFh8b70mehvm0Fi6sIt
	SIQPDsCC8G/0P8ALbOaViB9F1fv1kZmKEXrT+CGA7YenDf2EZHi9xkduHm1rSr0ZgR8VwPitRB/
	j8sKhLJyiAegt+wJNheICzna8I9W4u63pkERhiDuQji9ai3lgeShFXy1Xi2Hfg7r7fU9DtxCmdV
	wMH0fPu+I9NMK00qwBpO7K8ZAjwti34ZAiCEYka5X/ehLY4ybrRH/3nzrIhw==
X-Gm-Gg: ASbGncvGp3Xws9f4mtkeYdVhTLPaFlTl8fF5Spqitm0YETiZZnKVUGU2d4WIrwRkbsc
	YULiVMtnDkv9MDbEvyNfNzYPGsqotFUsItAqIP8VfssCbu99OOl/kSSq0QDaBM2U3ONtbMCvoPU
	7Wdumic+aa0PUD+oLpq2PIcTwzPViQxhH9RBT9TbvzmMSH07OgYR+w0wT7
X-Received: by 2002:a05:6102:6c7:b0:5db:2301:aa07 with SMTP id ada2fe7eead31-5dd8935c8c6mr2308390137.37.1762402261123;
        Wed, 05 Nov 2025 20:11:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrwdvRqPKYLxxY9dCQgrgztT3XItWP4mQU5xFiAH7wQRKQxGe/OvDiFkd/9kbSM8GD1fLrClO7b/gMzIHJdKw=
X-Received: by 2002:a05:6102:6c7:b0:5db:2301:aa07 with SMTP id
 ada2fe7eead31-5dd8935c8c6mr2308380137.37.1762402260712; Wed, 05 Nov 2025
 20:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <20251105080151.1115698-2-lulu@redhat.com>
In-Reply-To: <20251105080151.1115698-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 12:10:47 +0800
X-Gm-Features: AWmQ_bkDYKYme3pzt7xT2cmZpaqdFv46kMxg33LWsi20ecbBTbXuPdgNz1-3zz8
Message-ID: <CACGkMEvdjE+bYxS5_XPEnKWR1sQBuq=6CAqjioto6enryKm8kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 13nMD1DeNuymnXecxL-0bl-_RNnewmE9d11rAGJtec0_1762402261
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Improve MAC address handling in mlx5_vdpa_set_attr() to ensure
> that old MAC entries are properly removed from the MPFS table
> before adding a new one. The new MAC address is then added to
> both the MPFS and VLAN tables.
>
> Warnings are issued if deleting or adding a MAC entry fails, but
> the function continues to execute in order to keep the configuration
> as consistent as possible with the hardware state.
>
> This change fixes an issue where the updated MAC address would not
> take effect until the qemu was rebooted
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e38aa3a335fc..4bc39cb76268 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -4067,10 +4067,26 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
>         down_write(&ndev->reslock);
>         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>                 pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> -               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> -               if (!err)
> +               if (!is_zero_ether_addr(ndev->config.mac)) {
> +                       if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) =
{
> +                               mlx5_vdpa_warn(mvdev,"failed to delete ol=
d MAC %pM from MPFS table\n",
> +                                       ndev->config.mac);

Any reason we need to keep trying when we fail here?

> +                       }
> +               }
> +               err =3D mlx5_mpfs_add_mac(pfmdev, (u8 *)add_config->net.m=
ac);
> +               if (!err) {
> +                       mac_vlan_del(ndev, config->mac, 0, false);
>                         ether_addr_copy(config->mac, add_config->net.mac)=
;
> +               } else {
> +                       mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM t=
o MPFS table\n",
> +                               (u8 *)add_config->net.mac);
> +                       up_write(&ndev->reslock);
> +                       return err;
> +               }
>         }
> +       if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
> +               mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to vlan t=
able\n",
> +                              (u8 *)add_config->net.mac);
>
>         up_write(&ndev->reslock);
>         return err;
> --
> 2.45.0
>

Thanks

