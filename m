Return-Path: <SRS0=yNrU=OV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA177C433F5
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 18:10:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EA26135E
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 18:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43EA26135E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB749407F9;
	Fri,  1 Oct 2021 18:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id faDvzPAmwVfb; Fri,  1 Oct 2021 18:10:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CF17402DC;
	Fri,  1 Oct 2021 18:10:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12A61C0011;
	Fri,  1 Oct 2021 18:10:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BC78C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 18:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 436A3402DC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 18:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sVNrSHUYz-Ki
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 18:10:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C428401FB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 18:10:03 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 rj12-20020a17090b3e8c00b0019f88e44d85so868832pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Oct 2021 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2KFuOrTMhH3SQsw1rM/3FEXg4ao/BGYA5Ilqe0th6JM=;
 b=NDbfA3XjG5EhuNjh+dRar041dNJzw1gWHW6t+j97IW2pEjdJSk+YfuCAkrm4fDmjkO
 0pVPJaITMLoKmUdk6x7lCcT+oIBj+ETmUCSbdmpCdzHtL5l7zoz7tIvrGEfpKbPxiIYu
 /+P6IplqX3kirO8xwKxQmGhFDwpB3qeScSFXJVTc2it/D+aS3MMDemWs535izc/INWUw
 nUzYVdFPjGWsRtC7OdTOPI5KlsLMhNqOMT55cuSSJ3jFhvPS84t3GqwTqBxu514MA6C1
 M425dYCXlqS0TK5NPkHcYAR+SwVvSNx3oDZqFPnKdEA9d5B8B2pAY67LX+y0krOYYvOx
 +gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2KFuOrTMhH3SQsw1rM/3FEXg4ao/BGYA5Ilqe0th6JM=;
 b=RD1hcQxsjvEsw8GPONVKmRNCKn6Xf5fEDadVnOr/qhy8+HUwe24kLXbuzKvxTzc4rY
 qrRYVC9mE6z+7xCklQ2bUmPDhK8cIwTYbAT3au4hgfFqhkPQBxCZjEDjUzk0lavDqyWz
 Ue/vnibmDNIdVqGvQ1up3zxFrJnftZdWWRAMvvCXQHi0qvp9zL5NyYBK8shwOxx3Bzun
 g8MHJpX4scPf4OI5QaVFEJq6TTPqBCNk19/Ms5rA8WKojaqCfEAaKRajJt7rwyelBESA
 giJxv0z1b/FJ+mUC+T41Nl5Oj3LSHabsOKwS3xPM4AXmHGswGygRo6jI5Ym8tpnvNr8z
 g6rg==
X-Gm-Message-State: AOAM532H2/hdYRxdntTcleIWpTCIMA3llrBYkLQntPJFHI6jdLq6Npg5
 0BDaNkuVEI6E7LeC8Z90px7NPfOvExrbHOfZYz+XrQ==
X-Google-Smtp-Source: ABdhPJxhssf74vi65MJPjZjUi4lYRyXsEkvUbEqnuapdQ7I4PrjXBFhCptKglUzo8lM7g8GATcVf+T3EH0hIEL6uJtY=
X-Received: by 2002:a17:90b:3b84:: with SMTP id
 pc4mr14704315pjb.220.1633111802704; 
 Fri, 01 Oct 2021 11:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
 <20211001164533.GC505557@rowland.harvard.edu>
In-Reply-To: <20211001164533.GC505557@rowland.harvard.edu>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 1 Oct 2021 11:09:52 -0700
Message-ID: <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To: Alan Stern <stern@rowland.harvard.edu>
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

On Fri, Oct 1, 2021 at 9:47 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Oct 01, 2021 at 09:13:54AM -0700, Dan Williams wrote:
> > Bear with me, and perhaps it's a lack of imagination on my part, but I
> > don't see how to get to a globally generic "authorized" sysfs ABI
> > given that USB and Thunderbolt want to do bus specific actions on
> > authorization toggle events. Certainly a default generic authorized
> > attribute can be defined for all the other buses that don't have
> > legacy here, but Thunderbolt will still require support for '2' as an
> > authorized value, and USB will still want to base probe decisions on
> > the authorization state of both the usb_device and the usb_interface.
>
> The USB part isn't really accurate (I can't speak for Thunderbolt).
> When a usb_device is deauthorized, the device will be unconfigured,
> deleting all its interfaces and removing the need for any probe
> decisions about them.  In other words, the probe decision for a
> usb_device or usb_interface depends only on the device's/interface's
> own authorization state.
>
> True, the interface binding code does contain a test of the device's
> authorization setting.  That test is redundant and can be removed.
>
> The actions that USB wants to take on authorization toggle events for
> usb_devices are: for authorize, select and install a configuration;
> for deauthorize, unconfigure the device.  Each of these could be
> handled simply enough just by binding/unbinding the device.  (There
> is some special code for handling wireless USB devices, but wireless
> USB is now defunct.)

Ah, so are you saying that it would be sufficient for USB if the
generic authorized implementation did something like:

dev->authorized = 1;
device_attach(dev);

...for the authorize case, and:

dev->authorize = 0;
device_release_driver(dev);

...for the deauthorize case?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
