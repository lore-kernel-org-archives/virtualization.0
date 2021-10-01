Return-Path: <SRS0=yNrU=OV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E25C433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 19:00:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D15661A57
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 19:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D15661A57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 506DA4023A;
	Fri,  1 Oct 2021 19:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e5ZWl4vJRHED; Fri,  1 Oct 2021 19:00:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 80DC440111;
	Fri,  1 Oct 2021 19:00:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40381C0011;
	Fri,  1 Oct 2021 19:00:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4905C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 19:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C09BB84422
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 19:00:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RDdAAxycuqMz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 19:00:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by smtp1.osuosl.org (Postfix) with SMTP id A0DC884412
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 19:00:50 +0000 (UTC)
Received: (qmail 512559 invoked by uid 1000); 1 Oct 2021 15:00:48 -0400
Date: Fri, 1 Oct 2021 15:00:48 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <20211001190048.GA512418@rowland.harvard.edu>
References: <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
 <20211001164533.GC505557@rowland.harvard.edu>
 <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
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

On Fri, Oct 01, 2021 at 11:09:52AM -0700, Dan Williams wrote:
> On Fri, Oct 1, 2021 at 9:47 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Oct 01, 2021 at 09:13:54AM -0700, Dan Williams wrote:
> > > Bear with me, and perhaps it's a lack of imagination on my part, but I
> > > don't see how to get to a globally generic "authorized" sysfs ABI
> > > given that USB and Thunderbolt want to do bus specific actions on
> > > authorization toggle events. Certainly a default generic authorized
> > > attribute can be defined for all the other buses that don't have
> > > legacy here, but Thunderbolt will still require support for '2' as an
> > > authorized value, and USB will still want to base probe decisions on
> > > the authorization state of both the usb_device and the usb_interface.
> >
> > The USB part isn't really accurate (I can't speak for Thunderbolt).
> > When a usb_device is deauthorized, the device will be unconfigured,
> > deleting all its interfaces and removing the need for any probe
> > decisions about them.  In other words, the probe decision for a
> > usb_device or usb_interface depends only on the device's/interface's
> > own authorization state.
> >
> > True, the interface binding code does contain a test of the device's
> > authorization setting.  That test is redundant and can be removed.
> >
> > The actions that USB wants to take on authorization toggle events for
> > usb_devices are: for authorize, select and install a configuration;
> > for deauthorize, unconfigure the device.  Each of these could be
> > handled simply enough just by binding/unbinding the device.  (There
> > is some special code for handling wireless USB devices, but wireless
> > USB is now defunct.)
> 
> Ah, so are you saying that it would be sufficient for USB if the
> generic authorized implementation did something like:
> 
> dev->authorized = 1;
> device_attach(dev);
> 
> ...for the authorize case, and:
> 
> dev->authorize = 0;
> device_release_driver(dev);
> 
> ...for the deauthorize case?

Yes, I think so.  But I haven't tried making this change to test and 
see what really happens.

Alan Stern
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
