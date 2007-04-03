From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 03 Apr 2007 15:10:18 -0700
Message-ID: <4612D0CA.3070209@zytor.com>
References: <4611652F.700@zytor.com> <4612B303.5000109@zytor.com>
	<4612C077.60502@goop.org> <200704032351.17823.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704032351.17823.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> =

> One interesting aspect of the PS3 hypervisor is that some of the
> low-speed interfaces are implemented as a virtual UART, meaning
> something that only has read and write operations and uses an
> interrupt for flow control. The implementation in =

> drivers/ps3/vuart.c is probably more complex than what we want
> as a generic transport mechanism, but simply having a bidirectional
> data stream sounds like an ideal abstraction for the "simple"
> case. Some more or less obvious users of this include:
> =

> - console
> - additional tty
> - random
> - slow network (using ppp)
> - printer
> - watchdog
> - hid (e.g. mouse)
> - system management (like ps3)
> - fast network (in combination with
>   shared memory segment)
> =

> The transport can be hypervisor specific, e.g. there could be
> a virtual PCI serial port on kvm, an hcall interface on the ps3
> and a virtual CTC on s390 (kidding), while all of them can have
> the same kind of hardware _behind_ the serial connection.
> =


Note that at least for PIO-based devices, there is nothing that says you =

can't implement PCI over another transport, if you wish.  It's really =

just a very simple RPC protocol.

DMA is trickier, as it makes the data appear into the address space of =

the guest in a way that is both device- and host-dependent (in the =

presence of PCI domains, IOMMU etc.)  There may be reason to avoid DMA =

for that reason.

	-hpa
