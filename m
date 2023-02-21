Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8384EC636D7
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 17:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1170A611B8;
	Tue, 21 Feb 2023 17:21:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1170A611B8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SwZmBmbS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHuR15DtCIkr; Tue, 21 Feb 2023 17:21:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B7C361199;
	Tue, 21 Feb 2023 17:21:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B7C361199
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65768C0032;
	Tue, 21 Feb 2023 17:21:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74A29C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 17:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EBA942CDD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 17:21:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EBA942CDD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SwZmBmbS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iGjTXGIbvlhY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 17:21:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27B5C42CDC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27B5C42CDC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677000086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/m8VwT5q+IEQCUF2d/PwSBsc8aImFdA/guFZRJFeDAM=;
 b=SwZmBmbSRwRHysDUfprF83nba/UJiRV5v/CungP3Z7nsGVVusHTj6WC8FRrA/0LEv2HDNm
 JgSgl50rN52rJxfEQceiPPROo+8uIBhQ8lgbhbdjlEwyQ0swtNZGn2zhpCVXIfM4Cw1+Uy
 28lH6ZkpLpW+2ssUV9m74QMcstrrTHc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-ZtF93JwFP4GSfmf-ScRUWA-1; Tue, 21 Feb 2023 12:21:22 -0500
X-MC-Unique: ZtF93JwFP4GSfmf-ScRUWA-1
Received: by mail-wm1-f72.google.com with SMTP id
 c15-20020a05600c0a4f00b003ddff4b9a40so2128123wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 09:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/m8VwT5q+IEQCUF2d/PwSBsc8aImFdA/guFZRJFeDAM=;
 b=oGBtsj1qsXYyoDki+S0oYt2Gt5OgCCl/Hq1UJaoglS8uAbWZtuuz+/xZd2sv469C+A
 0fO1rF/FGQnaw8FKOaYiLOIQt5lH/0419nqG81KbCCFSOwMp/sa7GGvZFm+jFck1ROct
 lC0x2WGvfDmy7uGGBouv8EjVBXuG8DUD8Bb0e3o3dH0FEcYRWdHVAFopmRgV6GdOXilq
 pBd8VDLp4MDEgkUBn3ZegVJ9XgsEhIgYTHqjNdE+DQvUKXKiqiktCXQMpk0DVMX0VDSN
 mFmmmtF2O1Hs4kM4iXClryW8genWlHkHTbmO08LspbZ/Hct7Qp5HDZvU0Vg2Sv1ePkA5
 VvDQ==
X-Gm-Message-State: AO0yUKVeVe1XKhFeRUFeS5pee+7WHBaIMrSwdBpyj6myqHAOvbCwjI7R
 Z600fqd37XdD17Z0u1UBC0E8f2oheLpeoa0zHbiOsgGPBSk7QITB8dVIepuJKVQvRt72ggTrbqC
 lAeONp/86h93cP2W9P41xMKbuE8yVLv+wMPYNu1iIPw==
X-Received: by 2002:a5d:410b:0:b0:2c5:58f5:3c40 with SMTP id
 l11-20020a5d410b000000b002c558f53c40mr3878921wrp.47.1677000081317; 
 Tue, 21 Feb 2023 09:21:21 -0800 (PST)
X-Google-Smtp-Source: AK7set92PXvkKYybMFyuZBNH8dfngZt4TBEFZfWE8mDOCU9ySWWLv5BCvRdTh2TqIrRRJv/2MGUtiA==
X-Received: by 2002:a5d:410b:0:b0:2c5:58f5:3c40 with SMTP id
 l11-20020a5d410b000000b002c558f53c40mr3878911wrp.47.1677000081017; 
 Tue, 21 Feb 2023 09:21:21 -0800 (PST)
Received: from redhat.com ([2.52.2.78]) by smtp.gmail.com with ESMTPSA id
 p7-20020a5d48c7000000b002c3d29d83d2sm4284356wrs.63.2023.02.21.09.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 09:21:20 -0800 (PST)
Date: Tue, 21 Feb 2023 12:21:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Message-ID: <20230221121543-mutt-send-email-mst@kernel.org>
References: <20230221144741.316477-1-jiri@resnulli.us>
MIME-Version: 1.0
In-Reply-To: <20230221144741.316477-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: vmireyno@marvell.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Tue, Feb 21, 2023 at 03:47:41PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> set implicates that the driver provides the exact size of the header.

OK but I feel this is not the important point. The important points are:
- this bit means device needs this info
- driver also has to set this bit
For example one might replace above with:

	Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
	which when set implicates that device benefits from knowing the exact
	size of the header. For compatiblity, to signal to the device that the header
	is reliable driver also needs to set this feature.
	Without this feature set by driver, device has to figure
	out the header size itself.

and the below is ok.

> Quoting the original virtio spec:
> "hdr_len is a hint to the device as to how much of the header needs to
>  be kept to copy into each packet"
> 
> "a hint" might not be clear for the reader what does it mean, if it is
> "maybe like that" of "exactly like that". This feature just makes it
> crystal clear and let the device count on the hdr_len being filled up
> by the exact length of header.
> 
> Also note the spec already has following note about hdr_len:
> "Due to various bugs in implementations, this field is not useful
>  as a guarantee of the transport header size."
> 
> Without this feature the device needs to parse the header in core
> data path handling. Accurate information helps the device to eliminate
> such header parsing and directly use the hardware accelerators
> for GSO operation.
> 
> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> The driver already complies to fill the correct value. Introduce the
> feature and advertise it.
> 
> Note that virtio spec also includes following note for device
> implementation:
> "Caution should be taken by the implementation so as to prevent
>  a malicious driver from attacking the device by setting
>  an incorrect hdr_len."
> 
> There is a plan to support this feature in our emulated device.
> A device of SolidRun offers this feature bit. They claim this feature
> will save the device a few cycles for every GSO packet.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

I'm fine with patch itself. with commit log tweak:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> v1->v2:
> - extended patch description
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
