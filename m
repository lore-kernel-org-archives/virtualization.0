From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Subject: Re: [PATCH V6 8/8] virtio: Intel IFC VF driver for VDPA
Date: Thu, 19 Mar 2020 15:28:09 +0800
Message-ID: <d3e0ec0d-3387-17bd-a33c-189933f70f95@linux.intel.com>
References: <20200318080327.21958-1-jasowang@redhat.com>
 <20200318080327.21958-9-jasowang@redhat.com>
 <20200318122255.GG13183@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200318122255.GG13183@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>, Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, Bie Tiwei <tiwei.bie@intel.com>
List-Id: virtualization@lists.linuxfoundation.org


On 3/18/2020 8:22 PM, Jason Gunthorpe wrote:
> On Wed, Mar 18, 2020 at 04:03:27PM +0800, Jason Wang wrote:
>> From: Zhu Lingshan <lingshan.zhu@intel.com>
>> +
>> +static int ifcvf_vdpa_attach(struct ifcvf_adapter *adapter)
>> +{
>> +	int ret;
>> +
>> +	adapter->vdpa_dev  = vdpa_alloc_device(adapter->dev, adapter->dev,
>> +					       &ifc_vdpa_ops);
>> +	if (IS_ERR(adapter->vdpa_dev)) {
>> +		IFCVF_ERR(adapter->dev, "Failed to init ifcvf on vdpa bus");
>> +		put_device(&adapter->vdpa_dev->dev);
>> +		return -ENODEV;
>> +	}
> The point of having an alloc call is so that the drivers
> ifcvf_adaptor memory could be placed in the same struct - eg use
> container_of to flip between them, and have a kref for both memories.
>
> It seem really weird to have an alloc followed immediately by
> register.

Hi Jason,

Thanks for your comments, but I failed to understand this. In IFCVF 
driver, we call ifcvf_vdpa_attach() at the end at probe(),
at this point, PCIE initialization almost done, then try to alloc vdpa 
device, if successful, we can register it to VDPA bus.

Are you suggesting to wait for anything else done?

THanks,
BR
Zhu Linghsan
>
>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>> index c30eb55030be..de64b88ee7e4 100644
>> +++ b/drivers/virtio/virtio_vdpa.c
>> @@ -362,6 +362,7 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
>>   		goto err;
>>   
>>   	vdpa_set_drvdata(vdpa, vd_dev);
>> +	dev_info(vd_dev->vdev.dev.parent, "device attached to VDPA bus\n");
>>   
>>   	return 0;
> This hunk seems out of place
>
> Jason
