From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 10:52:57 +0200
Message-ID: <51A5C1E9.1020100@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <20130529082440.GE4472@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130529082440.GE4472@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 29/05/2013 10:24, Michael S. Tsirkin ha scritto:
> On Wed, May 29, 2013 at 02:01:18PM +0930, Rusty Russell wrote:
>> Anthony Liguori <aliguori@us.ibm.com> writes:
>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
>>>> +        return proxy->device_feature_select;
>>>
>>> Oh dear no...  Please use defines like the rest of QEMU.
>>
>> It is pretty ugly.
>>
>> Yet the structure definitions are descriptive, capturing layout, size
>> and endianness in natural a format readable by any C programmer.
>>
>> So AFAICT the question is, do we put the required
>>
>> #define VIRTIO_PCI_CFG_FEATURE_SEL \
>>          (offsetof(struct virtio_pci_common_cfg, device_feature_select))
>>
>> etc. in the kernel headers or qemu?
> 
> 
> I forgot that we need to validate size (different fields
> have different sizes so memory core does not validate
> for us).
> 
> And that is much cleaner if we use offsetof directly:
> You can see that you are checking the correct
> size matching the offset, at a glance.

I wonder if we can use and possibly extend Peter Crosthwaite's "register
API" to support this better.

Paolo

> --->
> 
> virtio: new layout: add offset validation
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f4db224..fd09ea7 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -467,51 +467,70 @@ static uint64_t virtio_pci_config_common_read(void *opaque, hwaddr addr,
>  {
>      VirtIOPCIProxy *proxy = opaque;
>      VirtIODevice *vdev = proxy->vdev;
> +    struct virtio_pci_common_cfg cfg;
>  
>      uint64_t low = 0xffffffffull;
>  
>      switch (addr) {
>      case offsetof(struct virtio_pci_common_cfg, device_feature_select):
> +        assert(size == sizeof cfg.device_feature_select);
>          return proxy->device_feature_select;
>      case offsetof(struct virtio_pci_common_cfg, device_feature):
> +        assert(size == sizeof cfg.device_feature);
>          /* TODO: 64-bit features */
>  	return proxy->device_feature_select ? 0 : proxy->host_features;
>      case offsetof(struct virtio_pci_common_cfg, guest_feature_select):
> +        assert(size == sizeof cfg.guest_feature_select);
>          return proxy->guest_feature_select;
>      case offsetof(struct virtio_pci_common_cfg, guest_feature):
> +        assert(size == sizeof cfg.guest_feature);
>          /* TODO: 64-bit features */
>  	return proxy->guest_feature_select ? 0 : vdev->guest_features;
>      case offsetof(struct virtio_pci_common_cfg, msix_config):
> +        assert(size == sizeof cfg.msix_config);
>  	return vdev->config_vector;
>      case offsetof(struct virtio_pci_common_cfg, num_queues):
> +        assert(size == sizeof cfg.num_queues);
>          /* TODO: more exact limit? */
>  	return VIRTIO_PCI_QUEUE_MAX;
>      case offsetof(struct virtio_pci_common_cfg, device_status):
> +        assert(size == sizeof cfg.device_status);
>          return vdev->status;
>  
>  	/* About a specific virtqueue. */
>      case offsetof(struct virtio_pci_common_cfg, queue_select):
> +        assert(size == sizeof cfg.queue_select);
>          return  vdev->queue_sel;
>      case offsetof(struct virtio_pci_common_cfg, queue_size):
> +        assert(size == sizeof cfg.queue_size);
>          return virtio_queue_get_num(vdev, vdev->queue_sel);
>      case offsetof(struct virtio_pci_common_cfg, queue_msix_vector):
> +        assert(size == sizeof cfg.queue_msix_vector);
>  	return virtio_queue_vector(vdev, vdev->queue_sel);
>      case offsetof(struct virtio_pci_common_cfg, queue_enable):
> +        assert(size == sizeof cfg.queue_enable);
>          /* TODO */
>  	return 0;
>      case offsetof(struct virtio_pci_common_cfg, queue_notify_off):
> +        assert(size == sizeof cfg.queue_notify_off);
>          return vdev->queue_sel;
>      case offsetof(struct virtio_pci_common_cfg, queue_desc):
> +        assert(size == 4);
>          return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & low;
>      case offsetof(struct virtio_pci_common_cfg, queue_desc) + 4:
> +        assert(size == 4);
>          return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) >> 32;
>      case offsetof(struct virtio_pci_common_cfg, queue_avail):
> +        assert(size == 4);
>          return virtio_queue_get_avail_addr(vdev, vdev->queue_sel) & low;
>      case offsetof(struct virtio_pci_common_cfg, queue_avail) + 4:
> +        assert(size == 4);
>          return virtio_queue_get_avail_addr(vdev, vdev->queue_sel) >> 32;
>      case offsetof(struct virtio_pci_common_cfg, queue_used):
> +        assert(size == 4);
>          return virtio_queue_get_used_addr(vdev, vdev->queue_sel) & low;
>      case offsetof(struct virtio_pci_common_cfg, queue_used) + 4:
> +        assert(size == 4);
>          return virtio_queue_get_used_addr(vdev, vdev->queue_sel) >> 32;
>      default:
>          return 0;
> @@ -523,76 +542,95 @@ static void virtio_pci_config_common_write(void *opaque, hwaddr addr,
>  {
>      VirtIOPCIProxy *proxy = opaque;
>      VirtIODevice *vdev = proxy->vdev;
> +    struct virtio_pci_common_cfg cfg;
>  
>      uint64_t low = 0xffffffffull;
>      uint64_t high = ~low;
>  
>      switch (addr) {
>      case offsetof(struct virtio_pci_common_cfg, device_feature_select):
> +        assert(size == sizeof cfg.device_feature_select);
>          proxy->device_feature_select = val;
>          break;
>      case offsetof(struct virtio_pci_common_cfg, device_feature):
> +        assert(size == sizeof cfg.device_feature);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, guest_feature_select):
> +        assert(size == sizeof cfg.guest_feature_select);
>          proxy->guest_feature_select = val;
>          break;
>      case offsetof(struct virtio_pci_common_cfg, guest_feature):
> +        assert(size == sizeof cfg.guest_feature);
>          /* TODO: 64-bit features */
>  	if (!proxy->guest_feature_select) {
>              virtio_set_features(vdev, val);
>          }
>          break;
>      case offsetof(struct virtio_pci_common_cfg, msix_config):
> +        assert(size == sizeof cfg.msix_config);
>  	vdev->config_vector = val;
>          break;
>      case offsetof(struct virtio_pci_common_cfg, num_queues):
> +        assert(size == sizeof cfg.num_queues);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, device_status):
> +        assert(size == sizeof cfg.device_status);
>          virtio_pci_set_status(proxy, val);
>          break;
>  	/* About a specific virtqueue. */
>      case offsetof(struct virtio_pci_common_cfg, queue_select):
> +        assert(size == sizeof cfg.queue_select);
>          assert(val < VIRTIO_PCI_QUEUE_MAX);
>          vdev->queue_sel = val;
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_size):
> +        assert(size == sizeof cfg.queue_size);
>          assert(val && val < 0x8ffff && !(val & (val - 1)));
>          virtio_queue_set_num(vdev, vdev->queue_sel, val);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_msix_vector):
> +        assert(size == sizeof cfg.queue_msix_vector);
>  	virtio_queue_set_vector(vdev, vdev->queue_sel, val);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_enable):
> +        assert(size == sizeof cfg.queue_enable);
>          /* TODO */
>  	break;
>      case offsetof(struct virtio_pci_common_cfg, queue_notify_off):
> +        assert(size == sizeof cfg.queue_notify_off);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_desc):
> +        assert(size == 4);
>          val &= low;
>          val |= virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & high;
>          virtio_queue_set_desc_addr(vdev, vdev->queue_sel, val);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_desc) + 4:
> +        assert(size == 4);
>          val = val << 32;
>          val |= virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & low;
>          virtio_queue_set_desc_addr(vdev, vdev->queue_sel, val);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_avail):
> +        assert(size == 4);
>          val &= low;
>          val |= virtio_queue_get_avail_addr(vdev, vdev->queue_sel) & high;
>          virtio_queue_set_avail_addr(vdev, vdev->queue_sel, val);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_avail) + 4:
> +        assert(size == 4);
>          val = val << 32;
>          val |= virtio_queue_get_avail_addr(vdev, vdev->queue_sel) & low;
>          virtio_queue_set_avail_addr(vdev, vdev->queue_sel, val);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_used):
> +        assert(size == 4);
>          val &= low;
>          val |= virtio_queue_get_used_addr(vdev, vdev->queue_sel) & high;
>          virtio_queue_set_used_addr(vdev, vdev->queue_sel, val);
>          break;
>      case offsetof(struct virtio_pci_common_cfg, queue_used) + 4:
> +        assert(size == 4);
>          val = val << 32;
>          val |= virtio_queue_get_used_addr(vdev, vdev->queue_sel) & low;
>          virtio_queue_set_used_addr(vdev, vdev->queue_sel, val);
> 
