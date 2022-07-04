Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B60DC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 19:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 043B7408FB;
	Mon,  4 Jul 2022 19:07:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 043B7408FB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ikVjspmv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2b31u7YZDr5f; Mon,  4 Jul 2022 19:07:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E761408C0;
	Mon,  4 Jul 2022 19:07:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E761408C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C780C0032;
	Mon,  4 Jul 2022 19:07:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99045C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 19:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 719A0410CA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 19:07:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 719A0410CA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ikVjspmv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bb9JacoiY4N8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 19:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 788FA410C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 788FA410C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656961642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D2gi9XsvbFmRpvchivL/m3Dq1jd/AeOLkln+AN3rc6I=;
 b=ikVjspmvTskz89MzMaAdUFkFtVX5pshvog1uWbAYyxZ2sdQA0lbTDLt1jPD8xah1GUPzs5
 x5V10kiDHvrCi1Q6vWi2b6Bbr5J5g8bP0YEqdcSdYx+js7eSfX6oMedAVXm79rdy9qly1X
 AwJj0x7xHWzN6TCNm5pEZZgzGOFNr54=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-Neag9KbLPsiQ-I69g8AD2A-1; Mon, 04 Jul 2022 15:07:21 -0400
X-MC-Unique: Neag9KbLPsiQ-I69g8AD2A-1
Received: by mail-ed1-f72.google.com with SMTP id
 z13-20020a056402274d00b004357fcdd51fso7673538edd.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 12:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D2gi9XsvbFmRpvchivL/m3Dq1jd/AeOLkln+AN3rc6I=;
 b=T4qCknq2ytgE5Yv4HTw94MQIjQRqsJNl0/aTMQR37R59JtvOr8uoavXVu1632ijkHq
 FSSUbuA9IfoQ97Nr+tOB16UnrXTQsIuTadmwygPHec87qCVZo5rIHEXQ3IOwlTQk/l1/
 lCt1+6nl9abyuM2rqJdZkTof+XbGKEWeaylFk+djAIsG9zsQXIjsI0cOZ0kDlhumOMxB
 XbbH1vjkAHIN3tdcT32NRsPzZkRni6akbaCprOMk/zaSpIk8H/xQSkxw53xeF9vE4V+D
 +sM2APx3QPcwBwDjlnGGUhrljN6uvwcurr6ev1xGlXN7FVVDpnzzGh0OVY6YLhs7oTEQ
 e7rg==
X-Gm-Message-State: AJIora9wZ1NvlAXUyRuyuqttewF4jKAbGzydAvdr3r5BtuhtxTe7vgwH
 nYPJsI4tujBSM8B5erRyQTXL0itK2A1Wgd56Ia94kVcty9XJrpd0Y5I/GXBPVDSOJ43UGMHXiaG
 MKWgf20KQv7Wq3dPGK0dIchGeqCSCYfrnmVl0nF2+xw==
X-Received: by 2002:a05:6402:5001:b0:437:8918:8dbe with SMTP id
 p1-20020a056402500100b0043789188dbemr40093048eda.70.1656961640147; 
 Mon, 04 Jul 2022 12:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sRTKxevSLGEYgqLonHWHFDIlgEK+Dm3Q1A/IkjYBGtZpCegln635n3jvgVCXe9lX7kz0vbTg==
X-Received: by 2002:a05:6402:5001:b0:437:8918:8dbe with SMTP id
 p1-20020a056402500100b0043789188dbemr40093023eda.70.1656961639948; 
 Mon, 04 Jul 2022 12:07:19 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 p19-20020aa7cc93000000b0042bdb6a3602sm20930975edt.69.2022.07.04.12.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 12:07:19 -0700 (PDT)
Date: Mon, 4 Jul 2022 15:07:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 1/6] tools/virtio: fix build
Message-ID: <20220704150706-mutt-send-email-mst@kernel.org>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <20220704171701.127665-2-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220704171701.127665-2-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Jul 04, 2022 at 07:16:56PM +0200, Stefano Garzarella wrote:
> Fix the build caused by the following changes:
> - phys_addr_t is now defined in tools/include/linux/types.h
> - dev_warn_once() is used in drivers/virtio/virtio_ring.c
> - linux/uio.h included by vringh.h use INT_MAX defined in limits.h
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Post this separately?

> ---
>  tools/virtio/linux/kernel.h | 2 +-
>  tools/virtio/linux/vringh.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 0b493542e61a..21593bf97755 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -29,7 +29,6 @@
>  #define READ                    0
>  #define WRITE                   1
>  
> -typedef unsigned long long phys_addr_t;
>  typedef unsigned long long dma_addr_t;
>  typedef size_t __kernel_size_t;
>  typedef unsigned int __wsum;
> @@ -136,6 +135,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
>  #endif
>  #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
>  #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
> +#define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
>  
>  #define min(x, y) ({				\
>  	typeof(x) _min1 = (x);			\
> diff --git a/tools/virtio/linux/vringh.h b/tools/virtio/linux/vringh.h
> index 9348957be56e..e11c6aece734 100644
> --- a/tools/virtio/linux/vringh.h
> +++ b/tools/virtio/linux/vringh.h
> @@ -1 +1,2 @@
> +#include <limits.h>
>  #include "../../../include/linux/vringh.h"
> -- 
> 2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
