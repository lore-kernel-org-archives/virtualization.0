Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83012C433EF
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 07:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E29A412F0;
	Fri, 27 May 2022 07:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XsQcVSpeLuf6; Fri, 27 May 2022 07:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A690E4055A;
	Fri, 27 May 2022 07:32:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B641C0039;
	Fri, 27 May 2022 07:32:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1746C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90FEB61612
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dMDph1YW15zT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:32:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B012461610
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:32:05 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0VEWDhhD_1653636721; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VEWDhhD_1653636721) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 May 2022 15:32:01 +0800
Message-ID: <1653636712.2244692-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 4/9] virtio-pci: implement synchronize_cbs()
Date: Fri, 27 May 2022 15:31:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-5-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-5-jasowang@redhat.com>
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

On Fri, 27 May 2022 14:01:15 +0800, Jason Wang <jasowang@redhat.com> wrote:
> We can simply reuse vp_synchronize_vectors() for .synchronize_cbs().
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
>  drivers/virtio/virtio_pci_legacy.c | 1 +
>  drivers/virtio/virtio_pci_modern.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 7fe4caa4b519..a5e5721145c7 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -192,6 +192,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_cbs = vp_synchronize_vectors,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 4acb34409f0b..623906b4996c 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -394,6 +394,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_modern_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_cbs = vp_synchronize_vectors,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> @@ -411,6 +412,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_modern_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_cbs = vp_synchronize_vectors,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> --
> 2.25.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
