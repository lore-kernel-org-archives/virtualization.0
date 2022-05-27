Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D179C433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 07:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0F10427F9;
	Fri, 27 May 2022 07:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tYq17K7PcgfE; Fri, 27 May 2022 07:29:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2521742811;
	Fri, 27 May 2022 07:29:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDCF6C0039;
	Fri, 27 May 2022 07:29:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56156C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4371542811
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1t68QQvxSg1i
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:29:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7860427F9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:29:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0VEW4LRq_1653636588; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VEW4LRq_1653636588) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 May 2022 15:29:49 +0800
Message-ID: <1653636572.3092504-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 1/9] virtio: use virtio_device_ready() in
 virtio_device_restore()
Date: Fri, 27 May 2022 15:29:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-2-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-2-jasowang@redhat.com>
Cc: linux-s390@vger.kernel.org, lulu@redhat.com, paulmck@kernel.org,
 mst@redhat.com, peterz@infradead.org, maz@kernel.org, cohuck@redhat.com,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 eperezma@redhat.com, Vineeth Vijayan <vneethv@linux.ibm.com>,
 tglx@linutronix.de, linux-kernel@vger.kernel.org
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

On Fri, 27 May 2022 14:01:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> It will allow us to do extension on virtio_device_ready() without
> duplicating code.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index ce424c16997d..938e975029d4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
>  			goto err;
>  	}
>
> -	/* Finally, tell the device we're all set */
> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
> +	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		virtio_device_ready(dev);
>
>  	virtio_config_enable(dev);
>
> --
> 2.25.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
