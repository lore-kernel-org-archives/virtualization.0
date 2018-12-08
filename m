From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/1] virtio: remove deprecated VIRTIO_PCI_CONFIG()
Date: Sat, 8 Dec 2018 08:56:08 +0800
Message-ID: <e91c687f-0683-1d88-bf0a-cfb5e43ee316__29505.5408882492$1544230458$gmane$org@oracle.com>
References: <1544168081-13205-1-git-send-email-dongli.zhang@oracle.com>
	<20181207125951-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181207125951-mutt-send-email-mst@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 12/08/2018 02:01 AM, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 03:34:41PM +0800, Dongli Zhang wrote:
>> VIRTIO_PCI_CONFIG() is deprecated. Use VIRTIO_PCI_CONFIG_OFF() instead.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  drivers/virtio/virtio_pci_legacy.c | 6 ++++--
>>  include/uapi/linux/virtio_pci.h    | 2 --
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>> index de062fb..eff9ddc 100644
>> --- a/drivers/virtio/virtio_pci_legacy.c
>> +++ b/drivers/virtio/virtio_pci_legacy.c
>> @@ -52,7 +52,8 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>  	void __iomem *ioaddr = vp_dev->ioaddr +
>> -				VIRTIO_PCI_CONFIG(vp_dev) + offset;
>> +			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
>> +			offset;
>>  	u8 *ptr = buf;
>>  	int i;
>>  
>> @@ -67,7 +68,8 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>  	void __iomem *ioaddr = vp_dev->ioaddr +
>> -				VIRTIO_PCI_CONFIG(vp_dev) + offset;
>> +			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
>> +			offset;
>>  	const u8 *ptr = buf;
>>  	int i;
>>
> 
> I agree that VIRTIO_PCI_CONFIG_OFF is a better interface. So above looks
> fine.
>   
>> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
>> index 90007a1..2070232 100644
>> --- a/include/uapi/linux/virtio_pci.h
>> +++ b/include/uapi/linux/virtio_pci.h
>> @@ -78,8 +78,6 @@
>>  /* The remaining space is defined by each driver as the per-driver
>>   * configuration space */
>>  #define VIRTIO_PCI_CONFIG_OFF(msix_enabled)	((msix_enabled) ? 24 : 20)
>> -/* Deprecated: please use VIRTIO_PCI_CONFIG_OFF instead */
>> -#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->msix_enabled)
>>  
>>  /* Virtio ABI version, this must match exactly */
>>  #define VIRTIO_PCI_ABI_VERSION		0
> 
> This might break some userspace builds, I don't see why we should bother
> removing it. Any reason?

Apologies.

I thought about some compatibility issue for building third-party kernel module
at userspace, but did not realize it will break other userspace software builds.

I will keep the definition of VIRTIO_PCI_CONFIG() and resend again.

Thank you very much!

Dongli Zhang

> 
> 
>> -- 
>> 2.7.4
