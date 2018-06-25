From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 2/5] iommu: Add virtio-iommu driver
Date: Mon, 25 Jun 2018 18:52:15 +0100
Message-ID: <d52ea647-8caf-d973-be2a-f54e4d9ce074__42820.3629599468$1529949046$gmane$org@arm.com>
References: <20180621190655.56391-1-jean-philippe.brucker@arm.com>
	<20180621190655.56391-3-jean-philippe.brucker@arm.com>
	<20180622033720-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180622033720-mutt-send-email-mst@kernel.org>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "joro@8bytes.org" <joro@8bytes.org>, Will Deacon <Will.Deacon@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, Robin Murphy <Robin.Murphy@arm.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

On 22/06/18 01:51, Michael S. Tsirkin wrote:
>> +VIRTIO IOMMU DRIVER
>> +M:	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> +S:	Maintained
>> +F:	drivers/iommu/virtio-iommu.c
>> +F:	include/uapi/linux/virtio_iommu.h
>> +
>>  VIRTUAL BOX GUEST DEVICE DRIVER
>>  M:	Hans de Goede <hdegoede@redhat.com>
>>  M:	Arnd Bergmann <arnd@arndb.de>
> 
> Please add the virtualization mailing list.

Ok. For the driver get_maintainer.pl now outputs the iommu and
virtualizations lists, as well as Joerg Roedel. For the header it
outputs the virtualization list, Jason and you.

>> +#define VIOMMU_REQUEST_TIMEOUT		10000 /* 10s */
> 
> Where does this come from? Do you absolutely have to have
> an arbitrary timeout?

It isn't necessary but very useful for development, and I wonder if
we could keep it behind an #ifdef DEBUG. Some requests are sent from
hardirq-safe context (because device driver are allowed to call
iommu_map/unmap from an IRQ handler), where they would lock the CPU if
the IOMMU device misbehaves. The timeout is here to provide a little
more info to developers, instead of a generic RCU lockup message.

On the other hand allowing unmap requests to timeout might pose a
security risk (freeing pages that are still used by endpoints). So I
think moving this behind a DEBUG would be better.

>> +static int viommu_probe(struct virtio_device *vdev)
>> +{
>> +	struct device *parent_dev = vdev->dev.parent;
>> +	struct viommu_dev *viommu = NULL;
>> +	struct device *dev = &vdev->dev;
>> +	u64 input_start = 0;
>> +	u64 input_end = -1UL;
>> +	int ret;
> 
> Please validate that device has VIRTIO_F_VERSION_1 -
> we don't ever want new devices to grow legacy
> interfaces.

Agreed. In this case I think I can also remove from the device
specification all legacy paragraphs, that cater for missing FEATURES_OK
status and native endianess.

For the record, all kvmtool devices on my branch now default to virtio
version 1, since they need the VIRTIO_F_IOMMU_PLATFORM bit.

>> +struct virtio_iommu_config {
>> +	/* Supported page sizes */
>> +	__u64					page_size_mask;
>> +	/* Supported IOVA range */
>> +	struct virtio_iommu_range {
>> +		__u64				start;
>> +		__u64				end;
>> +	} input_range;
>> +	/* Max domain ID size */
>> +	__u8					domain_bits;
>> +} __packed;
> 
> Please pad structs so each field and all of it are size aligned and avoid __packed.
> 
> Applies below too.

Ok, I'll clean this up (as well as the structs in the device spec). I
think the only struct that needs more padding is virtio_iommu_fault. The
total size of the attach request is 20 bytes, not aligned on 64 bits,
but it probably doesn't need to change. virtio_blk_req for example has
an odd size and I don't think that caused any problem (?).

>> +union virtio_iommu_req {
>> +	struct virtio_iommu_req_head		head;
>> +
>> +	struct virtio_iommu_req_attach		attach;
>> +	struct virtio_iommu_req_detach		detach;
>> +	struct virtio_iommu_req_map		map;
>> +	struct virtio_iommu_req_unmap		unmap;
>> +};
> 
> Such unions are problematic: if you add an option of a larger structure
> down the road, do all requests grow automatically?

Yes, requests don't have a fixed size, and the next extension adds two
slightly larger requests. I'm also in favor of removing the union, and
letting implementations redefine it if needed. At the moment this union
is only used by kvmtool for parsing requests, not by QEMU or the Linux
driver.

Thanks a lot for the comments

Jean
