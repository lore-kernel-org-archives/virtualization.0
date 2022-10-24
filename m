Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EDEC38A2D
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 11:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB71F40567;
	Mon, 24 Oct 2022 11:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB71F40567
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uNWp-tI8xSlw; Mon, 24 Oct 2022 11:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5AE3040531;
	Mon, 24 Oct 2022 11:34:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AE3040531
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37BC8C0032;
	Mon, 24 Oct 2022 11:34:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C027C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 11:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEE0E60B55
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 11:33:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEE0E60B55
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id miBNn5JYdtEM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 11:33:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F8BF60B4D
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F8BF60B4D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 11:33:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VSyOrxW_1666611231; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VSyOrxW_1666611231) by smtp.aliyun-inc.com;
 Mon, 24 Oct 2022 19:33:52 +0800
Message-ID: <1666611221.6163745-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtio_ring: use helper function is_power_of_2()
Date: Mon, 24 Oct 2022 19:33:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: shaoqin.huang@intel.com
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
 <20221021062734.228881-3-shaoqin.huang@intel.com>
In-Reply-To: <20221021062734.228881-3-shaoqin.huang@intel.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
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

On Thu, 20 Oct 2022 23:27:34 -0700, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
>
> Use helper function is_power_of_2() to check if num is power of two.
> Minor readability improvement.
>
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2e7689bb933b..723c4e29e1d3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1052,7 +1052,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	dma_addr_t dma_addr;
>
>  	/* We assume num is a power of 2. */
> -	if (num & (num - 1)) {
> +	if (!is_power_of_2(num)) {
>  		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
>  		return -EINVAL;
>  	}
> --
> 2.34.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
