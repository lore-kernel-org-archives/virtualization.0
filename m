Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB246C433FE
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 09:05:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A3B6140F
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 09:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76A3B6140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A5A184093;
	Thu, 30 Sep 2021 09:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jjdm_G0tpl7e; Thu, 30 Sep 2021 09:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E342284049;
	Thu, 30 Sep 2021 09:05:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B00C8C0011;
	Thu, 30 Sep 2021 09:05:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93FBFC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 09:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BD2940330
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 09:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S8r64iEhEEWw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 09:05:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9140B40200
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 09:05:12 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 77-20020a9d0ed3000000b00546e10e6699so6426212otj.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 02:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A0kBNA83hCb4HCc/FO3KjbqdDYyweltNhd4aS4t5/kU=;
 b=Bx+fTMAR0R2d5rD19+/Nxj/+tRenvSKuh5WYsYvowdj5ctS7LIFI8lJQ4BsdfkK0Ez
 eTP3xp7GnXYlZvprBmYnk22SUJaHC7SZDfAB3DPSsov6W3Q7h3SG0/RhkbmcGjn2HySa
 AETcYqHucC72kOZvCkfhbAyFjCmKFmxn4VxKOvFgYGa07fD7KDYsD6sp6IYje1/kDtkb
 UtAA3zo2hNuQ7ahkhasmrHoQb40Yd/Fvef37qaQlMyXoW8wR3HLgBbsT2rxsEQMcB/uR
 k233/SfTUY0gjxOiV+9P8Zt3IlSoz5fcPtpdV574KqkcxaelOkCB8ymPpPfFfSezCbVS
 GHQw==
X-Gm-Message-State: AOAM533FslQh94kUf/WtSZJvoi4SAMEp9xEGNANCk9/5SkfsQHxsmAI9
 OklHDu1CR2+qfjTyBduSIlnAZBdo/IWdVPKvfHk=
X-Google-Smtp-Source: ABdhPJxQvr32DBDvE9GooVKcASD2AsIl4lfSqdKR1BOYS2VPGs0tjNvE9npSlrVtmKJ8P2bAkPp+G83bpdvcAuxPNP4=
X-Received: by 2002:a05:6830:2784:: with SMTP id
 x4mr4274581otu.86.1632992711404; 
 Thu, 30 Sep 2021 02:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu>
 <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
 <f9b7cf97-0a14-1c80-12ab-23213ec2f4f2@linux.intel.com>
 <CAPcyv4gDgQYf0ct_Xy32gQBcWhs6d2uL+wUq4pfzszDHcUHbwQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gDgQYf0ct_Xy32gQBcWhs6d2uL+wUq4pfzszDHcUHbwQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Sep 2021 11:05:00 +0200
Message-ID: <CAJZ5v0gOEffKJoH7P9=QOAxXFbMGOf9j0V1DsixQwaAehicnfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Andreas Noever <andreas.noever@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
 Michael Jamet <michael.jamet@intel.com>, Borislav Petkov <bp@alien8.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
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

On Thu, Sep 30, 2021 at 6:59 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Sep 29, 2021 at 7:39 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> >
> >
> > On 9/29/21 6:55 PM, Dan Williams wrote:
> > >> Also, you ignored the usb_[de]authorize_interface() functions and
> > >> their friends.
> > > Ugh, yes.
> >
> > I did not change it because I am not sure about the interface vs device
> > dependency.
> >
>
> This is was the rationale for has_probe_authorization flag. USB
> performs authorization of child devices based on the authorization
> state of the parent interface.
>
> > I think following change should work.
> >
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index f57b5a7a90ca..84969732d09c 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -334,7 +334,7 @@ static int usb_probe_interface(struct device *dev)
> >         if (udev->dev.authorized == false) {
> >                 dev_err(&intf->dev, "Device is not authorized for usage\n");
> >                 return error;
> > -       } else if (intf->authorized == 0) {
> > +       } else if (intf->dev.authorized == 0) {
>
> == false

Or even (!intf->dev.authorized).

> >                 dev_err(&intf->dev, "Interface %d is not authorized for usage\n",
> >                                 intf->altsetting->desc.bInterfaceNumber);
> >                 return error;
> > @@ -546,7 +546,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
> >                 return -EBUSY;
> >
> >         /* reject claim if interface is not authorized */
> > -       if (!iface->authorized)
> > +       if (!iface->dev.authorized)
>
> I'd do == false to keep it consistent with other conversions.

But this looks odd, FWIW.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
