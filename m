From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH v2 3/5] iommu/virtio-iommu: Add event queue
Date: Tue, 16 Jan 2018 17:48:15 +0000
Message-ID: <874c9d45-d2a0-d77b-8606-bd1c13b63032__32193.7237786644$1516124650$gmane$org@arm.com>
References: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
	<20171117185211.32593-4-jean-philippe.brucker@arm.com>
	<3061e653-38bb-bffa-0f16-43047724a0ae@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3061e653-38bb-bffa-0f16-43047724a0ae@redhat.com>
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
To: Auger Eric <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "lenb@kernel.org" <lenb@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On 16/01/18 10:10, Auger Eric wrote:
> Hi,
> 
> On 17/11/17 19:52, Jean-Philippe Brucker wrote:
>> The event queue offers a way for the device to report access faults from
>> devices.
> end points?

Yes

[...]
>> +static void viommu_event_handler(struct virtqueue *vq)
>> +{
>> +	int ret;
>> +	unsigned int len;
>> +	struct scatterlist sg[1];
>> +	struct viommu_event *evt;
>> +	struct viommu_dev *viommu = vq->vdev->priv;
>> +
>> +	while ((evt = virtqueue_get_buf(vq, &len)) != NULL) {
>> +		if (len > sizeof(*evt)) {
>> +			dev_err(viommu->dev,
>> +				"invalid event buffer (len %u != %zu)\n",
>> +				len, sizeof(*evt));
>> +		} else if (!(evt->head & VIOMMU_FAULT_RESV_MASK)) {
>> +			viommu_fault_handler(viommu, &evt->fault);
>> +		}
>> +
>> +		sg_init_one(sg, evt, sizeof(*evt));
> in case of above error case, ie. len > sizeof(*evt), is it safe to push
> evt again?

I think it is, len is just what the device reports as written. The above
error would be a device bug, very unlikely and not worth a special
treatment (freeing the buffer), maybe not even worth the dev_err()
actually.

>> +		ret = virtqueue_add_inbuf(vq, sg, 1, evt, GFP_ATOMIC);
>> +		if (ret)
>> +			dev_err(viommu->dev, "could not add event buffer\n");
>> +	}
>> +
>> +	if (!virtqueue_kick(vq))
>> +		dev_err(viommu->dev, "kick failed\n");
>> +}
>> +
>>  /* IOMMU API */
>>  
>>  static bool viommu_capable(enum iommu_cap cap)
>> @@ -938,19 +1018,44 @@ static struct iommu_ops viommu_ops = {
>>  	.put_resv_regions	= viommu_put_resv_regions,
>>  };
>>  
>> -static int viommu_init_vq(struct viommu_dev *viommu)
>> +static int viommu_init_vqs(struct viommu_dev *viommu)
>>  {
>>  	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
>> -	const char *name = "request";
>> -	void *ret;
>> +	const char *names[] = { "request", "event" };
>> +	vq_callback_t *callbacks[] = {
>> +		NULL, /* No async requests */
>> +		viommu_event_handler,
>> +	};
>> +
>> +	return virtio_find_vqs(vdev, VIOMMU_NUM_VQS, viommu->vqs, callbacks,
>> +			       names, NULL);
>> +}
>>  
>> -	ret = virtio_find_single_vq(vdev, NULL, name);
>> -	if (IS_ERR(ret)) {
>> -		dev_err(viommu->dev, "cannot find VQ\n");
>> -		return PTR_ERR(ret);
>> +static int viommu_fill_evtq(struct viommu_dev *viommu)
>> +{
>> +	int i, ret;
>> +	struct scatterlist sg[1];
>> +	struct viommu_event *evts;
>> +	struct virtqueue *vq = viommu->vqs[VIOMMU_EVENT_VQ];
>> +	size_t nr_evts = min_t(size_t, PAGE_SIZE / sizeof(struct viommu_event),
>> +			       viommu->vqs[VIOMMU_EVENT_VQ]->num_free);
>> +
>> +	evts = devm_kmalloc_array(viommu->dev, nr_evts, sizeof(*evts),
>> +				  GFP_KERNEL);
>> +	if (!evts)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < nr_evts; i++) {
>> +		sg_init_one(sg, &evts[i], sizeof(*evts));
>> +		ret = virtqueue_add_inbuf(vq, sg, 1, &evts[i], GFP_KERNEL);
> who does the deallocation of evts?

I think it should be viommu_remove, which should also remove the
virtqueues. I'll add this.

Thanks,
Jean
