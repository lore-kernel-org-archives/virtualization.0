Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24974C77B6C
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 07:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8969F60FB7;
	Thu, 13 Apr 2023 07:31:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8969F60FB7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fgHKAWmbztWw; Thu, 13 Apr 2023 07:31:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CEFFB606A9;
	Thu, 13 Apr 2023 07:31:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEFFB606A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B43BDC0036;
	Thu, 13 Apr 2023 07:31:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3AE9C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAE8041EEF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:31:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAE8041EEF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZJdTZ9Hm8rV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:31:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9EEF41EB5
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9EEF41EB5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:31:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R421e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0Vg-SPvB_1681371070; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vg-SPvB_1681371070) by smtp.aliyun-inc.com;
 Thu, 13 Apr 2023 15:31:11 +0800
Message-ID: <1681370820.0675354-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy waiting
 for cvq command
Date: Thu, 13 Apr 2023 15:27:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-3-jasowang@redhat.com>
In-Reply-To: <20230413064027.13267-3-jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, david.marchand@redhat.com, davem@davemloft.net
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

On Thu, 13 Apr 2023 14:40:27 +0800, Jason Wang <jasowang@redhat.com> wrote:
> We used to busy waiting on the cvq command this tends to be
> problematic since there no way for to schedule another process which
> may serve for the control virtqueue. This might be the case when the
> control virtqueue is emulated by software. This patch switches to use
> completion to allow the CPU to sleep instead of busy waiting for the
> cvq command.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - use completion for simplicity
> - don't try to harden the CVQ command which requires more thought
> Changes since RFC:
> - break the device when timeout
> - get buffer manually since the virtio core check more_used() instead
> ---
>  drivers/net/virtio_net.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2e56bbf86894..d3eb8fd6c9dc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -19,6 +19,7 @@
>  #include <linux/average.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> +#include <linux/completion.h>
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> @@ -295,6 +296,8 @@ struct virtnet_info {
>
>  	/* failover when STANDBY feature enabled */
>  	struct failover *failover;
> +
> +	struct completion completion;
>  };
>
>  struct padded_vnet_hdr {
> @@ -1709,6 +1712,13 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>  	return !oom;
>  }
>
> +static void virtnet_cvq_done(struct virtqueue *cvq)
> +{
> +	struct virtnet_info *vi = cvq->vdev->priv;
> +
> +	complete(&vi->completion);
> +}
> +
>  static void skb_recv_done(struct virtqueue *rvq)
>  {
>  	struct virtnet_info *vi = rvq->vdev->priv;
> @@ -2169,12 +2179,8 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  	if (unlikely(!virtqueue_kick(vi->cvq)))
>  		return vi->ctrl->status == VIRTIO_NET_OK;
>
> -	/* Spin for a response, the kick causes an ioport write, trapping
> -	 * into the hypervisor, so the request should be handled immediately.
> -	 */
> -	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq))
> -		cpu_relax();
> +	wait_for_completion(&vi->completion);
> +	virtqueue_get_buf(vi->cvq, &tmp);
>
>  	return vi->ctrl->status == VIRTIO_NET_OK;
>  }
> @@ -3672,7 +3678,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
> -		callbacks[total_vqs - 1] = NULL;
> +		callbacks[total_vqs - 1] = virtnet_cvq_done;

This depends the interrupt, right?

I worry that there may be some devices that may not support interruption on cvq.
Although this may not be in line with SPEC, it may cause problem on the devices
that can work normally at present.

Thanks.


>  		names[total_vqs - 1] = "control";
>  	}
>
> @@ -4122,6 +4128,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>
> +	init_completion(&vi->completion);
>  	enable_rx_mode_work(vi);
>
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
> --
> 2.25.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
