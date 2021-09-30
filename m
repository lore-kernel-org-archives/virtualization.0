Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98162C433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 20:44:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4980E61881
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 20:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4980E61881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 142C4613FD;
	Thu, 30 Sep 2021 20:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ud_HivDfoJ4Z; Thu, 30 Sep 2021 20:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE4CF607F1;
	Thu, 30 Sep 2021 20:44:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 742FCC000F;
	Thu, 30 Sep 2021 20:44:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46A5FC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 20:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D77B400D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 20:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZB2tri-DtSK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 20:44:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by smtp2.osuosl.org (Postfix) with SMTP id 3F1C7400C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 20:44:49 +0000 (UTC)
Received: (qmail 483354 invoked by uid 1000); 30 Sep 2021 16:44:47 -0400
Date: Thu, 30 Sep 2021 16:44:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930204447.GA482974@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104924-mutt-send-email-mst@kernel.org>
 <20210930153509.GF464826@rowland.harvard.edu>
 <20210930115243-mutt-send-email-mst@kernel.org>
 <00156941-300d-a34a-772b-17f0a9aad885@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00156941-300d-a34a-772b-17f0a9aad885@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Andreas Noever <andreas.noever@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, "Reshetova,
 Elena" <elena.reshetova@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Michael Jamet <michael.jamet@intel.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>
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

On Thu, Sep 30, 2021 at 12:23:36PM -0700, Andi Kleen wrote:
> 
> > I don't think the current mitigations under discussion here are about
> > keeping the system working. In fact most encrypted VM configs tend to
> > stop booting as a preferred way to handle security issues.
> 
> Maybe we should avoid the "trusted" term here. We're only really using it
> because USB is using it and we're now using a common framework like Greg
> requested. But I don't think it's the right way to think about it.
> 
> We usually call the drivers "hardened". The requirement for a hardened
> driver is that all interactions through MMIO/port/config space IO/MSRs are
> sanitized and do not cause memory safety issues or other information leaks.
> Other than that there is no requirement on the functionality. In particular
> DOS is ok since a malicious hypervisor can decide to not run the guest at
> any time anyways.
> 
> Someone loading an malicious driver inside the guest would be out of scope.
> If an attacker can do that inside the guest you already violated the
> security mechanisms and there are likely easier ways to take over the guest
> or leak data.
> 
> The goal of the device filter mechanism is to prevent loading unhardened
> drivers that could be exploited without them being themselves malicious.

If all you want to do is prevent someone from loading a bunch of 
drivers that you have identified as unhardened, why not just use a 
modprobe blacklist?  Am I missing something?

Alan Stern
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
