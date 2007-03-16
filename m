From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 15/26] Xen-paravirt_ops: Add
	apply_to_page_range() which applies a function to a pte range.
Date: Fri, 16 Mar 2007 09:47:19 -0700
Message-ID: <20070316164719.GK10574@sequoia.sous-sol.org>
References: <20070301232443.195603797@goop.org>
	<20070301232528.155002121@goop.org>
	<20070316091940.GJ23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
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
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <clameter@sgi.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Add a new mm function apply_to_page_range() which applies a given 
> > function to every pte in a given virtual address range in a given mm 
> > structure. This is a generic alternative to cut-and-pasting the Linux 
> > idiomatic pagetable walking code in every place that a sequence of 
> > PTEs must be accessed.
> 
> nice one! I suspect we could simplify some of the less 
> performance-critical open-coded pagetable walker loops in the kernel 
> with this? (i'm not even sure it's all that much of a performance loss 
> to pass a function pointer around - would be nice to convert say 
> mprotect() to this and see the performance difference?)

We went through this before, and eventually got kick back to
keep it Xen specific.  There's still some effort for generalized
walkers from the Gelato folks IIRC.  And we can certainly adapt.
