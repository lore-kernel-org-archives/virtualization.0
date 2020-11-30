Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E78C64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 15:33:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A1D2076C
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 15:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qmq8j69y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A1D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C866E2270C;
	Mon, 30 Nov 2020 15:33:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L2TBrSoJIZ2L; Mon, 30 Nov 2020 15:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F048421080;
	Mon, 30 Nov 2020 15:33:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2491C0859;
	Mon, 30 Nov 2020 15:33:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA9BDC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 15:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AF4BB2270C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 15:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2uMlo9uVS2lB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 15:33:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id A439F21080
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606750387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LgmtIu6NywG32ioz0iysYLpbYawJ9kmk2cBjeIzMVD4=;
 b=Qmq8j69yTq+P1Ds3wiuyymfZmzxfSjN1HxHLKnXvI8GRDZ1PwPuQfalWe9Q8s8O5sieKaN
 1YYzFRambAfC0WDBDGWUh9HesY/o82y5P7yeu1AQNM7u04sLObnCPUmzBEJ0VzRo0ljQRV
 9W0B1sGzSqhtcXjH16+eiibSqLQwXVE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-FDYra9lNN1OlzhR3BMfxKA-1; Mon, 30 Nov 2020 10:33:05 -0500
X-MC-Unique: FDYra9lNN1OlzhR3BMfxKA-1
Received: by mail-wr1-f70.google.com with SMTP id p16so8562493wrx.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 07:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LgmtIu6NywG32ioz0iysYLpbYawJ9kmk2cBjeIzMVD4=;
 b=DlekCxGMdME9zGDXSosJuXO0p2JC3mvE8kdVkLS/vIMDK3mv7jyMiAVKRJbp4OJm9X
 kFn0kL8VoUr/OLx4ZJO8LKdWuckG9zQpw7kZfqu5o+/g1/F4Qi0C8XV20FrZNbDY9amX
 xuFTfW48OQqDz0JwywhXIpDSbDu1TbY9yXeXjRAJM0dvgd1KLvc5xhbNBtErsDWivT0K
 c8q8JuvF84ZUXOk/n9eWrDIbeIHLLpGaqTM8V1Tab8tRtrYq6Cmisi8MIrb0u407QGPx
 DR1apBYS4KTbVKLCQB899873kOtO7icNaM+tO+g4ibJIECRiFN1jhknBzTBzsdV/Zsmp
 EPVA==
X-Gm-Message-State: AOAM530x0f4yBcqVuJCvzRzJTMrcW+WFCrFX4klOR0Vdv3eKqrWq5sfH
 jmNNiUXvi2zvYn2NILM8I1p/fCZSUv1GwrEk5Ba88mVp/honcwjMakcajpQS3KgsjJBDQUfo6ku
 RSNNJO4rkqO6o4n7WlVrQqM+oxVCRnVOw17CKbegJ+A==
X-Received: by 2002:a5d:6805:: with SMTP id w5mr29233202wru.266.1606750383874; 
 Mon, 30 Nov 2020 07:33:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywMuYeSVYDjXV3EOxn3sApgn14cOXuE9z8SSQHXhUh2qp2qnZeHPucW8U3SaHg2j+lsQKsoA==
X-Received: by 2002:a5d:6805:: with SMTP id w5mr29233185wru.266.1606750383678; 
 Mon, 30 Nov 2020 07:33:03 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id r13sm22228346wrm.25.2020.11.30.07.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 07:33:02 -0800 (PST)
Date: Mon, 30 Nov 2020 10:33:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130103142-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > > generated MAC address.
> > > > > > >
> > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > >
> > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > with and without vdpa.
> > > > >
> > > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > > several instances of vdpa net devices and nic net devices.
> > > > >
> > > > > > Could you include a bit more description on the failure
> > > > > > mode?
> > > > >
> > > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > > MAC of the regular NIC implementation of mlx5_core.
> > > >
> > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > >
> > >
> > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > >
> > > > > > Is switching to a random mac for such an unusual
> > > > > > configuration really justified?
> > > > >
> > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > 1. To get the MAC address as was chosen by the user administering the
> > > > >    NIC. This should invoke the set_config callback. Unfortunately this
> > > > >    is not implemented yet.
> > > > >
> > > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > > >    can always override this random configuration.
> > > > >
> > > > > > It looks like changing a MAC could break some guests,
> > > > > > can it not?
> > > > > >
> > > > >
> > > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > > from steering point of view. I will post them here once other patches on
> > > > > which they depend will be merged.
> > > > >
> > > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > >
> > > > Could you be more explicit on the following points:
> > > > - which configuration is broken ATM (as in, two device have identical
> > > >   macs? any other issues)?
> > >
> > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > > It's not breaking anything yet is wrong. The random MAC address setting
> > > is required for the steering patches.
> >
> > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > dependency of a new feature.
> >
> > > > - why won't device MAC change from guest point of view?
> > > >
> > >
> > > It's lack of implementation in qemu as far as I know.
> >
> > Sorry not sure I understand. What's not implemented in QEMU?
> >
> HI Michael, there are some bug in qemu to set_config, this will fix in future,
> But this patch is still needed, because without this patch the mlx
> driver will give an 0 mac address to qemu
> and qemu will overwrite the default mac address.  This will cause traffic down.

Hmm the patch description says VF mac address, not 0 address. Confused.
If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
use a random value ...

> > > >
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > > > > >       if (err)
> > > > > > >               goto err_mtu;
> > > > > > >
> > > > > > > -     err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > > -     if (err)
> > > > > > > -             goto err_mtu;
> > > > > > > -
> > > > > > > +     eth_random_addr(config->mac);
> > > > > > >       mvdev->vdev.dma_dev = mdev->device;
> > > > > > >       err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > >       if (err)
> > > > > > > --
> > > > > > > 2.26.2
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
