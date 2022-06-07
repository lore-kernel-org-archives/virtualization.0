Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02552C433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 13:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E1AA42491;
	Tue,  7 Jun 2022 13:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pUJb5BXqlqWe; Tue,  7 Jun 2022 13:42:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC49341873;
	Tue,  7 Jun 2022 13:42:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CBECC0039;
	Tue,  7 Jun 2022 13:42:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F262C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 13:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49AB960F30
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 13:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TfP3D8JhLcb5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 13:42:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FEF16100D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654609324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9GWchY9hZYcIJP7lDw5j1KYfu5h/jhdfCsZWPH40Q8=;
 b=RRi4QjAn7sx1oxiTav2LXVEYk4HjhJ6sIs/BBH9vY97myKLAzT5nH3hG6OkQEzW0icahmL
 X9YGMngXem6pGZs0mF3Gu3WsNGsOhCbyluyFNnOwEOlwv3RSHJuynzgqmc2z7z0luUvi7t
 2If3Mg/3tHHa9z/ezVwoOCuCAtbsmSM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-1l_svAg-Nha8BL7jMxTEuA-1; Tue, 07 Jun 2022 09:42:01 -0400
X-MC-Unique: 1l_svAg-Nha8BL7jMxTEuA-1
Received: by mail-qt1-f198.google.com with SMTP id
 t14-20020a05622a01ce00b002ff91ea4445so13999021qtw.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Jun 2022 06:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U9GWchY9hZYcIJP7lDw5j1KYfu5h/jhdfCsZWPH40Q8=;
 b=YlzZIyruXXY9b3NCJOq0NAS0n2d1ObrnTQyg3oKB7J2y/I1NN1b6Z+tFZvFenQB0ew
 i+QerdEHhl0pNO2e2pkqrDVhZoUmjvPOT26WTSIOtdVZE3s5dzoWF4uhCyMRjwYZ1EjG
 5m7fwEMGC0kEtapXveUh7px5WeAaTXHcuVBXvkjTRx5IuvB7kzbw14B9F1FwyNeIexxj
 S9YUDA/NqQ/DBhE67cLScTvxUbPfyoNldXpaww9cFH+L5wpGA1j+kNDcdlx1JNdPw2yt
 SI4hE9bDq3cvjUIAyY1u1WGMvWk/FsWu48EWCyVjlAlz/FL8IrqwTnfGPexr+tfXmYYj
 wT9w==
X-Gm-Message-State: AOAM532ABkkCivQ7B6mR0IMGUHVH+hi0+V5UgjJ8vvyxrsdQLxYwC5jx
 +Ev4FHp1pv8BzZZAPxgPiebk5RspHvr01AHZk8qzadFphOZxWn+ajfuj2GcyKBsQu2JOMDFZN9e
 a8rwkeoZPni/NJmv2Irtqt+BIJ3zxsq777jh293ImYg==
X-Received: by 2002:ac8:5acc:0:b0:304:f75a:4a1d with SMTP id
 d12-20020ac85acc000000b00304f75a4a1dmr3015568qtd.120.1654609320541; 
 Tue, 07 Jun 2022 06:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyavNr4YW+NLtrlTYw3DwYvyx9zxVnBrVGsEoQi3F5ODngxQYCXvCvG44n4ArB8DEsaTyYSw==
X-Received: by 2002:ac8:5acc:0:b0:304:f75a:4a1d with SMTP id
 d12-20020ac85acc000000b00304f75a4a1dmr3015540qtd.120.1654609320271; 
 Tue, 07 Jun 2022 06:42:00 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
 by smtp.gmail.com with ESMTPSA id
 ay33-20020a05620a17a100b006a6f68c8a87sm148860qkb.126.2022.06.07.06.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jun 2022 06:41:59 -0700 (PDT)
Date: Tue, 7 Jun 2022 09:41:57 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 05/20] mm/migrate: Convert expected_page_refs() to
 folio_expected_refs()
Message-ID: <Yp9VpZDsUEAZHEuy@bfoster>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-6-willy@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20220606204050.2625949-6-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bfoster@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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

On Mon, Jun 06, 2022 at 09:40:35PM +0100, Matthew Wilcox (Oracle) wrote:
> Now that both callers have a folio, convert this function to
> take a folio & rename it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/migrate.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 77b8c662c9ca..e0a593e5b5f9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -337,13 +337,18 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>  }
>  #endif
>  
> -static int expected_page_refs(struct address_space *mapping, struct page *page)
> +static int folio_expected_refs(struct address_space *mapping,
> +		struct folio *folio)
>  {
> -	int expected_count = 1;
> +	int refs = 1;
> +	if (!mapping)
> +		return refs;
>  
> -	if (mapping)
> -		expected_count += compound_nr(page) + page_has_private(page);
> -	return expected_count;
> +	refs += folio_nr_pages(folio);
> +	if (folio_get_private(folio))
> +		refs++;

Why not folio_has_private() (as seems to be used for later
page_has_private() conversions) here?

> +
> +	return refs;;

Nit: extra ;

Brian

>  }
>  
>  /*
> @@ -360,7 +365,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>  	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
>  	struct zone *oldzone, *newzone;
>  	int dirty;
> -	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
> +	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
>  	long nr = folio_nr_pages(folio);
>  
>  	if (!mapping) {
> @@ -670,7 +675,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  		return migrate_page(mapping, &dst->page, &src->page, mode);
>  
>  	/* Check whether page does not have extra refs before we do more work */
> -	expected_count = expected_page_refs(mapping, &src->page);
> +	expected_count = folio_expected_refs(mapping, src);
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> -- 
> 2.35.1
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
