Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23E7C433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 19:15:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89921619F7
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 19:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89921619F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 532078402C;
	Thu, 30 Sep 2021 19:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZJz6Eb0Pn0H; Thu, 30 Sep 2021 19:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F39F284015;
	Thu, 30 Sep 2021 19:15:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7988C0011;
	Thu, 30 Sep 2021 19:15:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D455C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E8FE8402C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBift6lb-i4I
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:15:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6F2E84015
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:15:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="212524817"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="212524817"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 12:15:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="438151438"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.134.229])
 ([10.252.134.229])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 12:15:17 -0700
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org> <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930103537-mutt-send-email-mst@kernel.org> <YVXOc3IbcHsVXUxr@kroah.com>
 <20210930105852-mutt-send-email-mst@kernel.org> <YVXWIVZupeAzT6bO@kroah.com>
 <f4b5a269-843f-6911-24fe-ebffb2bd4f9e@linux.intel.com>
 <YVXyqBGa5Ix5MzmD@kroah.com>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <bb27af8d-d4ba-fa70-8893-5b9939f9280a@linux.intel.com>
Date: Thu, 30 Sep 2021 12:15:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVXyqBGa5Ix5MzmD@kroah.com>
Content-Language: en-US
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Jamet <michael.jamet@intel.com>,
 linux-pci@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-kernel@vger.kernel.org,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Reshetova, Elena" <elena.reshetova@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-usb@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
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


On 9/30/2021 10:23 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 10:17:09AM -0700, Andi Kleen wrote:
>>>> The "it" that I referred to is the claim that no driver should be
>>>> touching hardware in their module init call. Andi seems to think
>>>> such drivers are worth working around with a special remap API.
>>> Andi is wrong.
>> While overall it's a small percentage of the total, there are still quite a
>> few drivers that do touch hardware in init functions. Sometimes for good
>> reasons -- they need to do some extra probing to discover something that is
>> not enumerated -- sometimes just because it's very old legacy code that
>> predates the modern driver model.
> Are any of them in the kernel today?
>
> PCI drivers should not be messing with this, we have had well over a
> decade to fix that up.


It's not just PCI driver, it's every driver that can do io port / MMIO / 
MSR / config space accesses.


Maybe read the excellent article from Jon on this:

https://lwn.net/Articles/865918/


>
>> The legacy drivers could be fixed, but nobody really wants to touch them
>> anymore and they're impossible to test.
> Pointers to them?

For example if you look over old SCSI drivers in drivers/scsi/*.c there 
is a substantial number that has a module init longer than just 
registering a driver. As a single example look at drivers/scsi/BusLogic.c

There were also quite a few platform drivers like this.


>
>> The drivers that probe something that is not enumerated in a standard way
>> have no choice, it cannot be implemented in a different way.
> PCI devices are not enumerated in a standard way???

The pci devices are enumerated in a standard way, but typically the 
driver also needs something else outside PCI that needs some other 
probing mechanism.


>
>> So instead we're using a "firewall" the prevents these drivers from doing
>> bad things by not allowing ioremap access unless opted in, and also do some
>> filtering on the IO ports The device filter is still the primary mechanism,
>> the ioremap filtering is just belts and suspenders for those odd cases.
> That's horrible, don't try to protect the kernel from itself.  Just fix
> the drivers.

I thought we had already established this last time we discussed it.

That's completely impractical. We cannot harden thousands of drivers, 
especially since it would be all wasted work since nobody will ever need 
them in virtual guests. Even if we could harden them how would such a 
work be maintained long term? Using a firewall and filtering mechanism 
is much saner for everyone.

-Andi




_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
