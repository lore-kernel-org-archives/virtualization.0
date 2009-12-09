From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Guest bridge setup variations
Date: Wed, 09 Dec 2009 13:36:16 -0600
Message-ID: <4B1FFC30.40904@codemonkey.ws>
References: <200912081707.42660.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200912081707.42660.arnd@arndb.de>
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
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> As promised, here is my small writeup on which setups I feel
> are important in the long run for server-type guests. This
> does not cover -net user, which is really for desktop kinds
> of applications where you do not want to connect into the
> guest from another IP address.
>
> I can see four separate setups that we may or may not want to
> support, the main difference being how the forwarding between
> guests happens:
>
> 1. The current setup, with a bridge and tun/tap devices on ports
> of the bridge. This is what Gerhard's work on access controls is
> focused on and the only option where the hypervisor actually
> is in full control of the traffic between guests. CPU utilization should
> be highest this way, and network management can be a burden,
> because the controls are done through a Linux, libvirt and/or Director
> specific interface.
>   

Typical bridging.

> 2. Using macvlan as a bridging mechanism, replacing the bridge
> and tun/tap entirely. This should offer the best performance on
> inter-guest communication, both in terms of throughput and
> CPU utilization, but offer no access control for this traffic at all.
> Performance of guest-external traffic should be slightly better
> than bridge/tap.
>   

Optimization to typical bridge (no traffic control).

> 3. Doing the bridging in the NIC using macvlan in passthrough
> mode. This lowers the CPU utilization further compared to 2,
> at the expense of limiting throughput by the performance of
> the PCIe interconnect to the adapter. Whether or not this
> is a win is workload dependent. Access controls now happen
> in the NIC. Currently, this is not supported yet, due to lack of
> device drivers, but it will be an important scenario in the future
> according to some people.
>   

Optimization to typical bridge (hardware accelerated).

> 4. Using macvlan for actual VEPA on the outbound interface.
> This is mostly interesting because it makes the network access
> controls visible in an external switch that is already managed.
> CPU utilization and guest-external throughput should be
> identical to 3, but inter-guest latency can only be worse because
> all frames go through the external switch.
>   

VEPA.

While we go over all of these things one thing is becoming clear to me.  
We need to get qemu out of the network configuration business.  There's 
too much going on here.

What I'd like to see is the following interfaces supported:

1) given an fd, make socket calls to send packets.  Could be used with a 
raw socket, a multicast or tcp socket.
2) given an fd, use tap-style read/write calls to send packets*
3) given an fd, treat a vhost-style interface

* need to make all tun ioctls optional based on passed in flags

Every backend we have today could be implemented in terms of one of the 
above three.  They really come down to how the fd is created and setup.

I believe we should continue supporting the mechanisms we support 
today.  However, for people that invoke qemu directly from the command 
line, I believe we should provide a mechanism like the tap helper that 
can be used to call out to a separate program to create these initial 
file descriptors.  We'll have to think about how we can make this 
integrate well so that the syntax isn't clumsy.

Regards,

Anthony Liguori
