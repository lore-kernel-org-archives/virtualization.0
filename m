From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] paravirt.h
Date: Thu, 10 Aug 2006 13:31:19 +0200
Message-ID: <200608101331.19954.ak@muc.de>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<20060810103012.GA2356@muc.de>
	<1155207946.18420.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1155207946.18420.18.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 10 August 2006 13:05, Rusty Russell wrote:
> On Thu, 2006-08-10 at 12:30 +0200, Andi Kleen wrote:
> > On Thu, Aug 10, 2006 at 08:10:03PM +1000, Rusty Russell wrote:
> > > On Thu, 2006-08-10 at 19:35 +1000, Rusty Russell wrote:
> > > > This version over last version:
> > > > (1) Gets rid of the no_paravirt.h header and leaves native ops in p=
lace
> > > > (with some reshuffling to keep then under one #ifdef).
> > > > (2) Fixes the "X crashes with CONFIG_PARAVIRT=3Dy" bug.
> > > > (3) Puts __ex_table entry in paravirt iret.
> > > =

> > > Gurp... that was old version.  This version removes the explicit "save
> > > flags and disable irqs" op (the binary patching patches it as one, but
> > > there's little point having a short-cut through the slow path).
> > =

> > Can you please do at least a s/__asm__/asm/g s/__volatile__/volatile/g ?
> > =

> > And you seem to have added some __volatiles too, that should be also =

> > volatile.
> =

> OK, here's with the __removal__

Hmm, i still see a lot of them (and __volatile too) =


Also maybe it's my mail client, but the resulting patch seems to be also fu=
ll of
MIME damage:

 EXTRA_AFLAGS   :=3D3D -traditional

Can you send it at least without that please? The __s I can fix
up myself in the worst case if you don't want to.

-Andi
