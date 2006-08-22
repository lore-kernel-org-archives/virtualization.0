From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 17:12:10 +0200
Message-ID: <1156259530.2976.86.camel@laptopd505.fenrus.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<44DB7596.6010503@goop.org>
	<1156254965.27114.17.camel@localhost.localdomain>
	<44EB1BEB.60202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44EB1BEB.60202@goop.org>
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
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-08-22 at 07:59 -0700, Jeremy Fitzhardinge wrote:
> Alan Cox wrote:
> > It would be nice not to export it at all or to protect it, paravirt_ops
> > is a rootkit authors dream ticket. I'm opposed to paravirt_ops until it
> > is properly protected, its an unpleasantly large security target if not.
> >   =

> =

> Do you have an example of an attack which would become significantly =

> easier with pv_ops in use?  I agree it might make a juicy target, but =

> surely it is just a matter of degree given that any attacker who can get =

> to pv_ops can do pretty much anything else.

it makes for a "clean" and robust rootkit rather than a fragile one

> =

> > It would be a lot safer if we could have the struct paravirt_ops in
> > protected read-only const memory space, set it up in the core kernel
> > early on in boot when we play "guess todays hypervisor" and then make
> > sure it stays in read only (even to kernel) space.
> >   =

> =

> Yes, I'd thought about doing something like that, but as Arjan pointed =

> out, nothing is actually read-only in the kernel when using a 2M =


that's why there is a config option :) THe 2Mb advantage is a bit
overrated btw; there are very few such tlbs in current processors so the
kernel gets tlb misses anyway. And since most of the code is in the
first 2Mb (which isn't broken up) of the kernel text it's not that bad
tlb wise either

(and it was Andi that pointed that out, not me)
