Return-Path: <SRS0=zxqJ=OA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5136EC433F5
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 09:54:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F34611C1
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 09:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2F34611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACD29606EB;
	Fri, 10 Sep 2021 09:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YRVe3WUvg7tD; Fri, 10 Sep 2021 09:54:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D6F3605C1;
	Fri, 10 Sep 2021 09:54:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23924C0011;
	Fri, 10 Sep 2021 09:54:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 969D6C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 09:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90260405F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 09:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QL_Sq4DTPZKF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 09:54:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 448BD40167
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 09:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631267681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3LlEYSRHK/bW1nfGLOGdZcifmv3HCR8Ukwhz+/9614=;
 b=HZrj4xMfkHo4GQLDRHapdO6Gm8bRQR0d12L1Hr8CI4WKWLoNIjjoezSBIMQIVnvhoCqUJ7
 FanWz75gAyne578GQG6BYZ4UBVWsx3xtbhLA4ju20tKStNdqcriBS4S6wb4mqH8adUa1Op
 gGWEkmD6F8T4jm6QjO3VvmtSZ1BVDUQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-qEYCUBpfPsKpmUelv8KSCg-1; Fri, 10 Sep 2021 05:54:37 -0400
X-MC-Unique: qEYCUBpfPsKpmUelv8KSCg-1
Received: by mail-wr1-f71.google.com with SMTP id
 q14-20020a5d574e000000b00157b0978ddeso315258wrw.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 02:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G3LlEYSRHK/bW1nfGLOGdZcifmv3HCR8Ukwhz+/9614=;
 b=hIclcKT3jPjihLqSPhx64Tuj8U2LLuYqdP02kPqDgaSsDSIz1GDAaPr0N+0JBqcfYY
 L9AGmmqeoTNV7Pmbf3ASCyji8cIw261Q6/e+oAkizmoFB8gnfQCKvBzFRvRy80n4Z3OO
 z2jdV3Q9PfuZ9WPDu73vloI/I6IixpbpjExTfO/cz2B3nnfky691bKI45BKP9cmAv1Y4
 SSTIZXiTDCy2eQW0Fh26Pq3oiaVBKdA4/BRGLpuihO6Twf+RJONuzDQXeKiYA0BxzCeh
 kI4yccqDPSk+qUUTx8FYgBAT0LFjXfzmc6/Ux8GXM1At6xfiqprW7pGAzpPAgLiQ6iK/
 7ang==
X-Gm-Message-State: AOAM532CJzqkSSGn66u2ohUa2SHytB3QJGLplB1vtzERFwIpecDEZZbX
 wT++9VeGVr1GBVHGR1YwCwppbojhnv0djNciCYxyAKa/HPpRUeaBjEWSBbVi2AX1hIVyMIz0s3W
 VBJPPJsRPmvb8KveNfOXIfP54bzzAebdq+9AGu/Rf+Q==
X-Received: by 2002:adf:eb81:: with SMTP id t1mr8841000wrn.245.1631267676748; 
 Fri, 10 Sep 2021 02:54:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO0Y/+7P/8niNtl+CoPrjCVE7HuwDhOVv5eL0lpW28+D5kEKFv5EWjYMYsYF1r6EhbMvRO7w==
X-Received: by 2002:adf:eb81:: with SMTP id t1mr8840971wrn.245.1631267676591; 
 Fri, 10 Sep 2021 02:54:36 -0700 (PDT)
Received: from redhat.com ([2.55.145.189])
 by smtp.gmail.com with ESMTPSA id o7sm3686409wmc.46.2021.09.10.02.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Sep 2021 02:54:34 -0700 (PDT)
Date: Fri, 10 Sep 2021 05:54:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210910054044-mutt-send-email-mst@kernel.org>
References: <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
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

On Mon, Aug 30, 2021 at 05:23:17PM -0700, Andi Kleen wrote:
> 
> On 8/30/2021 1:59 PM, Michael S. Tsirkin wrote:
> > 
> > > Or we can add _audited to the name. ioremap_shared_audited?
> > But it's not the mapping that has to be done in handled special way.
> > It's any data we get from device, not all of it coming from IO, e.g.
> > there's DMA and interrupts that all have to be validated.
> > Wouldn't you say that what is really wanted is just not running
> > unaudited drivers in the first place?
> 
> 
> Yes.

Then ... let's do just that?

> 
> > 
> > > And we've been avoiding that drivers can self declare auditing, we've been
> > > trying to have a separate centralized list so that it's easier to enforce
> > > and avoids any cut'n'paste mistakes.
> > > 
> > > -Andi
> > Now I'm confused. What is proposed here seems to be basically that,
> > drivers need to declare auditing by replacing ioremap with
> > ioremap_shared.
> 
> Auditing is declared on the device model level using a central allow list.

Can we not have an init call allow list instead of, or in addition to, a
device allow list?

> But this cannot do anything to initcalls that run before probe,

Can't we extend module_init so init calls are validated against the
allow list?

> that's why
> an extra level of defense of ioremap opt-in is useful.

OK even assuming this, why is pci_iomap opt-in useful?
That never happens before probe - there's simply no pci_device then.

> But it's not the
> primary mechanism to declare a driver audited, that's the allow list. The
> ioremap is just another mechanism to avoid having to touch a lot of legacy
> drivers.
> 
> If we agree on that then the original proposed semantics of "ioremap_shared"
> may be acceptable?
> 
> -Andi
> 

It looks suspiciously like drivers self-declaring auditing to me which
we both seem to agree is undesirable. What exactly is the difference?

Or are you just trying to disable anything that runs before probe?
In that case I don't see a reason to touch pci drivers though.
These should be fine with just the device model list.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
