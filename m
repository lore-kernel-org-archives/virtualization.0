Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B54C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 14:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5391081589;
	Wed, 12 Oct 2022 14:34:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5391081589
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Ex1DBVWx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGPyMnaQAc5L; Wed, 12 Oct 2022 14:34:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A47698148A;
	Wed, 12 Oct 2022 14:34:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A47698148A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 823ECC0032;
	Wed, 12 Oct 2022 14:34:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1570FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 14:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D084F6106A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 14:34:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D084F6106A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Ex1DBVWx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UX7YHzYEv8NZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 14:34:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 292FF61057
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 292FF61057
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 14:34:04 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnZsM3YYXz4xGQ;
 Thu, 13 Oct 2022 01:33:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1665585241;
 bh=ZwzUyoEZ0QyY2/E7GFhwabiJeQLIx//6F4mXwQYP97E=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Ex1DBVWxo4dVZXYC/c3s2BRZC+uHoJKi2xOwQm6ownsPzATmCcA6UI2Ot2eQnW/fT
 QYzmIK1I5c0faUhON0YJpUrPWfWg9KE6Yka/0wA9GAsW9Vp8MNIQQNeRhYs+CAWk24
 vgQfX5nvT2+/clEQ4y9+GKLtgGQCbpuh96nqjlZTr2jTMp7Ya2xSyN/L7t5RgeeiOX
 U8I6bb4WUzWNag8WpglJJ29hxVssdCZdpfCnabrVUcGHx0kL+uWeF1fBgc/5OKvfGs
 hyRHG2d7m5iRmnSfAvH0sXgFQKp9JsUV5g+WgYyjTMvZ+EY6NObWrmtwJFVUEVKpTE
 4XZY0iUdjZztw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fixes, features
In-Reply-To: <87mta1marq.fsf@mpe.ellerman.id.au>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au>
Date: Thu, 13 Oct 2022 01:33:59 +1100
Message-ID: <87edvdm7qg.fsf@mpe.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> [ Cc += Bjorn & linux-pci ]
>
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> On Wed, Oct 12, 2022 at 05:21:24PM +1100, Michael Ellerman wrote:
>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
> ...
>>> > ----------------------------------------------------------------
>>> > virtio: fixes, features
>>> >
>>> > 9k mtu perf improvements
>>> > vdpa feature provisioning
>>> > virtio blk SECURE ERASE support
>>> >
>>> > Fixes, cleanups all over the place.
>>> >
>>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> >
>>> > ----------------------------------------------------------------
>>> > Alvaro Karsz (1):
>>> >       virtio_blk: add SECURE ERASE command support
>>> >
>>> > Angus Chen (1):
>>> >       virtio_pci: don't try to use intxif pin is zero
>>> 
>>> This commit breaks virtio_pci for me on powerpc, when running as a qemu
>>> guest.
>>> 
>>> vp_find_vqs() bails out because pci_dev->pin == 0.
>>> 
>>> But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
>>> succeed if we called it - which is what the code used to do.
>>> 
>>> I think this happens because pci_dev->pin is not populated in
>>> pci_assign_irq().
>>> 
>>> I would absolutely believe this is bug in our PCI code, but I think it
>>> may also affect other platforms that use of_irq_parse_and_map_pci().
>>
>> How about fixing this in of_irq_parse_and_map_pci then?
>> Something like the below maybe?
>> 
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 196834ed44fe..504c4d75c83f 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -446,6 +446,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>  	if (pin == 0)
>>  		return -ENODEV;
>>  
>> +	pdev->pin = pin;
>> +
>>  	/* Local interrupt-map in the device node? Use it! */
>>  	if (of_get_property(dn, "interrupt-map", NULL)) {
>>  		pin = pci_swizzle_interrupt_pin(pdev, pin);

Backing up a bit. Should the virtio code be looking at pci_dev->pin in
the first place?

Shouldn't it be checking pci_dev->irq instead?

The original commit talks about irq being 0 and colliding with the timer
interrupt.

But all (most?) platforms have converged on 0 meaning NO_IRQ since quite
a fews ago AFAIK.

And the timer irq == 0 is a special case AIUI:
  https://lore.kernel.org/all/CA+55aFwiLp1z+2mzkrFsid1WZQ0TQkcn8F2E6NL_AVR+m1fZ2w@mail.gmail.com/

cheers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
