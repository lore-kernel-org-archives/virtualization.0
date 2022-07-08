Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7BEC433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 03:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B002D84623;
	Fri,  8 Jul 2022 03:29:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B002D84623
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=rHG9dzm8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0HMrz9egmO5; Fri,  8 Jul 2022 03:29:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 11B5D8460B;
	Fri,  8 Jul 2022 03:29:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11B5D8460B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DED23C0033;
	Fri,  8 Jul 2022 03:29:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9FE7C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8427341187
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8427341187
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=rHG9dzm8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3CT0nDZUAax
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:29:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 357A44010C
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 357A44010C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oM2k/skZQvyu3mUYfkmntJvn7Ev2BYz4NH8zgIp7wHI=; b=rHG9dzm8IpPU7EfLVpII+KVjLX
 tK5RzYEsVvZxSEwtzFKftLvIoD7Gprdj8prhV6AczG/W1VhVFRA0+eJOe8FB1oYirYLF/RKjzuD1y
 UeDEi51PvWgAnfcZaU3Gwg3yJ7ho+xCZcFg47ydeQ/XmgoGz+hnH2UXSd2OVAnZpRaDhU4lA368tD
 oe+dO/0K+fc3cXMTKiXo8fOIKu03oBij5w1Ge8Sml/7vp/K9duiAF0tEeC/5h5rnSekPO7SDQxmi+
 t+Coa71RLCVtJVynZWQvpaKSs5ZIFuJtUldewmkkeABsbAtcvNHR4ZT5VhVmpe3X/ZzFhhyxT4Ch5
 5u2Qto6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o9eg6-003A5X-T9; Fri, 08 Jul 2022 03:29:15 +0000
Date: Fri, 8 Jul 2022 04:29:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 07/19] mm/migrate: Convert expected_page_refs() to
 folio_expected_refs()
Message-ID: <Ysekikp60Hhs5lV0@casper.infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-8-willy@infradead.org>
 <6e7599d1-8a5f-bf16-383c-febd753bd051@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e7599d1-8a5f-bf16-383c-febd753bd051@google.com>
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
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

On Thu, Jul 07, 2022 at 07:50:17PM -0700, Hugh Dickins wrote:
> On Wed, 8 Jun 2022, Matthew Wilcox (Oracle) wrote:
> 
> > Now that both callers have a folio, convert this function to
> > take a folio & rename it.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  mm/migrate.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 2975f0c4d7cf..2e2f41572066 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -336,13 +336,18 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
> >  }
> >  #endif
> >  
> > -static int expected_page_refs(struct address_space *mapping, struct page *page)
> > +static int folio_expected_refs(struct address_space *mapping,
> > +		struct folio *folio)
> >  {
> > -	int expected_count = 1;
> > +	int refs = 1;
> > +	if (!mapping)
> > +		return refs;
> >  
> > -	if (mapping)
> > -		expected_count += compound_nr(page) + page_has_private(page);
> > -	return expected_count;
> > +	refs += folio_nr_pages(folio);
> > +	if (folio_get_private(folio))
> > +		refs++;
> > +
> > +	return refs;
> >  }
> >  
> >  /*
> > @@ -359,7 +364,7 @@ int folio_migrate_mapping(struct address_space *mapping,
> >  	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
> >  	struct zone *oldzone, *newzone;
> >  	int dirty;
> > -	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
> > +	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
> >  	long nr = folio_nr_pages(folio);
> >  
> >  	if (!mapping) {
> > @@ -669,7 +674,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> >  		return migrate_page(mapping, &dst->page, &src->page, mode);
> >  
> >  	/* Check whether page does not have extra refs before we do more work */
> > -	expected_count = expected_page_refs(mapping, &src->page);
> > +	expected_count = folio_expected_refs(mapping, src);
> >  	if (folio_ref_count(src) != expected_count)
> >  		return -EAGAIN;
> >  
> > -- 
> > 2.35.1
> 
> This commit (742e89c9e352d38df1a5825fe40c4de73a5d5f7a in pagecache.git
> folio/for-next and recent linux-next) is dangerously wrong, at least
> for swapcache, and probably for some others.
> 
> I say "dangerously" because it tells page migration a swapcache page
> is safe for migration when it certainly is not.
> 
> The fun that typically ensues is kernel BUG at include/linux/mm.h:750!
> put_page_testzero() VM_BUG_ON_PAGE(page_ref_count(page) == 0, page),
> if CONFIG_DEBUG_VM=y (bisecting for that is what brought me to this).
> But I guess you might get silent data corruption too.
> 
> I assumed at first that you'd changed the rules, and were now expecting
> any subsystem that puts a non-zero value into folio->private to raise
> its refcount - whereas the old convention (originating with buffer heads)
> is that setting PG_private says an extra refcount has been taken, please
> call try_to_release_page() to lower it, and maybe that will use data in
> page->private to do so; but page->private free for the subsystem owning
> the page to use as it wishes, no refcount implication.  But that you
> had missed updating swapcache.
> 
> So I got working okay with the patch below; but before turning it into
> a proper patch, noticed that there were still plenty of other places
> applying the test for PG_private: so now think that maybe you set out
> with intention as above, realized it wouldn't work, but got distracted
> before cleaning up some places you'd already changed.  And patch below
> now goes in the wrong direction.
> 
> Or maybe you didn't intend any change, but the PG_private test just got
> missed in a few places.  I don't know, hope you remember, but current
> linux-next badly inconsistent.
> Over to you, thanks,

Ugh.  The problem I'm trying to solve is that we're short on page flags.
We _seemed_ to have correlation between "page->private != NULL" and
"PG_private is set", and so I thought I could make progress towards
removing PG_private.  But the rule you set out above wasn't written down
anywhere that I was able to find it.

I'm about to go to sleep, but I'll think on this some more tomorrow.

> Hugh
> 
> --- a/mm/migrate.c	2022-07-06 14:24:44.499941975 -0700
> +++ b/mm/migrate.c	2022-07-06 15:49:25.000000000 -0700
> @@ -351,6 +351,10 @@ unlock:
>  }
>  #endif
>  
> +static inline bool folio_counted_private(struct folio *folio)
> +{
> +	return !folio_test_swapcache(folio) && folio_get_private(folio);
> +}
>  static int folio_expected_refs(struct address_space *mapping,
>  		struct folio *folio)
>  {
> @@ -359,7 +363,7 @@ static int folio_expected_refs(struct ad
>  		return refs;
>  
>  	refs += folio_nr_pages(folio);
> -	if (folio_get_private(folio))
> +	if (folio_counted_private(folio))
>  		refs++;
>  
>  	return refs;
> --- a/mm/vmscan.c	2022-07-06 14:24:44.531942217 -0700
> +++ b/mm/vmscan.c	2022-07-06 15:49:37.000000000 -0700
> @@ -2494,6 +2494,10 @@ shrink_inactive_list(unsigned long nr_to
>   * The downside is that we have to touch folio->_refcount against each folio.
>   * But we had to alter folio->flags anyway.
>   */
> +static inline bool folio_counted_private(struct folio *folio)
> +{
> +	return !folio_test_swapcache(folio) && folio_get_private(folio);
> +}
>  static void shrink_active_list(unsigned long nr_to_scan,
>  			       struct lruvec *lruvec,
>  			       struct scan_control *sc,
> @@ -2538,8 +2542,9 @@ static void shrink_active_list(unsigned
>  		}
>  
>  		if (unlikely(buffer_heads_over_limit)) {
> -			if (folio_get_private(folio) && folio_trylock(folio)) {
> -				if (folio_get_private(folio))
> +			if (folio_counted_private(folio) &&
> +			    folio_trylock(folio)) {
> +				if (folio_counted_private(folio))
>  					filemap_release_folio(folio, 0);
>  				folio_unlock(folio);
>  			}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
