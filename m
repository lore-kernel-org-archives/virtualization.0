Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CBC433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:43:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0E261423
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A0E261423
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29D3240352;
	Thu, 30 Sep 2021 14:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6LXghF7r4c2K; Thu, 30 Sep 2021 14:43:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27C2240371;
	Thu, 30 Sep 2021 14:43:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E446DC000F;
	Thu, 30 Sep 2021 14:43:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02190C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D32CC42599
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:43:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTv46sKYLfc1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:43:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by smtp4.osuosl.org (Postfix) with SMTP id D3617425B2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:43:07 +0000 (UTC)
Received: (qmail 465943 invoked by uid 1000); 30 Sep 2021 10:43:05 -0400
Date: Thu, 30 Sep 2021 10:43:05 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930144305.GA464826@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YVXBNJ431YIWwZdQ@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, linux-kernel@vger.kernel.org,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-usb@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Thu, Sep 30, 2021 at 03:52:52PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > While the common case for device-authorization is to skip probe of
> > > unauthorized devices, some buses may still want to emit a message on
> > > probe failure (Thunderbolt), or base probe failures on the
> > > authorization status of a related device like a parent (USB). So add
> > > an option (has_probe_authorization) in struct bus_type for the bus
> > > driver to own probe authorization policy.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > 
> > 
> > So what e.g. the PCI patch
> > https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > actually proposes is a list of
> > allowed drivers, not devices. Doing it at the device level
> > has disadvantages, for example some devices might have a legacy
> > unsafe driver, or an out of tree driver. It also does not
> > address drivers that poke at hardware during init.
> 
> Doing it at a device level is the only sane way to do this.
> 
> A user needs to say "this device is allowed to be controlled by this
> driver".  This is the trust model that USB has had for over a decade and
> what thunderbolt also has.
> 
> > Accordingly, I think the right thing to do is to skip
> > driver init for disallowed drivers, not skip probe
> > for specific devices.
> 
> What do you mean by "driver init"?  module_init()?
> 
> No driver should be touching hardware in their module init call.  They
> should only be touching it in the probe callback as that is the only
> time they are ever allowed to talk to hardware.  Specifically the device
> that has been handed to them.
> 
> If there are in-kernel PCI drivers that do not do this, they need to be
> fixed today.
> 
> We don't care about out-of-tree drivers for obvious reasons that we have
> no control over them.

I don't see any point in talking about "untrusted drivers".  If a 
driver isn't trusted then it doesn't belong in your kernel.  Period.  
When you load a driver into your kernel, you are implicitly trusting 
it (aside from limitations imposed by security modules).  The code 
it contains, the module_init code in particular, runs with full 
superuser permissions.

What use is there in loading a driver but telling the kernel "I don't 
trust this driver, so don't allow it to probe any devices"?  Why not 
just blacklist it so that it never gets modprobed in the first place?

Alan Stern
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
