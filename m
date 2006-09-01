From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 19:02:30 +0200
Message-ID: <1157130150.21733.70.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157128157.28577.129.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932457AbWIARCd@vger.kernel.org>
In-Reply-To: <1157128157.28577.129.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 09:29 -0700, Dave Hansen wrote:
> > 3) The page-has-a-writable-mapping (PG_writable) bit is set when the
> > first writable pte for a page is established. The page needs to have a
> > different state if a writable pte exists compared to a read-only page.
> > The alternative without the page bit would be to do the state change
> > every time a writable pte is established or to search all ptes of a
> > given page. Both have performance implications.  
> 
> What are the performance implications?  Do they completely erase any
> performance gains that these patches might have given in the first
> place?  Has there been any evaluation of these other two alternatives?
> As I understand it, carrying out this performance analysis would be very
> difficult for most of the kernel community to perform.

It seemed obvious to me that anything else than checking a bit is way to
expensive. I never implemented nor measured any of the alternatives. The
alternative to do the state change every time a writable pte is
established can be implemented without too much trouble. Perhaps I will
give it a try next week.

> Keeping a nice count of the number of writable PTEs sounds like
> something that might be generally useful.  Could we split
> page->_mapcount to keep track of r/o and r/w ptes separately?  Or,
> perhaps a single bit in it can be utilized to replace PG_writable,
> instead.

Yes, that would be really useful for the writable ptes. But I have the
feeling that the actual implementation of it will be tricky.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
