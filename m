Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF47C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 14:55:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F2D60EFF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 14:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82F2D60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4225B4010B;
	Wed, 27 Oct 2021 14:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CyZDGHLafZ6l; Wed, 27 Oct 2021 14:55:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8226403FE;
	Wed, 27 Oct 2021 14:55:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C290C0019;
	Wed, 27 Oct 2021 14:55:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 508ADC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 14:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 323C3606DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 14:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NQkS8LVbEgJM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 14:55:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 619DF60665
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635346527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lp3MKDjnFrSR+4gVc16F4ogHmgYiCOd0YCxbmncoWwI=;
 b=dorPSVyFec5A2TYitO3Xobkwh+V/Gylo6oU2jeJFSWhTs/hL/K2CH7xJvLZycpbcE51kuc
 Aklws4k4iYeTKQykl0vhKfMwtukA0WhiNHWG8ME8DsXHD3Qq0VAJ3cnbL8sP4IedzWlCkg
 UVWWyfnsj8v9g9xw3knchp2RzHVuN3g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-JvynjPN2NiyqJxlFE3wBag-1; Wed, 27 Oct 2021 10:55:25 -0400
X-MC-Unique: JvynjPN2NiyqJxlFE3wBag-1
Received: by mail-wm1-f70.google.com with SMTP id
 k5-20020a7bc3050000b02901e081f69d80so1356058wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Lp3MKDjnFrSR+4gVc16F4ogHmgYiCOd0YCxbmncoWwI=;
 b=PhPu7NqChBK4hyE8gOO+Cvl5IW/WjOAbXUfmb8tVmugbve+2sxu2/ex/JQo0+OkPSZ
 M1Yo/I/mjrL7OzPm6z1nmppECmxniug0rFXVBfdJsXin9ciaoH+lTmBbpE6mbAvrVktJ
 6PYHo0JSRpAZJf4fVHd1AutjdWxhHTGG8tgA9buo3XodnxbDkpb2LmnG6HN1hz0DoSaP
 7ctrcWGjc1HpPREi96DXKD9KeW7Bxz1AQ/MBfCVeKJdJiuWpXHPd3LQVgKRVLy7GtLgl
 Hte2aIUunUWIu3H/eD5D0tNN9SLmdvxnSQQxWjnry3m1laDjQvQXtxz2g9ZmVroAZ712
 +fTQ==
X-Gm-Message-State: AOAM530gUigRPwCnLjG3yKdWtoRK5KvJeAz5ZVqBMS1Kp2L4iZOJJJ8c
 J3l5JaDInUtpfalhEkDeX+fOK/q2L/01zttLwYMBEGzm5rCudBLCYO7tDT//9jbMVuy/PyrFjcS
 AUxYr8vTF5fvheHJyrRaYLSrA3UjCUA26rDG+Tt1uZA==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr1620237wme.23.1635346524701; 
 Wed, 27 Oct 2021 07:55:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI361h/ezacALLgptu96Fn+gOJLLfX9nvpCDn8IkWJ2ceM8+0pwmtHwSpwJBQYpLhuQhYzfQ==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr1620208wme.23.1635346524471; 
 Wed, 27 Oct 2021 07:55:24 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:a543:72f:c4d1:8911:6346])
 by smtp.gmail.com with ESMTPSA id m3sm103026wrx.52.2021.10.27.07.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 07:55:23 -0700 (PDT)
Date: Wed, 27 Oct 2021 10:55:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] net: virtio: use eth_hw_addr_set()
Message-ID: <20211027105137-mutt-send-email-mst@kernel.org>
References: <20211026175634.3198477-1-kuba@kernel.org>
 <20211027032113-mutt-send-email-mst@kernel.org>
 <20211027062640.5d32d7be@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <20211027062640.5d32d7be@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, davem@davemloft.net,
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

On Wed, Oct 27, 2021 at 06:26:40AM -0700, Jakub Kicinski wrote:
> On Wed, 27 Oct 2021 03:23:17 -0400 Michael S. Tsirkin wrote:
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c501b5974aee..b7f35aff8e82 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3177,12 +3177,16 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  	dev->max_mtu = MAX_MTU;
> > >  
> > >  	/* Configuration may specify what MAC to use.  Otherwise random. */
> > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> > > +		u8 addr[MAX_ADDR_LEN];
> > > +
> > >  		virtio_cread_bytes(vdev,
> > >  				   offsetof(struct virtio_net_config, mac),
> > > -				   dev->dev_addr, dev->addr_len);
> > > -	else
> > > +				   addr, dev->addr_len);  
> > 
> > Maybe BUG_ON(dev->addr_len > sizeof addr);
> > 
> > here just to make sure we don't overflow addr silently?
> 
> Since I need to post a v2 and we're talking... can I just use
> eth_hw_addr_set() instead? AFAICT netdev is always allocated with 
> alloc_etherdev_mq() and ->addr_len never changed. Plus there is 
> a number of Ethernet address helpers used so ETH_ALEN is kind of 
> already assumed.


Right. Sure, just document this in the commit log pls.

> > > +		dev_addr_set(dev, addr);
> > > +	} else {
> > >  		eth_hw_addr_random(dev);
> > > +	}
> > >  
> > >  	/* Set up our device-specific information */
> > >  	vi = netdev_priv(dev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
