Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFA27713
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510653; cv=none; b=nrLIWoUIS95dP52K8rBGGEBTQEV7CVZuPjUXpziCoAEA294GIzSuiDjYGwkIgs7w/bLMXUwq5seIDi338k2RO/l72kgUZUCJECLslZ1ziO/mtw15L7KSxhx/6m7krd/xxCfFxiO7k4QaN4qzxbEVVCBr8jUihqC0QW5riGQQ3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510653; c=relaxed/simple;
	bh=R6uhElAMm4FTpUU4vkd99nDcZrma70iZDg9k9g3ocDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY4es1jBNHdJFYKquTeeUJTb3lmDH3iIhczObIzOj/YI3U6eN3Zavw9BdVfwjLnUeaCmQHmAbyjqelgEhhoSZqgek5lHE3Z49A0IVDpwmLnagtbRDiXXSGwBlcupAXrgP27k8HOu4jpZYE5e750wfNx1Q1FPn8P+ElldMNuXWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKyqaQzW; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKyqaQzW"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C1E960E81
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:37:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tCNRcwlI1J3L for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 07:37:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4ABF660A8A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4ABF660A8A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKyqaQzW
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4ABF660A8A
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A49qXoXkEsMzgDh5I6lFSA4XYzFZMk+NCFiOV4UimaA=;
	b=fKyqaQzW21EAsASSVBdhHZfGPwZH0BGQ/EBrclnEHSawjjVob5+w6x7xaC4CEfEeIyUMa3
	M9NJgGVrnsPhQxO8xFhx/RnmRCEzjkmuSqpc/T0n3ch1dGbQ3LuVyMnKEnFqyQOdXbb8c/
	O/8d4e1NhxT4s8LHzgNYaJXvcRIRz24=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-YlVqtGUkMK27O86_SD0WHg-1; Tue, 09 Jul 2024 03:37:27 -0400
X-MC-Unique: YlVqtGUkMK27O86_SD0WHg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-58cd7a95dabso2224942a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 00:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510646; x=1721115446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A49qXoXkEsMzgDh5I6lFSA4XYzFZMk+NCFiOV4UimaA=;
        b=ScPDcEHuhT+qR6m6pZhKxR0qsy2ZJHjqLG/Q8PKUzGhRyUpXmMbbWNWn6SLiBE3TNm
         J9FO5ZtIhj5B1Bm/sclev3htjITpqB6PCjr1KqCZOG81BFRRgYOTQszZDbCZIldje1Ct
         LXVFUFbdGnyVizlF0ARzqqZDvSJK5wLBYhlI+XCSnUjABmiUq9ri+XQPdJeu9arhKO/c
         SD/bmSP7ZqQYTQ64tVD1GTo7a7KH4fNImqHcE3qXO8aa7LOi+Jw0SJuJU4ArToJ38VXn
         dPnzML4Fx+4L47VWZoEWCj7T01kUhoz90J5U+uIpCYLuOG+1IkPb49SmzMnsSJJx4/GI
         zdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaG4Vot/2xQHYfnB0xP+I6HHc/w9ONh2YB/GfR7oyHEXxuKMQBxQiJGk2t+fPJZFX5W8YmzIRyxzytG7OZmU6q6yODdlr9czoWSnBx+wOjemrrbnb2j1Im0w==
X-Gm-Message-State: AOJu0Ywj5LROW1wVgYkhoqcQNh34JUSD+y9J7BAI1JoUD7Ib0xunUFW5
	C0BrdD5kWxZZc5FspQgYkt1BKBHF0I/Q9j1JGHeIIplF6Gn2U7IubFWE1txAzUpErUCFr0AxPEU
	Sm3X/Vc94HRsliUVO1lijAmz6z41U1LNQp2ZhJPd5MYbhAiOdlPRsmdb7NJQXqME1JjDsuXE3cD
	e8geXjwsVZdCKJyIBSc+QUr0ely8hT2fykESlyTKmjQHgo2lSE81NQAg==
X-Received: by 2002:a05:6402:430b:b0:58c:3252:3ab8 with SMTP id 4fb4d7f45d1cf-594bcba83fcmr1671350a12.37.1720510645970;
        Tue, 09 Jul 2024 00:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvA5gcFgFWqNy3DfNk26q33q8PtgffuDdwkGspZQpCkB6LI+Z1lBCXYRy9/d//O/OXiMfXxo5/urdnIEt4WlE=
X-Received: by 2002:a05:6402:430b:b0:58c:3252:3ab8 with SMTP id
 4fb4d7f45d1cf-594bcba83fcmr1671317a12.37.1720510645548; Tue, 09 Jul 2024
 00:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708065549.89422-1-lulu@redhat.com> <34818d378285d011d0e7d73d497ef8d710861adc.camel@nvidia.com>
In-Reply-To: <34818d378285d011d0e7d73d497ef8d710861adc.camel@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:36:48 +0800
Message-ID: <CACLfguV5CXMs9AdWrN9a=st5PjUnT4B1bt2Uua=AYjuC0NwfNg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 15:27, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
> On Mon, 2024-07-08 at 14:55 +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 26ba7da6b410..f78701386690 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >       destroy_workqueue(wq);
> >       mgtdev->ndev =3D NULL;
> >  }
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *add_c=
onfig)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev =3D to_mvdev(dev);
> > +     struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_core_dev *mdev =3D mvdev->mdev;
> > +     struct virtio_net_config *config =3D &ndev->config;
> > +     int err;
> > +     struct mlx5_core_dev *pfmdev;
> > +
> You need to take the ndev->reslock.
>
thanks will change this
> > +     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             if (!is_zero_ether_addr(add_config->net.mac)) {
> > +                     memcpy(config->mac, add_config->net.mac, ETH_ALEN=
);
> I would do the memcpy after mlx5_mpfs_add_mac() was called successfully. =
This
> way the config gets changed only on success.
>
thanks Dragos=EF=BC=8C Will fix this
thanks
cindy
> > +                     pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev)=
);
> > +                     err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +                     if (err)
> > +                             return -1;
> > +             }
> > +     }
> > +     return 0;
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> >       .dev_add =3D mlx5_vdpa_dev_add,
> >       .dev_del =3D mlx5_vdpa_dev_del,
> > +     .dev_set_attr =3D mlx5_vdpa_set_attr_mac,
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
>
> Thanks,
> Dragos
>

