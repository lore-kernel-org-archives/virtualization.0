Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81385C4338F
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 12:49:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A276113C
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 12:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25A276113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0048401E9;
	Thu,  5 Aug 2021 12:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1SZKHBs7Cwn; Thu,  5 Aug 2021 12:49:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 875B5401CB;
	Thu,  5 Aug 2021 12:49:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C3B5C0010;
	Thu,  5 Aug 2021 12:49:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B56A0C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 12:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 920CE81DCB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 12:49:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yZ-0L3MlcSR1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 12:49:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5C9481D67
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 12:49:26 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 dw2-20020a17090b0942b0290177cb475142so14496586pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=F1MbFXcnuN9pjWPNAa72glUadkAUJinAs+z8GV+IyLk=;
 b=GPPWMa0bFoy0buCBXmfsNtAnrv5MXxcRHUZJ7/r7DHglcCHVdT5R2BkodtNr8fXb9E
 wPevm0KEqOa9H8wb/A3lHwCeo8e090BOPSSbzj+FsYFI3DUeUnHD8HjOHwVMfiWeQ1wh
 wTknrNOO8Sig9Lj5qWg7ty5OgIgw194KG4e165244BPRJ3xWGTmJFMoV8LtbfRCIXTII
 P5dlErGWaZzNzirHtL2HKOfUAdVztx58SsHeyqTIBzCmqyp+TZvk6npEI3Nfiw6ZErVE
 PW4aWzRFnLQFh4gxeXk8A6mZVTR8SBP+jVOccXd568slgkD5dKs9L+UBx8GzZDKuDZha
 dZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F1MbFXcnuN9pjWPNAa72glUadkAUJinAs+z8GV+IyLk=;
 b=Dsmz8k6ucUyrup/z/ApLi8ECeL04c10fnvxAiTAkLlelIJ/2Bw57ZIRABiZWIt7lE6
 +ffuU2HK/+om2g1jaLTAZe8iJY3Jr6jP/rC6OBxBn9pbUpMknMOxGTtUHdbkXkNVFvcW
 gALmORUTzCOksBRfFHjKKf7qerA1hGUh+4WBWY36TWdke+50SUIY4xzlkWZ4SptNJU0/
 qqb/mS/keDUJMci4C4pKaXSVMOp04Lv38ewwAjTkF5CwJzGQDoWLqAFdn4vNCygy3e38
 a0LhXihlRQiqk+aqNoG+LtS51gfZvl9E/LrSqoj8MEB5bfVfNesSVJYn1ryNUgkhedTH
 1pnw==
X-Gm-Message-State: AOAM531N9Js+OdIhXrgeT4Y9+VvANn10XbaoZprWUpbpbjf4lMmGySUY
 XWp3DGMxNZx2RMgGfzqX3G2tVw==
X-Google-Smtp-Source: ABdhPJz0h7q3yTGaeHYn8lFKeSzJMOv94e7fkfP1oY5TE3vNb42+mj6TLtrxhtTA2RCH7pmg/EpgDw==
X-Received: by 2002:a17:90a:1f8a:: with SMTP id
 x10mr4472178pja.167.1628167766138; 
 Thu, 05 Aug 2021 05:49:26 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id u16sm7963740pgh.53.2021.08.05.05.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Aug 2021 05:49:25 -0700 (PDT)
Date: Thu, 5 Aug 2021 18:19:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [Stratos-dev] [PATCH V4 2/2] gpio: virtio: Add IRQ support
Message-ID: <20210805124922.j7lts7tfmm4t2kpf@vireshk-i7>
References: <cover.1627989586.git.viresh.kumar@linaro.org>
 <75c8e6e5e8dfa1889938f3a6b2d991763c7a3717.1627989586.git.viresh.kumar@linaro.org>
 <CAK8P3a29NfFWwtGHhqos1P8f_SmzPJTXvEY5BZJAEMbV2SKe-Q@mail.gmail.com>
 <0100017b1610f711-c53c79f2-9e28-4c45-bb42-8db09688b18e-000000@email.amazonses.com>
 <CAK8P3a0DWkfQcZpmyfKcdNt1MHf8ha6a9L2LmLt1Tv-j0HDr3w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0DWkfQcZpmyfKcdNt1MHf8ha6a9L2LmLt1Tv-j0HDr3w@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Stratos Mailing List <stratos-dev@op-lists.linaro.org>
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

On 05-08-21, 14:03, Arnd Bergmann wrote:
> On Thu, Aug 5, 2021 at 1:26 PM Viresh Kumar via Stratos-dev
> > Based on discussion we had today (offline), I changed the design a bit
> > and used handle_level_irq() instead, as it provides consistent calls
> > to mask/unmask(), which simplified the whole thing a bit.
> 
> The new flow looks much nicer to me, without the workqueue, and
> doing the requeue directly in the unmask() operation.
> 
> I don't quite understand the purpose of the type_pending and
> mask_pending flags yet, can you explain what they actually
> do?

They are required to make sure we don't send unnecessary
VIRTIO_GPIO_MSG_IRQ_TYPE events to the device, every time bus_unlock()
is called.

mask_pending tracks if the masked state has changed since the time
last bus_unlock() was called. So on an interrupt, both mask() and
unmask() will get called by the irq-core now and mask_pending will
change to true (in mask()} and then false (in unmask()). And
eventually in bus_unlock() we won't send an extra
VIRTIO_GPIO_MSG_IRQ_TYPE message.

> Also, I have no idea about whether using the handle_level_irq()
> function is actually correct here. I suppose if necessary, the driver
> could provide its own irq.handler callback in place of that.

After looking at internals of these, I felt handle_level_irq() suits
much better in our case as we need to queue the buffer only at
unmask(). With handle_fasteoi_irq(), we would be required to do the
same from multiple places, unmask(), eoi().

> > Also I have broken the rule from specs, maybe we should update spec
> > with that, where the specs said that the buffer must not be queued
> > before enabling the interrupt. I just queue the buffer unconditionally
> > now from unmask().
> >
> > I am not sure but there may be some race around the "queued" flag and
> > I wonder if we can land in a scenario where the buffer is left
> > un-queued somehow, while an interrupt is enabled.
> 
> Can that be integrated with the "masked" state now? It looks like
> the two flags are always opposites now.

Yeah, but then there can be races and keeping them separate is a
better thing IMO.

I was thinking of something on these lines, disable_irq() followed by
enable_irq():

CPU0                                                 CPU1

disable_irq()
 -> irq_bus_lock()
 -> irq_mask()
 -> irq_bus_sync_unlock()
   -> sends blocking VIRTIO_GPIO_MSG_IRQ_TYPE
      to disable interrupt
                                                     Backend (at host) disables irq and 
                                                     returns the unused buffer.

enable_irq()
 -> irq_bus_lock()
 -> irq_unmask()
   -> Tries to queues buffer again
      Finds it already queued and returns.
                                                     - virtio_gpio_event_vq() runs at guest
                                                     - Finds VIRTIO_GPIO_IRQ_STATUS_INVALID in status
                                                     - returns without doing anything
 -> irq_bus_sync_unlock()
   -> sends blocking VIRTIO_GPIO_MSG_IRQ_TYPE
      to enable interrupt



So the irq is still enabled and the buffer isn't queued. Yes, need
some locking here for sure, confirmed :)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
