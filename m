Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A6CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 00:55:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678DB6124B
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 00:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 678DB6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EAE681CDB;
	Mon, 18 Oct 2021 00:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1i4oIfAF7iL8; Mon, 18 Oct 2021 00:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B70381CAF;
	Mon, 18 Oct 2021 00:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 421B5C000F;
	Mon, 18 Oct 2021 00:55:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18549C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 00:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE3D96087C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 00:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="XHU/uT6r";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="bkeSQfcw"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7DyqvyWr2x78
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 00:55:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF4D36068F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 00:55:15 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1634518512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=Gay8VmFyss97KfWC5visbOqdWAYqK9/j2DbvMiqFQuY=;
 b=XHU/uT6rxY83cF7h/S8R1Or7JEZysnYFiMTBcvx5KoySp5QBAdL72qHvO/eAZ44b/oq3vE
 btNorRbowan8FRVNNpXH6+aXAmG0xXy2yRXzb6ymU0722PLjY2grnFZ0xyYhFuMZt8oj34
 nVCwWohCP3WCdN+qHMYPSPAQitSOPg+8BNuqxg2PGTNKfNzy8XO1aG4MVazipjYuTM5Hfg
 rPKozNgBgpjTgQTFwURKcICK+nkcOLZyV12wAWjfISaiPSEk3dwNafUw/aNGmJrVIt60fW
 QrDeG4HB/o/g+NtgFglnBrD3XJ+VscmgTDiwoLvTPsn1H2T4v4+ErS5lir8cLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1634518512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=Gay8VmFyss97KfWC5visbOqdWAYqK9/j2DbvMiqFQuY=;
 b=bkeSQfcwuKqiSyUYQR5UJ5dUTJnV3GfJ5hn2kv4dlsE7Q5KIsp4P7VACv6mECyInrd/hXO
 2M0zlxRqSRVXWIAA==
To: Andi Kleen <ak@linux.intel.com>, Dan Williams
 <dan.j.williams@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
In-Reply-To: <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
Date: Mon, 18 Oct 2021 02:55:11 +0200
Message-ID: <875ytv2lu8.ffs@tglx>
MIME-Version: 1.0
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, "Reshetova, Elena" <elena.reshetova@intel.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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

Andi,

On Sun, Oct 10 2021 at 15:11, Andi Kleen wrote:
> On 10/9/2021 1:39 PM, Dan Williams wrote:
>> I agree with you and Greg here. If a driver is accessing hardware
>> resources outside of the bind lifetime of one of the devices it
>> supports, and in a way that neither modrobe-policy nor
>> device-authorization -policy infrastructure can block, that sounds
>> like a bug report.
>
> The 5.15 tree has something like ~2.4k IO accesses (including MMIO and 
> others) in init functions that also register drivers (thanks Elena for 
> the number)

These numbers are completely useless simply because they are based on
nonsensical criteria. See:

  https://lore.kernel.org/r/87r1cj2uad.ffs@tglx

> My point is just that the ecosystem of devices that Linux supports is 
> messy enough that there are legitimate exceptions from the "First IO 
> only in probe call only" rule.

Your point is based on your outright refusal to actualy do a proper
analysis and your outright refusal to help fixing the real problems.

All you have provided so far is handwaving based on a completely useless
analysis.

Sure, your goal is to get this TDX problem solved, but it's not going to
be solved by:

  1) Providing a nonsensical analysis

  2) Using #1 as an argument to hack some half baken interfaces into the
     kernel which allow you to tick off your checkbox and then leave the
     resulting mess for others to clean up.
 
Try again when you have factual data to back up your claims and factual
arguments which prove that the problem can't be fixed otherwise.

I might be repeating myself, but kernel development works this way:

  1) Hack your private POC - Yay!

  2) Sit down and think hard about the problems you identified in step
     #1. Do a thorough analysis.
  
  3) Come up with a sensible integration plan.

  4) Do the necessary grump work of cleanups all over the place

  5) Add sensible infrastructure which is understandable for the bulk
     of kernel/driver developers

  6) Let your feature fall in place

and not in the way you are insisting on:

  1) Hack your private POC - Yay!

  2) Define that this is the only way to do it and try to shove it down
     the throat of everyone.

  3) Getting told that this is not the way it works

  4) Insist on it forever and blame the grumpy maintainers who are just
     not understanding the great value of your approach.

  5) Go back to #2

You should know that already, but I have no problem to give that lecture
to you over and over again. I probably should create a form letter.

And no, you can bitch about me as much as you want. These are not my
personal rules and personal pet pieves. These are rules Linus cares
about very much and aside of that they just reflect common sense.

  The kernel is a common good and not the dump ground for your personal
  brain waste.

  The kernel does not serve Intel. Quite the contrary Intel depends on
  the kernel to work nicely with it's hardware. Ergo, Intel should have
  a vested interest to serve the kernel and take responsibility for it
  as a whole. And so should you as an Intel employee.

Just dumping your next half baken workaround does not cut it especially
not when it is not backed up by sensible arguments.

Please try again, but not before you have something substantial to back
up your claims.

Thanks,

	Thomas
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
