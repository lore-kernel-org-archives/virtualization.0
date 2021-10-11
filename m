Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D06C433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 12:00:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ACA60F38
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 12:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82ACA60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F09C40381;
	Mon, 11 Oct 2021 12:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mk0BA5MRp4y8; Mon, 11 Oct 2021 12:00:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFB8B40262;
	Mon, 11 Oct 2021 12:00:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84212C000F;
	Mon, 11 Oct 2021 12:00:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C6EDC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 12:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A30640268
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 12:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4iaWOgf-fLjt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 11:59:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03B8D40262
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633953597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwUIXMwF5ZMBaAs7PCxNKL8UZk5q2glV6KYJyh2b2Q4=;
 b=WSQukelTmKdtW4e8dVO4rBrkyOGQWO3Gk+teXh23DW3jHemasuuFgdsZGRzmnKMlB+tKvZ
 vIUXknHm9VJCeQGRpSvZnkXsbOff7IeVJrUgNcShJr14aEViJUj/UIMQpwM7XMpVnqsU0r
 mcEmWebzHmzFNsBkH6NmZWH4sqxwlok=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-B1NFLvizNDSaQxCHd7O22w-1; Mon, 11 Oct 2021 07:59:25 -0400
X-MC-Unique: B1NFLvizNDSaQxCHd7O22w-1
Received: by mail-ed1-f70.google.com with SMTP id
 14-20020a508e4e000000b003d84544f33eso15700383edx.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 04:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hwUIXMwF5ZMBaAs7PCxNKL8UZk5q2glV6KYJyh2b2Q4=;
 b=q05pXfUk/M988/7Fjho3MYboU/iywC/453c3+O9ZEb5tvv4K+BbvzyfUIkXx31NfDN
 Wh0VrWOSJ1VK5QRNtnh2woa91nh5gw2MIIvocppjMQHbSGb6LCZuqmUip9fJY1Pvqqe7
 QQJW/+gQrz/AQ6oUqkST0YN/0r99kEkYqLGFs9gqdlyFDHo/3/C2ElVKyqSWHFJ+renS
 ZgfO///H36x7rlhkFmCMLWVMdyt2/hN9arF/7iNgVqekJdbPcd9zyMSKYCuLhjsB3+Vx
 E3ZzEniOe7PigMMe8yhGHrYekShW/7I11rVkAXwa7ISWS5Iv+eyrhkLz/bSoX5uQ92Mp
 aTgQ==
X-Gm-Message-State: AOAM532KpMAmawNhh1vJZEn8c4ENPqp4Flb3V4NcUfsK6LSMGGiaNDtD
 eQMfDf/lonYk/V51IQ1WE+jfZ80EtDrny5jzwC2zy5sFssDQTI7hIB9NvMVdmUrzswQIWmN6CcP
 vGeh9yBFGoxpNlS/EBTn/jJDyI1qHfiQPlVxOnzQ4yA==
X-Received: by 2002:a05:6402:90c:: with SMTP id
 g12mr1207562edz.139.1633953564725; 
 Mon, 11 Oct 2021 04:59:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe9IbZEyN/NuCWBVGBR/HLcEv3Q4Zpk3pvSHKKh7mzddFCxZ4eLiFif7F1M5YGcdkOoPRk/g==
X-Received: by 2002:a05:6402:90c:: with SMTP id
 g12mr1207493edz.139.1633953564478; 
 Mon, 11 Oct 2021 04:59:24 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
 by smtp.gmail.com with ESMTPSA id lb12sm3498129ejc.28.2021.10.11.04.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Oct 2021 04:59:23 -0700 (PDT)
Date: Mon, 11 Oct 2021 07:59:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211011073614-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
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

On Sun, Oct 10, 2021 at 03:22:39PM -0700, Andi Kleen wrote:
> 
> > To which Andi replied
> > 	One problem with removing the ioremap opt-in is that
> > 	it's still possible for drivers to get at devices without going through probe.
> > 
> > To which Greg replied:
> > https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
> > 	If there are in-kernel PCI drivers that do not do this, they need to be
> > 	fixed today.
> > 
> > Can you guys resolve the differences here?
> 
> 
> I addressed this in my other mail, but we may need more discussion.

Hopefully Greg will reply to that one.

> 
> > 
> > And once they are resolved, mention this in the commit log so
> > I don't get to re-read the series just to find out nothing
> > changed in this respect?
> > 
> > I frankly do not believe we are anywhere near being able to harden
> > an arbitrary kernel config against attack.
> 
> Why not? Device filter and the opt-ins together are a fairly strong
> mechanism.

Because it does not end with I/O operations, that's a trivial example.
module unloading is famous for being racy: I just re-read that part of
virtio drivers and sure enough we have bugs there, this is after
they have presumably been audited, so a TDX guest is better off
just disabling hot-unplug completely, and hotplug isn't far behind.
Malicious filesystems can exploit many linux systems unless
you take pains to limit what is mounted and how.
Networking devices tend to get into the default namespaces and can
do more or less whatever CAP_NET_ADMIN can.
Etc.
I am not saying this makes the effort worthless, I am saying userspace
better know very well what it's doing, and kernel better be
configured in a very specific way.

> And it's not that they're a lot of code or super complicated either.
> 
> You're essentially objecting to a single line change in your subsystem here.

Well I commented on the API patch, not the virtio patch.
If it's a way for a driver to say "I am hardened
and audited" then I guess it should at least say so. It has nothing
to do with host or sharing, that's an implementation detail,
and it obscures the actual limitations of the approach,
in that eventually in an ideal world all drivers would be secure
and use this API.

Yes, if that's the API that PCI gains then virtio will use it.


> > How about creating a defconfig that makes sense for TDX then?
> 
> TDX can be used in many different ways, I don't think a defconfig is
> practical.
> 
> In theory you could do some Kconfig dependency (at the pain point of having
> separate kernel binariees), but why not just do it at run time then if you
> maintain the list anyways. That's much easier and saner for everyone. In the
> past we usually always ended up with runtime mechanism for similar things
> anyways.
> 
> Also it turns out that the filter mechanisms are needed for some arch
> drivers which are not even configurable, so alone it's probably not enough,


I guess they aren't really needed though right, or you won't try to
filter them? So make them configurable?

> 
> > Anyone deviating from that better know what they are doing,
> > this API tweaking is just putting policy into the kernel  ...
> 
> Hardening drivers is kernel policy. It cannot be done anywhere else.
> 
> 
> -Andi

To clarify, the policy is which drivers to load into the kernel.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
