From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Date: Thu, 5 Apr 2018 20:09:30 +0530
Message-ID: <3e1b113b-79ca-b700-5be9-10c66d74aabe__6851.55901960588$1522939097$gmane$org@linux.vnet.ibm.com>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: robh@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On 04/05/2018 04:26 PM, Anshuman Khandual wrote:
> There are certian platforms which would like to use SWIOTLB based DMA API
> for bouncing purpose without actually requiring an IOMMU back end. But the
> virtio core does not allow such mechanism. Right now DMA MAP API is only
> selected for devices which have an IOMMU and then the QEMU/host back end
> will process all incoming SG buffer addresses as IOVA instead of simple
> GPA which is the case for simple bounce buffers after being processed with
> SWIOTLB API. To enable this usage, it introduces an architecture specific
> function which will just make virtio core front end select DMA operations
> structure.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

+ "Michael S. Tsirkin" <mst@redhat.com>
