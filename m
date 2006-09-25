From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Mon, 25 Sep 2006 11:16:14 +1000
Message-ID: <1159146974.26986.30.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	<1158925997.26261.6.camel@localhost.localdomain>
	<1158926106.26261.8.camel@localhost.localdomain>
	<1158926215.26261.11.camel@localhost.localdomain>
	<1158926308.26261.14.camel@localhost.localdomain>
	<1158926386.26261.17.camel@localhost.localdomain>
	<4514663E.5050707@goop.org>
	<1158985882.26261.60.camel@localhost.localdomain>
	<45172AC8.2070701@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45172AC8.2070701@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2006-09-24 at 18:03 -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> >> So are symbols referencing the .data.percpu section 0-based?  Wouldn't =

> >> you need to subtract __per_cpu_start from the symbols to get a 0-based =

> >> segment offset?
> >>     =

> >
> > I don't think I understand the question.
> >
> > The .data.percpu section is the "template" per-cpu section, freed along
> > with other initdata: after setup_percpu_areas() is called, it is not
> > supposed to be used.  Around that time, the gs segment is set up based
> > at __per_cpu_offset[cpu], so "%gs:<varname>" accesses the local version.
> >   =

> =

> If you do
> =

>     DEFINE_PER_CPU(int, foo);
> =

> then this ends up defining per_cpu__foo in .data.percpu.  Since =

> .data.percpu is part of the init data section, it starts at some address =

> X (not 0), so the real offset into the actual per-cpu memory is actually =

> (per_cpu__foo - __per_cpu_start).  setup_per_cpu_areas() builds this =

> delta into the __per_cpu_offset[], and so it means that the base of your =

> %gs segment is at -__per_cpu_start from the actual start of the CPU's =

> per-cpu memory, and the limit has to be correspondingly larger.  Which =

> is a bit ugly.

Hi Jeremy!

	You're thinking of it in a convoluted way, by converting to offsets
from the per-cpu section, then converting it back.  How about this
explanation: the local cpu's versions are offset from where the compiler
thinks they are by __per_cpu_offset[cpu].  We set the segment base to
__per_cpu_offset[cpu], so "%gs:per_cpu__foo" gets us straight to the
local cpu version.  __per_cpu_offset[cpu] is always positive (kernel
image sits at bottom of kernel address space).

>   Especially since "__per_cpu_start" is actually very =

> large, and so this scheme pretty much relies on being able to wrap =

> around the segment limit, and will be very bad for Xen.

__per_cpu_start is large, yes.  But there's no reason to use it in
address calculation.  The second half of your statement is not correct.

> An alternative is to put the "-__per_cpu_start" into the addressing mode =

> when constructing the address of the per-cpu variable.

I think you're thinking of TLS relocations?  I don't use them...

Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
