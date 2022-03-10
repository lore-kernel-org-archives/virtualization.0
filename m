Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C42C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 15:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 148CE418F8;
	Thu, 10 Mar 2022 15:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hML0sLd7b0ry; Thu, 10 Mar 2022 15:21:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC6A3418FB;
	Thu, 10 Mar 2022 15:21:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB2BC001D;
	Thu, 10 Mar 2022 15:21:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF0AC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E82508471F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jrBWj5I9U-Ci
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:20:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 686278438F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:20:57 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V6pLINk_1646925654; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6pLINk_1646925654) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Mar 2022 23:20:54 +0800
Message-ID: <1646925615.2061906-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [bug report] virtio_net: support rx/tx queue reset
Date: Thu, 10 Mar 2022 23:20:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20220310151221.GA2212@kili>
In-Reply-To: <20220310151221.GA2212@kili>
Cc: virtualization@lists.linux-foundation.org
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



On Thu, 10 Mar 2022 18:12:21 +0300, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Xuan Zhuo,
>
> The patch 26ae35c46f93: "virtio_net: support rx/tx queue reset" from
> Mar 8, 2022, leads to the following Smatch static checker warning:

Yes, thanks to you, I also found this problem today.

>
> 	drivers/net/virtio_net.c:1410 virtnet_napi_tx_disable()
> 	warn: sleeping in atomic context
>
> drivers/net/virtio_net.c
>   1829        static int virtnet_tx_vq_reset(struct virtnet_info *vi,
>   1830                                       struct send_queue *sq, u32 ring_num)
>   1831        {
>   1832                struct netdev_queue *txq;
>   1833                int err, qindex;
>   1834
>   1835                qindex = sq - vi->sq;
>   1836
>   1837                txq = netdev_get_tx_queue(vi->dev, qindex);
>   1838                __netif_tx_lock_bh(txq);
>                       ^^^^^^^^^^^^^^^^^^^^^^^
> Disables preempt
>
>   1839
>   1840                /* stop tx queue and napi */
>   1841                netif_stop_subqueue(vi->dev, qindex);
>   1842                virtnet_napi_tx_disable(&sq->napi);
>                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> napi_disable() is a might_sleep() function.
>
>   1843
>   1844                __netif_tx_unlock_bh(txq);
>   1845
>   1846                /* reset the queue */
>   1847                err = virtio_reset_vq(sq->vq);
>   1848                if (err) {
>   1849                        netif_start_subqueue(vi->dev, qindex);
>   1850                        goto err;
>   1851                }
>
> regards,
> dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
