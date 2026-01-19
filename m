Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDE23D2B1
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768788782; cv=none; b=F3X2DdOUa37RqoSLu+5Q+3mzownJHW9HkoxInD/BtJFL5BSVS98KkkXpfZ6r3plgjY77QRr+QZvbrrsP2vK6g53tRMX4DHPZZnEZeepY5uv8bjyuIIycJNl3g4D2G3qV2PU8MkDwum6u4moiXxJbna1t14h6qFjIYvBAwM07M2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768788782; c=relaxed/simple;
	bh=b66rLIBiGJ7BwzeJ7NBVrWX0pCkBrP5xqopu/zP1v50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsdDHY1kbVAgQAMN3JqiWITA13VID2Phwh2jN/tyAjSRCMM093HWH8TY8REHkFMTSyWKCojxltFWt0h7qx67mrghX9MhZSoXkTNQCnwHrAEO5xeqOmlRt8xc/revjo6K9e0UaLo4cm8UaEM16NnA5hw+fE+XlR3EcIK63nruHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5y/nhA0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5y/nhA0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51DFD80E17
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QCa8LI-582ou for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jan 2026 02:13:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 31C8480D8A
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31C8480D8A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V5y/nhA0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 31C8480D8A
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768788777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DbdTN7pF/npZpXEyk9hZ7zUr+KhydCm72fooIP7+FI=;
	b=V5y/nhA0zN+latSCNmyQQWsRafjD0QgIHaCriIEo0futq3o8BwA5XJzoeLa8PHH2i5X9fy
	nSLYJsgqBfV+7k8YfocNEiM6ZLEUYp2frROSx4u7Gcmz6DhxXf3caW3eJ9ocwVkfOXFSq5
	gvowaPe5XG8Q4JS/4ybDvkc3VDuZ9eI=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-KxaBKdnGNX-94uz_sB4_aw-1; Sun, 18 Jan 2026 21:12:56 -0500
X-MC-Unique: KxaBKdnGNX-94uz_sB4_aw-1
X-Mimecast-MFC-AGG-ID: KxaBKdnGNX-94uz_sB4_aw_1768788775
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5ee83da1811so10673385137.0
        for <virtualization@lists.linux-foundation.org>; Sun, 18 Jan 2026 18:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768788775; x=1769393575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DbdTN7pF/npZpXEyk9hZ7zUr+KhydCm72fooIP7+FI=;
        b=k0ks8nhwfU6/jk5/4IMzOfH1hFWaqmIzXEAafuJgZwgKGJd2McrUSbSdD8yefbR59s
         74wzvvQsnoOt3WnqidX6XD799pMBc2013o5lrrczjvWvZeBtQX6lkTxITBECJXaOYeid
         zpMBfMvm9RdtAoPRyH+Gu0p+v6OT+qwII01ZjLYdyKH5JMMW041WodY/N8xgEJ/yX2yv
         Pbd2fsUZ5AzF09Woreu3OAe/qO4CAvBKIxcbVCHZ8LYqGe0BGiTs+r19Wq4Be3NQ4Bwn
         N7l+tRuyjoXRqai+ucC4r3e3TZfS39QzaL/J1SLGf+/CBTV+SidXxhwUSD5DD5U4g7HL
         uMhw==
X-Forwarded-Encrypted: i=1; AJvYcCUGAK/UB9wtC3+OF9YFfCJXtv20XQFnTo1yF/DEUbF4esXCrabmSLQQWoO8+p89xMjGXIDJwBtLsE91LWKPKw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy1+XnqMF5MrTH3xXgYQ7dd65giB/NRpFzyz+f/qI5aDPhBVXRs
	D5IHy279ZqUwIioyIY6rOv/iuM/dQn+HXKbKefbT5LSjr1REcKV47m1RKBYjYH8GXSP1EI4whT0
	+TzPMuWqapU6H/rSB2SWraR/MSQRsdVWZo+1RDCKCbzUvT37Jlp0Ass5HW3xSgbWl9/bCCzJbyw
	gTf5fi8077mZk58oYIrnrBCi8ubutiXyYRJmuYdAwvIfDkEIPkezO+5L6rEw==
X-Gm-Gg: AY/fxX6XzxFF8nUgZYyQ3MzObKMF0fXlGdD4YPxcUwXKUnusBpRMAfkP9jq0ks3AOKK
	OW83N4ugTZI0uFe+hxhdDLwvOC2KDOqRrjFsZ0gl30tAjOZdD3AvRsi7gV/irZP9pBTngEHcT8i
	u2lm9gDIN6eiQHcrs7bKyRMtNmTOHnwdG0Ev8sY70VVd1W90vXKW0v4zFKduaPuIxPYJM=
X-Received: by 2002:a05:6102:3f4a:b0:5dd:b0e6:c4cb with SMTP id ada2fe7eead31-5f1a4d8d33amr3253347137.9.1768788775613;
        Sun, 18 Jan 2026 18:12:55 -0800 (PST)
X-Received: by 2002:a05:6102:3f4a:b0:5dd:b0e6:c4cb with SMTP id
 ada2fe7eead31-5f1a4d8d33amr3253337137.9.1768788775314; Sun, 18 Jan 2026
 18:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251229071614.779621-1-lulu@redhat.com> <09178761-3ff7-4c6d-bdf4-cbf16531d71e@nvidia.com>
In-Reply-To: <09178761-3ff7-4c6d-bdf4-cbf16531d71e@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 19 Jan 2026 10:12:16 +0800
X-Gm-Features: AZwV_Qizwj1EMviepQfrW3r56R4fRHe-HzedcvdMLGJBJgU0YPalMF59laPuV2I
Message-ID: <CACLfguWDQ-NqNV6w2BAGQS_fA0+ADhVVOJbzDC+rt4u8Trhu3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vdpa/mlx5: update mlx_features with driver state check
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6jdPjOfJBdDem3NCu0jbj4FsEveRM_knMVIpU9PCTWE_1768788775
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 8:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
> Hi Cindy,
>
> Thanks for your patch!
>
> On 29.12.25 08:16, Cindy Lu wrote:
> > Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> > feature bit is properly set only when the device is not yet in
> > the DRIVER_OK (running) state.
> >
> > This makes the MAC address visible in the output of:
> >
> >  vdpa dev config show -jp
> >
> > when the device is created without an initial MAC address.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Having a cover letter with the summary, history and links series would
> make the review process easier.
>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index ddaa1366704b..6e42bae7c9a1 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4049,7 +4049,7 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
> >       struct mlx5_vdpa_dev *mvdev;
> >       struct mlx5_vdpa_net *ndev;
> >       struct mlx5_core_dev *mdev;
> > -     int err =3D -EOPNOTSUPP;
> > +     int err =3D 0;
> >
> >       mvdev =3D to_mvdev(dev);
> >       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > @@ -4057,13 +4057,22 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >       config =3D &ndev->config;
> >
> >       down_write(&ndev->reslock);
> > -     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +
> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +                     ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_=
F_MAC);
> > +             } else {
> > +                     mlx5_vdpa_warn(mvdev, "device running, skip updat=
ing MAC\n");
> > +                     err =3D -EBUSY;
> > +                     goto out;
> > +             }
> >               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> >               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> >               if (!err)
> >                       ether_addr_copy(config->mac, add_config->net.mac)=
;
> >       }
> >
> > +out:
> >       up_write(&ndev->reslock);
> >       return err;
> >  }
> The patch itself makes sense. For it you can add:
>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>
Thanks Dragos, will add this
> Thanks,
> Dragos
>

