Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7D28C5DE
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295062; cv=none; b=hfFBUFmo4JImCbg+h38+8Kh/w6xJzUwq4R3p77njAmGALBo6MgtGBn0ucJ71c9p9toY4KTY6FSexzN0EnxsuqqUJcnXCFs3h40TOka30Kzce1tg3J/qOgHIdeEAUQJpafP8JRtUynB6+Agz9cb2xxlNA5MzC63Y88yJD2/izTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295062; c=relaxed/simple;
	bh=Q7H5Mae2lfyZ9olxXdhg244usOkP0rN8020MYLRd/AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PqPtq9H16tfeUjT7uIMJIV2bwDi+Egc7AxMlDAoVsvUt2Z8+clrAXtmEy9SBOFBnQaZBcx9ULEhl/VnmaDfb5SaInGEEeQrbddtZxDMTrZudtmd0XFiKN7bbEA5yNAyNLfmymPEYNkZs/v9SBLKGWbJ61fFn3JlADCJG/4I9lnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaBrliL6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaBrliL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751295059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AO0WwxoEv5pQePQjGxtMRKG2m7KTBBV9bH1zDwVxzZE=;
	b=OaBrliL6bDi7pmd4AWAdDmYL4F75W/2jElsgpmAO5lv3oGRC4gemzPcYq9NVDbxLqxbwT6
	Hfg+6nKDxVVb23SORwo5RARXepDes5e+pIz6UysqKSW2OImMnCIxTcRIslkLcBlZ/9JXuW
	lHbztHhwILUIs/j/SwvyWms5M9ZJ6WE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-W4enanNbM4O4_OazvLyj7A-1; Mon, 30 Jun 2025 10:50:57 -0400
X-MC-Unique: W4enanNbM4O4_OazvLyj7A-1
X-Mimecast-MFC-AGG-ID: W4enanNbM4O4_OazvLyj7A_1751295056
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae0a3511145so293632766b.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295056; x=1751899856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO0WwxoEv5pQePQjGxtMRKG2m7KTBBV9bH1zDwVxzZE=;
        b=iNVrY+0kNLYfeHGPROgVMf6HtjJK/G9/KMswk8q9sAN2ZqPSL4qSuaNtA+EyQVnP/t
         KsaK8QFl1cWcjEY64c1AiP/yv/Z2CXm/ZvUyE4jrlGrkLGuZG2r3cqt0EiyetQddiC49
         jSoo/x32We52T4WflGs+Pf2cuLHM6WjH8PFVk8hx740bseJ1iV3RLmBlYeS8+8jv7Bau
         HpllJ47VDT509cXNI5gynmczxCSUEZr0X+pu+bIIVJCZI8vRb7cMzZps9NAczKHeAa/u
         R9RjUPtHLq0Qg/gKjh4gBE/ile/MAdwydHfeJu6/vUNEk6asTdsfyc9PuQn3KSsIZwTY
         qMyg==
X-Forwarded-Encrypted: i=1; AJvYcCXADLOd0wl2xTI/3rqLL0ufaX6WO9w2TXYUz/mkXe+4fNA4qK8lK7K2Qly1zjHwTzUCMgob0iKNbef8IXPOVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvXOId7VxRrVot2jynlGtAjaPmrZ+7/hx+5rTeVMC21oDqx06L
	ytZd1GYjhCjACQTnyRhtdSK2uSufOZ4MNeubjKWsvm/TIBTr7C7lFaA4qLqqFlLm9EsQtu8SlLx
	fUAxR95zRXA65BGwp8VJuaqiXRuOJM/E4naXRykAF6hbcfS5PfC2JcbND/3g0D2crogOl
X-Gm-Gg: ASbGncvD4kbQ3WH9xIk27H/8hRzYWEngFM9l84qfSu4cQSxNUU9BINPOFcQ+cbo9vcC
	IO2i0VYFonLTk5PCJJGmsEaI1mvY11HUOmaVRwyOITJNA6Qah3McXKZglg/kgQGrmVfPRZKosJE
	8o4BNfN0MgqcIHzUC65sCdNJ4e4CEgvsWUGlJ6xENjh547WzWxmDmerNy2528UchzOkLznTYOAr
	SHYy/lKCrsCA6HyUBKSZdly6O6SWiJJw2vkl5G4r0iLBJoCPzBXzFtXfwrHh3Naevg5UX1oqGRm
	7aFo+EUKnw0=
X-Received: by 2002:a17:907:9721:b0:ae0:c539:b89a with SMTP id a640c23a62f3a-ae34fd9a108mr1344305166b.19.1751295055902;
        Mon, 30 Jun 2025 07:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFilcEWZAtf/t0KvGdfF6PuE3xyw4eeo9DeGU4E65CUTPm13/SbEfKyhA0n6NQJnmwGy8DrnA==
X-Received: by 2002:a17:907:9721:b0:ae0:c539:b89a with SMTP id a640c23a62f3a-ae34fd9a108mr1344301366b.19.1751295055299;
        Mon, 30 Jun 2025 07:50:55 -0700 (PDT)
Received: from redhat.com ([31.187.78.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a0a8sm689409666b.71.2025.06.30.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:50:54 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:50:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: fix a rtnl_lock() deadlock during probing
Message-ID: <20250630103240-mutt-send-email-mst@kernel.org>
References: <20250630095109.214013-1-zuozhijie@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250630095109.214013-1-zuozhijie@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1zAz9KC022_02Z2l6WGtJ8POPUy9nMZ4P3SQ53raKbw_1751295056
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2025 at 05:51:09PM +0800, Zigit Zo wrote:
> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
> the virtio-net driver is still probing with rtnl_lock() hold, this will
> cause a recursive mutex in netdev_notify_peers().
> 
> Fix it by skip acking the annouce in virtnet_config_changed_work() when
> probing. The annouce will still get done when ndo_open() enables the
> virtio_config_driver_enable().

I am not so sure it will be - while driver is not loaded, device does
not have to send interrupts, and there's no rule I'm aware of that says
we'll get one after DRIVER_OK.

How about, we instead just schedule the work to do it later?


Also, there is another bug here.
If ndo_open did not run, we actually should not send any announcements.

Do we care if carrier on is set on probe or on open?
If not, let's just defer this to ndo_open?


> We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
> QEMU sending the announce_self rapidly while booting.
> 
> [  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
> [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
> [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
> [  494.168260] Call Trace:
> [  494.168329]  <TASK>
> [  494.168389]  __schedule+0x27c/0x6b0
> [  494.168495]  schedule+0x33/0x110
> [  494.168585]  schedule_preempt_disabled+0x15/0x30
> [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
> [  494.168835]  __mutex_lock_slowpath+0x13/0x20
> [  494.168949]  mutex_lock+0x3c/0x50
> [  494.169039]  rtnl_lock+0x15/0x20
> [  494.169128]  netdev_notify_peers+0x12/0x30
> [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
> [  494.169377]  virtnet_probe+0xa48/0xe00
> [  494.169484]  ? vp_get+0x4d/0x100
> [  494.169574]  virtio_dev_probe+0x1e9/0x310
> [  494.169682]  really_probe+0x1c7/0x410
> [  494.169783]  __driver_probe_device+0x8c/0x180
> [  494.169901]  driver_probe_device+0x24/0xd0
> [  494.170011]  __driver_attach+0x10b/0x210
> [  494.170117]  ? __pfx___driver_attach+0x10/0x10
> [  494.170237]  bus_for_each_dev+0x8d/0xf0
> [  494.170341]  driver_attach+0x1e/0x30
> [  494.170440]  bus_add_driver+0x14e/0x290
> [  494.170548]  driver_register+0x5e/0x130
> [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
> [  494.170788]  register_virtio_driver+0x20/0x40
> [  494.170905]  virtio_net_driver_init+0x97/0xb0
> [  494.171022]  do_one_initcall+0x5e/0x340
> [  494.171128]  do_initcalls+0x107/0x230
> [  494.171228]  ? __pfx_kernel_init+0x10/0x10
> [  494.171340]  kernel_init_freeable+0x134/0x210
> [  494.171462]  kernel_init+0x1b/0x200
> [  494.171560]  ret_from_fork+0x47/0x70
> [  494.171659]  ? __pfx_kernel_init+0x10/0x10
> [  494.171769]  ret_from_fork_asm+0x1b/0x30
> [  494.171875]  </TASK>
> 
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> ---
>  drivers/net/virtio_net.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..0290d289ebee 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6211,7 +6211,8 @@ static const struct net_device_ops virtnet_netdev = {
>  	.ndo_tx_timeout		= virtnet_tx_timeout,
>  };
>  
> -static void virtnet_config_changed_work(struct work_struct *work)
> +static void __virtnet_config_changed_work(struct work_struct *work,
> +					  bool check_announce)
>  {
>  	struct virtnet_info *vi =
>  		container_of(work, struct virtnet_info, config_work);

So this will be schedule_announce instead of check_announce?




> @@ -6221,7 +6222,7 @@ static void virtnet_config_changed_work(struct work_struct *work)
>  				 struct virtio_net_config, status, &v) < 0)
>  		return;
>  
> -	if (v & VIRTIO_NET_S_ANNOUNCE) {
> +	if (check_announce && (v & VIRTIO_NET_S_ANNOUNCE)) {
>  		netdev_notify_peers(vi->dev);
>  		virtnet_ack_link_announce(vi);
>  	}
> @@ -6244,6 +6245,11 @@ static void virtnet_config_changed_work(struct work_struct *work)
>  	}
>  }
>  
> +static void virtnet_config_changed_work(struct work_struct *work)
> +{
> +	__virtnet_config_changed_work(work, true);
> +}
> +
>  static void virtnet_config_changed(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi = vdev->priv;
> @@ -7030,7 +7036,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		virtnet_config_changed_work(&vi->config_work);
> +		/* The check_annouce work will get scheduled when ndo_open()
> +		 * doing the virtio_config_driver_enable().
> +		 */
> +		__virtnet_config_changed_work(&vi->config_work, false);
>  	} else {
>  		vi->status = VIRTIO_NET_S_LINK_UP;
>  		virtnet_update_settings(vi);
> 
> base-commit: 2def09ead4ad5907988b655d1e1454003aaf8297
> -- 
> 2.49.0

