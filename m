From: Arnd Bergmann <arnd@arndb.de>
Subject: Guest bridge setup variations
Date: Tue, 8 Dec 2009 17:07:41 +0100
Message-ID: <200912081707.42660.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

As promised, here is my small writeup on which setups I feel
are important in the long run for server-type guests. This
does not cover -net user, which is really for desktop kinds
of applications where you do not want to connect into the
guest from another IP address.

I can see four separate setups that we may or may not want to
support, the main difference being how the forwarding between
guests happens:

1. The current setup, with a bridge and tun/tap devices on ports
of the bridge. This is what Gerhard's work on access controls is
focused on and the only option where the hypervisor actually
is in full control of the traffic between guests. CPU utilization should
be highest this way, and network management can be a burden,
because the controls are done through a Linux, libvirt and/or Director
specific interface.

2. Using macvlan as a bridging mechanism, replacing the bridge
and tun/tap entirely. This should offer the best performance on
inter-guest communication, both in terms of throughput and
CPU utilization, but offer no access control for this traffic at all.
Performance of guest-external traffic should be slightly better
than bridge/tap.

3. Doing the bridging in the NIC using macvlan in passthrough
mode. This lowers the CPU utilization further compared to 2,
at the expense of limiting throughput by the performance of
the PCIe interconnect to the adapter. Whether or not this
is a win is workload dependent. Access controls now happen
in the NIC. Currently, this is not supported yet, due to lack of
device drivers, but it will be an important scenario in the future
according to some people.

4. Using macvlan for actual VEPA on the outbound interface.
This is mostly interesting because it makes the network access
controls visible in an external switch that is already managed.
CPU utilization and guest-external throughput should be
identical to 3, but inter-guest latency can only be worse because
all frames go through the external switch.

In case 2 through 4, we have the choice between macvtap and
the raw packet interface for connecting macvlan to qemu.
Raw sockets are better tested right now, while macvtap has
better permission management (i.e. it does not require
CAP_NET_ADMIN). Neither one is upstream though at the
moment. The raw driver only requires qemu patches, while
macvtap requires both a new kernel driver and a trivial change
in qemu.

In all four cases, vhost-net could be used to move the workload
from user space into the kernel, which may be an advantage.
The decision for or against vhost-net is entirely independent of
the other decisions.

	Arnd
