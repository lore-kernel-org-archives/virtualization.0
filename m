Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70E7C4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 03:49:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCA4603E7
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 03:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FCA4603E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 319C74053F;
	Wed,  4 Aug 2021 03:49:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EnMihGPJZWki; Wed,  4 Aug 2021 03:49:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 53873401F7;
	Wed,  4 Aug 2021 03:49:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F090C001A;
	Wed,  4 Aug 2021 03:49:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BF34C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 03:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0908A400CE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 03:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1F58Jdmrdp2E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 03:49:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D83CC40001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 03:49:29 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id mt6so1131297pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 20:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hy1NnP0wO2zT/VrMPRCtNkUc0gMbU7esFhgTPbbumaI=;
 b=pV3LQkTEVPVFO26bH4qKathJhoDVM53Wle33GPuHirv2DuW2qDklwIScy2sYGP/qdo
 G4Fmk/hM5GcDgdrbTSDp9aukIqKPSx6ouUAghX8NOe+h5E2A7j9bPvjpV/XTqKVKj9uo
 F2fF/0YVnI2g2AAxnKAFhoz1HwI540CBzUl8YtRiX1g9l40QcPUnmzgIy+61h0NHsif7
 phCMi0sqqj3sWKI9HBhiXrkLZXiHvVq5Zp/pu4c583bc9oFKSxPmWJ3qmkxAdQ0K2Pre
 vagCPQZjsoHJUYzHOnegWEXQxrCooPRXeM0B8S1DSWq+ldZqIL/hwUbfTZBeTOeSuCZi
 MPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hy1NnP0wO2zT/VrMPRCtNkUc0gMbU7esFhgTPbbumaI=;
 b=FicbuOuSf2gMqo3sL/0VZ7qG37IfR8GP7uUbvQMCwTcinkDYOdPD75MKUG3MYMmM8J
 AVPdO74Kf4igANqYWrVEBDDo/jNhUd9DCW+EoUXsjSqAaijlIypC1xa1TuP+8GpDwgbs
 nsDVDvodurZtY145b32VgWwWQPGqfB9XwXBvD4eSI4apu0AUPmXdeoSSo5YvoQ3XegbK
 xIxcsbQB3TLADxUeEmXwU9VZw+0FXDbyLDLM8ylGNt6RGBeemzQ+HAa/9ggVjGomlxvf
 JJfMlyggZhqs1tb7x4F2WlCcrlPFzziD+ZAtN6fZTeSh8992AJL0hcvrQQQuQFNrcidc
 AvWA==
X-Gm-Message-State: AOAM531bcGe4JkdaY+kRwDByA6pYlGeXXbtEBPXVPanVOxwvxU5MQL/I
 acVle83Y2yPYJSmSTVxzh5We1Q==
X-Google-Smtp-Source: ABdhPJzu/UIWjSp9w8Y+KDSNX/I9Gp6Tb85pVQV1NeAG9BQWHvOy0AKG892wKsDIlxZIxK3pOYSmvQ==
X-Received: by 2002:a17:902:8ec7:b029:12c:6a1a:3e8d with SMTP id
 x7-20020a1709028ec7b029012c6a1a3e8dmr20768190plo.83.1628048969221; 
 Tue, 03 Aug 2021 20:49:29 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id b17sm739174pgl.61.2021.08.03.20.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Aug 2021 20:49:28 -0700 (PDT)
Date: Wed, 4 Aug 2021 09:19:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 3/5] dt-bindings: gpio: Add bindings for gpio-virtio
Message-ID: <20210804034926.qtagdoopeaeaskaw@vireshk-i7>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <acf7402ef4aabc0ad6295c32846f2bef1cd9b56a.1627362340.git.viresh.kumar@linaro.org>
 <YQhKKyPmOUE8z+US@robh.at.kernel.org>
 <20210803043014.paskwghdio6azplp@vireshk-i7>
 <CAL_JsqJ6_ktTQKiy_xx9DhjQ3=imfvSZpBem5fXwVY7O49EgCw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ6_ktTQKiy_xx9DhjQ3=imfvSZpBem5fXwVY7O49EgCw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bill Mills <bill.mills@linaro.org>
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

On 03-08-21, 09:47, Rob Herring wrote:
> n Mon, Aug 2, 2021 at 10:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 02-08-21, 13:40, Rob Herring wrote:
> > > Humm, how does one implement interrupts without a parent interrupt? It
> > > uses the parent virtio,mmio interrupt?
> >
> > Kind of, yeah, but not necessarily.
> >
> > The interrupt information is passed over buffers shared between host and guest.
> > Now the guest may process the buffers when it receives a notification from the
> > host, that will be at downpath of an interrupt for virtio,mmio. Or the guest may
> > poll on the virtqueue and process any buffers as soon as they are made
> > available, no interrupts then.
> 
> Okay, thanks for the explanation.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for reviewing this Rob.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
