Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023527;
	b=kRHKvHgeo7elW17BSL3j0lbbJSMJM12D4VhO8xBvqLn+HXVtXDrL6VRuBGctKd70uhc9
	 9sKYx66o/SLEGd9iT/DLjZdwQBLb0KxV+LRQkF2Rq7tzXNECfLBliF0rI1nerWQxYIo4e
	 0j+VFfxdpqgXYPVJag/40furySZwwimHybHxh8jhhYWLJOXl+BzoVFNwYTQihLzyWg6bt
	 0OAE96Xji4G0gdprGpcLHtctOjPOTHvneMP3wbUVGReyWfx0PV3Hzq0qIva6NJe6B0W13
	 /cKx/kZ+gpKhrvIIunTvdUg6GoK20yqoVSNpjocSm1trTqlAfTC86sHUKN6R8RL7YmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023527;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E54yKKmVxhqcCEXeR1OMwWIKj2eo9rtcn6VKxqg8/dA=;
	b=nLT5ckBMbTyLuczgGahpxRcoZ8wMqGd2WMwBa2a06/vypdDGnsVmBm7+wKx5octg9i6e
	 9y4g1ZtZ7M6xog6y2q65WGAPbMqZF5kgUf6RC45tsVHx3tPK0C/mnCJxdpFMtPPHdogWK
	 EDiwIyMqKwYiBJBIfEN7fVepcWWNCqPwVph6MMyGgbJ3mZiyR6ty0iaqt0jIj6uNvM2ux
	 s2ZHpxiYG3zQOxn8IMbqlGbCOHa7tggwGA1kJcchCZvzTrW5CBmYWKFzjVirCN/ckn2A4
	 Y952sHlVJxjUHeCXTG8iNeaAoXkJ70cBqU8WF3brBMdjFSJRY+yhGqsMdom8pLe8T0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REWNjJOw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08A606A31A;
	Mon, 26 Oct 2026 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REWNjJOw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071411F01825;
	Mon, 26 Oct 2026 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793023526;
	bh=E54yKKmVxhqcCEXeR1OMwWIKj2eo9rtcn6VKxqg8/dA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=REWNjJOwGgm2w8vi2R0iHWV+GtU417WRHC0nPyjWwDityoGQ8r56bDIqzIwsWLXPW
	 MvZ3H7tm4zx30b429wIUBN4YPE1B38aetylgNJhOLafm+3eSkFW0mU4Jv/Iwt48JiW
	 0ucG149dS7+WK0dtAPx9qXgyUB72afnh0LkBYY2sYScxG3bQONsebYLHP9b4CHxEo/
	 QtGkg1OjyzGLgJQwru+MjUP44H5wgYCl2llb6xUnUOjNsuWsS0+RnX7TCpbFJi6Ddj
	 7cjKN+24m4CstBuE0bKLfskG6egRgVs7l9vavW7/UX5Z1oUB65LaHDhD8I8rGnobkz
	 YdXniI1yjBlTg==
Message-ID: <sashiko-outbox-185373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/23] drm/msm/dcp: Add Qualcomm VirtIO transport
 wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-19-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-19-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 14:05:25 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/msm/dcp: use-after-free of vdev due to devm_kzalloc() and empt=
y release
- [High] drm/msm/dcp: broken virtqueue PM sequencing in suspend and resume
- [Medium] drm/msm/dcp: unbalanced IRQ wake in dcp_virtio_transport_resume(=
) on error
- [Low] drm/msm/dcp: build failure in dcp_virtio_transport_suspend() when !=
PM_SLEEP
--

commit 8e04d90ffae5a36ffd1db1c49707f1bc447c570d
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add Qualcomm VirtIO transport wrapper

This commit adds the Qualcomm-specific VirtIO MMIO transport wrapper for DCP
firmware, handling IPCC power notifications, virtqueue setup, interrupt
handling, and system suspend/resume sequencing.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c b/drivers/gpu=
/drm/msm/dcp/dcp_virtio_transport.c
> new file mode 100644
> index 0000000000000..02c0e2a9fafe9
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c
[ ... ]
> +struct dcp_virtio_transport {
> +	struct virtio_device vdev;
> +	struct platform_device *pdev;
> +
> +	void __iomem *base;
> +	unsigned long version;
> +
> +	bool wake_irq_enabled;
> +	struct dcp_ipcc ipcc;
> +};
[ ... ]
> +static void dcp_virtio_release_dev(struct device *dev)
> +{
> +}
> +
> +struct dcp_ipcc *dcp_virtio_get_ipcc(struct virtio_device *vdev)
> +{
> +	return &to_dcp_virtio_transport(vdev)->ipcc;
> +}
> +
> +static int dcp_virtio_transport_probe(struct platform_device *pdev)
> +{
> +	struct dcp_virtio_transport *transport;
> +	unsigned long magic;
> +	int ret;
> +
> +	transport =3D devm_kzalloc(&pdev->dev, sizeof(*transport), GFP_KERNEL);
> +	if (!transport)
> +		return -ENOMEM;
> +
> +	transport->pdev =3D pdev;
> +	transport->vdev.dev.parent =3D &pdev->dev;
> +	transport->vdev.dev.release =3D dcp_virtio_release_dev;
> +	transport->vdev.config =3D &dcp_virtio_config_ops;
> +	platform_set_drvdata(pdev, transport);
[ ... ]
> +	ret =3D register_virtio_device(&transport->vdev);
> +	if (ret) {
> +		put_device(&transport->vdev.dev);
> +		dcp_ipcc_deinit(&transport->ipcc);
> +		platform_set_drvdata(pdev, NULL);
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +err_node:
> +err_ipcc:
> +	dcp_ipcc_deinit(&transport->ipcc);
> +err_free:
> +	platform_set_drvdata(pdev, NULL);
> +	return ret;
> +}
> +
> +static void dcp_virtio_transport_remove(struct platform_device *pdev)
> +{
> +	struct dcp_virtio_transport *transport =3D platform_get_drvdata(pdev);
> +
> +	unregister_virtio_device(&transport->vdev);
> +	platform_set_drvdata(pdev, NULL);
> +	dcp_ipcc_deinit(&transport->ipcc);
> +}

[Severity: High]
struct dcp_virtio_transport embeds struct virtio_device vdev, which in turn
embeds a reference-counted struct device dev. In dcp_virtio_transport_probe=
(),
transport is allocated with devm_kzalloc(&pdev->dev, ...) and
transport->vdev.dev.release is set to the empty callback
dcp_virtio_release_dev().

Once register_virtio_device(&transport->vdev) calls
device_initialize(&dev->dev), the lifetime of transport->vdev.dev is govern=
ed
by its reference count rather than the parent platform device's devres
lifetime. When dcp_virtio_transport_remove() returns (or when
register_virtio_device() fails), devres_release_all(&pdev->dev) immediately
frees transport regardless of whether references to transport->vdev.dev are
still held.

Additionally, if transport is instead allocated with kzalloc() and freed in
dcp_virtio_release_dev() (as in drivers/virtio/virtio_mmio.c), calling
dcp_ipcc_deinit(&transport->ipcc) after put_device(&transport->vdev.dev) in
dcp_virtio_transport_probe() or after unregister_virtio_device(&transport->=
vdev)
in dcp_virtio_transport_remove() would access transport->ipcc after the fin=
al
reference drops and frees transport.

Can this cause a use-after-free of transport->vdev.dev and transport->ipcc?

> +
> +static int dcp_virtio_transport_suspend(struct device *dev)
> +{
> +	struct dcp_virtio_transport *transport =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D virtio_device_freeze(&transport->vdev);
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
> +	virtio_device_restore(&transport->vdev);
> +	return ret;
> +}
> +
> +static int dcp_virtio_transport_resume(struct device *dev)
> +{
> +	struct dcp_virtio_transport *transport =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D dcp_ipcc_send_power_notify(&transport->ipcc);
> +	if (ret)
> +		return ret;

[Severity: Medium]
During system suspend, dcp_virtio_transport_suspend() enables IRQ wake on
transport->ipcc.power_notify_irq via dcp_ipcc_enable_irq_wake(&transport->i=
pcc).

During system resume, dcp_virtio_transport_resume() calls
dcp_ipcc_send_power_notify(&transport->ipcc) before calling
dcp_ipcc_disable_irq_wake(&transport->ipcc).

If dcp_ipcc_send_power_notify() fails or times out, does returning early he=
re
leave wake_depth unbalanced on transport->ipcc.power_notify_irq?

> +
> +	dcp_ipcc_disable_irq_wake(&transport->ipcc);
> +	if (transport->version =3D=3D 1)
> +		writel(PAGE_SIZE,
> +		       transport->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> +
> +	return virtio_device_restore(&transport->vdev);
> +}

[Severity: High]
In dcp_virtio_transport_suspend(), virtio_device_freeze(&transport->vdev) r=
uns
before dcp_ipcc_send_power_notify(&transport->ipcc), while
transport->ipcc.resp_vq remains non-NULL because neither this function nor
dcp_virtio_driver clears it during freeze. When the firmware acknowledges t=
he
power notification, dcp_ipcc_handle_rx() executes:

drivers/gpu/drm/msm/dcp/dcp_ipcc.c:dcp_ipcc_handle_rx() {
	...
	complete(&ipcc->power_notify_done);
	if (ipcc->resp_vq && virtqueue_kick_prepare(ipcc->resp_vq))
		virtqueue_notify(ipcc->resp_vq);
	...
}

Because VIRTIO_RING_F_EVENT_IDX is not negotiated, virtqueue_kick_prepare()
returns true whenever VRING_USED_F_NO_NOTIFY is clear, writing to
VIRTIO_MMIO_QUEUE_NOTIFY after the VirtIO device has already been frozen.

Similarly, in dcp_virtio_transport_resume(), dcp_ipcc_send_power_notify() is
called before virtio_device_restore(&transport->vdev), so the RX
acknowledgment kicks ipcc->resp_vq before restore. Immediately after,
virtio_device_restore() calls virtio_reset_device() -> dcp_virtio_reset(),
which writes 0 to VIRTIO_MMIO_STATUS and resets the hardware virtqueue stat=
e,
and nothing in the restore path or dcp_virtio_driver reprograms the virtque=
ue
registers before setting VIRTIO_CONFIG_S_DRIVER_OK.

Will this leave the virtqueues unconfigured in hardware and break the displ=
ay
transport across suspend and resume?

> +
> +static const struct dev_pm_ops dcp_virtio_transport_pm_ops =3D {
> +	.suspend =3D dcp_virtio_transport_suspend,
> +	.resume =3D dcp_virtio_transport_resume,
> +};
> +
> +static const struct of_device_id dcp_virtio_transport_of_match[] =3D {
> +	{ .compatible =3D "qcom,dcp-virtio" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dcp_virtio_transport_of_match);
> +
> +static struct platform_driver dcp_virtio_transport_driver =3D {
> +	.probe =3D dcp_virtio_transport_probe,
> +	.remove =3D dcp_virtio_transport_remove,
> +	.driver =3D {
> +		.name =3D "qcom-dcp-virtio",
> +		.of_match_table =3D dcp_virtio_transport_of_match,
> +		.pm =3D &dcp_virtio_transport_pm_ops,
> +	},
> +};

[Severity: Low]
In include/linux/virtio.h, virtio_device_freeze() and virtio_device_restore=
()
are only declared under #ifdef CONFIG_PM_SLEEP:

#ifdef CONFIG_PM_SLEEP
int virtio_device_freeze(struct virtio_device *dev);
int virtio_device_restore(struct virtio_device *dev);
#endif

Since CONFIG_DRM_MSM_DCP depends on CONFIG_DRM_MSM (which only depends on
CONFIG_PM) and CONFIG_VIRTIO, this file can be built with CONFIG_PM=3Dy and
CONFIG_PM_SLEEP=3Dn.

Won't compiling dcp_virtio_transport_suspend() and
dcp_virtio_transport_resume() unconditionally without #ifdef CONFIG_PM_SLEEP
(and without pm_sleep_ptr() / pm_ptr() on dcp_virtio_transport_pm_ops) caus=
e a
build failure when CONFIG_PM_SLEEP is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D19
