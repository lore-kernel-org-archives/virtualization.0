Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0713C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:59:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94822619E2
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94822619E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62A8D83A7E;
	Thu, 30 Sep 2021 14:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4m_bH2pScpFL; Thu, 30 Sep 2021 14:59:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD84783A6E;
	Thu, 30 Sep 2021 14:59:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9663C000F;
	Thu, 30 Sep 2021 14:59:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E442C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0EBF613FB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E037L7e9zikV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:59:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by smtp3.osuosl.org (Postfix) with SMTP id DADFA6071F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:59:33 +0000 (UTC)
Received: (qmail 471447 invoked by uid 1000); 30 Sep 2021 10:59:32 -0400
Date: Thu, 30 Sep 2021 10:59:32 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
Message-ID: <20210930145932.GB464826@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu>
 <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Wed, Sep 29, 2021 at 06:55:12PM -0700, Dan Williams wrote:
> On Wed, Sep 29, 2021 at 6:43 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Sep 29, 2021 at 06:05:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > Currently bus drivers like "USB" or "Thunderbolt" implement a custom
> > > version of device authorization to selectively authorize the driver
> > > probes. Since there is a common requirement, move the "authorized"
> > > attribute support to the driver core in order to allow it to be used
> > > by other subsystems / buses.
> > >
> > > Similar requirements have been discussed in the PCI [1] community for
> > > PCI bus drivers as well.
> > >
> > > No functional changes are intended. It just converts authorized
> > > attribute from int to bool and moves it to the driver core. There
> > > should be no user-visible change in the location or semantics of
> > > attributes for USB devices.
> > >
> > > Regarding thunderbolt driver, although it declares sw->authorized as
> > > "int" and allows 0,1,2 as valid values for sw->authorized attribute,
> > > but within the driver, in all authorized attribute related checks,
> > > it is treated as bool value. So when converting the authorized
> > > attribute from int to bool value, there should be no functional
> > > changes other than value 2 being not visible to the user.
> > >
> > > [1]: https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > >
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >
> > Since you're moving the authorized flag from the USB core to the
> > driver core, the corresponding sysfs attribute functions should be
> > moved as well.
> 
> Unlike when 'removable' moved from USB to the driver core there isn't
> a common definition for how the 'authorized' sysfs-attribute behaves
> across buses. The only common piece is where this flag is stored in
> the data structure, i.e. the 'authorized' sysfs interface is
> purposefully left bus specific.

How about implementing "library" versions of show_authorized() and 
store_authorized() that the bus-specific attribute routines can call?  
These library routines would handle parsing the input values, storing 
the new flag, and displaying the stored flag value.  That way at 
least the common parts of these APIs would be centralized in the 
driver core, and any additional functionality could easily be added 
by the bus-specific attribute routine.

Alan Stern
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
