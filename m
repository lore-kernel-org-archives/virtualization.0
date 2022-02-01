Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C4AC433EF
	for <virtualization@archiver.kernel.org>; Tue,  1 Feb 2022 18:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9984B40240;
	Tue,  1 Feb 2022 18:27:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GZhdfKTJ5gBQ; Tue,  1 Feb 2022 18:27:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E820401DD;
	Tue,  1 Feb 2022 18:27:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DB85C0011;
	Tue,  1 Feb 2022 18:27:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB98DC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 18:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94872401DD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 18:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hQ2yXRxKsKdj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 18:27:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EF8E400C4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643740067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZNaYTZmYX8SAV2IvxTXhkNs0jj6KRq86m7Q14LMjvE=;
 b=cfcgZZ5QoWr3ERX6OXl2YACg4rQZ8b6eGByzSe+csNMLay5EDmd2oqfhxVuX7Vh6SmMyeb
 0QSYIDFc67jSTNQWQD2PyOeAoo4RdOFyzebx6zhQddJeY0/l4zojaf5lu8wPmx3vDjj06T
 uKQQbCc8aGC3Cm5SiDwPSjD1XnENaVQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-owtqYIE6M2u7Qqv0Pt_H7Q-1; Tue, 01 Feb 2022 13:27:46 -0500
X-MC-Unique: owtqYIE6M2u7Qqv0Pt_H7Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 bg32-20020a05600c3ca000b00349f2aca1beso1294248wmb.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Feb 2022 10:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CZNaYTZmYX8SAV2IvxTXhkNs0jj6KRq86m7Q14LMjvE=;
 b=TdDIaIiuST/TJHhCIgo1fgBln+aKhTtD5pv6QQCj4BlPi6id3zaJn/VAJndc1pwUiC
 OQLK6ouYCkw0j73NAcAfOwU8R9MsZ6xpt9RmixwdYEozx5Z12BmiQyXoVCxwAOjcyx/d
 +eA/uO2YO1eGpehIo4HPFPX0GjeT8UzaOZFgEZweFk6R3R2JQ4Z08aG+9Z9K+J7gRYtN
 LOV2BgDqzTgTNtTl2eNcQrl7kPx2CnwwKkwbQp0ViAZ7jt1Wqz8GBh5SSKb2fFB87t7e
 q19wDFZQiNHgUNv2LQd2YbvZEoofYKQxe9qQ6sYhA0LIwjV3tHEQ3w6iNtgkom2QLqKJ
 4cJQ==
X-Gm-Message-State: AOAM531JfsadOL4UEiB64yQrSdJmH/TSCChEp10b973/I0IjifqhyL/4
 Hdxp/g26rosCl1AKPTIp7oMoNfxAoS4fEB5i5lcaYS0o0RhQ/hm1yruiy3sFNoq2XwAZNFqCmzm
 aLI+cK68E+lPEYXFjqMMjFpqJC+0FYRo0J/QfVgAcNA==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr22607762wrv.188.1643740065030; 
 Tue, 01 Feb 2022 10:27:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoRnz9FX5T4stkcbEepAQH0Vaob3Ap3Q0yHX7Zr0nuN2RMKU9RMxJWLUqZMqXyQ2okix3BMQ==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr22607734wrv.188.1643740064752; 
 Tue, 01 Feb 2022 10:27:44 -0800 (PST)
Received: from redhat.com ([2.55.147.35])
 by smtp.gmail.com with ESMTPSA id m64sm2760020wmm.31.2022.02.01.10.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 10:27:44 -0800 (PST)
Date: Tue, 1 Feb 2022 13:27:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v2 3/9] [RFC] virtio_ring: Embed a wrap counter in opaque
 poll index value
Message-ID: <20220201131434-mutt-send-email-mst@kernel.org>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
 <20220201171601.53316-4-cristian.marussi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20220201171601.53316-4-cristian.marussi@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: f.fainelli@gmail.com, vincent.guittot@linaro.org,
 igor.skalkin@opensynergy.com, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 peter.hilber@opensynergy.com, james.quinlan@broadcom.com,
 Jonathan.Cameron@huawei.com, souvik.chakravarty@arm.com,
 etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org
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

Looks correct, thanks. Some minor comments below:

On Tue, Feb 01, 2022 at 05:15:55PM +0000, Cristian Marussi wrote:
> Exported API virtqueue_poll() can be used to support polling mode operation
> on top of virtio layer if needed; currently the parameter last_used_idx is
> the opaque value that needs to be passed to the virtqueue_poll() function
> to check if there are new pending used buffers in the queue: such opaque
> value would have been previously obtained by a call to the API function
> virtqueue_enable_cb_prepare().
> 
> Since such opaque value is indeed containing simply a snapshot in time of
> the internal

to add: 16 bit

> last_used_index (roughly), it is possible that,

to add here: 

if another thread calls virtqueue_add_*()
at the same time (which existing drivers don't do,
but does not seem to be documented as prohibited anywhere), and

> if exactly
> 2**16 buffers are marked as used between two successive calls to
> virtqueue_poll(), the caller is fooled into thinking that nothing is
> pending (ABA problem).
> Keep a full fledged internal wraps counter

s/full fledged/a 16 bit/

since I don't see why is a 16 bit counter full but not e.g. a 32 bit one

> per virtqueue and embed it into
> the upper 16bits of the returned opaque value, so that the above scenario
> can be detected transparently by virtqueue_poll(): this way each single
> possible last_used_idx value is really belonging to a different wrap.

Just to add here: the ABA problem can in theory still happen but
now that's after 2^32 requests, which seems sufficient in practice.

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Still no perf data on this, I was wondering what exactly to measure in
> term of perf metrics to evaluate the impact of the rolling vq->wraps
> counter.
> ---
>  drivers/virtio/virtio_ring.c | 51 +++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..613ec0503509 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -12,6 +12,8 @@
>  #include <linux/hrtimer.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/spinlock.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <xen/xen.h>
>  
>  static bool force_used_validation = false;
> @@ -69,6 +71,17 @@ module_param(force_used_validation, bool, 0444);
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>  
> +#define VRING_IDX_MASK					GENMASK(15, 0)
> +#define VRING_GET_IDX(opaque)				\
> +	((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
> +
> +#define VRING_WRAPS_MASK				GENMASK(31, 16)
> +#define VRING_GET_WRAPS(opaque)				\
> +	((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
> +
> +#define VRING_BUILD_OPAQUE(idx, wraps)			\
> +	(FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
> +

Maybe prefix with VRING_POLL_  since that is the only user.


>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> @@ -117,6 +130,8 @@ struct vring_virtqueue {
>  	/* Last used index we've seen. */
>  	u16 last_used_idx;
>  
> +	u16 wraps;
> +
>  	/* Hint for event idx: already triggered no need to disable. */
>  	bool event_triggered;
>  
> @@ -806,6 +821,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	ret = vq->split.desc_state[i].data;
>  	detach_buf_split(vq, i, ctx);
>  	vq->last_used_idx++;
> +	if (unlikely(!vq->last_used_idx))
> +		vq->wraps++;
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */

So most drivers don't call virtqueue_poll.
Concerned about the overhead here: another option is
with a flag that will have to be set whenever a driver
wants to use virtqueue_poll.
Could you pls do a quick perf test e.g. using tools/virtio/
to see what's faster?



> @@ -1508,6 +1525,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
>  		vq->last_used_idx -= vq->packed.vring.num;
>  		vq->packed.used_wrap_counter ^= 1;
> +		vq->wraps++;
>  	}
>  
>  	/*
> @@ -1744,6 +1762,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->wraps = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->packed_ring = true;
> @@ -2092,13 +2111,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>   */
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
> +	unsigned int last_used_idx;
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> -				 virtqueue_enable_cb_prepare_split(_vq);
> +	last_used_idx = vq->packed_ring ?
> +			virtqueue_enable_cb_prepare_packed(_vq) :
> +			virtqueue_enable_cb_prepare_split(_vq);
> +
> +	return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2107,6 +2130,21 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>   * @_vq: the struct virtqueue we're talking about.
>   * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
>   *
> + * The provided last_used_idx, as returned by virtqueue_enable_cb_prepare(),
> + * is an opaque value representing the queue state and it is built as follows:
> + *
> + *	---------------------------------------------------------
> + *	|	vq->wraps	|	vq->last_used_idx	|
> + *	31------------------------------------------------------0
> + *
> + * The MSB 16bits embedding the wraps counter for the underlying virtqueue
> + * is stripped out here before reaching into the lower layer helpers.
> + *
> + * This structure of the opaque value mitigates the scenario in which, when
> + * exactly 2**16 messages are marked as used between two successive calls to
> + * virtqueue_poll(), the caller is fooled into thinking nothing new has arrived
> + * since the pure last_used_idx is exactly the same.
> + *

Do you want to move this comment to where the macros implementing it
are?

>   * Returns "true" if there are pending used buffers in the queue.
>   *
>   * This does not need to be serialized.
> @@ -2118,9 +2156,13 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>  	if (unlikely(vq->broken))
>  		return false;
>  
> +	if (unlikely(vq->wraps != VRING_GET_WRAPS(last_used_idx)))
> +		return true;
> +
>  	virtio_mb(vq->weak_barriers);
> -	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
> -				 virtqueue_poll_split(_vq, last_used_idx);
> +	return vq->packed_ring ?
> +		virtqueue_poll_packed(_vq, VRING_GET_IDX(last_used_idx)) :
> +			virtqueue_poll_split(_vq, VRING_GET_IDX(last_used_idx));
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -2245,6 +2287,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->wraps = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
