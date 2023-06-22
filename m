Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E0EB64D8
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 11:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC14441FAC;
	Thu, 22 Jun 2023 11:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC14441FAC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Et4xGHTB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RZQt-Ckz3GUn; Thu, 22 Jun 2023 11:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD8E140953;
	Thu, 22 Jun 2023 11:37:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD8E140953
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71487C0037;
	Thu, 22 Jun 2023 11:37:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9EAAC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 11:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F87241D8B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 11:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F87241D8B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jIKECGSBCYmq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 11:37:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90C0E40953
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90C0E40953
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687433838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W7SKEzo0tiPtjA/r8jOe2vPyIc6DKSYtWpFv1BZVSgU=;
 b=Et4xGHTBY5geu4WiDFyWr0DhpLyP73vfB026rF5OrfHiW8qUNFaOFrKwSjwBSDj2aZgIoq
 BGCdl1o84fq5xeBW5HQFzrczWyldj9rC8hlJ+0mWs6HuVT9JzONXw7BlLrq5xjeS9H8+Vl
 Nkr+wO/S6Q8010k1SpogzoXqoGnrcG0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-tULdWKhGPQ2-iUgoCMMeew-1; Thu, 22 Jun 2023 07:37:17 -0400
X-MC-Unique: tULdWKhGPQ2-iUgoCMMeew-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-988e344bed9so328349366b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 04:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687433836; x=1690025836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7SKEzo0tiPtjA/r8jOe2vPyIc6DKSYtWpFv1BZVSgU=;
 b=aZGrSDQV76f9jxNgkUl9SwKQKxu2rUJpnNF4G/jDJSE4GyD512yi6tvq3UBcG428Rj
 P9Bp7BNJIERZR8O0UXa/UW5hnrvuksMArF/dC5xVC0+ma7NBBgjZoAbHidP9qb0S5V+B
 JN9hYFD9sxYc0RKNCU9rjZUtwL5GaL40VoNKz3JqS5U+cEohShz2P5HMsRln46wFm7Ik
 Up8N59JdACX5D6b6ckY3U/jy2al7b3jvNayAMYIlYSLVp0hFLJi0BzX4xDWQx77Yache
 PHrJqajgNxMRCp+kKOxTw5sOpKhMGN9rOtc6U7RNSySIswlzodIaMdymh6IcXalAHWJd
 l4VA==
X-Gm-Message-State: AC+VfDxpMwL7y8WpCqdGPN0HHGfkwZmXbYMh+MR5/uef8rPjICXLuWsH
 SUMNh22HrDNaDJ2+Qm99r9fyxi7wibF5JZPSKKz3nh2gb5EPgsax5i+b7K2LBtvAfpapWsr/aTI
 RyHXXkywrJJ0wMb3bddcbzxj24sKXyNcI3NH+gHkuxQ==
X-Received: by 2002:a17:907:9810:b0:96f:bcea:df87 with SMTP id
 ji16-20020a170907981000b0096fbceadf87mr18311951ejc.42.1687433836424; 
 Thu, 22 Jun 2023 04:37:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+6ZFEmHAogYeFG0AWvOJXQRz4NqoLSKP89l/++Hp1rS3Ll408wTBVz5tejEgoel33u4yaOA==
X-Received: by 2002:a17:907:9810:b0:96f:bcea:df87 with SMTP id
 ji16-20020a170907981000b0096fbceadf87mr18311937ejc.42.1687433836129; 
 Thu, 22 Jun 2023 04:37:16 -0700 (PDT)
Received: from redhat.com ([2.52.159.126]) by smtp.gmail.com with ESMTPSA id
 l11-20020a170906644b00b00988956f244csm4586680ejn.6.2023.06.22.04.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 04:37:15 -0700 (PDT)
Date: Thu, 22 Jun 2023 07:37:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230622073625-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230605110644.151211-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> don't support packed virtqueue well yet, so let's filter the
> VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> 
> This way, even if the device supports it, we don't risk it being
> negotiated, then the VMM is unable to set the vring state properly.
> 
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

OK so for now I dropped this, we have a better fix upstream.

> ---
> 
> Notes:
>     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>     better PACKED support" series [1] and backported in stable branches.
>     
>     We can revert it when we are sure that everything is working with
>     packed virtqueues.
>     
>     Thanks,
>     Stefano
>     
>     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
> 
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 8c1aefc865f0..ac2152135b23 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -397,6 +397,12 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>  
>  	features = ops->get_device_features(vdpa);
>  
> +	/*
> +	 * IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE) don't support
> +	 * packed virtqueue well yet, so let's filter the feature for now.
> +	 */
> +	features &= ~BIT_ULL(VIRTIO_F_RING_PACKED);
> +
>  	if (copy_to_user(featurep, &features, sizeof(features)))
>  		return -EFAULT;
>  
> 
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> -- 
> 2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
