Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12978C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 17:43:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CDC610CE
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 17:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94CDC610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E61040742;
	Tue, 12 Oct 2021 17:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7YCMab_ECnbC; Tue, 12 Oct 2021 17:43:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A581A40741;
	Tue, 12 Oct 2021 17:43:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8727AC000F;
	Tue, 12 Oct 2021 17:43:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92BF7C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 17:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7309F40426
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 17:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id erXQojt0B_Hs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 17:43:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AD3440421
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 17:43:04 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id q5so6493963pgr.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c0eaXCym61eiyhGT8GrUnwQDVzwTszJGE9WWYZbnw/I=;
 b=WxPZdN095KQgIlI5yU5qv0kDDUbBxKJaeY7ZC60bwwjCmldsE5dJp8xBjUlh2H3f7u
 KDcadpUVFwub2imKyC31S7f+xXPYC3o0QZayMhGwBFND9QSSkipX+sNLN90JdelYcTQV
 icggDdPWpuMAw4t03MeCBYYi/bC9qevHqZZYs+zUb+0aiQ7EAIJHrMdiFnYoTYu422eg
 uJNegZaUShKK4Z3PYQkHuOa7SLoCwsbTusMRGb7Z+VqP1cY9TG6mW5XMlJLFBqIp0ND4
 Qohcz53rKRmxnjn2Kc0dL0iebauPHDeU9Xe9+UkQrP37q/4ILF/V1eyPuoG9gexwZ1Jh
 vFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c0eaXCym61eiyhGT8GrUnwQDVzwTszJGE9WWYZbnw/I=;
 b=0ehpHSF1GbJyq2uVy+XVgcCdsJSBA3KvH6sfdCTB2swcuhfNMhqX/D4yluch6GoMuQ
 d/XgSbIcsbww115diRDaqMsBVWrlO2MVLpM2TYlg7LbhViBvWj/lFVTLIrEfoq5p/gZq
 MZMBzcdgm2dDarSE/PEh1mlC4ry3epvh9TNz41vCUOVSNj83/qRbq6OVUDD2hdfbsIye
 d1eeqkujevwCftNuxZp965/ynQ3+62UgVIfIAaYyJCniqyVcfUtHoEVSQ1S/lz/WM1FC
 Qu9Zm2liRoCO8rmDaFeaOmimX4D/0AxZVtjypeEXWF7CaSVeGSF4x8SVXoBdRpR2UMx8
 BkXg==
X-Gm-Message-State: AOAM533kKyK93cTLZN5oNDf2fwACpHVPhk2C2u9KNxgckNalfSbJbSfp
 PhXnRpx01PdJByiZTEB2DfLzM3bAdAZaQtEBXiMZLQ==
X-Google-Smtp-Source: ABdhPJw1VjQ62MwbxnVetu2KFatM9kheWAJJfezTYytAXzbh88FOGY4hTcSMBpDz0J/dm4EaQSnWU4J67TnjFV+cb6o=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr33331175pfb.3.1634060583829; Tue, 12
 Oct 2021 10:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
In-Reply-To: <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Oct 2021 10:42:52 -0700
Message-ID: <CAPcyv4g0v0YHZ-okxf4wwVCYxHotxdKwsJpZGkoT+fhvvAJEFg@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
To: Andi Kleen <ak@linux.intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Oct 10, 2021 at 3:11 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 10/9/2021 1:39 PM, Dan Williams wrote:
> > On Sat, Oct 9, 2021 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> On Fri, Oct 08, 2021 at 05:37:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>> From: Andi Kleen <ak@linux.intel.com>
> >>>
> >>> For Confidential VM guests like TDX, the host is untrusted and hence
> >>> the devices emulated by the host or any data coming from the host
> >>> cannot be trusted. So the drivers that interact with the outside world
> >>> have to be hardened by sharing memory with host on need basis
> >>> with proper hardening fixes.
> >>>
> >>> For the PCI driver case, to share the memory with the host add
> >>> pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.
> >>>
> >>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> So I proposed to make all pci mappings shared, eliminating the need
> >> to patch drivers.
> >>
> >> To which Andi replied
> >>          One problem with removing the ioremap opt-in is that
> >>          it's still possible for drivers to get at devices without going through probe.
> >>
> >> To which Greg replied:
> >> https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
> >>          If there are in-kernel PCI drivers that do not do this, they need to be
> >>          fixed today.
> >>
> >> Can you guys resolve the differences here?
> > I agree with you and Greg here. If a driver is accessing hardware
> > resources outside of the bind lifetime of one of the devices it
> > supports, and in a way that neither modrobe-policy nor
> > device-authorization -policy infrastructure can block, that sounds
> > like a bug report.
>
> The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
> others) in init functions that also register drivers (thanks Elena for
> the number)
>
> Some are probably old drivers that could be fixed, but it's quite a few
> legitimate cases. For example for platform or ISA drivers that's the
> only way they can be implemented because they often have no other
> enumeration mechanism. For PCI drivers it's rarer, but also still can
> happen. One example that comes to mind here is the x86 Intel uncore
> drivers, which support a mix of MSR, ioremap and PCI config space
> accesses all from the same driver. This particular example can (and
> should be) fixed in other ways, but similar things also happen in other
> drivers, and they're not all broken. Even for the broken ones they're
> usually for some crufty old devices that has very few users, so it's
> likely untestable in practice.
>
> My point is just that the ecosystem of devices that Linux supports is
> messy enough that there are legitimate exceptions from the "First IO
> only in probe call only" rule.
>
> And we can't just fix them all. Even if we could it would be hard to
> maintain.
>
> Using a "firewall model" hooking into a few strategic points like we're
> proposing here is much saner for everyone.
>
> Now we can argue about the details. Right now what we're proposing has
> some redundancies: it has both a device model filter and low level
> filter for ioremap (this patch and some others). The low level filter is
> for catching issues that don't clearly fit into the
> "enumeration<->probe" model. You could call that redundant, but I would
> call it defense in depth or better safe than sorry. In theory it would
> be enough to have the low level opt-in only, but that would have the
> drawback that is something gets enumerated after all you would have all
> kind of weird device driver failures and in some cases even killed
> guests. So I think it makes sense to have

The "better safe-than-sorry" argument is hard to build consensus
around. The spectre mitigations ran into similar problems where the
community rightly wanted to see the details and instrument the
problematic paths rather than blanket sprinkle lfence "just to be
safe". In this case the rules about when a driver is suitably
"hardened" are vague and the overlapping policy engines are confusing.

I'd rather see more concerted efforts focused/limited core changes
rather than leaf driver changes until there is a clearer definition of
hardened. I.e. instead of jumping to the assertion that fixing up
these init-path vulnerabilities are too big to fix, dig to the next
level to provide more evidence that per-driver opt-in is the only
viable option.

For example, how many of these problematic paths are built-in to the
average kernel config? A strawman might be to add a sprinkling error
exits in the module_init() of the problematic drivers, and only fail
if the module is built-in, and let modprobe policy handle the rest.

>
>
> > Fix those drivers instead of sprinkling
> > ioremap_shared in select places and with unclear rules about when a
> > driver is allowed to do "shared" mappings.
>
> Only add it when the driver has been audited and hardened.
>
> But I agree we need on a documented process for this. I will work on
> some documentation for a proposal. But essentially I think it should be
> some variant of what Elena has outlined in her talk at Security Summit.
>
> https://static.sched.com/hosted_files/lssna2021/b6/LSS-HardeningLinuxGuestForCCC.pdf
>
> That is using extra auditing/scrutiny at review time, supported with
> some static code analysis that points to the interaction points, and
> code needs to be fuzzed explicitly.
>
> However short term it's only three virtio drivers, so this is not a
> urgent problem.
>
> > Let the new
> > device-authorization mechanism (with policy in userspace)
>
>
> Default policy in user space just seems to be a bad idea here. Who
> should know if a driver is hardened other than the kernel? Maintaining
> the list somewhere else just doesn't make sense to me.

I do not understand the maintenance burden correlation of where the
policy is driven vs where the list is maintained? Even if I agreed
with the contention that out-of-tree userspace would have a hard time
tracking the "hardened" driver list there is still an in-tree
userspace path to explore. E.g. perf maintains lists of things tightly
coupled to the kernel, this authorized device list seems to be in the
same category of data.

> Also there is the more practical problem that some devices are needed
> for booting. For example in TDX we can't print something to the console
> with this mechanism, so you would never get any output before the
> initrd. Just seems like a nightmare for debugging anything. There really
> needs to be an authorization mechanism that works reasonably early.
>
> I can see a point of having user space overrides though, but we need to
> have a sane kernel default that works early.

Right, as I suggested [1], just enough early authorization to
bootstrap/debug initramfs and then that can authorize the remainder.

[1]: https://lore.kernel.org/all/CAPcyv4im4Tsj1SnxSWe=cAHBP1mQ=zgO-D81n2BpD+_HkpitbQ@mail.gmail.com/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
