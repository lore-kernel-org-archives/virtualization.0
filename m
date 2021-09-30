Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDBC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:25:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D0861A2C
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4D0861A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9AAF84076A;
	Thu, 30 Sep 2021 15:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKw6T68z1md1; Thu, 30 Sep 2021 15:25:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE4DC4036A;
	Thu, 30 Sep 2021 15:25:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCCC0C0011;
	Thu, 30 Sep 2021 15:25:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 517A3C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39F35425A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MjxJkQCr5KwU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:25:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B28E64074D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:25:46 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id r201so692817pgr.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iIxgYNDztL7Z5NZD7Jrw2Q8W9/sF09Rvn/hN4H8sJ6s=;
 b=H9ByBCwUFoisbggQfboACP31KYAVClsy6c2zsT8A18/94EX+AnluzG1qujii4U0mXT
 3l96j2LXb6DMlHQlhr/CLemSNhGGqawiFsMbdelCPbB2zN028oULxdodOhY85xhryQtb
 k+DZww7m+rKmc3v7sZs7XWqntRlSwLBw4TfVkkOlsJT5/RhGPdUOzrP6c2PZlrsEGs5D
 MvUBojQkUYkfrK5jEUOzFV8tUfb/ViVq+LQZ9DSIcsGrwmgKlFZreeu8G2wd7kuW1vnq
 kSp18ebDWzKdvr1UPRjO2MEykMiEfFsfiDuep2Z859xwM7cOMrAwL3NsmQNsK4RPHXLN
 Zbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iIxgYNDztL7Z5NZD7Jrw2Q8W9/sF09Rvn/hN4H8sJ6s=;
 b=swvDhWcB2b7azq2h3HUf7aEejTkonvDD5kEhYZhkNlrpH7LrhHhD2q2CklvFDUGrN6
 cE14zjqOu6xA5rCX77OxY+zOMUv+F/j3oCgBxrYb3vt3vFg+pcPQcYUHJUYv2FZu4hy1
 FId8vS/M27tNdPxW2QudDMRCcjeRxq7fNFzXy8ztYrAJ+clAbXRi393P51uDW0G7K8xc
 CnGN65Oebi/+BVD9+aZ+UgpH9W5uKKV4l4rxLpqCIlXOVu/PakBetBYg/yyUrFp79dgO
 2mpTHxakOBssvgTJdWiHuHiXI061NUDiESjFeu+5HLCcyY6hSGp4u8mWHy195DPcirjE
 euJw==
X-Gm-Message-State: AOAM533YBNgztNanaf744P4eh1ER+AdCwCmjomDAV3MOavH45ZQMj+/y
 2L821NC8BBxp0TftslBd9tGA1HHzOg5BpMzZ3wGtWg==
X-Google-Smtp-Source: ABdhPJxC9LlLHCc9VsuLNd2ENfEgS7lqcNO31wz+nFKZyLdakX6Gg7y18epJgAQ/l5pu2ntO4OPx+josqq5a+ijdZqA=
X-Received: by 2002:aa7:9d84:0:b0:447:c2f4:4a39 with SMTP id
 f4-20020aa79d84000000b00447c2f44a39mr4974478pfq.86.1633015546058; Thu, 30 Sep
 2021 08:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu>
 <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
 <20210930145932.GB464826@rowland.harvard.edu>
In-Reply-To: <20210930145932.GB464826@rowland.harvard.edu>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Sep 2021 08:25:35 -0700
Message-ID: <CAPcyv4gZp3dx9JDKiRSkuCF1=5w-g5gVd1SrcA_WfLtYjo4BQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To: Alan Stern <stern@rowland.harvard.edu>
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

On Thu, Sep 30, 2021 at 8:00 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Sep 29, 2021 at 06:55:12PM -0700, Dan Williams wrote:
> > On Wed, Sep 29, 2021 at 6:43 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Wed, Sep 29, 2021 at 06:05:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > Currently bus drivers like "USB" or "Thunderbolt" implement a custom
> > > > version of device authorization to selectively authorize the driver
> > > > probes. Since there is a common requirement, move the "authorized"
> > > > attribute support to the driver core in order to allow it to be used
> > > > by other subsystems / buses.
> > > >
> > > > Similar requirements have been discussed in the PCI [1] community for
> > > > PCI bus drivers as well.
> > > >
> > > > No functional changes are intended. It just converts authorized
> > > > attribute from int to bool and moves it to the driver core. There
> > > > should be no user-visible change in the location or semantics of
> > > > attributes for USB devices.
> > > >
> > > > Regarding thunderbolt driver, although it declares sw->authorized as
> > > > "int" and allows 0,1,2 as valid values for sw->authorized attribute,
> > > > but within the driver, in all authorized attribute related checks,
> > > > it is treated as bool value. So when converting the authorized
> > > > attribute from int to bool value, there should be no functional
> > > > changes other than value 2 being not visible to the user.
> > > >
> > > > [1]: https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > > >
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > >
> > > Since you're moving the authorized flag from the USB core to the
> > > driver core, the corresponding sysfs attribute functions should be
> > > moved as well.
> >
> > Unlike when 'removable' moved from USB to the driver core there isn't
> > a common definition for how the 'authorized' sysfs-attribute behaves
> > across buses. The only common piece is where this flag is stored in
> > the data structure, i.e. the 'authorized' sysfs interface is
> > purposefully left bus specific.
>
> How about implementing "library" versions of show_authorized() and
> store_authorized() that the bus-specific attribute routines can call?
> These library routines would handle parsing the input values, storing
> the new flag, and displaying the stored flag value.  That way at
> least the common parts of these APIs would be centralized in the
> driver core, and any additional functionality could easily be added
> by the bus-specific attribute routine.
>

While show_authorized() seems like it could be standardized, have a
look at what the different store_authorized() implementations do.
Thunderbolt wants "switch approval" vs "switch challenge" and USB has
a bunch of bus-specific work to do when the authorization state
changes. I don't see much room for a library to help there as more
buses add authorization support. That said I do think it would be
useful to have a common implementation available for generic probe
authorization to toggle the flag if the bus does not have any
authorization work to do, but that seems a follow-on once this core is
accepted.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
