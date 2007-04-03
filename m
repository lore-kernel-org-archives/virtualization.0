From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 23:51:16 +0200
Message-ID: <200704032351.17823.arnd@arndb.de>
References: <4611652F.700@zytor.com> <4612B303.5000109@zytor.com> <4612C077.60502@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1945964AbXDCVw4@vger.kernel.org>
In-Reply-To: <4612C077.60502@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Andi Kleen <ak@suse.de>, Christian Borntraeger <borntrae@de.ibm.com>, virtualization@lists.linux-foundation.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 April 2007, Jeremy Fitzhardinge wrote:
> That said, something like USB is probably the best bet for this kind =
of
> low-performance device. =A0I think. =A0Not that I really know anythin=
g about
> USB.

USB has the disadvantage that it is more complex than PCI and requires
significantly more code to simulate on the host side.

On the plus side, I think it should be possible to implement a virtual
USB host on s390, which is not possible with PCI, but that again takes
a lot of work to implement.

One interesting aspect of the PS3 hypervisor is that some of the
low-speed interfaces are implemented as a virtual UART, meaning
something that only has read and write operations and uses an
interrupt for flow control. The implementation in=20
drivers/ps3/vuart.c is probably more complex than what we want
as a generic transport mechanism, but simply having a bidirectional
data stream sounds like an ideal abstraction for the "simple"
case. Some more or less obvious users of this include:

- console
- additional tty
- random
- slow network (using ppp)
- printer
- watchdog
- hid (e.g. mouse)
- system management (like ps3)
- fast network (in combination with
  shared memory segment)

The transport can be hypervisor specific, e.g. there could be
a virtual PCI serial port on kvm, an hcall interface on the ps3
and a virtual CTC on s390 (kidding), while all of them can have
the same kind of hardware _behind_ the serial connection.

	Arnd <><
