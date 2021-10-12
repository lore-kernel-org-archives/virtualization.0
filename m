Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8D1C4332F
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 19:13:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0466101D
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 19:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C0466101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CC0560803;
	Tue, 12 Oct 2021 19:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TeyANIMYvz4; Tue, 12 Oct 2021 19:13:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17C9B60BB1;
	Tue, 12 Oct 2021 19:13:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEE10C000F;
	Tue, 12 Oct 2021 19:13:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7D89C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 19:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CB3F60BB1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 19:13:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EDNTi29MUYq3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 19:13:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8F7A60803
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 19:13:25 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 pi19-20020a17090b1e5300b0019fdd3557d3so400569pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x0Pu5SkQy434ZkX51MnktY5ssWOIrsLEYRF7ntLLX9U=;
 b=0jctKiGZ96Dsvad5OoCsdnFQ90uhqg1CiK1Bu0TfnxVnL6DCcOHWSNEaxF2Q506KkR
 4HtMZYOUQL39cLxqSpXNajGrgxx+RmvKyhX9L62DSpa2FFz1DwK1pXjqe0gPg6jzDMKu
 WkA7Fi0xfKpYSR5vgaxJseL9c8Tv3DOZBBhmW2kjevu4TlUZ1AYGMy6keZGF9sAknJ9l
 hDA7MVJBkGzifUBk8/e/fmnFd3BwShLwj4oAUm8kr8DgAxB3H+Xy66k+IPlhE69rsxE+
 etyGZvxl/HxhIrzvur1lJ5f+acFnxyUDpgERXDK7KG94rmnmm7OmQdlxHrmjvC6jSJ+W
 hxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x0Pu5SkQy434ZkX51MnktY5ssWOIrsLEYRF7ntLLX9U=;
 b=rZCQ6r9K/JQVhcB7YWzs0QKhU4M5MBjg3TWriHZUHRzppEvMmnX4ZU1OkYexxqnaNk
 TukqKtRzODwZYEvlnWtPZ6ZA6nyp0a6Cd4mf3UueH/6QZGU33ABKqIH2UscAHRC5grlC
 0GW9ADjzYAWnx8Fabf1HQivw1KVMuGjv5CcYrXfIw60SA05SyDnXVqR9rKkTPHwM8Azj
 0+3h8bTDr/8Q0qSzWDtWh9I9G8oltxGRWOM674R6x4enwWvM7wtila8zjVjBleLK5SH3
 2l/vzD/d7wUJAX+RKn7YGXcYYj0PwbW+uLn2eTXeV1KHreLs1BlfeZa+/Oy2+ntAZmFL
 q+SA==
X-Gm-Message-State: AOAM530M2vaqb1wSZ/ph8agNQYv9xtPt65TgGAQRn70eanNUa5Pn741/
 OrtL5B4VaLlnj20ADVOYSD8mMkIh2QLo/hONGgZANQ==
X-Google-Smtp-Source: ABdhPJyNOix5cZDMBclXmOSXO+RM6EpABwDw+QW/CroDmQMvsjA4/EVROp8ApuvNtORV3RBVktyntd/Xd2M0AJ958a8=
X-Received: by 2002:a17:90b:350f:: with SMTP id
 ls15mr8210876pjb.220.1634066005117; 
 Tue, 12 Oct 2021 12:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <f850d2d6-d427-8aeb-bd38-f9b5eb088191@linux.intel.com>
 <DM8PR11MB57505C520763DF706309E177E7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB57505C520763DF706309E177E7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Oct 2021 12:13:13 -0700
Message-ID: <CAPcyv4g8VjbMaVnXXyWVh8tXNakO9FmDXfANJmPmgvDfZX-OBA@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>, X86 ML <x86@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "Luck, Tony" <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, "Lutomirski, Andy" <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 12, 2021 at 11:57 AM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>
> > I suspect the true number is even higher because that doesn't include IO
> > inside calls to other modules and indirect pointers, correct?
>
> Actually everything should be included. Smatch has cross-function db and
> I am using it for getting the call chains and it follows function pointers.
> Also since I am starting from a list of individual read IOs, every single
> base read IO in drivers/* should be covered as far as I can see. But if it uses
> some weird IO wrappers then the actual list might be higher.

Why analyze individual IO calls? I thought the goal here was to
disable entire classes of ioremap() users?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
