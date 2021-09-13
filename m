Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C8FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 20:54:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5773610A2
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 20:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5773610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C9B34014B;
	Mon, 13 Sep 2021 20:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XHUM0-Qwd1a9; Mon, 13 Sep 2021 20:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D8AC140275;
	Mon, 13 Sep 2021 20:54:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B336FC0011;
	Mon, 13 Sep 2021 20:54:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CEF8C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BA4C4030D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivG9uE_f7kLr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:54:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F83F4030B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631566456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hlpZvCk21PRwAK2AssPWCacRS5dlgslqLeUme/k+iMw=;
 b=H5JxGe5OArwC+am0XfDj6N1MhPEX3j5vgkyObmX35eK1dUvEVqpLzvPAWlpdrk/X7hin3p
 jp7VNtX386HgdB69vd+m8W00VGTrSOdBKPlP024iDHkP6/1HNq6hckNr8oef0GxojdiCBj
 OVPaXgnWmKI8sXb4VveITz5uLK/jZPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-CGrbo8ilP1--Ztw9h0_zEA-1; Mon, 13 Sep 2021 16:54:15 -0400
X-MC-Unique: CGrbo8ilP1--Ztw9h0_zEA-1
Received: by mail-wr1-f69.google.com with SMTP id
 z1-20020adfec81000000b0015b085dbde3so3108287wrn.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 13:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hlpZvCk21PRwAK2AssPWCacRS5dlgslqLeUme/k+iMw=;
 b=Br1Q2F37DM1d7w4rxG9ZqN/hxM/FTg8T5FeSPwOCOv1yRtGGS3fAMzVLzUNCVDrFsr
 FzhK8QRGAhtoYPLzCPZ9md+8bIQLLPxZXZKbblA1q4OJ2Y38K8LuJZfQq6OrOZWC3d2c
 DlOA8HgQznH4np42PhNsNBybOOnstozs6+KztyXrHFn/N0CKIEGfkW2xHpl70qsJdG5V
 YddhIZ5SJzCox5g1m9UwysMOFblMw2/pd81c9vIeXPagWm9VlgsQ7wFifHkaK4WdWt9G
 iu19gAhwBsJAePmZjNeCgc7DE65PAh8Arl0SXcObxtXeZBIx9zelBDVScYDWwCafl5PU
 m57A==
X-Gm-Message-State: AOAM533WVeaoBXQ+hTdFsPbXYNXZrTI7JjWLVt0ZVfHge02a4KrXkmUs
 hjuZzsqUeJ7GxYsTQch2R0O7cfB5qYeXnI1f7oWIUYdoXgnxjZKyad7Z8m60VjKLDft+dsfgnLs
 7IpMeqxyUdI87lNKj9Q4FF0ZwTjheBHiZnx12eZRdzw==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr14416348wrw.311.1631566453986; 
 Mon, 13 Sep 2021 13:54:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMajhI/hXKe/GPHfRteHnAZwNKo0kHbqRkuPGx3w3DgULJMMHKTbVpiprC8l4Y+VQZSXapTQ==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr14416326wrw.311.1631566453828; 
 Mon, 13 Sep 2021 13:54:13 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
 by smtp.gmail.com with ESMTPSA id w1sm7747752wmc.19.2021.09.13.13.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 13:54:13 -0700 (PDT)
Date: Mon, 13 Sep 2021 16:54:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
Message-ID: <20210913164934-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
 <20210913024153-mutt-send-email-mst@kernel.org>
 <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
 <87bl4wfeq1.ffs@tglx>
MIME-Version: 1.0
In-Reply-To: <87bl4wfeq1.ffs@tglx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, pbonzini <pbonzini@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
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

On Mon, Sep 13, 2021 at 09:38:30PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 15:07, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > But doen't "irq is disabled" basically mean "we told the hypervisor
> >> > to disable the irq"?  What extractly prevents hypervisor from
> >> > sending the irq even if guest thinks it disabled it?
> >>
> >> More generally, can't we for example blow away the
> >> indir_desc array that we use to keep the ctx pointers?
> >> Won't that be enough?
> >
> > I'm not sure how it is related to the indirect descriptor but an
> > example is that all the current driver will assume:
> >
> > 1) the interrupt won't be raised before virtio_device_ready()
> > 2) the interrupt won't be raised after reset()
> 
> If that assumption exists, then you better keep the interrupt line
> disabled until virtio_device_ready() has completed

started not completed. device is allowed to send
config interrupts right after DRIVER_OK status is set by
virtio_device_ready.

> and disable it again
> before reset() is invoked. That's a question of general robustness and
> not really a question of trusted hypervisors and encrypted guests.

We can do this for some MSIX interrupts, sure. Not for shared interrupts though.

> >> > > > > > > +void vp_disable_vectors(struct virtio_device *vdev)
> >> > > > > > >  {
> >> > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> > > > > > >       int i;
> >> > > > > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >> > > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> 
> Don't you want the same change for non-MSI interrupts?


We can't disable them - these are shared.

> Thanks,
> 
>         tglx

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
