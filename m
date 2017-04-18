From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [RFC 1/3] virtio-iommu: firmware description of the virtual
	topology
Date: Tue, 18 Apr 2017 09:51:23 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190CADDD2__39853.3469917767$1492509093$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407191747.26618-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407191747.26618-2-jean-philippe.brucker@arm.com>
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
> Unlike other virtio devices, the virtio-iommu doesn't work independently,
> it is linked to other virtual or assigned devices. So before jumping into
> device operations, we need to define a way for the guest to discover the
> virtual IOMMU and the devices it translates.
> 
> The host must describe the relation between IOMMU and devices to the
> guest
> using either device-tree or ACPI. The virtual IOMMU identifies each

Do you plan to support both device tree and ACPI?

> virtual device with a 32-bit ID, that we will call "Device ID" in this
> document. Device IDs are not necessarily unique system-wide, but they may
> not overlap within a single virtual IOMMU. Device ID of passed-through
> devices do not need to match IDs seen by the physical IOMMU.
> 
> The virtual IOMMU uses virtio-mmio transport exclusively, not virtio-pci,
> because with PCI the IOMMU interface would itself be an endpoint, and
> existing firmware interfaces don't allow to describe IOMMU<->master
> relations between PCI endpoints.

I'm not familiar with virtio-mmio mechanism. Curious how devices in
virtio-mmio are enumerated today? Could we use that mechanism to
identify vIOMMUs and then invent a purely para-virtualized method to
enumerate devices behind each vIOMMU? 

Asking this is because each vendor has its own enumeration methods.
ARM has device tree and ACPI IORT. AMR has ACPI IVRS and device
tree (same format as ARM?). Intel has APCI DMAR and sub-tables. Your 
current proposal looks following ARM definitions which I'm not sure 
extensible enough to cover features defined only in other vendors' 
structures.

Since the purpose of this series is to go para-virtualize, why not also
para-virtualize and simplify the enumeration method? For example, 
we may define a query interface through vIOMMU registers to allow 
guest query whether a device belonging to that vIOMMU. Then we 
can even remove use of any enumeration structure completely... 
Just a quick example which I may not think through all the pros and 
cons. :-)

> 
> The following diagram describes a situation where two virtual IOMMUs
> translate traffic from devices in the system. vIOMMU 1 translates two PCI
> domains, in which each function has a 16-bits requester ID. In order for
> the vIOMMU to differentiate guest requests targeted at devices in each
> domain, their Device ID ranges cannot overlap. vIOMMU 2 translates two PCI
> domains and a collection of platform devices.
> 
>                        Device ID    Requester ID
>                   /       0x0           0x0      \
>                  /         |             |        PCI domain 1
>                 /      0xffff           0xffff   /
>         vIOMMU 1
>                 \     0x10000           0x0      \
>                  \         |             |        PCI domain 2
>                   \   0x1ffff           0xffff   /
> 
>                   /       0x0                    \
>                  /         |                      platform devices
>                 /      0x1fff                    /
>         vIOMMU 2
>                 \      0x2000           0x0      \
>                  \         |             |        PCI domain 3
>                   \   0x11fff           0xffff   /
> 

isn't above be (0x30000, 3ffff) for PCI domain 3 giving device ID is 16bit?

Thanks
Kevin
