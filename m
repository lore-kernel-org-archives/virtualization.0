Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A502CC433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 09:28:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175EA613AE
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 09:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175EA613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A50496059F;
	Tue, 20 Apr 2021 09:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hfR5J6mHaLmX; Tue, 20 Apr 2021 09:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E72F60602;
	Tue, 20 Apr 2021 09:28:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B7A7C000E;
	Tue, 20 Apr 2021 09:28:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29419C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 107EB4020D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PfkAutEX213v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:28:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DEE240204
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:28:09 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id h19so443558vsa.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yMXR5NQJZ/zyREq4gm4h4LkxWtsvke6Z9ueVpoC66Zk=;
 b=eF2bGYurc7zu+6HOECFHZ+oC4Er3j4XuLyUd86PJ5h+2023CvNyDFxPE2qfANtMeI2
 ApztTnSxSBsNvXcd8YvLszBEm9tVDdz7Xkn4AUbMgwh6s07ceJDhrZW3cDtFGnwurJ4k
 RQ2deVmPJOCy4IW9lntfiUUrLWfo2hDPY4zmyOrX2S1KEx/oSWphpq9MazsrvKrEVk3W
 LNqOYZTkaVkTxUoIX/qT+FIHul8mtT43jYt3vlWSLC5ulwJ4kwR51sx0fTASIRWKY8qR
 ZzLahfbHG1/VVz+zPn6nGWjclKQhsiwyN2znu6cmPBDNIGfGha63WEmaHQdOlhpzBPJS
 d6ug==
X-Gm-Message-State: AOAM533aWO3kr2HHPRGJZajkmMqPylh+Jj/slxB9k2a6dlKJ5h2W1qDd
 775Pdc0HqmQbBBqA3ClSkhKxSpkivUToXYTPciA=
X-Google-Smtp-Source: ABdhPJxXCrtc8Ti44j0CBaEgS9Yup/jZMkfMjkpOEktA0jLylcqYZKFpMvHeIXPqlR4Qmizx3hBjdSAdP7Uy7plFlRQ=
X-Received: by 2002:a67:f503:: with SMTP id u3mr17536399vsn.3.1618910888327;
 Tue, 20 Apr 2021 02:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210416090048.11492-1-tzimmermann@suse.de>
 <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
 <YH6U92Q71ntU6Z1R@phenom.ffwll.local>
 <20210420092204.7azdb7nxgofegjht@sirius.home.kraxel.org>
In-Reply-To: <20210420092204.7azdb7nxgofegjht@sirius.home.kraxel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Apr 2021 11:27:57 +0200
Message-ID: <CAMuHMdX=0H3LHP5Yme9tpN4JnmpJcnF=SQN8bc=4XTd-X6AVTg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] drm: Support simple-framebuffer devices and
 firmware fbs
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Rob Herring <robh@kernel.org>, bluescreen_avenger@verizon.net,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 virtualization@lists.linux-foundation.org, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Greg KH <gregkh@linuxfoundation.org>,
 Sam Ravnborg <sam@ravnborg.org>
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

Hi Gerd,

On Tue, Apr 20, 2021 at 11:22 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > Patches 4 to 8 add the simpledrm driver. It's build on simple DRM helpers
> > > > and SHMEM. It supports 16-bit, 24-bit and 32-bit RGB framebuffers. During
> > >
> > > .... if support for 8-bit frame buffers would be added?
> >
> > Is that 8-bit greyscale or 8-bit indexed with 256 entry palette? Former
> > shouldn't be a big thing, but the latter is only really supported by the
> > overall drm ecosystem in theory. Most userspace assumes that xrgb8888
> > works, and we keep that illusion up by emulating it in kernel for hw which
> > just doesn't support it. But reformatting xrgb8888 to c8 is tricky at
> > best.
>
> Well.  cirrus converts xrgb8888 on the fly to rgb888 or rgb565
> (depending on display resolution).  We could pull off the same trick
> here and convert to rgb332 (assuming we can program the palette with the
> color cube needed for that).  Wouldn't look pretty, but would probably
> work better than expecting userspace know what color palettes are in
> 2021 ...

Yeah, I already had a similar idea for Amiga HAM ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
