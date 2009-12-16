From: "Leonid Grossman" <Leonid.Grossman@neterion.com>
Subject: RE: Guest bridge setup variations
Date: Tue, 15 Dec 2009 19:55:22 -0500
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD7705FDEEDA@nekter>
References: <78C9135A3D2ECE4B8162EBDCE82CAD7705FDEDCF@nekter>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <78C9135A3D2ECE4B8162EBDCE82CAD7705FDEDCF@nekter>
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

> > -----Original Message-----
> > From: virtualization-bounces@lists.linux-foundation.org
> > [mailto:virtualization-bounces@lists.linux-foundation.org] On Behalf
> Of
> > Arnd Bergmann
> > Sent: Tuesday, December 08, 2009 8:08 AM
> > To: virtualization@lists.linux-foundation.org
> > Cc: qemu-devel@nongnu.org
> > Subject: Guest bridge setup variations
> >
> > As promised, here is my small writeup on which setups I feel
> > are important in the long run for server-type guests. This
> > does not cover -net user, which is really for desktop kinds
> > of applications where you do not want to connect into the
> > guest from another IP address.
> >
> > I can see four separate setups that we may or may not want to
> > support, the main difference being how the forwarding between
> > guests happens:
> >
> > 1. The current setup, with a bridge and tun/tap devices on ports
> > of the bridge. This is what Gerhard's work on access controls is
> > focused on and the only option where the hypervisor actually
> > is in full control of the traffic between guests. CPU utilization
> should
> > be highest this way, and network management can be a burden,
> > because the controls are done through a Linux, libvirt and/or
> Director
> > specific interface.
> >
> > 2. Using macvlan as a bridging mechanism, replacing the bridge
> > and tun/tap entirely. This should offer the best performance on
> > inter-guest communication, both in terms of throughput and
> > CPU utilization, but offer no access control for this traffic at
all.
> > Performance of guest-external traffic should be slightly better
> > than bridge/tap.
> >
> > 3. Doing the bridging in the NIC using macvlan in passthrough
> > mode. This lowers the CPU utilization further compared to 2,
> > at the expense of limiting throughput by the performance of
> > the PCIe interconnect to the adapter. Whether or not this
> > is a win is workload dependent. 

This is certainly true today for pci-e 1.1 and 2.0 devices, but 
as NICs move to pci-e 3.0 (while remaining almost exclusively dual port
10GbE for a long while), 
EVB internal bandwidth will significantly exceed external bandwidth.
So, #3 can become a win for most inter-guest workloads.

> > Access controls now happen
> > in the NIC. Currently, this is not supported yet, due to lack of
> > device drivers, but it will be an important scenario in the future
> > according to some people.

Actually, x3100 10GbE drivers support this today via sysfs interface to
the host driver 
that can choose to control VEB tables (and therefore MAC addresses, vlan
memberships, etc. for all passthru interfaces behind the VEB).
OF course a more generic vendor-independent interface will be important
in the future.

> >
> > 4. Using macvlan for actual VEPA on the outbound interface.
> > This is mostly interesting because it makes the network access
> > controls visible in an external switch that is already managed.
> > CPU utilization and guest-external throughput should be
> > identical to 3, but inter-guest latency can only be worse because
> > all frames go through the external switch.
> >
> > In case 2 through 4, we have the choice between macvtap and
> > the raw packet interface for connecting macvlan to qemu.
> > Raw sockets are better tested right now, while macvtap has
> > better permission management (i.e. it does not require
> > CAP_NET_ADMIN). Neither one is upstream though at the
> > moment. The raw driver only requires qemu patches, while
> > macvtap requires both a new kernel driver and a trivial change
> > in qemu.
> >
> > In all four cases, vhost-net could be used to move the workload
> > from user space into the kernel, which may be an advantage.
> > The decision for or against vhost-net is entirely independent of
> > the other decisions.
> >
> > 	Arnd
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/virtualization
