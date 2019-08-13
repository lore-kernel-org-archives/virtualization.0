From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 13 Aug 2019 15:26:17 +0200
Message-ID: <20190813132617.GA6426__44674.0313012683$1565702797$gmane$org@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
	<20190812095156.GD3947@umbus.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190812095156.GD3947@umbus.fritz.box>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-devel@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 12, 2019 at 07:51:56PM +1000, David Gibson wrote:
> AFAICT we already kind of abuse this for the VIRTIO_F_IOMMU_PLATFORM,
> because to handle for cases where it *is* a device limitation, we
> assume that if the hypervisor presents VIRTIO_F_IOMMU_PLATFORM then
> the guest *must* select it.
> 
> What we actually need here is for the hypervisor to present
> VIRTIO_F_IOMMU_PLATFORM as available, but not required.  Then we need
> a way for the platform core code to communicate to the virtio driver
> that *it* requires the IOMMU to be used, so that the driver can select
> or not the feature bit on that basis.

I agree with the above, but that just brings us back to the original
issue - the whole bypass of the DMA OPS should be an option that the
device can offer, not the other way around.  And we really need to
fix that root cause instead of doctoring around it.
