From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_mem: prevent overflow with subblock size
Date: Mon, 8 Jun 2020 08:58:31 +0200
Message-ID: <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
References: <20200608061406.709211-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200608061406.709211-1-mst@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08.06.20 08:14, Michael S. Tsirkin wrote:
> If subblock size is large (e.g. 1G) 32 bit math involving it
> can overflow. Rather than try to catch all instances of that,
> let's tweak block size to 64 bit.

I fail to see where we could actually trigger an overflow. The reported
warning looked like a false positive to me.

> 
> It ripples through UAPI which is an ABI change, but it's not too late to
> make it, and it will allow supporting >4Gbyte blocks while might
> become necessary down the road.
> 

This might break cloud-hypervisor, who's already implementing this
protocol upstream (ccing Hui).
https://github.com/cloud-hypervisor/cloud-hypervisor/blob/master/vm-virtio/src/mem.rs

(blocks in the gigabyte range were never the original intention of
virtio-mem, but I am not completely opposed to that)

> Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c     | 14 +++++++-------
>  include/uapi/linux/virtio_mem.h |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 2f357142ea5e..7b1bece8a331 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -77,7 +77,7 @@ struct virtio_mem {
>  	uint64_t requested_size;
>  
>  	/* The device block size (for communicating with the device). */
> -	uint32_t device_block_size;
> +	uint64_t device_block_size;
>  	/* The translated node id. NUMA_NO_NODE in case not specified. */
>  	int nid;
>  	/* Physical start address of the memory region. */
> @@ -86,7 +86,7 @@ struct virtio_mem {
>  	uint64_t region_size;
>  
>  	/* The subblock size. */
> -	uint32_t subblock_size;
> +	uint64_t subblock_size;
>  	/* The number of subblocks per memory block. */
>  	uint32_t nb_sb_per_mb;
>  
> @@ -1698,9 +1698,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
>  	 * - At least the device block size.
>  	 * In the worst case, a single subblock per memory block.
>  	 */
> -	vm->subblock_size = PAGE_SIZE * 1u << max_t(uint32_t, MAX_ORDER - 1,
> -						    pageblock_order);
> -	vm->subblock_size = max_t(uint32_t, vm->device_block_size,
> +	vm->subblock_size = PAGE_SIZE * 1ul << max_t(uint32_t, MAX_ORDER - 1,
> +						     pageblock_order);
> +	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
>  				  vm->subblock_size);
>  	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
>  
> @@ -1713,8 +1713,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
>  
>  	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
>  	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
> -	dev_info(&vm->vdev->dev, "device block size: 0x%x",
> -		 vm->device_block_size);
> +	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
> +		 (unsigned long long)vm->device_block_size);
>  	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
>  		 memory_block_size_bytes());
>  	dev_info(&vm->vdev->dev, "subblock size: 0x%x",
> diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
> index a455c488a995..a9ffe041843c 100644
> --- a/include/uapi/linux/virtio_mem.h
> +++ b/include/uapi/linux/virtio_mem.h
> @@ -185,10 +185,10 @@ struct virtio_mem_resp {
>  
>  struct virtio_mem_config {
>  	/* Block size and alignment. Cannot change. */
> -	__u32 block_size;
> +	__u64 block_size;
>  	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
>  	__u16 node_id;
> -	__u16 padding;
> +	__u8 padding[6];
>  	/* Start address of the memory region. Cannot change. */
>  	__u64 addr;
>  	/* Region size (maximum). Cannot change. */
> 


-- 
Thanks,

David / dhildenb
