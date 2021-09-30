Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF1CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 04:59:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1297361439
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 04:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1297361439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D515442553;
	Thu, 30 Sep 2021 04:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8zq5SmyjY2_t; Thu, 30 Sep 2021 04:59:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95BD942544;
	Thu, 30 Sep 2021 04:59:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A117C000F;
	Thu, 30 Sep 2021 04:59:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C597DC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFF9642546
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3jcS3u3GhWk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:59:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E01BF42544
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:59:36 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 ce20-20020a17090aff1400b0019f13f6a749so5553285pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VTM9z+DcTeYF3hZgKWEu9ebVrBPYT2J8Mz8sj8erXZk=;
 b=PCpbwU/Blt/pbMA6NT2nm2SIqNzMnAtcLzxhxbtj3rTw2MHvXasv4KZ/zpwWPlZn7y
 xPWsxFGYK8u70vbz7XcbGiHpsKtrQjK346ig5ArayijRkOVR0ZSgmSdFgnxE9i5Sf9pW
 0deGfEYYnNhaWRDtv3KVBZBS8spTYrA43Nq9+AxcJVFP4EVbUPaWHgG3/ccF/i1QocQh
 Qw4w3IvzGqNsfXW9sLxObs8iR9rV/NKytwQ8uw+30BCP3sXi3JaL/1APxK4M9G1CofGl
 mDPEFjR6CHHEV+e1F5uOIa2vub/p77kBLKF9waZAxea7kzN/oqO6LWY664QZ4RAJnbzu
 9G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VTM9z+DcTeYF3hZgKWEu9ebVrBPYT2J8Mz8sj8erXZk=;
 b=AQmglzKTmou8kib9gw40PVqGit62YPDOhkqBDw3Tmzi9bNnYgrhes3Iip3uppfwz9p
 IDKPvYhYL25wNxXuOxsBbiHr3v1b4QfN6JH2cyR0o/CJh6Vzie5d1SPevcfnZMFgy0Qp
 yChtU+WzWPpqrvQHXvinyJQTmxgGvZQo9ZQCYzDJMY482/pe1/ob28ONgdiuOt1d8l7M
 qz6zfITZPsPluYj6+jGgaDKqclXxwZAlHLP2nRm2iztic/wlrCiWT5WPNqButZbXaSfk
 nb/qI53eKFUZ7D+PzFACyOX9GNzA+2pAxQtkZC4VWj627z2/2u7kb0zo5qRMd3XVLr76
 WMcw==
X-Gm-Message-State: AOAM531R+a9P8gvykTElrmzRK1xjROv89F0nt7aFa/TMBUkQaqN8qxX/
 Sr6urHo4YaeyQQ6KKiWeWopg/ssqqTxjmkSkvGnzUQ==
X-Google-Smtp-Source: ABdhPJyybPbFqs+kvSA+EffRawV4Hj+ykPs983Fz8BFHzbiq+5hEn89iPiOxS6iB4aUV2nFWiaggHuioY3Gye2yZA4U=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr2377812pls.89.1632977976213; Wed, 29
 Sep 2021 21:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu>
 <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
 <f9b7cf97-0a14-1c80-12ab-23213ec2f4f2@linux.intel.com>
In-Reply-To: <f9b7cf97-0a14-1c80-12ab-23213ec2f4f2@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 29 Sep 2021 21:59:25 -0700
Message-ID: <CAPcyv4gDgQYf0ct_Xy32gQBcWhs6d2uL+wUq4pfzszDHcUHbwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andi Kleen <ak@linux.intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 USB list <linux-usb@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
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

On Wed, Sep 29, 2021 at 7:39 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 9/29/21 6:55 PM, Dan Williams wrote:
> >> Also, you ignored the usb_[de]authorize_interface() functions and
> >> their friends.
> > Ugh, yes.
>
> I did not change it because I am not sure about the interface vs device
> dependency.
>

This is was the rationale for has_probe_authorization flag. USB
performs authorization of child devices based on the authorization
state of the parent interface.

> I think following change should work.
>
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index f57b5a7a90ca..84969732d09c 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -334,7 +334,7 @@ static int usb_probe_interface(struct device *dev)
>         if (udev->dev.authorized == false) {
>                 dev_err(&intf->dev, "Device is not authorized for usage\n");
>                 return error;
> -       } else if (intf->authorized == 0) {
> +       } else if (intf->dev.authorized == 0) {

== false.

>                 dev_err(&intf->dev, "Interface %d is not authorized for usage\n",
>                                 intf->altsetting->desc.bInterfaceNumber);
>                 return error;
> @@ -546,7 +546,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
>                 return -EBUSY;
>
>         /* reject claim if interface is not authorized */
> -       if (!iface->authorized)
> +       if (!iface->dev.authorized)

I'd do == false to keep it consistent with other conversions.

>                 return -ENODEV;
>
>         dev->driver = &driver->drvwrap.driver;
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 47548ce1cfb1..ab3c8d1e4db9 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1791,9 +1791,9 @@ void usb_deauthorize_interface(struct usb_interface *intf)
>
>         device_lock(dev->parent);
>
> -       if (intf->authorized) {
> +       if (intf->dev.authorized) {
>                 device_lock(dev);
> -               intf->authorized = 0;
> +               intf->dev.authorized = 0;

= false;

>                 device_unlock(dev);
>
>                 usb_forced_unbind_intf(intf);
> @@ -1811,9 +1811,9 @@ void usb_authorize_interface(struct usb_interface *intf)
>   {
>         struct device *dev = &intf->dev;
>
> -       if (!intf->authorized) {
> +       if (!intf->dev.authorized) {
>                 device_lock(dev);
> -               intf->authorized = 1; /* authorize interface */
> +               intf->dev.authorized = 1; /* authorize interface */

= true

...not sure that comment is worth preserving.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
