Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826547043A
	for <virtualization@lists.linux.dev>; Fri,  2 Oct 2026 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932389; cv=none; b=Bcx3KPmy8v1oTdlTBnpp2jdyHaW7utKbAcccr4S1XnLmuk6ecIFCS5hsmNOCdi5QCT2W325TlHEkowNtaOt46qJguwGvGDCQazWTzYXdsVm6vAD7rhIbwygucQcxVuK37smvcXgvaujEXyvA8+HHUuelPT4ICyZ26wFQV9JgmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932389; c=relaxed/simple;
	bh=ODO5JJ6Et9z2t2YmE6jk7A3AhpxeDLC2PPBd1adrMlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Em362U4Lw5mRzwgmj7VlPMpgf6oiNo8lIKpM5hO/2x0YQRq9wNXJ2wh2eQ3ALNRa+UMl7Jb2Gpj5X7U0LJd/FMu9gSEEsBnxsmwbVcBDpevX1R01yVknHvi2Dn2gwzm1pX70s6C56b3R4KjTPbKkWKljolvr7umhV4hjNd23AYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOU9jaAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOU9jaAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384651F0089C;
	Fri,  2 Oct 2026 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932387;
	bh=K55fmbDmLKJTJsa1EkERW5cvv8miYTTr7u+1kPny374=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOU9jaAjIE5qzApgocEOXN+qIl6tOU5qpJdZ9hWftfe7xTzwyj8aX/LpMzpP1nTUG
	 xi7/25ECfKFn2xoWZLUSxV+mV0D1VZQDLsA9TXG/c02teEpwwnXor4LMcQRAfczG3b
	 WIA1cm/qUh/6DLEwRv0XlLYOKZYzw8Tf5NwaBHXEaQLUfXrYgDu4yqKMqQDWAEgU7E
	 nW8Voxwd+9I/0diFSwY3t5QNRbR2sqOPzbzyvOXzl46wM9L0/Cit5ZbZWI/YtFat17
	 I5EASGkjDUl7Xnf9eh9cIWvLcLaWpg8ynO51U28Yf3noZF0TtwaqCJl4qNs2BUvfDm
	 4Qn5u2jBCKjgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/qxl: fix use-after-free in qxl_irq_handler on
 PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261001184321.80615-1-megia.oscar@gmail.com>
References: <20261001184321.80615-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:06 +0000
Message-Id: <20261002091307.384651F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/qxl: use-after-free on qdev in client_monitors_config_work
- [High] drm/qxl: IRQ storm on shared interrupt line due to race
- [Medium] drm/qxl: guaranteed 1-second timeout delay on device unbind
--

commit 4e30a9d9b42421b43ae1402ef7242873b17ea62b
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

drm/qxl: fix use-after-free in qxl_irq_handler on PCI

This commit aims to fix a slab-use-after-free in the qxl_irq_handler during
unbind. It masks interrupts on the QXL hardware and reorders the IRQ cleanup
logic to be handled in qxl_pci_remove() before legacy VGA resources are
released.

> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -159,10 +159,12 @@ static void
>  qxl_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev =3D pci_get_drvdata(pdev);
> +	struct qxl_device *qdev =3D to_qxl(dev);
> =20
>  	drm_kms_helper_poll_fini(dev);
>  	drm_dev_unregister(dev);
>  	drm_atomic_helper_shutdown(dev);
> +	qxl_irq_fini(qdev);

[Severity: Medium]
Does placing qxl_irq_fini() here cause a guaranteed timeout during unbind?

Later in the teardown process, the DRM release callback qxl_drm_release()
calls qxl_device_fini(), which invokes qxl_io_notify_oom() and waits for
the hardware to signal completion via an interrupt:

drivers/gpu/drm/qxl/qxl_kms.c:qxl_device_fini() {
    ...
    qxl_io_notify_oom(qdev);
    wait_event_timeout(qdev->release_event,
                       atomic_read(&qdev->release_count) =3D=3D 0,
                       HZ);
    ...
}

Since the interrupt handler is permanently unregistered at this point,
the interrupt is never processed. Will wait_event_timeout() unconditionally
hit its 1-second timeout on every unbind?

>  	if (pci_is_vga(pdev) && pdev->revision < 5)
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  }

[ ... ]

> diff --git a/drivers/gpu/drm/qxl/qxl_irq.c b/drivers/gpu/drm/qxl/qxl_irq.c
> --- a/drivers/gpu/drm/qxl/qxl_irq.c
> +++ b/drivers/gpu/drm/qxl/qxl_irq.c
> @@ -105,3 +105,16 @@ int qxl_irq_init(struct qxl_device *qdev)
>  	}
>  	return 0;
>  }
> +
> +void qxl_irq_fini(struct qxl_device *qdev)
> +{
> +	struct drm_device *ddev =3D &qdev->ddev;
> +	struct pci_dev *pdev =3D to_pci_dev(ddev->dev);
> +
> +	if (qdev->ram_header)
> +		qdev->ram_header->int_mask =3D 0;

[Severity: High]
Can this race with the interrupt handler and cause an IRQ storm?

While this clears the interrupt mask, it does not notify the hardware via an
I/O update. If an interrupt arrives right before this, qxl_irq_handler()
runs concurrently:

drivers/gpu/drm/qxl/qxl_irq.c:qxl_irq_handler() {
    ...
    qdev->ram_header->int_mask =3D QXL_INTERRUPT_MASK;
    outb(0, qdev->io_base + QXL_IO_UPDATE_IRQ);
    ...
}

The handler will unconditionally set the mask back to QXL_INTERRUPT_MASK
and re-enable interrupts at the hardware level.

When free_irq() subsequently removes the handler, could the hardware be left
actively asserting interrupts on a shared PCI line with no handler register=
ed
to clear them, potentially breaking other devices on the same line?

> +
> +	cancel_work_sync(&qdev->client_monitors_config_work);

[Severity: High]
Does cancelling the work before freeing the IRQ create a race condition that
leads to a use-after-free?

Because the IRQ handler is still active when cancel_work_sync() is called,
an arriving interrupt can trigger qxl_irq_handler() which schedules the work
again:

drivers/gpu/drm/qxl/qxl_irq.c:qxl_irq_handler() {
    ...
    if (pending & QXL_INTERRUPT_CLIENT_MONITORS_CONFIG) {
        schedule_work(&qdev->client_monitors_config_work);
    }
    ...
}

If the work is re-queued after cancel_work_sync() returns, qdev will
eventually be freed via devres during device removal. When the workqueue
later processes the dangling work item, will it access the freed memory?

> +
> +	free_irq(pdev->irq, ddev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001184321.8061=
5-1-megia.oscar@gmail.com?part=3D1
