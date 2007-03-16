From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 06/26] Xen-paravirt_ops: paravirt_ops:
	allocate a fixmap slot
Date: Fri, 16 Mar 2007 10:31:45 +0100
Message-ID: <20070316093145.GR23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232526.730138638@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232526.730138638@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Allocate a fixmap slot for use by a paravirt_ops implementation.  This 
> is intended for early-boot bootstrap mappings.  Once the zones and 
> allocator have been set up, it would be better to use get_vm_area() to 
> allocate some virtual space.
> 
> Xen uses this to map the hypervisor's shared info page, which doesn't 
> have a pseudo-physical page number, and therefore can't be mapped 
> ordinarily.  It is needed early because it contains the vcpu state, 
> including the interrupt mask.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
