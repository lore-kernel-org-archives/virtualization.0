Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6097C433B4
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 16:00:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7060C6113A
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 16:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7060C6113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31F5F4196F;
	Thu,  8 Apr 2021 16:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BI7ZF3HFnaOM; Thu,  8 Apr 2021 16:00:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8126F404F0;
	Thu,  8 Apr 2021 16:00:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5997EC000B;
	Thu,  8 Apr 2021 16:00:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BBA8C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D69360DE8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZQb7Ik_7F_8G
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:00:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28D99606EC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617897604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PNTuOs8cwmVPsb+XPqRB51lDxbRlJnUP7klH9+xffsY=;
 b=RlAYxJ85yy7pXQNicDShjHZInxuOLNNuC+3AvKOKP7568raqBUvp24apiKhvWrW1pLmxSU
 89sMu7HliA/dUu/vYaMMd0CjHOqQKW5DNbW3Jtc6xCrGmAYLNdhEr2woRBGqkEgwbvwQhI
 Gnd5mV7aH8EjuDNLKn4fF0Q1/sKPIOc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-3MzJKcW9M1-ndDudt15UAg-1; Thu, 08 Apr 2021 12:00:02 -0400
X-MC-Unique: 3MzJKcW9M1-ndDudt15UAg-1
Received: by mail-wm1-f69.google.com with SMTP id b20so590159wmj.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Apr 2021 09:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PNTuOs8cwmVPsb+XPqRB51lDxbRlJnUP7klH9+xffsY=;
 b=py42B5iszkMag3ngqzCKhcOqkkZChXExErBAXVianC0RxNQ/EytZ6v4PABoRscP8/E
 w9Tce5WLB8q/mqYhEG7z3TKq93aaRcO8JKbv/Y3TZwppHUO4bIZUJMk9eFeokIQ59gtq
 oXiiEXiNTX6UWDvrfxF4kP05pbvqlGkwRiW+N4NA3vgoHdswWM0gza1mFsRr0TzJXm2J
 nYFCH0KXfaXI8hUYjK5bDP0ACiNJulFwZbT2JIHzTUKN/cUksW0CKCruBEyNCbXeHnAE
 fFzyEjq1Sa1FI9vrFkvqfXo5iiTjHYDSwXKoUcIRwVWGSA4fampzp+NlnKVJUEbqv/UE
 36RA==
X-Gm-Message-State: AOAM533m7vQSY+XgxS/Ap5CjtgoKhMAgv6FcFGdyzrVi3vAtYtgSdbb8
 4zJEELYi3UEX+sJ2WyNDfQFspjNcBIGI8z//itI4NQsJGknGez8AJNGaoEXVKbN/ki/iSltWVL7
 kYVPSa3LQNqtPpgFgtK2BeCsKcdQ+KqyC0FPGrxHVrg==
X-Received: by 2002:a05:600c:2e53:: with SMTP id
 q19mr9436931wmf.187.1617897599783; 
 Thu, 08 Apr 2021 08:59:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqoM3onIvGeRXWXv4QE785/eHcNM4dldKx3uveQOhko4iWcZKhOBw/s+pXUoh6UaqBx9fHKw==
X-Received: by 2002:a05:600c:2e53:: with SMTP id
 q19mr9436917wmf.187.1617897599571; 
 Thu, 08 Apr 2021 08:59:59 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id j14sm47053447wrw.69.2021.04.08.08.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 08:59:59 -0700 (PDT)
Date: Thu, 8 Apr 2021 11:59:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210408115834-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210408082648.20145-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
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

On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> This patch mandates 1.0 for vDPA devices. The goal is to have the
> semantic of normative statement in the virtio spec and eliminate the
> burden of transitional device for both vDPA bus and vDPA parent.
> 
> uAPI seems fine since all the vDPA parent mandates
> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> 
> For legacy guests, it can still work since Qemu will mediate when
> necessary (e.g doing the endian conversion).
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hmm. If we do this, don't we still have a problem with
legacy drivers which don't ack 1.0?
Note 1.0 affects ring endianness which is not mediated in QEMU
so QEMU can't pretend to device guest is 1.0.





> ---
>  include/linux/vdpa.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 0fefeb976877..cfde4ec999b4 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -6,6 +6,7 @@
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/vhost_iotlb.h>
> +#include <uapi/linux/virtio_config.h>
>  
>  /**
>   * vDPA callback definition.
> @@ -317,6 +318,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>  {
>          const struct vdpa_config_ops *ops = vdev->config;
>  
> +        /* Mandating 1.0 to have semantics of normative statements in
> +         * the spec. */
> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> +		return -EINVAL;
> +
>  	vdev->features_valid = true;
>          return ops->set_features(vdev, features);
>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
