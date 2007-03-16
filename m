From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 16/26] Xen-paravirt_ops: Allocate and free
	vmalloc areas
Date: Fri, 16 Mar 2007 10:16:48 +0100
Message-ID: <20070316091648.GI23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232528.297902504@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232528.297902504@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Allocate/destroy a 'vmalloc' VM area: alloc_vm_area and free_vm_area 
> The alloc function ensures that page tables are constructed for the 
> region of kernel virtual address space and mapped into init_mm.

> --- a/arch/i386/mm/fault.c

> +struct vm_struct *alloc_vm_area(unsigned long size)

this should go into mm/vmalloc.c.

	Ingo
