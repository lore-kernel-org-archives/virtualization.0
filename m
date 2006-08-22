From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 14:56:03 +0100
Message-ID: <1156254965.27114.17.camel@localhost.localdomain>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<44DB7596.6010503@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44DB7596.6010503@goop.org>
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
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Ar Iau, 2006-08-10 am 11:06 -0700, ysgrifennodd Jeremy Fitzhardinge:
> Rusty Russell wrote:
> > +EXPORT_SYMBOL_GPL(paravirt_ops);
> >   =

> This should probably be EXPORT_SYMBOL(), otherwise pretty much every =

> driver module will need to be GPL...

It would be nice not to export it at all or to protect it, paravirt_ops
is a rootkit authors dream ticket. I'm opposed to paravirt_ops until it
is properly protected, its an unpleasantly large security target if not.

It would be a lot safer if we could have the struct paravirt_ops in
protected read-only const memory space, set it up in the core kernel
early on in boot when we play "guess todays hypervisor" and then make
sure it stays in read only (even to kernel) space.

Once you can't patch it then the worries about rootkits and patching it
that might make people want it particularly to be _GPL should mostly go
away too.

Alan
