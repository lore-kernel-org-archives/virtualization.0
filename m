Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6161DC4338F
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 07:15:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C50E60F44
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 07:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C50E60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBFE740354;
	Mon, 26 Jul 2021 07:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2koH1md9oP0j; Mon, 26 Jul 2021 07:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EBE4340325;
	Mon, 26 Jul 2021 07:15:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDD38C001A;
	Mon, 26 Jul 2021 07:15:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E612C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 07:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 059F0607E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 07:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1wPC6H_el7Ee
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 07:15:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1F5660789
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 07:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627283740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jr/kMfXd7N5bZI/UQn9TvwHA89sVmHJDTUMbSHF8LRE=;
 b=XmI1Y9sm7oip0o1JxE5yuOa24ymaVrzR/FGHtOSjABEYss7o/+Z4mKMGT+0Xv5n465xP3l
 3YcSWIY8FJphu6aJefKZYD3AAtfK9AbsrUEwhwmUagJE/UBfgbjrlKBeVKOx+JsSxw7Fsb
 uX+HlrnL52jPCFygqraP4++q52zIcnE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-O1E4c4K8P8m-41yhpAH63g-1; Mon, 26 Jul 2021 03:15:38 -0400
X-MC-Unique: O1E4c4K8P8m-41yhpAH63g-1
Received: by mail-wr1-f70.google.com with SMTP id
 d10-20020a056000114ab02901537f048363so1134593wrx.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 00:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Jr/kMfXd7N5bZI/UQn9TvwHA89sVmHJDTUMbSHF8LRE=;
 b=OsHhLY0Vp2B6d5bGpo0WGQMoCMTCivUlWs+oWlUKHg3zfj8IQnqI/hftld894P9SZC
 k9inXEcnh1X5rBpnG1omwC/ePXLExQluuelUMpoaewHidtuUy4E9h6MMPs3/6/9p7j4J
 E2UPYkFzHNBSIhbmAu37UG7ILtnEp19lO3XsQ3GlivBTLzPO/j4mIoF1hLwxbK+p3CdR
 QSCpCO63I9WnBqv8dLCepUHTR4LWzv4Tl9nnAd16WCfiQTucoDhwD/06REhM0lvwhKnv
 MeawMbcfZYblatzL0/QbOdvk6j3AhGfo5jxOWDbj2/DyG3KvCqq0riwGZNvjZmH6UH0o
 8ILg==
X-Gm-Message-State: AOAM533VSQ2B1WIruVb3GM3+cXvXxBmlvjCWPx+YH6BC8yuG69fFRRU1
 Nf1030pcuMm5spJ/8ttMDQKK9PFWNXpNlFig0h8xet2ZzoSGGlvGLzxuVU/F2/OOsfQ997O/rT4
 sjVRxVBbKjyu75JeaqQQvaNPhHRBm52fTiv9vh1v82g==
X-Received: by 2002:adf:f592:: with SMTP id f18mr17191519wro.179.1627283737686; 
 Mon, 26 Jul 2021 00:15:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa09nmyWHVmVAQphE1ddip761fZbYJ84EB5R4AJvFqDggQmhIVrwytnke9AYAcp72nUCMKuQ==
X-Received: by 2002:adf:f592:: with SMTP id f18mr17191488wro.179.1627283737550; 
 Mon, 26 Jul 2021 00:15:37 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23b33.dip0.t-ipconnect.de. [79.242.59.51])
 by smtp.gmail.com with ESMTPSA id
 l18sm12476411wme.29.2021.07.26.00.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jul 2021 00:15:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] mm/memory_hotplug: introduce "auto-movable" online
 policy
To: linux-kernel@vger.kernel.org
References: <20210723125210.29987-1-david@redhat.com>
 <20210723125210.29987-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <cd67a188-6d87-2d99-cfb8-2c4964e6087e@redhat.com>
Date: Mon, 26 Jul 2021 09:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723125210.29987-3-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hui Zhu <teawater@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Kedzierski <mkedzier@redhat.com>, Mike Rapoport <rppt@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

>   
> +struct auto_movable_stats {
> +	unsigned long kernel_early_pages;
> +	unsigned long movable_pages;
> +};
> +
> +static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
> +					    struct zone *zone)
> +{
> +	if (zone_idx(zone) == ZONE_MOVABLE) {
> +		stats->movable_pages += zone->present_pages;
> +	} else {
> +		/*
> +		 * CMA pages (never on hotplugged memory) behave like
> +		 * ZONE_MOVABLE.
> +		 */
> +		stats->movable_pages += zone->cma_pages;
> +		stats->kernel_early_pages += zone->present_early_pages;
> +		stats->kernel_early_pages -= zone->cma_pages;
> +	}
> +}

The following on top to make it compile without CONFIG_CMA (thanks Randy):

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bfdaa28eb86f..fa1a0afd32ba 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -741,13 +741,15 @@ static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
         if (zone_idx(zone) == ZONE_MOVABLE) {
                 stats->movable_pages += zone->present_pages;
         } else {
+               stats->kernel_early_pages += zone->present_early_pages;
+#ifdef CONFIG_CMA
                 /*
                  * CMA pages (never on hotplugged memory) behave like
                  * ZONE_MOVABLE.
                  */
                 stats->movable_pages += zone->cma_pages;
-               stats->kernel_early_pages += zone->present_early_pages;
                 stats->kernel_early_pages -= zone->cma_pages;
+#endif /* CONFIG_CMA */
         }
  }
  struct auto_movable_group_stats {



-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
