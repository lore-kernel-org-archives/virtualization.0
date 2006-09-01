From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Fri, 01 Sep 2006 17:43:40 +0200
Message-ID: <1157125420.21733.28.camel@localhost>
References: <20060901110908.GB15684@skybase>
	 <1157124821.28577.88.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751650AbWIAPn4@vger.kernel.org>
In-Reply-To: <1157124821.28577.88.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 08:33 -0700, Dave Hansen wrote:
> > +++ linux-2.6-patched/mm/page_alloc.c   2006-09-01 12:49:35.000000000
> > +0200
> > @@ -515,6 +515,7 @@ static void __free_pages_ok(struct page 
> >                 reserved += free_pages_check(page + i);
> >         if (reserved)
> >                 return;
> > +       page_set_unused(page, order);
> >  
> >         kernel_map_pages(page, 1 << order, 0);
> >         local_irq_save(flags); 
> 
> Do these have anything in common with arch_free_page()?  I thought
> marking the pages as being "unused by the kernel" was the whole idea of
> having that hook.

This question did come up already. arch_free_page() is done before the
PageReserved() check so it isn't suitable for stable/unused state
transitions. You can argue that arch_free_page() should be moved but who
knows what the architecture defined function is supposed to do?
page_set_stable/page_set_unused on the other hand have a clearly defined
meaning.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
