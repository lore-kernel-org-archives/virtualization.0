Return-Path: <SRS0=yNrU=OV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA04C433F5
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 01:41:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C1461A59
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 01:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91C1461A59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45FEA8439A;
	Fri,  1 Oct 2021 01:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qpyj_OwbpjoS; Fri,  1 Oct 2021 01:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D539E84397;
	Fri,  1 Oct 2021 01:41:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC3E1C0011;
	Fri,  1 Oct 2021 01:41:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A541DC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 01:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86D064050F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 01:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vHkHkvxHcAhO
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 01:41:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by smtp4.osuosl.org (Postfix) with SMTP id 3A3964050D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 01:41:16 +0000 (UTC)
Received: (qmail 489289 invoked by uid 1000); 30 Sep 2021 21:41:14 -0400
Date: Thu, 30 Sep 2021 21:41:14 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20211001014114.GB489012@rowland.harvard.edu>
References: <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104924-mutt-send-email-mst@kernel.org>
 <20210930153509.GF464826@rowland.harvard.edu>
 <20210930115243-mutt-send-email-mst@kernel.org>
 <00156941-300d-a34a-772b-17f0a9aad885@linux.intel.com>
 <20210930204447.GA482974@rowland.harvard.edu>
 <CAPcyv4j8DvsMYppRtm=+JQWc7nJGoXeAGGz9U150x0p_KekqcA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4j8DvsMYppRtm=+JQWc7nJGoXeAGGz9U150x0p_KekqcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Andreas Noever <andreas.noever@gmail.com>, "Reshetova,
 Elena" <elena.reshetova@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>, Borislav Petkov <bp@alien8.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
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

On Thu, Sep 30, 2021 at 01:52:59PM -0700, Dan Williams wrote:
> On Thu, Sep 30, 2021 at 1:44 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, Sep 30, 2021 at 12:23:36PM -0700, Andi Kleen wrote:
> > >
> > > > I don't think the current mitigations under discussion here are about
> > > > keeping the system working. In fact most encrypted VM configs tend to
> > > > stop booting as a preferred way to handle security issues.
> > >
> > > Maybe we should avoid the "trusted" term here. We're only really using it
> > > because USB is using it and we're now using a common framework like Greg
> > > requested. But I don't think it's the right way to think about it.
> > >
> > > We usually call the drivers "hardened". The requirement for a hardened
> > > driver is that all interactions through MMIO/port/config space IO/MSRs are
> > > sanitized and do not cause memory safety issues or other information leaks.
> > > Other than that there is no requirement on the functionality. In particular
> > > DOS is ok since a malicious hypervisor can decide to not run the guest at
> > > any time anyways.
> > >
> > > Someone loading an malicious driver inside the guest would be out of scope.
> > > If an attacker can do that inside the guest you already violated the
> > > security mechanisms and there are likely easier ways to take over the guest
> > > or leak data.
> > >
> > > The goal of the device filter mechanism is to prevent loading unhardened
> > > drivers that could be exploited without them being themselves malicious.
> >
> > If all you want to do is prevent someone from loading a bunch of
> > drivers that you have identified as unhardened, why not just use a
> > modprobe blacklist?  Am I missing something?
> 
> modules != drivers (i.e. multi-driver modules are a thing) and builtin
> modules do not adhere to modprobe policy.
> 
> There is also a desire to be able to support a single kernel image
> across hosts and guests. So, if you were going to say, "just compile
> all unnecessary drivers as modules" that defeats the common kernel
> image goal. For confidential computing the expectation is that the
> necessary device set is small. As you can see in the patches in this
> case it's just a few lines of PCI ids and a hack to the virtio bus to
> achieve the goal of disabling all extraneous devices by default.



If your goal is to prevent some unwanted _drivers_ from operating -- 
or all but a few desired drivers, as the case may be -- why extend 
the "authorized" API to all _devices_?  Why not instead develop a 
separate API (but of similar form) for drivers?

Wouldn't that make more sense?  It corresponds a lot more directly 
with what you say you want to accomplish.

What would you do in the theoretical case where two separate drivers 
can manage the same device, but one of them is desired (or hardened) 
and the other isn't?

Alan Stern
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
