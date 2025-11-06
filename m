Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3E271476
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415300; cv=none; b=VTFSoOxNrMytEDaasBJXA8A1sZIciDv78myiQMsfFPBqv+Jr0htXkNYL1S62CgFCg7tP+wgwLsVelz1WM8n0KnfTBINvWTBZQ3LjsqBSV+f5w7DozrM8Pnyk0Qb7N7Qtp4dNWNk5XZYjxHSedkOQ62hiCmSRNQeFcTS4gqN8n/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415300; c=relaxed/simple;
	bh=utxQjgvi47PYdkifSJDqv0O9qHP5x/EM/RYN8U0WxeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4DNQZxZ0r6Wx347V4jfU/niViAYUrt2PUaYSkoO+Li9fRmM/U5KtBTbcknXfOmPIZhB8YJbu6q/im7zQZ5IJAWqOhqxK1v6sAUAClnO5eDYgdqug8AL4CqbB+4XChfzbVctY4H873Uw0w/b1/h4EneZ5DjCHjZZm/jArUXHxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YC98hxXi; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC98hxXi"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7F946128E
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:48:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XjZ94KrAbQ8M for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Nov 2025 07:48:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AD85661279
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD85661279
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YC98hxXi
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD85661279
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762415296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnJC3i9GUtLtZtx9qzqc96Wn1X4xgc/30U+djyUk6hY=;
	b=YC98hxXi13ZwxUP/4mZkF4pz4GyX/Ey0sXHq75DJoMB/Jicb8SyZZ3zdNGD/HAzv2fpFCh
	IXA7RqrGjvgsYV0f45uDQasKeCRikYPUOTCA0brd08iDbjt4qIeBImmeE/XG5DhA52KCIk
	ZBqxod/YDrttSxTsGX0REF2I5JbvYcA=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-v9IQkHOmMFGfbwI-s2BDAw-1; Thu, 06 Nov 2025 02:48:15 -0500
X-MC-Unique: v9IQkHOmMFGfbwI-s2BDAw-1
X-Mimecast-MFC-AGG-ID: v9IQkHOmMFGfbwI-s2BDAw_1762415294
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5dd83e15408so54039137.3
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Nov 2025 23:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415294; x=1763020094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnJC3i9GUtLtZtx9qzqc96Wn1X4xgc/30U+djyUk6hY=;
        b=ebm//yZbJlFz2xDgnGubXofQfjR2xVf53P7Sr1xEiJbeVqKtQYH+D322103e+8qk4h
         ZjhAWkCcgMBOXJ072YIzmtJE7G1ZJgfPoxOd810u8bDQTpTkMoiogCTYTWBf4wUoII0W
         jOW4r+2s5j935bQDd/R9RqdkGEr6+wFB4q6NZClrFXWbarwvZ1pwvVjKU2zyE4P9C0gu
         dfo9GDnkKkKPUanqUmjvKCMythjRJ4HDubpmm7JtiiCHbj7tgp0zs1eXrQ04qJ7sGvtR
         sRhvdHjLL6305cxjGndCViSDJ/xWlgd51aS4BWiASCfXSAuTZxi9OrJJMz1m7XHEOjYC
         pwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbx3mjOza+6V8vakVYTrww5wLatI3C6+YMe3qIlVUKpNbyT7yQYoxUs5NsXt6/BOOmEilk2GJw/MsM1B/+JQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwuuzJBj3jIT3NxA1pYiT0RxuBUyIF7IdhONY8ZwFZHGBZ3Zcr5
	dbLnsfxg0l6Ra7iai5D87iOUboaibTfYgkdUWdHZUit/TyvUOeUYwqpmEafyPL9mPaZXU81d/Rb
	UW+wxkA5MJZgqMXXpiJV3ETF+h5JUc0DinfqT/jrXByx5wTpfp3FSSN7dbrjzhPgC4eUjl/01m0
	DiJ4n0OiNGoTXhjn0sfg/Q4Fgv056ylpkIbLkGdtNEGSSUl5xmN8QLIv9ugw==
X-Gm-Gg: ASbGncvjnBxpNiVo1FXOIctnObJI6nsg261RQHb6W0/rUquWJUJ99BuE+d0B1aORAuI
	zRm8m4k3psAQdkgoEFml2rydjd3acSJP9wojU4QujXkAYVi/wfTHnsBJJGHeFq/E6W7zKfeHi+5
	m10sD5Su6wnwo/gcO0gGa/wd10VpA4u0Uo4PG1zInC2JGqcn6euDT9LpQD
X-Received: by 2002:a05:6102:5490:b0:5dc:51c5:e3c7 with SMTP id ada2fe7eead31-5dd894c35ffmr2105515137.26.1762415294528;
        Wed, 05 Nov 2025 23:48:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaHvOwp3yRcJdiplcZBh+ZekqeMFt4UrhXQvHFpGLbTZPXBEUYvgOe0WgV7DfP1t9bX9QOMxsHfqFGlqrS6Ds=
X-Received: by 2002:a05:6102:5490:b0:5dc:51c5:e3c7 with SMTP id
 ada2fe7eead31-5dd894c35ffmr2105504137.26.1762415294061; Wed, 05 Nov 2025
 23:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <20251105080151.1115698-2-lulu@redhat.com>
 <qfswutrrnmk6cksyamjx4ywv4kkxcb76vfqqszodzo7ltze5r6@c2dsseiez4ik>
In-Reply-To: <qfswutrrnmk6cksyamjx4ywv4kkxcb76vfqqszodzo7ltze5r6@c2dsseiez4ik>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 6 Nov 2025 15:47:31 +0800
X-Gm-Features: AWmQ_bmq49ZgsPINEs5Pimr0WRd1izcH6HyxicuyWqewO5LqB7r_2LjC3IeC1oE
Message-ID: <CACLfguUL39gt7zoUzsT_vypJYSAqcRBkFX-w_wtWrrFrx1aLNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -SWUiGwJwcPaZzUt-4OyZD1gEwknyh6rz-oXp21Z6Tw_1762415294
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:13=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Wed, Nov 05, 2025 at 04:01:42PM +0800, Cindy Lu wrote:
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
> Can you remind me how you provision the MAC address throug .set_attr()
> instead ofa the CVQ route?
>
this mac address is set from vdpa tool,such as
vdpa dev set name vdpa0 mac 00:11:22:33:44:01

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
> >       down_write(&ndev->reslock);
> >       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> >               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > -             err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > -             if (!err)
> > +             if (!is_zero_ether_addr(ndev->config.mac)) {
> > +                     if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) =
{
> > +                             mlx5_vdpa_warn(mvdev,"failed to delete ol=
d MAC %pM from MPFS table\n",
> > +                                     ndev->config.mac);
> > +                     }
> > +             }
> > +             err =3D mlx5_mpfs_add_mac(pfmdev, (u8 *)add_config->net.m=
ac);
> > +             if (!err) {
> > +                     mac_vlan_del(ndev, config->mac, 0, false);
> >                       ether_addr_copy(config->mac, add_config->net.mac)=
;
> > +             } else {
> > +                     mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM t=
o MPFS table\n",
> > +                             (u8 *)add_config->net.mac);
> > +                     up_write(&ndev->reslock);
> > +                     return err;
> > +             }
> Code reorg suggestion for this block:
> err =3D mlx5_mpfs_add_mac();
> if (err) {
>         warn();
>         return err;
> }
>
> mac_vlan_del();
> ether_addr_copy();
>
> >       }
> > +     if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
> > +             mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to vlan t=
able\n",
> > +                            (u8 *)add_config->net.mac);
> >
> Have you considered factoring out the MAC changing code from
> hanle_ctrl_mac() into a function and using it here? Most of the
> operations are the same.
>
>
Thanks, that=E2=80=99s a good point. I=E2=80=99ll update the code.
> Thanks,
> Dragos
>

