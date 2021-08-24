Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90927C4320A
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 17:06:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F6F61BD4
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 17:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44F6F61BD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E993540198;
	Tue, 24 Aug 2021 17:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fvL3cOchazYV; Tue, 24 Aug 2021 17:06:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5FC40400E4;
	Tue, 24 Aug 2021 17:06:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30725C0010;
	Tue, 24 Aug 2021 17:06:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFD75C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 17:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 995FC40198
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 17:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v88e5Uyxm2QL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 17:06:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5077400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 17:06:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="215515521"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; d="scan'208";a="215515521"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2021 10:04:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; d="scan'208";a="526698792"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.119.65])
 ([10.209.119.65])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2021 10:04:27 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To: Christoph Hellwig <hch@infradead.org>,
 "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <YSSay4zGjLaNMOh1@infradead.org>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <2747d96f-5063-7c63-5a47-16ea299fa195@linux.intel.com>
Date: Tue, 24 Aug 2021 10:04:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSSay4zGjLaNMOh1@infradead.org>
Content-Language: en-US
Cc: Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
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


On 8/24/2021 12:07 AM, Christoph Hellwig wrote:
> On Mon, Aug 23, 2021 at 05:30:54PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>>
>> On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
>>>> Add a new variant of pci_iomap for mapping all PCI resources
>>>> of a devices as shared memory with a hypervisor in a confidential
>>>> guest.
>>>>
>>>> Signed-off-by: Andi Kleen<ak@linux.intel.com>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
>>> I'm a bit puzzled by this part. So why should the guest*not*  map
>>> pci memory as shared? And if the answer is never (as it seems to be)
>>> then why not just make regular pci_iomap DTRT?
>> It is in the context of confidential guest (where VMM is un-trusted). So
>> we don't want to make all PCI resource as shared. It should be allowed
>> only for hardened drivers/devices.
> Well, assuming the host can do any damage when mapped shared that also
> means not mapping it shared will completely break the drivers.

There are several cases:

- We have driver filtering active to protect you against attacks from 
the host against unhardened drivers.

In this case the drivers not working is the intended behavior.

- There is an command allow list override for some new driver, but the 
driver is hardened and shared

The other drivers will still not work, but that's also the intended behavior

- Driver filtering is disabled or the allow list override is used to 
enable some non hardened/enabled driver

There is a command line option to override the ioremap sharing default, 
it will allow all drivers to do ioremap. We would really prefer to make 
it more finegrained, but it's not possible in this case. Other drivers 
are likely attackable.

- Driver filtering is disabled (allowing attacks on the drivers) and the 
command line option for forced sharing is set.

All drivers initialize and can talk to the host through MMIO. Lots of 
unhardened drivers are likely attackable.

-Andi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
