Return-Path: <SRS0=UZhq=OW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B9AC433EF
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 11:14:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C5061AEF
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 11:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69C5061AEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 383F160655;
	Sat,  2 Oct 2021 11:14:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLHFg_Do11X4; Sat,  2 Oct 2021 11:14:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D58A260597;
	Sat,  2 Oct 2021 11:14:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD88BC0011;
	Sat,  2 Oct 2021 11:14:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20E80C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 11:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E93A60655
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 11:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NiRR1H3wh-mm
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 11:14:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D5E860597
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 11:14:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9F1A61A8F;
 Sat,  2 Oct 2021 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633173274;
 bh=oA5M5+lU7nwhD/rOivosaKv0XTN5QnVPtj675tCx3ks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1Z9pCS6A/zvKbuIWtPQJlXbQRYqiOOfvQxKqHhEIkajwh0e3d4lJeeYcqUtmHAduS
 9p1lU36Hd879Z2rHYNKKlSlgdoVXSyo0enKGfKCPqHiQm3G+LWvy/TiI25Ef+L2jJm
 AZPD3QuK/tbDBXoLEs5C2I3i7LyKTQCngkqZPsXE=
Date: Sat, 2 Oct 2021 13:14:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <YVg/F10PCFNOtCnL@kroah.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
 <20211002070218-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211002070218-mutt-send-email-mst@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
 X86 ML <x86@kernel.org>, virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, USB list <linux-usb@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Reshetova,
 Elena" <elena.reshetova@intel.com>
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

On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> > >   Do you have a list of specific drivers and kernel options that you
> > > feel you now "trust"?
> > 
> > For TDX it's currently only virtio net/block/console
> > 
> > But we expect this list to grow slightly over time, but not at a high rate
> > (so hopefully <10)
> 
> Well there are already >10 virtio drivers and I think it's reasonable
> that all of these will be used with encrypted guests. The list will
> grow.

What is keeping "all" drivers from being on this list?  How exactly are
you determining what should, and should not, be allowed?  How can
drivers move on, or off, of it over time?

And why not just put all of that into userspace and have it pick and
choose?  That should be the end-goal here, you don't want to encode
policy like this in the kernel, right?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
