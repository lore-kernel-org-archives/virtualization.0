From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Date: Fri, 6 Apr 2018 00:16:34 -0700
Message-ID: <20180406071634.GA31108__27683.3215299577$1522998904$gmane$org@infradead.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
	<3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
	<20180405175326-mutt-send-email-mst@kernel.org>
	<1522940983.21446.205.camel@kernel.crashing.org>
	<20180405213042-mutt-send-email-mst@kernel.org>
	<1522963113.21446.211.camel@kernel.crashing.org>
	<70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: robh@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 06, 2018 at 08:23:10AM +0530, Anshuman Khandual wrote:
> On 04/06/2018 02:48 AM, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-04-05 at 21:34 +0300, Michael S. Tsirkin wrote:
> >>> In this specific case, because that would make qemu expect an iommu,
> >>> and there isn't one.
> >>
> >>
> >> I think that you can set iommu_platform in qemu without an iommu.
> > 
> > No I mean the platform has one but it's not desirable for it to be used
> > due to the performance hit.
> 
> Also the only requirement is to bounce the I/O buffers through SWIOTLB
> implemented as DMA API which the virtio core understands. There is no
> need for an IOMMU to be involved for the device representation in this
> case IMHO.

This whole virtio translation issue is a mess.  I think we need to
switch it to the dma API, and then quirk the legacy case to always
use the direct mapping inside the dma API.
