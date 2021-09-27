Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E728CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 11:34:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9069F60F6B
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 11:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9069F60F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BA22404F1;
	Mon, 27 Sep 2021 11:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L-D997JfEY2D; Mon, 27 Sep 2021 11:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03D7C404BC;
	Mon, 27 Sep 2021 11:34:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBCFEC0011;
	Mon, 27 Sep 2021 11:34:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5133BC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 11:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 338AA80EAF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 11:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8o_tdRz7L10q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 11:34:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE76080EAA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 11:34:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0C2660F0F;
 Mon, 27 Sep 2021 11:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632742454;
 bh=6UbwnYpNicjR1JStRo8iJiVRLVMUG38adSoFtPPxBW0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S0Bg5z5sLPjWjfXYHLabHfbBe2KozrkiecXTq752fNuPKu8VKs/Rt58LeqY0p6JZe
 CQETOP+ZW9m46ko74rb0QsJeKQ+6gG8R1VdtEqVK8+/06V5Z6ydgLEY42Ug/83//Ak
 kWy54QBu8EqDdUN3n2yCJygyB+e8s1PNGqhzYHZsUIv+du4qn6BhkCjfavcJYEXcjp
 FyzOGwUqK0gyGChRIo2f3sraqcoWfWnby/gPMXU1qw1x9Ebs+Q7bD3wQn/dqL2OY5y
 M8wp94XZsHuImJayX1xZ6+5Jmf/HCH7b6WX/bXBEdqgBK5Mkl2q6cdG7hcqZWnqaVE
 ZJoo7HtGT700A==
Date: Mon, 27 Sep 2021 14:34:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-blk: set NUMA affinity for a tagset
Message-ID: <YVGsMsIjD2+aS3eC@unreal>
References: <20210926145518.64164-1-mgurtovoy@nvidia.com>
 <20210926145518.64164-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210926145518.64164-2-mgurtovoy@nvidia.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 mst@redhat.com, israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, stefanha@redhat.com, oren@nvidia.com
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

On Sun, Sep 26, 2021 at 05:55:18PM +0300, Max Gurtovoy wrote:
> To optimize performance, set the affinity of the block device tagset
> according to the virtio device affinity.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9b3bd083b411..1c68c3e0ebf9 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -774,7 +774,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
>  	vblk->tag_set.ops = &virtio_mq_ops;
>  	vblk->tag_set.queue_depth = queue_depth;
> -	vblk->tag_set.numa_node = NUMA_NO_NODE;
> +	vblk->tag_set.numa_node = virtio_dev_to_node(vdev);

I afraid that by doing it, you will increase chances to see OOM, because
in NUMA_NO_NODE, MM will try allocate memory in whole system, while in
the latter mode only on specific NUMA which can be depleted.

Thanks

>  	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>  	vblk->tag_set.cmd_size =
>  		sizeof(struct virtblk_req) +
> -- 
> 2.18.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
