From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 04/26] Xen-paravirt_ops: Add pagetable
	accessors to pack and unpack pagetable entries
Date: Thu, 01 Mar 2007 08:02:50 +1100
Message-ID: <1172696571.10271.40.camel@localhost.localdomain>
References: <20070227081337.434798469@goop.org>
	<20070227081630.311681690@goop.org> <20070227100850.GA10827@elte.hu>
	<45E47DEF.70405@goop.org>  <20070228083203.GB8866@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070228083203.GB8866@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-02-28 at 09:32 +0100, Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > >> +#ifdef CONFIG_PARAVIRT
> > >> +/* After pte_t, etc, have been defined */
> > >> +#include <asm/paravirt.h>
> > >> +#endif
> > >>     
> > >
> > > hm - there's already a CONFIG_PARAVIRT conditional in 
> > > asm-i386/paravirt.h.
> > 
> > Yes, but it happens after asm/paravirt.h has already included some 
> > things, and it ends up causing problems.  paravirt.h still defines 
> > various stub functions in the !CONFIG_PARAVIRT case, so it needs to do 
> > the includes either way.
> 
> hm, it then needs to be fixed first, instead of adding to the mess.

Yes, originally paravirt.h didn't define anything if !CONFIG_PARAVIRT
for this reason: getting it tied into the other headers correctly is a
PITA.

Rusty.
