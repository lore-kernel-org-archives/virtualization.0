From: Andi Kleen <ak@suse.de>
Subject: Re: A set of "standard" virtual devices?
Date: Mon, 2 Apr 2007 23:36:42 +0200
Message-ID: <200704022336.43136.ak@suse.de>
References: <4611652F.700@zytor.com> <200704022312.39195.ak@suse.de>
	<4611768D.1080801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4611768D.1080801@garzik.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 02 April 2007 23:33:01 Jeff Garzik wrote:
> Andi Kleen wrote:
> >> How would that work in the case where virtualized guests don't have a
> >> visible PCI bus, and the virtual environment doesn't pretend to emulate
> >> a PCI bus?
> > =

> > If they emulated one with the appropiate device =

> > then distribution driver auto probing would just work transparently for=
 them.
> =

> Yes, but, ideally with paravirtualization you should be able to avoid =

> the overhead of emulating many major classes of device (storage, =

> network, RNG, etc.) by developing a low-overhead passthrough interface =

> that does not involve PCI at all.

The implementation wouldn't need to use PCI at all. There wouldn't =

even need to be PCI like registers internally. Just a pci device
with an ID somewhere in sysfs. PCI with unique IDs
is just a convenient and well established key into the driver module
collection. Once you have the right driver it can do what it wants.

-Andi =
