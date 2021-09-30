Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB211C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 13:36:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AFA619EB
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 13:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93AFA619EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A2E44159B;
	Thu, 30 Sep 2021 13:36:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JD7QYf_aboq3; Thu, 30 Sep 2021 13:36:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D0DE642593;
	Thu, 30 Sep 2021 13:36:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0C55C0011;
	Thu, 30 Sep 2021 13:36:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD05AC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA890840E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:36:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D9UjcAeYGwy1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:36:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C58988410D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:36:29 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 d4-20020a17090ad98400b0019ece228690so6764434pjv.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IhpYyYMkI0XeCNTdHlGSDJ81bcd7IFryeGArrY+szTQ=;
 b=tzWjBg/nHXskXvXdSbdUAWirx10WGMvuJ25QnMqWGEKVu117WsUQDqo4BXxwBZM4Vy
 iMml9XLmdFezpL9PbFm884VgwXYcmMmqEdsqZo/9avYsPncDNWceavMqHTp7IFuX5Fiv
 v1r1F93OnXI9jmqpBVM3KAPk4tWkBhXozrofq6QyHPWA5TQdjsNkKSQVf8j8CwL26cu0
 X1L7FlxzkkWZnmbRFR9XxQuyeFhA5I/9zP6wcOvF0wUweSJoIYAs5Q4vf/0C2jEdhC6w
 ywbhSEggIflJxp6X9N1danfTLv6L8n3TWRtAzZkKsVJ10omi+3CgBK5+GJa6KgGcSdJq
 KKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IhpYyYMkI0XeCNTdHlGSDJ81bcd7IFryeGArrY+szTQ=;
 b=i/X1k2PUiYwCZqu7aF6mryBRko5hGM/toivgozEZjWu56b+BLcngLChCaQKgM/gOmT
 4bzjl+5SrHV4QtZCQUaiJwl+ZIyILuC0x2vnSdFBvLL5LWp/V2Fq5Wks8XPxkOLlvnNA
 6k7pzSdxnc+pkFFN2EU9SVCEs+bWjKZ7fUF38UMK43Y9FlQG+naHarS27p9ai066X7V1
 UHFW9FVB+OnvIPCao63nwjBIqUJSdSw2dCy5ULKkqP7IyjovB3UGeHlgnwWRMjMHg6on
 WxLiXVh2IEtjxrsz9JNgR0o3ns9LV5fuprfB6rdnMofMzAf4CpNm6LePq5ISKpFb2tDm
 +spg==
X-Gm-Message-State: AOAM532MZ+1Gglx0dmSEZvt7qFd6XXTMc7wv3DOA12GuwC4i+84nyXOr
 QSx91TDiUAx0J1YVEXYpevI2TMvqZ7LthrnUhtT53g==
X-Google-Smtp-Source: ABdhPJx9Xs+gNqlcxbnlbCdHKqDDoKF331LGbfaO4gqbfJsLmZV5ogqMQNLLtD+mtDfBhXnpfvjX8RedejWnYxnG7hg=
X-Received: by 2002:a17:90b:3ec3:: with SMTP id
 rm3mr5619607pjb.93.1633008989101; 
 Thu, 30 Sep 2021 06:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210930065953-mutt-send-email-mst@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Sep 2021 06:36:18 -0700
Message-ID: <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
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
 USB list <linux-usb@vger.kernel.org>
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

On Thu, Sep 30, 2021 at 4:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 29, 2021 at 06:05:09PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > Confidential guest platforms like TDX have a requirement to allow
> > only trusted devices. By default the confidential-guest core will
> > arrange for all devices to default to unauthorized (via
> > dev_default_authorization) in device_initialize(). Since virtio
> > driver is already hardened against the attack from the un-trusted host,
> > override the confidential computing default unauthorized state
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Architecturally this all looks backwards. IIUC nothing about virtio
> makes it authorized or trusted. The driver is hardened,
> true, but this should be set at the driver not the device level.

That's was my initial reaction to this proposal as well, and I ended
up leading Sathya astray from what Greg wanted. Greg rightly points
out that the "authorized" attribute from USB and Thunderbolt already
exists [1] [2]. So the choice is find an awkward way to mix driver
trust with existing bus-local "authorized" mechanisms, or promote the
authorized capability to the driver-core. This patch set implements
the latter to keep the momentum on the already shipping design scheme
to not add to the driver-core maintenance burden.

[1]: https://lore.kernel.org/all/YQuaJ78y8j1UmBoz@kroah.com/
[2]: https://lore.kernel.org/all/YQzF%2FutgrJfbZuHh@kroah.com/

> And in particular, not all virtio drivers are hardened -
> I think at this point blk and scsi drivers have been hardened - so
> treating them all the same looks wrong.

My understanding was that they have been audited, Sathya?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
