Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B123AC433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 12:13:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6909C610A3
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 12:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6909C610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 303D7403F9;
	Mon, 18 Oct 2021 12:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id suAV8bsN5L4H; Mon, 18 Oct 2021 12:13:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8154C403F2;
	Mon, 18 Oct 2021 12:13:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55F1EC0011;
	Mon, 18 Oct 2021 12:13:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46C99C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 12:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26D0C60883
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 12:13:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pA_3B9bIgsgb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 12:13:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8A2560818
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 12:13:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F24B60FC3;
 Mon, 18 Oct 2021 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1634559214;
 bh=JZE/18szAvUy5mVaCGRgXJrrABVRJ4b0rsi8noFT/gc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IkZ3b0MSfLm82OzxCOU7adYJFi02YagmoJazhg7LEntEzfOQdqHwsXijFZPe4QPtw
 xwtKn2ZJjvqdKSJbh+62rRNRcDQXH+5QrQDVWusQU+/IlmLPXzykFgeISq0R7Wk3Gh
 hblMyMVpPBCIxh/4VYKjOCHOCmFjBQ3qVCvJK2UA=
Date: Mon, 18 Oct 2021 14:13:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <YW1k69vzJr5kbViv@kroah.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <CAPcyv4g0v0YHZ-okxf4wwVCYxHotxdKwsJpZGkoT+fhvvAJEFg@mail.gmail.com>
 <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
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

On Tue, Oct 12, 2021 at 11:35:04AM -0700, Andi Kleen wrote:
> > I'd rather see more concerted efforts focused/limited core changes
> > rather than leaf driver changes until there is a clearer definition of
> > hardened.
> 
> A hardened driver is a driver that

Ah, you do define this, thank you!

> - Had similar security (not API) oriented review of its IO operations
> (mainly MMIO access, but also PCI config space) as a non privileged user
> interface (like a ioctl). That review should be focused on memory safety.

Where is this review done?  Where is is documented?  Who is responsible
for keeping it up to date with every code change to the driver, and to
the code that the driver calls and the code that calls the driver?

> - Had some fuzzing on these IO interfaces using to be released tools.

"some"?  What tools?  What is the input, and where is that defined?  How
much fuzzing do you claim is "good enough"?

> Right now it's only three virtio drivers (console, net, block)

Where was this work done and published?  And why only 3?

> Really it's no different than what we do for every new unprivileged user
> interface.

Really?  I have seen loads of new drivers from Intel submitted in the
past months that would fail any of the above things just based on
obvious code reviews that I end up having to do...

If you want to start a "hardened driver" effort, there's a lot of real
work that needs to be done here and documented, and explained why it can
not just be done for the whole kernel...

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
