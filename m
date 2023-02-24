Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0C9C64ED8
	for <virtualization@archiver.kernel.org>; Fri, 24 Feb 2023 08:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF45C60E86;
	Fri, 24 Feb 2023 08:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF45C60E86
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DxSGJuZT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aCXXp3cWSXgY; Fri, 24 Feb 2023 08:25:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F2F660E7A;
	Fri, 24 Feb 2023 08:25:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F2F660E7A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 314DFC0032;
	Fri, 24 Feb 2023 08:25:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 579AEC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 08:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EFAE40550
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 08:25:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EFAE40550
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DxSGJuZT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eCxX6BXyle9y
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 08:25:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB8D24051C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB8D24051C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 08:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677227118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1W3jI18Ol3sw6DqC+LMvzH80d9+CkyCSgdVYfhjlHU=;
 b=DxSGJuZTSW5kN1Gi6loX5NgfpvamZUmfhuFpf5Hn1esGxwW8DavjoGrl9mYTcjv4laqCdN
 IL4TwK48SrfhbvM1Tk72qKaE82oymoM6epQQIkXdZ8G38GvkBE84WCdByn5UziIVrFii+d
 EdUC+6c0J6f39ihWUZE4rkdqH9g8xJ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-GZhZ2FS5OQ2-vc5GAiS1Jg-1; Fri, 24 Feb 2023 03:25:17 -0500
X-MC-Unique: GZhZ2FS5OQ2-vc5GAiS1Jg-1
Received: by mail-wm1-f69.google.com with SMTP id
 j32-20020a05600c1c2000b003e9bdf02c9fso913951wms.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 00:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1W3jI18Ol3sw6DqC+LMvzH80d9+CkyCSgdVYfhjlHU=;
 b=jApqQ7JK4Jn1QRYR/FLCxR1O79KIUi40C29MNHG9Dqx7JBCwXlsiQOsRw8oNbFZxd/
 3MXXERtBHZhQ3GnYP0xk6a/CflfZHkJydo9E4m0kVQbQ4v8ausvezcKGz0Ylatj175hU
 O4sQinTsPpqke1JgR4k3CDTOphX+l0qKfT5+3RU5QL0n8eVShS5el41qcQAYNVt4GeSG
 CyefLtySluu4mv2FuJgVMOLY/0eM57l6QzRBedPtAXMGS40I9h5T9Dz6yo7uHj98B5mF
 BRrpXsMvS1ZIdTzchEzCR14PSyOepvfP9RxigTfDqQ0T5jOt4H05hnVcBm0whvIBC5/a
 jLnw==
X-Gm-Message-State: AO0yUKXcxGUx02gZiQwWWf5ff0L9LT/bVv384Po8MIoq30pgzEn8N+Jr
 QITOkLHkvWXR4+v2uYhFLsttQ2F9pKqJcHLIikDzziXoklHA5bb2hcAGhf2VvGhr8kHpC/DOrGs
 oxt+ithvjDd5+47eLJFH5ZSwgulARb0M10W6A0G2TDA==
X-Received: by 2002:adf:ee4f:0:b0:2c7:1c08:1224 with SMTP id
 w15-20020adfee4f000000b002c71c081224mr1628705wro.29.1677227115946; 
 Fri, 24 Feb 2023 00:25:15 -0800 (PST)
X-Google-Smtp-Source: AK7set+h0Q7ERAnJwpkJ6HirjyyhDbxWWMeG9atCKfDjQQWWffqd+OeTYMlx9rmh9c2GF8h0QSmFvw==
X-Received: by 2002:adf:ee4f:0:b0:2c7:1c08:1224 with SMTP id
 w15-20020adfee4f000000b002c71c081224mr1628686wro.29.1677227115641; 
 Fri, 24 Feb 2023 00:25:15 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:a3e9:76f3:3a96:2a:eb18])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a5d698b000000b002c5a1bd5280sm13137905wru.95.2023.02.24.00.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Feb 2023 00:25:15 -0800 (PST)
Date: Fri, 24 Feb 2023 03:25:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: rbradford@rivosinc.com
Subject: Re: [PATCH v2] virtio-net: Fix probe of virtio-net on kvmtool
Message-ID: <20230224031932-mutt-send-email-mst@kernel.org>
References: <20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com>
MIME-Version: 1.0
In-Reply-To: <20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com>
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

On Thu, Feb 23, 2023 at 07:38:25PM +0000, Rob Bradford via B4 Relay wrote:
> From: Rob Bradford <rbradford@rivosinc.com>
> 
> kvmtool does not support the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature
> but does advertise the VIRTIO_NET_F_GUEST_TSO{4,6} features. Check that
> the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is present before setting
> the NETIF_F_GRO_HW feature bit as otherwise an attempt will be made to
> program the virtio-net device using the ctrl queue which will fail.
> 
> This resolves the following error when running on kvmtool:
> 
> [    1.865992] net eth0: Fail to set guest offload.
> [    1.872491] virtio_net virtio2 eth0: set_features() failed (-22); wanted 0x0000000000134829, left 0x0080000000134829
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
> Changes in v2:
> - Use parentheses to group logical OR of features 
> - Link to v1:
>   https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v1-1-fc23d29b9d7a@rivosinc.com
> ---
>  drivers/net/virtio_net.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61e33e4dd0cd..f8341d1a4ccd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3780,10 +3780,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
>  		dev->features |= NETIF_F_RXCSUM;
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> -		dev->features |= NETIF_F_GRO_HW;
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> +	if ((virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6)) &&
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
>  		dev->hw_features |= NETIF_F_GRO_HW;

This will disable GRO/LRO on kvmtool completely causing a significant
performance regression.

Jason, isn't this what
	commit dbcf24d153884439dad30484a0e3f02350692e4c
	Author: Jason Wang <jasowang@redhat.com>
	Date:   Tue Aug 17 16:06:59 2021 +0800

	    virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO

was supposed to address?


And apropos this:
    
    Fix this by using NETIF_F_GRO_HW instead. Though the spec does not
    guarantee packets to be re-segmented as the original ones,
    we can add that to the spec, possibly with a flag for devices to
    differentiate between GRO and LRO.

this never happened. What's the plan exactly?




>  	dev->vlan_features = dev->features;
> 
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
