Return-Path: <SRS0=/Kss=NV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13002C4320A
	for <virtualization@archiver.kernel.org>; Mon, 30 Aug 2021 21:00:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79CD60F6C
	for <virtualization@archiver.kernel.org>; Mon, 30 Aug 2021 21:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B79CD60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E33C80E19;
	Mon, 30 Aug 2021 21:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UXsvza25kCqs; Mon, 30 Aug 2021 21:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 18A8B80DF2;
	Mon, 30 Aug 2021 21:00:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8795C001A;
	Mon, 30 Aug 2021 21:00:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 467BBC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2937380DF3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6n2bk42rATt7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:00:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C4D280DF2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630357199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDgZoaGxuF8+VxsBt8mWUj6L6RMapnQD42kDmE3TNZQ=;
 b=GH03Om/445Kfh0spCpfgBXGkgopeKaJKIqsbbIqGNoDmAlnZTvAthA2tI2dz9Aq5cuTnHb
 S/4bNzDF2aRH+g5BXDAau4HDRE6CwBE5H4ZiUVX0kxknRtFixsmYk2gTkESXfR+1kQusEc
 NugrIp20O33foRVdV+QJ3G9RR3jW/9o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-dBtyjiwlMbqRaGmiPeox9A-1; Mon, 30 Aug 2021 16:59:57 -0400
X-MC-Unique: dBtyjiwlMbqRaGmiPeox9A-1
Received: by mail-wm1-f70.google.com with SMTP id
 m22-20020a7bca56000000b002e7508f3faeso5163630wml.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 13:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZDgZoaGxuF8+VxsBt8mWUj6L6RMapnQD42kDmE3TNZQ=;
 b=gjVgsO4RxG36rkFw/xeq+xGtMbyYqW3QsCU660DbDip6KMaVqZHsyhvLIEJPeWNqWX
 YZEZdF3AUxgeGpCdp4LCWHqaS0mYdIP2zsBK49/fOCHTKttyzL4mjcmNYFCNXMBwxNNB
 rxp/p+soQndwMVzeTwCmlNrAx9zty4vS08ylT0bvM6r44Onzi5vOmcrfVg40DmNpkpvJ
 DAwzPkLm6E9beArznweJNf8QSBogmVvQWquUi24DQ0b/BPO4xfcCh3WVOTIbq3XSdL7s
 YwXCtQ/75Hi2WYy1mXGaU8+9SLcT0VI6SrC8K6j3JPp9/vYdY1MPx3vHtvYoo4aryrD+
 BYBA==
X-Gm-Message-State: AOAM5332V8S9UlgPCsIdDMB9Gb0OTimWRUhMNXaOQsIpwrWWgYc26V5z
 Gx743ZE6/x6mgZhoEcgTQ7O54MDfTZQc/DD9kL+Gb/PjMrLlIOZ3puUPim2wwv/bSw0fM2/jlx8
 lZEKPn+i0Uz3OHmITUR9GetsiqJEAOrOXPp6GZsLGUg==
X-Received: by 2002:a1c:7f48:: with SMTP id a69mr887129wmd.166.1630357196521; 
 Mon, 30 Aug 2021 13:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjS6eag15Cf7xmVDHk/qvmWoQLzIdnk7dLXkY7XjvOHcTw6SiXs3ksmYcUzh73pyrAtLIGDA==
X-Received: by 2002:a1c:7f48:: with SMTP id a69mr887093wmd.166.1630357196296; 
 Mon, 30 Aug 2021 13:59:56 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id z9sm12277068wre.11.2021.08.30.13.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 13:59:55 -0700 (PDT)
Date: Mon, 30 Aug 2021 16:59:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210830163723-mutt-send-email-mst@kernel.org>
References: <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Aug 29, 2021 at 10:11:46PM -0700, Andi Kleen wrote:
> =

> On 8/29/2021 3:26 PM, Michael S. Tsirkin wrote:
> > On Sun, Aug 29, 2021 at 09:17:53AM -0700, Andi Kleen wrote:
> > > Also I changing this single call really that bad? It's not that we ch=
anging
> > > anything drastic here, just give the low level subsystem a better hin=
t about
> > > the intention. If you don't like the function name, could make it an
> > > argument instead?
> > My point however is that the API should say that the
> > driver has been audited,
> =

> We have that status in the struct device. If you want to tie the ioremap =
to
> that we could define a ioremap_device() with a device argument and decide
> based on that.

But it's not the device that is audited. And it's not the device
that might be secure or insecure. It's the driver.

> Or we can add _audited to the name. ioremap_shared_audited?

But it's not the mapping that has to be done in handled special way.
It's any data we get from device, not all of it coming from IO, e.g.
there's DMA and interrupts that all have to be validated.
Wouldn't you say that what is really wanted is just not running
unaudited drivers in the first place?

> =

> > not that the mapping has been
> > done in some special way. For example the mapping can be
> > in some kind of wrapper, not directly in the driver.
> > However you want the driver validated, not the wrapper.
> > =

> > Here's an idea:
> =

> =

> I don't think magic differences of API behavior based on some define are a
> good idea.=A0 That's easy to miss.

Well ... my point is that actually there is no difference in API
behaviour. the map is the same map, exactly same data goes to device. If
anything any non-shared map is special in that encrypted data goes to
device.

> =

> That's a "COME FROM" in API design.
> =

> Also it wouldn't handle the case that a driver has both private and shared
> ioremaps, e.g. for BIOS structures.

Hmm. Interesting.  It's bios maps that are unusual and need to be private t=
hough ...

> And we've been avoiding that drivers can self declare auditing, we've been
> trying to have a separate centralized list so that it's easier to enforce
> and avoids any cut'n'paste mistakes.
> =

> -Andi

Now I'm confused. What is proposed here seems to be basically that,
drivers need to declare auditing by replacing ioremap with
ioremap_shared.

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
