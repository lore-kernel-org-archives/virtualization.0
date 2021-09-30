Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B21C433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 20:24:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2E061A40
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 20:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB2E061A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A633B400D5;
	Thu, 30 Sep 2021 20:24:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rx5OHiwA53XE; Thu, 30 Sep 2021 20:24:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B54140208;
	Thu, 30 Sep 2021 20:24:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE691C000F;
	Thu, 30 Sep 2021 20:24:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C37EC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 20:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0381E400D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 20:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrBuCqDJF3yp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 20:24:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A64C5400C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 20:24:08 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 om12-20020a17090b3a8c00b0019eff43daf5so5672449pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YNu/YUTTEta1euczrqSgmEotnhGowg7gkC/LCBiwK4s=;
 b=xj9wCZapqmLIJztql+O6rs7uhLCij1deyqu/+aL8hw5KpdACRtEzLzlrczZPQazJf2
 FupFdb9n864IVhhEWE2BFU2kLYdnzUmtFaxbjHm6lb//5fDkvE5CAaUcSQvsRG36P8PP
 eun2CY6L6A5F0Wlzc/fObt5myxz90grs1McqqY8m7v98HFHvToc+FDZTHTkWeW44HECM
 xCD+ovGiDADokJx7WJDuutLzRkMC4VORWMEfE6EY2d8Olt83Rs2NuhEFcPoVePw5SUH+
 SZYrcirr0KsiRYZZIdz5IaTMK6SzVZ+teg347CmH3QnWX3NUvpnIOGpCQjLVm0yeaTnN
 DPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YNu/YUTTEta1euczrqSgmEotnhGowg7gkC/LCBiwK4s=;
 b=0uuMDpABaQj9a9DhrFXF63n+Yb1s/mUnXxRli8pOf82XO61y6xM/bVEmov08Sk8z6t
 Z7l06UQ9i2BTKqRfBd0Uph3n9FSIyAWcPS1/suDEVOZOC6ry6KFLOGKJRN6UL+2BBFcm
 m+3AZkkglVeJ4Ofw6ykyMH2WYg2Of6C34vDgcjX5AwmG1pFJgXzYo3j5DLu4tMzIec4K
 g0gy7lBPvRn3PP6ZuprSs21018EMjtwBbjgRkCHk/mZ/mjDAtjbhj482KvoGqBici1kH
 XM7zotteAayQGYzBPSxzw7+A6Eo46PwMpSTq68UK9KAP4a4pRTAfGr6/lHorDbDHw1rC
 fppg==
X-Gm-Message-State: AOAM5312df6wC28Hz4B+PHD3DqPTWu2KH3MRUxUROpSXcFr43KmV/7WI
 Aq2PXzq2APgPafBilCXQ6ID6dAEuBpVNaOX3TUOshg==
X-Google-Smtp-Source: ABdhPJxHo0SPWEXvKFwCQCE3PBZOqr998IUbVvJMOZmF3XCbHGVfqolawYuaus/mRtyLVKphZnv5zDwZadqtIJCP1+I=
X-Received: by 2002:a17:90b:3ec3:: with SMTP id
 rm3mr7610144pjb.93.1633033447983; 
 Thu, 30 Sep 2021 13:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CA+CmpXtXn5wjxwow5va5u9qHcQDLkd4Sh2dcqB545SXaxV1GkQ@mail.gmail.com>
 <CAPcyv4iNp41mZcpzGCPR9Xty83j+abk_SOxvsx1xaQ8wALRv0Q@mail.gmail.com>
 <CA+CmpXvGCAny-WHGioJQHF9ZZ5pCaR-E_rw5oeE82xC30naVXg@mail.gmail.com>
 <CAPcyv4ixqiMw1KTB8rbzzrtaErV4PT3R3XqshHhAXv6Ohjzs1Q@mail.gmail.com>
 <c701ca61-4e7d-1060-102f-8f92dd6e6802@linux.intel.com>
In-Reply-To: <c701ca61-4e7d-1060-102f-8f92dd6e6802@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Sep 2021 13:23:57 -0700
Message-ID: <CAPcyv4gZ=pm5GKV5q-QDqaVw+HAepiLdAokbcgqKooH-6bZcEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andreas Noever <andreas.noever@gmail.com>,
 Andi Kleen <ak@linux.intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 virtualization@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Linux PCI <linux-pci@vger.kernel.org>, Yehezkel Bernat <yehezkelshb@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Sep 30, 2021 at 12:50 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 9/30/21 12:04 PM, Dan Williams wrote:
> >>> That's why it was highlighted in the changelog. Hopefully a
> >>> Thunderbolt developer can confirm if it is a non-issue.
> >>> Documentation/ABI/testing/sysfs-bus-thunderbolt does not seem to
> >>> answer this question about whether authorized_show and
> >>> authorized_store need to be symmetric.
> >> Apparently, Bolt does read it [1] and cares about it [2].
> > Ah, thank you!
> >
> > Yeah, looks like the conversion to bool was indeed too hopeful.
> >
>
> IIUC, the end result of value "2" in authorized sysfs is to just
> "authorize" or "de-authorize". In that case, can the user space
> driver adapt to this int->bool change? Just want to know the
> possibility.

ABIs are forever. The kernel has to uphold its contract to bolt that
it will return '2' and not '1' after '2' has been written.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
