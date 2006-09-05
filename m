From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Tue, 05 Sep 2006 11:27:53 -0700
Message-ID: <1157480873.3186.57.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157127483.28577.117.camel@localhost.localdomain>
	 <1157127943.21733.52.camel@localhost>
	 <1157128634.28577.139.camel@localhost.localdomain>
	 <1157129762.21733.63.camel@localhost>
	 <1157130970.28577.150.camel@localhost.localdomain>
	 <1157132520.21733.78.camel@localhost>
	 <1157133780.18728.6.camel@localhost.localdomain>
	 <1157133841.21733.79.camel@localhost>
	 <1157135024.18728.19.camel@localhost.localdomain>
	 <1157135504.21733.83.camel@localhost>
	 <1157136106.18728.27.camel@localhost.localdomain>
	 <1157368883.5078.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030181AbWIES2R@vger.kernel.org>
In-Reply-To: <1157368883.5078.24.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2006-09-04 at 13:21 +0200, Martin Schwidefsky wrote:
> Any kind of locking won't work. You need the information that a page has
> been discarded until the page has been freed. Only then the fact that
> the page has been discarded may enter nirvana. Any kind of lock needs to
> be freed again to allow the next discard fault to happen. Since you
> don't when the last page reference is returned you cannot hold the lock
> until the page is free.

First of all, you *CAN* sleep with the BKL held. ;)

Why doesn't the normal lock_page() help?  It can sleep, too?

As far as simplifying the patches, I feel like some of the
page_make_stable() stuff should be done inside of page_cache_get().
Perhaps the API needs to be changed so that page_cache_get()s can fail.

There are also a ton of "mapping == page->mapping" tests all over.
Perhaps you need a page_still_in_mapping(page, mapping) call that also
checks the page's discard state.

I also have the feeling that every single page_host_discards() check
which is actually placed in the VM code shouldn't be there.  The ones in
page_make_stable() and friends are OK, but the ones in
shrink_inactive_list() seem bogus to me.  Looks like they should be
covered up in some _other_ function that checks PageDiscarded().

You could even put these things in (what are now) simple functions like
lru_to_page().  The logic would be along the lines of, whenever I am
looking into the LRU, I need to make sure this page is still actually
there.

As for the locking, imagine a seqlock (per-zone, node, section, hash,
anon_vma, mapping, whatever...).  A write is taken any time that
PG_discard would have been set, and the page is placed in to a list so
that it can be found (the data structure isn't important now).  All of
the places that currently check PG_discard would go and take a read on
the seqlock.  If they fail to acquire it (what is normally now a loop),
they would go look in the list to see if the page they are interested in
is there.  If it is, then they treat it as dicarded, otherwise they
proceed normally.  So, the operation is normally very cheap (a
non-atomic read).  It is very expensive _during_ a discard because of
the traversal of the list, but these should be rare.

The structure storing the page could be like this:

struct page_list {
	struct list_head list;
	struct page *page;
};

So that it doesn't require any extra space in the struct page, and
limits the overhead to only the people actually using the page discard
mechanism.

-- Dave
