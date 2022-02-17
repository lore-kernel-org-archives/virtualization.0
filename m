Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEFAC433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 21:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 538BC83DF8;
	Thu, 17 Feb 2022 21:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RsEno_ISGXy9; Thu, 17 Feb 2022 21:45:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BF8C581B35;
	Thu, 17 Feb 2022 21:45:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64FFBC0021;
	Thu, 17 Feb 2022 21:45:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F24DC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 21:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D47D6F6FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 21:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GMK74irRr1J0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 21:45:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F2BE61C50
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 21:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645134350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nj4FalB6xoie1yj2BhEvitAxGiZEQy+yTjT2u4pERlM=;
 b=e7joZCjavB92D2/odM62imLaN0matj94oyGxqE7K8EZSmjwuvEXH4JKdh0o0uy9WOHPvBP
 eLbNMz+fNOe0EeePMMbJ0tMmLDTchdvU2KRKGewNNgpzg/0w3SYEmSm78YasK6z8vEbILW
 HTIAa/gScqUdvzEbMXd1nkiMWbfXuoA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-L5a2FpbtN4S3_nuwxzLDWw-1; Thu, 17 Feb 2022 16:45:49 -0500
X-MC-Unique: L5a2FpbtN4S3_nuwxzLDWw-1
Received: by mail-ed1-f72.google.com with SMTP id
 g5-20020a056402090500b0040f28e1da47so4344810edz.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 13:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nj4FalB6xoie1yj2BhEvitAxGiZEQy+yTjT2u4pERlM=;
 b=oS9bWoRROeE5q+mKhkz2hjaL3e2+/w7XeB0FeqRvBi662l1MSYCVAPZTVftKJHxjs5
 YiHyj24vcJhWBqRpvrLm+XB7Jv+en/N2kfwJDJ2HLntsyfW0XfizcgoltEbbNh/8oDBW
 8QIkQ0ler7v7mBv0CHx1Fv3Lr6fPcUxnE7LKq/7ju6ZIA904EuIhkJKqGi4apSi4sk1X
 TJ0rXu9YX+uNNeH64t7aCqcB0PbQX912pHK1CC0mrVj2Q6uIJIxWjjSCbeuDGW+7P0dY
 yi0T+m1pk6t5jmqZNSZ8KjX6S1UQAXzi6XtnGn8s0v5AEVOl9Q0YwQbLCGMXerMG0NtO
 ewPQ==
X-Gm-Message-State: AOAM5314BnbIVoEkVc3dXRDwwPqo698Xip96mkuadrmHppY/N6WWjvPS
 SX7O5uu9bWUgt1PqsCnrKeJk0iFF7N/7FPErMDdtqRhf9jmrWnHB8KCzl+H7gxAgYSJu8HhY1KF
 +xo0K11GuFI2BgpZ6WSgywlKeYM/OMQPTotqWxdWA7g==
X-Received: by 2002:a17:906:d977:b0:6ce:7097:b8ab with SMTP id
 rp23-20020a170906d97700b006ce7097b8abmr3818000ejb.766.1645134347892; 
 Thu, 17 Feb 2022 13:45:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJazbRh9bE5kMHBhaitWBnbfRyqZ7X89hoRVLQ5975AFcbMobjPlecHxxnXrftMs1acIovdg==
X-Received: by 2002:a17:906:d977:b0:6ce:7097:b8ab with SMTP id
 rp23-20020a170906d97700b006ce7097b8abmr3817983ejb.766.1645134347621; 
 Thu, 17 Feb 2022 13:45:47 -0800 (PST)
Received: from redhat.com ([2.55.156.211])
 by smtp.gmail.com with ESMTPSA id ek21sm3532878edb.27.2022.02.17.13.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 13:45:46 -0800 (PST)
Date: Thu, 17 Feb 2022 16:45:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Edward Cree <edward.cree@xilinx.com>
Subject: Re: [PATCH] virtio: Add definition for VIRTIO_F_NOTIFICATION_DATA
 feature flag
Message-ID: <20220217164356-mutt-send-email-mst@kernel.org>
References: <20220217095545.195426-1-elic@nvidia.com>
 <20220217064512-mutt-send-email-mst@kernel.org>
 <b52aebae-44c8-fb4a-f7f3-6da7cd4075fc@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <b52aebae-44c8-fb4a-f7f3-6da7cd4075fc@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 eperezma@redhat.com, si-wei.liu@oracle.com, Eli Cohen <elic@nvidia.com>,
 radovano@xilinx.com
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

On Thu, Feb 17, 2022 at 06:22:25PM +0000, Edward Cree wrote:
> On 17/02/2022 11:49, Michael S. Tsirkin wrote:
> > On Thu, Feb 17, 2022 at 11:55:45AM +0200, Eli Cohen wrote:
> >> This is required by iproute2 to display the capabilities of a vdpa based
> >> virtio device.
> >>
> >> Previously, drivers/net/ethernet/sfc/mcdi_pcol.h made use of a private
> >> definition of this flag. Modify the definition to rely on the new
> >> generic definition.
> >>
> >> Signed-off-by: Eli Cohen <elic@nvidia.com>
> >> ---
> >>  drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
> >>  include/uapi/linux/virtio_config.h   | 6 ++++++
> >>  2 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
> >> index d3fcbf930dba..2603e04dae06 100644
> >> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
> >> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
> >> @@ -21477,7 +21477,7 @@
> >>  #define        VIRTIO_BLK_CONFIG_VIRTIO_F_SR_IOV_LBN 37
> >>  #define        VIRTIO_BLK_CONFIG_VIRTIO_F_SR_IOV_WIDTH 1
> >>  #define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_OFST 0
> >> -#define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_LBN 38
> >> +#define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_LBN VIRTIO_F_NOTIFICATION_DATA
> >>  #define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_WIDTH 1
> >>  #define       VIRTIO_BLK_CONFIG_FEATURES_LBN 0
> >>  #define       VIRTIO_BLK_CONFIG_FEATURES_WIDTH 64
> > 
> > I don't think we need to bother with macros in mcdi_pcol.h - that header
> > is generated by some kind of script, this probably is why it has
> > all these macros that are otherwise unused.
> > 
> > Cc Edward Cree who added them - Edward, is there a way to
> > get rid of VIRTIO_ macros inmcdi_pcol.h?
> 
> mcdi_pcol.h is indeed generated, and is shared with the MCPU firmware
>  which implements the other side of the MCDI protocol, so I don't know
>  whether we'd be able to carry these kind of changes; every difference
>  between the upstream and internal/fw versions makes for ongoing
>  maintenance pain.  (And obviously Linux' virtio_config.h isn't
>  available to our firmware build.)
> Do these macro definitions lead to any immediate conflicts (if both
>  headers are included), or is it just the worry that conflicts could
>  arise in the future since these #defines aren't EFX_ namespaced?

The latter. One simple way would be ifndef __KERNEL__ around virtio
things in the header.

> If the latter, I would be tempted to leave well alone for now; only
>  sfc driver code is ever likely to #include mcdi_pcol.h, so a proper
>  resolution can safely wait until sfc vDPA support is upstreamed.
> CCing Aleksandar Radovanovic who originally added them internally, in
>  case he has anything to add.  Also CCing Gautam Dawar who is working
>  on vDPA support in the sfc driver.
> 
> -ed
> 
> > 
> >> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> >> index b5eda06f0d57..30eb76dcdcad 100644
> >> --- a/include/uapi/linux/virtio_config.h
> >> +++ b/include/uapi/linux/virtio_config.h
> >> @@ -92,4 +92,10 @@
> >>   * Does the device support Single Root I/O Virtualization?
> >>   */
> >>  #define VIRTIO_F_SR_IOV			37
> >> +
> >> +/* When negotiated, indicates that the driver can pass extra data beyond
> >> + * virtqueue identification when sending notifications
> >> + */
> >> +#define VIRTIO_F_NOTIFICATION_DATA	38
> >> +
> >>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> >> -- 
> >> 2.32.0
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
