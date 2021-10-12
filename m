Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F51C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 21:12:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B696860D43
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 21:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B696860D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 771DA60C17;
	Tue, 12 Oct 2021 21:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QwtlgyKwXn8i; Tue, 12 Oct 2021 21:11:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3329360C02;
	Tue, 12 Oct 2021 21:11:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B811C000F;
	Tue, 12 Oct 2021 21:11:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 940A7C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7583660C14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6kWcyD51JFdT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:11:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC36C60C02
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634073112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HJGSIN2xKq0W1I1KYpa25UxJU8ELuu6VCKra+BOIUC4=;
 b=L0+eoCTXM42Cbk560PgozyrZRHE0ClBk3iw7QaB0e4zTeAfBB/uCG+bJnkRZ2r3z+Y17Zz
 VGo2feldxz36wDpf+z+0Zi6fikBDXJ0U+ZiH6xb3z9rXPf7QYSTPk/bUqlDOE8owR7V3cA
 oe1HkWjE6e0EwFae9i5sdGYjdmvRI7s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-0Hr7AjAVO_WCnrbFBib2uA-1; Tue, 12 Oct 2021 17:11:49 -0400
X-MC-Unique: 0Hr7AjAVO_WCnrbFBib2uA-1
Received: by mail-wr1-f72.google.com with SMTP id
 r16-20020adfbb10000000b00160958ed8acso298326wrg.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 14:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HJGSIN2xKq0W1I1KYpa25UxJU8ELuu6VCKra+BOIUC4=;
 b=POeRG6LllUOhKbNEzzz2sbEJyOXMjAmeg1BOvnngGaw+zjacEBE4HwKUf1DLcScPuI
 ggOmjj3bpj4QD7Gqnqs4Uzxz2r1RQUvH9tFYrmSLH9UVEBsM5cBWEB3srybW/nzYcLim
 SevSfSrdXiB9GWuHh8CWOP6QgqBWwMlZbRPNvMWtY8OVrUS767uJYXH9pBgoTEq+yqN1
 ZwZp0fGMUCJ8nqe9PdI0tWt1FIfJBU7tLZjuWZ9TIYOqrEPO7a2yeCsmA757ejowMShS
 ofLgc5AqyYpj419DQcgo4VuJLwhvdQijSHRUYh9W1oR/TGOjfiH3gUzkVAptzctYa0b7
 m/uw==
X-Gm-Message-State: AOAM531aOvAg/e0WoZCMgVSlFU9tpM1JhLrPzs51aBgr8O+xsw8p2Ctg
 YZMtBg8d4giLucQjkVLuHZKnML7XwpvApd9lwX96/J7OG6Sc9BaWx8onkQX2rwPkKVpUQdGBAZC
 kkupc9PFeGpCf54oSMPccnKTRPlvR5qw21H2piVg5KQ==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr35380801wrc.231.1634073108394; 
 Tue, 12 Oct 2021 14:11:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpVXZ8CwRxxdc3jOF9zqv7UA5V/rSW0PqfcHy6Y1h8eiycZBeLZrenWoni8OECj28KdQIXIQ==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr35380772wrc.231.1634073108176; 
 Tue, 12 Oct 2021 14:11:48 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
 by smtp.gmail.com with ESMTPSA id s3sm11456516wrm.40.2021.10.12.14.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 14:11:47 -0700 (PDT)
Date: Tue, 12 Oct 2021 17:11:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211012171016-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "Luck, Tony" <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, "Lutomirski, Andy" <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
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

On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> > The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
> > others) in init functions that also register drivers (thanks Elena for
> > the number)
> 
> To provide more numbers on this. What I can see so far from a smatch-based
> analysis, we have 409 __init style functions (.probe & builtin/module_
> _platform_driver_probe excluded) for 5.15 with allyesconfig.

I don't think we care about allyesconfig at all though.
Just don't do that.
How about allmodconfig? This is closer to what distros actually do.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
