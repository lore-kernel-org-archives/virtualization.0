From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 06/26] Xen-paravirt_ops: paravirt_ops:
 allocate a fixmap slot
Date: Tue, 27 Feb 2007 16:49:53 -0800
Message-ID: <45E4D1B1.7030903@goop.org>
References: <20070227081337.434798469@goop.org>
	<20070227081631.122933982@goop.org>
	<20070227101143.GC10827@elte.hu> <45E47E95.2060803@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45E47E95.2060803@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
>   
>> why not vmalloc it on the guest side? fixmaps are bad for this purpose 
>> for a general paravirt implementation, it limits the size of the shared 
>> info page, etc.
>>     
>
> Yes.  vmalloc would have the annoying side-effect of actually allocating
> some pages which would be shadowed by the remapping, but I guess
> get_vm_area would do the job.  I'll give it a go.

Hm, this is a bit awkward.  We need to map the shared info page fairly
early - say, around paging_init - but we're still on the bootmem
allocator at that point, so get_vm_area isn't usable yet.  Using a
fixmap keeps things simple.  It seems to me that having a single fixmap
available is useful for this kind of simple/early mapping, and if
someone needs to map something larger, then they can put it off until
get_vm_area() is available...

    J
