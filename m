From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [RFC 2/3] virtio-iommu: device probing and operations
Date: Tue, 18 Apr 2017 10:26:41 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190CADECE__45493.0950924338$1492511258$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407191747.26618-3-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407191747.26618-3-jean-philippe.brucker@arm.com>
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Jean-Philippe Brucker
> Sent: Saturday, April 8, 2017 3:18 AM
> 
[...]
>   II. Feature bits
>   ================
> 
> VIRTIO_IOMMU_F_INPUT_RANGE (0)
>  Available range of virtual addresses is described in input_range

Usually only the maximum supported address bits are important. 
Curious do you see such situation where low end of the address 
space is not usable (since you have both start/end defined later)?

[...]
>   1. Attach device
>   ----------------
> 
> struct virtio_iommu_req_attach {
> 	le32	address_space;
> 	le32	device;
> 	le32	flags/reserved;
> };
> 
> Attach a device to an address space. 'address_space' is an identifier
> unique to the guest. If the address space doesn't exist in the IOMMU

Based on your description this address space ID is per operation right?
MAP/UNMAP and page-table sharing should have different ID spaces...

> device, it is created. 'device' is an identifier unique to the IOMMU. The
> host communicates unique device ID to the guest during boot. The method
> used to communicate this ID is outside the scope of this specification,
> but the following rules must apply:
> 
> * The device ID is unique from the IOMMU point of view. Multiple devices
>   whose DMA transactions are not translated by the same IOMMU may have
> the
>   same device ID. Devices whose DMA transactions may be translated by the
>   same IOMMU must have different device IDs.
> 
> * Sometimes the host cannot completely isolate two devices from each
>   others. For example on a legacy PCI bus, devices can snoop DMA
>   transactions from their neighbours. In this case, the host must
>   communicate to the guest that it cannot isolate these devices from each
>   others. The method used to communicate this is outside the scope of this
>   specification. The IOMMU device must ensure that devices that cannot be

"IOMMU device" -> "IOMMU driver"

>   isolated by the host have the same address spaces.
> 

Thanks
Kevin
