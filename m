Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F45C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 21:00:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B19610A4
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 21:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33B19610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0A83824A4;
	Tue, 12 Oct 2021 21:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6l0kQUnewFsp; Tue, 12 Oct 2021 21:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6FA9824BD;
	Tue, 12 Oct 2021 21:00:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6123EC0011;
	Tue, 12 Oct 2021 21:00:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB7DC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79CBC60C02
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id THw9kfnFnjEM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:00:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97C3F60833
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634072402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exp5E6dmY1PTSyKlOFa3gXPk4wQssFca5mHGxtbGag0=;
 b=fFKEcQ16sHWfHcNMycKLTh5a5cKdpKeBIwJoF+xnTjn9x6RDlkqLfRzjp9Ob/KcoJ7ldHE
 IzqnxW3ySr5JzXTEZ8khRcl/SMOovKmRB3eYDJoukkHKzVol1Hj+bFjxOU7hBIj3n3l8VM
 xRlo07jp5C/YoVzPKAB6EmCxQpbeIsM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-5gxd1W63MvqhdZXsQFAtxQ-1; Tue, 12 Oct 2021 16:59:59 -0400
X-MC-Unique: 5gxd1W63MvqhdZXsQFAtxQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 k2-20020adfc702000000b0016006b2da9bso327099wrg.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 13:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Exp5E6dmY1PTSyKlOFa3gXPk4wQssFca5mHGxtbGag0=;
 b=qgmtDDppe81lYbUi21ulxTDekXGt0gok3roaasVqK21xjxP6R+idpkC+bWNu0yGoWO
 7VpcDk34XfosVr1sKKWQUq1q5QqRUu/3SsR/utCXFfHtreLwJhtyIvVK5MsAPWJgxw8U
 rbIg+4Y6HrkPdsO6vaGAZLo2Z3X0Xta8wpzaGtaEwzeI+u1il/Z9MYiVIiTCaGwrNTUG
 9EwacNDb0Hay/bLd2llSARYPplLspOMf/kv4jKdGBQL4bICfYuDs+jCxzVikoU4Ypk1m
 auCM0zDWSAqd6E0Cj02T38bkmnN//bZY6wcoOrXXxxRLbpWJLB/7s6Fr4fN55ZGEB1QX
 IZ8Q==
X-Gm-Message-State: AOAM532PEaoEg+HXNXcU9wNVHwAiSA3JTd2BcNd1gTFe7RX9vsQnGBTP
 WOelVAKN82GqBKsSPxGdWRHG8ig/jMdMmjrO/7gcEYKB4PYzSZgNPZnySD8d+UTvjpwdvBcB6ZC
 2iIP2EwwiZxvZvJzTXhGDoem8cfoIejKxQWD8cS6SfA==
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr10798873wrx.192.1634072398167; 
 Tue, 12 Oct 2021 13:59:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBCYQfAelhSD7s+gLgNmxS7cksGV+rHTpSwlJhhXjwMp934f0UVw7OkfCfZxHBrxbJpbKA6g==
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr10798853wrx.192.1634072398013; 
 Tue, 12 Oct 2021 13:59:58 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
 by smtp.gmail.com with ESMTPSA id 36sm11465676wrc.92.2021.10.12.13.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 13:59:57 -0700 (PDT)
Date: Tue, 12 Oct 2021 16:59:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
Message-ID: <20211012165705-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009070132-mutt-send-email-mst@kernel.org>
 <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
 <20211011075945-mutt-send-email-mst@kernel.org>
 <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
 <20211011142330-mutt-send-email-mst@kernel.org>
 <4fe8d60a-2522-f111-995c-dcbefd0d5e31@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <4fe8d60a-2522-f111-995c-dcbefd0d5e31@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrea Arcangeli <aarcange@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
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

On Tue, Oct 12, 2021 at 10:55:20AM -0700, Andi Kleen wrote:
> 
> > I mean ... it's already wide spread.
> 
> 
> I meant wide spread usage with confidential guests.
> 
> > If we support it with TDX
> > it will be used with TDX.
> 
> It has some security trade offs. The main reason to use TDX is security.
> Also when people take the VT-d tradeoffs they might be ok with the BIOS
> trade offs too.
> 
> -Andi

Interesting. VT-d tradeoffs ... what are they?
Allowing hypervisor to write into BIOS looks like it will
trivially lead to code execution, won't it?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
