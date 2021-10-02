Return-Path: <SRS0=UZhq=OW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5198C433EF
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 14:20:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4115861AF0
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 14:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4115861AF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0431884436;
	Sat,  2 Oct 2021 14:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-Q4mobXkKa0; Sat,  2 Oct 2021 14:20:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B74B8440B;
	Sat,  2 Oct 2021 14:20:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76406C000F;
	Sat,  2 Oct 2021 14:20:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 903E6C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 14:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76FD584412
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 14:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KqSp26yXuTal
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 14:20:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61D958440B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 14:20:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10125"; a="311242299"
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; d="scan'208";a="311242299"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2021 07:20:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; d="scan'208";a="565773947"
Received: from unknown (HELO [10.134.107.90]) ([10.134.107.90])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2021 07:20:23 -0700
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
 <20211002070218-mutt-send-email-mst@kernel.org> <YVg/F10PCFNOtCnL@kroah.com>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
Date: Sat, 2 Oct 2021 07:20:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVg/F10PCFNOtCnL@kroah.com>
Content-Language: en-US
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
 X86 ML <x86@kernel.org>, virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, USB list <linux-usb@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Reshetova,
 Elena" <elena.reshetova@intel.com>
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


On 10/2/2021 4:14 AM, Greg Kroah-Hartman wrote:
> On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
>> On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
>>>>    Do you have a list of specific drivers and kernel options that you
>>>> feel you now "trust"?
>>> For TDX it's currently only virtio net/block/console
>>>
>>> But we expect this list to grow slightly over time, but not at a high rate
>>> (so hopefully <10)
>> Well there are already >10 virtio drivers and I think it's reasonable
>> that all of these will be used with encrypted guests. The list will
>> grow.
> What is keeping "all" drivers from being on this list?

It would be too much work to harden them all, and it would be pointless 
because all these drivers are never legitimately needed in a virtualized 
environment which only virtualize a very small number of devices.

>   How exactly are
> you determining what should, and should not, be allowed?

Everything that has had reasonable effort at hardening can be added. But 
if someone proposes to add a driver that should trigger additional 
scrutiny in code review. We should also request them to do some fuzzing.

It's a bit similar to someone trying to add a new syscall interface. 
That also triggers much additional scrutiny for good reasons and people 
start fuzzing it.


>    How can
> drivers move on, or off, of it over time?

Adding something is submitting a patch to the allow list.

I'm not sure the "off" case would happen, unless the driver is 
completely removed, or maybe it has some unfixable security problem. But 
that is all rather unlikely.


>
> And why not just put all of that into userspace and have it pick and
> choose?  That should be the end-goal here, you don't want to encode
> policy like this in the kernel, right?

How would user space know what drivers have been hardened? This is 
really something that the kernel needs to determine. I don't think we 
can outsource it to anyone else.

Also BTW of course user space can still override it, but really the 
defaults should be a kernel policy.

There's also the additional problem that one of the goals of 
confidential guest is to just move existing guest virtual images into 
them without much changes. So it's better for such a case if as much as 
possible of the policy is in the kernel. But that's more a secondary 
consideration, the first point is really the important part.


-Andi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
