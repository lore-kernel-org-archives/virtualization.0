From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 14/26] Xen-paravirt_ops: add common patching
	machinery
Date: Sat, 17 Mar 2007 20:15:36 +1100
Message-ID: <1174122936.8897.21.camel@localhost.localdomain>
References: <20070301232443.195603797@goop.org>
	<20070301232528.055105942@goop.org>  <20070316092054.GK23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316092054.GK23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-03-16 at 10:20 +0100, Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Implement the actual patching machinery.  paravirt_patch_default() 
> > contains the logic to automatically patch a callsite based on a few 
> > simple rules:
> > 
> >  - if the paravirt_op function is paravirt_nop, then patch nops
> >  - if the paravirt_op function is a jmp target, then jmp to it
> >  - if the paravirt_op function is callable and doesn't clobber too much
> >     for the callsite, call it directly
> > 
> > paravirt_patch_default is suitable as a default implementation of 
> > paravirt_ops.patch, will remove most of the expensive indirect calls 
> > in favour of either a direct call or a pile of nops.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

I like this one too, but note that it needs a twist when we change to
use direct calls to wrappers for the Great paravirt_ops Unexporting.

Rusty.
