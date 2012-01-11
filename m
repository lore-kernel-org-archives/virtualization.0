From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 11 Jan 2012 20:10:19 +1100
Message-ID: <1326273019.23910.118.camel@pasglop>
References: <20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au> <20111215063004.GA3630@redhat.com>
	<87zketp9nz.fsf@rustcorp.com.au> <20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au> <20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au> <20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
	<CAJSP0QU_viNks2jv003c8+gYWFkyW=FvZpU5w6wyroeEyFkXsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QU_viNks2jv003c8+gYWFkyW=FvZpU5w6wyroeEyFkXsA@mail.gmail.com>
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

On Wed, 2012-01-11 at 08:47 +0000, Stefan Hajnoczi wrote:
> 
> This is also an opportunity to stop using CPU physical addresses in
> the ring and instead perform DMA like a normal PCI device (use bus
> addresses).

Euh why ?

That would mean in many cases adding a layer of iommu, which will slow
things down a lot ... unless we create a special virtio bus which has
its own dma-ops that do a direct v:p translation that is. But anything
PCI doing dma_map_sg and co will involved emulated iommu mapping &
unmapping and will be a huge hit on performances.

Cheers,
Ben.
