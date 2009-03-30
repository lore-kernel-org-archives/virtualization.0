From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [patch 0/6] Guest page hinting version 7.
Date: Mon, 30 Mar 2009 08:54:55 -0700
Message-ID: <1238428495.8286.638.camel@nimitz>
References: <20090327150905.819861420@de.ibm.com>
	 <1238195024.8286.562.camel@nimitz>  <20090329161253.3faffdeb@skybase>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20090329161253.3faffdeb@skybase>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com, riel@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2009-03-29 at 16:12 +0200, Martin Schwidefsky wrote:
> > Can we persuade the hypervisor to tell us which pages it decided to page
> > out and just skip those when we're scanning the LRU?
> 
> One principle of the whole approach is that the hypervisor does not
> call into an otherwise idle guest. The cost of schedulung the virtual
> cpu is just too high. So we would a means to store the information where
> the guest can pick it up when it happens to do LRU. I don't think that
> this will work out.

I didn't mean for it to actively notify the guest.  Perhaps, as Rik
said, have a bitmap where the host can set or clear bit for the guest to
see.

As the guest is scanning the LRU, it checks the structure (or makes an
hcall or whatever) and sees that the hypervisor has already taken care
of the page.  It skips these pages in the first round of scanning.

I do see what you're saying about this saving the page-*out* operation
on the hypervisor side.  It can simply toss out pages instead of paging
them itself.  That's a pretty advanced optimization, though.  What would
this code look like if we didn't optimize to that level?

It also occurs to me that the hypervisor could be doing a lot of this
internally.  This whole scheme is about telling the hypervisor about
pages that we (the kernel) know we can regenerate.  The hypervisor
should know a lot of that information, too.  We ask it to populate a
page with stuff from virtual I/O devices or write a page out to those
devices.  The page remains volatile until something from the guest
writes to it.  The hypervisor could keep a record of how to recreate the
page as long as it remains volatile and clean.

That wouldn't cover things like page cache from network filesystems,
though.  

This patch does look like the full monty but I have to wonder what other
partial approaches are out there.  

-- Dave

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
