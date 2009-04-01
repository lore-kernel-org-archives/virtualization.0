From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 4/6] Guest page hinting: writable page table entries.
Date: Wed, 01 Apr 2009 10:45:53 -0400
Message-ID: <49D37E21.2000609@redhat.com>
References: <20090327150905.819861420@de.ibm.com>	<20090327151012.398894143@de.ibm.com>	<49D36B4E.7000702@redhat.com> <20090401163658.60f851ed@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20090401163658.60f851ed@skybase>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:
> On Wed, 01 Apr 2009 09:25:34 -0400
> Rik van Riel <riel@redhat.com> wrote:
> 
>> Martin Schwidefsky wrote:
>>
>> This code has me stumped.  Does it mean that if a page already
>> has the PageWritable bit set (and count_ok stays 0), we will
>> always mark the page as volatile?
>>
>> How does that work out on !s390?
> 
> No, we will not always mark the page as volatile. If PG_writable is
> already set count_ok will stay 0 and a call to page_make_volatile is
> done. This differs from page_set_volatile as it repeats all the
> required checks, then calls page_set_volatile with a PageWritable(page)
> as second argument. What state the page will get depends on the
> architecture definition of page_set_volatile. For s390 this will do a
> state transition to potentially volatile as the PG_writable bit is set.
> On architecture that cannot check the dirty bit on a physical page basis
> you need to make the page stable.

Good point. I guess that means patch 4/6 checks out right, then :)

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
