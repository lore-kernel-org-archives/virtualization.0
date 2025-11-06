Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C32F9DB2
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415979; cv=none; b=dE3i4MuIesnAvFqMin4u9YbiNveLp0lwsHx8uqq/rnEng7w374/+MxAIhH5FeP2jMwpVHi2fYHVMhWNQzIc0vMAi3fRSPRF3jSe1Q+bJsSd2h1SXfT12ikvSHMuL/05Hybb8riQPj9cOWUiguUg0E5HKOmNqH4xJS/NhKmMQNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415979; c=relaxed/simple;
	bh=+HFp5teyxBDg8jC+Iw/Ud9wGGwCABYXLJqBhAplJgPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2/FYkBSg653N64+veVEyiGEFOe7hLGnsJH2/EaElNGNOhox955je9tDCTxPQ9vODXQuqKeamjpnCwBvq1SbpIwfThaQap0nX36LQRutvd0mmjR2qDioE3wirYKYOSR8mco3scHMZwgAbFxyDhT6e1iX0ue5HnsNIGe02u4eUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7n9jRdD; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7n9jRdD"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A450D61474
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29cfCI8nrbCN for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Nov 2025 07:59:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A2C8661472
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2C8661472
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7n9jRdD
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2C8661472
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762415975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OQ1T7JKFRO66U5Rzh5RNwPuFMaB1j+5Hb1k3YmuMzw=;
	b=h7n9jRdDRJLTAjUkIF772ZH7P1QC170GJsO60rxy/wBQsN9lnXK1zhENEydI8sGtaFAvCM
	1pLOI2KHwfRDe8HllCGs20kxfF+OkjxmI979eidf1XTt1IgExHCU1C6oSvTZL0eKVFgw4s
	49CD2au71CybevIA34CQz2yWHYLUbCc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-m_AgZ1ThPxununVPcZjfFA-1; Thu, 06 Nov 2025 02:59:33 -0500
X-MC-Unique: m_AgZ1ThPxununVPcZjfFA-1
X-Mimecast-MFC-AGG-ID: m_AgZ1ThPxununVPcZjfFA_1762415973
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5db1ec1daa9so64230137.3
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Nov 2025 23:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415973; x=1763020773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OQ1T7JKFRO66U5Rzh5RNwPuFMaB1j+5Hb1k3YmuMzw=;
        b=MSizM4LnkJxZHpOaWUHXTGkPgH/s2sfrxGRbCAODnyaxjqPVLGIfgkkTsICfIKahE0
         RuIreBWzoOrgTAkrQkHJ7zdxgKo2xPfcSvdyO1C0jBseIFreuAhtH+HDLMZK5ARmVEl0
         iINrEaQGKwzjf7Fj7YCyeioMqVMayglLk3c0p61zeiW5KkLtSaWH9T7mgx7ATpqT997U
         pFYMzkCGvTPMdXzPlUbL4/mOvHSup1tR8SnfnjeUIWs/0weVNHF8qvHIvB4afwTsmm2L
         99GKdj94ws+LhYrrih8kyALaV5WCCEY6NhvYVqMcdHaAWyOpv8QVhLDjCQ6Q68ui7Qp4
         53sw==
X-Forwarded-Encrypted: i=1; AJvYcCWEOCBwqk7PPK9dtUs/ooEvd6gSde6R04l8p62m8MtfDLuC1HKqf29iMoB+extZL4GD2v9P5DK3TM3qTCFAQA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx8+9FhNFYIEUzbovC5/y4It5wWzOTonSHayTPp85SJPqaPMojy
	PiITitE0L8a3sYICDpfz03AXYlj2yeU9VJ6UOxMluyRwzlrdZOdcwCxQMpvCuTMBFCibUv5C37/
	VC+KYamJILpdWTt+HqpZZo1sBnmiZ9JyP4+UiH4tesTH97FxfrsQMf0yg2/d32L7vObWRX0Fjm5
	Bkafi6hzoaf04ygOg5EcHw0N+uP8aPY0PcuiV3mq0umyQvS2+JOh5qZzrgow==
X-Gm-Gg: ASbGncvf5caEQvEysWRsX1JPHDC8+lw998RfhttBFIkwfQDVY3Dccje2cv2/sZ79vlL
	53T5uHNsg6nVnGtEoORaDxy9WIbpe9b12XW6LWwdJjKT0MYhA6ZMbF6PIFSI20kod+D0F5h9rw2
	BldEC+ULo53/1sWbnuP56df+h04zugOx9Ewzi7b7KL9tbIwvQKYO53NgyR
X-Received: by 2002:a05:6102:2929:b0:5db:f9df:34de with SMTP id ada2fe7eead31-5dd8920ba8fmr1896823137.23.1762415972372;
        Wed, 05 Nov 2025 23:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3y+j0Qkz+bU++xXKWMhgu+xZDmAkoz+uj4iKjUkfpaG45KgV6Bd99eebvGDTo7Wl7cf1YQ7k40zBEV9g3T04=
X-Received: by 2002:a05:6102:2929:b0:5db:f9df:34de with SMTP id
 ada2fe7eead31-5dd8920ba8fmr1896812137.23.1762415972015; Wed, 05 Nov 2025
 23:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <20251105080151.1115698-2-lulu@redhat.com>
 <CACGkMEvdjE+bYxS5_XPEnKWR1sQBuq=6CAqjioto6enryKm8kw@mail.gmail.com>
In-Reply-To: <CACGkMEvdjE+bYxS5_XPEnKWR1sQBuq=6CAqjioto6enryKm8kw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 6 Nov 2025 15:58:52 +0800
X-Gm-Features: AWmQ_bn7aRMESoWH1MH-rtiOYr4zIjpmOWnGluH1naEda3Sb2UdEGholcLuo-pc
Message-ID: <CACLfguW7=HEETEcpYgb66V0+Frn8LYgvDkWo3-RfA7+e273Rxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Im3Ys3KsbOHQ0VbxBKlu7uiAx4VNWVmbhPuDGZzxohg_1762415973
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Nov 5, 2025 at 4:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Improve MAC address handling in mlx5_vdpa_set_attr() to ensure
> > that old MAC entries are properly removed from the MPFS table
> > before adding a new one. The new MAC address is then added to
> > both the MPFS and VLAN tables.
> >
> > Warnings are issued if deleting or adding a MAC entry fails, but
> > the function continues to execute in order to keep the configuration
> > as consistent as possible with the hardware state.
> >
> > This change fixes an issue where the updated MAC address would not
> > take effect until the qemu was rebooted
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index e38aa3a335fc..4bc39cb76268 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4067,10 +4067,26 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >         down_write(&ndev->reslock);
> >         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> >                 pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > -               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > -               if (!err)
> > +               if (!is_zero_ether_addr(ndev->config.mac)) {
> > +                       if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)=
) {
> > +                               mlx5_vdpa_warn(mvdev,"failed to delete =
old MAC %pM from MPFS table\n",
> > +                                       ndev->config.mac);
>
> Any reason we need to keep trying when we fail here?
>
sure will change this. i will reuse the code in hanle_ctrl_mac
> > +                       }
> > +               }
> > +               err =3D mlx5_mpfs_add_mac(pfmdev, (u8 *)add_config->net=
.mac);
> > +               if (!err) {
> > +                       mac_vlan_del(ndev, config->mac, 0, false);
> >                         ether_addr_copy(config->mac, add_config->net.ma=
c);
> > +               } else {
> > +                       mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM=
 to MPFS table\n",
> > +                               (u8 *)add_config->net.mac);
> > +                       up_write(&ndev->reslock);
> > +                       return err;
> > +               }
> >         }
> > +       if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
> > +               mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to vlan=
 table\n",
> > +                              (u8 *)add_config->net.mac);
> >
> >         up_write(&ndev->reslock);
> >         return err;
> > --
> > 2.45.0
> >
>
> Thanks
>

