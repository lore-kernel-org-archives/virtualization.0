Return-Path: <SRS0=GbdO=L3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB4C07E97
	for <virtualization@archiver.kernel.org>; Sat,  3 Jul 2021 08:05:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A7761421
	for <virtualization@archiver.kernel.org>; Sat,  3 Jul 2021 08:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A7761421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 999326062F;
	Sat,  3 Jul 2021 08:05:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VvnW4B6v70go; Sat,  3 Jul 2021 08:05:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C1D3605C1;
	Sat,  3 Jul 2021 08:05:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1803DC001A;
	Sat,  3 Jul 2021 08:05:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9B99C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A9836062F
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wl4xdzQgg0An
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:05:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57072605C1
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625299533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kKIOnpxOcNmgTRp3B6WHqjm7D0aNgAomWGm0e5Ck0pA=;
 b=X3HPLJUvRIj2mbk0OSsDwGlh5ue3ZFGSP/j0PPYSL3Nybt281/pqCXrfX1FzL9TK037Sw+
 Z9YtnSZ3/DWnk3GwP5rUXEAlxrDuquCUQUHwx/wjrjOqeBeqVPGjX7ul4Z2U8wh6OCSmCO
 6e6Al0LNxd1y5Ki8eLhckeD42rVweOA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-hY4rF_M2OPORkR_wxp1bxw-1; Sat, 03 Jul 2021 04:05:22 -0400
X-MC-Unique: hY4rF_M2OPORkR_wxp1bxw-1
Received: by mail-wm1-f72.google.com with SMTP id
 f11-20020a05600c154bb02901e0210617aaso3469785wmg.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 03 Jul 2021 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kKIOnpxOcNmgTRp3B6WHqjm7D0aNgAomWGm0e5Ck0pA=;
 b=geeMSD+Miz8awTVawvL+llKkdi4aHFzObb/zaKWDgv6p4PeK9xMUeVVIVQTiVLQFJ+
 WrneAcCS47e2LzNsI/dpF/yJAzZTrCNj9IMq8eMU2UG9IEvKwe1NUOYLtosIVMS2Ivt4
 EgEoGCD+VQfNUhHleD2OrFkcDATDZf/f24Cg6/MC8KY7AzsslLBW67YY1tIT9st2m6gD
 PlTV0TTLpHWktaDrexL6rg/+fpqMpBf+HnRIWS/2MFixhH7QKLNaPoDQkS246LP/Hk2Q
 IPwO3eUxzYycRNcBUQmErzmIBWGCKDK+FKisPXtr7Ow7ySZI3CovTDabYK4yxWi52Nom
 B+BA==
X-Gm-Message-State: AOAM532FMTeqqFtpNNGaFDbDrqs51kVCE2EPYAxrj/q61YBfrHk63MYo
 xMLEEWQc68NJiTOJTn9C4FNbyR1V/knQYwTKqPIp/hlkAfwDyIHczXyuASlnS1AIhIUpseLRJeo
 SOqTr8Z3AlBdoylRMuE4yNKfHyErO33H+DL3ZtE1RMg==
X-Received: by 2002:adf:a74a:: with SMTP id e10mr3938752wrd.185.1625299520741; 
 Sat, 03 Jul 2021 01:05:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKSHjkKeNS1veZXd/UH5HPoz05bwQZrIGUjhF4ktH5u6/iyfCkd4WgsIejTPdf0V3pNrgQdQ==
X-Received: by 2002:adf:a74a:: with SMTP id e10mr3938741wrd.185.1625299520609; 
 Sat, 03 Jul 2021 01:05:20 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id c8sm5566926wri.91.2021.07.03.01.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jul 2021 01:05:19 -0700 (PDT)
Date: Sat, 3 Jul 2021 04:05:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20210703040504-mutt-send-email-mst@kernel.org>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <CAOh2x=kcM351ObubnQSzUa=FVBQUmAUhz4u8ExORUthQQ0WbGQ@mail.gmail.com>
 <253f218d-07ac-1963-75e1-9ac2d035437a@metux.net>
 <20210526033206.5v362hdywb55msve@vireshk-i7>
MIME-Version: 1.0
In-Reply-To: <20210526033206.5v362hdywb55msve@vireshk-i7>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
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

On Wed, May 26, 2021 at 09:02:06AM +0530, Viresh Kumar wrote:
> On 25-05-21, 14:59, Enrico Weigelt, metux IT consult wrote:
> > On 24.05.21 13:27, Viresh Kumar wrote:
> > 
> > Hi,
> > 
> > 
> > > We (Linaro's Project Stratos
> > > https://linaro.atlassian.net/wiki/spaces/STR/overview)
> > >   are interested in this stuff. I was trying to look at the last status
> > > of all this. Few
> > > questions for you:
> > > 
> > > - Was the spec ever posted to virtio-dev list ? I thought that's the
> > > very first step before
> > > we merge the code.
> > 
> > I had posted some spec quite some time ago, but it wasn't in the form
> > of patches against the .tex documentation files yet. It's been laying
> > aside for quite a while, since I've been busy w/ other things.
> 
> Will you be fine if I take that up and restart the thread ?

It's been a while - why not right?

> -- 
> viresh

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
