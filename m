Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2E7C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 05:45:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E366610A8
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 05:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E366610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F9E1403EF;
	Wed,  6 Oct 2021 05:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id axgSUusL0GBk; Wed,  6 Oct 2021 05:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A759400BE;
	Wed,  6 Oct 2021 05:45:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9F4C000F;
	Wed,  6 Oct 2021 05:45:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DB3EC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 05:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F1D060D78
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 05:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iYKpjw9wjok3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 05:45:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B9EB608D2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 05:45:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08C45610A8;
 Wed,  6 Oct 2021 05:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633499115;
 bh=TkhOS3oV3aBi6/QsuUnIcb7Tuh/r6ed2nyWTvBNeZCE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ja+ryf444x6Di/ECYJ1MMxrIt8xWGjoeayFFSxzN7eUIV+0TdxlBE0oLlQK/Z6CPA
 Mkt0M00dGomHevaZhMCpHpdn51zXqCAEv+4jonKBlHTIZ50E6rRLws7+HdzmJccBZV
 CwuhTxux4JPGErPjZnNy3G/8slESpIe3e8+O8gMs=
Date: Wed, 6 Oct 2021 07:45:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <YV036H5iGd7FKg+E@kroah.com>
References: <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
 <20211001164533.GC505557@rowland.harvard.edu>
 <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
 <20211001190048.GA512418@rowland.harvard.edu>
 <CAPcyv4hYL51DcBuSuyMRFo5Jcc=zLd=Ugo+H_2saELcZ5AJBeQ@mail.gmail.com>
 <YVqONA0vhl0/H3QE@lahna>
 <CAPcyv4im4Tsj1SnxSWe=cAHBP1mQ=zgO-D81n2BpD+_HkpitbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4im4Tsj1SnxSWe=cAHBP1mQ=zgO-D81n2BpD+_HkpitbQ@mail.gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
 X86 ML <x86@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, Oct 05, 2021 at 03:33:29PM -0700, Dan Williams wrote:
> On Sun, Oct 3, 2021 at 10:16 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Fri, Oct 01, 2021 at 12:57:18PM -0700, Dan Williams wrote:
> > > > > Ah, so are you saying that it would be sufficient for USB if the
> > > > > generic authorized implementation did something like:
> > > > >
> > > > > dev->authorized = 1;
> > > > > device_attach(dev);
> > > > >
> > > > > ...for the authorize case, and:
> > > > >
> > > > > dev->authorize = 0;
> > > > > device_release_driver(dev);
> > > > >
> > > > > ...for the deauthorize case?
> > > >
> > > > Yes, I think so.  But I haven't tried making this change to test and
> > > > see what really happens.
> > >
> > > Sounds like a useful path for this effort to explore. Especially as
> > > Greg seems to want the proposed "has_probe_authorization" flag in the
> > > bus_type to disappear and make this all generic. It just seems that
> > > Thunderbolt would need deeper surgery to move what it does in the
> > > authorization toggle path into the probe and remove paths.
> > >
> > > Mika, do you see a path for Thunderbolt to align its authorization
> > > paths behind bus ->probe() ->remove() events similar to what USB might
> > > be able to support for a generic authorization path?
> >
> > In Thunderbolt "authorization" actually means whether there is a PCIe
> > tunnel to the device or not. There is no driver bind/unbind happening
> > when authorization toggles (well on Thunderbolt bus, there can be on PCI
> > bus after the tunnel is established) so I'm not entirely sure how we
> > could use the bus ->probe() or ->remove for that to be honest.
> 
> Greg, per your comment:
> 
> "... which was to move the way that busses are allowed to authorize
> the devices they wish to control into a generic way instead of being
> bus-specific logic."
> 
> We have USB and TB that have already diverged on the ABI here. The USB
> behavior is more in line with the "probe authorization" concept, while
> TB is about tunnel establishment and not cleanly tied to probe
> authorization. So while I see a path to a common authorization
> implementation for USB and other buses (per the insight from Alan), TB
> needs to retain the ability to record the authorization state as an
> enum rather than a bool, and emit a uevent on authorization status
> change.
> 
> So how about something like the following that moves the attribute
> into the core, but still calls back to TB and USB to perform their
> legacy authorization work. This new authorized attribute only shows up
> when devices default to not authorized, i.e. when userspace owns the
> allow list past critical-boot built-in drivers, or if the bus (USB /
> TB) implements ->authorize().

At quick glance, this looks better, but it would be good to see someone
test it :)

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
