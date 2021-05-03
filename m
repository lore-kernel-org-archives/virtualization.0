Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13641C433B4
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:24:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706F66121E
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706F66121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 191994043F;
	Mon,  3 May 2021 08:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mHI78r_iroMq; Mon,  3 May 2021 08:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A93A240443;
	Mon,  3 May 2021 08:23:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70933C000D;
	Mon,  3 May 2021 08:23:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 178B8C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0628540439
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:23:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fcv_mrB2VKTD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:23:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A05C40340
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620030235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bPRJDN7+PYmkwRc18YCW4pqF1oNECdl7EEdKg52HHCc=;
 b=fZOskuy4AziUojSmYmC8d9BYMWW0aNr5cQRHwhWwo9A0j4gHATn8awGPxiqiJ9s6HdDOEP
 eRUSpAM/yB//6wXWoyqIjtUcJSmCkeKCz63c6FM28v5OnnTzEfAZQR3AqhpcxjiIQqjhtS
 P4//sRoOoY7Kx0OJYWxf244IMCexSiw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-GCw0E4gMOdqyeOBDJRc2Ww-1; Mon, 03 May 2021 04:23:52 -0400
X-MC-Unique: GCw0E4gMOdqyeOBDJRc2Ww-1
Received: by mail-wm1-f71.google.com with SMTP id
 y184-20020a1ce1c10000b0290143299f39d7so2169297wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 May 2021 01:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bPRJDN7+PYmkwRc18YCW4pqF1oNECdl7EEdKg52HHCc=;
 b=m1RVeefGGGKQfnnmh8pa+S5m5f4zTa6iGnXqTJD3lKORFb0qufJClcvvm97840nWV7
 /mHBxbN6dEb7fKraymYZLlqWgVyXgR9oJgligaksDc4zyPabsT9b0mhKIfqdcwBcqdqC
 BDWol4Ka3Z5cDI9BjK1r3gF7hzOcXzgTOHkD97ok6W3Iw8K4QMI+11IQJebbDnQs4Q7y
 uIw6fro2RHJN4eaMsDVY2k04+GcAn3cMSCCCJHWj5Dy5uJYvpFcPcOFemTujBHKr7tEL
 WJp2MCYSRJaUA+blqLeH/5/gvN5NMSFYOlSDdjJF3VzvAON/oH7B1dzL2bTk/td7iN96
 9WaQ==
X-Gm-Message-State: AOAM531P8u8Ths1d1HFjk1IFc1IKWpiQkvSHBeG6hBn5W8RUFfGucQKf
 XAr2yG5J4E5XGEAHaVVv6vJ/+WsvqFObYm3Y20fWLU05KG3LAhIFeJefNN5WLuCiSf8qFFXRez1
 kRbG46ELlZvNnJfyRSP8IwwsZYUmuVsRORjPEtSJYPQ==
X-Received: by 2002:a05:6000:184a:: with SMTP id
 c10mr23619884wri.237.1620030231115; 
 Mon, 03 May 2021 01:23:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziGxRW4ZxIY4FY2qg1KRAZv5We9hL1OQjj2LLIG4bdcedtb0gAbjIZDrDWQnD40SLdnCFbag==
X-Received: by 2002:a05:6000:184a:: with SMTP id
 c10mr23619863wri.237.1620030230987; 
 Mon, 03 May 2021 01:23:50 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id n22sm8177060wmo.12.2021.05.03.01.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 May 2021 01:23:50 -0700 (PDT)
Date: Mon, 3 May 2021 04:23:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 6/7] virtio-mem: use page_offline_(start|end) when
 setting PageOffline()
Message-ID: <20210503042220-mutt-send-email-mst@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-7-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210429122519.15183-7-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Aili Yao <yaoaili@kingsoft.com>, Michal Hocko <mhocko@suse.com>,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Wei Liu <wei.liu@kernel.org>,
 Alex Shi <alex.shi@linux.alibaba.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Steven Price <steven.price@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Jiri Bohac <jbohac@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>,
 Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>,
 Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>
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

On Thu, Apr 29, 2021 at 02:25:18PM +0200, David Hildenbrand wrote:
> Let's properly use page_offline_(start|end) to synchronize setting
> PageOffline(), so we won't have valid page access to unplugged memory
> regions from /proc/kcore.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>


the patch looks good to me as such

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge with rest of patcgset - it seems to mostly
live in the fs/mm space.

IF you respin, maybe add the explanation you sent in response to Mike's comments
in the commit log.


> ---
>  drivers/virtio/virtio_mem.c | 2 ++
>  mm/util.c                   | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 10ec60d81e84..dc2a2e2b2ff8 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1065,6 +1065,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>  static void virtio_mem_set_fake_offline(unsigned long pfn,
>  					unsigned long nr_pages, bool onlined)
>  {
> +	page_offline_begin();
>  	for (; nr_pages--; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
>  
> @@ -1075,6 +1076,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>  			ClearPageReserved(page);
>  		}
>  	}
> +	page_offline_end();
>  }
>  
>  /*
> diff --git a/mm/util.c b/mm/util.c
> index 95395d4e4209..d0e357bd65e6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1046,8 +1046,10 @@ void page_offline_begin(void)
>  {
>  	down_write(&page_offline_rwsem);
>  }
> +EXPORT_SYMBOL(page_offline_begin);
>  
>  void page_offline_end(void)
>  {
>  	up_write(&page_offline_rwsem);
>  }
> +EXPORT_SYMBOL(page_offline_end);
> -- 
> 2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
