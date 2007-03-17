From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Re: [patch 13/26] Xen-paravirt_ops: Consistently
	wrap paravirt ops callsites to make them patchable
Date: Sat, 17 Mar 2007 20:26:29 +1100
Message-ID: <1174123589.8897.33.camel@localhost.localdomain>
References: <20070301232443.195603797@goop.org>
	<20070301232527.956565107@goop.org>  <20070316092445.GM23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316092445.GM23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-03-16 at 10:24 +0100, Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Wrap a set of interesting paravirt_ops calls in a wrapper which makes 
> > the callsites available for patching.  Unfortunately this is pretty 
> > ugly because there's no way to get gcc to generate a function call, 
> > but also wrap just the callsite itself with the necessary labels.
> > 
> > This patch supports functions with 0-4 arguments, and either void or 
> > returning a value.  64-bit arguments must be split into a pair of 
> > 32-bit arguments (lower word first).  Small structures are returned in 
> > registers.
> 
> ugh. This is beyond ugly! Why dont we just compile two images, one for 
> Xen and one for native, do two passes to get those two images and 
> 'merge' them into a single vmlinuz (so that we still have a 'single' 
> kernel unit to deal with on the distro side). This way we avoid all this 
> crazy, limited, fragile patchery business...

But with lguest, VMI and kvm I don't think that's a good idea.

For background: the current patching code is ugly too, but it only deals
with the 6 most common functions, so it's contained.  This gets us
pretty close to !CONFIG_PARAVIRT performance.  (But slowdown is still
measurable).

We get worse with Xen wanting to alter mkpte et al.  By the time we
patch another 6 functions (each one slightly different), we get pretty
close to general coverage anyway, so it's clearer to do them all.

I think the question is, can we do it better than this?  My previous
attempts (which lead to the current code) ranged from ugly to very ugly
8(

Rusty.
