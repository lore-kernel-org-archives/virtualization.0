Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A2FC433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 07:10:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E73E64DF2
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 07:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E73E64DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B50C83C54;
	Wed, 24 Feb 2021 07:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNzwznBQ3H63; Wed, 24 Feb 2021 07:10:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A433983C02;
	Wed, 24 Feb 2021 07:10:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79922C000B;
	Wed, 24 Feb 2021 07:10:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42158C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 304C583C23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17PgUAC6eK9d
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:10:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0648483C02
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614150637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLsZvKK89uHvhsAsSxSj4+kD+s70nvLC/i1ABZOf4UA=;
 b=ESdhVLydBNLOLzp7iyO9nE/i1BD9sh/b267mDLP7x66pGylIicXIzUSQyid26k0E+V7Yhf
 fxRWFSZq/QCS/0l9GgKHqkd44DF7Yb5tLN116FcoNg8gJqY0+1LQmYwnqWS+pufS3+TX2c
 8PFOs3zoZLnrwX3fxjdbRcjMBU6fE/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-6vlR5hIeMC6aNd0fluxSbw-1; Wed, 24 Feb 2021 02:10:33 -0500
X-MC-Unique: 6vlR5hIeMC6aNd0fluxSbw-1
Received: by mail-wr1-f72.google.com with SMTP id p15so623629wro.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 23:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LLsZvKK89uHvhsAsSxSj4+kD+s70nvLC/i1ABZOf4UA=;
 b=TmtJx28UheO/0dpSWDX7U7JkQCrzpskBlcIj5GKSABW3F1hn8qrEpWriRa9Tpku6IL
 Y+Vp89ZgTLBl18zsYLQDq/2SXix7btJ7k7mYMncaL3akuT95k6LdiLGZbg4fc7hbsiTr
 3rYrRXXbFt40hbUZVguXQEr+DWA2eYUyrcRCkAdZKRYxeajiRZIoS+KqlTX0KSTe1+ki
 hgLG7b/Q4jw01EZHiLk6pmpUY7RLOdFrTDJ+jP0kd8ooNGa/PRadwD3IsRvUQyXOwIsI
 WBlFOTwjjVOLYzFptcyyF9OMZ4sGr98KnFi1u9WMhsjYglLqcqdRNVGlGIyhWV9Ysjmk
 ZOng==
X-Gm-Message-State: AOAM530usEq/8TBD5zTyWypHSY9fTE2+5qZcUGTH9u3FvvkIAM8pGuWg
 rslZjGfxH8U9Zqyc7rlA4taWd6mNIJT7x5dWnpCHtjD4/oec9mWZioIEbPgAMHcHO0ctMPnLyoC
 N9/Z05/l0rgkmvN2Vi9FXQX27eRdB6H09+hguV3WnJA==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr30188331wrv.143.1614150632307; 
 Tue, 23 Feb 2021 23:10:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXX0xyWfqsk7yylROSSyFVPaGJwilqpbm2m1q4sLg54ERA6vOI7LE6mmjrrKZtU8M0RUzXGw==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr30188319wrv.143.1614150632197; 
 Tue, 23 Feb 2021 23:10:32 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id 75sm1382913wma.23.2021.02.23.23.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 23:10:31 -0800 (PST)
Date: Wed, 24 Feb 2021 02:10:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next 1/9] vdpa_sim: Consider read only supported
 features instead of current
Message-ID: <20210224020336-mutt-send-email-mst@kernel.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210224061844.137776-2-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org
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

On Wed, Feb 24, 2021 at 08:18:36AM +0200, Parav Pandit wrote:
> To honor VIRTIO_F_VERSION_1 feature bit, during endianness detection,
> consider the read only supported features bit instead of current
> features bit which can be modified by the driver.
> 
> This enables vdpa_sim_net driver to invoke cpu_to_vdpasim16() early
> enough just after vdpasim device creation in subsequent patch.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>

Well that works for legacy and modern devices but not for transitional
ones. Without transitional device support vendors are reluctant to add
modern features since that will break old guests ...  I suspect we need
to either add a new ioctl enabling modern mode, or abuse SET_FEATURES
and call it from qemu on first config space access.

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 6d75444f9948..176d641a0939 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -11,6 +11,7 @@
>  #include <linux/virtio_byteorder.h>
>  #include <linux/vhost_iotlb.h>
>  #include <uapi/linux/virtio_config.h>
> +#include <linux/bits.h>
>  
>  #define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
>  				 (1ULL << VIRTIO_F_VERSION_1)  | \
> @@ -71,7 +72,8 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr);
>  static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
>  {
>  	return virtio_legacy_is_little_endian() ||
> -		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
> +		(vdpasim->dev_attr.supported_features &
> +		 BIT_ULL(VIRTIO_F_VERSION_1));
>  }
>  
>  static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
