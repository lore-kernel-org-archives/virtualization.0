Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF89EC433FE
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 07:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52C3A60A91;
	Tue, 29 Nov 2022 07:29:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52C3A60A91
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=JztLYOgM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3fYpFNZYYY6r; Tue, 29 Nov 2022 07:29:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 84CDA60E33;
	Tue, 29 Nov 2022 07:29:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84CDA60E33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A962C0033;
	Tue, 29 Nov 2022 07:29:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65F75C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 07:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46DC860A91
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 07:29:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46DC860A91
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oxJwwR5UinEu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 07:29:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8950960A7A
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8950960A7A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 07:29:04 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id io19so12573852plb.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 23:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=93Z9yqmIQNRTUwtqeMmOmi2ENuglQBExrzkwGjKRh0s=;
 b=JztLYOgMk9XwE4BcyUMnXW3VGF+CF2dWB3NuyfPTjwAwf9xhLsYyPAIS/tsWH3E8mf
 JiCobSPoos2HFQXa1KTQIKU5xl/Jhvx0orRtY+P8kS36GlB0XoYg0ejyLYPx/dwE7kjr
 KvvaPYs7Ifvere6OlWy0hYaDeXwaLiZkbTJt7t3Y4KK/SIjP06ejDk7Yyhh17Nl+GqHq
 EeTw0O/C4kJsTnIrZytSsztz3MZYKVjBB58Aa64vH+/jBg84Q42ViVUoIvhPQirz0e6e
 VzQZozznQ9yk0O6+FaWZ+BuY/1QAKfxKujf94Vpj15J+vejj0a9Qp+Aw8xlPcDX8kKk3
 7ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93Z9yqmIQNRTUwtqeMmOmi2ENuglQBExrzkwGjKRh0s=;
 b=FOSOVuNP/EfyWyQOawBvKnnDOHZ2ygEFgSv4MHKPBipSVohWkP8+ReyO7tKpXv1O54
 DmOabM1d/ETZY1ArNTHgsv9Hllobr82pPeUGzC668b7RF6sCta++HiZqOkmBgdT5oduR
 ZGf97WCa919IXeQRl2sNDkym6FYf6LgaJpVhYcTGAzUs9a7YlHU03o5acA1MIw1MsK8w
 1nAasfj1qn8RIZx+TE26CgIOqUe6jO1TL/Ayt+VNAu1G47nAsO/OYTk1rINCPpoHpNf+
 631/50suI4O+/xFCrEf4nv0/w5YrldB8INu4aqCIuuag5+inX1f3BihYaOX0cZ0Nac6z
 wiew==
X-Gm-Message-State: ANoB5pkbyKK/9IILI8dYd1XunW6af/fqm7moUm8QZ3dAsVkdy6THLsVl
 3Bgg/EbAEZ8xe7gXDAsBlzk=
X-Google-Smtp-Source: AA0mqf5QFGoEjzGDY0KKJbrGdY5Kq4Yrc/VgK8IVEDvN/Ni8dTAOz6DfGlMoCwOAgVHpVVN94YPDgg==
X-Received: by 2002:a17:90a:e648:b0:219:2567:dc1e with SMTP id
 ep8-20020a17090ae64800b002192567dc1emr13836696pjb.237.1669706943759; 
 Mon, 28 Nov 2022 23:29:03 -0800 (PST)
Received: from DESKTOP-UNJJAT8.localdomain
 (n114-76-138-0.mas1.nsw.optusnet.com.au. [114.76.138.0])
 by smtp.gmail.com with ESMTPSA id
 x129-20020a628687000000b0056baebf23e7sm9521364pfd.141.2022.11.28.23.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 23:29:03 -0800 (PST)
Date: Tue, 29 Nov 2022 18:28:59 +1100
From: Andy Bui <andy.bui2001@gmail.com>
To: Amit Shah <amit@infradead.org>
Subject: Re: [PATCH] virtio: console: remove check for cpkt value when
 nominating console port
Message-ID: <Y4W0uz1/b6YfxJ/b@DESKTOP-UNJJAT8.localdomain>
References: <20221112124522.3981-1-andy.bui2001@gmail.com>
 <f638782743aa6d848af36cba36e9e039e2087d2b.camel@infradead.org>
 <Y3MD2vRn+8r+wp61@DESKTOP-UNJJAT8.localdomain>
 <639e5da00eff26d9fe4be8bed8bc3c91ee3b72a3.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <639e5da00eff26d9fe4be8bed8bc3c91ee3b72a3.camel@infradead.org>
Cc: virtualization@lists.linux-foundation.org, amit@kernel.org
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

On Wed, Nov 23, 2022 at 11:46:54AM +0100, Amit Shah wrote:
> I think the backward compat concern I have here is that a really old
> hypervisor - one that doesn't do virtio-serial-ports yet, will not have
> any other messages sent from the host, but the original console setup
> messages.
> 
> The is_serial_port() check looks for whether hvc is initialized.  It's
> possible hvc may not have been initialized when some control message
> comes in.

I'm assuming you're talking about the is_console_port() check here (apologies
I'm not too familiar with the old virtio-serial), in which case I have no problem
with.

> > If this is correct I think a warning should be emitted here? Not setting the
> > value to 1 can exhibit undefined behaviour (at least when interpreting the
> > virtIO spec) and it would help hypervisor developers.
> 
> Did you actually run into some issue here?

Yes, while developing a hypervisor solution I found that console port setup
was unsuccessful when the control messages were involved. I found out later on
after reading the qemu and linux source that a value of 1 was needed for all
VIRTIO_CONSOLE_CONSOLE_PORT events, which wasn't exactly specified in the
spec.

Andy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
