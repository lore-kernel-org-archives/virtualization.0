Return-Path: <SRS0=+9Ss=O5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B78C433F5
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 20:40:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB8660F9C
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 20:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADB8660F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5806D40255;
	Sat,  9 Oct 2021 20:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8-1uH-IbMRkv; Sat,  9 Oct 2021 20:40:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A6B5D40012;
	Sat,  9 Oct 2021 20:40:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85908C0011;
	Sat,  9 Oct 2021 20:40:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54A61C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 20:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33A9140504
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 20:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MPLDxCOxP2mq
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 20:40:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A644404E9
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 20:40:09 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id ls18so10143325pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 09 Oct 2021 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PNkbI6CC4MPwch06xoRoPuOpZuZRykTcMawJcvuLIGc=;
 b=Muu3r0eHUqB/dNHg2SbcMZBR59fyebiqEBsvk6PezrQlxQGwEI1ZicQJ1XHU8yb+jR
 kHSIW8u2KEJn+hh/8bqD+oSUoLGTMzHi2MKjMWxijaluyFQ9X/HFL9QP8jG3kJvP1+yC
 MFrvKW7dOAqDY1UzAuwqQRxVpGtbg2xoYhxoIQminXJgv3DKYb4mwO0GqHZDYiNWBRPr
 zX9FmLpjC1P17blRe4cxwK4BawnSAcTVigJTMtvWGUVR4Krw0LhW/yHMyjDs7LwJths0
 zTeiN6ZgCa7R3RDBLb9WPt7ZUqU0TGXpSpq1OOroQI9pRt1DcheHTMwoozKzKGHc51Jc
 ai5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PNkbI6CC4MPwch06xoRoPuOpZuZRykTcMawJcvuLIGc=;
 b=QAh/UkS0kXJG33S44v0K1cEXDbEZVvFRq+p/VqCFxMqAq9OXsqUxHw+20bxbUl4fhF
 1Kt6tZknewCpPCUbt7Bwup/k+/ysU0ibgcEk2LVYuIFKKSLTCARdBfcfrjtZ73DsEnuK
 NfNvoIXvFQgm9EHHsXF1OAJ60yjZjem7kUoRysxkx3uJnE+HDq9NBiM3/tzQDloBI/Q3
 5nk6krQLPmLN5r0Ct8FIP+/Lq79Oxe3744oNpnqaL1AEYLMlY3vkW8aXljtJEKaCptBh
 QOpf//qdMe+HOcr9gaaZVwSWDJbLjrW+4/yqUb9EHy6Vo78iVwtlRt5t/d6DAlUKX+mG
 TjnQ==
X-Gm-Message-State: AOAM5309TRY7jRzXjmwxvDONDhI2XjbQXmOnwgBk+f+SzRdeHHZVaVCK
 ABuREo1rbogL1jN1IYcWni+H1vpTNDJrfF+e4DhbEw==
X-Google-Smtp-Source: ABdhPJySd5zqNERLKr8S37E5WA9IMnevPxuJEZ9BVS6uY8X2FGjPzRDwsaOEKoQH/I5/2YcevgWJ2BJGpdsvJiUJb30=
X-Received: by 2002:a17:90a:d686:: with SMTP id
 x6mr20678375pju.8.1633812008773; 
 Sat, 09 Oct 2021 13:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211009053103-mutt-send-email-mst@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 9 Oct 2021 13:39:57 -0700
Message-ID: <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
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

On Sat, Oct 9, 2021 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Oct 08, 2021 at 05:37:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > For Confidential VM guests like TDX, the host is untrusted and hence
> > the devices emulated by the host or any data coming from the host
> > cannot be trusted. So the drivers that interact with the outside world
> > have to be hardened by sharing memory with host on need basis
> > with proper hardening fixes.
> >
> > For the PCI driver case, to share the memory with the host add
> > pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.
> >
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> So I proposed to make all pci mappings shared, eliminating the need
> to patch drivers.
>
> To which Andi replied
>         One problem with removing the ioremap opt-in is that
>         it's still possible for drivers to get at devices without going through probe.
>
> To which Greg replied:
> https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
>         If there are in-kernel PCI drivers that do not do this, they need to be
>         fixed today.
>
> Can you guys resolve the differences here?

I agree with you and Greg here. If a driver is accessing hardware
resources outside of the bind lifetime of one of the devices it
supports, and in a way that neither modrobe-policy nor
device-authorization -policy infrastructure can block, that sounds
like a bug report. Fix those drivers instead of sprinkling
ioremap_shared in select places and with unclear rules about when a
driver is allowed to do "shared" mappings. Let the new
device-authorization mechanism (with policy in userspace) be the
central place where all of these driver "trust" issues are managed.

> And once they are resolved, mention this in the commit log so
> I don't get to re-read the series just to find out nothing
> changed in this respect?
>
> I frankly do not believe we are anywhere near being able to harden
> an arbitrary kernel config against attack.
> How about creating a defconfig that makes sense for TDX then?
> Anyone deviating from that better know what they are doing,
> this API tweaking is just putting policy into the kernel  ...

Right, userspace authorization policy and select driver fixups seems
to be the answer to the raised concerns.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
