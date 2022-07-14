Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8116BC43334
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 11:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4D4984929;
	Thu, 14 Jul 2022 11:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4D4984929
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CWv2/ZXw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qisUTl5teixr; Thu, 14 Jul 2022 11:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE1E38490A;
	Thu, 14 Jul 2022 11:36:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE1E38490A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67F0CC0035;
	Thu, 14 Jul 2022 11:36:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9B0DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 11:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D48C8493D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 11:36:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D48C8493D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FyHC73Eonpm4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 11:36:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF53684898
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF53684898
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657798560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMPu0+CsGQWhq38Z8l8Tmth890eIyaSGEU2tVPnMSXY=;
 b=CWv2/ZXwnxWikeIajZEYDNsMbqXRkmPjPkNyxQZpie+PLnMqVvMGyp/NifNg3ZrZO/dRYv
 Ys58ui6J9Zt1ga5yB1bAJSV6S0m0DZS77ss8uAqg1pM8Y6//AKw9LwI7tzQ6JWcvL/J6wA
 jRRn1wmKX3w7qZZ1EQfYtemc5cV26cI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-G2Hx3e2tO8S8_fnHsC7PMQ-1; Thu, 14 Jul 2022 07:35:58 -0400
X-MC-Unique: G2Hx3e2tO8S8_fnHsC7PMQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 c126-20020a1c3584000000b003a02fa133ceso540150wma.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 04:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=DMPu0+CsGQWhq38Z8l8Tmth890eIyaSGEU2tVPnMSXY=;
 b=skOKSjQcaPKo3bdt17+cpN/ny0+yiWk7eT5RQpXP/pve1VZbK6JRK9vAP074vdzQ2z
 RUTU6uzn6vK3fXWff67szl4OrSKitA9PC1cU+jxd1RWGdLLsQpmuqcG3EQdH6tou5Q83
 OWqy97Vt+fJ6KVQcjjYv9MHy55+E/Wzuffm8XbzIq9qLOOEH0V+lNSSFrkSrLnSzwEAG
 pfg6wW5qnQ5gJyfiWzaJHPGcUZJY6p8f5hUUJfhEZcEKmDWFbnPKV8Zo5m/xMOpCkxrU
 Q7n2u9+qdGiABANIyPPbgUeD/ML63dnGv4T5g6tPw54nD2XOmJ1FJEbsJCr+FwBj6XGN
 q4dg==
X-Gm-Message-State: AJIora9rMksfnc1AM9kkeU/wukFcB7f4f9bdwLtgVPHmiZLdN6hFttjk
 eBUtdqGzN0PYbjHh37vpB++OXniyABwnclgonRhG+exxscSFeRXK4EL1bwo2ia2x4i1whebGD5K
 oHurkKR5J2z+bjpT3jhMFSWe7fXcSoiZX+cvKQ/A6Dg==
X-Received: by 2002:a5d:5143:0:b0:21d:61b6:5225 with SMTP id
 u3-20020a5d5143000000b0021d61b65225mr7665198wrt.164.1657798556894; 
 Thu, 14 Jul 2022 04:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vFLw/ilg8YddKegRKb5dsBkKEe/0ajWS/cmSAxw4ewN53wC5IMUv2obdftlGNr7i3D5y2NGA==
X-Received: by 2002:a5d:5143:0:b0:21d:61b6:5225 with SMTP id
 u3-20020a5d5143000000b0021d61b65225mr7665175wrt.164.1657798556581; 
 Thu, 14 Jul 2022 04:35:56 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8?
 ([2a09:80c0:192:0:20af:34be:985b:b6c8])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b003a305c0ab06sm616188wmq.31.2022.07.14.04.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 04:35:56 -0700 (PDT)
Message-ID: <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
Date: Thu, 14 Jul 2022 13:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel@openvz.org, linux-kernel@vger.kernel.org,
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

On 05.07.22 10:36, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 77 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_balloon.h |  1 +
>  2 files changed, 78 insertions(+)
> 
> V2:
>  - fixed coding style
>  - removed pretty print
> V3:
>  - removed dublicate of features
>  - comment about balooned_pages more clear
>  - convert host pages to balloon pages
> V4:
>  - added a define for BALLOON_PAGE_SIZE to make things clear
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..dc4ad584b947 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -10,6 +10,7 @@
>  #include <linux/virtio_balloon.h>
>  #include <linux/swap.h>
>  #include <linux/workqueue.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -731,6 +732,77 @@ static void report_free_page_func(struct work_struct *work)
>  	}
>  }
>  
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define guest_to_balloon_pages(i) ((i)*VIRTIO_BALLOON_PAGES_PER_PAGE)
> +/**
> + * virtio_balloon_debug_show - shows statistics of balloon operations.
> + * @f: pointer to the &struct seq_file.
> + * @offset: ignored.
> + *
> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
> + *
> + * Return: zero on success or an error code.
> + */
> +
> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +	struct virtio_balloon *b = f->private;
> +	u32 num_pages;
> +	struct sysinfo i;
> +
> +	si_meminfo(&i);
> +
> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);
> +	/*
> +	 * Pages allocated by host from the guest memory.
> +	 * Host inflates the balloon to get more memory.
> +	 * Guest needs to deflate the balloon to get more memory.
> +	 */

Please drop that comment. This is basic virtio-balloon operation that
must not be explained at this point.

> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
> +			guest_to_balloon_pages(i.totalram));

totalram is calculated from totalram_pages().

When we inflate/deflate, we adjust totalram as well via
adjust_managed_page_count().

Consequently, this doesn't calculate what you actually want?

Total memory would be totalram+inflated, current would be totalram.


But, TBH, only export num_pages. User space can just lookup the other
information (totalram) via /proc/meminfo.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
