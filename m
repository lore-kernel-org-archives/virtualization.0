From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 5/7] iommu: Add virtio-iommu driver
Date: Thu, 8 Nov 2018 16:46:19 +0000
Message-ID: <eebdbcd4-e7eb-d5cf-3cc9-6223d9bcfbe0__20170.5653606497$1541695502$gmane$org@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
	<20181012145917.6840-6-jean-philippe.brucker@arm.com>
	<20181012120953-mutt-send-email-mst@kernel.org>
	<60605670-0419-3f64-a379-9c4057d90db1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <60605670-0419-3f64-a379-9c4057d90db1@redhat.com>
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
To: Auger Eric <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On 08/11/2018 14:51, Auger Eric wrote:
>>> +/*
>>> + * viommu_replay_mappings - re-send MAP requests
>>> + *
>>> + * When reattaching a domain that was previously detached from all endpoints,
>>> + * mappings were deleted from the device. Re-create the mappings available in
>>> + * the internal tree.
>>> + */
>>> +static int viommu_replay_mappings(struct viommu_domain *vdomain)
>>> +{
>>> +	int ret;
> ret needs to be initialized here. Otherwise this can lead to a crash in
> viommu_add_device.

I actually hit this one while testing the other day :) Fixed in next version

Thanks,
Jean
