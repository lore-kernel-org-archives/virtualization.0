Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B18C64E8A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 15:17:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138B222203
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 15:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138B222203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7BC562E265;
	Wed,  2 Dec 2020 15:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYssnjWnQVEb; Wed,  2 Dec 2020 15:17:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6E6C72E269;
	Wed,  2 Dec 2020 15:17:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37DE3C0859;
	Wed,  2 Dec 2020 15:17:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DA74C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 15:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 98FB3203A5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 15:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i7WBp2lLqYJh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 15:17:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id B72892E288
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 15:17:16 +0000 (UTC)
IronPort-SDR: +WtAj41zxWrB4F2IBJXLZkb0f+EAE0Y1RiQz7Ud7oRp3gj0CpDd3e0qlxeapXPWteT+XRGCfKd
 xhHgftuQuElQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173129404"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; d="scan'208";a="173129404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2020 07:17:15 -0800
IronPort-SDR: lQjhoa4rlFFBhKMBX7uKfJeK3w1ffejEELjEVz36IdY+vd5HEezdP9lCjZSbo80pcNKKTWu79z
 lWZYmP6Kw1Rg==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; d="scan'208";a="550096338"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2020 07:17:01 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andy.shevchenko@gmail.com>)
 id 1kkTtK-00BXLU-L0; Wed, 02 Dec 2020 17:18:02 +0200
Date: Wed, 2 Dec 2020 17:18:02 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3 16/17] x86/ioapic: export a few functions and data
 structures via io_apic.h
Message-ID: <20201202151802.GI4077@smile.fi.intel.com>
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <20201124170744.112180-17-wei.liu@kernel.org>
 <CAHp75Vew+yjUkcfSx33KjhPLriH6wrYWixAtn9mASRFqe4+c+Q@mail.gmail.com>
 <20201202141107.covsx4ugipuyl6he@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201202141107.covsx4ugipuyl6he@liuwe-devbox-debian-v2>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Joerg Roedel <jroedel@suse.de>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 YueHaibing <yuehaibing@huawei.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jon Derrick <jonathan.derrick@intel.com>
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

On Wed, Dec 02, 2020 at 02:11:07PM +0000, Wei Liu wrote:
> On Wed, Nov 25, 2020 at 12:26:12PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2020 at 1:46 AM Wei Liu <wei.liu@kernel.org> wrote:
> > >
> > > We are about to implement an irqchip for IO-APIC when Linux runs as root
> > > on Microsoft Hypervisor. At the same time we would like to reuse
> > > existing code as much as possible.
> > >
> > > Move mp_chip_data to io_apic.h and make a few helper functions
> > > non-static.
> > 
> > > +struct mp_chip_data {
> > > +       struct list_head irq_2_pin;
> > > +       struct IO_APIC_route_entry entry;
> > > +       int trigger;
> > > +       int polarity;
> > > +       u32 count;
> > > +       bool isa_irq;
> > > +};
> > 
> > Since I see only this patch I am puzzled why you need to have this in
> > the header?
> > Maybe a couple of words in the commit message to elaborate?
> 
> Andy, does the following answer your question?
> 
> "The chip_data stashed in IO-APIC's irq chip is mp_chip_data.  The
> implementation of Microsoft Hypevisor's IO-APIC irqdomain would like to
> manipulate that data structure, so move it to io_apic.h as well."

At least it sheds some light, thanks.

> If that's good enough, I can add it to the commit message.

It's good for a starter, but I think you have to wait for what Thomas and other
related people can say.


-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
