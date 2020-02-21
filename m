From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Date: Fri, 21 Feb 2020 19:16:25 +0100
Message-ID: <20200221191625.1d589ea7.pasic@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221153340.4cdcde81.pasic@linux.ibm.com>
 <20200221163938.GC10054@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200221163938.GC10054@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>, Michael Mueller <mimu@linux.ibm.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 21 Feb 2020 17:39:38 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> > > Hell no.  This is a detail of the platform DMA direct implementation.
> > 
> > I beg to differ. If it was a detail of the DMA direct implementation, it
> > should have/would have been private to kernel/dma/direct.c. 
> 
> It can't given that platforms have to implement it.  It is an arch hook
> for dma-direct.
> 
> > Consider what would we have to do to make PCI devices do I/O trough
> > pages that were shared when the guest is running in a protected VM. The
> > s390_pci_dma_ops would also need to know whether to 'force dma uencrypted'
> > or not, and it's the exact same logic. I doubt simply using DMA direct
> > for zPCI would do, because we still have to do all the Z specific IOMMU
> > management.
> 
> And your IOMMU can't deal with the encryption bit?

There is no encrypt bit, and our memory is not encrypted, but protected.
Means e.g. when buggy/malicious hypervisor tries to read a protected
page it wont get ciphertext, but a slap on its finger. In order do make
memory accessible to the hypervisor (or another guest, or a real device)
the guest must make a so called utlravisor call (talk to the firmware)
and share the respective page.

We tapped into the memory encryption infrastructure, because both is
protecting the guest memory form the host (just by different means), and
because it made no sense to build up something in parallel when most of
the stuff we need was already there. But most unfortunately the names
are deceiving when it comes to s390 protected virtualization and it's
guest I/O enablement.


>  In the case we
> could think of allowing IOMMU implementation to access it.  But the
> point that it is an internal detail of the DMA implementation and by
> now means for drivers.

From the perspective, that any driver that does anything remotely DMAish,
that is, some external entity (possibly a hypervisor, possibly a channel
subsystem, possibly a DMA controller) to should the memory, should do
DMA API first, to make sure, the DMAish goes well, your argument makes
perfect sense. But form that perspective !F_ACCESS_PLATFORM is also a
DMAish. And the virtio spec mandates that !F_ACCESS_PLATFORM implies
GPA's.

For virtio-ccw I want GPA's and not IOVA's on s390, for virtio-pci,
which we also support in general but not with protected virtualization,
well, it's a different story.

With protected visualization however I must make sure all I/O goes
through shared pages. We use swiotlb for that. But then the old
infrastructure won't cut it. Jet we still need GPA's on the ring (with
the extra requirement that the page must be shared). 

DMA API is a nice fit there because we can allocate DMA coherent memory
(such that what comes back from our DMA ops is a GPA), so we have shared
memory that the hypervisor and the guest is allowed to look at
concurrently, and for the buffers that are going to be put on the vring,
we can use the streaming API, which uses bounce buffers. The returned
IOVA (in DMA API speak) is a GPA of the bounce buffer, and the guest is
not allowed to peek until it unmaps, so everything is cozy. But for that
to work, we all (AMD SEV, power, and s390) must go through the DMA API,
because the old infrastructure in virtio core simply won't cut it. And
it has nothing to do with the device. David explained it very well.

My series is about controlling virtio-core's usage of DMA API. I believe,
I did it in a way that doesn't hurt any arch at the moment.

Maybe the conflict can be resolved if the transport gets a say in
whether to use the DMA API or not. In the end the VIRTIO spec does say
that "Whether accesses are actually limited or translated is described
by platform-specific means."

Regards,
Halil
