From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 12/21] Xen-paravirt: Allocate and free vmalloc areas
Date: Fri, 16 Feb 2007 18:48:26 +1100
Message-ID: <45D561CA.3080609@yahoo.com.au>
References: <20070216022449.739760547@goop.org>	<20070216022531.417300365@goop.org>	<20070215224322.5c73d8e9.akpm@linux-foundation.org>	<45D55852.9000103@goop.org> <20070215232447.5ee67f50.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965240AbXBPHtF@vger.kernel.org>
In-Reply-To: <20070215232447.5ee67f50.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Jan Beulich <JBeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Thu, 15 Feb 2007 23:08:02 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> 
>>Andrew Morton wrote:
>>
>>>This won't work when CONFIG_PREEMPT=y.  The pagefault handler will see
>>>in_atomic() and will scram.
>>>  
>>
>>Is there some other way to get the pagetable populated for the address
>>range?
>>
> 
> 
> If you really need to run atomically, that gets ugly.  Even of one were to
> run handle_mm_fault() by hand, it still needs to allocate memory.
> 
> Two ugly options might be:
> 
> a) touch all the pages, then go atomic, then touch them all again.  If
>    one of them faults (ie: you raced with swapout) then go back and try
>    again.  Obviously susceptible to livelocking.
> 
> b) Do get_user_pages() against all the pages, then go atomic, then do
>    put_page() against them all.  Of course, they can immediately get
>    swapped out.
> 
> But that function's already racy against swapout and I guess it works OK. 
> I don't have clue what it is actually trying to do, so I'm guessing madly
> here.

Well its only operating on kernel pages, and against a vmalloc region.
So it would be immune to any sort of unmapping or swapout.

Andrew's option a) should work. What's this for, and how is it not Xen
specific if nothing else in the tree needs such a weird hack?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
