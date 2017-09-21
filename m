From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [virtio-dev] [RFC] virtio-iommu version 0.4
Date: Thu, 21 Sep 2017 06:41:45 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190DDD022__23231.1981766999$1505976138$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
	<f9b02ce1-057f-df4f-90d7-52616ad60b88@redhat.com>
	<6b56fd96-fee5-d105-5261-2e7274b4aa15@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6b56fd96-fee5-d105-5261-2e7274b4aa15@arm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Auger Eric <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Wednesday, September 6, 2017 7:49 PM
> 
> 
> > 2.6.8.2.1
> > Multiple overlapping RESV_MEM properties are merged together. Device
> > requirement? if same types I assume?
> 
> Combination rules apply to device and driver. When the driver puts
> multiple endpoints in the same domain, combination rules apply. They will
> become important once the guest attempts to do things like combining
> endpoints with different PASID capabilities in the same domain. I'm
> considering these endpoints to be behind different physical IOMMUs.
> 
> For reserved regions, we specify what the driver should do and what the
> device should enforce with regard to mapping IOVAs of overlapping regions.
> For example, if a device has some virtual address RESV_T_MSI and an other
> device has the same virtual address RESV_T_IDENTITY, what should the
> driver do?
> 
> I think it should apply the RESV_T_IDENTITY. RESV_T_MSI is just a special
> case of RESV_T_RESERVED, it's a hint for the IRQ subsystem and doesn't
> have a meaning within a domain. From DMA mappings point of view, it is
> effectively the same as RESV_T_RESERVED. When merging
> RESV_T_RESERVED and
> RESV_T_IDENTITY, we should make it RESV_T_IDENTITY. Because it is
> required
> for one endpoint to work (the one with IDENTITY) and is not accessed by
> the other (the driver must not allocate this IOVA range for DMA).
> 
> More generally, I'd like to add the following combination table to the
> spec, that shows the resulting reserved region type after merging regions
> from two endpoints. N: no reserved region, R: RESV_T_RESERVED, M:
> RESV_T_MSI, I: RESV_T_IDENTITY. It is symmetric so I didn't fill the
> bottom half.
> 
>       | N | R | M | I
>     ------------------
>     N | N | R | M | ?
>     ------------------
>     R |   | R | R | I
>     ------------------
>     M |   |   | M | I
>     ------------------
>     I |   |   |   | I
> 
> The 'I' column is problematic. If one endpoint has an IDENTITY region and
> the other doesn't have anything at that virtual address, then making that
> region an identity mapping will result in the second endpoint being able
> to access firmware memory. If using nested translation, stage-2 can help
> us here. But in general we should allow the device to reject an attach
> that would result in a N+I combination if the host considers it too dodgy.
> I think the other combinations are safe enough.
> 

will overlap happen in real? Can we simplify the spec to have device
not reporting overlapping regions?

Thanks
Kevin
