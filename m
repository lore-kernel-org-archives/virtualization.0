Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CD3C64ED6
	for <virtualization@archiver.kernel.org>; Wed,  1 Mar 2023 14:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 989E641971;
	Wed,  1 Mar 2023 14:44:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 989E641971
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bTk2IXxj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ten51vO7AGH8; Wed,  1 Mar 2023 14:44:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 942404196B;
	Wed,  1 Mar 2023 14:44:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 942404196B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7266CC0035;
	Wed,  1 Mar 2023 14:44:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1622FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 14:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7DF481215
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 14:44:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7DF481215
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bTk2IXxj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L2NXR33Cb7q6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 14:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A30D80FB6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A30D80FB6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677681856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E86jCb8kW1PzrvPSO5dVoBke0amKLBuYHjvi+nJQr9o=;
 b=bTk2IXxjyM8H25glC8AUnI8Nvf7PrGOtJM0U4bFXTraGafQvNNnwqGKMD68lNez2cjCeuD
 b0xuj84RHxU8q8eLhCZzTn2uD+C8RuDKf3BCnYjD60hYCrDECSiRRdEPN4ZS1cEa7wspr2
 oFpOBKMeBwtdnl4AOUlSDrmVrxG+hEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-FWkfAM1nOUOBIzB6yjnoTA-1; Wed, 01 Mar 2023 09:44:15 -0500
X-MC-Unique: FWkfAM1nOUOBIzB6yjnoTA-1
Received: by mail-wm1-f71.google.com with SMTP id
 k20-20020a05600c1c9400b003e2249bd2b4so4641774wms.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Mar 2023 06:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677681854;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E86jCb8kW1PzrvPSO5dVoBke0amKLBuYHjvi+nJQr9o=;
 b=5wS3jzGa54OHRZ/89cNScL3e7mi1vygGAAIZCDL35cM9iEpMQrNRwobiuKCrNOOhbi
 /r04e3ssTpZTMrQPDBFjazDXhr/wr6yhOcs/TfXjzIlumdn1sKW1KlWUPxVm+Iiy2Bac
 Fr2JX7DF/ggJqTbcuRve+u7u66Khh3H98X12h0nMZgcz6qTZtwOsNEqV+YqPwCA5OgM9
 F3r9GoaBOqqtZ1QwsW97XPaJkd9+ATUXkpK243EXjfKzvukRdIPv0BQ8XqnHyI4tyoyj
 bx7LEon2F+xhPn4wtZF8tiZhhxJdaZ4kY9XFqjXE8+CPfEYwTc8QiL4+W421HiNQaU9R
 Aq+g==
X-Gm-Message-State: AO0yUKV/cGxjuc7W6/SJocKjpMO7vojZWQw4+0tH4CTisbEM2KFBJyVp
 Qm5+rPNYGHGtxAN0ZCPyC/9B9r82uSnkiq2+sbfhqBX5BBlwOxoCmpf0C7mxt+OcAwf6iXzHOP6
 UJfqvSFJBJAavL5SmtqZHoTVqFfLW15gWuvw4bIjYiQ==
X-Received: by 2002:a5d:6e09:0:b0:2c7:5247:e496 with SMTP id
 h9-20020a5d6e09000000b002c75247e496mr5056891wrz.60.1677681854203; 
 Wed, 01 Mar 2023 06:44:14 -0800 (PST)
X-Google-Smtp-Source: AK7set8mSY3e1Y8uBNg7J/umChcu632unCjyUQQS2o6WA2kpSEr1P+PNtHKwqRrvNwfJaKiCprzfMA==
X-Received: by 2002:a5d:6e09:0:b0:2c7:5247:e496 with SMTP id
 h9-20020a5d6e09000000b002c75247e496mr5056875wrz.60.1677681853859; 
 Wed, 01 Mar 2023 06:44:13 -0800 (PST)
Received: from redhat.com ([2.52.141.194]) by smtp.gmail.com with ESMTPSA id
 t14-20020adfe44e000000b002c5503a8d21sm13145104wrm.70.2023.03.01.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Mar 2023 06:44:13 -0800 (PST)
Date: Wed, 1 Mar 2023 09:44:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: rbradford@rivosinc.com
Subject: Re: [PATCH v3] virtio-net: Fix probe of virtio-net on kvmtool
Message-ID: <20230301093054-mutt-send-email-mst@kernel.org>
References: <20230223-virtio-net-kvmtool-v3-1-e038660624de@rivosinc.com>
MIME-Version: 1.0
In-Reply-To: <20230223-virtio-net-kvmtool-v3-1-e038660624de@rivosinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Mar 01, 2023 at 01:59:52PM +0000, Rob Bradford via B4 Relay wrote:
> From: Rob Bradford <rbradford@rivosinc.com>
> 
> Since the following commit virtio-net on kvmtool has printed a warning
> during the probe:
> 
> commit dbcf24d153884439dad30484a0e3f02350692e4c
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Tue Aug 17 16:06:59 2021 +0800
> 
>     virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
> 
> [    1.865992] net eth0: Fail to set guest offload.
> [    1.872491] virtio_net virtio2 eth0: set_features() failed (-22); wanted 0x0000000000134829, left 0x0080000000134829
> 
> This is because during the probing the underlying netdev device has
> identified that the netdev features on the device has changed and
> attempts to update the virtio-net offloads through the virtio-net
> control queue. kvmtool however does not have a control queue that supports
> offload changing (VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is not advertised)
> 
> The netdev features have changed due to validation checks in
> netdev_fix_features():
> 
> if (!(features & NETIF_F_RXCSUM)) {
> 	/* NETIF_F_GRO_HW implies doing RXCSUM since every packet
> 	 * successfully merged by hardware must also have the
> 	 * checksum verified by hardware.  If the user does not
> 	 * want to enable RXCSUM, logically, we should disable GRO_HW.
> 	 */
> 	if (features & NETIF_F_GRO_HW) {
> 		netdev_dbg(dev, "Dropping NETIF_F_GRO_HW since no RXCSUM feature.\n");
> 		features &= ~NETIF_F_GRO_HW;
> 	}
> }
> 
> Since kvmtool does not advertise the VIRTIO_NET_F_GUEST_CSUM feature the
> NETIF_F_RXCSUM bit is not present and so the NETIF_F_GRO_HW bit is
> cleared. This results in the netdev features changing, which triggers
> the attempt to reprogram the virtio-net offloads which then fails.
> 
> This commit prevents that set of netdev features from changing by
> preemptively applying the same validation and only setting
> NETIF_F_GRO_HW if NETIF_F_RXCSUM is set because the device supports both
> VIRTIO_NET_F_GUEST_CSUM and VIRTIO_NET_F_GUEST_TSO{4,6}
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
> Changes in v3:
> - Identified root-cause of feature bit changing and updated conditions
>   check
> - Link to v2: https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com
> 
> Changes in v2:
> - Use parentheses to group logical OR of features 
> - Link to v1:
>   https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v1-1-fc23d29b9d7a@rivosinc.com
> ---
>  drivers/net/virtio_net.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61e33e4dd0cd..2e7705142ca5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3778,11 +3778,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			dev->features |= dev->hw_features & NETIF_F_ALL_TSO;
>  		/* (!csum && gso) case will be fixed by register_netdev() */
>  	}
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM)) {
>  		dev->features |= NETIF_F_RXCSUM;
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> -		dev->features |= NETIF_F_GRO_HW;
> +		/* This dependency is enforced by netdev_fix_features */
> +		if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> +		    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> +			dev->features |= NETIF_F_GRO_HW;
> +	}
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
>  		dev->hw_features |= NETIF_F_GRO_HW;
>  

I see. It is annoying that we are duplicating the logic from
netdev_fix_features here though :(
Maybe we should call netdev_update_features, in the callback check
the flags and decide what to set and what to clear?
Or export netdev_fix_features to modules?



Also re-reading Documentation/networking/netdev-features.rst - 

 1. netdev->hw_features set contains features whose state may possibly
    be changed (enabled or disabled) for a particular device by user's
    request.  This set should be initialized in ndo_init callback and not
    changed later.

 2. netdev->features set contains features which are currently enabled
    for a device.  This should be changed only by network core or in
    error paths of ndo_set_features callback.


is it then wrong that virtio sets NETIF_F_RXCSUM and NETIF_F_GRO_HW in
dev->features and not in dev->hw_features? We set it there because
without ctrl guest offload these can not be changed.
I suspect this is just a minor documentation bug yes? Maybe devices
where features can't be cleared are uncommon.

Also:
        if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
                dev->hw_features |= NETIF_F_GRO_HW;

but should we not set NETIF_F_RXCSUM there too?



> ---
> base-commit: c39cea6f38eefe356d64d0bc1e1f2267e282cdd3
> change-id: 20230223-virtio-net-kvmtool-87f37515be22
> 
> Best regards,
> -- 
> Rob Bradford <rbradford@rivosinc.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
