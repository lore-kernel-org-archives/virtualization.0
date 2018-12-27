From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v37 1/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Thu, 27 Dec 2018 13:03:44 +0100
Message-ID: <49d706f7-a0ee-e571-7d02-bcadac5ce742__31667.6148366698$1545912120$gmane$org@de.ibm.com>
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
	<1535333539-32420-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1535333539-32420-2-git-send-email-wei.w.wang@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, dgilbert@redhat.com
Cc: yang.zhang.wz@gmail.com, riel@redhat.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, pbonzini@redhat.com, nilal@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 27.08.2018 03:32, Wei Wang wrote:
>  static int init_vqs(struct virtio_balloon *vb)
>  {
> -	struct virtqueue *vqs[3];
> -	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
> -	static const char * const names[] = { "inflate", "deflate", "stats" };
> -	int err, nvqs;
> +	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
> +	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
> +	const char *names[VIRTIO_BALLOON_VQ_MAX];
> +	int err;
> 
>  	/*
> -	 * We expect two virtqueues: inflate and deflate, and
> -	 * optionally stat.
> +	 * Inflateq and deflateq are used unconditionally. The names[]
> +	 * will be NULL if the related feature is not enabled, which will
> +	 * cause no allocation for the corresponding virtqueue in find_vqs.
>  	 */

This might be true for virtio-pci, but it is not for virtio-ccw.

> -	nvqs = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ) ? 3 : 2;
> -	err = virtio_find_vqs(vb->vdev, nvqs, vqs, callbacks, names, NULL);
> +	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
> +	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
> +	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
> +	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
> +	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
> +	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> +
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> +		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> +		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
> +	}
> +
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> +		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
> +		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> +	}
> +
> +	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
[...]
