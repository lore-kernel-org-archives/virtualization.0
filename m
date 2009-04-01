From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 4/6] Guest page hinting: writable page table entries.
Date: Wed, 01 Apr 2009 09:25:34 -0400
Message-ID: <49D36B4E.7000702@redhat.com>
References: <20090327150905.819861420@de.ibm.com> <20090327151012.398894143@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20090327151012.398894143@de.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:

This code has me stumped.  Does it mean that if a page already
has the PageWritable bit set (and count_ok stays 0), we will
always mark the page as volatile?

How does that work out on !s390?

>  /**
> + * __page_check_writable() - check page state for new writable pte
> + *
> + * @page: the page the new writable pte refers to
> + * @pte: the new writable pte
> + */
> +void __page_check_writable(struct page *page, pte_t pte, unsigned int offset)
> +{
> +	int count_ok = 0;
> +
> +	preempt_disable();
> +	while (page_test_set_state_change(page))
> +		cpu_relax();
> +
> +	if (!TestSetPageWritable(page)) {
> +		count_ok = check_counts(page, offset);
> +		if (check_bits(page) && count_ok)
> +			page_set_volatile(page, 1);
> +		else
> +			/*
> +			 * If two processes create a write mapping at the
> +			 * same time check_counts will return false or if
> +			 * the page is currently isolated from the LRU
> +			 * check_bits will return false but the page might
> +			 * be in volatile state.
> +			 * We have to take care about the dirty bit so the
> +			 * only option left is to make the page stable but
> +			 * we can try to make it volatile a bit later.
> +			 */
> +			page_set_stable_if_present(page);
> +	}
> +	page_clear_state_change(page);
> +	if (!count_ok)
> +		page_make_volatile(page, 1);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(__page_check_writable);


-- 
All rights reversed.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
