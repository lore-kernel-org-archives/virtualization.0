Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7F4C77B73
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 07:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0B2C60F9C;
	Wed, 19 Apr 2023 07:35:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0B2C60F9C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cn0r6l8W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CzclMPtAdKLj; Wed, 19 Apr 2023 07:35:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3131660C0B;
	Wed, 19 Apr 2023 07:35:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3131660C0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F02A5C007A;
	Wed, 19 Apr 2023 07:35:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B17D2C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 07:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 84E1041CFE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 07:35:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84E1041CFE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cn0r6l8W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m6hEnGOIMf9F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 07:35:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDE3B403FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDE3B403FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 07:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681889708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X6WZsldECgcH7W7pwyXswAdWrzNZ/jMrMZVb+N3FzJQ=;
 b=Cn0r6l8Wm5Gsls/RAtlNIx3D+Y/1ty5ZuvQvx7kx5pkWj9Ws9DRqdyRQZiMNHD19Z6FM1Q
 3N0XbSQ7vRXeIs4VWjpE0KjqbB66lI9pE1ehIF0ETkfpgvGV1Tt3O2n7swso7m9MS4n+Vi
 Ku/FsJ3JS4WTW3TgB910kw5aB9aXEaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-yspVBPArMG6OhM2HYQriYA-1; Wed, 19 Apr 2023 03:35:07 -0400
X-MC-Unique: yspVBPArMG6OhM2HYQriYA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f09f2d0febso10761155e9.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 00:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681889706; x=1684481706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6WZsldECgcH7W7pwyXswAdWrzNZ/jMrMZVb+N3FzJQ=;
 b=UNZUibwVbJI+ilnuv/ESL/ojHRWVZcDQuYBcEgc6KxFPEKwtbVgmIUYpF0yESXnYoI
 XFymX8N3FZtd5T/ZPgrsMfzbH8m3oN1xPyS4aDzk0oxnVbZwsl9pzxvAkM+e/gtPJcxV
 azniELOVOMVevKun+2CwQtoG1bgMP4OuYT8uplQrmMBo2mjk2bEiC4EaO4wMATdpTk/8
 vByKhcvHQ7uK8RIyZ5GgEs/f1yKaaBZurpRCXl+KIo/3zrKhRxzQtFe60lrWAe/uRKeG
 iWQ3MmSUsTGKab0crvT2qQYk2fyl6cCHXoRQzkB0nXaOeNpjR1N3gbcq+0SsoOcVrSfa
 /Hew==
X-Gm-Message-State: AAQBX9dDXkqgip31sU/CG2EjhcdPrSKB/caYUNvs+XD9nvWN3PJbCHv1
 5y24nZ0W9IT5YiYJq3BSejRHFWWW5FKFmbtTBCHTwJHAXhJyRAvsctmYe0qOHB6l6ja4UmKqOAu
 8y6g9D+APIPzdM5vh3yNV2/0UBKBDZCsP8s4HUX7k2Q==
X-Received: by 2002:adf:f203:0:b0:2f6:de1f:acb6 with SMTP id
 p3-20020adff203000000b002f6de1facb6mr3331792wro.34.1681889706257; 
 Wed, 19 Apr 2023 00:35:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvQzgJcNa5oFUiKgVF/Ubwg9HDlxjq/9Gihac0CNYXVV9qe+d31ECu9kVTWy4hBWTvUpZvxg==
X-Received: by 2002:adf:f203:0:b0:2f6:de1f:acb6 with SMTP id
 p3-20020adff203000000b002f6de1facb6mr3331780wro.34.1681889705988; 
 Wed, 19 Apr 2023 00:35:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:19dd:3a43:9645:16eb:e84c])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b003f16932fe7dsm1251313wmq.38.2023.04.19.00.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Apr 2023 00:35:05 -0700 (PDT)
Date: Wed, 19 Apr 2023 03:34:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] MAINTAINERS: make me a reviewer of VIRTIO CORE AND NET
 DRIVERS
Message-ID: <20230419033449-mutt-send-email-mst@kernel.org>
References: <20230413071610.43659-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230413071610.43659-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Thu, Apr 13, 2023 at 03:16:10PM +0800, Xuan Zhuo wrote:
> First of all, I personally love open source, linux and virtio. I have
> also participated in community work such as virtio for a long time.
> 
> I think I am familiar enough with virtio/virtio-net and is adequate as a
> reviewer.
> 
> Every time there is some patch/bug, I wish I can get pinged
> and I will feedback on that.
> 
> For me personally, being a reviewer is an honor and a responsibility,
> and it also makes it easier for me to participate in virtio-related
> work. And I will spend more time reviewing virtio patch. Better advance
> virtio development
> 
> I had some contributions to virtio/virtio-net and some support for it.
> 
> * per-queue reset
> * virtio-net xdp
> * some bug fix
> * ......
> 
> I make a humble request to grant the reviewer role for the virtio core
> and net drivers.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I'll queue this, thanks

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cacd6074fb89..700b00a9e225 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22064,6 +22064,7 @@ F:	include/uapi/linux/virtio_console.h
>  VIRTIO CORE AND NET DRIVERS
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  M:	Jason Wang <jasowang@redhat.com>
> +R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-vdpa
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
