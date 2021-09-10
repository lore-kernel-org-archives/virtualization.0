Return-Path: <SRS0=zxqJ=OA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39854C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 16:34:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF610611C7
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 16:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF610611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 914BD407DC;
	Fri, 10 Sep 2021 16:34:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hZVMGG8EJKim; Fri, 10 Sep 2021 16:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E730407D7;
	Fri, 10 Sep 2021 16:34:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13DFAC000F;
	Fri, 10 Sep 2021 16:34:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A188C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 16:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1601883F73
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 16:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nc9ERxYNXkZ3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 16:34:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A65083E8E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 16:34:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="201308969"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; d="scan'208";a="201308969"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2021 09:34:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; d="scan'208";a="581420171"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.255.212])
 ([10.212.255.212])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2021 09:34:46 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
 <20210910054044-mutt-send-email-mst@kernel.org>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
Date: Fri, 10 Sep 2021 09:34:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910054044-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
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


>>>> And we've been avoiding that drivers can self declare auditing, we've been
>>>> trying to have a separate centralized list so that it's easier to enforce
>>>> and avoids any cut'n'paste mistakes.
>>>>
>>>> -Andi
>>> Now I'm confused. What is proposed here seems to be basically that,
>>> drivers need to declare auditing by replacing ioremap with
>>> ioremap_shared.
>> Auditing is declared on the device model level using a central allow list.
> Can we not have an init call allow list instead of, or in addition to, a
> device allow list?


That would be quite complicated and intrusive. In fact I'm not even sure 
how to do maintain something like this. There are a lot of needed 
initcalls, they would all need to be marked. How can we distinguish 
them? It would be a giant auditing project. And of course how would you 
prevent it from bitrotting?


Basically it would be hundreds of changes all over the tree, just to 
avoid two changes in virtio and MSI. Approach of just stopping the 
initcalls from doing bad things is much less intrusive.

>
>> But this cannot do anything to initcalls that run before probe,
> Can't we extend module_init so init calls are validated against the
> allow list?

See above.


Also the problem isn't really with modules (we rely on udev not loading 
them), but with builtin initcalls


>
>> that's why
>> an extra level of defense of ioremap opt-in is useful.
> OK even assuming this, why is pci_iomap opt-in useful?
> That never happens before probe - there's simply no pci_device then.


Hmm, yes that's true. I guess we can make it default to opt-in for 
pci_iomap.

It only really matters for device less ioremaps.

>
> It looks suspiciously like drivers self-declaring auditing to me which
> we both seem to agree is undesirable. What exactly is the difference?


Just allow listing the ioremaps is not self declaration because the 
device will still not initialize due to the central device filter. If 
you want to use it that has to be changed.

It's just an additional safety net to contain code running before probe.


>
> Or are you just trying to disable anything that runs before probe?


Well anything that could do dangerous host interactions (like processing 
ioremap data) A lot of things are harmless and can be allowed, or 
already blocked elsewhere (e.g. we have a IO port filter). This just 
handles the ioremap/MMIO case.

> In that case I don't see a reason to touch pci drivers though.
> These should be fine with just the device model list.


That won't stop initcalls.


-Andi


>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
