From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [q] kbuild for private asm-offsets (Re: [PATCH 6/10] lguest code:
	the little linux hypervisor.)
Date: Tue, 13 Feb 2007 04:10:44 +0100
Message-ID: <20070213031044.GA17046@flower.upol.cz>
References: <1171012296.2718.26.camel@localhost.localdomain>
	<1171012761.2718.40.camel@localhost.localdomain>
	<1171012827.2718.42.camel@localhost.localdomain>
	<200702091109.20061.ak@muc.de>
	<1171024771.2718.129.camel@localhost.localdomain>
	<20070209141728.GA26749@uranus.ravnborg.org>
	<1171034599.2718.190.camel@localhost.localdomain>
	<E1HGbJz-0003Lc-6h@flower>
	<1171323696.19842.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1171323696.19842.29.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 13, 2007 at 10:41:36AM +1100, Rusty Russell wrote:
> 	Always happy to explain.

Thanks!

[]
> 	So, asm-offsets.c is the solution: it uses asm() statements to emit
> patterns in the assembler, with the compiler computing the actual
> numbers, eg:
> =

> 	#define DEFINE(sym, val) \
(1) 	        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> 	DEFINE(SIZEOF_FOOBAR, sizeof(foobar));
> =

(2) Becomes in asm-offsets.s:
> 	->SIZEOF_FOOBAR $10 sizeof(foobar)  #
> =

(3) This gets sed'd back into asm-offsets.h:
> 	#define SIZEOF_FOOBAR 10 /* SIZEOF_FOOBAR  # */
> =

> This can be included from .S files (which get passed through the
> pre-processor).

So, to make this parsing job clear once again, (1) is a pattern generator
of (2) for sed (this is not assembler), which is making final (3) then.
And this are actually C-for-asm offsets (asm-offsets.h is confusing to
me).

On Mon, Feb 12, 2007 at 10:41:28PM +0100, Sam Ravnborg wrote:
[]
> > I will glad to help providing solution maybe somewhat earlier (well, i'm
> > trying to understand whole building process, if that matters).
> =

> Basically what is requested is to move the generic parts of asm-offsets
> generation from top-level Kbuild file to a generic file somewhere.
> =

> Since this is not generic Kbuild functionality but more specific to the
> kernel it should not be part of Kbuild generic files.
> include/asm-generic/asm-offsets seems to be a fair place for it.

Too much "generic" were used. Anyways, simply thing is, that there must be:

-- hardware file(s) for Arch;

-- "private" software file(s), for paravirt and such.

On Mon, Feb 12, 2007 at 06:24:13PM +0100, Andi Kleen wrote:
[]
> The problem is trying to figure out what needs to be done to get
> multiple asm-offsets.h.

Proposition will follow.

Kind regards.

P.S.
While it was fun to run kinds of offtopic operation systems in
virtual machine back in 2000-2001. Now it isn't.

Mainly due to yet another zoo. May be this is good for quick adoption,
commercial benefit, etc. Yet thankfully to Rusty, general useful
infrastructure is available now. Kudos to everyone :)
____
