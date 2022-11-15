Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61893C4332F
	for <virtualization@archiver.kernel.org>; Tue, 15 Nov 2022 03:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAE9680EE1;
	Tue, 15 Nov 2022 03:13:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAE9680EE1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=EosIrBBr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zEUniuO9hpUw; Tue, 15 Nov 2022 03:13:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7AA8E80CDE;
	Tue, 15 Nov 2022 03:13:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AA8E80CDE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50E33C0032;
	Tue, 15 Nov 2022 03:13:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F7A2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43C46403F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:13:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 43C46403F9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=EosIrBBr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjI4ykc_40PN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:13:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2AA4403A4
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2AA4403A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:13:39 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id o13so12058170pgu.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 19:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YPuI/aH6sciwWSEWtBmfgQ+4bTho7m8erD4/F4QbPFY=;
 b=EosIrBBrk9a3opZeZQURubA/T0SJnw0IDXs0CdETyiS3HMZmmyKK5tm0W5/gpczvQK
 skpk/X6xV5ZVUOdBfanpn9aAPuRIIbwMaTZwf7OAJf03vPb6kNkfr6IuL/I85+uLU2PV
 x3nm5phJjp0p19ZkwYMHiZShX3H/VWpLN3679UVLRT3IXJs7yZF9qGFp8g3OINjHNdXv
 W+YEhl+iboMs6YYIaHAYvm2PgZ4WsDzAe5ZB4Qr3YBUBcngtM/gXm1mFSCvc7l5lw9nn
 rEQkzcnevu3RsH53GsbPRF5KXz5AWlLOrCePpcDITGUa/4CQkLjOELimL2oUoh04X3/X
 9zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPuI/aH6sciwWSEWtBmfgQ+4bTho7m8erD4/F4QbPFY=;
 b=ICglck5zKVWAdS8EF66/So5W8T+vSBlL8OPnSrIEZJeWqOzCvAuMzPu3t6LWTe2utx
 U3GaGcNaRfFgojrpUJfZQxYKgWdy5blbh+ExuBBTPlNDLmkjpu5FpcxJZvtnQfsfrCaJ
 lQgoIpK2aLZ32S3hNTB8RQwdgnfBgiiYkq5texvK91CeOZUJQ4TBPAyAeDPZFV6qGDwm
 V6Z834K1kCHjd0FpdFHvBX2T5OrvW8WlPMY/O+SGTsjL1WRw33eNszC3Hu35+pl1+zxy
 lj/CTdTuRR9Ak5dvZQTV+H9xz4wnutRJ6SRUs6EmgdTh9Zt0CG5hDUTTvn2K96Uztvuw
 2vMA==
X-Gm-Message-State: ANoB5pl5oLtBm7qFOXAPm2He4O0Qw9PQGB6m3+RNZaqwB0c1LXAAycA1
 ussIdSYGyB33YKCePoMnNqc=
X-Google-Smtp-Source: AA0mqf61Co1vx+Gq63m0Lzu+T04S7X/HQCTEVNoXRC8RpJlc5uT72x9ZWsIwZkqsV9o6Rd9au/iMvQ==
X-Received: by 2002:a63:881:0:b0:43c:756:eb71 with SMTP id
 123-20020a630881000000b0043c0756eb71mr13891184pgi.480.1668482018915; 
 Mon, 14 Nov 2022 19:13:38 -0800 (PST)
Received: from DESKTOP-UNJJAT8.localdomain
 (n114-76-138-0.mas1.nsw.optusnet.com.au. [114.76.138.0])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a170902684700b0017808db132bsm2685129pln.137.2022.11.14.19.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Nov 2022 19:13:38 -0800 (PST)
Date: Tue, 15 Nov 2022 14:13:30 +1100
From: Andy Bui <andy.bui2001@gmail.com>
To: Amit Shah <amit@infradead.org>
Subject: Re: [PATCH] virtio: console: remove check for cpkt value when
 nominating console port
Message-ID: <Y3MD2vRn+8r+wp61@DESKTOP-UNJJAT8.localdomain>
References: <20221112124522.3981-1-andy.bui2001@gmail.com>
 <f638782743aa6d848af36cba36e9e039e2087d2b.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f638782743aa6d848af36cba36e9e039e2087d2b.camel@infradead.org>
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

On Mon, Nov 14, 2022 at 09:43:48AM -0800, Amit Shah wrote:
> 
> On Sat, 2022-11-12 at 23:45 +1100, Andy Bui wrote:
> > The virtIO spec does not specify a need for a value when nominating a
> > port as a console port, yet the virtio_console driver requires the value
> > to be 1.
> > 
> > Besides being a check that's not specified by the virtIO spec, I don't
> > see anywhere else in the kernel the value is used when the corresponding
> > event is VIRTIO_CONSOLE_CONSOLE_PORT. As an example QEMU also currently
> > only passes in value=1 when nominating a console port.
> 
> The original virtio-console driver just had the one port, and it was,
> as the name suggests, was a console port.  When we converted this
> console driver to a generic serial driver, the first port was kept as
> the console port to not break old drivers or hypervisors.  I'm afraid
> we'll have to keep this bit of backward compatibility forever.
> 

I think I might be misunderstanding the exact usage of the cpkt value.
Is error'ing and not continuing with the console port nomination the intended
behaviour when value != 1? I'm guessing that there are some hypervisors out
there that set value to something not 1 and we don't want those ports to be
the console ports?

If this is correct I think a warning should be emitted here? Not setting the
value to 1 can exhibit undefined behaviour (at least when interpreting the
virtIO spec) and it would help hypervisor developers.

Thanks and lmk your thoughts,
Andy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
