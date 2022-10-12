Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB84C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 13:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7E8E813D6;
	Wed, 12 Oct 2022 13:28:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7E8E813D6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=RHHgYvEM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dfdlnNvKvQ24; Wed, 12 Oct 2022 13:28:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3998C81438;
	Wed, 12 Oct 2022 13:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3998C81438
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94C58C0077;
	Wed, 12 Oct 2022 13:28:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C95AC0080
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 13:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D6A48139E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 13:28:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D6A48139E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DKdTuFGtqbb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 13:28:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E63981387
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E63981387
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 13:28:39 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnYPq2t9xz4x1G;
 Thu, 13 Oct 2022 00:28:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1665581313;
 bh=9E6D8SfUt/XvbCtYk6H79eLF5Z0a8VLBf3dbm5xgnlU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RHHgYvEMnEbCBFnzD18P+zJmb66XY27lFmS0KJ8KUqFVam8bV7++FxLIykwgZpM/S
 FiBTpasGKgc4Upb01vtGUerSG6up/lXQMe090W03pZ1gmjOVpSYg2vuz0r9lwE9EaH
 nPqvbKpIktgReSHQQVIIsx9vuUd7T26IIBp7sx/Ug4gb5mLGMBkdlSvT2E6Zimumhr
 VWasrOgScYJaSBz9IGFstoG13WLv+UD/l0Kp0YJkmY1BMAl37gPZRm+rB1wtZyzYYe
 21IqN5MPO+DWz2YaSMuMqRd9RzsPAA+tPSMk6qmHZOV7hS2uVpYymn6LQtqiBePpA4
 tf35f+0SCmUZg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fixes, features
In-Reply-To: <20221012070532-mutt-send-email-mst@kernel.org>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
Date: Thu, 13 Oct 2022 00:28:25 +1100
Message-ID: <87mta1marq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 wangdeming@inspur.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, angus.chen@jaguarmicro.com,
 Bjorn Helgaas <bhelgaas@google.com>, lingshan.zhu@intel.com,
 linuxppc-dev@lists.ozlabs.org, gavinl@nvidia.com
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

[ Cc += Bjorn & linux-pci ]

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Wed, Oct 12, 2022 at 05:21:24PM +1100, Michael Ellerman wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
...
>> > ----------------------------------------------------------------
>> > virtio: fixes, features
>> >
>> > 9k mtu perf improvements
>> > vdpa feature provisioning
>> > virtio blk SECURE ERASE support
>> >
>> > Fixes, cleanups all over the place.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >
>> > ----------------------------------------------------------------
>> > Alvaro Karsz (1):
>> >       virtio_blk: add SECURE ERASE command support
>> >
>> > Angus Chen (1):
>> >       virtio_pci: don't try to use intxif pin is zero
>> 
>> This commit breaks virtio_pci for me on powerpc, when running as a qemu
>> guest.
>> 
>> vp_find_vqs() bails out because pci_dev->pin == 0.
>> 
>> But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
>> succeed if we called it - which is what the code used to do.
>> 
>> I think this happens because pci_dev->pin is not populated in
>> pci_assign_irq().
>> 
>> I would absolutely believe this is bug in our PCI code, but I think it
>> may also affect other platforms that use of_irq_parse_and_map_pci().
>
> How about fixing this in of_irq_parse_and_map_pci then?
> Something like the below maybe?
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..504c4d75c83f 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -446,6 +446,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>  	if (pin == 0)
>  		return -ENODEV;
>  
> +	pdev->pin = pin;
> +
>  	/* Local interrupt-map in the device node? Use it! */
>  	if (of_get_property(dn, "interrupt-map", NULL)) {
>  		pin = pci_swizzle_interrupt_pin(pdev, pin);

That doesn't fix it in all cases, because there's an early return if
there's a struct device_node associated with the pci_dev, before we even
read the pin.

Also the pci_dev is const, and removing the const would propagate to a
few other places.

The other obvious place to fix it would be in pci_assign_irq(), as
below. That fixes this bug for me, but is otherwise very lightly tested.

cheers


diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index cc7d26b015f3..0135413b33af 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -22,6 +22,15 @@ void pci_assign_irq(struct pci_dev *dev)
 	int irq = 0;
 	struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
 
+	/* Make sure dev->pin is populated */
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+
+	/* Cope with illegal. */
+	if (pin > 4)
+		pin = 1;
+
+	dev->pin = pin;
+
 	if (!(hbrg->map_irq)) {
 		pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
 		return;
@@ -34,11 +43,6 @@ void pci_assign_irq(struct pci_dev *dev)
 	 * time the interrupt line passes through a PCI-PCI bridge we must
 	 * apply the swizzle function.
 	 */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	/* Cope with illegal. */
-	if (pin > 4)
-		pin = 1;
-
 	if (pin) {
 		/* Follow the chain of bridges, swizzling as we go. */
 		if (hbrg->swizzle_irq)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
