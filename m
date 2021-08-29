Return-Path: <SRS0=G2sl=NU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB3EC432BE
	for <virtualization@archiver.kernel.org>; Sun, 29 Aug 2021 16:43:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7153560F38
	for <virtualization@archiver.kernel.org>; Sun, 29 Aug 2021 16:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7153560F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 414AD401D9;
	Sun, 29 Aug 2021 16:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vdAxdIY4nbc1; Sun, 29 Aug 2021 16:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3C1140160;
	Sun, 29 Aug 2021 16:43:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EA35C0010;
	Sun, 29 Aug 2021 16:43:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5855FC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 16:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40E50606F1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 16:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fiv4DbrNN31x
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 16:43:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C98C606E0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 16:43:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="218207570"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; d="scan'208";a="218207570"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2021 09:43:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; d="scan'208";a="509322544"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.238.58])
 ([10.212.238.58])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2021 09:43:15 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <YSSay4zGjLaNMOh1@infradead.org>
 <2747d96f-5063-7c63-5a47-16ea299fa195@linux.intel.com>
 <20210829113023-mutt-send-email-mst@kernel.org>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <82e133af-6ad4-6910-8b1a-3f9e1a42a0fa@linux.intel.com>
Date: Sun, 29 Aug 2021 09:43:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829113023-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> All this makes sense but ioremap is such a random place to declare
> driver has been audited, and it's baked into the binary with no way for
> userspace to set policy.
>
> Again all we will end up with is gradual replacement of all ioremap
> calls with ioremap_shared as people discover a given driver does not
> work in a VM.

No the device filter will prevent that. They would need to submit 
patches to the central list.

Or they can override it at the command line, but there is already an 
option to force all ioremaps to be shared. So if you just want some 
driver to run without caring about security you can already do that 
without modifying it.

Besides the shared concept only makes sense for virtual devices, so if 
you don't have a device model for a device this will never happen either.

So I don't think your scenario of all ioremaps becoming shared will ever 
happen.


> How are you going to know driver has actually been
> audited? what the quality of the audit was? did the people doing the
> auditing understand what they are auditing for?  No way, right?

First the primary purpose of the ioremap policy is to avoid messing with 
all the legacy drivers (which is 99+% of the code base)

How to handle someone maliciously submitting a driver to the kernel is a 
completely different problem. To some degree there is trust of course. 
If someone says they audited and a maintainer trusts them with their 
statement, but they actually didn't there is a problem, but it's larger 
than just TDX. But in such a case the community code audit will also 
focus on such areas, and people interested in confidential computing 
security will also start taking a look.

And we're also working on fuzzing, so these drivers will be fuzzed at 
some point, so mistakes will be eventually found.

But in any case the ioremap policy is mainly to prevent having to handle 
this for all legacy drivers.

I would rather change the few drivers that are actually needed, than all 
the other drivers.

That's really the fundamental problem this is addressing: how to get 
reasonable security with all the legacy drivers out of the box without 
touching them.


-Andi


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
