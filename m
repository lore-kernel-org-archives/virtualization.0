Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079D392C3A
	for <virtualization@lists.linux.dev>; Sun, 27 Sep 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790504366; cv=none; b=avCxeZvrvgJRic/KaBCtSndymvKRW2kAbeAM+IytoAi3hEuc7YmSejXE2oW8Hr/mG4u3Pr/rfQvf4tR70JYQ6mKdPbC068chWouFcSINKRwfAZxPuOsl+7UKuizakGra650TaNCt5hxAuXG5BizkcKRVTrRGFMltSyQK5DGr38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790504366; c=relaxed/simple;
	bh=l5rn8rpQ/PNvOh8VoWkis1/tShOR6nqpI7VjAMvQTeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjsD+f26D1kwRGhbL6uWnyjYUcOdBXkD57wqtAiMtbBc4NsZILjywkv2M+CdSToYgWyv1/ZHuOBT/tcC+0fOSrgMv5Rt2+M63zUX73j4cl4xeNDFmnRAPiLpvxVglPfrHEcpfbzZ67gKftNv5Hft3AfQnpfzd2CYeYb8CQybRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjLO4W13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjLO4W13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAEA1F000FF;
	Sun, 27 Sep 2026 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790504365;
	bh=IqlGHUzuhyGaqXWs9nG4xS6EXMApVIf3q5Ba73JCT7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjLO4W13ht53arhhHFTdDhWpz5/basDS1FDwA8lNmTPETMWxMfT2ff+Q2Rx3Or0QD
	 DMgIYLAxmdjB7bWgwyiSh6CuyUt8yCHCO4ciLHWdcWpQ2wtvILoI3AHjMvEclGrX57
	 0w/SisNdnM+qMlIsrPgobiAExIfdYrxkfNm3YbmwIY9oq3O7jsHSz0at7tz475XI9K
	 jTcK9snAXQ6rMwpoidlg1qv4G/zBdp43XDuLlSIZgAzbL/WqKt5P9UabV7ybpQIq5C
	 zEN3o63YnJ1M2uSjsETFTEHhvdk/w91dV6rsM5fvhoC20PRn+4OWuVkALvAUXIP94L
	 EfpD3StOWDU9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/qxl: fix use-after-free in qxl_irq_handler on
 PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260927101026.45411-1-megia.oscar@gmail.com>
References: <20260927101026.45411-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 10:19:24 +0000
Message-Id: <20260927101924.EFAEA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/qxl: incorrect global disablement of shared PCI interrupt
- [High] drm/qxl: hardware teardown times out due to premature free_irq()
--

commit 4dcfdbcd12c8dcfe24f833ddd26240d1479406f0
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

drm/qxl: fix use-after-free in qxl_irq_handler on PCI

This commit adds disable_irq() and free_irq() to qxl_pci_remove() to
prevent the IRQ handler from firing after device teardown begins, fixing
a reported KASAN use-after-free.

> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -160,6 +160,9 @@ qxl_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev =3D pci_get_drvdata(pdev);
> =20
> +	disable_irq(pdev->irq);

[Severity: High]
Does this disable a shared interrupt line globally?

Looking at qxl_irq_init(), the interrupt is requested with IRQF_SHARED:
request_irq(pdev->irq, qxl_irq_handler, IRQF_SHARED, ...);

If this interrupt line is shared with other PCI devices, calling
disable_irq() here will mask the interrupt at the hardware controller
level (like the IO-APIC). Could this prevent other devices sharing the
same line from receiving interrupts, causing them to hang?

To safely disable shared interrupts, should the driver mask interrupts via
its own device registers instead?

> +	free_irq(pdev->irq, dev);
> +

[Severity: High]
Will freeing the IRQ this early cause hardware teardown commands to time ou=
t?

After this free_irq(), drm_atomic_helper_shutdown() is called.
Furthermore, when the final reference is dropped, qxl_device_fini()
executes the following cleanup sequence:

qxl_kms.c:qxl_device_fini() {
    ...
    qxl_io_notify_oom(qdev);
    wait_event_timeout(qdev->release_event,
                       atomic_read(&qdev->release_count) =3D=3D 0, HZ);
}

Since qxl_io_notify_oom() requires the interrupt handler to fire to process
the completion and signal release_event, will this wait now unconditionally
time out because the IRQ handler was already removed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927101026.4541=
1-1-megia.oscar@gmail.com?part=3D1
