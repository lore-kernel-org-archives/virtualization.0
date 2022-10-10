Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FBEC433FE
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 17:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC2A240983;
	Mon, 10 Oct 2022 17:17:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC2A240983
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MkyM8Xuh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3w1ZvBJ4eheV; Mon, 10 Oct 2022 17:17:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 738E4400A6;
	Mon, 10 Oct 2022 17:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 738E4400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4659DC0032;
	Mon, 10 Oct 2022 17:17:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D39C9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98CBC40914
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:17:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98CBC40914
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MkyM8Xuh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fW33ZLEnMuo7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:17:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D091240912
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D091240912
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665422257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EAkHWJV5i1XmoybWMpHm1PpCVGOwPrjFpBbuDSPlj3U=;
 b=MkyM8Xuh+aZoGppES/A5FEvlBI7k3UrqmIg4LU8ZE5ZHLlT+wTvvPXU5P3/QlMDj3Q8TUt
 0fhlw8la5A6YS5fT7DQ1LLO7VfbfM8DwO8iTu+rIUkm1OvkfiOCYJNzjgWOX3ZHRt589VF
 4I36S00p0RXR2KB5FVcgqQ0trkkDIFQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-488-gXPzPYhIP7Cu16phYbb6Yw-1; Mon, 10 Oct 2022 13:17:36 -0400
X-MC-Unique: gXPzPYhIP7Cu16phYbb6Yw-1
Received: by mail-wr1-f70.google.com with SMTP id
 h17-20020adfaa91000000b0022e9f2245c8so2075272wrc.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 10:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAkHWJV5i1XmoybWMpHm1PpCVGOwPrjFpBbuDSPlj3U=;
 b=63EiJgWdCi0nDTGqQvWZslin49Cg6W/DIIf1L1ifcK+JSW37GT+Cz05eX7PFJIyFc4
 g8FALA9rycf0GdKMnrtekMenz8YnscmgaWDkDE7yKkPJIe5V8wiB7UibvKsjIN4y2QND
 k2KbnszbeUjQuK5qKQfeh9Fo5duQRbSA5NXZkJeRkHIZrbUWI9JrAf/G5odWvsLmB97J
 XRmV6aq6WQNhUdagr8i008prnMeNtHphUxt6rnoOCeNs6MsMA59alB0PVSFcDcR9FY+f
 wBcWm+iZSKOJMhC5ghrkQvPj8yL/S5mQBstxLzxTMk1H10lpXhtzRSVqgroPLZDM422j
 zP8w==
X-Gm-Message-State: ACrzQf2tYqGoV5tDMq7zGwxH/vlu38gb0lKMHfh9xv5tXgGciuj/yohB
 +KqnnpSvPh4UPKtu6VX7gAzCrTegq92NVGGouLbIjhYwwJaQnnI1orpO52LY9U7Z2aABH1ciWsR
 /pOEO4YJPOkudMIuDXmNvAp+JWz2uWzDziwo/Q4jLKw==
X-Received: by 2002:a5d:47a6:0:b0:22e:7c73:feb2 with SMTP id
 6-20020a5d47a6000000b0022e7c73feb2mr12117209wrb.715.1665422255074; 
 Mon, 10 Oct 2022 10:17:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4pMbOL5Iwp6GXNIfNT4x8U3HJ5wmOn8CEMD/qC/+mMgXvo1QpQIRtd9FSIb027UG14KZk1NQ==
X-Received: by 2002:a5d:47a6:0:b0:22e:7c73:feb2 with SMTP id
 6-20020a5d47a6000000b0022e7c73feb2mr12117196wrb.715.1665422254860; 
 Mon, 10 Oct 2022 10:17:34 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 b21-20020a05600c151500b003c6b9749505sm2344218wmg.30.2022.10.10.10.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Oct 2022 10:17:34 -0700 (PDT)
Date: Mon, 10 Oct 2022 13:17:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtio_ring: split: Operators use unified style
Message-ID: <20221007091431-mutt-send-email-mst@kernel.org>
References: <20220926022202.1516-1-wangdeming@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220926022202.1516-1-wangdeming@inspur.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, Sep 25, 2022 at 10:22:02PM -0400, Deming Wang wrote:
> The operators of vring_alloc_queue_split should use the unified style.Add
> space for the '|' ,make it be looked more pretty.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Thanks for the patch!
Since this is about cosmetics let's make the patch look good:

Pls tweak the commit log. Space after . and , no space before ,
unified style -> kernel coding style
make it be looked more pretty -> make it prettier.


> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..7510163565b7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1074,7 +1074,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	if (!queue) {
>  		/* Try to get a single page. You are my only hope! */
>  		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
> -					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
> +					  &dma_addr, GFP_KERNEL | __GFP_ZERO);
>  	}
>  	if (!queue)
>  		return -ENOMEM;
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
