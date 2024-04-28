Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCAA55
	for <virtualization@lists.linux.dev>; Sun, 28 Apr 2024 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714267008; cv=none; b=O2QFHszQMRRbZb2CKd9j/gqKNS8FpTU+yhYiWbWJvg7o0ow38s7ostNHg3lfcOSdy945ceduxwEnnZGUPTDqUxhf5xHls3PWWz4h9lPKjX+P8cT/1LaZZ7YmFtaZ0A7FAdz7NaGjhblcIV0lGlnN6Jmi1zwPI42oVD8qeQqsBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714267008; c=relaxed/simple;
	bh=9ydlCVQrDrLZ0UKO1hDEARz6wlkq7N/zbEr1O9owwtk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qJWgatGzd4W1O8SCF86hAkDUtfmWf7GCjxZBZxtjH8yAKCRhG5iytUZIQ2ApF1lWasoCARjSxaOXkbO7a81lH3dFTmPVrJ/MkY/yzD14kqtPTdPFkW6CO63jh6Nah76car8ARmz5TZyZdlOcz64ow2KigaXCvyV00oPcf/QpYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=srPMRzxT; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="srPMRzxT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714266997; h=Message-ID:Subject:Date:From:To;
	bh=4TfonJ0Al4A8tagf6JEFZFee4KtmegFGsgXYRk95k3U=;
	b=srPMRzxTQl7vUIeyw5dASdYV5vN5PvFruJFqWeCNPW2b1zxDmkT1VELTB6dE1wrfiR5ppNG95zlEccoTNm1CcOTWsNMjwQYK9fxI6tx0DAD+w/xbUfayEEz3BdxFxJ9RuCZ11lm7/JGx1f9J9wx4VAoTdPRsGGW0wgNkVG096rk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W5MabJA_1714266993;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5MabJA_1714266993)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 09:16:34 +0800
Message-ID: <1714266984.9272623-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [patch virtio] virtio: delete vq in vp_find_vqs_msix() when request_irq() fails
Date: Sun, 28 Apr 2024 09:16:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 virtualization@lists.linux.dev
References: <20240426150845.3999481-1-jiri@resnulli.us>
In-Reply-To: <20240426150845.3999481-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 26 Apr 2024 17:08:45 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> When request_irq() fails, error path calls vp_del_vqs(). There, as vq is
> present in the list, free_irq() is called for the same vector. That
> causes following splat:
>
> [    0.414355] Trying to free already-free IRQ 27
> [    0.414403] WARNING: CPU: 1 PID: 1 at kernel/irq/manage.c:1899 free_irq+0x1a1/0x2d0
> [    0.414510] Modules linked in:
> [    0.414540] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4+ #27
> [    0.414540] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
> [    0.414540] RIP: 0010:free_irq+0x1a1/0x2d0
> [    0.414540] Code: 1e 00 48 83 c4 08 48 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 8b 74 24 04 48 c7 c7 98 80 6c b1 e8 00 c9 f7 ff 90 <0f> 0b 90 90 48 89 ee 4c 89 ef e8 e0 20 b8 00 49 8b 47 40 48 8b 40
> [    0.414540] RSP: 0000:ffffb71480013ae0 EFLAGS: 00010086
> [    0.414540] RAX: 0000000000000000 RBX: ffffa099c2722000 RCX: 0000000000000000
> [    0.414540] RDX: 0000000000000000 RSI: ffffb71480013998 RDI: 0000000000000001
> [    0.414540] RBP: 0000000000000246 R08: 00000000ffffdfff R09: 0000000000000001
> [    0.414540] R10: 00000000ffffdfff R11: ffffffffb18729c0 R12: ffffa099c1c91760
> [    0.414540] R13: ffffa099c1c916a4 R14: ffffa099c1d2f200 R15: ffffa099c1c91600
> [    0.414540] FS:  0000000000000000(0000) GS:ffffa099fec40000(0000) knlGS:0000000000000000
> [    0.414540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.414540] CR2: 0000000000000000 CR3: 0000000008e3e001 CR4: 0000000000370ef0
> [    0.414540] Call Trace:
> [    0.414540]  <TASK>
> [    0.414540]  ? __warn+0x80/0x120
> [    0.414540]  ? free_irq+0x1a1/0x2d0
> [    0.414540]  ? report_bug+0x164/0x190
> [    0.414540]  ? handle_bug+0x3b/0x70
> [    0.414540]  ? exc_invalid_op+0x17/0x70
> [    0.414540]  ? asm_exc_invalid_op+0x1a/0x20
> [    0.414540]  ? free_irq+0x1a1/0x2d0
> [    0.414540]  vp_del_vqs+0xc1/0x220
> [    0.414540]  vp_find_vqs_msix+0x305/0x470
> [    0.414540]  vp_find_vqs+0x3e/0x1a0
> [    0.414540]  vp_modern_find_vqs+0x1b/0x70
> [    0.414540]  init_vqs+0x387/0x600
> [    0.414540]  virtnet_probe+0x50a/0xc80
> [    0.414540]  virtio_dev_probe+0x1e0/0x2b0
> [    0.414540]  really_probe+0xc0/0x2c0
> [    0.414540]  ? __pfx___driver_attach+0x10/0x10
> [    0.414540]  __driver_probe_device+0x73/0x120
> [    0.414540]  driver_probe_device+0x1f/0xe0
> [    0.414540]  __driver_attach+0x88/0x180
> [    0.414540]  bus_for_each_dev+0x85/0xd0
> [    0.414540]  bus_add_driver+0xec/0x1f0
> [    0.414540]  driver_register+0x59/0x100
> [    0.414540]  ? __pfx_virtio_net_driver_init+0x10/0x10
> [    0.414540]  virtio_net_driver_init+0x90/0xb0
> [    0.414540]  do_one_initcall+0x58/0x230
> [    0.414540]  kernel_init_freeable+0x1a3/0x2d0
> [    0.414540]  ? __pfx_kernel_init+0x10/0x10
> [    0.414540]  kernel_init+0x1a/0x1c0
> [    0.414540]  ret_from_fork+0x31/0x50
> [    0.414540]  ? __pfx_kernel_init+0x10/0x10
> [    0.414540]  ret_from_fork_asm+0x1a/0x30
> [    0.414540]  </TASK>
>
> Fix this by calling deleting the current vq when request_irq() fails.
>
> Fixes: 0b0f9dc52ed0 ("Revert "virtio_pci: use shared interrupts for virtqueues"")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>



Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>




> ---
>  drivers/virtio/virtio_pci_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b655fccaf773..584af7816532 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -348,8 +348,10 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  				  vring_interrupt, 0,
>  				  vp_dev->msix_names[msix_vec],
>  				  vqs[i]);
> -		if (err)
> +		if (err) {
> +			vp_del_vq(vqs[i]);
>  			goto error_find;
> +		}
>  	}
>  	return 0;
>
> --
> 2.44.0
>
