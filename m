Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC65BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 10:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C351401CD;
	Tue, 18 Jan 2022 10:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dA-IcA8ifNGG; Tue, 18 Jan 2022 10:43:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB2A4401B1;
	Tue, 18 Jan 2022 10:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A60E1C0039;
	Tue, 18 Jan 2022 10:43:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01CEBC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 10:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA166401CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 10:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jUezU5tqJcfQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 10:43:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B027401B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642502598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A28nbKFcBeQMBmNHhsIiIdt9uBOcsYi0yUhyG3KA/b4=;
 b=BEdg33tUFnTwDcRwW/e2RfWxdJd9gd2auAEnHTupwa9xPVCPe4JgzeDESnpRC4eKpqC8CV
 2NOI6SQHw3Fx4Tx8R7W91MWkv4fG+BgHxu5+xmDWM7jWY9y80rg1shkcGlp/lhTD0mL50P
 tzixWL8WHpNEdV185/yu/pU/A0K5pd8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-8JfXtPFNOYOL4K2DU5_jpQ-1; Tue, 18 Jan 2022 05:43:13 -0500
X-MC-Unique: 8JfXtPFNOYOL4K2DU5_jpQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 i9-20020a05640242c900b003fe97faab62so16512101edc.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 02:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A28nbKFcBeQMBmNHhsIiIdt9uBOcsYi0yUhyG3KA/b4=;
 b=OujX694LUu68J7uthTCbuu+FM9WkX1xylEdNi8nETRgVXv2jXnjXdKvCNi773Y+jkx
 jC53Tp7esIxKOW9sHeBK28B7PQpO5Z5xtnyirq1Q1D1jVJDTJ9W7ZOg+CyzC8M8LqIRE
 URQA7UnYyjBq4NJxeo91oGdq+h2nqbzXnendvRXwL8rFCj4qSEYPBGJ9ychVvjUNN1zu
 Be4JbUDdtHn7oDlIwgFiPBJN6RydKA1azXfL9mjYuYF30cdu6G7xSrVgVTJON3U12zv7
 Wxl4kCz5KIoCvspSprxMqANANY0hohfQC7bKUud2wIQ3EWPS219hTvV2EP7TMLeF/RMM
 2wvg==
X-Gm-Message-State: AOAM530OOLa93dZSFAtStMzpEtOWm1+90LjgjNCSnM3qjQYCWQMGtvGi
 taz02JUzmGNwUdbxQyz4woCON5f2oadUIMTUE2cK8QF+JnzfXMbhMxNueqVVtR/uxrrgHj4EEzh
 7DkjNnZN/0Y2vCmSPxVtUgGHEogzYIFIeAfQZYQnQJg==
X-Received: by 2002:a17:906:4453:: with SMTP id
 i19mr19461314ejp.305.1642502591866; 
 Tue, 18 Jan 2022 02:43:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwTh6NI80ukxANZfx2gMiqM97LYb7cD6bz7E/cA5wuQ4vWKMJSlXDqRDAGYeVfwX+9Il1UsA==
X-Received: by 2002:a17:906:4453:: with SMTP id
 i19mr19461303ejp.305.1642502591711; 
 Tue, 18 Jan 2022 02:43:11 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id r2sm5204377eje.60.2022.01.18.02.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 02:43:11 -0800 (PST)
Date: Tue, 18 Jan 2022 05:43:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] drivers/virtio: Enable virtio mem for ARM64
Message-ID: <20220118054210-mutt-send-email-mst@kernel.org>
References: <20220118013431.167347-1-gshan@redhat.com>
 <4fe8127e-6e24-64bd-c53b-bf4ffa15b4b4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4fe8127e-6e24-64bd-c53b-bf4ffa15b4b4@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, shan.gavin@gmail.com,
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

On Tue, Jan 18, 2022 at 09:38:21AM +0100, David Hildenbrand wrote:
> On 18.01.22 02:34, Gavin Shan wrote:
> > This enables virtio-mem device support by allowing to enable the
> > corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
> > architecture.
> > 
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  drivers/virtio/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index 34f80b7a8a64..bf3f6ebdaa3b 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
> >  config VIRTIO_MEM
> >  	tristate "Virtio mem driver"
> >  	default m
> > -	depends on X86_64
> > +	depends on X86_64 || ARM64
> >  	depends on VIRTIO
> >  	depends on MEMORY_HOTPLUG
> >  	depends on MEMORY_HOTREMOVE
> 
> With MEMBLOCK_DRIVER_MANAGED in place upstream, kexec should be fine.
> 
> 
> Can you adjust/rephrase the comment as well? Like
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 34f80b7a8a64..88028ca01c8f 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>          This driver provides access to virtio-mem paravirtualized memory
>          devices, allowing to hotplug and hotunplug memory.
>  
> -        This driver was only tested under x86-64, but should theoretically
> -        work on all architectures that support memory hotplug and hotremove.
> +        This driver was only tested under x86-64 and arm64, but should
> +        theoretically work on all architectures that support memory hotplug and
> +        hotremove.
>  
>          If unsure, say M.
>  
> 
> 
> Acked-by: David Hildenbrand <david@redhat.com>

with this:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

I guess I will merge this? It's a small change so - let's go for this
release straight away?

> -- 
> Thanks,
> 
> David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
