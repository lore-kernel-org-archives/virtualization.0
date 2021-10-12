Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F5C433FE
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 21:18:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4C0610F8
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 21:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B4C0610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 46FF4404AE;
	Tue, 12 Oct 2021 21:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yvoFOIS8BP88; Tue, 12 Oct 2021 21:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D074E40150;
	Tue, 12 Oct 2021 21:18:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5690C000F;
	Tue, 12 Oct 2021 21:18:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 487F8C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4360E404A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OJ8QXLfIpodr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:18:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A2D740150
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 21:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634073519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9gTeGrsi2W3a53jAeuwmK0vZqpG0/BE4xVwWIpQUl1c=;
 b=VFvYUD6X4jylMsPj90lcrGlObpw8PiNAXuUiCuaf/VuF9buckFYNipcHk1Otbx9DNdBxWX
 09MafsM8+pZ6eCoPVxwFSIkj94yNDD0h3K6z6iaM41lmwINCVX6gkHE0Avn8G2FR6kZhNP
 iEUSFPEMzweYUQzGGLK5BOfQXVkLiGE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-UsuCPOT7MH2t3qBTMakTZw-1; Tue, 12 Oct 2021 17:18:38 -0400
X-MC-Unique: UsuCPOT7MH2t3qBTMakTZw-1
Received: by mail-wr1-f70.google.com with SMTP id
 d13-20020adf9b8d000000b00160a94c235aso355197wrc.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 14:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9gTeGrsi2W3a53jAeuwmK0vZqpG0/BE4xVwWIpQUl1c=;
 b=Mst1Rn1vCz3+4HpMloH0al/a5YUEjm8l4YKRBxASSlf7JEwe710qxeRvm9jJ1vsJ6W
 aW2gT2bcVwtt+mWsflnultITeLY6Cu4rDbU+zKnkYdK0MInXqZ6IOVpYDICGuOoGEIhH
 QJUm7dBdOcwOc240CeYp8UbZJsrXGmsJqI19bHwRFRy8IB44uGv87CM5bWHQusbonyRr
 nmvgZwhnc+itSZZFXYy/+ijD80vR7u7JVnFMKSBJi2O5unr+Fq9FHuwyai5njLbfxAbF
 dj3XAiZrqL1wuehVd2rdW2+ij39RLL/Vz6bwoFKaEw2qnhmcvt/Kzj29+JNKbAFKsti+
 IwLg==
X-Gm-Message-State: AOAM532hjEupgs0/Xy8/xrtYYFpThPae8W+tcNQBMdd3C6aaaQnv4hgt
 gy0/Pcf252GDDw+EHI75SC+kZfOFGulpgPcuftHRhNlUcaVj6z5UcmnJ4BpP2f4mEhQKspwkVUy
 GsoAAHAyBCyPfRwsivL/plidbJgudcilpP8egIgmgsg==
X-Received: by 2002:adf:a502:: with SMTP id i2mr33893039wrb.311.1634073516968; 
 Tue, 12 Oct 2021 14:18:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjGgSxkLoHx5w6cOxEFC0Oz/08nxpy9u+bE29gjEXJrmWnhBhSxvdOuRrJNEuQ5aFXEiU9tQ==
X-Received: by 2002:adf:a502:: with SMTP id i2mr33892998wrb.311.1634073516828; 
 Tue, 12 Oct 2021 14:18:36 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
 by smtp.gmail.com with ESMTPSA id p18sm11430249wrn.41.2021.10.12.14.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 14:18:36 -0700 (PDT)
Date: Tue, 12 Oct 2021 17:18:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211012171628-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <CAPcyv4g0v0YHZ-okxf4wwVCYxHotxdKwsJpZGkoT+fhvvAJEFg@mail.gmail.com>
 <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
 <CAPcyv4hG0HcbUO8Mb=ccDp5Bz3RJNkAJwKwNzRkQ1gCMpp_OMQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hG0HcbUO8Mb=ccDp5Bz3RJNkAJwKwNzRkQ1gCMpp_OMQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, "Reshetova, Elena" <elena.reshetova@intel.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
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

On Tue, Oct 12, 2021 at 02:14:44PM -0700, Dan Williams wrote:
> Especially in this case where the virtio use case being
> opted-in is *already* in a path that has been authorized by the
> device-filter policy engine.

That's a good point. Andi, how about setting a per-device flag
if its ID has been allowed and then making pci_iomap create
a shared mapping transparently?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
