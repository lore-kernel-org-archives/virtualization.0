From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 23:29:57 +0000
Message-ID: <C1FBEEF5.2256%Keir.Fraser@cl.cam.ac.uk>
References: <45D60569.2050702@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D60569.2050702@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 19:26, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

> Keir Fraser wrote:
>> Hmmm... Actually looks like a bunch of architectures do lazy sync of the
>> vmalloc area, although neither ia64 nor powerpc does so. However, all
>> current users of the alloc_vm_area() function would be okay since none of
>> the other lazy-syncing architectures are supported by Xen.
>>   
> 
> Well, assuming that alloc_vm_area() has some non-Xen use, the right
> thing is for archs to export vmalloc_sync_all(), and just use that from
> common code.

It has no other users right now and get_vm_area_sync() would be a
better-named and more generically useful function than alloc_vm_area(). But
yes, to be done properly it does require vmalloc_sync_all() to be defined by
all architectures (even if that's BUG() and implement-properly-on-demand).

get_vm_area_sync(), partnered with existing remove_vm_area(), just seems
much smaller and neater than adding four new functions with a more complex
usage: alloc_vm_area, {lock,unlock}_vm_area, and free_vm_area. Maybe keeping
free_vm_area() too makes sense as its interface is more neatly symmetrical
to that of get_vm_area().

 -- Keir
