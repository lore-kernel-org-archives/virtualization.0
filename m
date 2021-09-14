Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C4CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 08:29:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546776103B
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 08:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 546776103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1819E40293;
	Tue, 14 Sep 2021 08:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Ag5fXEECZ0I; Tue, 14 Sep 2021 08:29:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 942E6400CB;
	Tue, 14 Sep 2021 08:29:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B823C000F;
	Tue, 14 Sep 2021 08:29:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C306C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 08:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B07A80D90
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 08:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="Fj0aHeO6";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="cNiMAtDb"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mR59l3271NVn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 08:29:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C82880D8E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 08:29:39 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1631608175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uHkQ2f03H/PuJHXm8XPlJhTMFmQaWQv3oameKd/9pIM=;
 b=Fj0aHeO69qk/iu1WeOScRO/audTzEodFbNV1WK85R/QJT0mRZdUMh1SxUU7ps0Pg+pBQyr
 E4BJ5vTRFeo5EUPSd5htXSrL8QFHGlpaXZ3U3XICyes1/cp0K90pfF6JckbCE9FUCWTwl5
 AlA/ZfKlDHQ7OKmFUQ8bIC0Cc7jNKc7WlUr1+2KrvTkV4Mk0sh+LQD3ayuQmgSJXOl9w6s
 psPsp59bFHrP+rE2736xe38iF9kL+EpFtGDOaxrqhjC5t71n8bZvrw9hNd/xlwJdoCPq3P
 p5a6CGsUBrceiJRgK7yAWu9ivH76OxFbaOIZkvVjZlLjOuNnQW7tpKnT7esEoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1631608175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uHkQ2f03H/PuJHXm8XPlJhTMFmQaWQv3oameKd/9pIM=;
 b=cNiMAtDbpBa10XpUJgI4NVAbvk88gwVvjrYB/S9/ooE1FdRTbPykAQS5QAHOo/8KAhxh1s
 XJcVOXKp4ZcLuHBQ==
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
Date: Tue, 14 Sep 2021 10:29:35 +0200
Message-ID: <878rzzef0w.ffs@tglx>
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
>> and disable it again
>> before reset() is invoked. That's a question of general robustness and
>> not really a question of trusted hypervisors and encrypted guests.
>
> We can do this for some MSIX interrupts, sure. Not for shared interrupts though.

But you have to make sure that the handler does not run before and after
the defined points. And that's even more important for shared because
with shared interrupts the interrupt can be raised at any point in time
via the other devices which share the line.

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
