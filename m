Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343BFC43219
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 13:17:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E9961074
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 13:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1E9961074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B2F740418;
	Mon, 18 Oct 2021 13:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vdxz1EnPf_tA; Mon, 18 Oct 2021 13:17:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EAE28403D1;
	Mon, 18 Oct 2021 13:17:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B95D2C000F;
	Mon, 18 Oct 2021 13:17:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 288F7C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 13:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 115B0608B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 13:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vodnHhcQIlmT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 13:17:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F06F608B6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 13:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634563073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MzTAOtwulDEmvfrOMqdp9kU77zBPM/IRO9XOnd+cufc=;
 b=Zzog55VI2G2Ibuy6CANigG/Q77iyfOtp8pVcRGZiUYhusYfqwNrowcR2msszISgJ6fF757
 nXG8C9ziKGNU2HQVFOLp5FOevznG+Iy5kB5MKNG61hgVXn2zmAS/YyC3QY1X2N4/pvKu6i
 BSEtNVghbgPHO0e9Tx40Y+jJGxT0eBQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-9rPQZhnPPBuIRYHC98tGHQ-1; Mon, 18 Oct 2021 09:17:51 -0400
X-MC-Unique: 9rPQZhnPPBuIRYHC98tGHQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 s1-20020adfc541000000b001645b92c65bso3606974wrf.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 06:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MzTAOtwulDEmvfrOMqdp9kU77zBPM/IRO9XOnd+cufc=;
 b=T0Ln2Llm49H8rlxNw3k9u/Mk8Kb63RoikwobiO2hZQ6ZiqxK25QyU1w0W4QfdnIGlr
 pjem7s1Zl0dVNZJR5ih8LVHj7EmXo4ryQDrEsGC79kVYZV2zkJ9wuFS174aluIcpdxLL
 NccBBJBZPRc5d2AldtDBFvP+MsATgdLKTlDejwfsrnXUrUNd/urRwLfNpkJcSXZJ1iHB
 +tviURWteq8LT2fv567YpoDMUab1qeUuWtgmr+Um840IBTjdaK0gN1u/NFmwXuwY2hMG
 WZQm4dhgR69eCRnLUwUilaAGXAs8cp0VEtU0lfa+Ht+5MoBhzGPC0Bup87S158NydniW
 VtiA==
X-Gm-Message-State: AOAM532bGE24yJmfnJ+PBMcgW8uY31cXdeAZsONXeQaLiD0YIObEXZNi
 TbB91YvWU7sgrqkfvrf9WWAYVkw2PznddbKWT9SOLECZaEdxGrN0R1nejPXWppJ6hR5JbDYvJeJ
 CEKQTJsgR72zjIT3eQmowl1U+k1bnxO8ty1ATpSTF4Q==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr43163291wmj.160.1634563070234; 
 Mon, 18 Oct 2021 06:17:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSuIZ1TUObsaltct5kZLxF5NiX0EAwqlesEoWuwEt55OWxSiqTjrt15fn3c5YHGk3doStYbg==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr43163243wmj.160.1634563069879; 
 Mon, 18 Oct 2021 06:17:49 -0700 (PDT)
Received: from redhat.com ([2.55.19.190])
 by smtp.gmail.com with ESMTPSA id n66sm12531808wmn.2.2021.10.18.06.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 06:17:48 -0700 (PDT)
Date: Mon, 18 Oct 2021 09:17:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211018091627-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
 <20211011073614-mutt-send-email-mst@kernel.org>
 <YW1lc5Y2P1zRc2kp@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YW1lc5Y2P1zRc2kp@kroah.com>
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
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
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

On Mon, Oct 18, 2021 at 02:15:47PM +0200, Greg KH wrote:
> On Mon, Oct 11, 2021 at 07:59:17AM -0400, Michael S. Tsirkin wrote:
> > On Sun, Oct 10, 2021 at 03:22:39PM -0700, Andi Kleen wrote:
> > > 
> > > > To which Andi replied
> > > > 	One problem with removing the ioremap opt-in is that
> > > > 	it's still possible for drivers to get at devices without going through probe.
> > > > 
> > > > To which Greg replied:
> > > > https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
> > > > 	If there are in-kernel PCI drivers that do not do this, they need to be
> > > > 	fixed today.
> > > > 
> > > > Can you guys resolve the differences here?
> > > 
> > > 
> > > I addressed this in my other mail, but we may need more discussion.
> > 
> > Hopefully Greg will reply to that one.
> 
> Note, when wanting Greg to reply, someone should at the very least cc:
> him.

"that one" being "Andi's other mail". Which I don't remember what it was,
by now. Sorry.

> {sigh}
> 
> greg k-h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
