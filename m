From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [RFC]vhost/vhost-net backend for PCI cards
Date: Wed, 27 Feb 2013 11:17:05 -0800
Message-ID: <20130227191705.GB29239@ovro.caltech.edu>
References: <1361964866.62280.69.camel@jmataraz-mobl.amr.corp.intel.com>
	<1361965854.62280.71.camel@jmataraz-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1361965854.62280.71.camel@jmataraz-mobl.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nikhil Rao <nikhil.rao@intel.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 27, 2013 at 03:50:54AM -0800, Nikhil Rao wrote:
> 
> We are implementing a driver for a PCIe card that runs Linux. This card
> needs "virtual" network/disk/console devices, so we have reused the
> virtio devices on on the card and provided a host backend that interacts
> with the virtio devices through the card's driver. 
> 
> this approach is very much like what was proposed on this thread
> http://permalink.gmane.org/gmane.linux.ports.sh.devel/10379
> 
> We will posting the driver soon, so perhaps I am jumping the gun with my
> question below about replacing our backend with vhost.
> 
> It is possible for vhost (along with vhost-net in the case of
> virtio-net) to serve as the backend. The copy between virtio buffers and
> skbs happens in the tun/tap driver which means tun/tap may need to use a
> HW DMA engine (the card has one) for copy across the bus to get close to
> the full PCIe bandwidth.
> 
> tun/tap was probably never designed for this use case, but reusing vhost
> does simplify our backend since it is now only involved in setup and
> potentially has a performance/memory footprint advantage due to avoiding
> context switches/intermediate buffer copy and this idea can be
> generalized to other cards as well.
> 
> Comments/suggestions ?
> 
> Thanks,
> Nikhil
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Hi Nikhil,

I don't have any code to offer, but may be able to provide some
suggestions. I work on a system which has a single (x86) host computer,
and many PowerPC data processing boards, which are connected via PCI.
This sounds similar to your hardware.

Our system was developed before vhost existed. I built a (fairly dumb)
network driver that just transfers packets over PCI using the PowerPC
DMA controller. It works, however I think a more generic virtio solution
will work better. A virtio solution will also allow other types of
devices besides a network interface.

I have done some studying of rproc/rpmsg/vhost/vringh, and may have some
suggestions about those pieces of kernel functionality.

A HW DMA engine is absolutely needed to get good performance over the
PCI bus. I don't have experience with PCIe.

You may want to investigate rproc/rpmsg to help do virtio device
discovery.

When dealing with virtio, it may be helpful to think of your PCIe card
as the "host". In virtio nomenclature, the "host" is in charge of
copying data. Your HW DMA engine needs to be controlled by the "host".

Your main computer (the computer the PCIe card plugs into) will be a
virtio "guest" and will run the virtio-net/virtio-console/etc. drivers.

Several vendors have contacted me privately to ask for the code for my
(dumb) network-over-PCI driver. A generic solution to this problem will
definitely find a userbase.

I look forward to porting the code to run on my PowerPC PCI boards when
it becomes available. I am able to help review code as well.

Good luck!
Ira
