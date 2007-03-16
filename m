From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 15/26] Xen-paravirt_ops: Add
 apply_to_page_range() which applies a function to a pte range.
Date: Fri, 16 Mar 2007 10:08:43 -0700
Message-ID: <45FACF1B.5010709@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232528.155002121@goop.org>
	<20070316091940.GJ23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316091940.GJ23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <clameter@sgi.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> nice one! I suspect we could simplify some of the less 
> performance-critical open-coded pagetable walker loops in the kernel 
> with this? (i'm not even sure it's all that much of a performance loss 
> to pass a function pointer around - would be nice to convert say 
> mprotect() to this and see the performance difference?)
>   

apply_page_to_range has the side-effect of allocating all the pagetable
levels for the address range it walks.  Xen uses this to populate
pagetables (for example, build out the pagetable, and let the hypervisor
plug a mapping into the pte page).

If that's OK for the other uses, then it should be good.

    J
