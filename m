Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15FFC43217
	for <virtualization@archiver.kernel.org>; Thu, 13 Oct 2022 17:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 271B360AE0;
	Thu, 13 Oct 2022 17:19:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 271B360AE0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RwP93R0i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlVV1EC8Zsq3; Thu, 13 Oct 2022 17:19:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B8B1E60585;
	Thu, 13 Oct 2022 17:19:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8B1E60585
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D9FBC0032;
	Thu, 13 Oct 2022 17:19:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D57A3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 17:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A37CA60AE0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 17:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A37CA60AE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ucfzoqsBQnTC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 17:19:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F18B560585
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F18B560585
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 17:19:23 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-12c8312131fso3071544fac.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j1qTz+oYugF8Lf770mKCIrdepvqmBbCEzwy+EaukMrM=;
 b=RwP93R0i/58OL7LRD+//xbsGSpXEvsNfrhi2GXL/rRnIR0fEBr1hhf0AxtH9ySaIuq
 fxnBUs5tBFF0nv+sS5fXPWTFdyDQIQyfW3oaIHCHCny57nHo+jkN3VT1oW56ATf0pSAn
 /cXKnAs4MWRb/mczWEGT2NYOdgosHqzbcK1Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j1qTz+oYugF8Lf770mKCIrdepvqmBbCEzwy+EaukMrM=;
 b=PHSOiFE+cgY/Rch79KkCiYh0USp/pcCa915yUNC/mTkZUm9y8N42Erba7IorvrV/kD
 rti5TORLxNPZI77Dph+aTmpiIUzFzEbLBACmCQXdCQPYyiMCpcf3C4kMwfqUL1vEJ4xt
 /kZYJRHqoENza1zUDDGtFqF+iZxoZkMyVE5o5ZMJl0X8KUoIPYEfH7lL1n5s+GIGR7jn
 QDyFai6nLz+oXbKerlaEQXfPKWvPZdhY6IvcRKXyOC4bhbNpaJ4pfeErwtjyk7Tn82Lq
 vzeWFEVYHKCkYrG6uEuXK+Knh4PO83bgenPEFXEPq0P1EuihHWWdvVCecE/AVATykTlO
 8RPw==
X-Gm-Message-State: ACrzQf3f0vzFsq/fE6CmHjsI/VCFcki2VRcZumwPC2LBNaOysimGin1D
 8Hetckzfz5wom4sCnGV3Jo4u+iew8cDK3xL5
X-Google-Smtp-Source: AMsMyM7h54uP+OvMN2EdlFrCBD4qJWYaHh/j65atqrPLtIa4KLBWGZN/oGnypXAT3qfh5qqc9NlhFw==
X-Received: by 2002:a05:6870:a114:b0:132:8139:f640 with SMTP id
 m20-20020a056870a11400b001328139f640mr6133370oae.198.1665681562383; 
 Thu, 13 Oct 2022 10:19:22 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com.
 [209.85.210.47]) by smtp.gmail.com with ESMTPSA id
 n1-20020a4ae741000000b0044b47bb023fsm2323527oov.37.2022.10.13.10.19.19
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Oct 2022 10:19:19 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id
 r8-20020a056830120800b00661a0a236efso425447otp.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 10:19:19 -0700 (PDT)
X-Received: by 2002:a05:6830:4421:b0:661:8fdd:81e9 with SMTP id
 q33-20020a056830442100b006618fdd81e9mr528782otv.69.1665681558964; Thu, 13 Oct
 2022 10:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au> <87edvdm7qg.fsf@mpe.ellerman.id.au>
 <20221012115023-mutt-send-email-mst@kernel.org>
 <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
 <38893b2e-c7a1-4ad2-b691-7fbcbbeb310f@app.fastmail.com>
 <20221012180806-mutt-send-email-mst@kernel.org>
 <a35fd31b-0658-4ac1-8340-99cdf4c75bb7@app.fastmail.com>
In-Reply-To: <a35fd31b-0658-4ac1-8340-99cdf4c75bb7@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Oct 2022 10:19:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLv3MO0Tvc62zJ+=4yvSfKMK17C0wfpbXBwUJqSjKbYA@mail.gmail.com>
Message-ID: <CAHk-=whLv3MO0Tvc62zJ+=4yvSfKMK17C0wfpbXBwUJqSjKbYA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: fixes, features
To: Arnd Bergmann <arnd@arndb.de>
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 wangdeming@inspur.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>,
 angus.chen@jaguarmicro.com, Bjorn Helgaas <bhelgaas@google.com>,
 lingshan.zhu@intel.com, linuxppc-dev@lists.ozlabs.org, gavinl@nvidia.com
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

On Wed, Oct 12, 2022 at 11:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 13, 2022, at 12:08 AM, Michael S. Tsirkin wrote:
> >
> > Do these two boxes even have pci?
>
> Footbridge/netwinder has PCI and PC-style ISA on-board devices
> (floppy, ps2 mouse/keyboard, parport, soundblaster, ...), RiscPC
> has neither.

It's worth noting that changing a driver that does

        if (dev->irq == NO_IRQ)
                return -ENODEV;

to use

        if (!dev->irq)
                return -ENODEV;

should be pretty much always fine.

Even *if* that driver is then compiled and used on an architecture
where NO_IRQ is one of the odd values, you end up having only two
cases

 (a) irq 0 was actually a valid irq after all

 (b) you just get the error later when actually trying to use the odd
NO_IRQ interrupt with request_irq() and friends

and here (a) basically never happens - certainly not for any PCI setup
- and (b) is harmless unless the driver was already terminally broken
anyway.

The one exception for (a) might be some platform irq code. On x86,
that would be the legacy timer interrupt, of course.

So if some odd platform actually has a "real" interrupt on irq0, that
platform should either just fix the irq number mapping, or should
consider that interrupt to be a platform-specific thing and handle it
very very specially.

On x86, for example, we do

        if (request_irq(0, timer_interrupt, flags, "timer", NULL))

early in boot, and that's basically what then makes sure that no
driver can get that irq. It's done through the platform "timer_init"
code at the "late_time_init()" call.

(And that "late_time_init()" - despite the name - isn't very late at
all. It's just later than the very early timekeeping init - after
interrupts have been enabled at all.

             Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
