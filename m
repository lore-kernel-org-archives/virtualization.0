From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 0/6] Guest page hinting version 7.
Date: Thu, 02 Apr 2009 13:34:37 -0700
Message-ID: <49D5215D.6050503@goop.org>
References: <20090327150905.819861420@de.ibm.com>	<200903281705.29798.rusty@rustcorp.com.au>	<20090329162336.7c0700e9@skybase>	<200904022232.02185.nickpiggin@yahoo.com.au>	<20090402175249.3c4a6d59@skybase> <49D50CB7.2050705@redhat.com> <49D518E9.1090001@goop.org> <49D51CA9.6090601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <49D51CA9.6090601@redhat.com>
Sender: owner-linux-mm@kvack.org
To: Rik van Riel <riel@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>, frankeh@watson.ibm.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hugh@veritas.com, Xen-devel <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Rik van Riel wrote:
> Jeremy Fitzhardinge wrote:
>> The more complex host policy decisions of how to balance overall 
>> memory use system-wide are much in the same for both mechanisms.
> Not at all.  Page hinting is just an optimization to host swapping, where
> IO can be avoided on many of the pages that hit the end of the LRU.
>
> No decisions have to be made at all about balancing memory use
> between guests, it just happens through regular host LRU aging.

When the host pages out a page belonging to guest A, then its making a 
policy decision on how large guest A should be compared to B.  If the 
policy is a global LRU on all guest pages, then that's still a policy on 
guest sizes: the target size is a function of its working set, assuming 
that the working set is well modelled by LRU.  I imagine that if the 
guest and host are both managing their pages with an LRU-like algorithm 
you'll get some nasty interactions, which page hinting tries to alleviate.

> Automatic ballooning requires that something on the host figures
> out how much memory each guest needs and sizes the guests
> appropriately.  All the proposed policies for that which I have
> seen have some nasty corner cases or are simply very limited
> in scope.

Well, you could apply something equivalent to a global LRU: ask for more 
pages from guests who have the most unused pages.  (I'm not saying that 
its necessarily a useful policy.)

    J

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
