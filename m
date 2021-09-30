Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCCAC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 19:30:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEA261A02
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 19:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CEA261A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E174C40181;
	Thu, 30 Sep 2021 19:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U2ZNU8y_CRNL; Thu, 30 Sep 2021 19:30:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B31A400D5;
	Thu, 30 Sep 2021 19:30:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CE7EC0011;
	Thu, 30 Sep 2021 19:30:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1409EC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2F4983FF0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id anG3I0_ili2c
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:30:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1242083F9B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:30:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="212346623"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="212346623"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 12:30:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="438154658"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.134.229])
 ([10.252.134.229])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 12:30:24 -0700
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <291d5e03-ccaa-3a73-cdcd-66cbe80fede1@linux.intel.com>
Date: Thu, 30 Sep 2021 12:30:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
Content-Language: en-US
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Jamet <michael.jamet@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, X86 ML <x86@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, USB list <linux-usb@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rafael@kernel.org>
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


On 9/30/2021 12:04 PM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 9/30/21 8:23 AM, Greg Kroah-Hartman wrote:
>> On Thu, Sep 30, 2021 at 08:18:18AM -0700, Kuppuswamy, Sathyanarayanan 
>> wrote:
>>>
>>>
>>> On 9/30/21 6:36 AM, Dan Williams wrote:
>>>>> And in particular, not all virtio drivers are hardened -
>>>>> I think at this point blk and scsi drivers have been hardened - so
>>>>> treating them all the same looks wrong.
>>>> My understanding was that they have been audited, Sathya?
>>>
>>> Yes, AFAIK, it has been audited. Andi also submitted some patches
>>> related to it. Andi, can you confirm.
>>
>> What is the official definition of "audited"?
>
>
> In our case (Confidential Computing platform), the host is an un-trusted
> entity. So any interaction with host from the drivers will have to be
> protected against the possible attack from the host. For example, if we
> are accessing a memory based on index value received from host, we have
> to make sure it does not lead to out of bound access or when sharing the
> memory with the host, we need to make sure only the required region is
> shared with the host and the memory is un-shared after use properly.
>
> Elena can share more details, but it was achieved with static analysis
> and fuzzing. Here is a presentation she is sharing about the work at the
> Linux Security Summit:
> https://static.sched.com/hosted_files/lssna2021/b6/LSS-HardeningLinuxGuestForCCC.pdf 
>
>
> Andi, can talk more about the specific driver changes that came out of 
> this
> effort.

The original virtio was quite easy to exploit because it put its free 
list into the shared ring buffer.

We had a patchkit to harden virtio originally, but after some discussion 
we instead switched to Jason Wang's patchkit to move the virtio metadata 
into protected memory, which fixed near all of the issues. These patches 
have been already merged. There is one additional patch to limit the 
virtio modes.

There's an ongoing effort to audit (mostly finished I believe) and fuzz 
the three virtio drivers (fuzzing is still ongoing).

There was also a range of changes outside virtio for code outside the 
device model. Most of it was just disabling it though.

-Andi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
