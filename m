Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8369C43334
	for <virtualization@archiver.kernel.org>; Mon, 18 Jul 2022 11:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32CB2415B3;
	Mon, 18 Jul 2022 11:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32CB2415B3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBG1mZ2s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8Xb-ODaC1IC; Mon, 18 Jul 2022 11:35:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F08634159D;
	Mon, 18 Jul 2022 11:35:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F08634159D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3495C0033;
	Mon, 18 Jul 2022 11:35:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CC6EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 11:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA5A440AD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 11:35:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA5A440AD1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBG1mZ2s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aoCEyo174NVV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 11:35:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F21CB40A59
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F21CB40A59
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 11:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658144128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JCm/b/mjt4LZBLzHear3EHHnOGBIPoSaVrBJk+/RAA=;
 b=HBG1mZ2sdw8IWf/Evo5Nmy+T10VBBxV4L0VR8b2IuTx0wN0r+1Hxk9vrPit0b73Yox0ZSh
 rFy5btP9GwZDecRldSFskK5x8e+dLgxK5Lvvj6NhyYX/p/80KEr/GvDLUaf2JKHp6k9TzT
 yGjucukNimq80So2CpeNBA8QgrVzh8I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-6YO43v11PoClj7RetzbGbw-1; Mon, 18 Jul 2022 07:35:24 -0400
X-MC-Unique: 6YO43v11PoClj7RetzbGbw-1
Received: by mail-wm1-f72.google.com with SMTP id
 ay19-20020a05600c1e1300b003a315c2c1c0so3148440wmb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 04:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=9JCm/b/mjt4LZBLzHear3EHHnOGBIPoSaVrBJk+/RAA=;
 b=OY8/ctaa89gXY9NriAP11jevUXW853kwfpXArFQTHelWX0lnctg+wBSW2MfrJ+wJw3
 ZUbvLnxlNbEZRO7tP0wHo75VgN7aqI02sizqplWmHvonvHwD8LaZA0r8MOxyWz+yTwhP
 +SQOfWrb7iJYoNhRqlDZTCRWej9PwUP/GEfCCwKEe1jwVqrGepNezk28zzPA/Qm5JFPR
 lK64pywhVDD/Oxsl4g7wuqujyagyaNJ+EzTR3ZDoBKQRvC+ZgkJRSxiW7qTrri+BYHSq
 welh51pkZ8LXAd7onG+l+KIMFBUw/JPHuAZ9pk1Gypb0W/8aULAx6TCd4jCqI9LYSMDP
 W9+Q==
X-Gm-Message-State: AJIora84dxTYBYPYP607Eoy0ewYBVNM0tQc9vsmS/HVPTLgSjZuRGM8h
 gS7HC+W9T6OZKyJoXH9j0LpeXOdsQX6Ax6BSNhBZBdlwLwUrlBIjTGt4RTweGpPZQwyqpQ6o7oz
 ru7GQcv0bS9JTkuzc1WncrMSeGujBRNABLELgbuIy/w==
X-Received: by 2002:a7b:c381:0:b0:3a2:fe96:2ce4 with SMTP id
 s1-20020a7bc381000000b003a2fe962ce4mr23293122wmj.70.1658144123695; 
 Mon, 18 Jul 2022 04:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1viP2cnS2guKXxZTHu+eZiJoLsbXgWsbMOQJGktyyp94smBfBZj8OyeafS+IH7srVRiUt/CHQ==
X-Received: by 2002:a7b:c381:0:b0:3a2:fe96:2ce4 with SMTP id
 s1-20020a7bc381000000b003a2fe962ce4mr23293097wmj.70.1658144123376; 
 Mon, 18 Jul 2022 04:35:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018?
 (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de.
 [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a056000181800b0021d68e1fd42sm10736132wrh.89.2022.07.18.04.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jul 2022 04:35:23 -0700 (PDT)
Message-ID: <0b660226-28dc-1f1d-e22e-34805dc5b25d@redhat.com>
Date: Mon, 18 Jul 2022 13:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
 <20220714132053.56323-1-alexander.atanasov@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 1/1] Create debugfs file with virtio balloon usage
 information
In-Reply-To: <20220714132053.56323-1-alexander.atanasov@virtuozzo.com>
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

On 14.07.22 15:20, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 79 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_balloon.h |  1 +
>  2 files changed, 80 insertions(+)
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
> V5:
>  - Made the calculatons work properly for both ways of memory accounting
>    with or without deflate_on_oom
>  - dropped comment 
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..e17f8cc71ba4 100644
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
> @@ -731,6 +732,79 @@ static void report_free_page_func(struct work_struct *work)
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

Most other functions call this "vb".

> +	u32 num_pages, total_pages, current_pages;
> +	struct sysinfo i;
> +
> +	si_meminfo(&i);
> +
> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);

Why? Either export all in ordinary page size or in kB. No need to
over-complicate the interface with a different page size that users
don't actually care about.

I'd just stick to /proc/meminfo and use kB.

> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);

What's wrong with vb->num_pages? I'd prefer not doing config access, if
it can be avoided.

> +
> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
> +		total_pages = guest_to_balloon_pages(i.totalram);
> +		current_pages = guest_to_balloon_pages(i.totalram) - num_pages;
> +	} else {
> +		total_pages = guest_to_balloon_pages(i.totalram) +  num_pages;
> +		current_pages = guest_to_balloon_pages(i.totalram);
> +	}
> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %u\n", "total_pages", total_pages);
> +
> +	/* Current memory for the guest */
> +	seq_printf(f, "%-22s: %u\n", "current_pages", current_pages);

The think I detest about that interface (total/current) is that it's
simply not correct -- because i.totalram for example doesn't include
things like (similar to MemTotal in /proc/meminfo)

a) crashkernel
b) early boot allocations (e.g., memmap)
c) any kind of possible memory (un)hotplug in the future

I'd really suggest to just KIS and not mess with i.totalram.

Exposing how much memory is inflated and some way to identify how that
memory is accounted in /proc/meminfo should be good enough.

E.g., the output here could simply be

"Inflated: 1024 kB"
"MemTotalReduced: 1024 kB"

That would even allow in the future for flexibility when it comes to how
much/what was actually subtracted from MemTotal.

> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(virtio_balloon_debug);
> +
> +static void  virtio_balloon_debugfs_init(struct virtio_balloon *b)
> +{
> +	debugfs_create_file("virtio-balloon", 0444, NULL, b,
> +			    &virtio_balloon_debug_fops);
> +}
> +
> +static void  virtio_balloon_debugfs_exit(struct virtio_balloon *b)
> +{
> +	debugfs_remove(debugfs_lookup("virtio-balloon", NULL));
> +}
> +
> +#else
> +
> +static inline void virtio_balloon_debugfs_init(struct virtio_balloon *b)
> +{
> +}
> +
> +static inline void virtio_balloon_debugfs_exit(struct virtio_balloon *b)
> +{
> +}
> +
> +#endif	/* CONFIG_DEBUG_FS */

[...]

> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..f3ff7c4e5884 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -40,6 +40,7 @@
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)

We prefer extra spacing

 (1 << VIRTIO_BALLOON_PFN_SHIFT)


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
