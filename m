Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030405;
	b=wCyzKcof/F5XSuPwe7LuvBiB1inusjEy9kfjBnlMkUR0+6bmWmy2GwnZT83ARNeNIk+U
	 J3fCoTx4nkguwQWDh+6T2vup0ukuYskPnqAOla9fzm0ZL0ZByHStzBrMJXHZ3OduwhuqC
	 KUfpgkmK4kiZ6I06F9MMHJUGLAlh8dhuVzPV3kRsnHv3wioL8hcUtWA6yJ2w6C3kHXeDN
	 lQMzC1bK/LlCf8ZIWynVlzLiAmtWOJc+w0v7RMMK0W3Is1Z9VzoHNDt/kwGYEqlGXfOsO
	 pLGRAldqtFJFQYcH8wuZXhh8LwWcpMNztHyCowQTdutTKI6CvsVUenEU4hohl/4cUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030405;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=c2WuH6kPMXMbpt315DBFCc0jlTBpS0O6mr9XG8/O1sU=;
	b=VkC/yVbgzWTFd7UjTm4r69YxafALvfUBSCtM4W12S7Bx6QXLzZWX9gJbQ70WGbYj/4Bn
	 pZBO1mC5J9r83mDBvIUQfQWiMVD8Z3fRPBoh8/hZfPp6jGe5m8ZUKiCQQHUUJX0yGR1q9
	 i9czQ2uzY222gLSjVP6MhDQ0SVzE97k773E/RhdG1wt16qmjIiq1T9E1PLW1Tf7AWd0Px
	 J/sAYxCQfNQPEz+FRXCKJBf3cfmlwetrJIZn24KhcXd+SKDMiEfrhqimpTISxAN2TETW6
	 xiGQ6e4eTnCThwxMyYaMdSU9G61XXGsKAWKfpK9M5cayaF0poXDuqcIUcyhjTz81N9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h5LBXxX6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0E606A31F
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 16:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C0E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h5LBXxX6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793030403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2WuH6kPMXMbpt315DBFCc0jlTBpS0O6mr9XG8/O1sU=;
	b=h5LBXxX6qRlVNQqj5TWfrp3IAJZiga4ge8TDDGO0HOWH7pNWKjAwHJqvO6vQXYY9Hr66KG
	lzuboytpACvZyt8L0ozhttAV9f/Dtj+Vxk6foJViki//pgVFN5qsP2rkRHftOcoFtyIPBB
	bEQzDydnDwn0xSPDqh2Tlhfa3/dfu1s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-2kSp1B2cNhC350pDXcDneg-1; Mon, 26 Oct 2026 12:00:02 -0400
X-MC-Unique: 2kSp1B2cNhC350pDXcDneg-1
X-Mimecast-MFC-AGG-ID: 2kSp1B2cNhC350pDXcDneg_1793030401
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48df5b058ddso2241834f8f.0
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030401; x=1793635201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c2WuH6kPMXMbpt315DBFCc0jlTBpS0O6mr9XG8/O1sU=;
        b=nlQDciYm+upYKGGDcv/OodN8ohPby3UYb98ktsvmO1tsfYdCQRYopJ29R0+DyxVsbV
         dNhbEk4uEJH+VA3RXLrWOVMJh7qdAGAIGVZNjosXMu5QzAmk27d8E1TTNohQfofgC4Q1
         t0VTt5g7dMMNNPBr1m5hVRCAeaHflpx4XFz4O1oHAoXLFKeLmF5Oyq/Ftgph0MApGJR0
         GdYfwXW1Vs6FsYeoxlvEsqhhajulD17kKQGikq0nQ9Q1IITnsT3iRgiU0SoI3IuJAbCG
         EyVOoEINDv5PVQzKiozymBFHxDgaMJ6XGCHuRNtWEncGSBc/cyeDo9iu8RKNT/hmJg4x
         W4ZA==
X-Gm-Message-State: AFq9FYI0g++Jn5sVo99ttQpT88szXmdLK1V9u3yI1LO2SKzR9stZvgCg
	Et0c1pE+HLRUDXJgaiChrOZU0quJ1RcTsQaSKMXDbW9Gn2ho//OhbBCopTDXVlMTSL5H5MQWzNb
	SUDrAxAPogE0zgx35UwLj/zfftbpC8ED5vbSXyq4ejZv2tCgQQSg7npPOotMl9PLu06Z6
X-Gm-Gg: AYBFou1gRGmC44/9hC3j6EJnxi95kcp5OVv86VJ36BdXUOkWqK66i1W1o8gTzLbGkJi
	+XzpYIA2L7e/cfhmwkVaAJ90rxrffrA7SIewNcCjCct6x6Pix//3Lw66rUYnCiGM284uRcfQeyH
	jTBc757MY4oI9jkL1Px+uOHp1RYKlHDohxBJ02hCi176ioqdPDU+kHCg9OpgmcTExVil5C/fXWn
	Gyo30fFwfzEm2FStk69UeuYrryVEfstnu4xHI8k/ikB42+/H5/R2K2D/9UjBy7dpO/WT2HifpEz
	QoUKjztejNFCnzLrdmUyR4NCX7GPlFyuOomM4gAwcBK9e/+OcJexTjKTOaKimnXLurk=
X-Received: by 2002:a05:6000:4a0a:b0:48d:de0f:b79 with SMTP id ffacd0b85a97d-48e3eac8e4bmr14090331f8f.0.1793030400906;
        Mon, 26 Oct 2026 09:00:00 -0700 (PDT)
X-Received: by 2002:a05:6000:4a0a:b0:48d:de0f:b79 with SMTP id ffacd0b85a97d-48e3eac8e4bmr14090282f8f.0.1793030400293;
        Mon, 26 Oct 2026 09:00:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3cfasm17417900f8f.17.2026.10.26.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:59:59 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:59:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH 1/2] virtio_ring: add virtqueue_enable_cb_delayed_max
Message-ID: <20261026115933-mutt-send-email-mst@kernel.org>
References: <ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com>
 <sashiko-outbox-185433@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-185433@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A67FOx-B1Wyvtq3pIblkNDkpoa6IguC2Vz-edc6Qexs_1793030401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 26, 2026 at 03:24:23PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] virtio_ring: off-by-one in virtqueue_enable_cb_delayed_max_split()
> - [High] virtio_ring: off-by-one in virtqueue_enable_cb_delayed_max_packed()
> - [High] virtio_ring: missing vq->broken check in virtqueue_enable_cb_delayed_max()
> - [Medium] virtio_ring: missing READ_ONCE() in virtqueue_enable_cb_delayed_max_split()
> --
> 
> commit f77f0cd19bbfba432c2d11a8e7e8a7c7597a610a
> Author: Michael S. Tsirkin <mst@redhat.com>
> 
> virtio_ring: add virtqueue_enable_cb_delayed_max
> 
> This commit introduces virtqueue_enable_cb_delayed_max(), which arms the
> virtqueue callback with the used event placed at the last currently queued
> buffer so that the device only notifies the driver once all queued buffers
> have been used.
> 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index db678f5a80e03..98b630fc6f8f6 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> [ ... ]
> > @@ -1165,6 +1166,42 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
> >  	return true;
> >  }
> >  
> > +static bool virtqueue_enable_cb_delayed_max_split(struct vring_virtqueue *vq)
> > +{
> > +	u16 bufs;
> > +
> > +	START_USE(vq);
> > +
> > +	/* We optimistically turn back on interrupts, then check if there was
> > +	 * more to do. */
> > +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> > +	 * either clear the flags bit or point the event index at the next
> > +	 * entry. Always update the event index to keep code simple. */
> > +	if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
> > +		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
> > +		if (!vq->event)
> > +			vq->split.vring.avail->flags =
> > +				cpu_to_virtio16(vq->vq.vdev,
> > +						vq->split.avail_flags_shadow);
> > +	}
> > +	/* Point the used event at the last queued buffer: the device
> > +	 * will only notify us once it has used everything. */
> > +	bufs = (u16)(vq->split.avail_idx_shadow - vq->last_used_idx);
> > +
> > +	virtio_store_mb(vq->weak_barriers,
> > +			&vring_used_event(&vq->split.vring),
> > +			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
> > +
> > +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
> > +						- vq->last_used_idx) > bufs)) {
> > +		END_USE(vq);
> > +		return false;
> > +	}
> 
> [Severity: High]
> Is there an off-by-one in how bufs and vring_used_event are computed in
> virtqueue_enable_cb_delayed_max_split()?

Ugh. I actually fixed it, but forgot to commit (
Will fix in v2.


> 
> Here bufs is set to (u16)(vq->split.avail_idx_shadow - vq->last_used_idx),
> so vq->last_used_idx + bufs equals vq->split.avail_idx_shadow. Per the
> virtio specification and vring_need_event():
> 
> include/uapi/linux/virtio_ring.h:vring_need_event() {
> 	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
> }
> 
> event_idx is 0-indexed and triggers a notification when used->idx (new_idx)
> transitions from event_idx to event_idx + 1 (for example,
> virtqueue_enable_cb_prepare_split() writes vq->last_used_idx + 0 to be
> notified when the first buffer is used and used->idx reaches
> vq->last_used_idx + 1). When the device consumes all queued buffers,
> used->idx advances to vq->split.avail_idx_shadow. With event_idx also set
> to vq->split.avail_idx_shadow, (u16)(new_idx - event_idx - 1) underflows to
> 0xffff, so vring_need_event() evaluates to false and the device never sends
> an interrupt when the batch finishes.
> 
> In addition, in the post-barrier race check:
> 
> 	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
> 						- vq->last_used_idx) > bufs)) {
> 
> because only bufs (avail_idx_shadow - last_used_idx) buffers have been made
> available to the device in total, (u16)(used->idx - vq->last_used_idx) can
> at most equal bufs when every queued buffer has been used and can never be
> strictly greater than bufs. Even if the device already consumed all queued
> buffers before vring_used_event or avail->flags was updated, this check
> always evaluates to false and virtqueue_enable_cb_delayed_max_split()
> returns true, causing callers to sleep forever waiting for a notification
> that will never arrive.
> 
> [Severity: Medium]
> Also in virtqueue_enable_cb_delayed_max_split(), should the read of
> vq->split.vring.used->idx use vring_read_split_used_idx(vq) instead of
> reading vq->split.vring.used->idx directly?
> 
> Commit 32fe1de5c124 ("virtio_ring: Add READ_ONCE annotations for
> device-writable fields") introduced vring_read_split_used_idx(vq) to wrap
> the lockless read of device-writable vq->split.vring.used->idx in
> READ_ONCE(), which is what virtqueue_enable_cb_delayed_split() uses:
> 
> drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed_split() {
>     ...
> 	if (unlikely((u16)(vring_read_split_used_idx(vq)
> 					- vq->last_used_idx) > bufs)) {
>     ...
> }
> 
> > +
> > +	END_USE(vq);
> > +	return true;
> > +}
> [ ... ]
> > @@ -2391,6 +2428,67 @@ static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
> >  	return true;
> >  }
> >  
> > +static bool virtqueue_enable_cb_delayed_max_packed(struct vring_virtqueue *vq)
> > +{
> > +	u16 used_idx, wrap_counter, last_used_idx;
> > +	u16 bufs;
> > +
> > +	START_USE(vq);
> > +
> > +	/*
> > +	 * We optimistically turn back on interrupts, then check if there was
> > +	 * more to do.
> > +	 */
> > +
> > +	if (vq->event) {
> > +		/* Point the event at the last queued buffer: the device
> > +		 * will only notify us once it has used everything. */
> > +		bufs = vq->packed.vring.num - vq->vq.num_free;
> > +		last_used_idx = READ_ONCE(vq->last_used_idx);
> > +		wrap_counter = packed_used_wrap_counter(last_used_idx);
> > +
> > +		used_idx = packed_last_used(last_used_idx) + bufs;
> > +		if (used_idx >= vq->packed.vring.num) {
> > +			used_idx -= vq->packed.vring.num;
> > +			wrap_counter ^= 1;
> > +		}
> > +
> > +		vq->packed.vring.driver->off_wrap = cpu_to_le16(used_idx |
> > +			(wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
> > +
> > +		/*
> > +		 * We need to update event offset and event wrap
> > +		 * counter first before updating event flags.
> > +		 */
> > +		virtio_wmb(vq->weak_barriers);
> > +	}
> > +
> > +	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DISABLE) {
> > +		vq->packed.event_flags_shadow = vq->event ?
> > +				VRING_PACKED_EVENT_FLAG_DESC :
> > +				VRING_PACKED_EVENT_FLAG_ENABLE;
> > +		vq->packed.vring.driver->flags =
> > +				cpu_to_le16(vq->packed.event_flags_shadow);
> > +	}
> > +
> > +	/*
> > +	 * We need to update event suppression structure first
> > +	 * before re-checking for more used buffers.
> > +	 */
> > +	virtio_mb(vq->weak_barriers);
> > +
> > +	last_used_idx = READ_ONCE(vq->last_used_idx);
> > +	wrap_counter = packed_used_wrap_counter(last_used_idx);
> > +	used_idx = packed_last_used(last_used_idx);
> > +	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> > +		END_USE(vq);
> > +		return false;
> > +	}
> 
> [Severity: High]
> Won't virtqueue_enable_cb_delayed_max_packed() also place driver->off_wrap
> one past the last queued descriptor and miss the completion interrupt?
> 
> When bufs = vq->packed.vring.num - vq->vq.num_free descriptors are queued,
> they occupy offsets 0 through bufs - 1 starting from
> packed_last_used(last_used_idx). Adding bufs to
> packed_last_used(last_used_idx) sets used_idx to vq->packed.next_avail_idx
> (with vq->packed.avail_wrap_counter), which is the next free descriptor
> slot that has not been made available to the device.
> 
> With VRING_PACKED_EVENT_FLAG_DESC, the device notifies the driver when it
> marks the descriptor at driver->off_wrap as used (for comparison,
> virtqueue_enable_cb_prepare_packed() sets driver->off_wrap to
> vq->last_used_idx, i.e. offset 0, to trigger when the first queued
> descriptor is used). Because no descriptor is queued at next_avail_idx (and
> if the last queued buffer is a multi-descriptor direct chain, the device
> writes the used completion to the head descriptor of that chain), the
> device stops at next_avail_idx without ever using the descriptor at
> driver->off_wrap.
> 
> When the post-barrier check then tests is_used_desc_packed() at
> packed_last_used(last_used_idx) and sees the first queued buffer is not yet
> used, virtqueue_enable_cb_delayed_max_packed() returns true and the caller
> sleeps forever waiting for an interrupt at next_avail_idx that never
> arrives.
> 
> > +
> > +	END_USE(vq);
> > +	return true;
> > +}
> [ ... ]
> > @@ -3278,6 +3380,29 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> >  
> > +/**
> > + * virtqueue_enable_cb_delayed_max - callback for all queued buffers
> > + * @_vq: the struct virtqueue we're talking about.
> > + *
> > + * Like virtqueue_enable_cb_delayed, but with VIRTIO_RING_F_EVENT_IDX
> > + * the used event is placed at the last currently queued buffer, so the
> > + * device only notifies us once it has used everything we queued.
> > + *
> > + * Returns "true" if the callback is armed and we can sleep waiting
> > + * for the notification, or "false" if some buffers were already used
> > + * and we should poll instead.
> > + */
> > +bool virtqueue_enable_cb_delayed_max(struct virtqueue *_vq)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	if (vq->event_triggered)
> > +		data_race(vq->event_triggered = false);
> > +
> > +	return VIRTQUEUE_CALL(vq, enable_cb_delayed_max);
> > +}
> 
> [Severity: High]
> Should virtqueue_enable_cb_delayed_max() check if (unlikely(vq->broken))
> and return true, matching virtqueue_enable_cb_delayed()?
> 
> Commit 0d0eff39ceb3 ("virtio_ring: fix infinite loop in
> virtnet_poll_cleantx when device is broken") added:
> 
> drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed() {
> 	struct vring_virtqueue *vq = to_vvq(_vq);
> 
> 	if (unlikely(vq->broken))
> 		return true;
>     ...
> }
> 
> because virtqueue_get_buf_ctx_split() and virtqueue_get_buf_ctx_packed()
> immediately return NULL when vq->broken is true without detaching buffers
> or advancing vq->last_used_idx. Without this check in
> virtqueue_enable_cb_delayed_max(), if vq->broken becomes true while used
> descriptors remain in the ring, a caller polling until
> virtqueue_enable_cb_delayed_max() returns true will spin forever because
> virtqueue_get_buf() returns NULL without advancing vq->last_used_idx while
> virtqueue_enable_cb_delayed_max() repeatedly returns false.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com?part=1

