Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B419ECAAA1
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 11:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC7DC40302;
	Mon, 24 Oct 2022 11:33:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC7DC40302
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5ULweUj6iQN; Mon, 24 Oct 2022 11:33:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 13390402F8;
	Mon, 24 Oct 2022 11:33:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13390402F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8A3AC0032;
	Mon, 24 Oct 2022 11:33:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E838C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 11:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 437A860B33
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 11:33:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 437A860B33
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q6zZ7J8GUd3q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 11:33:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 546DC6059C
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 546DC6059C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 11:33:38 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R971e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VSyvVWN_1666611213; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VSyvVWN_1666611213) by smtp.aliyun-inc.com;
 Mon, 24 Oct 2022 19:33:34 +0800
Message-ID: <1666611190.2063382-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: use helper function is_power_of_2()
Date: Mon, 24 Oct 2022 19:33:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: shaoqin.huang@intel.com
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
 <20221021062734.228881-2-shaoqin.huang@intel.com>
In-Reply-To: <20221021062734.228881-2-shaoqin.huang@intel.com>
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

On Thu, 20 Oct 2022 23:27:33 -0700, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
>
> Use helper function is_power_of_2() to check if num is power of two.
> Minor readability improvement.
>
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_pci_modern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index c3b9f2761849..207294bd7b9d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -310,7 +310,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	if (!num || vp_modern_get_queue_enable(mdev, index))
>  		return ERR_PTR(-ENOENT);
>
> -	if (num & (num - 1)) {
> +	if (!is_power_of_2(num)) {
>  		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
>  		return ERR_PTR(-EINVAL);
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
