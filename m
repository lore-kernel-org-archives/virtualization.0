Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4F5C433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 07:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16AD960B5B;
	Fri, 27 May 2022 07:49:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Qt7HbBN6BCL; Fri, 27 May 2022 07:49:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE88760B53;
	Fri, 27 May 2022 07:49:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4CB6C0039;
	Fri, 27 May 2022 07:49:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69AABC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 494ED4056A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LS0dTzzx4nsR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:49:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7995A4055A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:49:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R541e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0VEW9IBM_1653637784; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VEW9IBM_1653637784) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 May 2022 15:49:44 +0800
Message-ID: <1653637777.3783245-8-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 9/9] virtio: use WARN_ON() to warning illegal status
 value
Date: Fri, 27 May 2022 15:49:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-10-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-10-jasowang@redhat.com>
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

On Fri, 27 May 2022 14:01:20 +0800, Jason Wang <jasowang@redhat.com> wrote:
> We used to use BUG_ON() in virtio_device_ready() to detect illegal
> status value, this seems sub-optimal since the value is under the
> control of the device. Switch to use WARN_ON() instead.
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
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  include/linux/virtio_config.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index d4edfd7d91bb..9a36051ceb76 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -255,7 +255,7 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>  	unsigned status = dev->config->get_status(dev);
>
> -	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> +	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>
>  	/*
>  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> --
> 2.25.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
