From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 18:56:01 +0200
Message-ID: <1157129762.21733.63.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157127483.28577.117.camel@localhost.localdomain>
	 <1157127943.21733.52.camel@localhost>
	 <1157128634.28577.139.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932120AbWIAQ4H@vger.kernel.org>
In-Reply-To: <1157128634.28577.139.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 09:37 -0700, Dave Hansen wrote:
> Can you give me the sequence of events that occur so that we need to
> set, then check PG_discarded?  I'm not getting it.
> 
> 1. there is good data in a page
> ...
> 50.  ... and PG_discarded gets set
> ...
> 99.  We check PG_discarded and ...

Ok, here we go:
0) there is good data in a page
1) the host scans for pages to reclaim and selects a page of a
particular guest
2) the host checks the page state and decides to either swap the page or
discard it
3) nothing happens for a long time
4) the guest comes around and tries to access the long gone page
5) the host gets a fault because the page is gone from the hosts page
table for the guest system
6) the host delivers a discard fault to the guest
7) the architecture dependent fault handler gets a page reference for
the discarded page (tricky for s390)
8) page_discard is called which locks the page and does a
TestSetPageDiscarded. If the bit has not been set yet the page is
removed from the page cache. There can still be page references around.

Concurrent to 5-8 another cpu could be just be removing the page from
page cache as well. Without the check for the discarded bit the page
would get removed twice. This does nasty things to reference counting,
mapping->nrpages, ...

> > NUMA node is not granular enough, mem_section is probably doable. I do
> > not understand the part about the bit in the mem_map[] area, a bit in
> > the page->flags is exactly that, isn't it?
> 
> No, I'm being tricky.  There are struct pages for all memory, including
> kernel memory.  mem_map[] is in kernel memory.  So, the memory for the
> mem_map[] has struct pages, which themselves are in the mem_map[].
> 
> void lock_page_for_state_change(struct page *page)
> {
>         struct pages_backing_page = virt_to_page(page);
>         lock_page(pages_backing_page)
> }
> 
> We did this for a bit with sparsemem, I think.  That is, until Andy came
> up with something even more clever.

Ouch, I understand what you are trying to tell me. The struct page
entries that cover the mem_map array itself has free bits we could try
to cannibalize.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
