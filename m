Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C141C433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:22:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90C360E54
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E90C360E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF96340276;
	Tue,  2 Nov 2021 03:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tx0xAUf3xPi2; Tue,  2 Nov 2021 03:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4C34400C7;
	Tue,  2 Nov 2021 03:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6C7BC0012;
	Tue,  2 Nov 2021 03:22:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91B9CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D663401CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HEFQLF2C4xU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:22:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA086400C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:22:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R441e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UuhDnvG_1635823321; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UuhDnvG_1635823321) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 02 Nov 2021 11:22:03 +0800
MIME-Version: 1.0
message-id: <1635823138.4631283-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
date: Tue, 02 Nov 2021 11:18:58 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <20211027022107.14357-2-jasowang@redhat.com>
Cc: david.kaplan@amd.com, mst@redhat.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 konrad.wilk@oracle.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 27 Oct 2021 10:21:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> This patch validate the used buffer length provided by the device
> before trying to use it. This is done by record the in buffer length
> in a new field in desc_state structure during virtqueue_add(), then we
> can fail the virtqueue_get_buf() when we find the device is trying to
> give us a used buffer length which is greater than the in buffer
> length.
>
> Since some drivers have already done the validation by themselves,
> this patch tries to makes the core validation optional. For the driver
> that doesn't want the validation, it can set the
> suppress_used_validation to be true (which could be overridden by
> force_used_validation module parameter). To be more efficient, a
> dedicate array is used for storing the validate used length, this
> helps to eliminate the cache stress if validation is done by the
> driver.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 60 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4c0ec82cef56..a6e5a3b94337 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -14,6 +14,9 @@
>  #include <linux/spinlock.h>
>  #include <xen/xen.h>
>
> +static bool force_used_validation = false;
> +module_param(force_used_validation, bool, 0444);
> +
>  #ifdef DEBUG
>  /* For development, we want to crash whenever the ring is screwed. */
>  #define BAD_RING(_vq, fmt, args...)				\
> @@ -182,6 +185,9 @@ struct vring_virtqueue {
>  		} packed;
>  	};
>
> +	/* Per-descriptor in buffer length */
> +	u32 *buflen;
> +
>  	/* How to notify other side. FIXME: commonalize hcalls! */
>  	bool (*notify)(struct virtqueue *vq);
>
> @@ -490,6 +496,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	unsigned int i, n, avail, descs_used, prev, err_idx;
>  	int head;
>  	bool indirect;
> +	u32 buflen = 0;
>
>  	START_USE(vq);
>
> @@ -571,6 +578,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			buflen += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -610,6 +618,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	else
>  		vq->split.desc_state[head].indir_desc = ctx;
>
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[head] = buflen;
> +
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> @@ -784,6 +796,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> +			*len, vq->buflen[i]);
> +		return NULL;
> +	}
>
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1062,6 +1079,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
> +	u32 buflen = 0;
>
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1091,6 +1109,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			i++;
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>
> @@ -1144,6 +1164,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
>
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[id] = buflen;
> +
>  	vq->num_added += 1;
>
>  	pr_debug("Added buffer head %i to %p\n", head, vq);
> @@ -1179,6 +1203,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
>  	int err;
> +	u32 buflen = 0;
>
>  	START_USE(vq);
>
> @@ -1258,6 +1283,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  					1 << VRING_PACKED_DESC_F_AVAIL |
>  					1 << VRING_PACKED_DESC_F_USED;
>  			}
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>
> @@ -1277,6 +1304,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].indir_desc = ctx;
>  	vq->packed.desc_state[id].last = prev;
>
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[id] = buflen;
> +
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
>  	 * available before all subsequent descriptors comprising
> @@ -1463,6 +1494,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (vq->buflen && unlikely(*len > vq->buflen[id])) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> +			*len, vq->buflen[id]);
> +		return NULL;
> +	}
>
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> @@ -1668,6 +1704,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	struct vring_virtqueue *vq;
>  	struct vring_packed_desc *ring;
>  	struct vring_packed_desc_event *driver, *device;
> +	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
>  	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
>  	size_t ring_size_in_bytes, event_size_in_bytes;
>
> @@ -1757,6 +1794,15 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	if (!vq->packed.desc_extra)
>  		goto err_desc_extra;
>
> +	if (!drv->suppress_used_validation || force_used_validation) {
> +		vq->buflen = kmalloc_array(num, sizeof(*vq->buflen),
> +					   GFP_KERNEL);
> +		if (!vq->buflen)
> +			goto err_buflen;

The reason for not using "struct vring_desc_state_split/ struct vring_desc_state_split"
is to occupy less memory when turning off this function?

Thanks.

> +	} else {
> +		vq->buflen = NULL;
> +	}
> +
>  	/* No callback?  Tell other side not to bother us. */
>  	if (!callback) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> @@ -1769,6 +1815,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	spin_unlock(&vdev->vqs_list_lock);
>  	return &vq->vq;
>
> +err_buflen:
> +	kfree(vq->packed.desc_extra);
>  err_desc_extra:
>  	kfree(vq->packed.desc_state);
>  err_desc_state:
> @@ -2176,6 +2224,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  					void (*callback)(struct virtqueue *),
>  					const char *name)
>  {
> +	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
>  	struct vring_virtqueue *vq;
>
>  	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> @@ -2235,6 +2284,15 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	if (!vq->split.desc_extra)
>  		goto err_extra;
>
> +	if (!drv->suppress_used_validation || force_used_validation) {
> +		vq->buflen = kmalloc_array(vring.num, sizeof(*vq->buflen),
> +					   GFP_KERNEL);
> +		if (!vq->buflen)
> +			goto err_buflen;
> +	} else {
> +		vq->buflen = NULL;
> +	}
> +
>  	/* Put everything in free lists. */
>  	vq->free_head = 0;
>  	memset(vq->split.desc_state, 0, vring.num *
> @@ -2245,6 +2303,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	spin_unlock(&vdev->vqs_list_lock);
>  	return &vq->vq;
>
> +err_buflen:
> +	kfree(vq->split.desc_extra);
>  err_extra:
>  	kfree(vq->split.desc_state);
>  err_state:
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 41edbc01ffa4..44d0e09da2d9 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
>   * @feature_table_size: number of entries in the feature table array.
>   * @feature_table_legacy: same as feature_table but when working in legacy mode.
>   * @feature_table_size_legacy: number of entries in feature table legacy array.
> + * @suppress_used_validation: set to not have core validate used length
>   * @probe: the function to call when a device is found.  Returns 0 or -errno.
>   * @scan: optional function to call after successful probe; intended
>   *    for virtio-scsi to invoke a scan.
> @@ -168,6 +169,7 @@ struct virtio_driver {
>  	unsigned int feature_table_size;
>  	const unsigned int *feature_table_legacy;
>  	unsigned int feature_table_size_legacy;
> +	bool suppress_used_validation;
>  	int (*validate)(struct virtio_device *dev);
>  	int (*probe)(struct virtio_device *dev);
>  	void (*scan)(struct virtio_device *dev);
> --
> 2.25.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
