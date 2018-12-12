From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Date: Wed, 12 Dec 2018 09:35:19 -0500
Message-ID: <20181212093413-mutt-send-email-mst__33411.6808059209$1544625215$gmane$org@kernel.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
	<20181212103545.GV16835@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181212103545.GV16835@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <joro@8bytes.org>
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-pci@vger.kernel.org, will.deacon@arm.com, robin.murphy@arm.com, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, marc.zyngier@arm.com, bhelgaas@google.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 12, 2018 at 11:35:45AM +0100, Joerg Roedel wrote:
> Hi,
> 
> to make progress on this, we should first agree on the protocol used
> between guest and host. I have a few points to discuss on the protocol
> first.
> 
> On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
> > [1] Virtio-iommu specification v0.9, sources and pdf
> >     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
> >     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
> 
> Looking at this I wonder why it doesn't make the IOTLB visible to the
> guest. the UNMAP requests seem to require that the TLB is already
> flushed to make the unmap visible.
> 
> I think that will cost significant performance for both, vfio and
> dma-iommu use-cases which both do (vfio at least to some degree),
> deferred flushing.
> 
> I also wonder whether the protocol should implement a
> protocol version handshake

virtio has a builtin version handshake so devices don't need to.

> and iommu-feature set queries.
> 
> > [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.1
> >     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> 
> Unfortunatly gitweb seems to be broken on linux-arm.org. What is missing
> in this patch-set to make this work on x86?

And I wonder about pcc too.

> Regards,
> 
> 	Joerg
