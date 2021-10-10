Return-Path: <SRS0=pcMQ=O6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A42C4332F
	for <virtualization@archiver.kernel.org>; Sun, 10 Oct 2021 22:11:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F1260EDF
	for <virtualization@archiver.kernel.org>; Sun, 10 Oct 2021 22:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1F1260EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88D1881BC6;
	Sun, 10 Oct 2021 22:11:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GMQ7IF3M__1Q; Sun, 10 Oct 2021 22:11:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9726481BC5;
	Sun, 10 Oct 2021 22:11:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CD11C000F;
	Sun, 10 Oct 2021 22:11:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6243C000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 22:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D5864037E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 22:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id It0WwCkBvRFp
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 22:11:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 438274036D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 22:11:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226724806"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; d="scan'208";a="226724806"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2021 15:11:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; d="scan'208";a="459743239"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.83.75])
 ([10.209.83.75])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2021 15:11:24 -0700
Message-ID: <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
Date: Sun, 10 Oct 2021 15:11:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
From: Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
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
 Thomas Gleixner <tglx@linutronix.de>,
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


On 10/9/2021 1:39 PM, Dan Williams wrote:
> On Sat, Oct 9, 2021 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Fri, Oct 08, 2021 at 05:37:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> From: Andi Kleen <ak@linux.intel.com>
>>>
>>> For Confidential VM guests like TDX, the host is untrusted and hence
>>> the devices emulated by the host or any data coming from the host
>>> cannot be trusted. So the drivers that interact with the outside world
>>> have to be hardened by sharing memory with host on need basis
>>> with proper hardening fixes.
>>>
>>> For the PCI driver case, to share the memory with the host add
>>> pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.
>>>
>>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> So I proposed to make all pci mappings shared, eliminating the need
>> to patch drivers.
>>
>> To which Andi replied
>>          One problem with removing the ioremap opt-in is that
>>          it's still possible for drivers to get at devices without going through probe.
>>
>> To which Greg replied:
>> https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
>>          If there are in-kernel PCI drivers that do not do this, they need to be
>>          fixed today.
>>
>> Can you guys resolve the differences here?
> I agree with you and Greg here. If a driver is accessing hardware
> resources outside of the bind lifetime of one of the devices it
> supports, and in a way that neither modrobe-policy nor
> device-authorization -policy infrastructure can block, that sounds
> like a bug report.

The 5.15 tree has something like ~2.4k IO accesses (including MMIO and 
others) in init functions that also register drivers (thanks Elena for 
the number)

Some are probably old drivers that could be fixed, but it's quite a few 
legitimate cases. For example for platform or ISA drivers that's the 
only way they can be implemented because they often have no other 
enumeration mechanism. For PCI drivers it's rarer, but also still can 
happen. One example that comes to mind here is the x86 Intel uncore 
drivers, which support a mix of MSR, ioremap and PCI config space 
accesses all from the same driver. This particular example can (and 
should be) fixed in other ways, but similar things also happen in other 
drivers, and they're not all broken. Even for the broken ones they're 
usually for some crufty old devices that has very few users, so it's 
likely untestable in practice.

My point is just that the ecosystem of devices that Linux supports is 
messy enough that there are legitimate exceptions from the "First IO 
only in probe call only" rule.

And we can't just fix them all. Even if we could it would be hard to 
maintain.

Using a "firewall model" hooking into a few strategic points like we're 
proposing here is much saner for everyone.

Now we can argue about the details. Right now what we're proposing has 
some redundancies: it has both a device model filter and low level 
filter for ioremap (this patch and some others). The low level filter is 
for catching issues that don't clearly fit into the 
"enumeration<->probe" model. You could call that redundant, but I would 
call it defense in depth or better safe than sorry. In theory it would 
be enough to have the low level opt-in only, but that would have the 
drawback that is something gets enumerated after all you would have all 
kind of weird device driver failures and in some cases even killed 
guests. So I think it makes sense to have


> Fix those drivers instead of sprinkling
> ioremap_shared in select places and with unclear rules about when a
> driver is allowed to do "shared" mappings.

Only add it when the driver has been audited and hardened.

But I agree we need on a documented process for this. I will work on 
some documentation for a proposal. But essentially I think it should be 
some variant of what Elena has outlined in her talk at Security Summit.

https://static.sched.com/hosted_files/lssna2021/b6/LSS-HardeningLinuxGuestForCCC.pdf

That is using extra auditing/scrutiny at review time, supported with 
some static code analysis that points to the interaction points, and 
code needs to be fuzzed explicitly.

However short term it's only three virtio drivers, so this is not a 
urgent problem.

> Let the new
> device-authorization mechanism (with policy in userspace)


Default policy in user space just seems to be a bad idea here. Who 
should know if a driver is hardened other than the kernel? Maintaining 
the list somewhere else just doesn't make sense to me.

Also there is the more practical problem that some devices are needed 
for booting. For example in TDX we can't print something to the console 
with this mechanism, so you would never get any output before the 
initrd. Just seems like a nightmare for debugging anything. There really 
needs to be an authorization mechanism that works reasonably early.

I can see a point of having user space overrides though, but we need to 
have a sane kernel default that works early.

-Andi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
