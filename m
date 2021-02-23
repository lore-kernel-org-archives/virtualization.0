Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EE1C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:26:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EFC64E02
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EFC64E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D55082726;
	Tue, 23 Feb 2021 09:26:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0aHgsXeddym; Tue, 23 Feb 2021 09:26:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F3FA8271D;
	Tue, 23 Feb 2021 09:26:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3254AC000B;
	Tue, 23 Feb 2021 09:26:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 768C7C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64C3A82726
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Ms5Up-zvXT2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:26:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2F7B8271D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614072403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h24RIBiBzWyvnGHMRqm0bjGav8NVJ5vrDg07fowU/yw=;
 b=Hu5fT3lQjd9B8sl1fLwx/P8Ku1EzYNR8DsXPNbofiSJ+7dHRwjXfbWDhnON7HDN2PCU599
 cZjBTiFZHisOjrqNizukyt53mg4TC6kEuKZxwy0cP6Enm1D6XGhBAu3KJcVZeW/qnS2/2i
 6t/Q1xbSSBo4oU5Cdnz4iW5nP+JKoIs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-Wb63CIhCPaqO1ulsPCH88g-1; Tue, 23 Feb 2021 04:26:39 -0500
X-MC-Unique: Wb63CIhCPaqO1ulsPCH88g-1
Received: by mail-wm1-f71.google.com with SMTP id o18so469163wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 01:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h24RIBiBzWyvnGHMRqm0bjGav8NVJ5vrDg07fowU/yw=;
 b=YKajhBQbrq3jPQQJoAJTmYKXZkE5igrQuYVLjo8PSch7faNXWOamdWsT/tk6ogVGPb
 Cu8CjHMUDe0FTTXqyRf4dyrJdHQafBlGD7nC8bveotUhpKSITNPlsc1syiBIvvr1dvSv
 rO22uAUDpAEAd2nsoUZJmzNF9r3HiZGGMRwBGkiXddwNjLTOOeFs9PHvbrUor8abYo0+
 l1+0FalMxADPzKMwBX1BpJoC/lHAakRkMD6cvEtDMAJmYtkysl0WaWQpMpHSdqm3CMH9
 Ho39vCRt0s23kmYe3fWvU4hnNsZORHZzlRf9062LitQUTvl9UE2CSfRI4+1REXoRaNHi
 8y0A==
X-Gm-Message-State: AOAM532QxYaPlOCm0jrBtyn5TWuVXmryZ1Cf+97WQ/JW9O9ls4sL+Jdc
 GLNMGbS1ypGMUDml75PmZZ0ds/6ntJH6/oKxaep5DlbHiEQduaps1WemDtVKY+DEEd/5XiYXC0L
 D/6AXCKvEpfnxa7SL7zxo3bPCjec2fzsEReKFJaqxTw==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr25412079wrd.304.1614072398474; 
 Tue, 23 Feb 2021 01:26:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpG+IjMBMskIS3JIko3wZp10Ib6ahzykLv4bI1e1go9h9Q19lzcgRxEOLog/5XNrwEUBFFxQ==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr25412068wrd.304.1614072398336; 
 Tue, 23 Feb 2021 01:26:38 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id 36sm33421735wrj.97.2021.02.23.01.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 01:26:37 -0800 (PST)
Date: Tue, 23 Feb 2021 04:26:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223042559-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <20210221144437.GA82010@mtl-vdi-166.wap.labs.mlnx>
 <20210221165047-mutt-send-email-mst@kernel.org>
 <20210222060526.GA110862@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210222060526.GA110862@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Feb 22, 2021 at 08:05:26AM +0200, Eli Cohen wrote:
> On Sun, Feb 21, 2021 at 04:52:05PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Feb 21, 2021 at 04:44:37PM +0200, Eli Cohen wrote:
> > > On Fri, Feb 19, 2021 at 06:54:58AM -0500, Si-Wei Liu wrote:
> > > > Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> > > > for legacy") made an exception for legacy guests to reset
> > > > features to 0, when config space is accessed before features
> > > > are set. We should relieve the verify_min_features() check
> > > > and allow features reset to 0 for this case.
> > > > 
> > > > It's worth noting that not just legacy guests could access
> > > > config space before features are set. For instance, when
> > > > feature VIRTIO_NET_F_MTU is advertised some modern driver
> > > > will try to access and validate the MTU present in the config
> > > > space before virtio features are set. Rejecting reset to 0
> > > > prematurely causes correct MTU and link status unable to load
> > > > for the very first config space access, rendering issues like
> > > > guest showing inaccurate MTU value, or failure to reject
> > > > out-of-range MTU.
> > > > 
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +--------------
> > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 7c1f789..540dd67 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -1490,14 +1490,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
> > > >  	return mvdev->mlx_features;
> > > >  }
> > > >  
> > > > -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> > > > -{
> > > > -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> > > > -		return -EOPNOTSUPP;
> > > > -
> > > > -	return 0;
> > > > -}
> > > > -
> > > 
> > > But what if VIRTIO_F_ACCESS_PLATFORM is not offerred? This does not
> > > support such cases.
> > 
> > Did you mean "catch such cases" rather than "support"?
> > 
> 
> Actually I meant this driver/device does not support such cases.

Well the removed code merely failed without VIRTIO_F_ACCESS_PLATFORM
it didn't actually try to support anything ...

> > 
> > > Maybe we should call verify_min_features() from mlx5_vdpa_set_status()
> > > just before attempting to call setup_driver().
> > > 
> > > >  static int setup_virtqueues(struct mlx5_vdpa_net *ndev)
> > > >  {
> > > >  	int err;
> > > > @@ -1558,18 +1550,13 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > > >  {
> > > >  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > >  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > -	int err;
> > > >  
> > > >  	print_features(mvdev, features, true);
> > > >  
> > > > -	err = verify_min_features(mvdev, features);
> > > > -	if (err)
> > > > -		return err;
> > > > -
> > > >  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> > > >  	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
> > > >  	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> > > > -	return err;
> > > > +	return 0;
> > > >  }
> > > >  
> > > >  static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
> > > > -- 
> > > > 1.8.3.1
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
