From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] paravirt.h
Date: 10 Aug 2006 12:30:12 +0200
Message-ID: <20060810103012.GA2356@muc.de>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<1155204603.18420.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Thu, 10 Aug 2006 12:30:12 +0200
Content-Disposition: inline
In-Reply-To: <1155204603.18420.9.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 10, 2006 at 08:10:03PM +1000, Rusty Russell wrote:
> On Thu, 2006-08-10 at 19:35 +1000, Rusty Russell wrote:
> > This version over last version:
> > (1) Gets rid of the no_paravirt.h header and leaves native ops in place
> > (with some reshuffling to keep then under one #ifdef).
> > (2) Fixes the "X crashes with CONFIG_PARAVIRT=3Dy" bug.
> > (3) Puts __ex_table entry in paravirt iret.
> =

> Gurp... that was old version.  This version removes the explicit "save
> flags and disable irqs" op (the binary patching patches it as one, but
> there's little point having a short-cut through the slow path).

Can you please do at least a s/__asm__/asm/g s/__volatile__/volatile/g ?

And you seem to have added some __volatiles too, that should be also =

volatile.

I would still prefer a better name that "nopara"

Some of the other cleanups are missing too, but I guess that could
be fixed later.

-Andi
