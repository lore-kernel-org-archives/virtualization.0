Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4516DCDB47E
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 09:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF0427047E;
	Fri, 20 Oct 2023 09:35:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF0427047E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1VQJ7yqy9lg; Fri, 20 Oct 2023 09:35:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6207B7047D;
	Fri, 20 Oct 2023 09:35:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6207B7047D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C77FC0039;
	Fri, 20 Oct 2023 09:35:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9A9EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6E3040253
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:35:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6E3040253
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 67-XoZ2OiTtU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:35:24 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FFA942C57
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:35:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FFA942C57
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0VuWtWLk_1697794515; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuWtWLk_1697794515) by smtp.aliyun-inc.com;
 Fri, 20 Oct 2023 17:35:16 +0800
Message-ID: <1697794128.4297402-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Date: Fri, 20 Oct 2023 17:28:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Su Hui <suhui@nfschina.com>
References: <20231020092320.209234-1-suhui@nfschina.com>
In-Reply-To: <20231020092320.209234-1-suhui@nfschina.com>
Cc: Su Hui <suhui@nfschina.com>, mst@redhat.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
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

If any error happens, this function should restore to the old status.

So, whether the err is true, we should goto the virtqueue_enable_after_reset().

If the err is true, that mean the resize new quuee failed, but the queue
status has restored to the old status.

We should ignore the return value of the virtuqueue_resize_xxx().

Do you find other error in the virtuqueue_resize_xxx().

Thanks.


On Fri, 20 Oct 2023 17:23:21 +0800, Su Hui <suhui@nfschina.com> wrote:
> virtqueue_resize_packed() or virtqueue_resize_split() can return
> error code if failed, so add a check for this.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>
> I'm not sure that return directly is right or not,
> maybe there are some process should do before return.
>
>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..cf662c3a755b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	else
>  		err = virtqueue_resize_split(_vq, num);
>
> +	if (err)
> +		return err;
> +
>  	return virtqueue_enable_after_reset(_vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
