Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A3CC4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 09:39:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404AE23A52
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 09:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404AE23A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D73A386C14;
	Tue,  8 Dec 2020 09:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EW2OMJ7J4sOx; Tue,  8 Dec 2020 09:38:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3029886978;
	Tue,  8 Dec 2020 09:38:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2378BC0FA7;
	Tue,  8 Dec 2020 09:38:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66F25C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 60EDB20401
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g0nvisJsZ29M
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:38:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by silver.osuosl.org (Postfix) with ESMTPS id A39E2203B9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:38:56 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id q8so18297685ljc.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Df6CqLv6JOagx1Y8po8wBRxgE1D965nfEA75Zeqy5oU=;
 b=hiBfGGso9wRtqNNhBBDBX1PZJI4bsFd8GYtW1arlG6wQ4COUeIZUEbdlyvCERMJMNo
 G3mKLQX6l8yLU9kEnfD7DSvjlpMv/k/voYdOTNP7XWZPPJ/qSQk8mxqGTTh8jNzexWF+
 IM8Az+l2VS7WmMT17YcIg6P/3wHd3R+VH1SSg9INsPTtt3qSUiUthy5zd7hakcqWkB+O
 qSfwe3vWou5ZGLP9SOQvoHKDMgFZGQ1O3JUjz3sj++5TS4p8K381xHRqUXYIzwKWdgKO
 FQZL/lFJPkZkG5N/3mq019RC7s6wgK9FMFx6XuoeVpbfGEDxYEjwM070MoklamNKuEIX
 cY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Df6CqLv6JOagx1Y8po8wBRxgE1D965nfEA75Zeqy5oU=;
 b=RXe/c3enpJ6M99zBWvQTXzz/D3wMRPs+UPvjt1bjWdSNayaytMm4yVism2pX7syhfy
 snfusouzl2dwtA+UbvcQSO/RhFvKfJWx4iYbgJIFPWQ+Shp6bfhwQVL8xhugk1XDABxC
 3Mp8kFT/BwTaDPqoh0tKl4hqz0bxlBzeNWUau+KNwaGnimr2D/TmkDaB/aWIdt27Y+g2
 8BFK8zbaJ1nRhg/N7EiHRHMZn0BL02Ax8QsWUVIm6NMm0vV3WC4XxtPBg06x4GEonXY7
 01RXqiNILsOwKLdAwOwD6O06Q08Y1A7kGwpHKkTtNms4i/3MQ4Ki6n+zO4MaHh7VYpmc
 Kgew==
X-Gm-Message-State: AOAM532Jq9lfzmvSrggffavYQrchs6KjbPzct/0rNlPPbaQeoILchEIW
 KZkl+2bDgsBts2NX58ESFs1l8tmFoDBBLDU5husuSA==
X-Google-Smtp-Source: ABdhPJxQWX+drL6yggghfNbiTL59lvfCIOzavoQ1GoTxnH37PaUwIwrN8fyjAkWeHJ5nGm3eQq7eo4VvW5wksxdLa68=
X-Received: by 2002:a2e:910f:: with SMTP id m15mr10801861ljg.467.1607420334616; 
 Tue, 08 Dec 2020 01:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <0080d492-2f07-d1c6-d18c-73d4204a5d40@metux.net>
In-Reply-To: <0080d492-2f07-d1c6-d18c-73d4204a5d40@metux.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 8 Dec 2020 10:38:43 +0100
Message-ID: <CACRpkdb4R4yHcUV2KbGEC_RkU+QmH6Xg7X+qee8sEa9TURGr8A@mail.gmail.com>
Subject: Re: Howto listen to/handle gpio state changes ? Re: [PATCH v2 2/2]
 drivers: gpio: add virtio-gpio guest driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-riscv@lists.infradead.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

On Sat, Dec 5, 2020 at 9:15 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:

> The virtio-gpio device/host can raise a signal on line state change.
> Kinda IRQ, but not actually running through real IRQs, instead by a
> message running though queue. (hmm, kida MSI ? :o).
>
> I've tried allocating an IRQ range and calling generic_handle_irq(),
> but then I'm getting unhanled IRQ trap.

This is Bartosz territory, but the gpio-mockup.c driver will insert
IRQs into the system, he went and added really core stuff
into kernel/irq to make this happen. Notice that in Kconfig
it does:

select IRQ_SIM

Then this is used:
include/linux/irq_sim.h

This is intended for simulating IRQs and both GPIO and IIO use it.
I think this inserts IRQs from debugfs and I have no idea how
flexible that is.

If it is suitable for what you want to do I don't know but it's
virtio so...

Yours,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
