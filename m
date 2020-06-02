From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Date: Tue, 2 Jun 2020 15:08:39 +0800
Message-ID: <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200602010332-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/2 下午1:08, Michael S. Tsirkin wrote:
> On Fri, May 29, 2020 at 04:03:02PM +0800, Jason Wang wrote:
>> +static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
>> +				 u16 qid, bool ready)
>> +{
>> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>> +
>> +	vp_iowrite16(qid, &vp_vdpa->common->queue_select);
>> +	vp_iowrite16(ready, &vp_vdpa->common->queue_enable);
>> +}
>> +
> Looks like this needs to check and just skip the write if
> ready == 0, right? Of course vdpa core then insists on calling
> vp_vdpa_get_vq_ready which will warn. Maybe just drop the
> check from core, move it to drivers which need it?
>
> ...


That may work, but it may cause inconsistent semantic for set_vq_ready 
if we leave it to the driver.


>
>
>> +static const struct pci_device_id vp_vdpa_id_table[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
>> +	{ 0 }
>> +};
> This looks like it'll create a mess with either virtio pci
> or vdpa being loaded at random. Maybe just don't specify
> any IDs for now. Down the road we could get a
> distinct vendor ID or a range of device IDs for this.


Right, will do.

Thanks


>
>> +MODULE_DEVICE_TABLE(pci, vp_vdpa_id_table);
>> +
>> +static struct pci_driver vp_vdpa_driver = {
>> +	.name		= "vp-vdpa",
>> +	.id_table	= vp_vdpa_id_table,
>> +	.probe		= vp_vdpa_probe,
>> +	.remove		= vp_vdpa_remove,
>> +};
>> +
>> +module_pci_driver(vp_vdpa_driver);
>> +
>> +MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
>> +MODULE_DESCRIPTION("vp-vdpa");
>> +MODULE_LICENSE("GPL");
>> +MODULE_VERSION("1");
>> -- 
>> 2.20.1
