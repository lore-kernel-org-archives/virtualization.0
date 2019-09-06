From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] drm/virtio: Use vmalloc for command buffer allocations.
Date: Fri, 6 Sep 2019 07:18:47 +0200
Message-ID: <20190906051847.75mj4772nqwdper6__21290.2966815577$1567747149$gmane$org@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
	<20190905220008.75488-1-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190905220008.75488-1-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Riley <davidriley@chromium.org>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> +/* How many bytes left in this page. */
> +static unsigned int rest_of_page(void *data)
> +{
> +	return PAGE_SIZE - offset_in_page(data);
> +}

Not needed.

> +/* Create sg_table from a vmalloc'd buffer. */
> +static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
> +{
> +	int nents, ret, s, i;
> +	struct sg_table *sgt;
> +	struct scatterlist *sg;
> +	struct page *pg;
> +
> +	*sg_ents = 0;
> +
> +	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
> +	if (!sgt)
> +		return NULL;
> +
> +	nents = DIV_ROUND_UP(size, PAGE_SIZE) + 1;

Why +1?

> +	ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
> +	if (ret) {
> +		kfree(sgt);
> +		return NULL;
> +	}
> +
> +	for_each_sg(sgt->sgl, sg, nents, i) {
> +		pg = vmalloc_to_page(data);
> +		if (!pg) {
> +			sg_free_table(sgt);
> +			kfree(sgt);
> +			return NULL;
> +		}
> +
> +		s = rest_of_page(data);
> +		if (s > size)
> +			s = size;

vmalloc memory is page aligned, so:

		s = min(PAGE_SIZE, size);

> +		sg_set_page(sg, pg, s, offset_in_page(data));

Offset is always zero.

> +
> +		size -= s;
> +		data += s;
> +		*sg_ents += 1;

sg_ents isn't used anywhere.

> +
> +		if (size) {
> +			sg_unmark_end(sg);
> +		} else {
> +			sg_mark_end(sg);
> +			break;
> +		}

That looks a bit strange.  I guess you need only one of the two because
the other is the default?

>  static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>  					       struct virtio_gpu_vbuffer *vbuf,
>  					       struct virtio_gpu_ctrl_hdr *hdr,
>  					       struct virtio_gpu_fence *fence)
>  {
>  	struct virtqueue *vq = vgdev->ctrlq.vq;
> +	struct scatterlist *vout = NULL, sg;
> +	struct sg_table *sgt = NULL;
>  	int rc;
> +	int outcnt = 0;
> +
> +	if (vbuf->data_size) {
> +		if (is_vmalloc_addr(vbuf->data_buf)) {
> +			sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
> +					     &outcnt);
> +			if (!sgt)
> +				return -ENOMEM;
> +			vout = sgt->sgl;
> +		} else {
> +			sg_init_one(&sg, vbuf->data_buf, vbuf->data_size);
> +			vout = &sg;
> +			outcnt = 1;

outcnt must be set in both cases.

> +static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
> +					struct virtio_gpu_vbuffer *vbuf)
> +{
> +	return virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL, NULL);
> +}

Changing virtio_gpu_queue_ctrl_buffer to call
virtio_gpu_queue_fenced_ctrl_buffer should be done in a separate patch.

cheers,
  Gerd
