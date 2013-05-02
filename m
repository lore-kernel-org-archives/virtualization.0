From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: BUG: virtio_mmio multi-queue competely  broken -- virtio
	*registers* considered harmful
Date: Thu, 2 May 2013 08:25:38 +0300
Message-ID: <20130502052538.GA27500@redhat.com>
References: <5181E046.7000309@lyon-about.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5181E046.7000309@lyon-about.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tom Lyon <pugs@lyon-about.com>
Cc: kvm@vger.kernel.org, pawel.moll@arm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 01, 2013 at 08:40:54PM -0700, Tom Lyon wrote:
> Virtiio_mmio attempts to mimic the layout of some control registers
> from virtio_pci.  These registers, in particular
> VIRTIO_MMIO_QUEUE_SEL and VIRTIO_PCI_QUEUE_SEL,
> are active in nature, and not just passive like a normal memory
> location.  Thus, the host side must react immediately upon write of
> these registers to map some other registers (queue address, size,
> etc) to queue-specific locations.  This is just not possible for
> mmio, and, I would argue, not desirable for PCI either.
> 
> Because the queue selector register doesn't work in mmio, it is
> clear that only single queue virtio devices can work.  This means no
> virtio_net - I've seen a few messages
> complaining that it doesn't work but nothing so far on why.
> 
> It seems from some messages back in March that there is a register
> re-layout in the works for virtio_pci.  I think that virtio_pci
> could become just one of the
> various ways to configure a virtio_mmio device and there would no
> need for any "registers", just memory locations acting like memory.
> The one gotcha is in
> figuring out the kick/notify mechanism for the guest to notify the
> host when there is work on a queue.  For notify, using a hypervisor
> call could unify the pci and mmio
> cases, but comes with the cost of leaving the pure pci domain.
> 
> I got into this code because I am looking at the possibility of
> using an off the shelf embedded processor sitting on a PCIe port to
> emulate the virtio pci interface.  The
> notion of active registers makes this a non-starter, whereas if
> there was a purely memory based system like mmio (with mq fixes), a
> real PCI device could easily emulate it.
> Excepting, of course, whatever the notify mechanism is.  If it were
> hypercall based, then the hypervisor could call a transport or
> device specific way of notifying and a small
> notify driver could poke the PCI device is some way.


This was discussed on this thread:
	'[PATCH 16/22] virtio_pci: use separate notification offsets for each vq'
Please take a look there and confirm that this addresses your concern.
I'm working on making memory io as fast as pio on x86,
implemented on intel, once I do it on AMD too and assuming it's
as fast as PIO, we'll do mmio everywhere.
Then with a PCI card, you won't have exits for notification just normal
passthrough.


-- 
MST
