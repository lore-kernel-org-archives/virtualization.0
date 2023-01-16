Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581B4C3DA78
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 02:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC2A140106;
	Mon, 16 Jan 2023 02:29:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC2A140106
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0BpP5HWP9FRZ; Mon, 16 Jan 2023 02:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4D64A40492;
	Mon, 16 Jan 2023 02:29:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D64A40492
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DC28C0033;
	Mon, 16 Jan 2023 02:29:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D2F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 02:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4487460759
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 02:29:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4487460759
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-aPm8ZuB7aT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 02:29:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86E3460743
Received: from out30-6.freemail.mail.aliyun.com
 (out30-6.freemail.mail.aliyun.com [115.124.30.6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86E3460743
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 02:29:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VZbZNlw_1673836141; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VZbZNlw_1673836141) by smtp.aliyun-inc.com;
 Mon, 16 Jan 2023 10:29:02 +0800
Message-ID: <1673836131.7281802-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/2] virtio_net: Reuse buffer free function
Date: Mon, 16 Jan 2023 10:28:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
References: <20230113223619.162405-1-parav@nvidia.com>
 <20230113223619.162405-3-parav@nvidia.com>
In-Reply-To: <20230113223619.162405-3-parav@nvidia.com>
Cc: mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Sat, 14 Jan 2023 00:36:19 +0200, Parav Pandit <parav@nvidia.com> wrote:
> virtnet_rq_free_unused_buf() helper function to free the buffer
> already exists. Avoid code duplication by reusing existing function.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>


Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  drivers/net/virtio_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d45e140b6852..c1faaf11fbcd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1251,13 +1251,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(len < vi->hdr_len + ETH_ZLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
>  		dev->stats.rx_length_errors++;
> -		if (vi->mergeable_rx_bufs) {
> -			put_page(virt_to_head_page(buf));
> -		} else if (vi->big_packets) {
> -			give_pages(rq, buf);
> -		} else {
> -			put_page(virt_to_head_page(buf));
> -		}
> +		virtnet_rq_free_unused_buf(rq->vq, buf);
>  		return;
>  	}
>
> --
> 2.26.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
