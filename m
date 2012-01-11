From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 07:56:41 +1100
Message-ID: <1326315401.23910.138.camel@pasglop>
References: <87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com> <871us0om2t.fsf@rustcorp.com.au>
	<20111220113718.GF3913@redhat.com> <878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com> <8762gj6q5r.fsf@rustcorp.com.au>
	<CAJSP0QU_viNks2jv003c8+gYWFkyW=FvZpU5w6wyroeEyFkXsA@mail.gmail.com>
	<1326273019.23910.118.camel@pasglop>
	<CAJSP0QWMBhsg9ExmTsDG7d32p=7tokCPpm5Z0DMAm2_ADvvb+g@mail.gmail.com>
	<20120111153954.GC20570@redhat.com>
	<CAJSP0QVm2f+A8hFa+tx3LRcXa_oe8mn4=DhrGMnozVB8_K4OxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QVm2f+A8hFa+tx3LRcXa_oe8mn4=DhrGMnozVB8_K4OxQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-01-11 at 17:21 +0000, Stefan Hajnoczi wrote:
> > It won't be hard to show siginificant performance regression if
> > we do this. Hard to justify for something as niche as nested virt.
> 
> For x86 this should be mostly a nop.

No it won't be. Or rather, it will be as long as you map your entire
guests in the iommu, which means your entire guest will have to be
pinned and you lost swap, ksm, yadadada... 

Since the only way to have non-pinned guests today on x86 is to use
virtio, you just shot yourself in the foot.

Eventually x86 will have to grow some kind of virtualized iommu or
paravir iommu to overcome that at which point you will pay that price.

>   For ppc and SPARC architectures
> maybe you're right.  I still think it's a design flaw because if
> virtio v2 doesn't use bus addresses then it will simply not be
> possible to do passthrough for nested virt and other cases we haven't
> hit yet.

Then don't use virtio in those cases, use real emulated HW. Seriously,
is nested virt that interesting ? 

At the very least, make that use of iommu a feature or something like
that so it can be negociated down when not doing nesting which is going
to be 99% of your use cases.

Cheers,
Ben.
