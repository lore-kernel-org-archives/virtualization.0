From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
Date: Tue, 17 Sep 2019 15:23:05 +0200
Message-ID: <20190917132305.GV3958__16362.9564851121$1568726603$gmane$org@phenom.ffwll.local>
References: <20190912094121.228435-1-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190912094121.228435-1-tfiga@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: zachr@chromium.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, keiichiw@chromium.org, Daniel Vetter <daniel@ffwll.ch>, marcheu@chromium.org, posciak@chromium.org, stevensd@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 12, 2019 at 06:41:21PM +0900, Tomasz Figa wrote:
> This patch is an early RFC to judge the direction we are following in
> our virtualization efforts in Chrome OS. The purpose is to start a
> discussion on how to handle buffer sharing between multiple virtio
> devices.
> 
> On a side note, we are also working on a virtio video decoder interface
> and implementation, with a V4L2 driver for Linux. Those will be posted
> for review in the near future as well.
> 
> Any feedback will be appreciated! Thanks in advance.
> 
> ===
> 
> With the range of use cases for virtualization expanding, there is going
> to be more virtio devices added to the ecosystem. Devices such as video
> decoders, encoders, cameras, etc. typically work together with the
> display and GPU in a pipeline manner, which can only be implemented
> efficiently by sharing the buffers between producers and consumers.
> 
> Existing buffer management framework in Linux, such as the videobuf2
> framework in V4L2, implements all the DMA-buf handling inside generic
> code and do not expose any low level information about the buffers to
> the drivers.
> 
> To seamlessly enable buffer sharing with drivers using such frameworks,
> make the virtio-gpu driver expose the resource handle as the DMA address
> of the buffer returned from the DMA-buf mapping operation. Arguably, the
> resource handle is a kind of DMA address already, as it is the buffer
> identifier that the device needs to access the backing memory, which is
> exactly the same role a DMA address provides for native devices.
> 
> A virtio driver that does memory management fully on its own would have
> code similar to following. The code is identical to what a regular
> driver for real hardware would do to import a DMA-buf.
> 
> static int virtio_foo_get_resource_handle(struct virtio_foo *foo,
> 					  struct dma_buf *dma_buf, u32 *id)
> {
> 	struct dma_buf_attachment *attach;
> 	struct sg_table *sgt;
> 	int ret = 0;
> 
> 	attach = dma_buf_attach(dma_buf, foo->dev);
> 	if (IS_ERR(attach))
> 		return PTR_ERR(attach);
> 
> 	sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
> 	if (IS_ERR(sgt)) {
> 		ret = PTR_ERR(sgt);
> 		goto err_detach;
> 	}
> 
> 	if (sgt->nents != 1) {
> 		ret = -EINVAL;
> 		goto err_unmap;
> 	}
> 
> 	*id = sg_dma_address(sgt->sgl);

I agree with Gerd, this looks pretty horrible to me.

The usual way we've done these kind of special dma-bufs is:

- They all get allocated at the same place, through some library or
  whatever.

- You add a dma_buf_is_virtio(dma_buf) function, or maybe something that
  also upcasts or returns NULL, which checks for dma_buf->ops.

- Once you've upcasted at runtime by checking for ->ops, you can add
  whatever fancy interfaces you want. Including a real&proper interface to
  get at whatever underlying id you need to for real buffer sharing
  between virtio devices.

In a way virtio buffer/memory ids are a kind of private bus, entirely
distinct from the dma_addr_t bus. So can't really stuff them under this
same thing like we e.g. do with pci peer2peer.
-Daniel

> 
> err_unmap:
> 	dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
> err_detach:
> 	dma_buf_detach(dma_buf, attach);
> 
> 	return ret;
> }
> 
> On the other hand, a virtio driver that uses an existing kernel
> framework to manage buffers would not need to explicitly handle anything
> at all, as the framework part responsible for importing DMA-bufs would
> already do the work. For example, a V4L2 driver using the videobuf2
> framework would just call thee vb2_dma_contig_plane_dma_addr() function
> to get what the above open-coded function would return.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  2 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 81 ++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 0fc32fa0b3c0..ac095f813134 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -210,6 +210,8 @@ static struct drm_driver driver = {
>  #endif
>  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> +	.gem_prime_export = virtgpu_gem_prime_export,
> +	.gem_prime_import = virtgpu_gem_prime_import,
>  	.gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
>  	.gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
>  	.gem_prime_vmap = virtgpu_gem_prime_vmap,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index e28829661724..687cfce91885 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -367,6 +367,10 @@ void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo);
>  int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
>  
>  /* virtgpu_prime.c */
> +struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
> +					 int flags);
> +struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
> +						struct dma_buf *buf);
>  struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
>  struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
>  	struct drm_device *dev, struct dma_buf_attachment *attach,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index dc642a884b88..562eb1a2ed5b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -22,6 +22,9 @@
>   * Authors: Andreas Pokorny
>   */
>  
> +#include <linux/dma-buf.h>
> +#include <linux/dma-direction.h>
> +
>  #include <drm/drm_prime.h>
>  
>  #include "virtgpu_drv.h"
> @@ -30,6 +33,84 @@
>   * device that might share buffers with virtgpu
>   */
>  
> +static struct sg_table *
> +virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
> +			enum dma_data_direction dir)
> +{
> +	struct drm_gem_object *obj = attach->dmabuf->priv;
> +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
> +	if (!sgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (ret) {
> +		kfree(sgt);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	sg_dma_address(sgt->sgl) = bo->hw_res_handle;
> +	sg_dma_len(sgt->sgl) = obj->size;
> +	sgt->nents = 1;
> +
> +	return sgt;
> +}
> +
> +static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> +				      struct sg_table *sgt,
> +				      enum dma_data_direction dir)
> +{
> +	sg_free_table(sgt);
> +	kfree(sgt);
> +}
> +
> +static const struct dma_buf_ops virtgpu_dmabuf_ops =  {
> +	.cache_sgt_mapping = true,
> +	.attach = drm_gem_map_attach,
> +	.detach = drm_gem_map_detach,
> +	.map_dma_buf = virtgpu_gem_map_dma_buf,
> +	.unmap_dma_buf = virtgpu_gem_unmap_dma_buf,
> +	.release = drm_gem_dmabuf_release,
> +	.mmap = drm_gem_dmabuf_mmap,
> +	.vmap = drm_gem_dmabuf_vmap,
> +	.vunmap = drm_gem_dmabuf_vunmap,
> +};
> +
> +struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
> +					 int flags)
> +{
> +	struct dma_buf *buf;
> +
> +	buf = drm_gem_prime_export(obj, flags);
> +	if (!IS_ERR(buf))
> +		buf->ops = &virtgpu_dmabuf_ops;
> +
> +	return buf;
> +}
> +
> +struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
> +						struct dma_buf *buf)
> +{
> +	struct drm_gem_object *obj;
> +
> +	if (buf->ops == &virtgpu_dmabuf_ops) {
> +		obj = buf->priv;
> +		if (obj->dev == dev) {
> +			/*
> +			 * Importing dmabuf exported from our own gem increases
> +			 * refcount on gem itself instead of f_count of dmabuf.
> +			 */
> +			drm_gem_object_get(obj);
> +			return obj;
> +		}
> +	}
> +
> +	return drm_gem_prime_import(dev, buf);
> +}
> +
>  struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  {
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> -- 
> 2.23.0.237.gc6a4ce50a0-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
