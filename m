Return-Path: <SRS0=yNrU=OV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85328C433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 02:20:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA3A61A54
	for <virtualization@archiver.kernel.org>; Fri,  1 Oct 2021 02:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EA3A61A54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D52408355C;
	Fri,  1 Oct 2021 02:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rlEXHgCEHmdL; Fri,  1 Oct 2021 02:20:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6598C828EF;
	Fri,  1 Oct 2021 02:20:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD4EC000F;
	Fri,  1 Oct 2021 02:20:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47596C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 02:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2873E60635
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 02:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JZqsqjpjTxm3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 02:20:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55BD460629
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 02:20:15 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id c4so5329049pls.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H1v7bfhbOYS9QQdwJ+dS1BX8nNt2lEyswi+C4uaCxgo=;
 b=MCfltqqpgRZMipzrqKNzE4TCzkTYOE432mzaARuP6ZAPdOOvgGLlpUvdiffi7khzpY
 r5ytcuFoPT7QP1M4OkD8d4AAlvn+vL0MyimnfkqRJhaR81vcmlu24dPrEc+YtKAlQybA
 7uURmtuUtHfa/Nr7Epu3ozIGiZBUv0ryceNZpKerlCXqf9QNQpSj9B83sEeRR3HGje2V
 ccammWBDCWeMLsP2DpIOuH4BWPqRZiqqTRMGUl6o6QVUfFIn9+Kh4TihdfnVd9FVq5xA
 pfY/wl98KGZ2b/jqHOnCN5/hR5tIVmL9HTa0U3Dihde1AMTPm61wVlHLUYFEkJnvJlU6
 RSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H1v7bfhbOYS9QQdwJ+dS1BX8nNt2lEyswi+C4uaCxgo=;
 b=LKrDiyeQML7mXeEj8pxYvtqc4kAPDOR+1cEM78D6tlTk5pFCxCgztDrGeD5aN19LA+
 JaEcNfYouFoxbN83531E51/tFb2ggsGC0UIxALThDvzMNwyGfedhSfoXkbnYCwb4VoMn
 QeBGwUqgfL0nEa2n5WBbdR+kBrDCDAwVnUFA62jcYCpexVQ65Nc2tvo7gMhYxGfFoxC5
 +klrtZM2duFkBGPnu2CXMBg7NferUYFXZVqgz/q+rbuTxhXhBPVuHLjQ4TBbpP5l5jye
 LvaVD4+WleJum4da6q9hIlDFyVo1NT4CSLjjBdwPamY/KXelUY0buAmWol/yudm3N/2v
 bXgw==
X-Gm-Message-State: AOAM531ZJ3Oh1jdWg79oVPwuzTOkcruwiN3y0R/qnZHzKuhEHpboiohx
 9efCeHQdPKfeToTHmg7xdeDyFIqdYLcArbG7sddouQ==
X-Google-Smtp-Source: ABdhPJw3+LICXsBfSEFCKXlafRA7xXZxwrcD4LdHbM7zaf1EyXu36rjRKL9bEqMGIfW1AeETHE+7h0w47T6Gie9PJI0=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr5975436plo.4.1633054814608; Thu, 30 Sep
 2021 19:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org> <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104924-mutt-send-email-mst@kernel.org>
 <20210930153509.GF464826@rowland.harvard.edu>
 <20210930115243-mutt-send-email-mst@kernel.org>
 <00156941-300d-a34a-772b-17f0a9aad885@linux.intel.com>
 <20210930204447.GA482974@rowland.harvard.edu>
 <CAPcyv4j8DvsMYppRtm=+JQWc7nJGoXeAGGz9U150x0p_KekqcA@mail.gmail.com>
 <20211001014114.GB489012@rowland.harvard.edu>
In-Reply-To: <20211001014114.GB489012@rowland.harvard.edu>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Sep 2021 19:20:04 -0700
Message-ID: <CAPcyv4iRo0Hd=_3jAScb5KUEJp3bU=QrWM8FYeb94SzO4gqgJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Andreas Noever <andreas.noever@gmail.com>, "Reshetova,
 Elena" <elena.reshetova@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>, Borislav Petkov <bp@alien8.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
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

On Thu, Sep 30, 2021 at 6:41 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Sep 30, 2021 at 01:52:59PM -0700, Dan Williams wrote:
> > On Thu, Sep 30, 2021 at 1:44 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Thu, Sep 30, 2021 at 12:23:36PM -0700, Andi Kleen wrote:
> > > >
> > > > > I don't think the current mitigations under discussion here are about
> > > > > keeping the system working. In fact most encrypted VM configs tend to
> > > > > stop booting as a preferred way to handle security issues.
> > > >
> > > > Maybe we should avoid the "trusted" term here. We're only really using it
> > > > because USB is using it and we're now using a common framework like Greg
> > > > requested. But I don't think it's the right way to think about it.
> > > >
> > > > We usually call the drivers "hardened". The requirement for a hardened
> > > > driver is that all interactions through MMIO/port/config space IO/MSRs are
> > > > sanitized and do not cause memory safety issues or other information leaks.
> > > > Other than that there is no requirement on the functionality. In particular
> > > > DOS is ok since a malicious hypervisor can decide to not run the guest at
> > > > any time anyways.
> > > >
> > > > Someone loading an malicious driver inside the guest would be out of scope.
> > > > If an attacker can do that inside the guest you already violated the
> > > > security mechanisms and there are likely easier ways to take over the guest
> > > > or leak data.
> > > >
> > > > The goal of the device filter mechanism is to prevent loading unhardened
> > > > drivers that could be exploited without them being themselves malicious.
> > >
> > > If all you want to do is prevent someone from loading a bunch of
> > > drivers that you have identified as unhardened, why not just use a
> > > modprobe blacklist?  Am I missing something?
> >
> > modules != drivers (i.e. multi-driver modules are a thing) and builtin
> > modules do not adhere to modprobe policy.
> >
> > There is also a desire to be able to support a single kernel image
> > across hosts and guests. So, if you were going to say, "just compile
> > all unnecessary drivers as modules" that defeats the common kernel
> > image goal. For confidential computing the expectation is that the
> > necessary device set is small. As you can see in the patches in this
> > case it's just a few lines of PCI ids and a hack to the virtio bus to
> > achieve the goal of disabling all extraneous devices by default.
>
>
>
> If your goal is to prevent some unwanted _drivers_ from operating --
> or all but a few desired drivers, as the case may be -- why extend
> the "authorized" API to all _devices_?  Why not instead develop a
> separate API (but of similar form) for drivers?
>
> Wouldn't that make more sense?  It corresponds a lot more directly
> with what you say you want to accomplish.

This was v1. v1 was NAKd [1] [2]:

[1]: https://lore.kernel.org/all/YQwpa+LAYt7YZ5dh@kroah.com/
[2]: https://lore.kernel.org/all/YQzDqm6FOezM6Rnu@kroah.com/

> What would you do in the theoretical case where two separate drivers
> can manage the same device, but one of them is desired (or hardened)
> and the other isn't?

Allow for user override, just like we do today for new_id, remove_id,
bind, and unbind  when default driver policy is insufficient.

echo 1 > /sys/bus/$bus/devices/$device/authorized
echo $device > /sys/bus/$bus/drivers/$desired_driver/bind

The device filter is really only necessary to bootstrap until you can
run override policy scripts. The driver firewall approach was overkill
in that regard.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
