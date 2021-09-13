Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C28FC433FE
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 19:38:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4256023D
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 19:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A4256023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2679380EBB;
	Mon, 13 Sep 2021 19:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y8fV3uJ5KscJ; Mon, 13 Sep 2021 19:38:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C9A6C80E95;
	Mon, 13 Sep 2021 19:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92081C000F;
	Mon, 13 Sep 2021 19:38:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E0CBC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6259C80EA3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bSihkI9rnBmu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:38:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1795A80E95
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:38:34 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1631561911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SNljKPD0Xskmz5pElU9tRhA+/eVrlrzmSfYWjyc0pwQ=;
 b=Lz1rdiVRdsnnIyZTt9O+PdsZkBcUkriRCVvIxzoSwUtP9AB2zCB7wQXlSkaVmzyDa+efCP
 97t3aMTfIUSBC7VBmRsp4QJTwzZVlb0mCyhPmsoW9b/WQUdg1PafWop8XM0W5RbaHPm59a
 cy6vFLF1A3DOpN3OXWY0MEwA0oJVy4cqR7mD11os6qQzwVoqdCjvr4aemI+WH2lcUEY3+N
 tHFOoPn1z5s/aiN8Kho5XLlhNETZu5DQsR/V2EnkkoXBNcgN/SLkHgD5WhFCg44Kk9Vku1
 3DDT6heVg1SqMuCAHsAARCZHzaVObvXVGn1Kob2PNC5diFkuXd7PTA9L+O3Nyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1631561911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SNljKPD0Xskmz5pElU9tRhA+/eVrlrzmSfYWjyc0pwQ=;
 b=SufMvqF2KSz3fVI4AXwUx2qxp8cvjJJKuP2MMttHEgnS9lz4/mi1ozW/1Ac0UnCZ0bFSGS
 oDsaHyPxIjRIFLBw==
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
In-Reply-To: <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
 <20210913024153-mutt-send-email-mst@kernel.org>
 <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
Date: Mon, 13 Sep 2021 21:38:30 +0200
Message-ID: <87bl4wfeq1.ffs@tglx>
MIME-Version: 1.0
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

On Mon, Sep 13 2021 at 15:07, Jason Wang wrote:
> On Mon, Sep 13, 2021 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> > But doen't "irq is disabled" basically mean "we told the hypervisor
>> > to disable the irq"?  What extractly prevents hypervisor from
>> > sending the irq even if guest thinks it disabled it?
>>
>> More generally, can't we for example blow away the
>> indir_desc array that we use to keep the ctx pointers?
>> Won't that be enough?
>
> I'm not sure how it is related to the indirect descriptor but an
> example is that all the current driver will assume:
>
> 1) the interrupt won't be raised before virtio_device_ready()
> 2) the interrupt won't be raised after reset()

If that assumption exists, then you better keep the interrupt line
disabled until virtio_device_ready() has completed and disable it again
before reset() is invoked. That's a question of general robustness and
not really a question of trusted hypervisors and encrypted guests.

>> > > > > > > +void vp_disable_vectors(struct virtio_device *vdev)
>> > > > > > >  {
>> > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> > > > > > >       int i;
>> > > > > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>> > > > > > >               synchronize_irq(vp_dev->pci_dev->irq);

Don't you want the same change for non-MSI interrupts?

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
