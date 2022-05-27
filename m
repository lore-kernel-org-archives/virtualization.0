Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E47C4332F
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 07:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68CBA84916;
	Fri, 27 May 2022 07:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ywvu-lb5PdHO; Fri, 27 May 2022 07:32:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 15C0084767;
	Fri, 27 May 2022 07:32:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC571C0039;
	Fri, 27 May 2022 07:32:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B905C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AA3D84767
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DLHqJHLiDgxN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:32:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com
 [47.90.199.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AD868249E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:32:42 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0VEW8612_1653636756; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VEW8612_1653636756) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 May 2022 15:32:37 +0800
Message-ID: <1653636748.5919-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 5/9] virtio-mmio: implement synchronize_cbs()
Date: Fri, 27 May 2022 15:32:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-6-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-6-jasowang@redhat.com>
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

On Fri, 27 May 2022 14:01:16 +0800, Jason Wang <jasowang@redhat.com> wrote:
> Simply synchronize the platform irq that is used by us.
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
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_mmio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 839684d672af..c9699a59f93c 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -345,6 +345,13 @@ static void vm_del_vqs(struct virtio_device *vdev)
>  	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
>  }
>
> +static void vm_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));
> +}
> +
>  static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int index,
>  				  void (*callback)(struct virtqueue *vq),
>  				  const char *name, bool ctx)
> @@ -541,6 +548,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.finalize_features = vm_finalize_features,
>  	.bus_name	= vm_bus_name,
>  	.get_shm_region = vm_get_shm_region,
> +	.synchronize_cbs = vm_synchronize_cbs,
>  };
>
>
> --
> 2.25.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
