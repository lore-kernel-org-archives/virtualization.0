Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B63FC433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 14:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 546F26100D;
	Tue,  7 Jun 2022 14:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYSM24eHETZd; Tue,  7 Jun 2022 14:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03C7260D6E;
	Tue,  7 Jun 2022 14:12:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA998C0032;
	Tue,  7 Jun 2022 14:12:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57A09C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FBF960D6E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GcgenUKhMc_3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:12:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 227B760D61
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4nUpYTI4YzQUWe3MX/DeuqIdjPgTHj7mksBWnabO8pk=; b=IoritkaL90aqbR+RUHZKoSo8fb
 np1ux4ttns5tYj2sJk/FAj12Ak/CQ/wW4eIuwXN5ulK6rhUSeL7wfME8a6K9gYUgIYgqg08BNe9+I
 tus3kQ04SmPJZl9V4GH+E2xTibe280AETqIE3sbtSug/TUXDR0128c42jRa/+qeI8q7uri0dQOk1f
 wWHM11+pgzBreVL8bkL3da/JDGIf99g2HUm8tnTrzT4cPM9I17c3dxlon1CkQMKJOgWEf9FbWmKJ9
 h7TOtnv+jsL8ABFyKBR86bb03b2ZVDj0NIek4XcowncLGE0YjVino+xsZhqucJvOU+7lO9abDpL7s
 BM8iPWpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyZvo-00BhC6-Sq; Tue, 07 Jun 2022 14:11:40 +0000
Date: Tue, 7 Jun 2022 15:11:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 05/20] mm/migrate: Convert expected_page_refs() to
 folio_expected_refs()
Message-ID: <Yp9cnCaZ1O4qHFEp@casper.infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-6-willy@infradead.org>
 <Yp9VpZDsUEAZHEuy@bfoster>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yp9VpZDsUEAZHEuy@bfoster>
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

On Tue, Jun 07, 2022 at 09:41:57AM -0400, Brian Foster wrote:
> On Mon, Jun 06, 2022 at 09:40:35PM +0100, Matthew Wilcox (Oracle) wrote:
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
> 
> Why not folio_has_private() (as seems to be used for later
> page_has_private() conversions) here?

We have a horrid confusion that I'm trying to clean up stealthily
without anyone noticing.  I would have gotten away with it too if it
weren't for you pesky kids.

#define PAGE_FLAGS_PRIVATE                              \
        (1UL << PG_private | 1UL << PG_private_2)

static inline int page_has_private(struct page *page)
{
        return !!(page->flags & PAGE_FLAGS_PRIVATE);
}

So what this function is saying is that there is one extra refcount
expected on the struct page if PG_private _or_ PG_private_2 is set.

How are filesystems expected to manage their page's refcount with this
rule?  Increment the refcount when setting PG_private unless
PG_private_2 is already set?  Decrement the refcount when clearing
PG_private_2 unless PG_private is set?

This is garbage.  IMO, PG_private_2 should have no bearing on the page's
refcount.  Only btrfs and the netfs's use private_2 and neither of them
do anything to the refcount when setting/clearing it.  So that's what
I'm implementing here.

> > +
> > +	return refs;;
> 
> Nit: extra ;

Oh, that's where it went ;-)  I had a compile error due to a missing
semicolon at some point, and thought it was just a typo ...
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
