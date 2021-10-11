Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8506AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 17:32:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE9A60E78
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 17:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BE9A60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B357540457;
	Mon, 11 Oct 2021 17:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sG5kEczXLpnf; Mon, 11 Oct 2021 17:32:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5459140450;
	Mon, 11 Oct 2021 17:32:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B050C000F;
	Mon, 11 Oct 2021 17:32:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89154C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 17:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64FA540457
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 17:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QD4hQaSUTKaN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 17:32:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADDFF40450
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 17:32:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="224341797"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; d="scan'208";a="224341797"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2021 10:32:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; d="scan'208";a="440884638"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.229.69])
 ([10.255.229.69])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2021 10:32:23 -0700
Message-ID: <78766e28-8353-acc8-19e2-033d4bbf3472@linux.intel.com>
Date: Mon, 11 Oct 2021 10:32:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
 <20211011073614-mutt-send-email-mst@kernel.org>
From: Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20211011073614-mutt-send-email-mst@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrea Arcangeli <aarcange@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, "David S . Miller" <davem@davemloft.net>,
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


> Because it does not end with I/O operations, that's a trivial example.
> module unloading is famous for being racy: I just re-read that part of
> virtio drivers and sure enough we have bugs there, this is after
> they have presumably been audited, so a TDX guest is better off
> just disabling hot-unplug completely, and hotplug isn't far behind.

These all shouldn't matter for a confidential guest. The only way it can 
be attacked is through IO, everything else is protected by hardware.


Also it would all require doing something at the guest level, which we 
assume is not malicious.


> Malicious filesystems can exploit many linux systems unless
> you take pains to limit what is mounted and how.

That's expected to be handled by authenticated dmcrypt and similar. 
Hardening at this level has been done for many years.


> Networking devices tend to get into the default namespaces and can
> do more or less whatever CAP_NET_ADMIN can.
> Etc.


Networking should be already hardened, otherwise you would have much 
worse problems today.



> hange in your subsystem here.
> Well I commented on the API patch, not the virtio patch.
> If it's a way for a driver to say "I am hardened
> and audited" then I guess it should at least say so.


This is handled by the central allow list. We intentionally didn't want 
each driver to declare itself, but have a central list where changes 
will get more scrutiny than random driver code.

But then there are the additional opt-ins for the low level firewall. 
These are in the API. I don't see how it could be done at the driver 
level, unless you want to pass in a struct device everywhere?

>>> How about creating a defconfig that makes sense for TDX then?
>> TDX can be used in many different ways, I don't think a defconfig is
>> practical.
>>
>> In theory you could do some Kconfig dependency (at the pain point of having
>> separate kernel binariees), but why not just do it at run time then if you
>> maintain the list anyways. That's much easier and saner for everyone. In the
>> past we usually always ended up with runtime mechanism for similar things
>> anyways.
>>
>> Also it turns out that the filter mechanisms are needed for some arch
>> drivers which are not even configurable, so alone it's probably not enough,
>
> I guess they aren't really needed though right, or you won't try to
> filter them?

We're addressing most of them with the device filter for platform 
drivers. But since we cannot stop them doing ioremap IO in their init 
code they also need the low level firewall.

Some others that cannot be addressed have explicit disables.


> So make them configurable?

Why not just fix the runtime? It's much saner for everyone. Proposing to 
do things at build time sounds like we're in Linux 0.99 days.

-Andi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
