Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69F28B7F8
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295287; cv=none; b=Z8WpnDWIBmN3DJPIQvmLnXy24Fi0CBWQVbsxCz+zLWjM/EwUnq1V1w7FJPCVipU/J21Q/4MDEOxWcxp3tXgroIwi656Is1G7eHYpsCuIcjp0cZO3LUomw2cRe6tjtk9kN4aHOSqmmKv8XsHykQvXRbi+tWShqEteoMBVy0ui220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295287; c=relaxed/simple;
	bh=aLt1ZrspkXVq+7ZfamJt97k2eAHB68alTdtmafLRht0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=az8OmHeuZkxRCVGfaFW436r6uG6ZsdZnDet4SrIyge485NZYFJEE0AKZGBFzptY+icNpbiB6qwrETQ2wbInHwN1lUrakTvDaVfQJr3gCvSkGPHPytXv2ohMijnTd3SRxmvj98RUn34/2BkAT9Pk3WjpVZ1E31EtS8ki9JfGn8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pkru7PAe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pkru7PAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751295284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDq2W9BFH4O+4v2QDHUZ/OXiJmC+AYZucENKup8acvQ=;
	b=Pkru7PAezTy5zufVpIbGa1IxYWo1GaEIHRtEtVZ+rvMmy6Ow6rW9pVSQSLZXjgsPzr/fh5
	tjGZNgfhuTRRv6u7iqWKl1FKcNgXHYuThCCZ5MDXLH01nv8cHVQN4ALKgCSgr067mUwoXB
	AqZmJ+zwuZBg374j9ouDxkrB4qh5zjY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-TDEpR5sBOBiKW9hZZ9-AXA-1; Mon, 30 Jun 2025 10:54:43 -0400
X-MC-Unique: TDEpR5sBOBiKW9hZZ9-AXA-1
X-Mimecast-MFC-AGG-ID: TDEpR5sBOBiKW9hZZ9-AXA_1751295282
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae0b629918eso211068766b.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295282; x=1751900082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDq2W9BFH4O+4v2QDHUZ/OXiJmC+AYZucENKup8acvQ=;
        b=TjAneBBR4H2yuCWVHBBI6cd2jUXH0y1UJOK6D4TLaMHwVKTTjwrtrWz7fsElghl91O
         5EEjYlQVqjec5a+Lgwa3xdot8GpoEACKV+J5qSQIlYMA8B2/N5bllaU30J7xHd2Co3Ne
         kuLRR+6BcPU1kqoEdv8SYel8WSAZe2ejNARDBqwlhjk1MC/bT4KKpKztinDaKPe4yeUb
         ZxMoqqL5TGqtu4bYlf9221Fky9dVZJcJCVtxNqwmprOAxtKZGqyrVhP6OJNh6qS7YAq2
         RH/sb6ae/MjVnyJl5OkEVwHkgJK7Offe1Zhewa+wvZYIPLGgng2JXRIZpnTKy1OoIyPO
         HcyA==
X-Forwarded-Encrypted: i=1; AJvYcCWgZ1TYkFaDVC++h0N0K3zFb9xwIBuSORms2mdwxUdqbePr+0v4aYy6I65Jq/E98CDAHCYs0vDofTpNU/HJzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+ifM6vFRSM2/6/mecwe5VZ4QvGMQ0VH29+l8f2m5ys+lYL75/
	LkHHPjOk+8lT/GMwddFWt5E3fsivYuMbO0C6ZcuYMg/Q62NSz76QMLj+c5eTt9X9H4dNXBxxgbg
	83k8tavvh8rQhQTP6+2Ffk0HOBl5X/sBr1SYIBYmnNyjd4WgG83mjO4m1Yfh4bbFzkN1v
X-Gm-Gg: ASbGncvAKSUCVQrGomgR/JMSy1dxTxp4MKQNq6wbP6s3FAcKjm9rjuu1QsxfE4DYmn2
	zL3FpAHTuMrCluyPMaeLP40DdsLUJUs5nE3hsT6Qrb7WgYhc2k+oW1ag3wGJ37FKH4NeSga+OJA
	Yf/2O6mOFwSZFgXb7m78RnDHcVwz1u9+agBdMt/5fmcuziXjwZYaFRboZsE3U4b4GRBpgnaWy1D
	RqaHlH4j5jTWBEsufS2CrS3Usu6Nv7H716eTGdV2JmcaheNMAFVhm1uIRLOaNRgSEHSaxE/5MXQ
	tOBShnz4b6s=
X-Received: by 2002:a17:907:3c83:b0:ad8:e477:970c with SMTP id a640c23a62f3a-ae34fdc67demr1187814966b.23.1751295281528;
        Mon, 30 Jun 2025 07:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiDVHztt+YTUkaG1BJuQ7w5s/kr8yY1OSJDtV0Axqaw2I4tijYVvqW2nsMVoPwIigNr7w4kQ==
X-Received: by 2002:a17:907:3c83:b0:ad8:e477:970c with SMTP id a640c23a62f3a-ae34fdc67demr1187812466b.23.1751295280964;
        Mon, 30 Jun 2025 07:54:40 -0700 (PDT)
Received: from redhat.com ([31.187.78.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bbfdsm688648166b.115.2025.06.30.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:54:40 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:54:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: fix a rtnl_lock() deadlock during probing
Message-ID: <20250630105328-mutt-send-email-mst@kernel.org>
References: <20250630095109.214013-1-zuozhijie@bytedance.com>
 <20250630103240-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250630103240-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wEe6vKokFv54ddYD8xJJ1ZEsXih1seYRHASAkKVrC88_1751295282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2025 at 10:50:55AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 30, 2025 at 05:51:09PM +0800, Zigit Zo wrote:
> > This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
> > the virtio-net driver is still probing with rtnl_lock() hold, this will
> > cause a recursive mutex in netdev_notify_peers().
> > 
> > Fix it by skip acking the annouce in virtnet_config_changed_work() when
> > probing. The annouce will still get done when ndo_open() enables the
> > virtio_config_driver_enable().
> 
> I am not so sure it will be - while driver is not loaded, device does
> not have to send interrupts, and there's no rule I'm aware of that says
> we'll get one after DRIVER_OK.
> 
> How about, we instead just schedule the work to do it later?
> 
> 
> Also, there is another bug here.
> If ndo_open did not run, we actually should not send any announcements.
> 
> Do we care if carrier on is set on probe or on open?
> If not, let's just defer this to ndo_open?

Hmm yes I think we do, device is visible to userspace is it not?

Hmm.  We can keep the announce bit set in vi->status and on open, check
it and then schedule a work to do the announcement.


> 
> > We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
> > QEMU sending the announce_self rapidly while booting.
> > 
> > [  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
> > [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
> > [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
> > [  494.168260] Call Trace:
> > [  494.168329]  <TASK>
> > [  494.168389]  __schedule+0x27c/0x6b0
> > [  494.168495]  schedule+0x33/0x110
> > [  494.168585]  schedule_preempt_disabled+0x15/0x30
> > [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
> > [  494.168835]  __mutex_lock_slowpath+0x13/0x20
> > [  494.168949]  mutex_lock+0x3c/0x50
> > [  494.169039]  rtnl_lock+0x15/0x20
> > [  494.169128]  netdev_notify_peers+0x12/0x30
> > [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
> > [  494.169377]  virtnet_probe+0xa48/0xe00
> > [  494.169484]  ? vp_get+0x4d/0x100
> > [  494.169574]  virtio_dev_probe+0x1e9/0x310
> > [  494.169682]  really_probe+0x1c7/0x410
> > [  494.169783]  __driver_probe_device+0x8c/0x180
> > [  494.169901]  driver_probe_device+0x24/0xd0
> > [  494.170011]  __driver_attach+0x10b/0x210
> > [  494.170117]  ? __pfx___driver_attach+0x10/0x10
> > [  494.170237]  bus_for_each_dev+0x8d/0xf0
> > [  494.170341]  driver_attach+0x1e/0x30
> > [  494.170440]  bus_add_driver+0x14e/0x290
> > [  494.170548]  driver_register+0x5e/0x130
> > [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
> > [  494.170788]  register_virtio_driver+0x20/0x40
> > [  494.170905]  virtio_net_driver_init+0x97/0xb0
> > [  494.171022]  do_one_initcall+0x5e/0x340
> > [  494.171128]  do_initcalls+0x107/0x230
> > [  494.171228]  ? __pfx_kernel_init+0x10/0x10
> > [  494.171340]  kernel_init_freeable+0x134/0x210
> > [  494.171462]  kernel_init+0x1b/0x200
> > [  494.171560]  ret_from_fork+0x47/0x70
> > [  494.171659]  ? __pfx_kernel_init+0x10/0x10
> > [  494.171769]  ret_from_fork_asm+0x1b/0x30
> > [  494.171875]  </TASK>
> > 
> > Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
> > Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> > ---
> >  drivers/net/virtio_net.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e53ba600605a..0290d289ebee 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6211,7 +6211,8 @@ static const struct net_device_ops virtnet_netdev = {
> >  	.ndo_tx_timeout		= virtnet_tx_timeout,
> >  };
> >  
> > -static void virtnet_config_changed_work(struct work_struct *work)
> > +static void __virtnet_config_changed_work(struct work_struct *work,
> > +					  bool check_announce)
> >  {
> >  	struct virtnet_info *vi =
> >  		container_of(work, struct virtnet_info, config_work);
> 
> So this will be schedule_announce instead of check_announce?
> 
> 
> 
> 
> > @@ -6221,7 +6222,7 @@ static void virtnet_config_changed_work(struct work_struct *work)
> >  				 struct virtio_net_config, status, &v) < 0)
> >  		return;
> >  
> > -	if (v & VIRTIO_NET_S_ANNOUNCE) {
> > +	if (check_announce && (v & VIRTIO_NET_S_ANNOUNCE)) {
> >  		netdev_notify_peers(vi->dev);
> >  		virtnet_ack_link_announce(vi);
> >  	}
> > @@ -6244,6 +6245,11 @@ static void virtnet_config_changed_work(struct work_struct *work)
> >  	}
> >  }
> >  
> > +static void virtnet_config_changed_work(struct work_struct *work)
> > +{
> > +	__virtnet_config_changed_work(work, true);
> > +}
> > +
> >  static void virtnet_config_changed(struct virtio_device *vdev)
> >  {
> >  	struct virtnet_info *vi = vdev->priv;
> > @@ -7030,7 +7036,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  	   otherwise get link status from config. */
> >  	netif_carrier_off(dev);
> >  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > -		virtnet_config_changed_work(&vi->config_work);
> > +		/* The check_annouce work will get scheduled when ndo_open()
> > +		 * doing the virtio_config_driver_enable().
> > +		 */
> > +		__virtnet_config_changed_work(&vi->config_work, false);
> >  	} else {
> >  		vi->status = VIRTIO_NET_S_LINK_UP;
> >  		virtnet_update_settings(vi);
> > 
> > base-commit: 2def09ead4ad5907988b655d1e1454003aaf8297
> > -- 
> > 2.49.0

