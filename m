Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E25DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:32:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED999613D0
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED999613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE4924036A;
	Thu, 30 Sep 2021 15:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cG876ssGJNS1; Thu, 30 Sep 2021 15:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 242AA40346;
	Thu, 30 Sep 2021 15:32:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9769C0011;
	Thu, 30 Sep 2021 15:32:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0705C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C717461404
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:32:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V2Wb1_s9TJk3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:32:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by smtp3.osuosl.org (Postfix) with SMTP id 0CE3161403
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:32:42 +0000 (UTC)
Received: (qmail 472797 invoked by uid 1000); 30 Sep 2021 11:32:41 -0400
Date: Thu, 30 Sep 2021 11:32:41 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930153241.GE464826@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104640-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210930104640-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, linux-kernel@vger.kernel.org,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-usb@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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

On Thu, Sep 30, 2021 at 10:48:54AM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> > I don't see any point in talking about "untrusted drivers".  If a 
> > driver isn't trusted then it doesn't belong in your kernel.  Period.  
> > When you load a driver into your kernel, you are implicitly trusting 
> > it (aside from limitations imposed by security modules).  The code 
> > it contains, the module_init code in particular, runs with full 
> > superuser permissions.
> > 
> > What use is there in loading a driver but telling the kernel "I don't 
> > trust this driver, so don't allow it to probe any devices"?  Why not 
> > just blacklist it so that it never gets modprobed in the first place?
> > 
> > Alan Stern
> 
> When the driver is built-in, it seems useful to be able to block it
> without rebuilding the kernel. This is just flipping it around
> and using an allow-list for cases where you want to severly
> limit the available functionality.

Does this make sense?

The only way to tell the kernel to block a built-in driver is by 
using some boot-command-line option.  Otherwise the driver's init 
code will run before you have a chance to tell the kernel anything at 
all.

So if you change your mind about whether a driver should be blocked, 
all you have to do is remove the blocking option from the command 
line and reboot.  No kernel rebuild is necessary.

Alan Stern
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
