Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE4C5519F
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 09:01:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E6020825
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 09:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Whb/mUgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E6020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 186FF86CDB;
	Mon, 30 Nov 2020 09:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MzkUQ8gU37R7; Mon, 30 Nov 2020 09:01:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D56C78691A;
	Mon, 30 Nov 2020 09:01:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4019C163C;
	Mon, 30 Nov 2020 09:01:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5521C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 09:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9D773873B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 09:01:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jk15uwjz2Qaj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 09:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 77EB0873B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606726861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xiPvp6x0gf1L8/yQBHxAgSJCq1BiNj+2S6D9QL93hd0=;
 b=Whb/mUgPFZPfQU/S18NWZZInYqE+cl/VUwy/NN9HmkRIAKNR2U0eEZdmvl/gmHIXY/r9eC
 8ChzTAZlnX+ffMCIMwTRobeuxCXAN78b7FyIpHD6rLnIUgq9qwFPaYmEMzbiwEdCHrq9HM
 4ok9b5sANI5bs+7hfHNQU5tScPm80Vs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-718wl8MOPHe2m0z9ecc1FA-1; Mon, 30 Nov 2020 04:00:56 -0500
X-MC-Unique: 718wl8MOPHe2m0z9ecc1FA-1
Received: by mail-wr1-f69.google.com with SMTP id b5so8057240wrp.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 01:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xiPvp6x0gf1L8/yQBHxAgSJCq1BiNj+2S6D9QL93hd0=;
 b=K0vA5p1wMqvlM2HnT+Vls+/b6KynHMypYFTJkeB/8Gx9x+L+MuKjjCCZhZsoyA80HA
 SevDWlwA0qQ3anpOziOlxxJejBYjGt5qewOsadIr0HuL9qq3QOWgNZl3F1hTacBZOcZd
 MhdR6DXeVZUSxDU8TUdtFaqaj5ooevS+f6PVb1Ft8eAvd0+t4WhB8Sf6j7GVRB7W85M/
 C6E9aGtLmfHCW3M9ZFKDJYh4/7EDx2cqcoh6q7F567+BKcAhNhExlDY+8ze92RM0B+/w
 B79kf2d5nzQp5wA0rl1Ut4w6HG5JF5YfXR04XaqjxnMqNJ9+41cgSg7yzLazHveWV0kP
 Z9jQ==
X-Gm-Message-State: AOAM530W9nTp6y9wrc/8nS9YK7NOptzmVu0UI8G3ksTxuwum8TiMurbF
 /HU/DWPLs8lTmpJ/uoFi+BJuOz9/ErkQXMGf7Y/xZjghFxgcAe68MOeRViv+Ww+FncxRdeg34Hl
 fz3Z4A32zGKN9C3Xzs05XCGZtrLoobMxyBnOZfQ19EQ==
X-Received: by 2002:adf:dd0e:: with SMTP id a14mr26864306wrm.36.1606726855414; 
 Mon, 30 Nov 2020 01:00:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM4Rcm5MkqH5pqPqXkkHFFYNovJ7rq0TY5MZ8/Ba8lx8HQAvuZuFy84/IfK1fWYLf7ESXbkQ==
X-Received: by 2002:adf:dd0e:: with SMTP id a14mr26864285wrm.36.1606726855207; 
 Mon, 30 Nov 2020 01:00:55 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id q16sm28072755wrn.13.2020.11.30.01.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 01:00:54 -0800 (PST)
Date: Mon, 30 Nov 2020 04:00:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130035147-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, lulu@redhat.com,
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

On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > We should not try to use the VF MAC address as that is used by the
> > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > generated MAC address.
> > > 
> > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > I didn't realise it's possible to use VF in two ways
> > with and without vdpa.
> 
> Using a VF you can create quite a few resources, e.g. send queues
> recieve queues, virtio_net queues etc. So you can possibly create
> several instances of vdpa net devices and nic net devices.
> 
> > Could you include a bit more description on the failure
> > mode?
> 
> Well, using the MAC address of the nic vport is wrong since that is the
> MAC of the regular NIC implementation of mlx5_core.

Right but ATM it doesn't coexist with vdpa so what's the problem?

> > Is switching to a random mac for such an unusual
> > configuration really justified?
> 
> Since I can't use the NIC's MAC address, I have two options:
> 1. To get the MAC address as was chosen by the user administering the
>    NIC. This should invoke the set_config callback. Unfortunately this
>    is not implemented yet.
> 
> 2. Use a random MAC address. This is OK since if (1) is implemented it
>    can always override this random configuration.
> 
> > It looks like changing a MAC could break some guests,
> > can it not?
> >
> 
> No, it will not. The current version of mlx5 VDPA does not allow regular
> NIC driver and VDPA to co-exist. I have patches ready that enable that
> from steering point of view. I will post them here once other patches on
> which they depend will be merged.
> 
> https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/

Could you be more explicit on the following points:
- which configuration is broken ATM (as in, two device have identical
  macs? any other issues)?
- why won't device MAC change from guest point of view?


> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 1fa6fcac8299..80d06d958b8b 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > >  	if (err)
> > >  		goto err_mtu;
> > >  
> > > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > -	if (err)
> > > -		goto err_mtu;
> > > -
> > > +	eth_random_addr(config->mac);
> > >  	mvdev->vdev.dma_dev = mdev->device;
> > >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > >  	if (err)
> > > -- 
> > > 2.26.2
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
