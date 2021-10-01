Return-Path: <SRS0=yNrU=OV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C145BC4332F
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 06:29:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D81061A6F
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 06:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D81061A6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30A2F843D7;
	Fri,  1 Oct 2021 06:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dl0yZn7xI2Vn; Fri,  1 Oct 2021 06:29:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C651A843BA;
	Fri,  1 Oct 2021 06:29:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C31EC000F;
	Fri,  1 Oct 2021 06:29:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19A17C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 06:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC04B401E4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 06:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPkZovSsuZn9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 06:29:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9CE940146
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 06:29:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD0D561A57;
 Fri,  1 Oct 2021 06:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633069779;
 bh=rcW5f2yBLwBChRyM5RHpwItzXk3vSZPn4evKCamc1c0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OkPICDQRY+xltvJ7ddDOZG9kEPCfLum70sOPEt/Lf/OtCN1j2XdfJYl0kuBOqscLw
 PujostpRqxD/hbx2g0swIybjvlpLeo8SaUjnLXSRTOjQnHiUaGpljPKzyDUTfgD78c
 BZXNayCKOYFzqCEcOExF+bZMAM7SOXAsPOzEHHB0=
Date: Fri, 1 Oct 2021 08:29:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <YVaq0Hm8WHVY46xX@kroah.com>
References: <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930103537-mutt-send-email-mst@kernel.org>
 <YVXOc3IbcHsVXUxr@kroah.com>
 <20210930105852-mutt-send-email-mst@kernel.org>
 <YVXWIVZupeAzT6bO@kroah.com>
 <f4b5a269-843f-6911-24fe-ebffb2bd4f9e@linux.intel.com>
 <YVXyqBGa5Ix5MzmD@kroah.com>
 <bb27af8d-d4ba-fa70-8893-5b9939f9280a@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bb27af8d-d4ba-fa70-8893-5b9939f9280a@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Jamet <michael.jamet@intel.com>,
 linux-pci@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-kernel@vger.kernel.org,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Reshetova, Elena" <elena.reshetova@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-usb@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
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

On Thu, Sep 30, 2021 at 12:15:16PM -0700, Andi Kleen wrote:
> 
> On 9/30/2021 10:23 AM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 30, 2021 at 10:17:09AM -0700, Andi Kleen wrote:
> > > The legacy drivers could be fixed, but nobody really wants to touch them
> > > anymore and they're impossible to test.
> > Pointers to them?
> 
> For example if you look over old SCSI drivers in drivers/scsi/*.c there is a
> substantial number that has a module init longer than just registering a
> driver. As a single example look at drivers/scsi/BusLogic.c

Great, send patches to fix them up instead of adding new infrastructure
to the kernel.  It is better to remove code than add it.  You can rip
the ISA code out of that driver and then you will not have the issue
anymore.

Or again, just add that module to the deny list and never load it from
userspace.

> There were also quite a few platform drivers like this.

Of course, platform drivers are horrible abusers of this.  Just like the
recent one submitted by Intel that would bind to any machine it was
loaded on and did not actually do any hardware detection assuming that
it owned the platform:
	https://lore.kernel.org/r/20210924213157.3584061-2-david.e.box@linux.intel.com

So yes, some drivers are horrible, it is our job to catch that and fix
it.  If you don't want to load those drivers on your system, we have
userspace solutions for that (you can have allow/deny lists there.)

> > > The drivers that probe something that is not enumerated in a standard way
> > > have no choice, it cannot be implemented in a different way.
> > PCI devices are not enumerated in a standard way???
> 
> The pci devices are enumerated in a standard way, but typically the driver
> also needs something else outside PCI that needs some other probing
> mechanism.

Like what?  What PCI drivers need outside connections to control the
hardware?

> > > So instead we're using a "firewall" the prevents these drivers from doing
> > > bad things by not allowing ioremap access unless opted in, and also do some
> > > filtering on the IO ports The device filter is still the primary mechanism,
> > > the ioremap filtering is just belts and suspenders for those odd cases.
> > That's horrible, don't try to protect the kernel from itself.  Just fix
> > the drivers.
> 
> I thought we had already established this last time we discussed it.
> 
> That's completely impractical. We cannot harden thousands of drivers,
> especially since it would be all wasted work since nobody will ever need
> them in virtual guests. Even if we could harden them how would such a work
> be maintained long term? Using a firewall and filtering mechanism is much
> saner for everyone.

I agree, you can not "harden" anything here.  That is why I asked you to
use the existing process that explicitly moves the model to userspace
where a user can say "do I want this device to be controlled by the
kernel or not" which then allows you to pick and choose what drivers you
want to have in your system.

You need to trust devices, and not worry about trusting drivers as you
yourself admit :)

The kernel's trust model is that once we bind to them, we trust almost
all device types almost explicitly.  If you wish to change that model,
that's great, but it is a much larger discussion than this tiny patchset
would require.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
