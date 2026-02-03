Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85350392C57
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107374; cv=none; b=iUeF4JSA9H795WPPobLvq9d7U6WBtVgJOTEx8+LrmZK+yF6bS3YV5iCwQgCkoXYTQ4YixCR1E6YruTqWZSkXV6Oen1/jYhV2oAWfn3KuA0H/7J3qXRvjg+XAQhsUD3dLh9+CJE+IFUObqqkdGI2tcEKhcOcBiQLh2mFPN3vZCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107374; c=relaxed/simple;
	bh=YWPNISbjvW3zZbtsnb2/ecoNtOvAKYiTplIIKIi/Z2g=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=OaHxHm0i00Vyo81ZeA13/wschyBjr1pBm1vO2T6VpdpAHFql9b5sXBMt/wuafErvNhaF9RdfbCdQTMlWlZG58vjhHZAZwfI76tQY2IAsgzltrxa6PZRNFM04xu6ghwVkly0Xa0545+nMB1yNSZq6y/xBVqtF3fjWqZLvTTcKaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sJ7bUOwF; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sJ7bUOwF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770107356; h=Message-ID:Subject:Date:From:To;
	bh=zf8zbtOzqsIp89KQ46JskEkvUHZuFMFlpl001PJETyk=;
	b=sJ7bUOwFmckDKA54NFnv0QgTbrtPGdkP30JCZgQKV2XzI0zBxHQID0AyN0j2S3sG+amo6enDINxktZ1EKSfa0ADj+80Wl0CG3hBTSasKp4ybVRmNT8bL85lnbotd/NdIao8+6SI5giPW3J0JImH/EWbdyNU6CF802wiXmbcFQrw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WyST6q8_1770107356 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Feb 2026 16:29:16 +0800
Message-ID: <1770107244.8746088-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3] virtio_ring: Add READ_ONCE annotations for device-writable fields
Date: Tue, 3 Feb 2026 16:27:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Alexander Graf <graf@amazon.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev (open list:VIRTIO CORE),
 linux-kernel@vger.kernel.org (open list),
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20260131102810.1254845-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260131102810.1254845-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Sat, 31 Jan 2026 11:28:09 +0100, Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:
> From: Alexander Graf <graf@amazon.com>
>
> KCSAN reports data races when accessing virtio ring fields that are
> concurrently written by the device (host). These are legitimate
> concurrent accesses where the CPU reads fields that the device updates
> via DMA-like mechanisms.
>
> Add accessor functions that use READ_ONCE() to properly annotate these
> device-writable fields and prevent compiler optimizations that could in
> theory break the code. This also serves as documentation showing which
> fields are shared with the device.
>
> The affected fields are:
> - Split ring: used->idx, used->ring[].id, used->ring[].len
> - Packed ring: desc[].flags, desc[].id, desc[].len
>
> This patch was partially written using the help of Kiro, an
> AI coding assistant, to automate the mechanical work of generating the
> inline function definition.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> [jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
> Co-developed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>
> ---
> Changes to v2:
> - Add AI statement (agraf)
> - Add R-b from agraf
> - Update comment (mst)
> - Add split to function names handling split rings (mst)
> - Add vring_read_split_avail_event() (mst)
>
> Changes to v1:
> - Updated comments (mst, agraf)
> - Moved _read suffix to prefix in newly introduced functions (mst)
> - Update my minor contribution to Co-developed-by (agraf)
> - Add "in theory" to changelog
> ---
>  drivers/virtio/virtio_ring.c | 72 +++++++++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ddab68959671..53d5334576bc 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -222,6 +222,55 @@ struct vring_virtqueue {
>  #endif
>  };
>
> +/*
> + * Accessors for device-writable fields in virtio rings.
> + * These fields are concurrently written by the device and read by the driver.
> + * Use READ_ONCE() to prevent compiler optimizations, document the
> + * intentional data race and prevent KCSAN warnings.
> + */
> +static inline u16 vring_read_split_used_idx(const struct vring_virtqueue *vq)

"inline" is not recommended in *.c files.

Ohters LGTM.

Thanks.


> +{
> +	return virtio16_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->idx));
> +}
> +
> +static inline u32 vring_read_split_used_id(const struct vring_virtqueue *vq,
> +					   u16 idx)
> +{
> +	return virtio32_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->ring[idx].id));
> +}
> +
> +static inline u32 vring_read_split_used_len(const struct vring_virtqueue *vq, u16 idx)
> +{
> +	return virtio32_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->ring[idx].len));
> +}
> +
> +static inline u16 vring_read_split_avail_event(const struct vring_virtqueue *vq)
> +{
> +	return virtio16_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vring_avail_event(&vq->split.vring)));
> +}
> +
> +static inline u16 vring_read_packed_desc_flags(const struct vring_virtqueue *vq,
> +					       u16 idx)
> +{
> +	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].flags));
> +}
> +
> +static inline u16 vring_read_packed_desc_id(const struct vring_virtqueue *vq,
> +				            u16 idx)
> +{
> +	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].id));
> +}
> +
> +static inline u32 vring_read_packed_desc_len(const struct vring_virtqueue *vq,
> +				             u16 idx)
> +{
> +	return le32_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].len));
> +}
> +
>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
>  static void vring_free(struct virtqueue *_vq);
>
> @@ -736,8 +785,7 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>  	LAST_ADD_TIME_INVALID(vq);
>
>  	if (vq->event) {
> -		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
> -					vring_avail_event(&vq->split.vring)),
> +		needs_kick = vring_need_event(vring_read_split_avail_event(vq),
>  					      new, old);
>  	} else {
>  		needs_kick = !(vq->split.vring.used->flags &
> @@ -808,8 +856,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>
>  static bool more_used_split(const struct vring_virtqueue *vq)
>  {
> -	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
> -			vq->split.vring.used->idx);
> +	return vq->last_used_idx != vring_read_split_used_idx(vq);
>  }
>
>  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> @@ -838,10 +885,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	virtio_rmb(vq->weak_barriers);
>
>  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev,
> -			vq->split.vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev,
> -			vq->split.vring.used->ring[last_used].len);
> +	i = vring_read_split_used_id(vq, last_used);
> +	*len = vring_read_split_used_len(vq, last_used);
>
>  	if (unlikely(i >= vq->split.vring.num)) {
>  		BAD_RING(vq, "id %u out of range\n", i);
> @@ -923,8 +968,7 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_i
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>
> -	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
> -			vq->split.vring.used->idx);
> +	return (u16)last_used_idx != vring_read_split_used_idx(vq);
>  }
>
>  static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> @@ -1701,10 +1745,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  				       u16 idx, bool used_wrap_counter)
>  {
> -	bool avail, used;
>  	u16 flags;
> +	bool avail, used;
>
> -	flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
> +	flags = vring_read_packed_desc_flags(vq, idx);
>  	avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
>  	used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
>
> @@ -1751,8 +1795,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	last_used_idx = READ_ONCE(vq->last_used_idx);
>  	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
>  	last_used = packed_last_used(last_used_idx);
> -	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
> -	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
> +	id = vring_read_packed_desc_id(vq, last_used);
> +	*len = vring_read_packed_desc_len(vq, last_used);
>
>  	if (unlikely(id >= vq->packed.vring.num)) {
>  		BAD_RING(vq, "id %u out of range\n", id);
> --
> 2.52.0
>
