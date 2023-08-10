Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EE5C001DE
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 20:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D2E58397F;
	Thu, 10 Aug 2023 20:55:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D2E58397F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YVjNFEOm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLv7khpn6VlZ; Thu, 10 Aug 2023 20:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BFD1821EB;
	Thu, 10 Aug 2023 20:55:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BFD1821EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61D77C0072;
	Thu, 10 Aug 2023 20:55:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29FC1C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 20:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1C9A8397F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 20:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1C9A8397F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yN7U_3NFyrUx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 20:55:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78388821EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 20:55:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78388821EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691700914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lfaB6tBMAvL9/pqvVaWnN1LZOF40W/2XE6DW1I2BEG4=;
 b=YVjNFEOmzPT77IDGbMCWaVsj6EUXIDkbQQ3GCrX03/qi4ObeH2TJIh/oyOfunzn2E5gdau
 +zcESvn82wz+emiXmkvMMnd+jO+aN/W+4JtwgevkV8zyB3iBSZRC5BKyxwHqM6JF3Y49qW
 6gcKi8jK+5ZhJcqvNfIuC0RAyhcI9Dg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-yxo0AqtYN7ahGYNXpYxUZQ-1; Thu, 10 Aug 2023 16:55:12 -0400
X-MC-Unique: yxo0AqtYN7ahGYNXpYxUZQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-317b30fedb0so834934f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 13:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691700911; x=1692305711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfaB6tBMAvL9/pqvVaWnN1LZOF40W/2XE6DW1I2BEG4=;
 b=Bd4tcZni0HlLfxEoj6EmKt1H+dvizMLPqPMBkWQXwE9ltyN73cpV4pLICrFAwv7Auv
 GzHOH0oBFw7LUcOtmN+MPv5eQoislIwFHnJO/4WAnINrKwimqJ1CIY7wOQe2fHhDiqiV
 HF449SgWv8vwEwwbOaPIDi1Y/RFRN+BcOwvgqAhTy7YQWURtWgGEnNqsyeDa7ObLYXMq
 W/C+mj2hs3Vmssxlcs1Ae+1HVZgMtUuNp/kCrz1rCeQ3lCT66z5YZ7BStoQ5fgdBsBG0
 HAwoPOmcySahwE5NDGQ18CruBjGQa3+EDqHqlcHmpJ2LzS3zftNFvHIrINYSoO8Vsqu5
 +WQg==
X-Gm-Message-State: AOJu0YyEDAKhdliQCeKNPR6zwgFkVDamLwCJeHat1r7C9+13nQfyK83Q
 7KC5fmQHEol+lNPqKawb7hsXvMg6EE6pYGtGjQ6wan3cbTFpj9kLbi9OinH1aHlLXbHPvD/wyoR
 xtJCgziJOqzYPhSLVJuNmFTnogBlNjuLaCuzjPN4vhw==
X-Received: by 2002:a05:6000:90:b0:314:3954:7ff6 with SMTP id
 m16-20020a056000009000b0031439547ff6mr3227133wrx.56.1691700911598; 
 Thu, 10 Aug 2023 13:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNUpf0ajOkTTXi4qlPy6gs875R1+q6YliZ1AXVNxj1/ZIGEmZCK4uQqXByKlrrTsc3hRFOAQ==
X-Received: by 2002:a05:6000:90:b0:314:3954:7ff6 with SMTP id
 m16-20020a056000009000b0031439547ff6mr3227122wrx.56.1691700911065; 
 Thu, 10 Aug 2023 13:55:11 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 s7-20020adfecc7000000b0031912c0ffebsm2457444wro.23.2023.08.10.13.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 13:55:10 -0700 (PDT)
Date: Thu, 10 Aug 2023 16:55:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhanghao1 <zhanghao1@kylinos.cn>
Subject: Re: [PATCH] virtio: a new vcpu watchdog driver
Message-ID: <20230810164707-mutt-send-email-mst@kernel.org>
References: <20230731012512.235085-1-zhanghao1@kylinos.cn>
MIME-Version: 1.0
In-Reply-To: <20230731012512.235085-1-zhanghao1@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jul 31, 2023 at 09:25:12AM +0800, zhanghao1 wrote:
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
> +	 and allow the host to detect vCPU stalls.
> +
> +	 If you do not intend to run this kernel as a guest, say N.
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


should all be LE. and formatting here is very compiler dependent.
also put this in a header under uapi/

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
> +{
> +	u32 ticks, ping_timeout_ms;
> +	struct scatterlist sg;
> +	int unused, err = 0;
> +
> +	struct vcpu_stall_priv *vcpu_stall_detector =
> +		this_cpu_ptr(vcpu_stall->priv);
> +
> +	/* Reload the stall detector counter register every
> +	 * `ping_timeout_ms` to prevent the virtual device
> +	 * from decrementing it to 0. The virtual device decrements this
> +	 * register at 'clock_freq_hz' frequency.
> +	 */
> +	ticks = vcpu_stall_config.clock_freq_hz *
> +				vcpu_stall_config.stall_timeout_sec;
> +
> +	spin_lock(&vcpu_stall->lock);
> +	while (virtqueue_get_buf(vcpu_stall->vq, &unused))
> +		;
> +	vcpu_stall->pet_event.ticks = cpu_to_virtio32(vcpu_stall_detector->vdev, ticks);
> +	vcpu_stall->pet_event.is_initialized = true;
> +	vcpu_stall->pet_event.cpu_id = vcpu_stall_detector->cpu_id;
> +
> +	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
> +	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
> +	if (!err)
> +		virtqueue_kick(vcpu_stall->vq);
> +	else
> +		pr_err("cpu:%d failed to add outbuf, err:%d\n", vcpu_stall_detector->cpu_id, err);

this can happen if device is slow to use the buffers. and then what?
will missing the pet even mean host will reset the guest?
pr_err also might make guest crash, depending on config.

> +
> +	spin_unlock(&vcpu_stall->lock);
> +
> +	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
> +			  MSEC_PER_SEC / 2;
> +	hrtimer_forward_now(hrtimer,
> +			    ms_to_ktime(ping_timeout_ms));
> +	return HRTIMER_RESTART;
> +}
> +
> +static int start_stall_detector_cpu(unsigned int cpu)
> +{
> +	u32 ticks, ping_timeout_ms;
> +	struct scatterlist sg;
> +	struct hrtimer *vcpu_hrtimer;
> +	int err = 0;
> +
> +	struct vcpu_stall_priv *vcpu_stall_detector =
> +		this_cpu_ptr(vcpu_stall->priv);
> +
> +	vcpu_stall_detector->cpu_id = cpu;
> +
> +	vcpu_hrtimer = &vcpu_stall_detector->vcpu_hrtimer;
> +
> +	/* Compute the number of ticks required for the stall detector
> +	 * counter register based on the internal clock frequency and the
> +	 * timeout value given from the device tree.
> +	 */
> +	ticks = vcpu_stall_config.clock_freq_hz *
> +		vcpu_stall_config.stall_timeout_sec;
> +	vcpu_stall->pet_event.ticks = cpu_to_virtio32(vcpu_stall_detector->vdev, ticks);
> +
> +	/* Pet the stall detector at half of its expiration timeout
> +	 * to prevent spurious resets.
> +	 */
> +	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
> +			  MSEC_PER_SEC / 2;
> +
> +	hrtimer_init(vcpu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	vcpu_hrtimer->function = vcpu_stall_detect_timer_fn;
> +
> +	vcpu_stall->pet_event.is_initialized = true;
> +
> +	spin_lock(&vcpu_stall->lock);
> +	vcpu_stall->pet_event.cpu_id = cpu;
> +	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
> +	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
> +	if (!err)
> +		virtqueue_kick(vcpu_stall->vq);
> +
> +	spin_unlock(&vcpu_stall->lock);
> +
> +	hrtimer_start(vcpu_hrtimer, ms_to_ktime(ping_timeout_ms),
> +		      HRTIMER_MODE_REL_PINNED);
> +	return err;
> +}
> +
> +static int stop_stall_detector_cpu(unsigned int cpu)
> +{
> +	int err = 0;
> +	struct scatterlist sg;
> +
> +	struct vcpu_stall_priv *vcpu_stall_detector =
> +		per_cpu_ptr(vcpu_stall_detectors, cpu);
> +
> +	/* Disable the stall detector for the current CPU */
> +	hrtimer_cancel(&vcpu_stall_detector->vcpu_hrtimer);
> +	vcpu_stall->pet_event.is_initialized = false;
> +	vcpu_stall->pet_event.cpu_id = cpu;
> +
> +	spin_lock(&vcpu_stall->lock);
> +	sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
> +	err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
> +	if (!err)
> +		virtqueue_kick(vcpu_stall->vq);
> +
> +	spin_unlock(&vcpu_stall->lock);
> +
> +	return err;
> +}
> +
> +static int vcpu_stall_detect_probe(struct virtio_device *vdev)
> +{
> +	int ret, cpu;
> +	u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
> +	u32 stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
> +
> +	vcpu_stall = kzalloc(sizeof(struct vcpu_stall), GFP_KERNEL);
> +	if (!vcpu_stall) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	vdev->priv = vcpu_stall;
> +
> +	vcpu_stall->priv = devm_alloc_percpu(&vdev->dev,
> +					typeof(struct vcpu_stall_priv));
> +	if (!vcpu_stall->priv) {
> +		ret = -ENOMEM;
> +		goto failed_priv;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		struct vcpu_stall_priv *priv;
> +
> +		priv = per_cpu_ptr(vcpu_stall->priv, cpu);
> +		priv->vdev = vdev;
> +	}
> +
> +	ret = virtio_cread_feature(vdev, VCPU_STALL_REG_CLOCK_FREQ_HZ,
> +						struct vcpu_stall_detect_config, clock_freq_hz,
> +						&clock_freq_hz);
> +	if (ret || !clock_freq_hz) {
> +		if (!(clock_freq_hz > 0 &&
> +		      clock_freq_hz < VCPU_STALL_MAX_CLOCK_HZ)) {
> +			dev_warn(&vdev->dev, "clk out of range\n");
> +			clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
> +		}
> +	}
> +	ret = virtio_cread_feature(vdev, VCPU_STALL_REG_TIMEOUT_SEC,
> +						struct vcpu_stall_detect_config, stall_timeout_sec,
> +						&stall_timeout_sec);
> +	if (ret || !stall_timeout_sec) {
> +		if (!(stall_timeout_sec > 0 &&
> +		      stall_timeout_sec < VCPU_STALL_MAX_TIMEOUT_SEC)) {
> +			dev_warn(&vdev->dev, "stall timeout out of range\n");
> +			stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;

how does host know what is the range?

> +		}
> +	}
> +
> +	vcpu_stall_config = (struct vcpu_stall_detect_config) {
> +		.clock_freq_hz		= clock_freq_hz,
> +		.stall_timeout_sec	= stall_timeout_sec
> +	};
> +
> +	/* find virtqueue for guest to send pet event to host */
> +	vcpu_stall->vq = virtio_find_single_vq(vdev, NULL, "pet-event");
> +	if (IS_ERR(vcpu_stall->vq)) {
> +		dev_err(&vdev->dev, "failed to find vq\n");
> +		goto failed_priv;
> +	}
> +
> +	spin_lock_init(&vcpu_stall->lock);
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +				"virt/vcpu_stall_detector:online",
> +				start_stall_detector_cpu,
> +				stop_stall_detector_cpu);
> +	if (ret < 0) {
> +		dev_err(&vdev->dev, "failed to install cpu hotplug\n");
> +		goto failed_priv;
> +	}
> +
> +	vcpu_stall_config.hp_online = ret;
> +	return 0;
> +
> +
> +failed_priv:
> +	kfree(vcpu_stall);
> +err:
> +	return ret;
> +}
> +
> +static void vcpu_stall_detect_remove(struct virtio_device *vdev)
> +{
> +	int cpu;
> +
> +	cpuhp_remove_state(vcpu_stall_config.hp_online);
> +
> +	for_each_possible_cpu(cpu)
> +		stop_stall_detector_cpu(cpu);


you are sending a bunch of messages ok but never even
wait for them to be processed. normally there's
need to reset device, destroy vqs ... not necessary here? why?

> +}
> +
> +static unsigned int features_legacy[] = {
> +	VCPU_STALL_REG_STATUS, VCPU_STALL_REG_LOAD_CNT, VCPU_STALL_REG_CURRENT_CNT,
> +	VCPU_STALL_REG_CLOCK_FREQ_HZ, VCPU_STALL_REG_LEN, VCPU_STALL_REG_TIMEOUT_SEC
> +};
> +


this should be a modern only device, no way this needs legacy support.


> +
> +static unsigned int features[] = {
> +	VCPU_STALL_REG_STATUS, VCPU_STALL_REG_LOAD_CNT, VCPU_STALL_REG_CURRENT_CNT,
> +	VCPU_STALL_REG_CLOCK_FREQ_HZ, VCPU_STALL_REG_LEN, VCPU_STALL_REG_TIMEOUT_SEC
> +};
> +
> +static struct virtio_driver vcpu_stall_detect_driver = {
> +	.feature_table	= features,
> +	.feature_table_size = ARRAY_SIZE(features),
> +	.feature_table_legacy	= features_legacy,
> +	.feature_table_size_legacy	= ARRAY_SIZE(features_legacy),
> +	.driver.name	= KBUILD_MODNAME,
> +	.driver.owner	= THIS_MODULE,
> +	.id_table =	vcpu_stall_id_table,
> +	.probe  = vcpu_stall_detect_probe,
> +	.remove = vcpu_stall_detect_remove,
> +};
> +
> +module_virtio_driver(vcpu_stall_detect_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(virtio, vcpu_stall_id_table);
> +MODULE_AUTHOR("zhanghao1 <zhanghao1@kylinos.cn>");
> +MODULE_DESCRIPTION("VCPU stall detector");
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
