From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 11:41:49 +0200
Message-ID: <200704031141.50045.arnd@arndb.de>
References: <4611652F.700@zytor.com> <461178D9.402@goop.org> <46117F72.6020506@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965528AbXDCJmb@vger.kernel.org>
In-Reply-To: <46117F72.6020506@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 April 2007, H. Peter Anvin wrote:
> However, one probably wants to think about what the heck one actually=
=20
> means with "virtualization" in the absence of a lot of this stuff. =A0=
PCI=20
> is probably the closest thing we have to a lowest common denominator =
for=20
> device detection.

I think that's true outside of s390, but a standardized virtual device
interface should be able to work there as well. Interestingly, the
s390 channel I/O also uses two 16 bit numbers to identify a device
(type and model), just like PCI or USB, so in that light, we might
be able to use the same number space for something entirely different
depending on the virtual bus.

	Arnd <><
