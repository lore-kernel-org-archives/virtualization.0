Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C8C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 21:05:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AC06113B
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 21:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6AC06113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76F6980CCD;
	Tue, 24 Aug 2021 21:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ObGVRJ0_znNw; Tue, 24 Aug 2021 21:05:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E6A3580E0F;
	Tue, 24 Aug 2021 21:05:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD4D4C0010;
	Tue, 24 Aug 2021 21:05:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1F17C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 21:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C198180E0F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 21:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vK9ZoIzlH1Ck
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 21:05:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A348280CCD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 21:05:36 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id 7so19448727pfl.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=50KgIimgoHn2hLRecJ9xsYP+KbZzb8N9bfDIuPfzvjQ=;
 b=NvAgKb0THlkdDUQ0aRx+9mednYqLHP6M3XIYjenGeve36GswyogqqyEtfltG9odhSS
 sXNl+nzWb/jgjnohkyON1TK0N4HUhwZj7aRcTxvirbX0hPedZ8o7Xo7c5YpxKjNNzQYr
 zyJiMtdKa9NltLOObRsERtWbUkAqlgZSPFS2egovwI2a4M3yx8YiJOFhAZDgyiFWM4Tr
 bAb4DagRmpCRfU/tqemlilYyGEtImDNJKoZmeV/8h3FeicEkU17ZO2s8oFIsfzw7ghCP
 W7IqcpYk1aL3JziP3HtHww5os2Qnu25hR/eXZFgKZ3PqWWua0S27ru9KI2z3Lojktzjy
 vK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=50KgIimgoHn2hLRecJ9xsYP+KbZzb8N9bfDIuPfzvjQ=;
 b=uKnyJoxxw5KMb/F0+Z23/PvHl6nGn/wa5aY/GPEWSyphz30r3Z/jiKU1+EHahSoSpi
 f5vHKXBcvZcob4E0GyFwLlV5idjgwKgELmUsoulVojI6t0phis/maRX9rGs7q7zW7dzT
 eeZ78tMgs4ZsFlFb88xXNDq+GMS22X9Q3qHOuNRsF5UnWVp7xTuHmIADUmctsriOWYtr
 EVNfZ3J3wx4GyE2EzUHEyZAxkbD2a7v/raZ20hsNgqrSo/rfkm0BrVHq1CahzaRVJG5h
 MBBgJXqdftSgInSdOgThe3GVQfpaXmPms8sx06w4SEV5bU4qg75FtxnNVg1gnLu/0OiU
 BCrA==
X-Gm-Message-State: AOAM530OYpdyGUdmyn7bvvU1L1h4tNfuW6Odbf/hcKal/vomTecwkPsr
 ZZQvKZTZp534tDUuKpTeR3f1083pIZ/fqhjgy3JYxg==
X-Google-Smtp-Source: ABdhPJwkzMtO2gq/o/NUrPl5vjkkiQPqJ23InKpT9YHvAxhia00+dsPd0+b1/fg0fqEO9y3ko1JQOVp9Vu81LPNo08o=
X-Received: by 2002:a65:6642:: with SMTP id z2mr26349152pgv.240.1629839136081; 
 Tue, 24 Aug 2021 14:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210824203115.GA3492097@bjorn-Precision-5520>
 <bb8c6f96-2597-bb80-bd08-7958405e1bf5@linux.intel.com>
In-Reply-To: <bb8c6f96-2597-bb80-bd08-7958405e1bf5@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Aug 2021 14:05:25 -0700
Message-ID: <CAPcyv4jjonArG94PbuMPTZefxqnFr+PEG7Gjem0Taa_iGRmSDA@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To: Andi Kleen <ak@linux.intel.com>
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>, linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Rajat Jain <rajatja@google.com>,
 linux-arch <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
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

On Tue, Aug 24, 2021 at 1:50 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 8/24/2021 1:31 PM, Bjorn Helgaas wrote:
> > On Tue, Aug 24, 2021 at 01:14:02PM -0700, Andi Kleen wrote:
> >> On 8/24/2021 11:55 AM, Bjorn Helgaas wrote:
> >>> [+cc Rajat; I still don't know what "shared memory with a hypervisor
> >>> in a confidential guest" means,
> >> A confidential guest is a guest which uses memory encryption to isolate
> >> itself from the host. It doesn't trust the host. But it still needs to
> >> communicate with the host for IO, so it has some special memory areas that
> >> are explicitly marked shared. These are used to do IO with the host. All
> >> their usage needs to be carefully hardened to avoid any security attacks on
> >> the guest, that's why we want to limit this interaction only to a small set
> >> of hardened drivers. For MMIO, the set is currently only virtio and MSI-X.
> > Good material for the commit log next time around.  Thanks!
>
> This is all in the patch intro too, which should make it into the merge
> commits.
>
> I don't think we can reexplain the basic concepts for every individual
> patch in a large patch kit.

Maybe not the whole cover letter, but how about just a line in this
one that says "Recall that 'shared' in this context refers to memory
that lacks confidentiality and integrity protection from the VMM so
that it can communicate with the VM." Although I think
ioremap_noprotect() might be clearer than shared for the protected
guest use case?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
