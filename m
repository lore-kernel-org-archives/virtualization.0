From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 27 Apr 2009 17:37:25 +0200
Message-ID: <200904271737.25546.borntraeger__38466.2800388925$1240846802$gmane$org@de.ibm.com>
References: <20090427123136.GA1152@redhat.com>
	<200904271600.30599.borntraeger@de.ibm.com>
	<20090427143256.GD2504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090427143256.GD2504@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Monday 27 April 2009 16:32:56 schrieb Michael S. Tsirkin:

> > I dont know, if that is feasible for MSI, but the transport(virtio_pci) should
> > already know the number of virtqueues, which should match the number of
> > vectors, no?
> 
> I think no, the transport can find out the max number of vectors the
> device supports (pci_msix_table_size), but not how many virtqueues are
> needed by the driver.

I was not talking about the number of vectors, but the number of real exisiting virtqueues.
I just read virtio_pci again and yes,it would be a bit hard to get the number
of available virtqueues, because we need to loop over all possible vqs:
(something like)

for (i=0; i < SOMEMAX; i++) {
        iowrite16(i, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
        if (!ioread16(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NUM))
		break;
}
return i;

which is obviously not very nice.
On the other hand, at the moment we have up to 3 virtqueues per device (network), and we have a current maximum of 16 virtqeues in qemu (VIRTIO_PCI_QUEUE_MAX in virtio.c), which would reduce the number.

> As  number of virtqueues <= number of vectors,
> we could pre-allocate all vectors that host supports, but this seems
> a bit drastic as an MSI-X device could support up to 2K vectors.
> 
> > In fact, the transport has to have a way of getting the number of virtqeues
> > because find_vq returns ENOENT on invalid index numbers.
> > 
> > Christian
> 
> So again, I think this is an upper bound supported by host. Right?

Not the upper bound, but the real available virtqueues. (With current qemu
3 for virtio-net, 2 for virtio-console etc.)

Since I use a different transport (drivers/s390/kvm/kvm_virtio.c), my motiviation is to keep the virtio interface as generic as possible. I dont really like the new interface, but I cannot give you silver bullet technical reasons - its more a gut feeling. The interface would work with lguest and s390.

Anyway. Avis suggestion to decouple MSI count and virtqueue count looks
like a promising approach. 

Christian
