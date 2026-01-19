Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E12367DC
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768788828; cv=none; b=KXD1hn0zCOg31YXBybUiBXukmfDIpMbiuIPRHtZEet+/Rp2bBU3DmcpGs6zo/PL8oyTi7JHinp7bty1toKVuc8BHWkBWb7e4ekLJMn5x0clTtXN/y6OufCCDlQY6zVrJtEtnIT3zeWdImOHmOEGBcT5m2UnOUpitMAdip1fN2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768788828; c=relaxed/simple;
	bh=90+tWTeSxgceKDw77gnujS5MZr4uRL5NZ/GtCzmhgqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avYsjoXqmqO4qX3rfVR0y7QNDbPLpyNHI0Da0E1qVfkaUJjzUqYQY7RyzZdjnpiZ3bmFb2L2w6CVbm8mW5Rk0zrsIrnjHIVc7uk3V28iM4xbFGj5S9M2aZ7KDdXBXsyKJ24TTy2iItL7RTPp/fHM+wmQokFmQ3xGdEq4xzVD87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7KhWxMn; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7KhWxMn"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6957540644
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FrYAGA_V64FT for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jan 2026 02:13:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 38DA44063A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38DA44063A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J7KhWxMn
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 38DA44063A
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 02:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768788824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oJ+aQGDfix+/xeXCCrELRf1tc5jPJ1TkK9gqm/2Sac=;
	b=J7KhWxMn2UiUk9ONgecpIcP8dOaCjUv8YSI6XefQZ3ywYUmYRPEVn+ufT+SsggMSrSSEzt
	WGx/CwaWPSMW1OWUg6Imo+U6ahvpaX9zdOetHVN3J614+/aQUkJPHVZXo/4ybNL+ZZ8D/t
	kC4xR5H5J1JZFeQNM7fzI+HyKqr28aA=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-BrtuAy1APHmuxKuRR1gGdQ-1; Sun, 18 Jan 2026 21:13:42 -0500
X-MC-Unique: BrtuAy1APHmuxKuRR1gGdQ-1
X-Mimecast-MFC-AGG-ID: BrtuAy1APHmuxKuRR1gGdQ_1768788822
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ec338650e0so9174603137.0
        for <virtualization@lists.linux-foundation.org>; Sun, 18 Jan 2026 18:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768788822; x=1769393622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3oJ+aQGDfix+/xeXCCrELRf1tc5jPJ1TkK9gqm/2Sac=;
        b=qBlkGYGworo/D6Oshso7ycyv2yjwglfT2wUv8b9BHc4DB1O6eYsh1j/s4OZqHISX5/
         QTbOcIWcvKxgFMG89NFl1TRmMTFLsxIMXdil2Zm6DzlvFHVpB2NTJGNqjCEdGG85SaOh
         9ftPpLmBVMCLTQW3c2D+l9YKxkOXo50fzcnn4543EaMmcFH8HhROBKCAdFFGaYXZhgRf
         OS9ynDpux3XMlNxb81J56+/VtfpyI7VztM7sQ4/hFbcElU6DXyES/k81GFK7jc9vg4rn
         fKpJgImj7yMWbqs+mOqBzqJq6PO9VTSID3uUsg1q7U1vErPMNW4q8JOiFtzwEp6/CCBi
         qZXA==
X-Forwarded-Encrypted: i=1; AJvYcCUrYpj6uCWLluP7Myom8jqIq5ogdVIVKT8QPmEGyFv+mTu3ZFvg0ZPjiWeJ0tWJNMYKL58R8dzM/bwAprVSwA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzorLeWrZp1gElnYOgRd2GmGUaY1OyPYKKF6HWgi7j0/J8YiLYS
	Pq88cWxwisfDBN20YVTHTgZmx2i7A+k0WIcC8CJtAyHXICyb+KMYhuvQakghsUNaEo/EIkNq0mo
	cIMl7mOYpPaw2yWfYWhoCi0UaLoskWg1qSymVAPAbZoltKj2TmupC/1+fyDBo7RdZ22InwwfsF7
	mcuY38a20F14WTvXGXcOUalSIAI58y3ddPbSexk5GSJYvAuYWoYoIjzAC4rQ==
X-Gm-Gg: AY/fxX6PRNESQ855G/UudBJxCpodFI3TNMiwLd/Sutiym5OX3qjWcU92yfLwKwqB/JA
	sQt1L/vEXNj++P5YXCWBaCSEv/evrckRYModQLXnTs3hu/TfVQoYSvZ1kfaAWngA+CU+hWdfYNx
	a3Ceol/WZhy+Rnrs9lbjQLJ7tdcj1IyEEG++bETEP72jLCM7E9pkhwgdTKOeW8DaL5OJk=
X-Received: by 2002:a05:6102:50a7:b0:5ef:2457:8011 with SMTP id ada2fe7eead31-5f1a7124942mr3346006137.21.1768788821856;
        Sun, 18 Jan 2026 18:13:41 -0800 (PST)
X-Received: by 2002:a05:6102:50a7:b0:5ef:2457:8011 with SMTP id
 ada2fe7eead31-5f1a7124942mr3346000137.21.1768788821517; Sun, 18 Jan 2026
 18:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251229071614.779621-1-lulu@redhat.com> <20251229071614.779621-2-lulu@redhat.com>
 <20260107122418.GB196631@kernel.org>
In-Reply-To: <20260107122418.GB196631@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 19 Jan 2026 10:13:03 +0800
X-Gm-Features: AZwV_Qhbj0k0tjvHGTYXVGhNvx3NEFWR7H8u6guiOq5dyRYKTF-BbKnWNZiRaSI
Message-ID: <CACLfguXp+bLbYTSvc7u+tKob92gBvarD6nBZ6h38MAKSwy-4Dw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vdpa/mlx5: reuse common function for MAC address updates
To: Simon Horman <horms@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, dtatulea@nvidia.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BImv6yGs9cPCTVpKgw2E0FuxQnOJtw7OzXr_I9p3HVc_1768788822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 8:32=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Dec 29, 2025 at 03:16:13PM +0800, Cindy Lu wrote:
> > Factor out MAC address update logic and reuse it from handle_ctrl_mac()=
.
> >
> > This ensures that old MAC entries are removed from the MPFS table
> > before adding a new one and that the forwarding rules are updated
> > accordingly. If updating the flow table fails, the original MAC and
> > rules are restored as much as possible to keep the software and
> > hardware state consistent.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 95 +++++++++++++++++--------------
> >  1 file changed, 53 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 6e42bae7c9a1..c87e6395b060 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2125,62 +2125,48 @@ static void teardown_steering(struct mlx5_vdpa_=
net *ndev)
> >       mlx5_destroy_flow_table(ndev->rxft);
> >  }
> >
> > -static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev=
, u8 cmd)
> > +static int mlx5_vdpa_change_new_mac(struct mlx5_vdpa_net *ndev,
> > +                                 struct mlx5_core_dev *pfmdev,
> > +                                 const u8 *new_mac)
> >  {
> > -     struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > -     struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> > -     virtio_net_ctrl_ack status =3D VIRTIO_NET_ERR;
> > -     struct mlx5_core_dev *pfmdev;
> > -     size_t read;
> > -     u8 mac[ETH_ALEN], mac_back[ETH_ALEN];
> > -
> > -     pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
> > -     switch (cmd) {
> > -     case VIRTIO_NET_CTRL_MAC_ADDR_SET:
> > -             read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (=
void *)mac, ETH_ALEN);
> > -             if (read !=3D ETH_ALEN)
> > -                     break;
> > -
> > -             if (!memcmp(ndev->config.mac, mac, 6)) {
> > -                     status =3D VIRTIO_NET_OK;
> > -                     break;
> > -             }
> > +     struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
> > +     u8 old_mac[ETH_ALEN];
> >
> > -             if (is_zero_ether_addr(mac))
> > -                     break;
> > +     if (is_zero_ether_addr(new_mac))
> > +             return -EINVAL;
> >
> > -             if (!is_zero_ether_addr(ndev->config.mac)) {
> > -                     if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) =
{
> > -                             mlx5_vdpa_warn(mvdev, "failed to delete o=
ld MAC %pM from MPFS table\n",
> > -                                            ndev->config.mac);
> > -                             break;
> > -                     }
> > +     if (!is_zero_ether_addr(ndev->config.mac)) {
> > +             if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
> > +                     mlx5_vdpa_warn(mvdev, "failed to delete old MAC %=
pM from MPFS table\n",
> > +                                    ndev->config.mac);
> > +                     return -EIO;
> >               }
> > +     }
> >
> > -             if (mlx5_mpfs_add_mac(pfmdev, mac)) {
> > -                     mlx5_vdpa_warn(mvdev, "failed to insert new MAC %=
pM into MPFS table\n",
> > -                                    mac);
> > -                     break;
> > -             }
> > +     if (mlx5_mpfs_add_mac(pfmdev, (u8 *)new_mac)) {
> > +             mlx5_vdpa_warn(mvdev, "failed to insert new MAC %pM into =
MPFS table\n",
> > +                            new_mac);
> > +             return -EIO;
> > +     }
> >
> >               /* backup the original mac address so that if failed to a=
dd the forward rules
> >                * we could restore it
> >                */
> > -             memcpy(mac_back, ndev->config.mac, ETH_ALEN);
> > +             memcpy(old_mac, ndev->config.mac, ETH_ALEN);
> >
> > -             memcpy(ndev->config.mac, mac, ETH_ALEN);
> > +             memcpy(ndev->config.mac, new_mac, ETH_ALEN);
>
> ...
>
> Hi Cindy,
>
> I realise that this makes the diffstat significantly more verbose.
> And hides material changes. So perhaps there is a nicer way to do this.
>
> But with the current arrangement of this patch, I think that
> the indentation from just above, until the end of this function
> needs to be updated.
>
> I.e. the following incremental patch on top of this one.
>
> This was flagged by Smatch.
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index c87e6395b060..c796f502b604 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2149,48 +2149,48 @@ static int mlx5_vdpa_change_new_mac(struct mlx5_v=
dpa_net *ndev,
>                 return -EIO;
>         }
>
> -               /* backup the original mac address so that if failed to a=
dd the forward rules
> -                * we could restore it
> -                */
> -               memcpy(old_mac, ndev->config.mac, ETH_ALEN);
> +       /* backup the original mac address so that if failed to add the f=
orward rules
> +        * we could restore it
> +        */
> +       memcpy(old_mac, ndev->config.mac, ETH_ALEN);
>
> -               memcpy(ndev->config.mac, new_mac, ETH_ALEN);
> +       memcpy(ndev->config.mac, new_mac, ETH_ALEN);
>
> -               /* Need recreate the flow table entry, so that the packet=
 could forward back
> -                */
> -               mac_vlan_del(ndev, old_mac, 0, false);
> +       /* Need recreate the flow table entry, so that the packet could f=
orward back
> +        */
> +       mac_vlan_del(ndev, old_mac, 0, false);
>
> -               if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
> -                       mlx5_vdpa_warn(mvdev, "failed to insert forward r=
ules, try to restore\n");
> +       if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
> +               mlx5_vdpa_warn(mvdev, "failed to insert forward rules, tr=
y to restore\n");
>
> -                       /* Although it hardly run here, we still need dou=
ble check */
> -                       if (is_zero_ether_addr(old_mac)) {
> -                               mlx5_vdpa_warn(mvdev, "restore mac failed=
: Original MAC is zero\n");
> -                               return -EIO;
> -                       }
> +               /* Although it hardly run here, we still need double chec=
k */
> +               if (is_zero_ether_addr(old_mac)) {
> +                       mlx5_vdpa_warn(mvdev, "restore mac failed: Origin=
al MAC is zero\n");
> +                       return -EIO;
> +               }
>
> -                       /* Try to restore original mac address to MFPS ta=
ble, and try to restore
> -                        * the forward rule entry.
> -                        */
> -                       if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) =
{
> -                               mlx5_vdpa_warn(mvdev, "restore mac failed=
: delete MAC %pM from MPFS table failed\n",
> -                                              ndev->config.mac);
> -                       }
> +               /* Try to restore original mac address to MFPS table, and=
 try to restore
> +                * the forward rule entry.
> +                */
> +               if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
> +                       mlx5_vdpa_warn(mvdev, "restore mac failed: delete=
 MAC %pM from MPFS table failed\n",
> +                                      ndev->config.mac);
> +               }
>
> -                       if (mlx5_mpfs_add_mac(pfmdev, old_mac)) {
> -                               mlx5_vdpa_warn(mvdev, "restore mac failed=
: insert old MAC %pM into MPFS table failed\n",
> -                                              old_mac);
> -                       }
> +               if (mlx5_mpfs_add_mac(pfmdev, old_mac)) {
> +                       mlx5_vdpa_warn(mvdev, "restore mac failed: insert=
 old MAC %pM into MPFS table failed\n",
> +                                      old_mac);
> +               }
>
> -                       memcpy(ndev->config.mac, old_mac, ETH_ALEN);
> +               memcpy(ndev->config.mac, old_mac, ETH_ALEN);
>
> -                       if (mac_vlan_add(ndev, ndev->config.mac, 0, false=
))
> -                               mlx5_vdpa_warn(mvdev, "restore forward ru=
les failed: insert forward rules failed\n");
> +               if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
> +                       mlx5_vdpa_warn(mvdev, "restore forward rules fail=
ed: insert forward rules failed\n");
>
> -                       return -EIO;
> -               }
> +               return -EIO;
> +       }
>
> -               return 0;
> +       return 0;
>  }
>
>  static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, =
u8 cmd)
>
Thanks Simon, will change this

