Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A4CC4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 15:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5D09833C9;
	Wed, 12 Oct 2022 15:51:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5D09833C9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJaeT/hf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s40xMlMeX_3l; Wed, 12 Oct 2022 15:51:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 659118328E;
	Wed, 12 Oct 2022 15:51:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 659118328E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 375C1C0033;
	Wed, 12 Oct 2022 15:51:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9311C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 15:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 953204024D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 15:51:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 953204024D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJaeT/hf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hQ_xLJm90vDq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 15:51:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23C0940214
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23C0940214
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665589899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VEmL4QPQ3D0Tb37hjB24vN30XeOf49ixlW7Qc6HLGRk=;
 b=WJaeT/hfRBNbHlU9zu2CWUNrf7ywGPPVInm8zmeodjK+DCusFlRdQgfbxPetkh306Sny4b
 KtCW7YcTZN9NPgQNxa8A7kJSTgNSJNEEFdljPDvDZFVvtK5IP/ct5SorE6Js1zc1E0nYi7
 I1SAgMqyhaoIa+FthdRIScvjyvtyXKQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-LnkQa5exPmefuAMkuZUesQ-1; Wed, 12 Oct 2022 11:51:38 -0400
X-MC-Unique: LnkQa5exPmefuAMkuZUesQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 k38-20020a05600c1ca600b003b49a809168so1313132wms.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 08:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEmL4QPQ3D0Tb37hjB24vN30XeOf49ixlW7Qc6HLGRk=;
 b=lh/uRoRiYEFfF42EjFeajqH2qqfNPjRRmH+n2CWiBuEFiSgR2OnDOYPOwuruUT+qhU
 c3EMBvKEQ7SACMWmt4uJXdpJNwCwhPtGbRFB8fLGdEFzfzWBgAvdGBlNICMJlTS2GbdH
 vw8fBUSErOd+7ziz2z+GjMtI7gfIALjxiHX/VzfD5VGIbTZk9/2JfO/Hv7ouQRO3IEv+
 gZApOaDMK4YuWdaor3Hzp3Nc0YEUyeoZU48fdJynMfZyYV/hs88C0rOv1gfPY6vlc6Q6
 lDsMp4UkGsp0y3jZlmMn72dfO+lWx0fXRKo9cdwNfWyAn5KmF6PFoddd+SM9vIULOQON
 mynA==
X-Gm-Message-State: ACrzQf0L7KrYfXNtdFlw3oaVVuxxhlrK1hPNmN6zzktxyBsdtmIMcGKM
 Bq8byygMCWIWBe9WqBKVAZAX+SoPhnOFVDo6D/dViINd/zJHdNer4SNWUwqYSKzUd/K2vd88mLP
 PBboarSUkjmlrNNo5xz+cukWOqybaZpjejdC1dbuW2Q==
X-Received: by 2002:a7b:c047:0:b0:3b4:adc7:1ecb with SMTP id
 u7-20020a7bc047000000b003b4adc71ecbmr3255625wmc.144.1665589897405; 
 Wed, 12 Oct 2022 08:51:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7N8bKAUKvYW6q1makifjzVvultjsSZhoTQJypXKec3ISNPJh+4qwpbqB9CUNsCQPvo9cbiyw==
X-Received: by 2002:a7b:c047:0:b0:3b4:adc7:1ecb with SMTP id
 u7-20020a7bc047000000b003b4adc71ecbmr3255614wmc.144.1665589897125; 
 Wed, 12 Oct 2022 08:51:37 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 d17-20020adfe891000000b0022e62529888sm32297wrm.67.2022.10.12.08.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 08:51:36 -0700 (PDT)
Date: Wed, 12 Oct 2022 11:51:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [GIT PULL] virtio: fixes, features
Message-ID: <20221012115023-mutt-send-email-mst@kernel.org>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au>
 <87edvdm7qg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <87edvdm7qg.fsf@mpe.ellerman.id.au>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Thu, Oct 13, 2022 at 01:33:59AM +1100, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > [ Cc += Bjorn & linux-pci ]
> >
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> On Wed, Oct 12, 2022 at 05:21:24PM +1100, Michael Ellerman wrote:
> >>> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > ...
> >>> > ----------------------------------------------------------------
> >>> > virtio: fixes, features
> >>> >
> >>> > 9k mtu perf improvements
> >>> > vdpa feature provisioning
> >>> > virtio blk SECURE ERASE support
> >>> >
> >>> > Fixes, cleanups all over the place.
> >>> >
> >>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> >
> >>> > ----------------------------------------------------------------
> >>> > Alvaro Karsz (1):
> >>> >       virtio_blk: add SECURE ERASE command support
> >>> >
> >>> > Angus Chen (1):
> >>> >       virtio_pci: don't try to use intxif pin is zero
> >>> 
> >>> This commit breaks virtio_pci for me on powerpc, when running as a qemu
> >>> guest.
> >>> 
> >>> vp_find_vqs() bails out because pci_dev->pin == 0.
> >>> 
> >>> But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
> >>> succeed if we called it - which is what the code used to do.
> >>> 
> >>> I think this happens because pci_dev->pin is not populated in
> >>> pci_assign_irq().
> >>> 
> >>> I would absolutely believe this is bug in our PCI code, but I think it
> >>> may also affect other platforms that use of_irq_parse_and_map_pci().
> >>
> >> How about fixing this in of_irq_parse_and_map_pci then?
> >> Something like the below maybe?
> >> 
> >> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> >> index 196834ed44fe..504c4d75c83f 100644
> >> --- a/drivers/pci/of.c
> >> +++ b/drivers/pci/of.c
> >> @@ -446,6 +446,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
> >>  	if (pin == 0)
> >>  		return -ENODEV;
> >>  
> >> +	pdev->pin = pin;
> >> +
> >>  	/* Local interrupt-map in the device node? Use it! */
> >>  	if (of_get_property(dn, "interrupt-map", NULL)) {
> >>  		pin = pci_swizzle_interrupt_pin(pdev, pin);
> 
> Backing up a bit. Should the virtio code be looking at pci_dev->pin in
> the first place?
> 
> Shouldn't it be checking pci_dev->irq instead?
> 
> The original commit talks about irq being 0 and colliding with the timer
> interrupt.
> 
> But all (most?) platforms have converged on 0 meaning NO_IRQ since quite
> a fews ago AFAIK.

Are you sure?

arch/arm/include/asm/irq.h:#ifndef NO_IRQ
arch/arm/include/asm/irq.h:#define NO_IRQ       ((unsigned int)(-1))



> And the timer irq == 0 is a special case AIUI:
>   https://lore.kernel.org/all/CA+55aFwiLp1z+2mzkrFsid1WZQ0TQkcn8F2E6NL_AVR+m1fZ2w@mail.gmail.com/
> 
> cheers

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
