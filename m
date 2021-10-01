Return-Path: <SRS0=yNrU=OV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E09C433F5
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 07:03:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEC8619F5
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 07:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CEC8619F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C2AF843FE;
	Fri,  1 Oct 2021 07:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tFWF7QDfl4_m; Fri,  1 Oct 2021 07:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D126184129;
	Fri,  1 Oct 2021 07:03:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A681AC0011;
	Fri,  1 Oct 2021 07:03:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 650ECC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 07:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E74240146
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 07:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FTlzphJTHV1q
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 07:03:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6427340017
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 07:03:33 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 706EA60551;
 Fri,  1 Oct 2021 07:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633071813;
 bh=0W38PdEXHIVQIPll+lj+mk7xZAUxC8QpCqNUBGSB+/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hgoTVKlDOzzRJAnGmyuCwIrPAJq3TBrkWxku6bsjIb9/ByohDLcD1EsZgSY7se0TI
 CG6q4Q9ASHZQ1Ge5WQJ9cuWOdgkVpeIV8KWygEsbGCk3UM89UEA/GOzhDqsNKz+K58
 Qhk0jK55DRI+q71MyjEfmxI23voJ/6FHW597Iwks=
Date: Fri, 1 Oct 2021 09:03:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <YVaywQLAboZ6b36V@kroah.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andi Kleen <ak@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Jamet <michael.jamet@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, X86 ML <x86@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, USB list <linux-usb@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rafael@kernel.org>
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

On Thu, Sep 30, 2021 at 12:04:05PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 9/30/21 8:23 AM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 30, 2021 at 08:18:18AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > 
> > > 
> > > On 9/30/21 6:36 AM, Dan Williams wrote:
> > > > > And in particular, not all virtio drivers are hardened -
> > > > > I think at this point blk and scsi drivers have been hardened - so
> > > > > treating them all the same looks wrong.
> > > > My understanding was that they have been audited, Sathya?
> > > 
> > > Yes, AFAIK, it has been audited. Andi also submitted some patches
> > > related to it. Andi, can you confirm.
> > 
> > What is the official definition of "audited"?
> 
> 
> In our case (Confidential Computing platform), the host is an un-trusted
> entity. So any interaction with host from the drivers will have to be
> protected against the possible attack from the host. For example, if we
> are accessing a memory based on index value received from host, we have
> to make sure it does not lead to out of bound access or when sharing the
> memory with the host, we need to make sure only the required region is
> shared with the host and the memory is un-shared after use properly.

You have not defined the term "audited" here at all in any way that can
be reviewed or verified by anyone from what I can tell.

You have only described a new model that you wish the kernel to run in,
one in which it does not trust the hardware at all.  That is explicitly
NOT what the kernel has been designed for so far, and if you wish to
change that, lots of things need to be done outside of simply running
some fuzzers on a few random drivers.

For one example, how do you ensure that the memory you are reading from
hasn't been modified by the host between writing to it the last time you
did?  Do you have a list of specific drivers and kernel options that you
feel you now "trust"?  If so, how long does that trust last for?  Until
someonen else modifies that code?  What about modifications to functions
that your "audited" code touches?  Who is doing this auditing?  How do
you know the auditing has been done correctly?  Who has reviewed and
audited the tools that are doing the auditing?  Where is the
specification that has been agreed on how the auditing must be done?
And so on...

I feel like there are a lot of different things all being mixed up here
into one "oh we want this to happen!" type of thread.  Please let's just
stick to the one request that I had here, which was to move the way that
busses are allowed to authorize the devices they wish to control into a
generic way instead of being bus-specific logic.

Any requests outside of that type of functionality are just that,
outside the scope of this patchset and should get their own patch series
and discussion.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
