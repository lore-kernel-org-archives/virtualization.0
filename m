Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2208C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 21:15:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2776D60E05
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 21:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2776D60E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD88C4048C;
	Mon, 25 Oct 2021 21:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T09XE-FWY2my; Mon, 25 Oct 2021 21:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 816B040400;
	Mon, 25 Oct 2021 21:15:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5543BC0012;
	Mon, 25 Oct 2021 21:15:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93C50C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 838AA80D2D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fJV9vrbY3zdW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:15:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEA3380D0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635196502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6b7aqCPr7A0jog7Oo4JmTvCROVoKj9eReecA1fHV04=;
 b=DZ9AQgPOipl7EzSB/JpXEuk/enWhmCpuptcrYBSDZ55zn47awrAha3ZC1dfTjzkGQ4ihyr
 9M7UUxenhb7A39yra/oMhMizoZJOPErkZzmu+3zOaz4k0qgrugt42SZFOZKLmTtH/Viwj6
 APV/XKQFHvBcjkw3L8rslsgX0pbaFIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-NSMPvdEsMiC12f8UFJmpIg-1; Mon, 25 Oct 2021 17:14:59 -0400
X-MC-Unique: NSMPvdEsMiC12f8UFJmpIg-1
Received: by mail-wm1-f71.google.com with SMTP id
 v10-20020a1cf70a000000b00318203a6bd1so466834wmh.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 14:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w6b7aqCPr7A0jog7Oo4JmTvCROVoKj9eReecA1fHV04=;
 b=2R65W+/9rdcVgYFcxf7PxzO07+wCSEYQo80BTlf/qbUfuDyBX62EFz+OyaMlvfkLLs
 Z4lcyiDRhKsGX3uL4ijWCO1RzfQEAHF5ExPSdPC8BO6/jD7KQTg31mHCUEkBVQXYLIYB
 p73pKbPqZNrSXqUYLuMcZo8MU+O6rvgePe9EDj02PpRQPfUEBpl2iacBMiaYIyCMiu40
 SdD3Hr1criCOz3RvbRWujHTq/L/gPtMe2+/Lw1j2/nWrk5J+56nolTXaOtPU38Qv7Szd
 sHbDyk10Z1ZRO77H/5K0/VNbwBKmRwnHm6POki5tTJiXv38+Szu5WjrqE+OWndgEDG32
 c7sg==
X-Gm-Message-State: AOAM531ItK2zhHkLCv+NagsMsO9G8NBlGS4XsqCq4L47H96xNRpXTEpN
 lV1dmmXBy4iZ9fKMlaie6b6Kap+P/I1fb7ADBpc1/Kr7IN7+E1JGMA1KPEXh6fIOFegIPAV7B4A
 JEzjmRy3KX7miq7Uv8UZiW96GbKKbkiGgKMiO+IIaiQ==
X-Received: by 2002:a05:600c:4143:: with SMTP id
 h3mr18153609wmm.19.1635196498319; 
 Mon, 25 Oct 2021 14:14:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeoj2sOl1DcD7M5L0c+WMiXce0f4QlBvY9Xx3OzcHUmEo6dA7h0au7mBRpy162jIZADgcgdw==
X-Received: by 2002:a05:600c:4143:: with SMTP id
 h3mr18153590wmm.19.1635196498130; 
 Mon, 25 Oct 2021 14:14:58 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
 by smtp.gmail.com with ESMTPSA id w5sm17340645wra.87.2021.10.25.14.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 14:14:57 -0700 (PDT)
Date: Mon, 25 Oct 2021 17:14:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
Message-ID: <20211025171431-mutt-send-email-mst@kernel.org>
References: <20211025125316.67664-1-parav@nvidia.com>
 <20211025125316.67664-8-parav@nvidia.com>
 <PH0PR12MB5481911ACF48EE43603F5EA6DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481911ACF48EE43603F5EA6DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Oct 25, 2021 at 06:35:35PM +0000, Parav Pandit wrote:
> 
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Monday, October 25, 2021 6:23 PM
> > 
> > From: Eli Cohen <elic@nvidia.com>
> > 
> > Add code to accept MAC configuration through vdpa tool. The MAC is written
> > into the config struct and later can be retrieved through get_config().
> > 
> > Examples:
> > 1. Configure MAC while adding a device:
> > $ vdpa dev add mgmtdev pci/0000:06:00.2 name vdpa0 mac 00:11:22:33:44:55
> > 
> > 2. Show configured params:
> > $ vdpa dev config show
> > vdpa0: mac 00:11:22:33:44:55 link down link_announce false max_vq_pairs 8
> > mtu 1500
> > 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 8d1539728a59..860d80efa5d1 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/vringh.h>
> >  #include <uapi/linux/virtio_net.h>
> >  #include <uapi/linux/virtio_ids.h>
> > +#include <uapi/linux/vdpa.h>
> >  #include <linux/virtio_config.h>
> >  #include <linux/auxiliary_bus.h>
> >  #include <linux/mlx5/cq.h>
> > @@ -2523,18 +2524,19 @@ static int mlx5_vdpa_dev_add(struct
> > vdpa_mgmt_dev *v_mdev, const char *name,
> >  	if (err)
> >  		goto err_mtu;
> > 
> > -	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> I messed up above line in the rebase conflict.
> Let me resend the series.

If it's happening it's better happen soon, rc7 is out.

> > -	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev,
> > VIRTIO_NET_S_LINK_UP);
> > -
> > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > -	if (err)
> > -		goto err_mtu;
> > -
> >  	if (get_link_state(mvdev))
> >  		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev,
> > VIRTIO_NET_S_LINK_UP);
> >  	else
> >  		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev,
> > ~VIRTIO_NET_S_LINK_UP);
> > 
> > +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR))
> > {
> > +		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
> > +	} else {
> > +		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config-
> > >mac);
> > +		if (err)
> > +			goto err_mtu;
> > +	}
> > +
> >  	if (!is_zero_ether_addr(config->mac)) {
> >  		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> >  		err = mlx5_mpfs_add_mac(pfmdev, config->mac); @@ -2632,6
> > +2634,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
> >  	mgtdev->mgtdev.ops = &mdev_ops;
> >  	mgtdev->mgtdev.device = mdev->device;
> >  	mgtdev->mgtdev.id_table = id_table;
> > +	mgtdev->mgtdev.config_attr_mask = (1 <<
> > +VDPA_ATTR_DEV_NET_CFG_MACADDR);
> >  	mgtdev->madev = madev;
> > 
> >  	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
> > --
> > 2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
