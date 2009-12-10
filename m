From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Qemu-devel] Re: Guest bridge setup variations
Date: Thu, 10 Dec 2009 20:20:26 +0000
Message-ID: <200912102020.26724.arnd@arndb.de>
References: <200912081707.42660.arnd@arndb.de>
	<200912101518.36128.arnd@arndb.de>
	<784CAF36-3F28-4FFD-82A2-0A4E54EDB831@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <784CAF36-3F28-4FFD-82A2-0A4E54EDB831@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: "Fischer, Anna" <anna.fischer@hp.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 10 December 2009 19:14:28 Alexander Graf wrote:
> > This is something I also have been thinking about, but it is not what
> > I was referring to above. I think it would be good to keep the three
> > cases (macvlan, VMDq, SR-IOV) as similar as possible from the user
> > perspective, so using macvlan as an infrastructure for all of them
> > sounds reasonable to me.
> 
> Oh, so you'd basically do -net vt-d,if=eth0 and the rest would
> automatically work? That's a pretty slick idea!

I was only referring to how they get set up under the covers, e.g.
creating the virtual device, configuring the MAC address etc, not
the qemu side, but that would probably make sense as well.

Or even better, qemu should probably not even know the difference
between macvlan and VT-d. In both cases, it would open a macvtap
file, but for VT-d adapters, the macvlan infrastructure can
use hardware support, much in the way that VLAN tagging gets
offloaded automatically to the hardware.

	Arnd <><
