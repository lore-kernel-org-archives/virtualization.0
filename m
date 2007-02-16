From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 15:41:53 -0800
Message-ID: <45D64141.90307@goop.org>
References: <C1FBEEF5.2256%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FBEEF5.2256%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> It has no other users right now and get_vm_area_sync() would be a
> better-named and more generically useful function than alloc_vm_area().
I'm thinking "reserve" might be a better term; "get" generally has the
suggestion of a refcount.

> get_vm_area_sync(), partnered with existing remove_vm_area(), just seems
> much smaller and neater than adding four new functions with a more complex
> usage: alloc_vm_area, {lock,unlock}_vm_area, and free_vm_area. Maybe keeping
> free_vm_area() too makes sense as its interface is more neatly symmetrical
> to that of get_vm_area().

I've already killed the lock/unlock functions.  I'll come up with
something for the get/allocate/reserve and free functions.

    J
