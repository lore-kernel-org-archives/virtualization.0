Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB1BC6FD18
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 11:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CDED41CF6;
	Wed, 29 Mar 2023 11:47:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CDED41CF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TIvaOSoOCVEK; Wed, 29 Mar 2023 11:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 999ED40558;
	Wed, 29 Mar 2023 11:47:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 999ED40558
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E70EC007A;
	Wed, 29 Mar 2023 11:47:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6902C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A287140558
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:47:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A287140558
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oii1Lwf0jRTs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:47:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EBF98400D7
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBF98400D7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:47:34 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VewkDRj_1680090447; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VewkDRj_1680090447) by smtp.aliyun-inc.com;
 Wed, 29 Mar 2023 19:47:28 +0800
Message-ID: <1680090301.6450636-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4] virtio_ring: interrupt disable flag updated to vq even
 with event_triggered is set
Date: Wed, 29 Mar 2023 19:45:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Albert Huang <huangjie.albert@bytedance.com>
References: <20230329102300.61000-1-huangjie.albert@bytedance.com>
In-Reply-To: <20230329102300.61000-1-huangjie.albert@bytedance.com>
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 29 Mar 2023 18:23:00 +0800, Albert Huang <huangjie.albert@bytedance.com> wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false. Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.
>
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
>
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This bring more interruptions.
>
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
>
> To fix:
> update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE to vq
> when we call virtqueue_disable_cb even the event_triggered is set to true.
>
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
>
> v2->v3:
> -update the interrupt disable flag even with the event_triggered is set,
> -instead of checking whether event_triggered is set in
> -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which have
> -not called virtqueue_{enable/disable}_cb to miss notifications.
>
> v3->v4:
> -remove change for
> -"if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)"
> -in virtqueue_disable_cb_packed
>
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")

Hi Michael,

I want to know what the purpose of this patch("virtio: fix up virtio_disable_cb")
is. I re-review this patch. I didn't understand what the purpose of this
patches. Does it reduce one write to vring_used_event(&vq->split.vring) ?

Thanks.


> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..ec7ab8e04846 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -931,6 +931,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +
> +		/*
> +		 * If device triggered an event already it won't trigger one again:
> +		 * no need to disable.
> +		 */
> +		if (vq->event_triggered)
> +			return;
> +
>  		if (vq->event)
>  			/* TODO: this is a hack. Figure out a cleaner value to write. */
>  			vring_used_event(&vq->split.vring) = 0x0;
> @@ -1761,6 +1769,14 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>
>  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> +
> +		/*
> +		 * If device triggered an event already it won't trigger one again:
> +		 * no need to disable.
> +		 */
> +		if (vq->event_triggered)
> +			return;
> +
>  		vq->packed.vring.driver->flags =
>  			cpu_to_le16(vq->packed.event_flags_shadow);
>  	}
> @@ -2462,12 +2478,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>
> -	/* If device triggered an event already it won't trigger one again:
> -	 * no need to disable.
> -	 */
> -	if (vq->event_triggered)
> -		return;
> -
>  	if (vq->packed_ring)
>  		virtqueue_disable_cb_packed(_vq);
>  	else
> --
> 2.20.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
