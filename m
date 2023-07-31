Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD8BEB64DD
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 02:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD3C440990;
	Mon, 31 Jul 2023 02:23:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD3C440990
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fB/vB65I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EcbYCs98dzgY; Mon, 31 Jul 2023 02:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7B917401C0;
	Mon, 31 Jul 2023 02:23:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B917401C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F763C0071;
	Mon, 31 Jul 2023 02:23:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB35C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 02:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DC7960F97
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 02:23:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DC7960F97
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fB/vB65I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dW6rM_ReYGYD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 02:23:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6806660B79
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 02:23:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6806660B79
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=JxaPmaoNeY4Be1h8EMB/LCkyezUw5Q8cZq/LkO4Me1s=; b=fB/vB65IvyVg7mMiZ3F3gIiHOV
 exWk+j64dmUy3lwx0NLkPPOBXKNv/eU3IUzF9DrCiOXsWvgx3dnDzuLfiYso137dK9RVltWKYJ5UG
 m2FlquIMLeBFnh5O3pkiYcna3lhN8ymHn7KnDuGpdlrMPNwQe9vfFkdqylc/7O25Jfjbnl2D1hkV1
 +c3EsaWUqkSuuobgxRsXkBDmvI0e/YknFTcE2MbCXMKP2GA5wCw78Uof8QA84NXx/t54ESL2zWUd9
 llK+ThiTZ6DesojAJzng6kO2mvkTBo8So1utwFLVa4Ksy3GtgJ1rM0vlethfJz715S5ZnZqB2VbwY
 PhIaVOwg==;
Received: from [2601:1c2:980:9ec0::2764]
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qQIYr-00DVnX-0I; Mon, 31 Jul 2023 02:23:05 +0000
Message-ID: <4b7c0ecf-5e9d-6428-6934-d6bd7278c622@infradead.org>
Date: Sun, 30 Jul 2023 19:23:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] virtio: a new vcpu watchdog driver
Content-Language: en-US
To: zhanghao1 <zhanghao1@kylinos.cn>, virtualization@lists.linux-foundation.org
References: <20230731012512.235085-1-zhanghao1@kylinos.cn>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230731012512.235085-1-zhanghao1@kylinos.cn>
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org, mst@redhat.com
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

Hi--

On 7/30/23 18:25, zhanghao1 wrote:
> A new virtio pci driver is added for listening to vcpus
> inside guest. Each vcpu creates a corresponding thread to
> periodically send data to qemu's back-end watchdog device.
> If a vCPU is in the stall state, data cannot be sent to
> back-end virtio device. As a result, the back-end device
> can detect that the guest is in the stall state.
> 
> The driver is mainly used with the back-end watchdog device of qemu.
> 
> The qemu backend watchdog device is implemented as follow:
> https://lore.kernel.org/qemu-devel/20230705081813.411526-1-zhanghao1@kylinos.cn/
> 
> Signed-off-by: zhanghao1 <zhanghao1@kylinos.cn>
> ---
>  drivers/virtio/Kconfig                      |   9 +
>  drivers/virtio/Makefile                     |   1 +
>  drivers/virtio/virtio_vcpu_stall_detector.c | 299 ++++++++++++++++++++
>  3 files changed, 309 insertions(+)
>  create mode 100644 drivers/virtio/virtio_vcpu_stall_detector.c
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 0a53a61231c2..869323e345a1 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -173,4 +173,13 @@ config VIRTIO_DMA_SHARED_BUFFER
>  	 This option adds a flavor of dma buffers that are backed by
>  	 virtio resources.
>  
> +config VIRTIO_VCPU_WATCHDOG
> +	tristate "Virtio vcpu watchdog driver"
> +	depends on VIRTIO_PCI
> +	help
> +	 When this driver is bound inside a KVM guest, it will
> +	 periodically "pet" an PCI virtio watchdog device from each vCPU

	                    a PCI

> +	 and allow the host to detect vCPU stalls.
> +
> +	 If you do not intend to run this kernel as a guest, say N.

Kconfig help text should be indented with one tab + 2 spaces
according to coding-style.rst.

>  endif # VIRTIO_MENU
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 8e98d24917cc..c7341f078a34 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
>  obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
>  obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
>  obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
> +obj-$(CONFIG_VIRTIO_VCPU_WATCHDOG) += virtio_vcpu_stall_detector.o
> diff --git a/drivers/virtio/virtio_vcpu_stall_detector.c b/drivers/virtio/virtio_vcpu_stall_detector.c
> new file mode 100644
> index 000000000000..58344ca528be
> --- /dev/null
> +++ b/drivers/virtio/virtio_vcpu_stall_detector.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// VCPU stall detector.
> +// Copyright (C) Kylin Software, 2023
> +
> +#include <linux/cpu.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/nmi.h>
> +#include <uapi/linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +#include <linux/param.h>
> +#include <linux/percpu.h>
> +#include <linux/slab.h>
> +
> +#define VCPU_STALL_REG_STATUS		(0x00)
> +#define VCPU_STALL_REG_LOAD_CNT		(0x04)
> +#define VCPU_STALL_REG_CURRENT_CNT	(0x08)
> +#define VCPU_STALL_REG_CLOCK_FREQ_HZ	(0x0C)
> +#define VCPU_STALL_REG_LEN		(0x10)
> +#define VCPU_STALL_REG_TIMEOUT_SEC	(0x14)
> +
> +#define VCPU_STALL_DEFAULT_CLOCK_HZ	(10)
> +#define VCPU_STALL_MAX_CLOCK_HZ		(100)
> +#define VCPU_STALL_DEFAULT_TIMEOUT_SEC	(8)
> +#define VCPU_STALL_MAX_TIMEOUT_SEC	(600)
> +
> +struct vcpu_stall_detect_config {
> +	u32 clock_freq_hz;
> +	u32 stall_timeout_sec;
> +
> +	enum cpuhp_state hp_online;
> +};
> +
> +struct vcpu_stall_priv {
> +	struct hrtimer vcpu_hrtimer;
> +	struct virtio_device *vdev;
> +	u32 cpu_id;
> +};
> +
> +struct vcpu_stall {
> +	struct vcpu_stall_priv *priv;
> +	struct virtqueue *vq;
> +	spinlock_t lock;
> +	struct pet_event {
> +		u32 cpu_id;
> +		bool is_initialized;
> +		u32 ticks;
> +	} pet_event;
> +};
> +
> +static const struct virtio_device_id vcpu_stall_id_table[] = {
> +	{ VIRTIO_ID_WATCHDOG, VIRTIO_DEV_ANY_ID },
> +	{ 0, },
> +};
> +
> +/* The vcpu stall configuration structure which applies to all the CPUs */
> +static struct vcpu_stall_detect_config vcpu_stall_config;
> +static struct vcpu_stall *vcpu_stall;
> +
> +static struct vcpu_stall_priv __percpu *vcpu_stall_detectors;
> +
> +static enum hrtimer_restart
> +vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)

One line instead of the 2 lines above.

> +{

-- 
~Randy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
