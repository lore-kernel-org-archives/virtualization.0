From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 4/6] Guest page hinting: writable page table entries.
Date: Wed, 1 Apr 2009 16:36:58 +0200
Message-ID: <20090401163658.60f851ed@skybase>
References: <20090327150905.819861420@de.ibm.com>
	<20090327151012.398894143@de.ibm.com>
	<49D36B4E.7000702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <49D36B4E.7000702@redhat.com>
Sender: owner-linux-mm@kvack.org
To: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 01 Apr 2009 09:25:34 -0400
Rik van Riel <riel@redhat.com> wrote:

> Martin Schwidefsky wrote:
> 
> This code has me stumped.  Does it mean that if a page already
> has the PageWritable bit set (and count_ok stays 0), we will
> always mark the page as volatile?
> 
> How does that work out on !s390?

No, we will not always mark the page as volatile. If PG_writable is
already set count_ok will stay 0 and a call to page_make_volatile is
done. This differs from page_set_volatile as it repeats all the
required checks, then calls page_set_volatile with a PageWritable(page)
as second argument. What state the page will get depends on the
architecture definition of page_set_volatile. For s390 this will do a
state transition to potentially volatile as the PG_writable bit is set.
On architecture that cannot check the dirty bit on a physical page basis
you need to make the page stable.

> >  /**
> > + * __page_check_writable() - check page state for new writable pte
> > + *
> > + * @page: the page the new writable pte refers to
> > + * @pte: the new writable pte
> > + */
> > +void __page_check_writable(struct page *page, pte_t pte, unsigned int offset)
> > +{
> > +	int count_ok = 0;
> > +
> > +	preempt_disable();
> > +	while (page_test_set_state_change(page))
> > +		cpu_relax();
> > +
> > +	if (!TestSetPageWritable(page)) {
> > +		count_ok = check_counts(page, offset);
> > +		if (check_bits(page) && count_ok)
> > +			page_set_volatile(page, 1);
> > +		else
> > +			/*
> > +			 * If two processes create a write mapping at the
> > +			 * same time check_counts will return false or if
> > +			 * the page is currently isolated from the LRU
> > +			 * check_bits will return false but the page might
> > +			 * be in volatile state.
> > +			 * We have to take care about the dirty bit so the
> > +			 * only option left is to make the page stable but
> > +			 * we can try to make it volatile a bit later.
> > +			 */
> > +			page_set_stable_if_present(page);
> > +	}
> > +	page_clear_state_change(page);
> > +	if (!count_ok)
> > +		page_make_volatile(page, 1);
> > +	preempt_enable();
> > +}
> > +EXPORT_SYMBOL(__page_check_writable);
> 
> 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
