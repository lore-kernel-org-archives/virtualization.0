Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9561C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 22:31:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F24F610CE
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 22:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F24F610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 589224032C;
	Mon, 13 Sep 2021 22:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VQqU7XrsGn2k; Mon, 13 Sep 2021 22:31:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E364B402FF;
	Mon, 13 Sep 2021 22:31:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C367CC0011;
	Mon, 13 Sep 2021 22:31:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E2E5C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 465E540210
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="wKie1t1e";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="0obimbJa"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VwsxFV-4NXzC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:31:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF6A440022
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:31:39 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1631572296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1Gt1t46cZyolnAF2U9fuqPB0Ne6SIX1s2ezNwbfHgs=;
 b=wKie1t1eD3ila7O0i8AUxj36N5RSBI6WglFMsuzNN/1rBn4kT9BjLIPCHa4cnYCZzyDTzc
 bA/xegx7oDxXBbpM+k/p9a/760NfwhdlaPq14FM3R5AJ4/7dq8D4E3qpg5NOGt0YRBMDZD
 eC8P1sdNbYnIC1QISKdrsHl0SLFyVo5eFDYQCVz3NsZEGlmyPMjZeh+0k+1MwW7JZij+uN
 hcutTWWVbfQvVwyNgYMtJ8tMfCAlKIYgcgWA2o6gLtHRyhX2lbepjXu5VJKQqjH+NPVdKI
 kzFKr1KCKk51+sEwczRUgJxI1AGltx8F1JWlYU46VHZqk/HQcACHgB96RfD9gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1631572296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1Gt1t46cZyolnAF2U9fuqPB0Ne6SIX1s2ezNwbfHgs=;
 b=0obimbJa7vbavMCTYbEOPY1I/1sUAJ075567RRz5J7y2xj3pNhae/5S//pPfzjdbcjapom
 qQcUvAbVK0VSdJDA==
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
In-Reply-To: <20210913164934-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
 <20210913024153-mutt-send-email-mst@kernel.org>
 <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
 <87bl4wfeq1.ffs@tglx> <20210913164934-mutt-send-email-mst@kernel.org>
Date: Tue, 14 Sep 2021 00:31:36 +0200
Message-ID: <87sfy8ds53.ffs@tglx>
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

On Mon, Sep 13 2021 at 16:54, Michael S. Tsirkin wrote:

> On Mon, Sep 13, 2021 at 09:38:30PM +0200, Thomas Gleixner wrote:
>> On Mon, Sep 13 2021 at 15:07, Jason Wang wrote:
>> > On Mon, Sep 13, 2021 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > But doen't "irq is disabled" basically mean "we told the hypervisor
>> >> > to disable the irq"?  What extractly prevents hypervisor from
>> >> > sending the irq even if guest thinks it disabled it?
>> >>
>> >> More generally, can't we for example blow away the
>> >> indir_desc array that we use to keep the ctx pointers?
>> >> Won't that be enough?
>> >
>> > I'm not sure how it is related to the indirect descriptor but an
>> > example is that all the current driver will assume:
>> >
>> > 1) the interrupt won't be raised before virtio_device_ready()
>> > 2) the interrupt won't be raised after reset()
>> 
>> If that assumption exists, then you better keep the interrupt line
>> disabled until virtio_device_ready() has completed
>
> started not completed. device is allowed to send
> config interrupts right after DRIVER_OK status is set by
> virtio_device_ready.

Whatever:

 * Define the exact point from which on the driver is able to handle the
   interrupt and put the enable after that point

 * Define the exact point from which on the driver is unable to handle
   the interrupt and put the disable before that point

The above is blury.

>> and disable it again
>> before reset() is invoked. That's a question of general robustness and
>> not really a question of trusted hypervisors and encrypted guests.
>
> We can do this for some MSIX interrupts, sure. Not for shared interrupts though.

See my reply to the next patch. The problem is the same:

 * Define the exact point from which on the driver is able to handle the
   interrupt and allow the handler to proceed after that point

 * Define the exact point from which on the driver is unable to handle
   the interrupt and ensure that the handler denies to proceed before
   that point

Same story just a different mechanism.

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
