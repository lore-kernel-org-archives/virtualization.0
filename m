From: Zoltan Kiss <zoltan.kiss@citrix.com>
Subject: Re: [PATCHv2] tracing/events: Add bounce tracing to swiotbl
Date: Wed, 18 Sep 2013 17:04:17 +0100
Message-ID: <5239CF01.1010001@citrix.com>
References: <1378325465-10384-1-git-send-email-zoltan.kiss@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1378325465-10384-1-git-send-email-zoltan.kiss@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I haven't got a reply in the past 2 weeks, so I would like to bump the 
patch, just to make sure it haven't fell off the radar.

Zoli

On 04/09/13 21:11, Zoltan Kiss wrote:
> Ftrace is currently not able to detect when SWIOTLB has to do double buffering.
> Under Xen you can only see it indirectly in function_graph, when
> xen_swiotlb_map_page() doesn't stop after range_straddles_page_boundary(), but
> calls spinlock functions, memcpy() and xen_phys_to_bus() as well. This patch
> introduces the swiotlb:swiotlb_bounced event, which also prints out the
> following informations to help you find out why bouncing happened:
>
> dev_name: 0000:08:00.0 dma_mask=ffffffffffffffff dev_addr=9149f000 size=32768
> swiotlb_force=0
>
> If you use Xen, and (dev_addr + size + 1) > dma_mask, the buffer is out of the
> device's DMA range. If swiotlb_force == 1, you should really change the kernel
> parameters. Otherwise, the buffer is not contiguous in mfn space.
>
> Signed-off-by: Zoltan Kiss <zoltan.kiss@citrix.com>
> ---
>   drivers/xen/swiotlb-xen.c      |    5 +++++
>   include/trace/events/swiotlb.h |   46 ++++++++++++++++++++++++++++++++++++++++
>   lib/swiotlb.c                  |    4 ++++
>   3 files changed, 55 insertions(+)
>
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index aadffcf..67a4b77 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -42,6 +42,9 @@
>   #include <xen/page.h>
>   #include <xen/xen-ops.h>
>   #include <xen/hvc-console.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/swiotlb.h>
>   /*
>    * Used to do a quick range check in swiotlb_tbl_unmap_single and
>    * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
> @@ -358,6 +361,8 @@ dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>   	/*
>   	 * Oh well, have to allocate and map a bounce buffer.
>   	 */
> +	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
> +
>   	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir);
>   	if (map == SWIOTLB_MAP_ERROR)
>   		return DMA_ERROR_CODE;
> diff --git a/include/trace/events/swiotlb.h b/include/trace/events/swiotlb.h
> new file mode 100644
> index 0000000..6d21410
> --- /dev/null
> +++ b/include/trace/events/swiotlb.h
> @@ -0,0 +1,46 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM swiotlb
> +
> +#if !defined(_TRACE_SWIOTLB_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SWIOTLB_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(swiotlb_bounced,
> +
> +	TP_PROTO(struct device *dev,
> +		 dma_addr_t dev_addr,
> +		 size_t size,
> +		 int swiotlb_force),
> +
> +	TP_ARGS(dev, dev_addr, size, swiotlb_force),
> +
> +	TP_STRUCT__entry(
> +		__string(	dev_name,	dev_name(dev)	)
> +		__field(	u64,	dma_mask		)
> +		__field(	dma_addr_t,	dev_addr	)
> +		__field(	size_t,	size			)
> +		__field(	int,	swiotlb_force		)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->dma_mask = (dev->dma_mask ? *dev->dma_mask : 0);
> +		__entry->dev_addr = dev_addr;
> +		__entry->size = size;
> +		__entry->swiotlb_force = swiotlb_force;
> +	),
> +
> +	TP_printk("dev_name: %s dma_mask=%llx dev_addr=%llx "
> +		"size=%zu swiotlb_force=%x",
> +		__get_str(dev_name),
> +		__entry->dma_mask,
> +		(unsigned long long)__entry->dev_addr,
> +		__entry->size,
> +		__entry->swiotlb_force)
> +);
> +
> +#endif /*  _TRACE_SWIOTLB_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index d23762e..d69ecbe 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -38,6 +38,8 @@
>   #include <linux/bootmem.h>
>   #include <linux/iommu-helper.h>
>
> +#include <trace/events/swiotlb.h>
> +
>   #define OFFSET(val,align) ((unsigned long)	\
>   	                   ( (val) & ( (align) - 1)))
>
> @@ -726,6 +728,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   	if (dma_capable(dev, dev_addr, size) && !swiotlb_force)
>   		return dev_addr;
>
> +	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
> +
>   	/* Oh well, have to allocate and map a bounce buffer. */
>   	map = map_single(dev, phys, size, dir);
>   	if (map == SWIOTLB_MAP_ERROR) {
>
