From: Christophe de Dinechin <christophe.de.dinechin@gmail.com>
Subject: Re: [RFC PATCH V2 4/5] vhost: introduce helpers to get the size of
	metadata area
Date: Wed, 6 Mar 2019 11:56:48 +0100
Message-ID: <608E47C2-5130-41DE-9D52-02807EBCDD43__35250.3334566549$1555717300$gmane$org@dinechin.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-5-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1551856692-3384-5-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: aarcange@redhat.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org



> On 6 Mar 2019, at 08:18, Jason Wang <jasowang@redhat.com> wrote:
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> drivers/vhost/vhost.c | 46 ++++++++++++++++++++++++++++------------------
> 1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2025543..1015464 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -413,6 +413,27 @@ static void vhost_dev_free_iovecs(struct vhost_dev *dev)
> 		vhost_vq_free_iovecs(dev->vqs[i]);
> }
> 
> +static size_t vhost_get_avail_size(struct vhost_virtqueue *vq, int num)

Nit: Any reason not to make `num` unsigned or size_t?

> +{
> +	size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +
> +	return sizeof(*vq->avail) +
> +	       sizeof(*vq->avail->ring) * num + event;
> +}
> +
> +static size_t vhost_get_used_size(struct vhost_virtqueue *vq, int num)
> +{
> +	size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +
> +	return sizeof(*vq->used) +
> +	       sizeof(*vq->used->ring) * num + event;
> +}
> +
> +static size_t vhost_get_desc_size(struct vhost_virtqueue *vq, int num)
> +{
> +	return sizeof(*vq->desc) * num;
> +}
> +
> void vhost_dev_init(struct vhost_dev *dev,
> 		    struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
> {
> @@ -1253,13 +1274,9 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
> 			 struct vring_used __user *used)
> 
> {
> -	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> -
> -	return access_ok(desc, num * sizeof *desc) &&
> -	       access_ok(avail,
> -			 sizeof *avail + num * sizeof *avail->ring + s) &&
> -	       access_ok(used,
> -			sizeof *used + num * sizeof *used->ring + s);
> +	return access_ok(desc, vhost_get_desc_size(vq, num)) &&
> +	       access_ok(avail, vhost_get_avail_size(vq, num)) &&
> +	       access_ok(used, vhost_get_used_size(vq, num));
> }
> 
> static void vhost_vq_meta_update(struct vhost_virtqueue *vq,
> @@ -1311,22 +1328,18 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
> 
> int vq_meta_prefetch(struct vhost_virtqueue *vq)
> {
> -	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> 	unsigned int num = vq->num;
> 
> 	if (!vq->iotlb)
> 		return 1;
> 
> 	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
> -			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
> +			       vhost_get_desc_size(vq, num), VHOST_ADDR_DESC) &&
> 	       iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->avail,
> -			       sizeof *vq->avail +
> -			       num * sizeof(*vq->avail->ring) + s,
> +			       vhost_get_avail_size(vq, num),
> 			       VHOST_ADDR_AVAIL) &&
> 	       iotlb_access_ok(vq, VHOST_ACCESS_WO, (u64)(uintptr_t)vq->used,
> -			       sizeof *vq->used +
> -			       num * sizeof(*vq->used->ring) + s,
> -			       VHOST_ADDR_USED);
> +			       vhost_get_used_size(vq, num), VHOST_ADDR_USED);
> }
> EXPORT_SYMBOL_GPL(vq_meta_prefetch);
> 
> @@ -1343,13 +1356,10 @@ bool vhost_log_access_ok(struct vhost_dev *dev)
> static bool vq_log_access_ok(struct vhost_virtqueue *vq,
> 			     void __user *log_base)
> {
> -	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> -
> 	return vq_memory_access_ok(log_base, vq->umem,
> 				   vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
> 		(!vq->log_used || log_access_ok(log_base, vq->log_addr,
> -					sizeof *vq->used +
> -					vq->num * sizeof *vq->used->ring + s));
> +				  vhost_get_used_size(vq, vq->num)));
> }
> 
> /* Can we start vq? */
> -- 
> 1.8.3.1
> 
