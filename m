From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio-pci: add MMIO property
Date: Mon, 19 Mar 2012 16:07:45 -0500
Message-ID: <4F67A021.6040601__24081.3851626173$1332191322$gmane$org@us.ibm.com>
References: <20120319155650.GA6430@redhat.com> <4F6786C5.3080902@codemonkey.ws>
	<20120319204952.GA9747@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120319204952.GA9747@redhat.com>
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
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On 03/19/2012 03:49 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2012 at 02:19:33PM -0500, Anthony Liguori wrote:
>> On 03/19/2012 10:56 AM, Michael S. Tsirkin wrote:
>>> Currently virtio-pci is specified so that configuration of the device is
>>> done through a PCI IO space (via BAR 0 of the virtual PCI device).
>>> However, Linux guests happen to use ioread/iowrite/iomap primitives
>>> for access, and these work uniformly across memory/io BARs.
>>>
>>> While PCI IO accesses are faster than MMIO on x86 kvm,
>>> MMIO might be helpful on other systems which don't
>>> implement PIO or where PIO is slower than MMIO.
>>>
>>> Add a property to make it possible to tweak the BAR type.
>>>
>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>>
>>> This is harmless by default but causes segfaults in memory.c
>>> when enabled. Thus an RFC until I figure out what's wrong.
>>
>> Doesn't this violate the virtio-pci spec?
>>
>
> The point is to change the BAR type depending on the architecture.
> IO is fastest on x86 but maybe not on other architectures.

Are we going to document that the BAR is X on architecture Y in the spec?

I think the better way to do this is to use a separate device id range for MMIO 
virtio-pci.  You can make the same driver hand both ranges and that way the 
device is presented consistently to the guest regardless of what the 
architecture is.

>> Making the same vendor/device ID have different semantics depending
>> on a magic flag in QEMU seems like a pretty bad idea to me.
>>
>> Regards,
>>
>> Anthony Liguori
>
> We do this with MSI-X so why not the BAR type?

We extend the bar size with MSI-X and use a transport flag to indicate that it's 
available, right?

Regards,

Anthony LIguori

>
>>>
>>> ---
>>>   hw/virtio-pci.c |   16 ++++++++++++++--
>>>   hw/virtio-pci.h |    4 ++++
>>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
>>> index 28498ec..6f338d2 100644
>>> --- a/hw/virtio-pci.c
>>> +++ b/hw/virtio-pci.c
>>> @@ -655,6 +655,7 @@ void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev)
>>>   {
>>>       uint8_t *config;
>>>       uint32_t size;
>>> +    uint8_t bar0_type;
>>>
>>>       proxy->vdev = vdev;
>>>
>>> @@ -684,8 +685,14 @@ void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev)
>>>
>>>       memory_region_init_io(&proxy->bar,&virtio_pci_config_ops, proxy,
>>>                             "virtio-pci", size);
>>> -    pci_register_bar(&proxy->pci_dev, 0, PCI_BASE_ADDRESS_SPACE_IO,
>>> -&proxy->bar);
>>> +
>>> +    if (proxy->flags&   VIRTIO_PCI_FLAG_USE_MMIO) {
>>> +        bar0_type = PCI_BASE_ADDRESS_SPACE_MEMORY;
>>> +    } else {
>>> +        bar0_type = PCI_BASE_ADDRESS_SPACE_IO;
>>> +    }
>>> +
>>> +    pci_register_bar(&proxy->pci_dev, 0, bar0_type,&proxy->bar);
>>>
>>>       if (!kvm_has_many_ioeventfds()) {
>>>           proxy->flags&= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
>>> @@ -823,6 +830,7 @@ static Property virtio_blk_properties[] = {
>>>       DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
>>>       DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
>>>       DEFINE_VIRTIO_BLK_FEATURES(VirtIOPCIProxy, host_features),
>>> +    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>>
>>> @@ -856,6 +864,7 @@ static Property virtio_net_properties[] = {
>>>       DEFINE_PROP_UINT32("x-txtimer", VirtIOPCIProxy, net.txtimer, TX_TIMER_INTERVAL),
>>>       DEFINE_PROP_INT32("x-txburst", VirtIOPCIProxy, net.txburst, TX_BURST),
>>>       DEFINE_PROP_STRING("tx", VirtIOPCIProxy, net.tx),
>>> +    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>>
>>> @@ -888,6 +897,7 @@ static Property virtio_serial_properties[] = {
>>>       DEFINE_PROP_HEX32("class", VirtIOPCIProxy, class_code, 0),
>>>       DEFINE_VIRTIO_COMMON_FEATURES(VirtIOPCIProxy, host_features),
>>>       DEFINE_PROP_UINT32("max_ports", VirtIOPCIProxy, serial.max_virtserial_ports, 31),
>>> +    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>>
>>> @@ -915,6 +925,7 @@ static TypeInfo virtio_serial_info = {
>>>
>>>   static Property virtio_balloon_properties[] = {
>>>       DEFINE_VIRTIO_COMMON_FEATURES(VirtIOPCIProxy, host_features),
>>> +    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>>
>>> @@ -969,6 +980,7 @@ static int virtio_scsi_exit_pci(PCIDevice *pci_dev)
>>>   static Property virtio_scsi_properties[] = {
>>>       DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
>>>       DEFINE_VIRTIO_SCSI_PROPERTIES(VirtIOPCIProxy, host_features, scsi),
>>> +    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>>
>>> diff --git a/hw/virtio-pci.h b/hw/virtio-pci.h
>>> index e560428..e6a8861 100644
>>> --- a/hw/virtio-pci.h
>>> +++ b/hw/virtio-pci.h
>>> @@ -24,6 +24,10 @@
>>>   #define VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT 1
>>>   #define VIRTIO_PCI_FLAG_USE_IOEVENTFD   (1<<   VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT)
>>>
>>> +/* Some guests don't support port IO. Use MMIO instead. */
>>> +#define VIRTIO_PCI_FLAG_USE_MMIO_BIT 2
>>> +#define VIRTIO_PCI_FLAG_USE_MMIO   (1<<   VIRTIO_PCI_FLAG_USE_MMIO_BIT)
>>> +
>>>   typedef struct {
>>>       PCIDevice pci_dev;
>>>       VirtIODevice *vdev;
>
