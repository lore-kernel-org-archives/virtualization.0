Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EF1C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 01:04:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59EE61212
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 01:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A59EE61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 707B76070B;
	Tue, 24 Aug 2021 01:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCZVd26c3N6g; Tue, 24 Aug 2021 01:04:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F3EDC60717;
	Tue, 24 Aug 2021 01:04:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B01B7C001A;
	Tue, 24 Aug 2021 01:04:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 925F5C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 01:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7463540333
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 01:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ja2AzFglao7y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 01:04:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A84DB40311
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 01:04:11 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id x16so16884120pfh.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+KWjXh2lT4oyxvT6TUUge6cE2M/3E1/QPatrdIWAbCk=;
 b=ssDUJbZQUoHOjzKeOoupouQflaDtoV/KGM0ZbImx65Id9YAIXzBr7xLGKgTJu5h7I2
 HHPWAyYNY1bDMlXgvnD4vDkqa1dsykDsMeTtzg3vHCZHA743vpTJ8zJ4NdfqSdbmmqvy
 KiEWa7Khi9N0O/9RoziHtutYHO2/nwyh6DBm4tBUK7GNpef0LXqDL+0p5s3nrsgMW6K/
 FFWm8o5SonyxAvLyA2+U5fUS7ZWjvbxn5iMEzqko5Bo0H+b6KX6dRPsNpkxsT+0zJzz9
 wV+DeBmwuvYfrQWDLM0QASdRWxoXpFfTwLTHLiDMsXuWjkskMss7fMermWEKgv/FmCUr
 IxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+KWjXh2lT4oyxvT6TUUge6cE2M/3E1/QPatrdIWAbCk=;
 b=GpprBhJyhXKox3qD37XQFjWzX2prewHpSEzsH/qC7ly5uOHCIlykweRydXxpu7VYvb
 hOpND8OjUQJTCVxF82cOC9IvdRbAdjEOEoW8ldDySOuoanmA/tQ7/t5+kg8TkQDhSPi9
 ds8q3y9l+5iZIOkcqmc/jLIwOj4qUUg1DI8QQM2+Txn1zmQ6Yyl0kS7oSMkzsur28T7b
 8AWv4eeeftJjbymsiiNli8zmEX9VLF8RLCJQUgR9qcSC05GS1RHnLQ5j2kqzQNNOnElM
 TNuPhdnyPe9lStLX4rPwVbO7ypzrqu+FQE/Vn2XsofU3WGdpIZWtcO7Ye9XuYwgRIrSe
 6Z9g==
X-Gm-Message-State: AOAM532Qp/66hvMk4udC6o7eycj9T1iNqzJDtwOiBfiizrYusyX/rELJ
 yzaWilYSpZ8+RBEZ213pTzkpJ46bJdF1VODoijXEhQ==
X-Google-Smtp-Source: ABdhPJwr+d+03lWZE5hBC3RKJQrz+BrvZKJ9PwHrCLpkrlXplyqx0kAfavOgC5QFY0A8k9yCeP+k8gHn1t12t0fKZcY=
X-Received: by 2002:a05:6a00:16c6:b029:32d:e190:9dd0 with SMTP id
 l6-20020a056a0016c6b029032de1909dd0mr36118105pfc.70.1629767051049; Mon, 23
 Aug 2021 18:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
In-Reply-To: <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 23 Aug 2021 18:04:00 -0700
Message-ID: <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>, linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
 Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
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

On Mon, Aug 23, 2021 at 5:31 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
> >> Add a new variant of pci_iomap for mapping all PCI resources
> >> of a devices as shared memory with a hypervisor in a confidential
> >> guest.
> >>
> >> Signed-off-by: Andi Kleen<ak@linux.intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> > I'm a bit puzzled by this part. So why should the guest*not*  map
> > pci memory as shared? And if the answer is never (as it seems to be)
> > then why not just make regular pci_iomap DTRT?
>
> It is in the context of confidential guest (where VMM is un-trusted). So
> we don't want to make all PCI resource as shared. It should be allowed
> only for hardened drivers/devices.

That's confusing, isn't device authorization what keeps unaudited
drivers from loading against untrusted devices? I'm feeling like
Michael that this should be a detail that drivers need not care about
explicitly, in which case it does not need to be exported because the
detail can be buried in lower levels.

Note, I specifically said "unaudited", not "hardened" because as Greg
mentioned the kernel must trust drivers, its devices that may not be
trusted.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
