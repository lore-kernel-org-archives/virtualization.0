Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75A2367DC
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768788861; cv=none; b=RK/nqRmDJLgKyVDtPoGrdUQ7eKQtlgWHQorCns9fL9F/TE4t0mB4uH0oR8eiJiEBXjl0i62qq7ZwopCW0/0jScoX1WyC6zAwQiU2yL1RB60f8M2KQb0v/Db7q7vqhJ+QG3c1hN1WKF9ke2FwJVlBGCaFIiuxyLzkEMSCyFro43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768788861; c=relaxed/simple;
	bh=4o+ytm+NwAqT+t1h0w8n2FMlwVkwhJ1u77717IS2+8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBPg6AqbCWpBx73+BcPRw/OdNtglo7cD5P93/Fo/m9sHcmYaa0Rz3s5SBi6/M5rHgqC+bdnBWnsvGNn5cnXzhhtCtdhcfa5gNbPjZ2nckalcxI0uaXaMaDAJ99V0rErR74tGkKIh7640J8vV28lXAhszdFcQyPgZeTveKWOLUG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxRiJ4B5; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxRiJ4B5"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A4C040644
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cJc9se_LMLr3 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jan 2026 02:14:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9261B4063A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9261B4063A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KxRiJ4B5
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9261B4063A
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768788857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjfoSgBxYJjHbPNyjU0OdP1JPk3R3MOJGd5edMGnFbs=;
	b=KxRiJ4B5RkZItp53JvyXIKndAHZldDWv0uyVUQMc1qd5QIAD3F1BCbEUypPMftLC65YpMc
	hRuIT9tWWK0A208+aDsQ4paSPIPU8iGWT8W8ZrqIiAmbEoTYZtdVaZri0zx9w495iRq1YL
	6r8G3b1ymqOjVz8zjqus6FnnrVFBrac=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-DHrunM1bMoq6TZyVwD1vbQ-1; Sun, 18 Jan 2026 21:14:15 -0500
X-MC-Unique: DHrunM1bMoq6TZyVwD1vbQ-1
X-Mimecast-MFC-AGG-ID: DHrunM1bMoq6TZyVwD1vbQ_1768788855
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-93f568048ccso4705006241.2
        for <virtualization@lists.linux-foundation.org>; Sun, 18 Jan 2026 18:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768788855; x=1769393655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PjfoSgBxYJjHbPNyjU0OdP1JPk3R3MOJGd5edMGnFbs=;
        b=vNn+1tDjSr8GfnF3XbAiwWva+yHf2ghyz3CCVt9Vn3WKMEOw4hEMrA4qbxbFuIcIM1
         3k2kZ4i5YPTs4+ZAFeHdN2eKTWgMEpeKy3Cw4WHTQ0BS8mSvMnJ2C1qfRVHsEZakNjA+
         i4xQkISR2PR7/mOB1aVuupN0lTA+t4JLuDpy+n3LdLbU4DiA0er63uEHD3KH4ROheDCi
         f9S+JPcOdPrEZGD90lsNrpwh8ivAlxjCG/TnSSpjQxnfTCh5iJjgJ96EiwwwK2jxuRdD
         3A4OoRspe4s0ubpeMmm+vUXDSU94bxsrGN6tHNHsfSa5xI4NiQPTSKGtyEa3jeRTAep6
         2SQA==
X-Forwarded-Encrypted: i=1; AJvYcCWoL7Ig88KgPVz+i5wPKE0BeLIo0S1KU9UcXQ6qv07kUVNQpklp7f3INUJICkp/NxQ3iOLdnsolKeV9U17E2Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy9iwY7sAOc4hmOslgi93JN3gOgc5t1XfxlLpanjDrzRx8iQ2Ct
	fLSurP5aLU8og/enRawKcjzYFUR7YUYcDVCFiLWFGI9H/IZStnMTpcnaLmV4lOrPIpG0pAOopgY
	uZ3mzh7Dr8k94LVTU3BNyJZ3a5BaPmqe2R+/RELer6TfuAKMfpXxn/4QqXEmAk4U79PxuERtPua
	5dh3bfHQG9U30IaSyzGYpOGqOn2dHjsok7JS2WBfGlSObZfxeAbv+MNJeC+Q==
X-Gm-Gg: AY/fxX5298bBC+K2LfRfhad7IJwvD2Yh2KavlWtxjAlYINKQhUWdCMRp/xsUi9IvNWf
	Dvgo3BdOyVYM/XDfcjJcLx5zeALbB6NlhGIEG12PLS/84L3L/4AyY5AqumbY7Bo/wPf4KkYfeF2
	1/wpsXRGNcsff/50adwk0nr5FFQ1Gx28ywOfvjCX1/SFD6O2gH6+lEGVbmeZljFVVt5tI=
X-Received: by 2002:a05:6102:950:b0:5db:2b4d:f1ee with SMTP id ada2fe7eead31-5f1a53b1e88mr2915427137.17.1768788854977;
        Sun, 18 Jan 2026 18:14:14 -0800 (PST)
X-Received: by 2002:a05:6102:950:b0:5db:2b4d:f1ee with SMTP id
 ada2fe7eead31-5f1a53b1e88mr2915424137.17.1768788854629; Sun, 18 Jan 2026
 18:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251229071614.779621-1-lulu@redhat.com> <20251229071614.779621-3-lulu@redhat.com>
 <3fa838af-4eec-441c-8739-020990d1826d@nvidia.com>
In-Reply-To: <3fa838af-4eec-441c-8739-020990d1826d@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 19 Jan 2026 10:13:36 +0800
X-Gm-Features: AZwV_Qi7JTwzpifTzUsT3WZaxjMIWG7XKyTKlEHP1wda51mvxBoFRj7TX0oSS3w
Message-ID: <CACLfguUNRhc1nttaJOAdp-QGxbrySTT-yDRMCuyntEbj0Dpjzw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QIiHhoedimDwKSxjEkcFCEDkhWA2cbJkviC62AvpCjk_1768788855
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 8:14=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 29.12.25 08:16, Cindy Lu wrote:
> > Improve MAC address handling in mlx5_vdpa_set_attr() to ensure that
> > old MAC entries are properly removed from the MPFS table before
> > adding a new one. The new MAC address is then added to both the MPFS
> > and VLAN tables.
> >
> > This change fixes an issue where the updated MAC address would not
> > take effect until QEMU was rebooted.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index c87e6395b060..a75788ace401 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4055,7 +4055,6 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
> >  static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdp=
a_device *dev,
> >                             const struct vdpa_dev_set_config *add_confi=
g)
> >  {
> > -     struct virtio_net_config *config;
> >       struct mlx5_core_dev *pfmdev;
> >       struct mlx5_vdpa_dev *mvdev;
> >       struct mlx5_vdpa_net *ndev;
> > @@ -4065,7 +4064,6 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
> >       mvdev =3D to_mvdev(dev);
> >       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >       mdev =3D mvdev->mdev;
> > -     config =3D &ndev->config;
> >
> >       down_write(&ndev->reslock);
> >
> > @@ -4078,9 +4076,7 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
> >                       goto out;
> >               }
> >               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > -             err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > -             if (!err)
> > -                     ether_addr_copy(config->mac, add_config->net.mac)=
;
> > +             err =3D mlx5_vdpa_change_new_mac(ndev, pfmdev, (u8 *)add_=
config->net.mac);
> >       }
> >
> >  out:
>
> Thanks for your patch. It looks much better like this.
>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>
Thanks Dragos
> Thanks,
> Dragos
>

