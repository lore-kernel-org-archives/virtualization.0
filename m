Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0763EC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 01:55:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B648361872
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 01:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B648361872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7304584080;
	Thu, 30 Sep 2021 01:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tNJICnTTfoCx; Thu, 30 Sep 2021 01:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E68383F34;
	Thu, 30 Sep 2021 01:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E456EC0011;
	Thu, 30 Sep 2021 01:55:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A3F3C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CD2242569
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bP0r7YtVHyuP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:55:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07EAF42554
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:55:22 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id k26so3564849pfi.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ppSjAe5S3xlWKT7s8el3Il5gQkJrN0MmdVf0E/AP7Gc=;
 b=ydGPiSJNMnM7op/wkyAmXwGCpbqUNFYUHuTIB1J9VMHKIEt0sSU7kMooEJf9ONRPIA
 1epCxOZbM0aS2EhNFY6KaCCjZUa3fkU0LWjAEDekFcojleEFYbUWcOuBjLnFNrOYEP0b
 mA+QtRVrgb+QVIzp8Q6gIPM6zutuAF5hBMmH4psZDUSy/atAm1KGSsMtdvT9RYXwFNoC
 0OxTcAvRXaSSlv2eJGo5aW5AjIbbmaejIHX929b6XcPXwpNZj92Vz8XUEuL92z5RkXVg
 41hSRYzrA1jBcQMejxi5WxXv4SfKoIIdMc6rLHA0kQZZpePX/R7ifabPflyujG0OznzI
 tNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ppSjAe5S3xlWKT7s8el3Il5gQkJrN0MmdVf0E/AP7Gc=;
 b=DGnOiJjzaL3xUaMXn2ux+lwcjpilIih0BenePWG2AIaKbRgwvNLIEf2XD6qnGpat9e
 RQ0BmHBVTcxpaCJtLK9HDbKC11feEYRR+tKKHxKk+PzCmj4a2u7qmxYYbObD4P/kVyWQ
 m1u5h8yHkKloGIrirIVFck2FNHolCSa/o4UaTz7rZnji1/xZ0GbuAoDhB1VGzjteRsoo
 4D9PKY7xu6AMBoaxywfdZKOVKjAnWwdMyNK6+fDbRSXRBsUf4/dR1RbUgCPmOPuBKBSP
 TuSbl0xifXnOydERwPqCuYpHPH4hMd1AuA7B7Sd4RNsW0s7rP2Xr1zHc4puJB9/nERAX
 kueg==
X-Gm-Message-State: AOAM5312yfI+r68J4+c9sLOG3e35MJxxAISgOQa6/juIAJIT2QasGu64
 HKtpDXjaUyausha2mHmNlt3wPiKYdG6kQ8V1oKamhw==
X-Google-Smtp-Source: ABdhPJxRCE7JDiUtfbj2unJgpoYL58Y7cUzTX2X/PJ4QmiFOuX+rJGY6EYObim88lDm7ERTzm39OsGnRXceY8UTFM6A=
X-Received: by 2002:a63:d709:: with SMTP id d9mr2624751pgg.377.1632966921696; 
 Wed, 29 Sep 2021 18:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu>
In-Reply-To: <20210930014229.GA447956@rowland.harvard.edu>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 29 Sep 2021 18:55:12 -0700
Message-ID: <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Sep 29, 2021 at 6:43 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Sep 29, 2021 at 06:05:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > Currently bus drivers like "USB" or "Thunderbolt" implement a custom
> > version of device authorization to selectively authorize the driver
> > probes. Since there is a common requirement, move the "authorized"
> > attribute support to the driver core in order to allow it to be used
> > by other subsystems / buses.
> >
> > Similar requirements have been discussed in the PCI [1] community for
> > PCI bus drivers as well.
> >
> > No functional changes are intended. It just converts authorized
> > attribute from int to bool and moves it to the driver core. There
> > should be no user-visible change in the location or semantics of
> > attributes for USB devices.
> >
> > Regarding thunderbolt driver, although it declares sw->authorized as
> > "int" and allows 0,1,2 as valid values for sw->authorized attribute,
> > but within the driver, in all authorized attribute related checks,
> > it is treated as bool value. So when converting the authorized
> > attribute from int to bool value, there should be no functional
> > changes other than value 2 being not visible to the user.
> >
> > [1]: https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Since you're moving the authorized flag from the USB core to the
> driver core, the corresponding sysfs attribute functions should be
> moved as well.

Unlike when 'removable' moved from USB to the driver core there isn't
a common definition for how the 'authorized' sysfs-attribute behaves
across buses. The only common piece is where this flag is stored in
the data structure, i.e. the 'authorized' sysfs interface is
purposefully left bus specific.

> Also, you ignored the usb_[de]authorize_interface() functions and
> their friends.

Ugh, yes.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
