Return-Path: <SRS0=yNrU=OV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3509EC433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 16:14:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29CB61881
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 16:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E29CB61881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E0E4407D4;
	Fri,  1 Oct 2021 16:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFnDnd8y-Zx3; Fri,  1 Oct 2021 16:14:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B7D37407DD;
	Fri,  1 Oct 2021 16:14:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C694C0011;
	Fri,  1 Oct 2021 16:14:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 633A7C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 16:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 518FA83E74
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 16:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rPIMlJ_kAoFT
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 16:14:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F95083F39
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 16:14:05 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id g184so9872775pgc.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Oct 2021 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L+IL02FMe+I7B4+U5u5M54tfurOAC2b0ElDJQPqcLIw=;
 b=oO0uC4WpB1+cVuonu95kNrc8wnrnpaPc6XpaEvVlujReEgHgOJDnXbIgSFvcZ4Lcff
 Aqk3Pd1iNSEN2T8a5OjiQwDBFMznxQHOJgHVnVhs76lnV3p7oSYWL0DM2YGuYJv3npow
 +IrQC41xGbtNWfmNxD9nrdbKv9gqI6RRjz0RJsUzM9efiVOdh8Inczsk+/0ZFsC4YhNy
 0rTO55xrbcTTizbMKZx29czde/VQ3SyNEdMJWIKL4iLfuuO76YS/1/NaG/fTDAPk9ZLq
 eCp/IZavpOI8Cji7BuOcy+n9kryivJAwwzZ92ngIcanHcpfUkR1Vv5arBDmNcDB210kH
 4D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L+IL02FMe+I7B4+U5u5M54tfurOAC2b0ElDJQPqcLIw=;
 b=Jfh38pmEB6mh2ZHFO4951Pfw2nIDMaimKDkvG4cBCeoLJE615gQuOSTQHVbnsSZGvr
 UKUu4bRI5tMM5YArXiPiNNcrXJn4bbzYgUfkAm4bw+Cl6mjYhOcRWOSHSlGVPDFXZUXz
 dAHN2ZEgIFNBqCGBrnxbiM8gapU0I6bPFqdzTi6g7CharKN+tzgmRPQfRgWVOV5C/orf
 Q9USK64Wh0pXWRtik7oLWf5rAG4DvdfzqyNTWCNanmIU/lxhmx6T3k6XvWL2DmVr5OBR
 r+y/0kEGnUD/IUs7MahMvjuOcybQl1l01f0+EWZ3fY60ztD8hKFfMjwHqMPrAAEBRFXq
 ynxw==
X-Gm-Message-State: AOAM533xUFSMdHJAuF2M0/vQnW4RueaVr1+B2vj/8V2yGjJZPbxuim83
 SgHr7SmCt+CfObdyp7z8bKCZlB2ZTSd2frh0CmYx2A==
X-Google-Smtp-Source: ABdhPJwoncJpOq7m2H1Nvqcm8PwawEpCPPAs59UL5MSj0mchXzRNB6hKmmVM7i/iP8SPezb7R+n30wI3Y0CjzSsOsWc=
X-Received: by 2002:a63:1262:: with SMTP id 34mr10319530pgs.356.1633104844562; 
 Fri, 01 Oct 2021 09:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
In-Reply-To: <YVaywQLAboZ6b36V@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 1 Oct 2021 09:13:54 -0700
Message-ID: <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
 X86 ML <x86@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
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

On Fri, Oct 1, 2021 at 12:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 30, 2021 at 12:04:05PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> >
> >
> > On 9/30/21 8:23 AM, Greg Kroah-Hartman wrote:
> > > On Thu, Sep 30, 2021 at 08:18:18AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > >
> > > >
> > > > On 9/30/21 6:36 AM, Dan Williams wrote:
> > > > > > And in particular, not all virtio drivers are hardened -
> > > > > > I think at this point blk and scsi drivers have been hardened - so
> > > > > > treating them all the same looks wrong.
> > > > > My understanding was that they have been audited, Sathya?
> > > >
> > > > Yes, AFAIK, it has been audited. Andi also submitted some patches
> > > > related to it. Andi, can you confirm.
> > >
> > > What is the official definition of "audited"?
> >
> >
> > In our case (Confidential Computing platform), the host is an un-trusted
> > entity. So any interaction with host from the drivers will have to be
> > protected against the possible attack from the host. For example, if we
> > are accessing a memory based on index value received from host, we have
> > to make sure it does not lead to out of bound access or when sharing the
> > memory with the host, we need to make sure only the required region is
> > shared with the host and the memory is un-shared after use properly.
>
> You have not defined the term "audited" here at all in any way that can
> be reviewed or verified by anyone from what I can tell.

Agree.

>
> You have only described a new model that you wish the kernel to run in,
> one in which it does not trust the hardware at all.  That is explicitly
> NOT what the kernel has been designed for so far, and if you wish to
> change that, lots of things need to be done outside of simply running
> some fuzzers on a few random drivers.
>
> For one example, how do you ensure that the memory you are reading from
> hasn't been modified by the host between writing to it the last time you
> did?  Do you have a list of specific drivers and kernel options that you
> feel you now "trust"?  If so, how long does that trust last for?  Until
> someonen else modifies that code?  What about modifications to functions
> that your "audited" code touches?  Who is doing this auditing?  How do
> you know the auditing has been done correctly?  Who has reviewed and
> audited the tools that are doing the auditing?  Where is the
> specification that has been agreed on how the auditing must be done?
> And so on...
>
> I feel like there are a lot of different things all being mixed up here
> into one "oh we want this to happen!" type of thread.  Please let's just
> stick to the one request that I had here, which was to move the way that
> busses are allowed to authorize the devices they wish to control into a
> generic way instead of being bus-specific logic.

I want to continue to shave this proposal down, but that last sentence
reads as self-contradictory.

Bear with me, and perhaps it's a lack of imagination on my part, but I
don't see how to get to a globally generic "authorized" sysfs ABI
given that USB and Thunderbolt want to do bus specific actions on
authorization toggle events. Certainly a default generic authorized
attribute can be defined for all the other buses that don't have
legacy here, but Thunderbolt will still require support for '2' as an
authorized value, and USB will still want to base probe decisions on
the authorization state of both the usb_device and the usb_interface.

> Any requests outside of that type of functionality are just that,
> outside the scope of this patchset and should get their own patch series
> and discussion.

A way to shave this further would be to default authorize just enough
devices to do the rest of the authorization from initramfs. That would
seem to cut out 'virtio-net' and 'virtio-storage' from default
authorized list.

The generic authorized attribute would only need to appear when
'dev_default_authorization' is set to false.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
