Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074BBC433FE
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 18:22:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B900060F0F
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 18:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B900060F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 819A280FFF;
	Mon, 11 Oct 2021 18:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5hMtbz0h0Gv; Mon, 11 Oct 2021 18:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B19180EC8;
	Mon, 11 Oct 2021 18:22:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C173AC0011;
	Mon, 11 Oct 2021 18:22:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C10D1C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 18:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9ED6D80FFF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 18:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L__eqO2V_k6G
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 18:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67ED780EC8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 18:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633976565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dMNh2Z50mjXzYsw8NI8wyY+ikUuFKE6oW0fJI23ISWw=;
 b=ft6/vqCLOW8Gf/FHmbkaFNU2Za9N4AxyBMUsvsFcEuK9qS5wQS9jAIYvqRYa5sJ7dNnyNu
 CS8YhEhMT05S2Gdk838nfUGEcMetGtCOo06L8e+FGt2IyV03tx9HLa2zJO+8Pf0BtbOe1e
 V4Sq6GQABIzXBV4qbUN/gKUakILqZT4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-R03JHO4KOUiYKluN4ZVXvQ-1; Mon, 11 Oct 2021 14:22:42 -0400
X-MC-Unique: R03JHO4KOUiYKluN4ZVXvQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 c8-20020a50d648000000b003daa53c7518so16571169edj.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 11:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dMNh2Z50mjXzYsw8NI8wyY+ikUuFKE6oW0fJI23ISWw=;
 b=w18z9JRhogHi80mBTQDFoYpV/k86kkIQ4Mm+kkaUdxPDKQe9quBdrnyXsaFjOSKKSe
 wnuvJfPVpdUvvc1yfGUSeR6x3TI3NUwfV0JD0mQGB0dz+GNwfTq5KQrBaMMqjpqNCIfL
 +EroNjDRoEbIrE1U1s2pBOmwc07egs6jk75mtgW0oRqUbvlVTHVRGZr4y3iufjQLL/I6
 njJcvdqGK1xZi2OHmdju+TVtWETQh9hKBoYXwAYF9GldQrgubdSCreaQ7EULOzSUgRmU
 akp0zoLVHfQtjYHW4pXTRKQ2PZTDJ9kpPcQ7/imUjzL+wGY0vTCJWuMxelnJSzeYdINx
 nUqQ==
X-Gm-Message-State: AOAM533n+Z6Q6FPTGaAxP5ot8B2+Xb0AFnOohUmJGjRoD+nwnRJMzFor
 wm8bTTiXcgfmRITOirIlkZKp9hc8JM56xgZCzKsAyVpp8H9dr/ZgmMNDMmjV4cGqwvZUQAu7E5l
 Zc1FTIhjtYYtNANVC7F9YiZygZrecYJeTnRyHtggjyg==
X-Received: by 2002:aa7:c941:: with SMTP id h1mr44235672edt.128.1633976560834; 
 Mon, 11 Oct 2021 11:22:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN/U+BRUzodKL6gvFVqtuU/Q67n/I/WAJHIiErFZ+rnv84Ucv2oE2o+msvXuPI2MK8YmvNow==
X-Received: by 2002:aa7:c941:: with SMTP id h1mr44235616edt.128.1633976560614; 
 Mon, 11 Oct 2021 11:22:40 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
 by smtp.gmail.com with ESMTPSA id u2sm4623544eda.32.2021.10.11.11.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Oct 2021 11:22:39 -0700 (PDT)
Date: Mon, 11 Oct 2021 14:22:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211011141248-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
 <20211011073614-mutt-send-email-mst@kernel.org>
 <78766e28-8353-acc8-19e2-033d4bbf3472@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <78766e28-8353-acc8-19e2-033d4bbf3472@linux.intel.com>
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

On Mon, Oct 11, 2021 at 10:32:23AM -0700, Andi Kleen wrote:
> 
> > Because it does not end with I/O operations, that's a trivial example.
> > module unloading is famous for being racy: I just re-read that part of
> > virtio drivers and sure enough we have bugs there, this is after
> > they have presumably been audited, so a TDX guest is better off
> > just disabling hot-unplug completely, and hotplug isn't far behind.
> 
> These all shouldn't matter for a confidential guest. The only way it can be
> attacked is through IO, everything else is protected by hardware.
> 
> 
> Also it would all require doing something at the guest level, which we
> assume is not malicious.
> 
> 
> > Malicious filesystems can exploit many linux systems unless
> > you take pains to limit what is mounted and how.
> 
> That's expected to be handled by authenticated dmcrypt and similar.
> Hardening at this level has been done for many years.

It's possible to do it like this, sure. But that's not the
only configuration, userspace needs to be smart about setting things up.
Which is my point really.

> 
> > Networking devices tend to get into the default namespaces and can
> > do more or less whatever CAP_NET_ADMIN can.
> > Etc.
> 
> 
> Networking should be already hardened, otherwise you would have much worse
> problems today.

Same thing. NFS is pretty common, you are saying don't do it then. Fair
enough but again, arbitrary configs just aren't going to be secure.

> 
> 
> > hange in your subsystem here.
> > Well I commented on the API patch, not the virtio patch.
> > If it's a way for a driver to say "I am hardened
> > and audited" then I guess it should at least say so.
> 
> 
> This is handled by the central allow list. We intentionally didn't want each
> driver to declare itself, but have a central list where changes will get
> more scrutiny than random driver code.

Makes sense. Additionally, distros can tweak that to their heart's
content, selecting the functionality/security balance that makes sense
for them.

> But then there are the additional opt-ins for the low level firewall. These
> are in the API. I don't see how it could be done at the driver level, unless
> you want to pass in a struct device everywhere?

I am just saying don't do it then. Don't build drivers that distro does
not want to support into kernel. And don't load them when they are
modules.

> > > > How about creating a defconfig that makes sense for TDX then?
> > > TDX can be used in many different ways, I don't think a defconfig is
> > > practical.
> > > 
> > > In theory you could do some Kconfig dependency (at the pain point of having
> > > separate kernel binariees), but why not just do it at run time then if you
> > > maintain the list anyways. That's much easier and saner for everyone. In the
> > > past we usually always ended up with runtime mechanism for similar things
> > > anyways.
> > > 
> > > Also it turns out that the filter mechanisms are needed for some arch
> > > drivers which are not even configurable, so alone it's probably not enough,
> > 
> > I guess they aren't really needed though right, or you won't try to
> > filter them?
> 
> We're addressing most of them with the device filter for platform drivers.
> But since we cannot stop them doing ioremap IO in their init code they also
> need the low level firewall.
> 
> Some others that cannot be addressed have explicit disables.
> 
> 
> > So make them configurable?
> 
> Why not just fix the runtime? It's much saner for everyone. Proposing to do
> things at build time sounds like we're in Linux 0.99 days.
> 
> -Andi

Um. Tweaking driver code is not just build time, it's development time.
At least with kconfig you don't need to patch your kernel.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
