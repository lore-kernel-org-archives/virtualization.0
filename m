Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1359C433FE
	for <virtualization@archiver.kernel.org>; Thu, 13 Oct 2022 01:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24347610C5;
	Thu, 13 Oct 2022 01:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24347610C5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Z/pK7aMb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pAcNsYXWOUgu; Thu, 13 Oct 2022 01:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A226610BF;
	Thu, 13 Oct 2022 01:35:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A226610BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 521EFC0033;
	Thu, 13 Oct 2022 01:35:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F8A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 01:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04913405AC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 01:35:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04913405AC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Z/pK7aMb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A-qlRjuXeQDq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 01:34:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E62C40002
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E62C40002
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 01:34:58 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnsWs0jPLz4x1G;
 Thu, 13 Oct 2022 12:34:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1665624889;
 bh=gPvZV0BQTqsExtsBFxdu6MEGId7gZqkpuYWwZgOnkLI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Z/pK7aMbtmhvewWXZLFngbCigBpfnFHxarsryaRvqZrDhRAU6Xsk7ghQAZT04h2TV
 Yen2hAUBHVNi7qQdPcGcEbPl2VQrv5qD14t36IbzM9c2IFUMoOB4tAW/TSm5cJCdrv
 E/sJk8jrbbGQD5HJ+kEHZyaWqzJW4bVF8dRmPy0Wx/ja68JAay8PGpFjoS/KHq9NB7
 AXsZVs7yDXGBTL5+lDZVeExy99WRm1TnN3pNHCRwdEMk+oJ0MGxbLazZpYjZ8fcZPj
 N+yD+YBeVfl9znpUIyLEQiLFCJJr7o1530ch0cw+xGgrGwFfSBPD1JO2RQ/rhKk9ku
 gzB+qM7iXgdow==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: use irq to detect interrupt support
In-Reply-To: <20221012220312.308522-1-mst@redhat.com>
References: <20221012220312.308522-1-mst@redhat.com>
Date: Thu, 13 Oct 2022 12:34:45 +1100
Message-ID: <877d14mrpm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:
> commit 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> breaks virtio_pci on powerpc, when running as a qemu guest.
>
> vp_find_vqs() bails out because pci_dev->pin == 0.
>
> But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
> succeed if we called it - which is what the code used to do.
>
> This seems to happen because pci_dev->pin is not populated in
> pci_assign_irq().
>
> Which is absolutely a bug in the relevant PCI code, but it
> may also affect other platforms that use of_irq_parse_and_map_pci().
>
> However Linus said:
> 	The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does
> 		if (dev->irq) ...
> so let's just check irq and be done with it.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Build tested only - very late here. Angus any chance you could
> help test this? Thanks!

This works for me on powerpc.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 4df77eeb4d16..a6c86f916dbd 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -409,8 +409,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
>  	if (!err)
>  		return 0;
> -	/* Is there an interrupt pin? If not give up. */
> -	if (!(to_vp_device(vdev)->pci_dev->pin))
> +	/* Is there an interrupt? If not give up. */
> +	if (!(to_vp_device(vdev)->pci_dev->irq))
>  		return err;
>  	/* Finally fall back to regular interrupts. */
>  	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> -- 
> MST
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
