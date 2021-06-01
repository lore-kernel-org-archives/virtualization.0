Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_HEADERS,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72931C47082
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 02:54:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8716135C
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 02:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8716135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CDCCC40394;
	Tue,  1 Jun 2021 02:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cbc4AnuLX00K; Tue,  1 Jun 2021 02:54:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 702F0400A9;
	Tue,  1 Jun 2021 02:54:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5122EC000E;
	Tue,  1 Jun 2021 02:54:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E7F8C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1852F60603
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uX98rU4KI2Sb
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:54:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47FCC605CF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:54:06 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id t3so15463565edc.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 19:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
 bh=knN8PuwxMBMRUW0OyIkUMzniIsTf65LkkSfLXCcSzrY=;
 b=SvSffryegS+ysrvJelHxE0GDMIqYsiauOEAlrh+QIGJ4/aDIqhLCDQp2geMHP0p4EI
 o4sGgoCoODwCdY8h/iz7IjvTCxCzB07KIFYilnJ0a2ObrIdreIO9MOhx0UqE1X2eGufH
 /r7H7u+lQ2oOsS7H1+vMdNDI2SzPH6XNLpEIxDThc/aaGQSl61QvOXHwZ1dz4Q6RA7ee
 dqNy10UwQqXOMlDaCRQ13VjmQu/cFkSAcxY7UWJ43rVbLw/DyyxRYIch12GlLQr6yLHn
 wBDhSj5MCRhSyWb2Cpg1ZmjCvQoC5IFHyff1F4lSqgNZZASoNgUJ94Qku7CmF9xnUrWC
 p2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:cc;
 bh=knN8PuwxMBMRUW0OyIkUMzniIsTf65LkkSfLXCcSzrY=;
 b=CVc2IVJfLvmgRPMKSoikHD6Bl1dbFjpZUWRnDcHtiZgJLZHOhJAzJyiNrTuYkyodL8
 W+me4slYbGpAyVAXW+oayLuMFhbRDamDxBXQTNkg/sqttM7k95D2vuUIZ/mC+grszLmM
 fzjl5hs56OD4cyjq677q/fEyISRTN5p/vTo3wtYgHUQ0AgpCf72Y3/j6Y8hOS+gDfkBC
 gMgJMxotEW5P3X/XPXfQ/HqPG2C2gS8tfr4oOdLdiz+B6BACzIFz77FrUrrvhVwFPwlW
 n5l0JqwThIea1lS0Zok0X+px0RQZDl4xXfOxtNDF4hNwx3a85UAMpjjPgXECD5ZFZ+1x
 /f1Q==
X-Gm-Message-State: AOAM532gdCpq1TdW/8R+vZPc6cPhNk8bcPe7D9tPJKFBh2xlp48PSb+0
 KNpe1U8wIqf9q1CqaiBDjTPW2LYwP9o=
X-Google-Smtp-Source: ABdhPJxXeeJbc52o5bXsFdwIaxyWEFYlJhOG7gYsr/ggKymo0kJSAaBRpSFkfw8MwY9LmHZ97qYV8g==
X-Received: by 2002:a05:6402:487:: with SMTP id
 k7mr28409129edv.315.1622516044053; 
 Mon, 31 May 2021 19:54:04 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51])
 by smtp.gmail.com with ESMTPSA id h9sm7678284ede.93.2021.05.31.19.54.02
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 19:54:03 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id n4so12612173wrw.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 19:54:02 -0700 (PDT)
X-Received: by 2002:adf:fa04:: with SMTP id m4mt4367696wrr.275.1622516042429; 
 Mon, 31 May 2021 19:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210526082423.47837-1-mst@redhat.com>
 <CA+FuTScp-OhBnVzkXcsCBWxmq51VO6+8UGpSU5i3AJQV84eTLg@mail.gmail.com>
In-Reply-To: <CA+FuTScp-OhBnVzkXcsCBWxmq51VO6+8UGpSU5i3AJQV84eTLg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 31 May 2021 22:53:26 -0400
X-Gmail-Original-Message-ID: <CA+FuTSf09nOJ=St4-3318oXy2ey0qRKkti8FvwheEUdiHSK0HA@mail.gmail.com>
Message-ID: <CA+FuTSf09nOJ=St4-3318oXy2ey0qRKkti8FvwheEUdiHSK0HA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] virtio net: spurious interrupt related fixes
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
 David Miller <davem@davemloft.net>
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

On Wed, May 26, 2021 at 11:34 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Wed, May 26, 2021 at 4:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >
> > With the implementation of napi-tx in virtio driver, we clean tx
> > descriptors from rx napi handler, for the purpose of reducing tx
> > complete interrupts. But this introduces a race where tx complete
> > interrupt has been raised, but the handler finds there is no work to do
> > because we have done the work in the previous rx interrupt handler.
> > A similar issue exists with polling from start_xmit, it is however
> > less common because of the delayed cb optimization of the split ring -
> > but will likely affect the packed ring once that is more common.
> >
> > In particular, this was reported to lead to the following warning msg:
> > [ 3588.010778] irq 38: nobody cared (try booting with the
> > "irqpoll" option)
> > [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> > 5.3.0-19-generic #20~18.04.2-Ubuntu
> > [ 3588.017940] Call Trace:
> > [ 3588.017942]  <IRQ>
> > [ 3588.017951]  dump_stack+0x63/0x85
> > [ 3588.017953]  __report_bad_irq+0x35/0xc0
> > [ 3588.017955]  note_interrupt+0x24b/0x2a0
> > [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> > [ 3588.017957]  handle_irq_event+0x3b/0x60
> > [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> > [ 3588.017961]  handle_irq+0x20/0x30
> > [ 3588.017964]  do_IRQ+0x50/0xe0
> > [ 3588.017966]  common_interrupt+0xf/0xf
> > [ 3588.017966]  </IRQ>
> > [ 3588.017989] handlers:
> > [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> > [ 3588.025099] Disabling IRQ #38
> >
> > This patchset attempts to fix this by cleaning up a bunch of races
> > related to the handling of sq callbacks (aka tx interrupts).
> > Somewhat tested but I couldn't reproduce the original issues
> > reported, sending out for help with testing.
> >
> > Wei, does this address the spurious interrupt issue you are
> > observing? Could you confirm please?
>
> Thanks for working on this, Michael. Wei is on leave. I'll try to reproduce.

The original report was generated with five GCE virtual machines
sharing a sole-tenant node, together sending up to 160 netperf
tcp_stream connections to 16 other instances. Running Ubuntu 20.04-LTS
with kernel 5.4.0-1034-gcp.

But the issue can also be reproduced with just two n2-standard-16
instances, running neper tcp_stream with high parallelism (-T 16 -F
240).

It's a bit faster to trigger by reducing the interrupt count threshold
from 99.9K/100K to 9.9K/10K. And I added additional logging to report
the unhandled rate even if lower.

Unhandled interrupt rate scales with the number of queue pairs
(`ethtool -L $DEV combined $NUM`). It is essentially absent at 8
queues, at around 90% at 14 queues. By default these GCE instances
have one rx and tx interrupt per core, so 16 each. With the rx and tx
interrupts for a given virtio-queue pinned to the same core.

Unfortunately, commit 3/4 did not have a significant impact on these
numbers. Have to think a bit more about possible mitigations. At least
I'll be able to test the more easily now.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
