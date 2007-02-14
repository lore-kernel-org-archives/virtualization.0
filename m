From: Dan Hecht <dhecht@vmware.com>
Subject: Re: [patch 05/21] Xen-paravirt: paravirt_ops: allocate a fixmap slot
Date: Tue, 13 Feb 2007 18:34:28 -0800
Message-ID: <45D27534.1070608@vmware.com>
References: <20070213221729.772002682@goop.org> <20070213221829.845132535@goop.org> <45D2649D.4080508@vmware.com> <45D26797.5090600@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932265AbXBNCfG@vger.kernel.org>
In-Reply-To: <45D26797.5090600@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/13/2007 05:36 PM, Jeremy Fitzhardinge wrote:
> Dan Hecht wrote:
>> Why doesn't Xen allocate the shared_info page from the pseudo-physical
>> space?  Doesn't it already have to steal pages from the
>> pseudo-physical space for e.g. initial page tables, console, etc?  Why
>> not do the same for shared_info, and then you don't need a reserve the
>> fixmap slot.
> 
> Unlike the pagetable pages or the console page, the shared info page
> doesn't have a pseudo-physical address, so in order to map it we need to
> directly construct a pte containing the mfn for that page. 

Right.  But that is only because Xen decides to allocate the page from 
the (machine) physical space, rather than from the pseudo-physical 
space.  My question is: why doesn't Xen allocate shared_info from the 
pseudo-physical space?  If it had, then this page wouldn't need to be 
treated specially.  I'm not sure, but I seem to remember on 64-bit 
Xen/XenLinux allocated shared_info from pseudo-physical space already...

  Inserting
> this mapping into the fixmap space seems like the easiest way to do
> this.  It's not like a fixmap slot costs anything.
> 
>

I don't really have an objection to stealing a fixmap slot, just seems 
cleaner if you didn't have to special case the shared_info.

Dan
