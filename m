Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7B8C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 13:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 984546103D;
	Wed, 12 Oct 2022 13:29:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 984546103D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=px5TNFZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iOOgJp78tpn0; Wed, 12 Oct 2022 13:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 236B060D58;
	Wed, 12 Oct 2022 13:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 236B060D58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1349C0077;
	Wed, 12 Oct 2022 13:29:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CD04C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 13:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59FE583372
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 13:29:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59FE583372
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=px5TNFZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QvZcXDTPHq4U
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 13:29:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 693698336D
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 693698336D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 13:29:06 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnYQS4HWKz4xGt;
 Thu, 13 Oct 2022 00:29:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1665581344;
 bh=PWX6k4sapyUbB0Ldwc1YFfAGSS69spKkUKEhbPr0Uu4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=px5TNFZIthNvIxpiD5l6mE50E38LOu+L6ZD8Tu18htqxz4dPD1Pneda7aNIkUutXM
 6y2P0GtECJpuv+4mHpxkR4pZNaVi723kzwe0wqDVeAwEg/lZL1uc5O7LJ6U6aahdn7
 ziEwEnhxkqyHWuBttGWL47E5RtpU3v64rK3IQUqBRiKHKA3WxsvKs0NBwFB/DRo2nP
 XHkyQy9fiEQ+9rTDfvVw1ybqrTcubR+mU8G3KNHrXWakSgvGzrlIwLamL+nU9dDfap
 90h7DDOaThuio8+oSWexlqJ5LTLZnL9bZF4EV+AKujNH0AGQYBsmXBjYwA9X30KWwN
 pkT2uxxaxsVGA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: read interrupt pin directly
In-Reply-To: <20221012110736.285161-1-mst@redhat.com>
References: <20221012110736.285161-1-mst@redhat.com>
Date: Thu, 13 Oct 2022 00:29:04 +1100
Message-ID: <87leplmaqn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org,
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
> Work around the issue in virtio for now, and let's try to fix
> all affected pci systems and then we can revert this.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 4df77eeb4d16..6155ea4e7e4b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -400,6 +400,7 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  		struct irq_affinity *desc)
>  {
>  	int err;
> +	u8 pin = 0;
>  
>  	/* Try MSI-X with one vector per queue. */
>  	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
> @@ -409,8 +410,13 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
>  	if (!err)
>  		return 0;
> -	/* Is there an interrupt pin? If not give up. */
> -	if (!(to_vp_device(vdev)->pci_dev->pin))
> +	/*
> +	 * Is there an interrupt pin? If not give up.
> +	 * NB: It would seem to be better to use pci_dev->pin - unfortunately
> +	 * not all platforms populate it.
> +	 */
> +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> +	if (!pin)
>  		return err;
>  	/* Finally fall back to regular interrupts. */
>  	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);

Needs the delta below in order to compile.

But with that it fixes the issue for me.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers


diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 6155ea4e7e4b..cae134e2573f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -415,7 +415,7 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	 * NB: It would seem to be better to use pci_dev->pin - unfortunately
 	 * not all platforms populate it.
 	 */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pci_read_config_byte(to_vp_device(vdev)->pci_dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin)
 		return err;
 	/* Finally fall back to regular interrupts. */
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
