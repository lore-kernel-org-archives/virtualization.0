From: Jeff Garzik <jeff@garzik.org>
Subject: Re: A set of "standard" virtual devices?
Date: Mon, 02 Apr 2007 17:33:01 -0400
Message-ID: <4611768D.1080801@garzik.org>
References: <4611652F.700@zytor.com> <46116E12.5070206@goop.org>
	<200704022312.39195.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704022312.39195.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> How would that work in the case where virtualized guests don't have a
>> visible PCI bus, and the virtual environment doesn't pretend to emulate
>> a PCI bus?
> =

> If they emulated one with the appropiate device =

> then distribution driver auto probing would just work transparently for t=
hem.

Yes, but, ideally with paravirtualization you should be able to avoid =

the overhead of emulating many major classes of device (storage, =

network, RNG, etc.) by developing a low-overhead passthrough interface =

that does not involve PCI at all.

	Jeff
