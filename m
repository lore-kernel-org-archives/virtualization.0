Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F5CC433FE
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 21:28:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2186D60C41
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 21:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2186D60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9C9280C6B;
	Tue, 12 Oct 2021 21:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0e5rSaaKDzxg; Tue, 12 Oct 2021 21:28:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7704780CF2;
	Tue, 12 Oct 2021 21:28:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36E20C000F;
	Tue, 12 Oct 2021 21:28:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6AFEC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B571B40188
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:28:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ix8Oq8SgSsUh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:28:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D91BF40150
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:28:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="208076479"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; d="scan'208";a="208076479"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2021 14:28:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; d="scan'208";a="562834348"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.115.208])
 ([10.209.115.208])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2021 14:28:29 -0700
Message-ID: <bca75b04-f084-5bda-c071-249fd91aaa1e@linux.intel.com>
Date: Tue, 12 Oct 2021 14:28:29 -0700
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
 <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
 <CAPcyv4hG0HcbUO8Mb=ccDp5Bz3RJNkAJwKwNzRkQ1gCMpp_OMQ@mail.gmail.com>
From: Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CAPcyv4hG0HcbUO8Mb=ccDp5Bz3RJNkAJwKwNzRkQ1gCMpp_OMQ@mail.gmail.com>
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


>> But that was due to performance problems in hot paths. Nothing of this
>> applies here.
> It applies because a new API that individual driver authors is being
> proposed and that's an ongoing maintenance burden that might be
> mitigated by hiding that implementation detail from leaf drivers.

Right now we're only talking about 2 places to change, and none of those 
are actually in individual drivers, but in the virtio generic code and 
in the MSI code.

While there might be drivers in the future that do it directly it will 
be always the exception, normal drivers don't have to deal with this.



>> For me it both seems very straight forward and simple (but then I'm biased)
> You seem to be having a difficult time iterating this proposal toward
> consensus. I don't think the base principles are being contested as
> much as the semantics, scope, and need for the proposed API that is in
> the purview of all leaf driver developers.
Right now there is no leaf driver changed at all.
>
>>> I'd rather see more concerted efforts focused/limited core changes
>>> rather than leaf driver changes until there is a clearer definition of
>>> hardened.
>> A hardened driver is a driver that
>>
>> - Had similar security (not API) oriented review of its IO operations
>> (mainly MMIO access, but also PCI config space) as a non privileged user
>> interface (like a ioctl). That review should be focused on memory safety.
>>
>> - Had some fuzzing on these IO interfaces using to be released tools.
> What is the intersection of ioremap() users that are outside of the
> proposed probe authorization regime AND want confidential computing
> support?


Right now it's zero I believe.

That is there is other low level code that sets memory shared, but it's 
not using ioremap, but some other mechanisms.

>
> are needed
>>>> for booting. For example in TDX we can't print something to the console
>>>> with this mechanism, so you would never get any output before the
>>>> initrd. Just seems like a nightmare for debugging anything. There really
>>>> needs to be an authorization mechanism that works reasonably early.
>>>>
>>>> I can see a point of having user space overrides though, but we need to
>>>> have a sane kernel default that works early.
>>> Right, as I suggested [1], just enough early authorization to
>>> bootstrap/debug initramfs and then that can authorize the remainder.
>> But how do you debug the kernel then? Making early undebuggable seems
>> just bad policy to me.
> I am not proposing making the early undebuggable.


That's the implication of moving the policy into initrd.


If only initrd can authorize then it won't be possible to authorize 
before initrd, thus the early console won't work.

-Andi


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
