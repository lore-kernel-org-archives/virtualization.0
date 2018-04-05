From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Date: Thu, 5 Apr 2018 21:34:54 +0300
Message-ID: <20180405213042-mutt-send-email-mst__43441.7746765122$1522953198$gmane$org@kernel.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
	<3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
	<20180405175326-mutt-send-email-mst@kernel.org>
	<1522940983.21446.205.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1522940983.21446.205.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, joe@perches.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 06, 2018 at 01:09:43AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2018-04-05 at 17:54 +0300, Michael S. Tsirkin wrote:
> > On Thu, Apr 05, 2018 at 08:09:30PM +0530, Anshuman Khandual wrote:
> > > On 04/05/2018 04:26 PM, Anshuman Khandual wrote:
> > > > There are certian platforms which would like to use SWIOTLB based DMA API
> > > > for bouncing purpose without actually requiring an IOMMU back end. But the
> > > > virtio core does not allow such mechanism. Right now DMA MAP API is only
> > > > selected for devices which have an IOMMU and then the QEMU/host back end
> > > > will process all incoming SG buffer addresses as IOVA instead of simple
> > > > GPA which is the case for simple bounce buffers after being processed with
> > > > SWIOTLB API. To enable this usage, it introduces an architecture specific
> > > > function which will just make virtio core front end select DMA operations
> > > > structure.
> > > > 
> > > > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > > 
> > > + "Michael S. Tsirkin" <mst@redhat.com>
> > 
> > I'm confused by this.
> > 
> > static bool vring_use_dma_api(struct virtio_device *vdev)
> > {
> >         if (!virtio_has_iommu_quirk(vdev))
> >                 return true;
> > 
> > 
> > Why doesn't setting VIRTIO_F_IOMMU_PLATFORM on the
> > hypervisor side sufficient?
> 
> In this specific case, because that would make qemu expect an iommu,
> and there isn't one.


I think that you can set iommu_platform in qemu without an iommu.


> Anshuman, you need to provide more background here. I don't have time
> right now it's late, but explain about the fact that this is for a
> specific type of secure VM which has only a limited pool of (insecure)
> memory that can be shared with qemu, so all IOs need to bounce via that
> pool, which can be achieved by using swiotlb.
> 
> Note: this isn't urgent, we can discuss alternative approaches, this is
> just to start the conversation.
> 
> Cheers,
> Ben.
