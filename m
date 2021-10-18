Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7105C433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 12:08:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9248161283
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 12:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9248161283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 515BB403ED;
	Mon, 18 Oct 2021 12:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JajKIYx50vrt; Mon, 18 Oct 2021 12:08:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAA83403E9;
	Mon, 18 Oct 2021 12:08:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72FE6C0011;
	Mon, 18 Oct 2021 12:08:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7E62C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 12:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4ABC403E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 12:08:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d4QQWBWjS-FP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 12:08:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D081403ED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 12:08:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A32D60EFF;
 Mon, 18 Oct 2021 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1634558916;
 bh=vkWcBlEDJXGIxjZypm/BJbICnDvEF+3H0d23MuRGm0Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xFY0CQIXOwGC6S/lmBC22FQvTURuAJbwgyviVkrlrX8Mn/O9HkF0JIeIpzI+IH/lx
 W6qI1WdW7TfVaU0Vrbbwe8qJBYNXdjvL3Akm8XpeqHPq/DcFsw1XJTuGpuaK9GQ+Ym
 PR6IHySueEDqDoLJehztNpkbl1O34b4exMMmwGpY=
Date: Mon, 18 Oct 2021 14:08:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <YW1jwc44EIx6/VAu@kroah.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>, X86 ML <x86@kernel.org>,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Reshetova,
 Elena" <elena.reshetova@intel.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Sun, Oct 10, 2021 at 03:11:23PM -0700, Andi Kleen wrote:
> 
> On 10/9/2021 1:39 PM, Dan Williams wrote:
> > On Sat, Oct 9, 2021 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Fri, Oct 08, 2021 at 05:37:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > From: Andi Kleen <ak@linux.intel.com>
> > > > 
> > > > For Confidential VM guests like TDX, the host is untrusted and hence
> > > > the devices emulated by the host or any data coming from the host
> > > > cannot be trusted. So the drivers that interact with the outside world
> > > > have to be hardened by sharing memory with host on need basis
> > > > with proper hardening fixes.
> > > > 
> > > > For the PCI driver case, to share the memory with the host add
> > > > pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.
> > > > 
> > > > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > So I proposed to make all pci mappings shared, eliminating the need
> > > to patch drivers.
> > > 
> > > To which Andi replied
> > >          One problem with removing the ioremap opt-in is that
> > >          it's still possible for drivers to get at devices without going through probe.
> > > 
> > > To which Greg replied:
> > > https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
> > >          If there are in-kernel PCI drivers that do not do this, they need to be
> > >          fixed today.
> > > 
> > > Can you guys resolve the differences here?
> > I agree with you and Greg here. If a driver is accessing hardware
> > resources outside of the bind lifetime of one of the devices it
> > supports, and in a way that neither modrobe-policy nor
> > device-authorization -policy infrastructure can block, that sounds
> > like a bug report.
> 
> The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
> others) in init functions that also register drivers (thanks Elena for the
> number)
> 
> Some are probably old drivers that could be fixed, but it's quite a few
> legitimate cases. For example for platform or ISA drivers that's the only
> way they can be implemented because they often have no other enumeration
> mechanism. For PCI drivers it's rarer, but also still can happen. One
> example that comes to mind here is the x86 Intel uncore drivers, which
> support a mix of MSR, ioremap and PCI config space accesses all from the
> same driver. This particular example can (and should be) fixed in other
> ways, but similar things also happen in other drivers, and they're not all
> broken. Even for the broken ones they're usually for some crufty old devices
> that has very few users, so it's likely untestable in practice.
> 
> My point is just that the ecosystem of devices that Linux supports is messy
> enough that there are legitimate exceptions from the "First IO only in probe
> call only" rule.

No, there should not be for PCI drivers.  If there is, that is a bug
that you can, and should, fix.

> And we can't just fix them all. Even if we could it would be hard to
> maintain.

Not true at all, you can fix them, and write a simple coccinelle rule to
prevent them from ever coming back in.

> Using a "firewall model" hooking into a few strategic points like we're
> proposing here is much saner for everyone.

No it is not.  It is "easier" for you because you all do not want to fix
up all of the drivers and want to add additional code complexity on top
of the current mess that we have and then you can claim that you have
"hardened" the drivers you care about.

Despite no one ever explaining exactly what "hardened" means to me.

Again, fix the existing drivers, you have the whole source, if this is
something that you all care about, it should not be hard to do.

Stop making excuses.

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
