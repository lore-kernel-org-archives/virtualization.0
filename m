From: Nikhil Rao <nikhil.rao@intel.com>
Subject: [RFC]vhost/vhost-net backend for PCI cards
Date: Wed, 27 Feb 2013 03:50:54 -0800
Message-ID: <1361965854.62280.71.camel@jmataraz-mobl.amr.corp.intel.com>
References: <1361964866.62280.69.camel@jmataraz-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361964866.62280.69.camel@jmataraz-mobl.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


We are implementing a driver for a PCIe card that runs Linux. This card
needs "virtual" network/disk/console devices, so we have reused the
virtio devices on on the card and provided a host backend that interacts
with the virtio devices through the card's driver. 

this approach is very much like what was proposed on this thread
http://permalink.gmane.org/gmane.linux.ports.sh.devel/10379

We will posting the driver soon, so perhaps I am jumping the gun with my
question below about replacing our backend with vhost.

It is possible for vhost (along with vhost-net in the case of
virtio-net) to serve as the backend. The copy between virtio buffers and
skbs happens in the tun/tap driver which means tun/tap may need to use a
HW DMA engine (the card has one) for copy across the bus to get close to
the full PCIe bandwidth.

tun/tap was probably never designed for this use case, but reusing vhost
does simplify our backend since it is now only involved in setup and
potentially has a performance/memory footprint advantage due to avoiding
context switches/intermediate buffer copy and this idea can be
generalized to other cards as well.

Comments/suggestions ?

Thanks,
Nikhil
