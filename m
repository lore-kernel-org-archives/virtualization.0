From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest implementation for
	paravirt_ops interface
Date: Sat, 17 Feb 2007 16:05:42 +1100
Message-ID: <1171688742.18876.69.camel@localhost.localdomain>
References: <20070216022449.739760547@goop.org>
	<Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
	<45D61C74.2000601@vmware.com>
	<Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
	<45D626BB.20007@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D626BB.20007@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, JAndi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-16 at 13:48 -0800, Zachary Amsden wrote:
> Christoph Lameter wrote:
> > It still seems to be implemented for Xen and not to support a variety o=
f =

> > page table methods in paravirt ops.
> =

> Yes, but that is just because the Xen hooks happens to be near the last =

> part of the merge.  VMI required some special hooks, as do both Xen and =

> lhype (I think ... Rusty can correct me if lhype's puppy's have =

> precluded the addition of new hooks).

lguest was supposed to be a demonstration of paravirt_ops, so it
shouldn't have added any.  But note that I did change some other things,
such as the esp0 initialization for the swapper.

Puppies are still alive and well.  Although Andi not pushing into 2.6.21
(yet?) made puppies sad 8(

>   Xen page table handling is very =

> different, mostly it is trap and emulate so writable page tables can =

> work, which means they don't always issue hypercalls for PTE updates, =

> although they do have that option, should the hypervisor MMU model =

> change, or performance concerns prompt a different model (or perhaps, =

> migration?)

Yes, Xen really like their direct pagetable stuff.  I'm a
traditionalist, myself, but it did require some expansion of
paravirt_ops.

KVM might well want more, although from here it's more likely we'll move
some of the hooks up the stack a little IMHO.

Cheers,
Rusty.
