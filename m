Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37737C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 09:07:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5762610E8
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 09:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5762610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74C42400F5;
	Mon, 27 Sep 2021 09:07:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QLBpmVUxWV5i; Mon, 27 Sep 2021 09:07:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D1201400DB;
	Mon, 27 Sep 2021 09:07:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DEC0C0011;
	Mon, 27 Sep 2021 09:07:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D51CC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46ACD4054E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:07:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jr0_nPjy-MsV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:07:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FC294053F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632733673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KVP7Xe4ufaNCXcd20wpSSrMBsG9usYiBh4tpjUVxTUI=;
 b=A87jVk+oepUAxtpitt31u+xGVoIIAZhHvRG1ytMIxJ+Evgb5oKfi/FAAY/t0EhtGY2B8lu
 GsmusM22kaoZRJikJg9TYi0PoN98zEYTRM/R/2H1BcIJJCkx8JRF3r39x/pYwXMPCOrKZ5
 1Co2wrNmMfgPWkUPO8PgrqhlcK68OmY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-b7SJhZAgNve7sp6emFmHlw-1; Mon, 27 Sep 2021 05:07:52 -0400
X-MC-Unique: b7SJhZAgNve7sp6emFmHlw-1
Received: by mail-wr1-f71.google.com with SMTP id
 c15-20020a5d4ccf000000b0015dff622f39so13693889wrt.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 02:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KVP7Xe4ufaNCXcd20wpSSrMBsG9usYiBh4tpjUVxTUI=;
 b=4Sd4/R7RB95W0a5dmrgEdFGZDGBRaueJFfnEuGzMm/sOIzZOu7+BojaNGNx1JUhNqG
 PNMrFFJNNoPqiHHS99W60MnjaucPzMePpGxqs19kXVKaPc4ROnZHf/iB69lx17eNOUZY
 tXGTqvJ8ee2YK979YTkXp1aws6wfpqAXIDFko2vDlFyk66ngewBcrdvw68jXERBuIFy1
 TA97e2fqOAqTA+0A4Lo4W8/RxhicGkYZjQ6DT92WJ9M7EcNYtWU4frZuuG0VM3OfoDkZ
 ptjeT7oCNW54EwjAKPbDdvdGsi1HWXGUw2qWPpllOPu6n5kFN9gWHG1/iUb/WRzuMwzM
 npQg==
X-Gm-Message-State: AOAM530BgX032BZLGNDyCSoQfetBRxGoSphIxHx+vVRvBNSOcDvS8Ev9
 Nxijd1NkEHg8myMF4VyGr3d0qxiVSLyEbPn2xQhEBQNp9l6lnH9F35hOokaF9nAXHfZyPBE1N1w
 ZO/NQGGSMBtj0CL8iUfBfYVBH8mfl25Melna8lIiJCw==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr26547282wrt.18.1632733670882; 
 Mon, 27 Sep 2021 02:07:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC5dYp72FkeZBf/nNTyOGuT0oOk/w7Q1ed5WCCglQAPy4Z5zq+YWXxX5Bel6h9RljJshmxpg==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr26547249wrt.18.1632733670649; 
 Mon, 27 Sep 2021 02:07:50 -0700 (PDT)
Received: from redhat.com ([2.55.16.138])
 by smtp.gmail.com with ESMTPSA id i203sm20492120wma.7.2021.09.27.02.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 02:07:49 -0700 (PDT)
Date: Mon, 27 Sep 2021 05:07:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210927044738-mutt-send-email-mst@kernel.org>
References: <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
 <20210910054044-mutt-send-email-mst@kernel.org>
 <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
 <20210911195006-mutt-send-email-mst@kernel.org>
 <ad1e41d1-3f4e-8982-16ea-18a3b2c04019@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <ad1e41d1-3f4e-8982-16ea-18a3b2c04019@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Sep 24, 2021 at 03:43:40PM -0700, Andi Kleen wrote:
> 
> > > Hmm, yes that's true. I guess we can make it default to opt-in for
> > > pci_iomap.
> > > 
> > > It only really matters for device less ioremaps.
> > OK. And same thing for other things with device, such as
> > devm_platform_ioremap_resource.
> > If we agree on all that, this will basically remove virtio
> > changes from the picture ;)
> 
> Hi we revisited this now. One problem with removing the ioremap opt-in is
> that it's still possible for drivers to get at devices without going through
> probe. For example they can walk the PCI device list. Some drivers do that
> for various reasons. So if we remove the opt-in we would need to audit and
> possibly fix all that, which would be potentially a lot of churn. That's why
> I think it's better to keep the opt-in.
> 
> 
> -Andi
> 

I've been thinking about why this still feels wrong to me.

Here's what I came up with: at some point someone will want one of these
modules (poking at devices in the initcall) in the encrypted
environment, and will change ioremap to ioremap_shared.
At that point the allowlist will be broken again, and
by that time it will be set in stone and too late to fix.

Isn't the problem that what is actually audited is modules,
but you are trying to add devices to allow list?
So why not have modules/initcalls in the allowlist then?
For built-in modules, we already have initcall_blacklisted, right?
This could be an extension ... no?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
