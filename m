Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C341C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 21:04:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D9F613DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 21:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31D9F613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F104160727;
	Mon,  4 Oct 2021 21:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OzcJo5DAET9r; Mon,  4 Oct 2021 21:04:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BE6260670;
	Mon,  4 Oct 2021 21:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D29DC000F;
	Mon,  4 Oct 2021 21:04:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9E42C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 21:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCCD683BB6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 21:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 069gvJP9SJmB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 21:04:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFAFA83BB5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 21:04:28 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id u7so15538323pfg.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dTL71zCsO4wuS7DXxshZZRFAlW1Q/e6e78gucQODCPs=;
 b=XmzdavWE+xPwKjOfD7fVZBYLqzsaZ82tzU8rY7LUQTZzp2u58uvRub2eqnWLAelR42
 wLD6XtFTKQ+DXn86Rk1NjlffjspX7Z4xONQzcrRTl6WpCYAKGNigChzH1USP/+YHqV9S
 vZc+p0UEL2hD82BqL0dO/uxnq3Mnqc8ctr4Gz/pURtRB4rk3jKWFsKsMSYSX2m2E8Azg
 RvMWFiiLTiyyKXeTVFLm1BvWmS9VifSoG/e7OsLK26L+G/3Hp+Ihcr8dknzhk96b2FzO
 e6oEQdoZCpclC6RmTbpgM9m3MeKwU3UAkXLsknw16zQ5X13Esxb3XHzrZsCcKkqqTG+H
 anFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dTL71zCsO4wuS7DXxshZZRFAlW1Q/e6e78gucQODCPs=;
 b=kPkOGr3ausRLcSTVGpZ6QtS7oG5yaiaZv8LteXaNMPVRicZpERXrGTXU57bnU0IiqX
 nfAl4KC34cSck1UKV7CCZ/2pQolzCl8vLCBHy3geKwnXTDJzmvo0Mnwk4ak7YsZLgRYt
 xMHM2TokuqIIvQX0Ys2PZyK6Z3cUZ5fQb3Ax+eX9JbLdFhqZ7/XqmfcIz8YGZcQMT2pa
 6xzPOJaxuEJW33yfe6G0UMcwVH301GNohlBBcXaodao60FJRQg00kdWSSseP+ClBLGEI
 kj6gquEgk1AysSmF5GAnPThXmjggxQMKs2MYP/uWCQ7dqg6m9TKqpYcq9Vmtreg+18Lv
 Dh2Q==
X-Gm-Message-State: AOAM530vClnU7Zrpqr/9X7CFxuuxtfYCjUIj07zHRINHWvaiGsfUdFUW
 UjiA1TEsS7m7haT5XePnMDwGSWvkgGk0yhFGTcq9Eg==
X-Google-Smtp-Source: ABdhPJwtA7a1u8MewgFOuQ4ODk6qNf/e8OOxKzSS55rulMOQukdTduuScadVjnccrxY46jGbRZAxi2Ttqu24INezDC8=
X-Received: by 2002:a05:6a00:1a01:b0:44c:1ec3:364f with SMTP id
 g1-20020a056a001a0100b0044c1ec3364fmr19009668pfv.86.1633381468208; Mon, 04
 Oct 2021 14:04:28 -0700 (PDT)
MIME-Version: 1.0
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
 <YVg/F10PCFNOtCnL@kroah.com>
 <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
In-Reply-To: <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Oct 2021 14:04:20 -0700
Message-ID: <CAPcyv4jfdVTMtvhoUJ5B-ka596RgEH_0RLathfKL9aAi9+0apg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To: Andi Kleen <ak@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Reshetova, Elena" <elena.reshetova@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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

On Sat, Oct 2, 2021 at 7:20 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 10/2/2021 4:14 AM, Greg Kroah-Hartman wrote:
> > On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
> >> On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> >>>>    Do you have a list of specific drivers and kernel options that you
> >>>> feel you now "trust"?
> >>> For TDX it's currently only virtio net/block/console
> >>>
> >>> But we expect this list to grow slightly over time, but not at a high rate
> >>> (so hopefully <10)
> >> Well there are already >10 virtio drivers and I think it's reasonable
> >> that all of these will be used with encrypted guests. The list will
> >> grow.
> > What is keeping "all" drivers from being on this list?
>
> It would be too much work to harden them all, and it would be pointless
> because all these drivers are never legitimately needed in a virtualized
> environment which only virtualize a very small number of devices.
>
> >   How exactly are
> > you determining what should, and should not, be allowed?
>
> Everything that has had reasonable effort at hardening can be added. But
> if someone proposes to add a driver that should trigger additional
> scrutiny in code review. We should also request them to do some fuzzing.
>
> It's a bit similar to someone trying to add a new syscall interface.
> That also triggers much additional scrutiny for good reasons and people
> start fuzzing it.
>
>
> >    How can
> > drivers move on, or off, of it over time?
>
> Adding something is submitting a patch to the allow list.
>
> I'm not sure the "off" case would happen, unless the driver is
> completely removed, or maybe it has some unfixable security problem. But
> that is all rather unlikely.
>
>
> >
> > And why not just put all of that into userspace and have it pick and
> > choose?  That should be the end-goal here, you don't want to encode
> > policy like this in the kernel, right?
>
> How would user space know what drivers have been hardened? This is
> really something that the kernel needs to determine. I don't think we
> can outsource it to anyone else.

How it is outsourcing by moving that same allow list over the kernel /
user boundary. It can be maintained by the same engineers and get
deployed by something like:

dracut --authorize-device-list=confidential-computing-default $kernel-version

With that distributions can deploy kernel-specific authorizations and
admins can deploy site-specific authorizations. Then the kernel
implementation is minimized to authorize just enough drivers by
default to let userspace take over the policy.

> Also BTW of course user space can still override it, but really the
> defaults should be a kernel policy.

The default is secure, trust nothing but bootstrap devices.

> There's also the additional problem that one of the goals of
> confidential guest is to just move existing guest virtual images into
> them without much changes. So it's better for such a case if as much as
> possible of the policy is in the kernel. But that's more a secondary
> consideration, the first point is really the important part.

The same image can be used on host and guest in this "do it in
userspace" proposal.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
