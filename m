From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/virtio: Reject IOMMU page granule larger than
 PAGE_SIZE
Date: Wed, 18 Mar 2020 12:00:55 +0000
Message-ID: <f1f3d844-8080-d26d-200e-a38480895480@arm.com>
References: <20200318114047.1518048-1-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200318114047.1518048-1-jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On 2020-03-18 11:40 am, Jean-Philippe Brucker wrote:
> We don't currently support IOMMUs with a page granule larger than the
> system page size. The IOVA allocator has a BUG_ON() in this case, and
> VFIO has a WARN_ON().
> 
> It might be possible to remove these obstacles if necessary. If the host
> uses 64kB pages and the guest uses 4kB, then a device driver calling
> alloc_page() followed by dma_map_page() will create a 64kB mapping for a
> 4kB physical page, allowing the endpoint to access the neighbouring 60kB
> of memory. This problem could be worked around with bounce buffers.

FWIW the fundamental issue is that callers of iommu_map() may expect to 
be able to map two or more page-aligned regions directly adjacent to 
each other for scatter-gather purposes (or ring buffer tricks), and 
that's just not possible if the IOMMU granule is too big. Bounce 
buffering would be a viable workaround for the streaming DMA API and 
certain similar use-cases, but not in general (e.g. coherent DMA, VFIO, 
GPUs, etc.)

Robin.

> For the moment, rather than triggering the IOVA BUG_ON() on mismatched
> page sizes, abort the virtio-iommu probe with an error message.
> 
> Reported-by: Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/iommu/virtio-iommu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 6d4e3c2a2ddb..80d5d8f621ab 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -998,6 +998,7 @@ static int viommu_probe(struct virtio_device *vdev)
>   	struct device *parent_dev = vdev->dev.parent;
>   	struct viommu_dev *viommu = NULL;
>   	struct device *dev = &vdev->dev;
> +	unsigned long viommu_page_size;
>   	u64 input_start = 0;
>   	u64 input_end = -1UL;
>   	int ret;
> @@ -1028,6 +1029,14 @@ static int viommu_probe(struct virtio_device *vdev)
>   		goto err_free_vqs;
>   	}
>   
> +	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> +	if (viommu_page_size > PAGE_SIZE) {
> +		dev_err(dev, "granule 0x%lx larger than system page size 0x%lx\n",
> +			viommu_page_size, PAGE_SIZE);
> +		ret = -EINVAL;
> +		goto err_free_vqs;
> +	}
> +
>   	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
>   	viommu->last_domain = ~0U;
>   
> 
