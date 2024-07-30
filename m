Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C33944E
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302960; cv=none; b=P+wTmn8z8AUwyfu5MUtAtYqu8yo0C2PiJbTlR4RS5d/47w6C5I4P+jxQv7s3StLkDQOnJ4i2BvDoljyIhYDDTgxv+Fp3x/CpEObjriK1ehcO8oqqJnEymwOem7TcLRRAAHDtzli4xf41q//RSAJDbIIk4wpTc664l2+RgMy8OQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302960; c=relaxed/simple;
	bh=6V2Eg0+AV6C5wE2oxMFjIOKPbugqLyq7K0dfTJQYrkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8h2KcIdFSrA0Q+wz7gqAlc67uJkISQVB/yXXliK+zZ17eZorP6q6HscVVlrfRm0PbvBpHyuthAVVpcC497vAdRanlgWNRvBGRb8z4eONpPv9heas5LPnicWwy77OE1PAxjmo7bE12nK22gfjjIcdEbnsgZ0JhPrNLJjtfqkSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjbpV/ti; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjbpV/ti"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A02D4608E9
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBsGisdJnwZm for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jul 2024 01:29:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CD1D5608E8
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD1D5608E8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjbpV/ti
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD1D5608E8
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7worZc1WoS5CXw2Mg6pRcBJ9Od3yKPnwBVoMm0OgZU=;
	b=cjbpV/tiZGvODTayr3j4CoXyfisOtLhAP72sMGUo6+kGpIwVwOc9SQ1TnPi28SaWdqh6qP
	RKLg4V4YKyOG9CDt8v4sIG5mbwQQ64bdVrlhBpdTXjjqU/u4CKj3xQjzvtJI8ZVJGytuLB
	CiudeAMWH9FwWwp3SR8vec/kj17foRY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-CfV6ljkNPL-iePgecMozMQ-1; Mon, 29 Jul 2024 21:29:14 -0400
X-MC-Unique: CfV6ljkNPL-iePgecMozMQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-58bd84067fdso3570134a12.0
        for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 18:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302953; x=1722907753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7worZc1WoS5CXw2Mg6pRcBJ9Od3yKPnwBVoMm0OgZU=;
        b=Re+ycz6MIbxiEtQz/VyZMFGLs0p7aJlXAFHjVCOhboZ9S8JwORJpRRws+Tzy3ZNd1n
         P36RInVL/9RvEzwD1p/PE4mNbuMXSBbJWh8GMK9ABggW9nwnXP1wc50/GKdiBzs5HS7d
         F9RdyGRda80vh4RSD7FkZVhNaEltcQ2u3c73FHEQPmLK4ChMCexoUakSqwnbhrrZXMh/
         NAFnsMfT6hUNBEm+QezUCDaZbCPC/H5ZSreLJPnZ/wY8ScYiKR50y2aPbX3awepA4pdx
         ESjxu7jrBqgjDWXfjO2Ey6yYKG8uGom4Nkj54ri+vMV9lBwbEPO+o9ZKvDZ8RL7/+1+k
         5dMA==
X-Forwarded-Encrypted: i=1; AJvYcCU7zD6pbvM9v6/7Tps9NMvfpitjMyk00jbHR86Tv0ZswlP7PgPZjIWX8MUXgX59+qb+VfFBGMjPhFOcXAqV3I4DXP0fDH8aEM/pXXB9ynKHO9M8IEI6dI7duQ==
X-Gm-Message-State: AOJu0YyWIAZ4cwzAxT8MBPFzJPcFtZ1140CyDZj+t04LJnWRdzmPTWL8
	HMQ25/zOrMcb+tFgDyPFTNoB0zwQxK+C4AKw1/koCxDdx80IPl7DCBLIBql5+oXzRAocM0gyMU9
	y9tte8CAg7Xv691sZ9BhuvzB/XUhnrkrx3tXmyHw/cMlo3Ll3O7iN/rc9RhVb5DTUJ07C1wMJu8
	boBOuMdMs79F1iV7nMmhIzQpQPWOgQ8suihH0wzy0UTmv7JmGiwpL5kg==
X-Received: by 2002:a50:aadb:0:b0:5a3:3b44:ae00 with SMTP id 4fb4d7f45d1cf-5b020ea8945mr5859944a12.20.1722302953771;
        Mon, 29 Jul 2024 18:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLuOO7m5Qr5P8MSrVRUXIug1lSaQ0AKlobOKhsrzfg5Qpeu0JjwO/i2NWbI/Rn9Tgkhkq9CAnEijp0eyxafS0=
X-Received: by 2002:a50:aadb:0:b0:5a3:3b44:ae00 with SMTP id
 4fb4d7f45d1cf-5b020ea8945mr5859930a12.20.1722302953410; Mon, 29 Jul 2024
 18:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-4-lulu@redhat.com>
 <aa0ffd28-bfb8-4b25-8730-a522861bca98@lunn.ch>
In-Reply-To: <aa0ffd28-bfb8-4b25-8730-a522861bca98@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:28:36 +0800
Message-ID: <CACLfguWt1Uw=tpKCViz9+Hv-s3EvuAc6YeHP3yWYtg6tnuC9Hg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] vdpa/mlx5: Add the support of set mac address
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 03:16, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdp=
a_device *dev,
> > +                           const struct vdpa_dev_set_config *add_confi=
g)
> > +{
> > +     struct virtio_net_config *config;
> > +     struct mlx5_core_dev *pfmdev;
> > +     struct mlx5_vdpa_dev *mvdev;
> > +     struct mlx5_vdpa_net *ndev;
> > +     struct mlx5_core_dev *mdev;
> > +     int err =3D -EINVAL;
>
> I would say this should also be EOPNOTSUPP.
>
sure=EF=BC=8C will change this
Thanks
cindy
> > +
> > +     mvdev =3D to_mvdev(dev);
> > +     ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +     mdev =3D mvdev->mdev;
> > +     config =3D &ndev->config;
> > +
> > +     down_write(&ndev->reslock);
> > +     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > +             err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +             if (!err)
> > +                     ether_addr_copy(config->mac, add_config->net.mac)=
;
> > +     }
> > +
> > +     up_write(&ndev->reslock);
> > +     return err;
>
>
>     Andrew
>
> ---
> pw-bot: cr
>

