From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 2/2] virtio: don't allocate vqs when names[i] = NULL
Date: Wed, 9 Jan 2019 17:30:17 +0100
Message-ID: <3b3b43c4-de92-8093-096b-0d3783409391__32606.9269831807$1547051307$gmane$org@de.ibm.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<1545963986-11280-3-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1545963986-11280-3-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Cc: stable@vger.kernel.org
Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")

On 28.12.2018 03:26, Wei Wang wrote:
> Some vqs may not need to be allocated when their related feature bits
> are disabled. So callers may pass in such vqs with "names = NULL".
> Then we skip such vq allocations.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/misc/mic/vop/vop_main.c        |  9 +++++++--
>  drivers/remoteproc/remoteproc_virtio.c |  9 +++++++--
>  drivers/s390/virtio/virtio_ccw.c       | 12 +++++++++---
>  drivers/virtio/virtio_mmio.c           |  9 +++++++--
>  4 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> index 6b212c8..2bfa3a9 100644
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ b/drivers/misc/mic/vop/vop_main.c
> @@ -394,16 +394,21 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
>  	struct _vop_vdev *vdev = to_vopvdev(dev);
>  	struct vop_device *vpdev = vdev->vpdev;
>  	struct mic_device_ctrl __iomem *dc = vdev->dc;
> -	int i, err, retry;
> +	int i, err, retry, queue_idx = 0;
>  
>  	/* We must have this many virtqueues. */
>  	if (nvqs > ioread8(&vdev->desc->num_vq))
>  		return -ENOENT;
>  
>  	for (i = 0; i < nvqs; ++i) {
> +		if (!names[i]) {
> +			vqs[i] = NULL;
> +			continue;
> +		}
> +
>  		dev_dbg(_vop_dev(vdev), "%s: %d: %s\n",
>  			__func__, i, names[i]);
> -		vqs[i] = vop_find_vq(dev, i, callbacks[i], names[i],
> +		vqs[i] = vop_find_vq(dev, queue_idx++, callbacks[i], names[i],
>  				     ctx ? ctx[i] : false);
>  		if (IS_ERR(vqs[i])) {
>  			err = PTR_ERR(vqs[i]);
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 183fc42..2d7cd344 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -153,10 +153,15 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  				 const bool * ctx,
>  				 struct irq_affinity *desc)
>  {
> -	int i, ret;
> +	int i, ret, queue_idx = 0;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		vqs[i] = rp_find_vq(vdev, i, callbacks[i], names[i],
> +		if (!names[i]) {
> +			vqs[i] = NULL;
> +			continue;
> +		}
> +
> +		vqs[i] = rp_find_vq(vdev, queue_idx++, callbacks[i], names[i],
>  				    ctx ? ctx[i] : false);
>  		if (IS_ERR(vqs[i])) {
>  			ret = PTR_ERR(vqs[i]);
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index fc9dbad..ae1d56d 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -635,7 +635,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	unsigned long *indicatorp = NULL;
> -	int ret, i;
> +	int ret, i, queue_idx = 0;
>  	struct ccw1 *ccw;
>  
>  	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
> @@ -643,8 +643,14 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		return -ENOMEM;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i], names[i],
> -					     ctx ? ctx[i] : false, ccw);
> +		if (!names[i]) {
> +			vqs[i] = NULL;
> +			continue;
> +		}
> +
> +		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
> +					     names[i], ctx ? ctx[i] : false,
> +					     ccw);
>  		if (IS_ERR(vqs[i])) {
>  			ret = PTR_ERR(vqs[i]);
>  			vqs[i] = NULL;
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 4cd9ea5..d9dd0f78 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -468,7 +468,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>  	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
> -	int i, err;
> +	int i, err, queue_idx = 0;
>  
>  	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
>  			dev_name(&vdev->dev), vm_dev);
> @@ -476,7 +476,12 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		return err;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i],
> +		if (!names[i]) {
> +			vqs[i] = NULL;
> +			continue;
> +		}
> +
> +		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
>  				     ctx ? ctx[i] : false);
>  		if (IS_ERR(vqs[i])) {
>  			vm_del_vqs(vdev);
> 
