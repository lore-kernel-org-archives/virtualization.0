From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 19:53:55 +0100
Message-ID: <1173293636.24738.670.camel@localhost.localdomain>
References: <45EDD82F.90204@vmware.com>
	<1173225182.24738.507.camel@localhost.localdomain>
	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>
	<1173228544.24738.514.camel@localhost.localdomain>
	<45EE0D10.7070807@vmware.com>
	<1173230305.24738.529.camel@localhost.localdomain>
	<45EE1EA3.90803@vmware.com>
	<1173256666.24738.576.camel@localhost.localdomain>
	<45EEF966.6060902@goop.org> <20070307175232.GB31371@elte.hu>
	<45EF044C.2080307@goop.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45EF044C.2080307@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-03-07 at 10:28 -0800, Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
> > /For you/ it's certainly no big deal, you dont have to fix it up and yo=
u =

> > dont have to keep it flexible ;)
> >   =

> =

> How flexible does it need to be?  Its a simple time source and event
> driver.  How flexible does the pit driver need to be?  It's just a small
> leaf node hanging off a large existing piece of kernel infrastructure.
> =

> > and really, i'm not expecting miracles, i've never seen any hardware =

> > vendor argue /against/ support for their own hardware =3DB-)
> >   =

> =

> And since when has it been kernel policy to argue against including a
> well written, self-contained, vendor-provided driver for a piece of
> hardware?

The difference is that we have not much influence on the design
decisions of silicon vendors. We usually see them when the shit already
has been morphed into solid silicon.

Software emulated silicon _IS_ actually under our control. And we want
to have it as sane as possible.

	tglx
