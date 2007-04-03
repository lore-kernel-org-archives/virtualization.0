From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 12:41:08 +0200
Message-ID: <20070403124108.06108665@gondolin.boeblingen.de.ibm.com>
References: <4611652F.700@zytor.com>
	<461178D9.402@goop.org>
	<46117F72.6020506@zytor.com>
	<200704031141.50045.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965620AbXDCKjE@vger.kernel.org>
In-Reply-To: <200704031141.50045.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 3 Apr 2007 11:41:49 +0200,
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 03 April 2007, H. Peter Anvin wrote:
> > However, one probably wants to think about what the heck one actual=
ly=20
> > means with "virtualization" in the absence of a lot of this stuff. =
=A0PCI=20
> > is probably the closest thing we have to a lowest common denominato=
r for=20
> > device detection.
>=20
> I think that's true outside of s390, but a standardized virtual devic=
e
> interface should be able to work there as well. Interestingly, the
> s390 channel I/O also uses two 16 bit numbers to identify a device
> (type and model), just like PCI or USB, so in that light, we might
> be able to use the same number space for something entirely different
> depending on the virtual bus.

Even if we used those ids for cu_type and dev_type, it would still be
ugly IMO. It would be much cleaner to just define a very simple, easy
to implement virtual bus without dragging implementation details for
other types of devices around.
