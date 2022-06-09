Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDE5C43334
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 12:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A1A7409E2;
	Thu,  9 Jun 2022 12:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5FOUEzw2KVwE; Thu,  9 Jun 2022 12:50:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1370B400CC;
	Thu,  9 Jun 2022 12:50:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC6ECC0039;
	Thu,  9 Jun 2022 12:50:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 737A0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 12:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 619E5409E2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 12:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zKhX8LJBUp3S
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 12:50:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17020400CC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654779024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSyVt04wqMoyKuQwGc4zbS9w9C6qNO7mTJG8w/5DiLs=;
 b=Rl3YETfEkiQD6P2TsO5Q+i5VUelvKEU17hm+QH6XVlbmrAJ7L3t+EKioFBQ5V87wSzaX2K
 P9vJkXK6o5F0e3B84HtDADUGHQ9+35O3pCsp1XpTsGXgoMQ02jOISrg18N3vhiAfq/tIlh
 UX1g0Zx+CYCEYOq3jeqHpE2JcOdz03I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-w1E01Yz5MhWBef6U0z1joQ-1; Thu, 09 Jun 2022 08:50:23 -0400
X-MC-Unique: w1E01Yz5MhWBef6U0z1joQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 k32-20020a05600c1ca000b0039c4cf75023so6962447wms.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Jun 2022 05:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=jSyVt04wqMoyKuQwGc4zbS9w9C6qNO7mTJG8w/5DiLs=;
 b=AEDQf2skWpJkWX/QfwVhP1BN3YqbLiLPKeQSUOeLrkS5ueNSVldy4RVMJvGWGN1T27
 th4PR2LZRroH2kF6FhsSczL1XGSRS9oEmlYYf+qZB59UX0/aw2qnEsPRsbqIytrQWJCS
 xOfpK0ePoS9gXHCnweOz6qyZqyHOt6aJT1Fz22MCYQpr9clUujzAkLLEjtFUFbCIaE3u
 e8oKLRMrWju3s2B+GKyS+dv7pcqrBapOv7/jCbRlJX//XHNUX25AhDwapSmnCrYyRjWV
 h0FhWiEnioEYFfxHMkaGPCUh+FHL4iHBhYpa8XXQ2jyKLgfQqIGcMsewTwK9g5RaLSRa
 sWeg==
X-Gm-Message-State: AOAM531Bb+RP8l5d763oD+U7AgbTgvMcqu/iC7RknC07QrZ6CUiEPWPY
 W9Ze6y3Xu20EheniHr1fIurFAWNrXrJCn7UwlluyGMxdVTgInt4/sMmT0cZjW7Wa0DJri+xcPJh
 po/YSJcjxcfAGdE75lDCchF5EIwKkSoRYgP2I8+lLUg==
X-Received: by 2002:a1c:4c0d:0:b0:39c:5233:1873 with SMTP id
 z13-20020a1c4c0d000000b0039c52331873mr3299349wmf.28.1654779022064; 
 Thu, 09 Jun 2022 05:50:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJlGErsfVOd4GnScqiilTH958FLxgjsObuI+18makmIYSKefVpu0HdsVXKQhmSAU7kjNobOQ==
X-Received: by 2002:a1c:4c0d:0:b0:39c:5233:1873 with SMTP id
 z13-20020a1c4c0d000000b0039c52331873mr3299322wmf.28.1654779021707; 
 Thu, 09 Jun 2022 05:50:21 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8?
 ([2a09:80c0:192:0:20af:34be:985b:b6c8])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a056000124800b002185d79dc7fsm5672822wrx.75.2022.06.09.05.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jun 2022 05:50:21 -0700 (PDT)
Message-ID: <b2a81248-03fc-afb3-1041-d8206e95e08a@redhat.com>
Date: Thu, 9 Jun 2022 14:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 03/19] fs: Add aops->migrate_folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-4-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608150249.3033815-4-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
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

On 08.06.22 17:02, Matthew Wilcox (Oracle) wrote:
> Provide a folio-based replacement for aops->migratepage.  Update the
> documentation to document migrate_folio instead of migratepage.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/filesystems/locking.rst |  5 ++--
>  Documentation/filesystems/vfs.rst     | 13 ++++++-----
>  Documentation/vm/page_migration.rst   | 33 ++++++++++++++-------------
>  include/linux/fs.h                    |  4 +++-
>  mm/compaction.c                       |  4 +++-
>  mm/migrate.c                          | 11 +++++----
>  6 files changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index c0fe711f14d3..3d28b23676bd 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -253,7 +253,8 @@ prototypes::
>  	void (*free_folio)(struct folio *);
>  	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>  	bool (*isolate_page) (struct page *, isolate_mode_t);
> -	int (*migratepage)(struct address_space *, struct page *, struct page *);
> +	int (*migrate_folio)(struct address_space *, struct folio *dst,
> +			struct folio *src, enum migrate_mode);
>  	void (*putback_page) (struct page *);

isolate_page/putback_page are leftovers from the previous patch, no?

>  	int (*launder_folio)(struct folio *);
>  	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count);
> @@ -281,7 +282,7 @@ release_folio:		yes
>  free_folio:		yes
>  direct_IO:
>  isolate_page:		yes
> -migratepage:		yes (both)
> +migrate_folio:		yes (both)
>  putback_page:		yes

Dito.

>  launder_folio:		yes
>  is_partially_uptodate:	yes
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index a08c652467d7..3ae1b039b03f 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -740,7 +740,8 @@ cache in your filesystem.  The following members are defined:
>  		/* isolate a page for migration */
>  		bool (*isolate_page) (struct page *, isolate_mode_t);
>  		/* migrate the contents of a page to the specified target */
> -		int (*migratepage) (struct page *, struct page *);
> +		int (*migrate_folio)(struct mapping *, struct folio *dst,
> +				struct folio *src, enum migrate_mode);
>  		/* put migration-failed page back to right list */
>  		void (*putback_page) (struct page *);

Dito.

>  		int (*launder_folio) (struct folio *);
> @@ -935,12 +936,12 @@ cache in your filesystem.  The following members are defined:
>  	is successfully isolated, VM marks the page as PG_isolated via
>  	__SetPageIsolated.
>  
> -``migrate_page``
> +``migrate_folio``
>  	This is used to compact the physical memory usage.  If the VM
> -	wants to relocate a page (maybe off a memory card that is
> -	signalling imminent failure) it will pass a new page and an old
> -	page to this function.  migrate_page should transfer any private
> -	data across and update any references that it has to the page.
> +	wants to relocate a folio (maybe from a memory device that is
> +	signalling imminent failure) it will pass a new folio and an old
> +	folio to this function.  migrate_folio should transfer any private
> +	data across and update any references that it has to the folio.
>  
>  ``putback_page``
>  	Called by the VM when isolated page's migration fails.

Dito.

> diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
> index 8c5cb8147e55..e0f73ddfabb1 100644
> --- a/Documentation/vm/page_migration.rst
> +++ b/Documentation/vm/page_migration.rst
> @@ -181,22 +181,23 @@ which are function pointers of struct address_space_operations.
>     Once page is successfully isolated, VM uses page.lru fields so driver
>     shouldn't expect to preserve values in those fields.
>  
> -2. ``int (*migratepage) (struct address_space *mapping,``
> -|	``struct page *newpage, struct page *oldpage, enum migrate_mode);``
> -
> -   After isolation, VM calls migratepage() of driver with the isolated page.
> -   The function of migratepage() is to move the contents of the old page to the
> -   new page
> -   and set up fields of struct page newpage. Keep in mind that you should
> -   indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
> -   under page_lock if you migrated the oldpage successfully and returned
> -   MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, driver
> -   can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short time
> -   because VM interprets -EAGAIN as "temporary migration failure". On returning
> -   any error except -EAGAIN, VM will give up the page migration without
> -   retrying.
> -
> -   Driver shouldn't touch the page.lru field while in the migratepage() function.
> +2. ``int (*migrate_folio) (struct address_space *mapping,``
> +|	``struct folio *dst, struct folio *src, enum migrate_mode);``
> +
> +   After isolation, VM calls the driver's migrate_folio() with the
> +   isolated folio.  The purpose of migrate_folio() is to move the contents
> +   of the source folio to the destination folio and set up the fields
> +   of destination folio.  Keep in mind that you should indicate to the
> +   VM the source folio is no longer movable via __ClearPageMovable()
> +   under folio if you migrated the source successfully and returned
> +   MIGRATEPAGE_SUCCESS.  If driver cannot migrate the folio at the
> +   moment, driver can return -EAGAIN. On -EAGAIN, VM will retry folio
> +   migration in a short time because VM interprets -EAGAIN as "temporary
> +   migration failure".  On returning any error except -EAGAIN, VM will
> +   give up the folio migration without retrying.
> +
> +   Driver shouldn't touch the folio.lru field while in the migrate_folio()
> +   function.
>  
>  3. ``void (*putback_page)(struct page *);``

Hmm, here it's a bit more complicated now, because we essentially have
two paths: LRU+migrate_folio or !LRU+movable_ops
(isolate/migrate/putback page)



-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
