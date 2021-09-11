Return-Path: <SRS0=1q83=OB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C18C433EF
	for <virtualization@archiver.kernel.org>; Sat, 11 Sep 2021 23:54:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB3361050
	for <virtualization@archiver.kernel.org>; Sat, 11 Sep 2021 23:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAB3361050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 861F740161;
	Sat, 11 Sep 2021 23:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OlzdHm2jOusd; Sat, 11 Sep 2021 23:54:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B71A4015C;
	Sat, 11 Sep 2021 23:54:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 769FCC000F;
	Sat, 11 Sep 2021 23:54:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07E8FC000D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 23:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D55E740161
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 23:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A39EbjNt0Bqh
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 23:54:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFA964015C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 23:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631404485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhzTiX0DZYV1X5ckSDoJZp4U7aZCZRTdTtc5atz14SI=;
 b=HIYOtFgY4HxMNyU0nzLti5A8vG2pVu6p4v3N2hqr9VCqnSjvaEgH03c0xLylchB2XX6JhZ
 MZja69E6+/mBnkFFoaH07qfH2BNOXewJXF/fF6FcQeepTpcoGIs0L1KGN//6havxYew7HX
 7hUkBeY6or6zno1I58JXf2KSUB2lf60=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-3wVZsbiNMZq-dk1zgIaTbg-1; Sat, 11 Sep 2021 19:54:44 -0400
X-MC-Unique: 3wVZsbiNMZq-dk1zgIaTbg-1
Received: by mail-ej1-f71.google.com with SMTP id
 n18-20020a170906089200b005dc91303dfeso2258409eje.15
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 16:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XhzTiX0DZYV1X5ckSDoJZp4U7aZCZRTdTtc5atz14SI=;
 b=mCR3vk1dEFmmQ5IFct+eW8RNyFX9HK2vNBzl7Y8A2mXcxrJJ2yoqPqvyZv5sV34PwF
 +Dxtu7fU/PIT04sh/gmJ/+ANN+8MsBRDUwqjJavc8nZ1R7RjFlq3Oq7VyvRQfzj2bGKG
 n6DV3Y00Bj+h6kOwkj3143cOIEKUtuG3xg9ODUv/ob/1O9kmHJBvZKJGBn6xeS6TxpQy
 h7S47Pr+I2wt4XqEakFq/ysMldftdFdR874sjewCfGhAouXZaP/Sw17bslEP2IdbCa5k
 Zv4wxLXyH28tgCgTZEqjJFbqz29pHO/gqVzni0pYU7UW3uMGQ1ULcjeHXncsMY9goK7D
 czSw==
X-Gm-Message-State: AOAM530j5wEHDMkhZzHleU0INtXdXZUe5/sAWrmzQ4g7rWEbITQ951VD
 S5foRUXdQWfQgeIMaIUgWgebnRpop/0QG7ox42ZlsbIKsVp6Fh6bj85ew4jShRDy2p40iifugFZ
 FkhhgxubsxCv++RoOFEY1x4by+W7KAfgpFnwxJcgHrg==
X-Received: by 2002:a17:906:5855:: with SMTP id
 h21mr4944820ejs.230.1631404482988; 
 Sat, 11 Sep 2021 16:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUJ/Dz7qpoDYQNg7a7mY8Cl7pe7fwOabdq++HQzqfzjVSc2KbxoH+7byBLBBXMvIdUmNqg2Q==
X-Received: by 2002:a17:906:5855:: with SMTP id
 h21mr4944788ejs.230.1631404482774; 
 Sat, 11 Sep 2021 16:54:42 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id n13sm1309780ejk.97.2021.09.11.16.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Sep 2021 16:54:41 -0700 (PDT)
Date: Sat, 11 Sep 2021 19:54:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210911195006-mutt-send-email-mst@kernel.org>
References: <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
 <20210910054044-mutt-send-email-mst@kernel.org>
 <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
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

On Fri, Sep 10, 2021 at 09:34:45AM -0700, Andi Kleen wrote:
> > > that's why
> > > an extra level of defense of ioremap opt-in is useful.
> > OK even assuming this, why is pci_iomap opt-in useful?
> > That never happens before probe - there's simply no pci_device then.
> 
> 
> Hmm, yes that's true. I guess we can make it default to opt-in for
> pci_iomap.
> 
> It only really matters for device less ioremaps.

OK. And same thing for other things with device, such as
devm_platform_ioremap_resource.
If we agree on all that, this will basically remove virtio
changes from the picture ;)

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
