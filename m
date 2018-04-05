From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Date: Fri, 06 Apr 2018 01:09:43 +1000
Message-ID: <1522940983.21446.205.camel__15922.6275435232$1522942670$gmane$org@kernel.crashing.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
	<3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
	<20180405175326-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180405175326-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2018-04-05 at 17:54 +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 05, 2018 at 08:09:30PM +0530, Anshuman Khandual wrote:
> > On 04/05/2018 04:26 PM, Anshuman Khandual wrote:
> > > There are certian platforms which would like to use SWIOTLB based DMA API
> > > for bouncing purpose without actually requiring an IOMMU back end. But the
> > > virtio core does not allow such mechanism. Right now DMA MAP API is only
> > > selected for devices which have an IOMMU and then the QEMU/host back end
> > > will process all incoming SG buffer addresses as IOVA instead of simple
> > > GPA which is the case for simple bounce buffers after being processed with
> > > SWIOTLB API. To enable this usage, it introduces an architecture specific
> > > function which will just make virtio core front end select DMA operations
> > > structure.
> > > 
> > > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > 
> > + "Michael S. Tsirkin" <mst@redhat.com>
> 
> I'm confused by this.
> 
> static bool vring_use_dma_api(struct virtio_device *vdev)
> {
>         if (!virtio_has_iommu_quirk(vdev))
>                 return true;
> 
> 
> Why doesn't setting VIRTIO_F_IOMMU_PLATFORM on the
> hypervisor side sufficient?

In this specific case, because that would make qemu expect an iommu,
and there isn't one.

Anshuman, you need to provide more background here. I don't have time
right now it's late, but explain about the fact that this is for a
specific type of secure VM which has only a limited pool of (insecure)
memory that can be shared with qemu, so all IOs need to bounce via that
pool, which can be achieved by using swiotlb.

Note: this isn't urgent, we can discuss alternative approaches, this is
just to start the conversation.

Cheers,
Ben.
