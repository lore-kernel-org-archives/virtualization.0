From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 5/7] iommu: Add virtio-iommu driver
Date: Fri, 12 Oct 2018 19:54:53 +0100
Message-ID: <ba8d7b94-a806-276b-e64c-9e6c5c9e107b__29289.3283222385$1539370391$gmane$org@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
	<20181012145917.6840-6-jean-philippe.brucker@arm.com>
	<20181012120953-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181012120953-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On 12/10/2018 17:35, Michael S. Tsirkin wrote:
>> +		list_del(&req->list);
>> +		kfree(req);
> 
> So with DEBUG set, this will actually free memory that device still
> DMA's into. Hardly pretty. I think you want to mark device broken,
> queue the request and then wait for device to be reset.

Ok, let's remove DEBUG for the moment

>> +static int viommu_probe(struct virtio_device *vdev)
>> +{
>> +	struct device *parent_dev = vdev->dev.parent;
>> +	struct viommu_dev *viommu = NULL;
>> +	struct device *dev = &vdev->dev;
>> +	u64 input_start = 0;
>> +	u64 input_end = -1UL;
>> +	int ret;
>> +
>> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>> +		return -ENODEV;
> 
> I'm a bit confused about what will happen if this device
> happens to be behind an iommu itself.
>
> If we can't handle that, should we clear PLATFORM_IOMMU
> e.g. like the balloon does?

I think the DMA API can handle this device doing DMA through another
IOMMU. I haven't tested this case because it is very unusual (IOMMUs
themselves generally access the physical address space) but I don't see
anything preventing it.

What we can't handle is a device performing DMA through two
daisy-chained IOMMUs, but clearing PLATFORM_IOMMU on the first one
wouldn't make things work in that case, we'd need some core changes.

>> +struct virtio_iommu_config {
>> +	/* Supported page sizes */
>> +	__u64					page_size_mask;
>> +	/* Supported IOVA range */
>> +	struct virtio_iommu_range {
> 
> I'd rather we moved the definition outside even though gcc allows it -
> some old userspace compilers might not.
> 
>> +		__u64				start;
>> +		__u64				end;
>> +	} input_range;
>> +	/* Max domain ID size */
>> +	__u8					domain_bits;
> 
> Let's add explicit padding here as well?

Ok

Thanks,
Jean
