Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675472;
	b=RbHLprJaTZ2pwx91eYSHnAQD6iG44yc+m9cGkAcFEsnjckGOyzVS9Ix+nM0VbeXh8mQD
	 lM2EtfcdkUBTCRyo5P/sh8Ifj0XImNN8/arKmVsd2g78L5FI1yJUGpOudVLMpv2rPFnWF
	 20mcdPtko0IZuD4xwu6RNcquwVdmBf9z5PHJT2BELq8J8MIvkCkXE3gJHjzpaVQli7sni
	 YrSyDRlO5jFcNdyA4CeYar9WjvtKotMPelPRjBasbxBXEe29SIfQX0tWSjrXdg4vCkfHw
	 UaY+xcQYHEqSTeDiJ48E/UQ+g4ol216HEAWoVYDE+Yh7bqpvQW03K9LXn06COcq4n9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SJn+E+whF7dsKL1P9xTFHG/kse4SpMPZXxWIRnOTMPE=;
	b=wO2RihcZPvhQYT6aEVpCio4JC5hMhsddv187rKxEMB7l9m5KirnDPMfcPKsX9aHjh5Nr
	 g/kVKFN5feIshvFJwFZZVdw+99McR/NY2Dg8dTMYOBczjSlLf53q/XIFbC/XixetbhgNr
	 9uoDoier7MO3D9MxeIS6s5ApEWSvDPIHzJM8HNYpbm/Zjz7nwww00x444Z6zChR6yQ2rj
	 FJbouJi1Qgw25jwb9ItuKj1HrseZhzEIPXo8zYrZyC0rQ+QJ0V+RQSsA9x7M9oTIuo8HU
	 HsgZj7KHp0gC9d9/XZT9asX7gh7TZFnRJ9vqZb9vjF4rFGW8YLRQhzurr3QwhkvgOoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EajJxNSe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3179D606A31E;
	Thu, 26 Nov 2026 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EajJxNSe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3CC1F000C0;
	Thu, 26 Nov 2026 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675471;
	bh=SJn+E+whF7dsKL1P9xTFHG/kse4SpMPZXxWIRnOTMPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EajJxNSeiGZxuWuIcTxOoBgPAxNLrzgzh4LdY8kqIQiDTwIfxcgLRUpNbkjozdOIN
	 o5jkhTpv+elM0bJF/RnE2+ztayx2XPDS8DzpChk65kjuSlM9Q0Mlz8Wcw7WLwuKcsZ
	 StsUr1gCMxDbt9663tl8umyrqSxcYoZO3fed3U47KHBwNk4cT/5os26is1VzjcM1mU
	 cQnpH7yucjj58WEDRNeU9ujJQ8Q4zBlyvrCG3/CsLF83DFBAc3Z/TzaEuMK3Sw86xb
	 ZqHytxk3i2oceIo7eFnEy8KTcXLEp1Uqj4QoXHissBTGwTizARwMc8k8jX4oP/MIGo
	 ZMjqGUzmf4YNg==
Message-ID: <sashiko-outbox-234895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] virtio: Add Qualcomm VirtIO transport wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261126-jshekhar-qcom-virtio-dcp-v1-3-7b49bda74916@oss.qualcomm.com>
References: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
 <20261126-jshekhar-qcom-virtio-dcp-v1-3-7b49bda74916@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:44:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] virtio: dcp_ipcc_handle_rx() conflates power ACK and resp_vq
  IRQs
- [Medium] virtio: unsafe restore in dcp_virtio_transport_suspend()
  error path
- [Medium] virtio: concurrent vring_interrupt() on resp_vq from two IRQ
  lines
- [Medium] virtio: missing synchronize_irq() in dcp_ipcc_synchronize()
- [Low] virtio: duplicated MMIO init in dcp_virtio_init_device()
--

commit 857816350f7692694cd906a59f8f5d13188d9138
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

virtio: Add Qualcomm VirtIO transport wrapper

This commit adds a Qualcomm DCP VirtIO transport driver that reuses
virtio_mmio_config_ops and integrates an IPCC mailbox client to send power
notifications and forward response virtqueue interrupts.

> diff --git a/drivers/virtio/virtio_qcom_dcp.c b/drivers/virtio/virtio_qco=
m_dcp.c
> new file mode 100644
> index 0000000000000..a5443f2dbc4b0
> --- /dev/null
> +++ b/drivers/virtio/virtio_qcom_dcp.c
> @@ -0,0 +1,273 @@

[ ... ]

> +static int dcp_virtio_find_vqs(struct virtio_device *vdev, unsigned int =
nvqs,
> +			       struct virtqueue *vqs[],
> +			       struct virtqueue_info vqs_info[],
> +			       struct irq_affinity *desc)
> +{
> +	struct virtio_mmio_device *mmio =3D
> +		container_of(vdev, struct virtio_mmio_device, vdev);
> +	struct dcp_virtio_transport *transport =3D to_dcp_virtio_transport(mmio=
);
> +	unsigned int i;
> +	int ret;
> +
> +	ret =3D virtio_mmio_config_ops.find_vqs(vdev, nvqs, vqs, vqs_info, desc=
);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < nvqs; i++) {
> +		if (vqs[i] && vqs_info[i].name && !strcmp(vqs_info[i].name, "resp")) {
> +			dcp_ipcc_set_resp_vq(&transport->ipcc, vqs[i]);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can vm_interrupt() and dcp_ipcc_handle_rx() run vring_interrupt() on
resp_vq concurrently across two IRQ lines?

virtio_mmio_config_ops.find_vqs() registers vm_interrupt() on IRQ 0 and
keeps every created virtqueue, including "resp", on vdev->vqs.  dcp_virtio_=
find_vqs()
then also assigns that queue to transport->ipcc.resp_vq, which is serviced
on IRQ 1 by dcp_ipcc_power_notify_irq():

CPU0 (IRQ 0)                      CPU1 (IRQ 1)
vm_interrupt()                    dcp_ipcc_power_notify_irq()
  virtio_device_for_each_vq()       dcp_ipcc_handle_rx()
    vring_interrupt(irq, vq)          spin_lock_irqsave(&ipcc->state_lock)
      vq->vq.callback(&vq->vq)        vring_interrupt(0, ipcc->resp_vq)
                                        vq->vq.callback(&vq->vq)
                                          <-- concurrent callback execution

vring_interrupt() has no internal lock, so if both interrupts fire at the
same time while a used buffer is pending, resp_vq->callback() runs on two
CPUs simultaneously.

[ ... ]

> +static int dcp_virtio_init_device(struct dcp_virtio_transport *transport,
> +				  struct platform_device *pdev)
> +{
> +	struct virtio_mmio_device *mmio =3D &transport->mmio;
> +	unsigned long magic;
> +	int ret;
> +
> +	mmio->vdev.dev.parent =3D &pdev->dev;
> +	mmio->vdev.config =3D &transport->config_ops;
> +	mmio->pdev =3D pdev;
> +
> +	mmio->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio->base))
> +		return PTR_ERR(mmio->base);
> +
> +	magic =3D readl(mmio->base + VIRTIO_MMIO_MAGIC_VALUE);
> +	if (magic !=3D ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
> +		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
> +		return -ENODEV;
> +	}
> +
> +	mmio->version =3D readl(mmio->base + VIRTIO_MMIO_VERSION);
> +	if (mmio->version < 1 || mmio->version > 3) {
> +		dev_err(&pdev->dev, "Version %ld not supported!\n", mmio->version);
> +		return -ENXIO;
> +	}
> +
> +	mmio->vdev.id.device =3D readl(mmio->base + VIRTIO_MMIO_DEVICE_ID);
> +	if (!mmio->vdev.id.device)
> +		return -ENODEV;
> +
> +	mmio->vdev.id.vendor =3D readl(mmio->base + VIRTIO_MMIO_VENDOR_ID);
> +
> +	if (mmio->version =3D=3D 1) {
> +		writel(PAGE_SIZE, mmio->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> +		ret =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +		if (!ret)
> +			dma_set_coherent_mask(&pdev->dev,
> +					      DMA_BIT_MASK(32 + PAGE_SHIFT));
> +	} else {
> +		ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	}
> +	if (ret)
> +		ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		dev_warn(&pdev->dev,
> +			 "Failed to enable 64-bit or 32-bit DMA. Trying to continue, but this=
 might not work.\n");
> +
> +	return 0;
> +}

[Severity: Low]
This isn't a bug, but dcp_virtio_init_device() duplicates the MMIO register
validation and DMA mask setup from virtio_mmio_probe() in
drivers/virtio/virtio_mmio.c.  Since this patch already introduces
drivers/virtio/virtio_mmio.h to share struct virtio_mmio_device and
virtio_mmio_config_ops, could this initialization be factored into a shared
helper in virtio_mmio.c?

Also, the commit message says the transport implements MMIO configuration
access, feature negotiation, and reset, whereas it reuses
virtio_mmio_config_ops for those operations.

[ ... ]

> +#ifdef CONFIG_PM_SLEEP
> +static int dcp_virtio_transport_suspend(struct device *dev)
> +{
> +	struct dcp_virtio_transport *transport =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D virtio_device_freeze(&transport->mmio.vdev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D dcp_ipcc_enable_irq_wake(&transport->ipcc);
> +	if (ret)
> +		goto err_restore;
> +
> +	ret =3D dcp_ipcc_send_power_notify(&transport->ipcc);
> +	if (ret) {
> +		dcp_ipcc_disable_irq_wake(&transport->ipcc);
> +		goto err_restore;
> +	}
> +
> +	return 0;
> +
> +err_restore:
> +	virtio_device_restore(&transport->mmio.vdev);
> +	return ret;
> +}

[Severity: Medium]
Is it safe for err_restore to call virtio_device_restore() directly after
dcp_ipcc_send_power_notify() fails?

If dcp_ipcc_send_power_notify() times out after mbox_send_message() has
already sent the sleep notification, DCP may already be powering down or
inaccessible when virtio_device_restore() accesses mmio->base to reset the
device and recreate virtqueues.  In addition, unlike
dcp_virtio_transport_resume(), err_restore does not write PAGE_SIZE to
VIRTIO_MMIO_GUEST_PAGE_SIZE when mmio->version =3D=3D 1 before calling
virtio_device_restore().

> diff --git a/drivers/virtio/virtio_qcom_dcp_ipcc.c b/drivers/virtio/virti=
o_qcom_dcp_ipcc.c
> new file mode 100644
> index 0000000000000..1d83bcc69d5cf
> --- /dev/null
> +++ b/drivers/virtio/virtio_qcom_dcp_ipcc.c
> @@ -0,0 +1,193 @@

[ ... ]

> +static void dcp_ipcc_handle_rx(struct dcp_ipcc *ipcc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	if (ipcc->shutting_down) {
> +		spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +		return;
> +	}
> +
> +	complete(&ipcc->power_notify_done);
> +	if (ipcc->resp_vq)
> +		vring_interrupt(0, ipcc->resp_vq);
> +
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +}

[Severity: Medium]
Does dcp_ipcc_handle_rx() conflate power-notification acknowledgments with
response virtqueue interrupts during suspend and resume?

ipcc->resp_vq is only cleared in dcp_virtio_del_vqs() and
dcp_ipcc_deinit().  If the bound VirtIO driver does not call del_vqs() in
its freeze callback (for example, virtio_rtc keeps its virtqueues across
freeze and deletes them in restore), ipcc->resp_vq remains non-NULL while
the device is frozen.  When DCP acknowledges dcp_ipcc_send_power_notify()
during dcp_virtio_transport_suspend() (after virtio_device_freeze()) or
during dcp_virtio_transport_resume() (before virtio_device_restore()),
dcp_ipcc_handle_rx() invokes vring_interrupt(0, ipcc->resp_vq) on the
frozen device.

Conversely, because dcp_ipcc_send_power_notify() calls
reinit_completion(&ipcc->power_notify_done) while ipcc->power_notify_irq is
also used for response queue notifications, an in-flight response queue
interrupt arriving after reinit_completion() completes power_notify_done
and causes dcp_ipcc_send_power_notify() to return before DCP has
acknowledged the power transition.

[ ... ]

> +void dcp_ipcc_synchronize(struct dcp_ipcc *ipcc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +}

[Severity: Medium]
Should dcp_ipcc_synchronize() call synchronize_irq(ipcc->power_notify_irq)
instead of only cycling ipcc->state_lock?

When virtio_reset_device() calls virtio_synchronize_cbs() ->
dcp_virtio_synchronize_cbs(), ipcc->shutting_down is still false and
ipcc->resp_vq is still set until del_vqs() is called later.  If
power_notify_irq has fired on another CPU (or woken its IRQ thread under
threadirqs or PREEMPT_RT) but has not yet acquired ipcc->state_lock, cycling
the lock returns immediately and the handler then enters
dcp_ipcc_handle_rx() and calls vring_interrupt(0, ipcc->resp_vq) after
virtio_reset_device() has returned:

CPU0                              CPU1 (<hardirq> / IRQ thread)
virtio_reset_device()
  dev->config->reset(dev)
                                  dcp_ipcc_power_notify_irq()
                                    dcp_ipcc_handle_rx()
  virtio_synchronize_cbs()
    dcp_virtio_synchronize_cbs()
      dcp_ipcc_synchronize()
        spin_lock_irqsave(&ipcc->state_lock)
        spin_unlock_irqrestore(&ipcc->state_lock)
                                      spin_lock_irqsave(&ipcc->state_lock)
                                      vring_interrupt(0, ipcc->resp_vq)
                                        <-- callback runs after reset

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-q=
com-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com?part=3D3
