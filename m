From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [RFC]vhost/vhost-net backend for PCI cards
Date: Wed, 27 Feb 2013 14:31:24 -0800
Message-ID: <20130227223121.GC29239@ovro.caltech.edu>
References: <1361964866.62280.69.camel@jmataraz-mobl.amr.corp.intel.com>
	<1361965854.62280.71.camel@jmataraz-mobl.amr.corp.intel.com>
	<20130227191705.GB29239@ovro.caltech.edu>
	<1361969900.62280.97.camel@jmataraz-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20130227224949.GD29239@ovro.caltech.edu>
Resent-To: virtualization@lists.linux-foundation.org
Content-Disposition: inline
In-Reply-To: <1361969900.62280.97.camel@jmataraz-mobl.amr.corp.intel.com>
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
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 27, 2013 at 04:58:20AM -0800, Nikhil Rao wrote:
> On Wed, 2013-02-27 at 11:17 -0800, Ira W. Snyder wrote:
> 
> > Hi Nikhil,
> > 
> > I don't have any code to offer, but may be able to provide some
> > suggestions. I work on a system which has a single (x86) host computer,
> > and many PowerPC data processing boards, which are connected via PCI.
> > This sounds similar to your hardware.
> > 
> > Our system was developed before vhost existed. I built a (fairly dumb)
> > network driver that just transfers packets over PCI using the PowerPC
> > DMA controller. It works, however I think a more generic virtio solution
> > will work better. A virtio solution will also allow other types of
> > devices besides a network interface.
> > 
> > I have done some studying of rproc/rpmsg/vhost/vringh, and may have some
> > suggestions about those pieces of kernel functionality.
> > 
> > A HW DMA engine is absolutely needed to get good performance over the
> > PCI bus. I don't have experience with PCIe.
> > 
> > You may want to investigate rproc/rpmsg to help do virtio device
> > discovery.
> 
> > When dealing with virtio, it may be helpful to think of your PCIe card
> > as the "host". 
> 
> We wanted to support a host-based disk, using virtio-blk on the card
> seemed to be a good way to do this, given that the card runs Linux.
> 
> also from a performance perspective, which would be better ? [virtio-net
> on the card/backend on the host cpu] v/s [virtio-net on the
> hostcpu/backend on the card] ?  given that the host cpu is more powerful
> than the card cpu.
> 

I never considered using virtio-blk, so I don't have any input about it.

I don't know much about virtio performance either. The experts on this
list will have to send their input.

> > In virtio nomenclature, the "host" is in charge of copying data. 
> > Your HW DMA engine needs to be controlled by the "host".
> 
> In our case, the host driver controls the HW DMA engine (a subset of the
> card DMA engine channels are under host control). But you may be
> referring to the case where the host doesn't have access to the card's
> DMA engine.
> 

That's right. On our PowerPC cards, the DMA hardware can be controlled
by either the PowerPC processor, or the PCI host system, but not both.
We need the DMA for various operations on the PowerPC card itself, so
the PCI host system cannot be used to control the DMA hardware.

This is also true for other vendors who contacted me privately.

Your PCIe card seems to have better features than any similar systems
I've worked with.

I skimmed the code being used with rpmsg/rproc/virtio on the ARM DSPs on
the OMAP platform. They use the DSP as the "virtio host" (it copies
memory, performing the same function as vhost) and the OMAP as the
"virtio guest" (it runs virtio-net/etc.).

Among all virtio "guest" drivers (virtio-net/virtio-console/etc.), I
think virtio-blk behaves differently from the rest. All of the others
work better with DMA hardware when the PCI card is the "virtio host."

You might want to contact Ohad Ben-Cohen for his advice. He did a lot of
work on drivers/rpmsg and drivers/remoteproc. He works with the OMAP
hardware.

Ira

> > 
> > Your main computer (the computer the PCIe card plugs into) will be a
> > virtio "guest" and will run the virtio-net/virtio-console/etc. drivers.
> > 
> > Several vendors have contacted me privately to ask for the code for my
> > (dumb) network-over-PCI driver. A generic solution to this problem will
> > definitely find a userbase.
> > 
> > I look forward to porting the code to run on my PowerPC PCI boards when
> > it becomes available. I am able to help review code as well.
> > 
> > Good luck!
> > Ira
> 
> 
