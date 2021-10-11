Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D14C433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 19:09:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8A66103C
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 19:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C8A66103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE6C1608DB;
	Mon, 11 Oct 2021 19:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQubz6mygTKW; Mon, 11 Oct 2021 19:09:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D679608B3;
	Mon, 11 Oct 2021 19:09:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53D34C000F;
	Mon, 11 Oct 2021 19:09:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC420C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 19:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB080404A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 19:09:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W4CzkAut1tmp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 19:09:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E39740322
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 19:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633979359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oZEQAOmKk6R+KRX2BzvVHC2H3CodKlCG/yzYUUC2zJA=;
 b=KwudnqNUzol5PC2894sI4uG23yAdPLAGs9D71BmLU2f1sO67SCq5ezRs0ddtPX9/roDXEF
 vt9nC3FQ5vwzV7E6nGWRVu2CNYq4TnGDtZMJE4zgfTsYOl7q+k/xB7cgf8kFOLjHHqYvk1
 g2bK/LrvgBfhbsZqn5BVXa5zWqitjnA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-SK3z9U7vNw2uTgcb_4eXLQ-1; Mon, 11 Oct 2021 15:09:17 -0400
X-MC-Unique: SK3z9U7vNw2uTgcb_4eXLQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 l10-20020a056402230a00b003db6977b694so8377247eda.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 12:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oZEQAOmKk6R+KRX2BzvVHC2H3CodKlCG/yzYUUC2zJA=;
 b=2I/lJMbjSx6bDLGhOmtQiUhbFx/mhEwEn+IvENC4veI2so1Nfo1wsCRrqNUiciVMqU
 FW8vDf8tLpDltIboWBIq01Sy+sySoivmMOv+yfCPcM5p5cg1kaUOuxgT97VjWsqgiCcC
 E+DjhUA/RA6Y61Kvn6K74eiCQzIPvDqnzBsVfdjvEkDJYNlOHFe3G7jVpH7txJqG5Ti4
 ugXXccpa0wnEhhu+nPFadNmXflddJ3X5dPEtRMqx16QY9TGc0gZkqlkYJCAuy5rnkXuL
 S3XhHigUpp/f2NNGNhRy2m3JEVGYB/XnTR3ZEoKWFIiG8Yvu/xTkgbR6YgkQ9kmL2i2n
 R9bg==
X-Gm-Message-State: AOAM531ScXTrYaOMMVBEN8gjCsRdXt62iDsqHfB/wc79KJB2PUIhKl1K
 tQGEgxOBxgpfgRNHqWUX6iyHKST9eg+jQstFAiqUE+A+jylAg/jqz0yMXjpThWGOxuSIp/By2hN
 xCUwjCsSlME+/w8cwetGK3GqLu0TLyWksjC6VIitndg==
X-Received: by 2002:aa7:c38b:: with SMTP id k11mr4113148edq.79.1633979356728; 
 Mon, 11 Oct 2021 12:09:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGboOz6J9azwkeciPdL9sKClCOiUS/XGJc/PjIe5OTL3dASYPSk/hflbIEKyA9zwBTklJK0A==
X-Received: by 2002:aa7:c38b:: with SMTP id k11mr4113103edq.79.1633979356541; 
 Mon, 11 Oct 2021 12:09:16 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
 by smtp.gmail.com with ESMTPSA id z4sm5250327edd.46.2021.10.11.12.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Oct 2021 12:09:15 -0700 (PDT)
Date: Mon, 11 Oct 2021 15:09:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211011142956-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWPunfa+WK86Cgnv@infradead.org>
 <a070274e-6a3a-fb0a-68ff-d320d0729377@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <a070274e-6a3a-fb0a-68ff-d320d0729377@linux.intel.com>
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
 sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Mon, Oct 11, 2021 at 10:23:00AM -0700, Andi Kleen wrote:
> 
> On 10/11/2021 12:58 AM, Christoph Hellwig wrote:
> > Just as last time:  This does not make any sense.  ioremap is shared
> > by definition.
> 
> It's not necessarily shared with the host for confidential computing: for
> example BIOS mappings definitely should not be shared, but they're using
> ioremap today.

That just needs to be fixed.

> But if you have a better term please propose something. I tried to clarify
> it with "shared_host", but I don't know a better term.
> 
> 
> -Andi
> 


The reason we have trouble is that it's not clear what does the API mean
outside the realm of TDX.
If we really, truly want an API that says "ioremap and it's a hardened
driver" then I guess ioremap_hardened_driver is what you want.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
