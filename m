From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 13/26] Xen-paravirt_ops: Consistently wrap
	paravirt ops callsites to make them patchable
Date: Fri, 16 Mar 2007 10:57:02 +0100
Message-ID: <20070316095702.GA301@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232527.956565107@goop.org>
	<20070316092445.GM23174@elte.hu>
	<20070316.023331.59468179.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070316.023331.59468179.davem@davemloft.net>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: David Miller <davem@davemloft.net>
Cc: zach@vmware.com, jeremy@goop.org, xen-devel@lists.xensource.com, ak@muc.de, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, virtualization@lists.osdl.org, anthony@codemonkey.ws, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* David Miller <davem@davemloft.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Fri, 16 Mar 2007 10:24:45 +0100
> 
> > ugh. This is beyond ugly! Why dont we just compile two images, one 
> > for Xen and one for native, do two passes to get those two images 
> > and 'merge' them into a single vmlinuz (so that we still have a 
> > 'single' kernel unit to deal with on the distro side). This way we 
> > avoid all this crazy, limited, fragile patchery business...
> 
> Perhaps the problem can be dealt with using ELF relocations.
> 
> There is another case, discussed yesterday on netdev, where run-time 
> resolution of ELF relocations would be useful (for 
> very-very-very-read-only variables) so if it can solve this problem 
> too it would be nice to have a generic infrastructure for it.

yeah, and i really think this is very fundamental: we've already got a 
very nice tool that can do things like detect when we are paravirt and 
optimize and patch things in a machine-specific way. It can even reorder 
instructions and simulate the CPU's pipeline state and do very smart 
optimizations based on that. It's a really neat thing, they call it 
"GCC".

Limited, instruction-level patching like alternatives.h is fine because 
that makes it easier to support multiple, incompatible CPU 
architectures, without having to do a hugely intrusive split at the 
kernel RPM level.

but the level of 'binary patching' done by the paravirt and Xen goes way 
beyond that, and the changes here really underscore that we:

  _should not emulate the closed source world_

There the only solution is to binary-patch - because they have no source 
code. But here, we've got all the source code.

splitting the images and simply extending vmlinuz to have a 
'multi-image' format would not only eliminate a huge amount of hookery, 
it would also solve the problem of CONFIG_PARAVIRT bloating the native 
kernel's codepaths by ~7%.

nobody wants to boot a xen-paravirt kernel from a floppy, so image size 
is not an issue. In-RAM overhead would in fact be /reduced/, because 
currently all the paravirt overhead hits both the native and the 
paravirt kernel. Nor would /all/ of the vmlinuz have to be replicated in 
the images - it's enough to replicate only those functions that truly 
differ between the two build methods.

	Ingo
