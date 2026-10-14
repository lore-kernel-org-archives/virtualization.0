Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91353A89C
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992127; cv=none; b=rFB9pnFy+D+sLteBPqzOJg4BTRdZ9+9bsA9Pjr/zNegivW16U5Tti85Pi2S7jbRwihZBHZyQl2sJqMQkhTmYwrl8vb9Y35ZbdJP5sY9k6n+lbGYzSLBB2iUcMp0FbdxZcUx7joby7KlJ68YmdRGE0nTE0dA5eAj+1m2yYBG4y6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992127; c=relaxed/simple;
	bh=AhfZpLcYq9rEhMN4/FOXtbX3fH6D74n3RGJvl+OSJCI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kcrt/BzN9NRGp020Uq6BStKK4mT1nvlZdbmuyztGY1GBEip+JUTfJQb1/i6sIDp7YGuMVSlnetyDfmzgpn25zwAXz9sC4sP3k78sjuUXl2l0uSVy2iaJAzFaG4smKqTlllaFJDs6BGsnWxyYrBxtQ7ZbDBvdBCBxAponk7lcUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgkegtQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgkegtQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29861F000C4;
	Wed, 14 Oct 2026 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791992122;
	bh=myw1utKSfYGhy5Y1A6oP93nKTaDFeanSjxaTGg9Q1gU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgkegtQZ9pjBxIoI3o3WmoEd/EFhlie43LRZdKH4xCuvYahSA4oLIVDg9z/3G+qxv
	 20kgqh4MYJiwgZJA9KbciFqs0b3wYL2MzcnNlBlqWbmmb9lgLxMj2jSTsgCVwxwiuK
	 bGr9BIwq2J8X/h/G0AgktlBSnnyfBV3VGx0NXcF1fj7ylnskX9LIHfmVKwMeZabexf
	 da4u1Yy6WCZ86u2o1LB4BKA1/GC3uNgUmmKxCRnLKMhqrThcmVkzpN5RHELbh3PS9S
	 UMX57A6jaG3PLcensjDg4l214c04NJLIb81D6cv+2QMtEQ97C8eUYqIlRo1aEaT3uv
	 2ip1TI7XSQbbQ==
Message-ID: <sashiko-outbox-171476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] drm/qxl: fix use-after-free in qxl_irq_handler on
 PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014151731.16775-1-megia.oscar@gmail.com>
References: <20261014151731.16775-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:35:21 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/qxl: interrupt storm window due to free_irq() before device ma=
sking
- [High] drm/qxl: double free in qxl_device_fini() on probe error
- [High] drm/qxl: invalid MMIO access due to deferred free_irq() on PCI unb=
ind
- [Medium] drm/qxl: memory leaks of client_monitors_config and IDRs on tear=
down
--

commit a1057712d86c9f769cf2c5267fc13f1280db7f1d
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

drm/qxl: fix use-after-free in qxl_irq_handler on PCI

This patch aims to fix a use-after-free bug in the qxl_irq_handler by adding
a qxl_irq_fini() call to the device finalization path. It attempts to
properly tear down the IRQ and cancel related work when the device is
unbound.

>     Masking after free_irq to avoid be overwritten by a concurrent
>     interrupt handler.

Is this explanation correct?

As mentioned below, masking after free_irq() creates a window for an
interrupt storm on a shared PCI line.

If the concern is a concurrent handler re-enabling interrupts, should the
driver instead use a software teardown flag that the handler checks?

[ ... ]

> diff --git a/drivers/gpu/drm/qxl/qxl_irq.c b/drivers/gpu/drm/qxl/qxl_irq.c
> index 4018bcf808e51..7e3e80134562f 100644
> --- a/drivers/gpu/drm/qxl/qxl_irq.c
> +++ b/drivers/gpu/drm/qxl/qxl_irq.c
> @@ -105,3 +105,18 @@ int qxl_irq_init(struct qxl_device *qdev)
>  	}
>  	return 0;
>  }
> +
> +void qxl_irq_fini(struct qxl_device *qdev)
> +{
> +	struct drm_device *ddev =3D &qdev->ddev;
> +	struct pci_dev *pdev =3D to_pci_dev(ddev->dev);
> +
> +	free_irq(pdev->irq, ddev);

[Severity: High]
Does this sequence create a race window for an interrupt storm?

The QXL device uses a shared, level-triggered PCI interrupt line (IRQF_SHAR=
ED).

If free_irq() unregisters the QXL handler here, but the device is still
allowed to generate interrupts until int_mask is cleared below, couldn't
the hardware assert an interrupt in between?

Since the QXL handler is unregistered, no handler would acknowledge the
interrupt, leading to an interrupt storm that disables the shared line.

Should the hardware interrupt generation be masked before calling free_irq(=
)?

> +
> +	if (qdev->ram_header) {
> +		qdev->ram_header->int_mask =3D 0;
> +		outb(0, qdev->io_base + QXL_IO_UPDATE_IRQ);
> +	}
> +
> +	cancel_work_sync(&qdev->client_monitors_config_work);
> +}
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
> index 461b7ab9ad5ca..872939414af43 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -310,6 +310,8 @@ void qxl_device_fini(struct qxl_device *qdev)
>  	qxl_surf_evict(qdev);
>  	qxl_vram_evict(qdev);
> =20
> +	qxl_irq_fini(qdev);

[Severity: High]
Is this the correct place to tear down the IRQ handler?

qxl_device_fini() is called from qxl_drm_release() when the last DRM file
descriptor is closed, not from the PCI unbind path.

If the PCI device is unbound via sysfs while userspace holds a DRM fd
open, the PCI hardware is disabled and unregistered from the bus, but
the IRQ handler remains registered until the fd is closed.

If a shared interrupt fires in the meantime, wouldn't qxl_irq_handler()
blindly access detached MMIO memory (qdev->ram_header->int_pending),
leading to an invalid hardware access?

> +	cancel_work_sync(&qdev->gc_work);
>  	qxl_gem_fini(qdev);
>  	qxl_bo_fini(qdev);
>  	qxl_ring_free(qdev->command_ring);
> @@ -318,6 +320,7 @@ void qxl_device_fini(struct qxl_device *qdev)
>  	io_mapping_free(qdev->surface_mapping);
>  	io_mapping_free(qdev->vram_mapping);
>  	iounmap(qdev->ram_header);
> +	qdev->ram_header =3D NULL;
>  	iounmap(qdev->rom);
>  	qdev->rom =3D NULL;
>  }

[Severity: High]
Could this lead to a double free on probe error?

When qxl_pci_probe() fails, the error path explicitly calls qxl_device_fini=
().

Then the driver core initiates devres cleanup, dropping the reference count
via drm_dev_put(), which triggers qxl_drm_release().

qxl_drm_release() calls qxl_device_fini() a second time.

Since qdev->gc_work.func is never zeroed out here, the early exit check
(!qdev->gc_work.func) at the start of qxl_device_fini() won't prevent a
second execution. This seems like it would cause double free_irq(), and
double frees for the rings and io mappings.

Should qdev->gc_work.func be cleared to NULL at the end of this function?

[Severity: Medium]
This problem wasn't introduced by this patch, but does this function leak
memory during teardown?

It looks like client_monitors_config (allocated via kzalloc_flex() in
qxl_alloc_client_monitors_config()) is never freed.

Additionally, release_idr and surf_id_idr are initialized with
idr_init_base() but do not have matching idr_destroy() calls here.

Could these resources be leaking their memory when the device is unbound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014151731.1677=
5-1-megia.oscar@gmail.com?part=3D1
