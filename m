From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: share config interrupt between virtio
	devices
Date: Sun, 21 Sep 2014 11:09:14 +0300
Message-ID: <20140921080914.GA2489@redhat.com>
References: <1409550114-8186-1-git-send-email-akong@redhat.com>
	<20140901063730.GB20186@redhat.com> <11860049.kd4R4PIiz4@k>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11860049.kd4R4PIiz4@k>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Fritsch <sf@sfritsch.de>
Cc: kvm@vger.kernel.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, sasha.levin@oracle.com, penberg@iki.fi
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 18, 2014 at 09:18:37PM +0200, Stefan Fritsch wrote:
> On Monday 01 September 2014 09:37:30, Michael S. Tsirkin wrote:
> > Why do we need INT#x?
> > How about setting IRQF_SHARED for the config interrupt
> > while using MSI-X? You'd have to read ISR to check that the
> > interrupt was intended for your device.
> 
> The virtio 0.9.5 spec says that ISR is "unused" when in MSI-X mode. I 
> don't think that you can depend on the device to set the configuration 
> changed bit.
> The virtio 1.0 spec seems to have fixed that.

Yes, virtio 0.9.5 has this bug. But in practice qemu always set this
bit, so for qemu we could do that unconditionally.  Pekka's lkvm tool
doesn't unfortunately.  It's easy to fix that, but it would be nicer to
additionally probe for old versions of the tool, and disable IRQF_SHARED
in that case.

To complicate things, lkvm does not use a distinct subsystem vendor ID,
in spite of the fact the virtio spec always required this explicitly.

After poking at things, we could probably try and distinguish old lkmv
based on bar sizes. I think lkvm has:
#define IOPORT_SIZE			0x400
this is the size of the IO bar (bar0) correct?
Qemu's BAR is smaller.

So if
1. new versions of lkvm are fixed to always set ISR on config change
  even when msi is enabled
2 lkvm folks can promise not to make bar0 size smaller *before*
  fixing (1)

then we could use the heuristic:
	bar size == 0x400
to clear IRQF_SHARED.

Cc some lkvm folks for all of the above: would you guys be
happier with some other heuristic?

I'd like to note that lkvm really should get some vendor to request and
then donate a subsystem vendor id (registered with pci sig) for their
use, instead of pretending they are qemu.

AFAIK a subsystem vendor id does not cost money to register, but
only pci sig members can do this, and membership costs $3000.
Maybe we should combine all this with checking subsystem vendor id,
and only implement the optimization if it matches qemu, for now.
This needs some thought.

-- 
MST
