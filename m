Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96913AD20
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510512; cv=none; b=iUdAMhTI9vBuvIhSxrt82wciClUGftcjvRguBTtqlltbbddl9lDcRQc/VF9YZmOINKYFzvmqQgIGpL6H1SKb+4D8sRnkM6lf4Uh1NFHxIbgEdn6FXOkjxvIrlSMWEpGmGsM5KALmwi/gw28OUgVvlH4ikEy+kTRSSwuakU5iC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510512; c=relaxed/simple;
	bh=DdRhbICaef9j8HkGlMP5Bgg0eQtDwpCDC9yQaq+5/6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2hLgIl5AfWQkie8/CMtbeBVcBO4ol6T7IdCb4++NEm6VRTgfZH4gfVanricQpb+cfauoEqLhi6GtU1hrqskveLQpl3MwgZNyrurhqOwwWixzVO0OiWT9UE+dMg0jEJMD33HGHIn4ohB/0pqP8yT22t/0Ral6a24CuhQKoVDvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VerlCW4B; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VerlCW4B"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AFDD60A8A
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qXWodXcoU_V for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 07:35:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3881E607CE
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3881E607CE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VerlCW4B
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3881E607CE
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 07:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIqC2mqFe9C8xKJMg5ba5cK9RsFhYLPxtTQe6Ed06hU=;
	b=VerlCW4BpO2V6xM4rUWVeZktEk9+kwHOE9Wd291p773K2o0zg+LNqC3+WsUfyaqS1npD7K
	vThnoaJ980nTNJ2w9zeuGfQVkaYXE7pmPSMduFfZQUe1jvLrCl62qPrg5wN0s1FE134YVs
	57aBiVJZ1HC72N0jXsHDUOCpi4jNLxc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-l4QIWv7cOBOtTwpfZW3i3A-1; Tue, 09 Jul 2024 03:35:07 -0400
X-MC-Unique: l4QIWv7cOBOtTwpfZW3i3A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-58e847f01f7so4032470a12.1
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 00:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510506; x=1721115306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIqC2mqFe9C8xKJMg5ba5cK9RsFhYLPxtTQe6Ed06hU=;
        b=am38/f3ZKiHgyjTLmhU1oqhXvbywP6t9SIaxQ5DHuABsaa4XXb63KWvOqVe23nsQfl
         sPxFZ+UMvQ7POR0M5ShMNeK1aCdtGnTunvLL+Iupbb10LanlA0mVpQqro3krmcJtgJnw
         vaq3C7VKyBov8GWsdF+PabjxV1UtmoV1+cKE3YfVPeYRaaRvcN3kv3IDkstYD9Dkby9y
         h5AXz4ofQ4k4RrqfZXoF5k6034ba9wRvzzMeGCZnw2BFII4h9f4IjocjMf4hdQVXB0Oy
         w2sA3zQQja2gR9O0MNkEMWOvTfCdc2U1/qgr1rBwRtwsxb/Sa2GsA2bpMJvrsZZTOZDn
         hMww==
X-Forwarded-Encrypted: i=1; AJvYcCUQmXV4muRCEyX+s35Spk1uTYv0Xuw610KGF/+vU4ttM2EsRT3ejfpoJEUK8+1RtBSWFzUr+0MjybIF11bf7BS/iFpddtI3T4cuX4g+fz92x2e9Do+k1LljFA==
X-Gm-Message-State: AOJu0YwU2dWaPVcH9fxL5ut42WpqFV71foH2/cRy0Zg0gRYrNngF8Wgo
	PyZ+bmvj2QoC5pf/ELmaLAHvP3ROt8H9pkXCot4r3E9R9kDCUisElEPHP2ZE2yf0Xbph1lG7Xxy
	G6GFQWmBLZehmTMGZwLCVn4TwWwhhnD5lbEqaO51RtTgYX7uqKh3b/NExc5WGHbPnP29wRjqfPV
	ePveRSq7M1x0XteNS7M09dxDkd781R0bb3KKDMscn+gp6ifjQgiFIhCw==
X-Received: by 2002:a05:6402:2742:b0:57c:610a:6e7f with SMTP id 4fb4d7f45d1cf-594baf8719fmr1467713a12.11.1720510506316;
        Tue, 09 Jul 2024 00:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEprGNtKtwZjWwZDrHR9spCqEFHlNDxGO/hw7rYsSyBxth5QJJ9oylIOl12jUvsQu4A55DuFRtIjAqAaxCAus8=
X-Received: by 2002:a05:6402:2742:b0:57c:610a:6e7f with SMTP id
 4fb4d7f45d1cf-594baf8719fmr1467693a12.11.1720510505896; Tue, 09 Jul 2024
 00:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708065549.89422-1-lulu@redhat.com> <20240708072603-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240708072603-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:34:28 +0800
Message-ID: <CACLfguU2OakNJPO6pR6V7D4SV0-VvC=okqDcwutMPztTUweMZA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 19:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 08, 2024 at 02:55:49PM +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Is this on top of your other patchset?
>
yes, Will send a new version of these patch
Thanks
cindy
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 26ba7da6b410..f78701386690 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >       destroy_workqueue(wq);
> >       mgtdev->ndev = NULL;
> >  }
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *add_config)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_core_dev *mdev = mvdev->mdev;
> > +     struct virtio_net_config *config = &ndev->config;
> > +     int err;
> > +     struct mlx5_core_dev *pfmdev;
> > +
> > +     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             if (!is_zero_ether_addr(add_config->net.mac)) {
> > +                     memcpy(config->mac, add_config->net.mac, ETH_ALEN);
> > +                     pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> > +                     err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +                     if (err)
> > +                             return -1;
> > +             }
> > +     }
> > +     return 0;
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops = {
> >       .dev_add = mlx5_vdpa_dev_add,
> >       .dev_del = mlx5_vdpa_dev_del,
> > +     .dev_set_attr = mlx5_vdpa_set_attr_mac,
> >  };
> >
> >  static struct virtio_device_id id_table[] = {
> > --
> > 2.45.0
>

