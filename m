From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile,
	and a sysfs cpu attribute
Date: Thu, 19 May 2011 17:22:17 +0200
Message-ID: <201105191722.17685.arnd__40966.9065535583$1305818598$gmane$org@arndb.de>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<201105191541.11939.arnd@arndb.de> <4DD5334D.4060800@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DD5334D.4060800@tilera.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Metcalf <cmetcalf@tilera.com>, virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

(adding virtualization mailing list)

On Thursday 19 May 2011, Chris Metcalf wrote:
> On 5/19/2011 9:41 AM, Arnd Bergmann wrote:
> >> /proc/tile/hvconfig
> >>   Detailed configuration description of the hypervisor config
> 
> I'm concerned about moving this one out of /proc, since it's just (copious)
> free text.  An "hvconfig" (hypervisor config) file describes hypervisor
> driver "dedicated tiles" that run things like network packet or PCIe
> ingress/egress processing, etc.  In addition it lists hypervisor driver
> options, boot flags for the kernel, etc, all kinds of things -- and you
> can't really guarantee that it will fit on a 4KB page, though in practice
> it usually does.  The hypervisor reads this file from the boot stream when
> it boots, and then makes it available to Linux not for Linux's use, or even
> for programmatic userspace use, but just for end users to be able to review
> and verify that the configuration they think they booted is really what
> they got, for customer remote debugging, etc.  The "remote debugging"
> aspect makes truncation to page size a particularly worrisome idea.

Since it's not the kernel that is imposing the format here, you could
make it a binary sysfs attribute, which works in the same way as
a proc file and does not have the size limitations.

> >> /proc/tile/board
> >>   Information on part numbers, serial numbers, etc., of the
> >>   hardware that the kernel is executing on
> >>
> >> /proc/tile/switch
> >>   The type of control path for the onboard network switch, if any.
> 
> These two report information about the hardware, not the hypervisor.  For
> example:
> 
> # cat /proc/tile/board
> board_part: 402-00002-05
> board_serial: NBS-5002-00012
> chip_serial: P62338.01.110
> chip_revision: A0
> board_revision: 2.2
> board_description: Tilera TILExpressPro-64, TILEPro64 processor (866 MHz-capable), 1 10GbE, 6 1GbE
> # cat /proc/tile/switch
> control: mdio gbe/0

I think it's ok to have it below /sys/hypervisor, because the information
is provided through a hypervisor ABI, even though it describes something
else. This is more like /sys/firmware, but the boundaries between that
and /sys/hypervisor are not clearly defined when running virtualized anyway.

> The chip_serial and chip_revision can certainly hang off
> /sys/devices/system/cpu along with chip_height and chip_width (I've made
> this change now) but I don't know where the remaining "board" level
> description could go.  Note that (as you can see in the source) certain
> boards will also include four lines of output with the "mezzanine board"
> part number, serial number, revision, and description; this particular
> example doesn't have a mezzanine board.  The "switch" info is broken out
> into a separate file just to make it easier to script some /etc/rc code
> that launches a configurator for the Marvell switch on some of our boards,
> but is conceptually part of the board info.
> 
> >> /proc/tile/hardwall
> >>   Information on the set of currently active hardwalls (note that
> >>   the implementation is already present in arch/tile/kernel/hardwall.c;
> >>   this change just enables it)
> 
> This one is not a hypervisor-related file.  It just lists information about
> the set of Linux hardwalls currently active.  Again, it's not primarily
> intended for programmatic use, but as a diagnostic tool.

same here, I'd still put it into the hypervisor structure.

	Arnd
