From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 1/4] iommu: Add virtio-iommu driver
Date: Wed, 21 Mar 2018 13:14:04 +0000
Message-ID: <a11f1b52-c031-014c-8c23-1732f3d4666c__6.88885706967568$1521637733$gmane$org@arm.com>
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
	<20180214145340.1223-2-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19108B0FE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19108B0FE@SHSMSX101.ccr.corp.intel.com>
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
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Cc: "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>, "eric.auger@redhat.com" <eric.auger@redhat.com>, Robin Murphy <Robin.Murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 21/03/18 06:43, Tian, Kevin wrote:
[...]
>> +
>> +#include <uapi/linux/virtio_iommu.h>
>> +
>> +#define MSI_IOVA_BASE			0x8000000
>> +#define MSI_IOVA_LENGTH			0x100000
> 
> this is ARM specific, and according to virtio-iommu spec isn't it
> better probed on the endpoint instead of hard-coding here?

These values are arbitrary, not really ARM-specific even if ARM is the
only user yet: we're just reserving a random IOVA region for mapping MSIs.
It is hard-coded because of the way iommu-dma.c works, but I don't quite
remember why that allocation isn't dynamic.

As said on the v0.6 spec thread, I'm not sure allocating the IOVA range in
the host is preferable. With nested translation the guest has to map it
anyway, and I believe dealing with IOVA allocation should be left to the
guest when possible.

Thanks,
Jean
