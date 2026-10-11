Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461C385D60
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717205; cv=none; b=geUH5BVljkxMC5t1KVZk+w5zVpn5KNrIoikUxgKEfgHUA3cvhWwtfCucR2niUCXO1RxO3v2Kt3CUbFMfU0mf4t5Iaeg1uFLcTPbnNpIqb77uoWYllNGdJEqLBCjHwwZM7UKsm+Vdo/7DMvq1k0UNUuX6pRh/oPiJLuGYQdqzbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717205; c=relaxed/simple;
	bh=zj7r5kaWw5Xf90RbyO7mZIuOc7Gu4QgQXOoNkrW4BS0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pagpYc1ZcXDXv+9gB7ZiXhZ9HSDgBkLr6c0T/R45Vxl1n/ZLadx2J2CFTHuiFzPvaXNqxw7hHrdQ+DcknHQGVGM9jGYuH2yLL9ZMU8+9opqUpVx/5kbNtMcaBxtOQ5ly4Wvbo4xtq+gZrlzjagySYwmzinj4dZojRTV164GoBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8K3R/E9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8K3R/E9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3961F0089B;
	Sun, 11 Oct 2026 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791717204;
	bh=ywQn84bzxuMblu0lGE+DWJGh+INJwO9nFleuCBXeCjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8K3R/E9yMbHYcc/tW1KQPH6V7fLH0OkmXf0e1ESskerKTKTi5zeaYCPsC8FWex1p
	 XmPqj1suQ065acHVs0S21Sq+vQBHRdLG6iArYS5MrBDoG9LAOKurpVUhoP+zEvZcGi
	 TK+nMhX9oPmP3cYZKw8NjXUzfvN4z9EyrgfoooxBquiVw89GilCN7Di6bs8aon2E5q
	 nUhxqG32mCN/y0vkcrGkzWfJ+0jQDXiSztxZZM6q1o/2RGS8/m+buzqBv4EUt+YEd9
	 33c6NYlPgMNS1CQWtGNOdwj6Ntr+mKadjuygpW0/JGbJLOzQRlmMww4w4C9uGNT7ZC
	 3mohA5T/7f1uA==
Message-ID: <sashiko-outbox-167177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/qxl: fix use-after-free in qxl_irq_handler on
 PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261011110144.40575-1-megia.oscar@gmail.com>
References: <20261011110144.40575-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 11:13:23 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/qxl: Race in qxl_irq_fini() leaves hardware interrupts unmasked
- [High] drm/qxl: UAF of qdev due to cancel_work_sync() called before free_=
irq()
- [High] drm/qxl: UAF of qdev via gc_work due to missing cancel_work_sync()
- [High] drm/qxl: double execution of qxl_irq_fini on probe error path caus=
es UAF
--

commit b941d125ca70f91e048fd38f98c81dd403aa9b7d
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>
Subject: drm/qxl: fix use-after-free in qxl_irq_handler on PCI

This patch attempts to fix a use-after-free in qxl_irq_handler by tearing
down the IRQ resources during qxl_device_fini(). It adds qxl_irq_fini() to
mask the interrupt, cancel the pending monitor configuration work, and free
the IRQ.

[ ... ]
> --- a/drivers/gpu/drm/qxl/qxl_irq.c
> +++ b/drivers/gpu/drm/qxl/qxl_irq.c
[ ... ]
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
> +	if (qdev->ram_header) {
> +		qdev->ram_header->int_mask =3D 0;
> +		outb(0, qdev->io_base + QXL_IO_UPDATE_IRQ);
> +	}

[Severity: High]
Can this masking be overwritten by a concurrent interrupt handler?

If qxl_irq_handler() executes on another CPU concurrently, it
unconditionally writes QXL_INTERRUPT_MASK to int_mask and
QXL_IO_UPDATE_IRQ before returning. If that happens after this block
executes, the hardware will remain armed even after free_irq() unregisters
the handler, which might cause an unhandled IRQ storm.

> +
> +	cancel_work_sync(&qdev->client_monitors_config_work);
> +
> +	free_irq(pdev->irq, ddev);

[Severity: High]
Is it safe to cancel the work before freeing the IRQ?

Because free_irq() hasn't executed yet, a concurrent interrupt could
trigger qxl_irq_handler(). The handler might call:
schedule_work(&qdev->client_monitors_config_work)

If this happens after cancel_work_sync() has already returned, it would
leave the work queued after qdev is freed, resulting in a use-after-free.

> +}
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -310,6 +310,7 @@ void qxl_device_fini(struct qxl_device *qdev)
>  	qxl_surf_evict(qdev);
>  	qxl_vram_evict(qdev);
> =20
> +	qxl_irq_fini(qdev);

[Severity: High]
Is there a risk of a page fault here during probe failure?

If qxl_pci_probe() fails, the error path manually calls qxl_device_fini().
Then, devres cleanup triggers qxl_drm_release() which executes
qxl_device_fini() a second time.

The first execution unmaps qdev->ram_header but doesn't set it to NULL.
When the second execution calls qxl_irq_fini(), won't it dereference the
unmapped qdev->ram_header?

[Severity: High]
Will qdev->gc_work remain pending after device teardown?

Earlier in qxl_device_fini(), flush_work(&qdev->gc_work) is called,
followed by qxl_surf_evict() and qxl_vram_evict(). These evictions can
push commands to the hardware, resulting in new interrupts.

Since qxl_irq_fini() hasn't been called yet, qxl_irq_handler() processes
these interrupts and calls qxl_queue_garbage_collect(), which re-schedules
gc_work. Since cancel_work_sync(&qdev->gc_work) is never called, couldn't
this lead to a use-after-free when the pending work executes later?

>  	qxl_gem_fini(qdev);
>  	qxl_bo_fini(qdev);
>  	qxl_ring_free(qdev->command_ring);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011110144.4057=
5-1-megia.oscar@gmail.com?part=3D1
