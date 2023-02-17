Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC5BC636D4
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 12:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FE686176B;
	Fri, 17 Feb 2023 12:22:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FE686176B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NQH57tKs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aJpNMGukBEKv; Fri, 17 Feb 2023 12:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C905D60E66;
	Fri, 17 Feb 2023 12:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C905D60E66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3B6AC0033;
	Fri, 17 Feb 2023 12:22:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5811C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1D3541A10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:22:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1D3541A10
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NQH57tKs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5L6aWnQ4sF6r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:22:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 359BC41902
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 359BC41902
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676636531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbZ6lg0zzAJJ7VsgOJE+0XQphc+KxOOGhEwY/SdO60g=;
 b=NQH57tKsZfg/1xuTjb255MX7ifi+6AdxaF58loFH3AwO8UyrVg6Ma5YqCC8StnwHs0BKVN
 Q1XLPRdkQlnfJaL2WqNJkY32Af2kKxHHnJ1hfJi+iGJOxmips9T6X+vRlDzDVPUGdsjS2o
 /RJvz39cSGpgt6eo8UBjIvbi5rO8nyM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-ROuBaOynOJCvtEcr_Msu1g-1; Fri, 17 Feb 2023 07:22:07 -0500
X-MC-Unique: ROuBaOynOJCvtEcr_Msu1g-1
Received: by mail-wm1-f69.google.com with SMTP id
 n2-20020a05600c3b8200b003e10d3e1c23so564553wms.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 04:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbZ6lg0zzAJJ7VsgOJE+0XQphc+KxOOGhEwY/SdO60g=;
 b=5tTMghCZJFTH/o8Om3abVhudFQzlTrwW/5/cF62sRf4o5LbkzHp4krP9lI8iXuk/Ke
 Ul7UorBSw31XsXUmRitjXJTLxkAd68gkjh4+BuB1L3hGQNuyz4GgPhW8rful/FN1cpI9
 dZ8L7lGj/1NdrcZdfF08a8FSPgvz9pr49suzCk6o/JIe37epc6TXaOQiobj8z2F4aAob
 6UTKMY6Ga5K8mo8s0sqMDv3Fzlx4LE92oLwvQXSlV8w2GZgFVkqv5hvN10052v6daDiw
 G5opf111JKqzE4h0np+Gz7YpaCEK1laHkjFmJJQi0n8Xy147FPWc3ezgnb312U7nfGxb
 +jSQ==
X-Gm-Message-State: AO0yUKVmNZ99VR74rMrXvh9nDbUnC2Ni5vaztnMXuiYgG6sFZ3evUGTO
 cVgbjlxCXnEsHBjaLP7gFDZ8MzTGUn7pU0gHBk3oC5Re36EtwhPu/nyc/GzkJAg3SKaQiW0l0yd
 XaeTQH/x9dAM5ptCT7nRLYXajR5cH4GYU51600CY0pg==
X-Received: by 2002:a05:600c:4b1b:b0:3df:fbc7:5b10 with SMTP id
 i27-20020a05600c4b1b00b003dffbc75b10mr341763wmp.0.1676636526333; 
 Fri, 17 Feb 2023 04:22:06 -0800 (PST)
X-Google-Smtp-Source: AK7set9UTlL1W3RpGlRDPzUeP/pLLVc4PJU4+6e4Mtuwsp+LiTCnneeWPFlM/Gc64uI/ChZO+yqEkA==
X-Received: by 2002:a05:600c:4b1b:b0:3df:fbc7:5b10 with SMTP id
 i27-20020a05600c4b1b00b003dffbc75b10mr341749wmp.0.1676636526051; 
 Fri, 17 Feb 2023 04:22:06 -0800 (PST)
Received: from redhat.com ([2.52.5.34]) by smtp.gmail.com with ESMTPSA id
 ay38-20020a05600c1e2600b003dff870ce0esm723720wmb.2.2023.02.17.04.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Feb 2023 04:22:05 -0800 (PST)
Date: Fri, 17 Feb 2023 07:22:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <20230217072032-mutt-send-email-mst@kernel.org>
References: <20230217121547.3958716-1-jiri@resnulli.us>
MIME-Version: 1.0
In-Reply-To: <20230217121547.3958716-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Fri, Feb 17, 2023 at 01:15:47PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> 
> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> set implicates that the driver provides the exact size of the header.
> 
> The driver already complies to fill the correct value. Introduce the
> feature and advertise it.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Could you add a bit of motivation just for the record?
Does this improve performance for some card? By how much?
Expected to help some future card?

thanks!


> ---
>  drivers/net/virtio_net.c        | 6 ++++--
>  include/uapi/linux/virtio_net.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fb5e68ed3ec2..e85b03988733 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_UFO,
>  	VIRTIO_NET_F_GUEST_CSUM,
>  	VIRTIO_NET_F_GUEST_USO4,
> -	VIRTIO_NET_F_GUEST_USO6
> +	VIRTIO_NET_F_GUEST_USO6,
> +	VIRTIO_NET_F_GUEST_HDRLEN
>  };
>  
>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> @@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> -	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
> +	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> +	VIRTIO_NET_F_GUEST_HDRLEN
>  
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index b4062bed186a..12c1c9699935 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -61,6 +61,7 @@
>  #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
>  #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
> +#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
