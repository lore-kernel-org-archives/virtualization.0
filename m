Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3D3C433FE
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 17:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF0A34154A;
	Tue, 25 Jan 2022 17:59:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LaOCgb6uKV1H; Tue, 25 Jan 2022 17:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F58F41524;
	Tue, 25 Jan 2022 17:59:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14C06C0039;
	Tue, 25 Jan 2022 17:59:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E88F2C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 17:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1FE241527
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 17:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WW99w72bCryo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 17:59:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B16541524
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643133555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tQwnOxnoIr5kWKtczEX49APK7YeWZviqLQA1sp5peAU=;
 b=QjHh+Hp8TizOE4FgVulGUllZmBkvmk5dtJVN74+84RUT7cKIdFXDrGu3PWSEh8P3NjJvs1
 agTsfTuTjzioaRv+tQYvoONcr0Dkf9UJJ7WJ6rsj3GxLA7lanU+oCTkAw62tUHN+L19xFy
 6silaCCw/sO8Bru5wCqGg9JDsPrJNuw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-kVTVwGgbO8mNAWwgOSSLxg-1; Tue, 25 Jan 2022 12:59:13 -0500
X-MC-Unique: kVTVwGgbO8mNAWwgOSSLxg-1
Received: by mail-ed1-f70.google.com with SMTP id
 h11-20020a05640250cb00b003fa024f87c2so15450767edb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 09:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tQwnOxnoIr5kWKtczEX49APK7YeWZviqLQA1sp5peAU=;
 b=CQCx9/xfA1/iVFZyGSY92TrgepaxMToiEIa/h+/ac0axAXJkVJNXmUPk7RyiKERTfa
 rFdYDpKXlS7qyV+pClIfM6eR1MYBzi7eQjU72y6RXRZ5Ycyd7YjhtF5oo4cBnKt5mj5c
 ntskqCV/PJ1mGow7HpaIDe/gY3TitfKiVZH1924/wViNwdDZ5urCJ5BZ/avcrLDY626H
 SNNcQopKrZd+RwAtQC2G02KR7Xfy61vPlPSRuxLSOUPbAv5AmKByhiTwuyijXYZFo8Gk
 Jue69BWO87ANcvGeN0gbgBPXcIkZjZ1Tvy9Z9iRUhrFcBjk6+w12xqnZSI5cnpbbbPig
 bw/w==
X-Gm-Message-State: AOAM532l7aOuTFhqri2F7zvjuJeEoo1L+6uqLGiQ0KXgWl+ft5F/4nk0
 1ayX1Wl7vj/nQ2TM6LyHorstNTstn5nuTLGuMVuLtljcejH/ccw39t+VBnqf7nFGVusC360VGJz
 17AldKhef8Rsn/5jZyvyFaaUAzB9wZIJpPLKp+lWLUw==
X-Received: by 2002:a17:907:72c4:: with SMTP id
 du4mr9152820ejc.243.1643133552621; 
 Tue, 25 Jan 2022 09:59:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7m6XPepvwD9UHHPdetVwWNbg/dFQ1MV8dbRVv9I9eBjYFCvpX/V21GrFvuzJV6aICXTe9mQ==
X-Received: by 2002:a17:907:72c4:: with SMTP id
 du4mr9152815ejc.243.1643133552428; 
 Tue, 25 Jan 2022 09:59:12 -0800 (PST)
Received: from redhat.com ([176.12.185.204])
 by smtp.gmail.com with ESMTPSA id d5sm8562973edz.78.2022.01.25.09.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 09:59:11 -0800 (PST)
Date: Tue, 25 Jan 2022 12:59:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm/balloon_compaction: make balloon page compaction
 callbacks static
Message-ID: <20220125125853-mutt-send-email-mst@kernel.org>
References: <20220125132221.2220-1-linmiaohe@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220125132221.2220-1-linmiaohe@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Tue, Jan 25, 2022 at 09:22:21PM +0800, Miaohe Lin wrote:
> Since commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
> feature"), these functions are called via balloon_aops callbacks. They're
> not called directly outside this file. So make them static and clean up
> the relevant code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'll queue this unless someone else does first.

> ---
>  include/linux/balloon_compaction.h | 22 ----------------------
>  mm/balloon_compaction.c            |  6 +++---
>  2 files changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 338aa27e4773..edb7f6d41faa 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -80,12 +80,6 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
>  
>  #ifdef CONFIG_BALLOON_COMPACTION
>  extern const struct address_space_operations balloon_aops;
> -extern bool balloon_page_isolate(struct page *page,
> -				isolate_mode_t mode);
> -extern void balloon_page_putback(struct page *page);
> -extern int balloon_page_migrate(struct address_space *mapping,
> -				struct page *newpage,
> -				struct page *page, enum migrate_mode mode);
>  
>  /*
>   * balloon_page_insert - insert a page into the balloon's page list and make
> @@ -155,22 +149,6 @@ static inline void balloon_page_delete(struct page *page)
>  	list_del(&page->lru);
>  }
>  
> -static inline bool balloon_page_isolate(struct page *page)
> -{
> -	return false;
> -}
> -
> -static inline void balloon_page_putback(struct page *page)
> -{
> -	return;
> -}
> -
> -static inline int balloon_page_migrate(struct page *newpage,
> -				struct page *page, enum migrate_mode mode)
> -{
> -	return 0;
> -}
> -
>  static inline gfp_t balloon_mapping_gfp_mask(void)
>  {
>  	return GFP_HIGHUSER;
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 907fefde2572..4b8eab4b3f45 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -203,7 +203,7 @@ EXPORT_SYMBOL_GPL(balloon_page_dequeue);
>  
>  #ifdef CONFIG_BALLOON_COMPACTION
>  
> -bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
> +static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
>  
>  {
>  	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
> @@ -217,7 +217,7 @@ bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
>  	return true;
>  }
>  
> -void balloon_page_putback(struct page *page)
> +static void balloon_page_putback(struct page *page)
>  {
>  	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
>  	unsigned long flags;
> @@ -230,7 +230,7 @@ void balloon_page_putback(struct page *page)
>  
>  
>  /* move_to_new_page() counterpart for a ballooned page */
> -int balloon_page_migrate(struct address_space *mapping,
> +static int balloon_page_migrate(struct address_space *mapping,
>  		struct page *newpage, struct page *page,
>  		enum migrate_mode mode)
>  {
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
