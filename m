Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE52C433F5
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 17:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03A5582716;
	Tue, 25 Jan 2022 17:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2NpMiUrDuVhK; Tue, 25 Jan 2022 17:56:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95B53825DC;
	Tue, 25 Jan 2022 17:56:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A208C0039;
	Tue, 25 Jan 2022 17:56:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A63FC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 17:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7636241520
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 17:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AlTSJgjeTsrL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 17:56:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57F70410D0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643133374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6rxjsOhNxfEiaxINggrBA6x75JFuMQB6f2O2kbHXzE=;
 b=BXIzrEbjlwjxscJl0uWRCufAHy8cPOcPBVccwf7ZxM9Vy0E9ox0oHYavSq4U86wMexezxM
 dM4o3oGuxN/YBhLE+UnvweemQpjSpKvkeEvb2P56u8fG/PW0AF4914A8tsZD2yMGpp/5xl
 1Tro+B8f0sLkVdYIEWP8tJhoaI95hmg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-LegWoehEN5ujvylBC79I9g-1; Tue, 25 Jan 2022 12:56:12 -0500
X-MC-Unique: LegWoehEN5ujvylBC79I9g-1
Received: by mail-ot1-f71.google.com with SMTP id
 h17-20020a9d7991000000b0059b4230fc63so13850804otm.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 09:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E6rxjsOhNxfEiaxINggrBA6x75JFuMQB6f2O2kbHXzE=;
 b=G+rMBMgCl+64NwHJrEG/JHhnePXIjHHSavl1+WMoRgjXR6fcVpyyrxZG9nJyib0+Po
 xevco2AK8YfJ40dM2yyt6qsPVURjHWVAzlbMc+gVNcV3rLdjXM6Kxriqj6goMrSa3E3l
 P43LZ67v+D569fobqtUb1g/gyIsluuit1Q/dQPXSPxPfWwZCvwg40e0bmToMQ++lOFGx
 HlTjIE+DHAGYkBzsCtdpgzzzMVnJwDi7rz2Qu+NaJy0ivlrbOduxZaPvKtFYFHn2X3HX
 BLWv605P1Lr0aE7rcg90bMSZS72/uedcjvwXSa6A8UK0OhgjmXyajrLV+f6+JkFKNXHB
 9lyw==
X-Gm-Message-State: AOAM533ggsDvpt2YvOFUzSwlJGyGPsrs6F/7xbCXXCT7fjgv+Dx3ARpL
 +5nqjOvxN5+lngcHyyVpznIh7WnARgaWvarFlNw3PYm82tB4q/jSPIRqXxpcnhArhB6v15icmzh
 2w6gq+jXMsh2Jsh2BQ6DVrEqQg3aQ54ITAUEiGKg+rQ==
X-Received: by 2002:a4a:dd98:: with SMTP id h24mr2975786oov.73.1643133372054; 
 Tue, 25 Jan 2022 09:56:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYU8KoqYoZGyScgfgxOyqhv/Nbcm50wK1ORJkXgLkUal4jqhtQ/iOtcNXKSPdPLYBPciII5g==
X-Received: by 2002:a4a:dd98:: with SMTP id h24mr2975775oov.73.1643133371841; 
 Tue, 25 Jan 2022 09:56:11 -0800 (PST)
Received: from optiplex-fbsd (c-73-182-255-193.hsd1.nh.comcast.net.
 [73.182.255.193])
 by smtp.gmail.com with ESMTPSA id a15sm8138436oil.13.2022.01.25.09.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 09:56:11 -0800 (PST)
Date: Tue, 25 Jan 2022 12:56:08 -0500
From: Rafael Aquini <aquini@redhat.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm/balloon_compaction: make balloon page compaction
 callbacks static
Message-ID: <YfA5uLd8ftDxcIrG@optiplex-fbsd>
References: <20220125132221.2220-1-linmiaohe@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220125132221.2220-1-linmiaohe@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=aquini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 akpm@linux-foundation.org
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
> 
> 
Acked-by: Rafael Aquini <aquini@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
