Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED9C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 18:35:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8036260EDF
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 18:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8036260EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 476894036F;
	Tue, 12 Oct 2021 18:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80331wqva6VS; Tue, 12 Oct 2021 18:35:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 750C740160;
	Tue, 12 Oct 2021 18:35:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 542A1C0011;
	Tue, 12 Oct 2021 18:35:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACC96C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 18:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E56E4028F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 18:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qnLUFH9v7ZOo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 18:35:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BE2D40160
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 18:35:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290730540"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; d="scan'208";a="290730540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2021 11:35:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; d="scan'208";a="562780166"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.115.208])
 ([10.209.115.208])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2021 11:35:05 -0700
Message-ID: <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
Date: Tue, 12 Oct 2021 11:35:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <CAPcyv4g0v0YHZ-okxf4wwVCYxHotxdKwsJpZGkoT+fhvvAJEFg@mail.gmail.com>
From: Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CAPcyv4g0v0YHZ-okxf4wwVCYxHotxdKwsJpZGkoT+fhvvAJEFg@mail.gmail.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>, X86 ML <x86@kernel.org>,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, "Reshetova, Elena" <elena.reshetova@intel.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
 linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> The "better safe-than-sorry" argument is hard to build consensus
> around. The spectre mitigations ran into similar problems where the
> community rightly wanted to see the details and instrument the
> problematic paths rather than blanket sprinkle lfence "just to be
> safe".

But that was due to performance problems in hot paths. Nothing of this 
applies here.

> In this case the rules about when a driver is suitably
> "hardened" are vague and the overlapping policy engines are confusing.

What is confusing exactly?

For me it both seems very straight forward and simple (but then I'm biased)

The policy is:

- Have an allow list at driver registration.

- Have an additional opt-in for MMIO mappings (and potentially config 
space, but that's not currently there) to cover init calls completely.

>
> I'd rather see more concerted efforts focused/limited core changes
> rather than leaf driver changes until there is a clearer definition of
> hardened.

A hardened driver is a driver that

- Had similar security (not API) oriented review of its IO operations 
(mainly MMIO access, but also PCI config space) as a non privileged user 
interface (like a ioctl). That review should be focused on memory safety.

- Had some fuzzing on these IO interfaces using to be released tools.

Right now it's only three virtio drivers (console, net, block)

Really it's no different than what we do for every new unprivileged user 
interface.


> I.e. instead of jumping to the assertion that fixing up
> these init-path vulnerabilities are too big to fix, dig to the next
> level to provide more evidence that per-driver opt-in is the only
> viable option.
>
> For example, how many of these problematic paths are built-in to the
> average kernel config?

I don't think arguments from "the average kernel config" (if such a 
thing even exists) are useful. That's would be just hand waving.


> A strawman might be to add a sprinkling error
> exits in the module_init() of the problematic drivers, and only fail
> if the module is built-in, and let modprobe policy handle the rest.


That would be already hundreds of changes. I have no idea how such a 
thing could be maintained or sustained either.

Really I don't even see how these alternatives can be considered. Tree 
sweeps should always be last resort. They're a pain for everyone. But 
here they're casually thrown around as alternatives to straight forward 
one or two line changes.




>
>> Default policy in user space just seems to be a bad idea here. Who
>> should know if a driver is hardened other than the kernel? Maintaining
>> the list somewhere else just doesn't make sense to me.
> I do not understand the maintenance burden correlation of where the
> policy is driven vs where the list is maintained?

All the hardening and auditing happens in the kernel tree. So it seems 
the natural place to store the result is in the kernel tree.

But there's no single package for initrd, so you would need custom 
configurations for all the supported distros.

Also we're really arguing about a list that currently has three entries.


>   Even if I agreed
> with the contention that out-of-tree userspace would have a hard time
> tracking the "hardened" driver list there is still an in-tree
> userspace path to explore. E.g. perf maintains lists of things tightly
> coupled to the kernel, this authorized device list seems to be in the
> same category of data.

You mean the event list? perf is in the kernel tree, so it's maintained 
together with the kernel.

But we don't have a kernel initrd.



>
>> Also there is the more practical problem that some devices are needed
>> for booting. For example in TDX we can't print something to the console
>> with this mechanism, so you would never get any output before the
>> initrd. Just seems like a nightmare for debugging anything. There really
>> needs to be an authorization mechanism that works reasonably early.
>>
>> I can see a point of having user space overrides though, but we need to
>> have a sane kernel default that works early.
> Right, as I suggested [1], just enough early authorization to
> bootstrap/debug initramfs and then that can authorize the remainder.

But how do you debug the kernel then? Making early undebuggable seems 
just bad policy to me.

And if you fix if for the console why not add the two more entries for 
virtio net and block too?


-Andi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
