From: "Fischer, Anna" <anna.fischer@hp.com>
Subject: RE: Guest bridge setup variations
Date: Thu, 10 Dec 2009 12:26:00 +0000
Message-ID: <0199E0D51A61344794750DC57738F58E6D7083F314@GVW1118EXC.americas.hpqcorp.net>
References: <200912081707.42660.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200912081707.42660.arnd@arndb.de>
Content-Language: en-US
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Guest bridge setup variations
> 
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
> 2. Using macvlan as a bridging mechanism, replacing the bridge
> and tun/tap entirely. This should offer the best performance on
> inter-guest communication, both in terms of throughput and
> CPU utilization, but offer no access control for this traffic at all.
> Performance of guest-external traffic should be slightly better
> than bridge/tap.
> 
> 3. Doing the bridging in the NIC using macvlan in passthrough
> mode. This lowers the CPU utilization further compared to 2,
> at the expense of limiting throughput by the performance of
> the PCIe interconnect to the adapter. Whether or not this
> is a win is workload dependent. Access controls now happen
> in the NIC. Currently, this is not supported yet, due to lack of
> device drivers, but it will be an important scenario in the future
> according to some people.

Can you differentiate this option from typical PCI pass-through mode? It is not clear to me where macvlan sits in a setup where the NIC does bridging.

Typically, in a PCI pass-through configuration, all configuration goes through the physical function device driver (and all data goes directly to the NIC). Are you suggesting to use macvlan as a common configuration layer that then configures the underlying NIC? I could see some benefit in such a model, though I am not certain I understand you correctly.

Thanks,
Anna
