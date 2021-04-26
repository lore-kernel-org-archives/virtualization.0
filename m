Return-Path: <SRS0=15y9=JX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166CBC433ED
	for <virtualization@archiver.kernel.org>; Mon, 26 Apr 2021 15:08:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AD960FDC
	for <virtualization@archiver.kernel.org>; Mon, 26 Apr 2021 15:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AD960FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C366A4033B;
	Mon, 26 Apr 2021 15:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nKkfFAONxr-u; Mon, 26 Apr 2021 15:08:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id D405540205;
	Mon, 26 Apr 2021 15:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEE41C000E;
	Mon, 26 Apr 2021 15:08:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18D2EC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 15:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDE7F83720
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 15:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x0egxM8oM5KI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 15:08:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0BB88378A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 15:08:44 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 y124-20020a1c32820000b029010c93864955so5353931wmy.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OO83GWItv3al4uMKIJSIcf1TbyC1yzgEvIGCA7JJ1q8=;
 b=ThS84KEYDB6DccAoy4K/DgXkkgnYptEl833hofd0DJROOCqjceuYwR5O7Dk7+m+S7u
 Ge32dC6xtZoW/zNNI7UOs5wMQHN91VLUSN3VhqQDVCTlj4zLq30P67qX5eqe+8H/8BR9
 iXs0McUH9OXqb3qhKOxPn/WN7ZZkwe9m6cOE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OO83GWItv3al4uMKIJSIcf1TbyC1yzgEvIGCA7JJ1q8=;
 b=XoRiBDaB6pe6ElDTjuBbjw9jmY5JsuAhzmrkUaMBUAnxJuJ9AI6tD2wLSlDOkaPGZI
 zWELb7h9tE58S91tluQYOs7sJl7qpWoduxHGff0vWcdpCWy3VWoe/DFwxDa1RvlCnFKa
 4OCmL29JEiGVjex8EblEWJQDKbT8Fhz7d28JYR+i4UTPTFMpOKM7aEDl7UvTF1FaDLEP
 gkTh+sSeKIyQvXUJTuU6CDsubZHm0sT8UOjVl0H6n9l+sCy6mR3liN6I8dT/TCANjNGF
 TAcya2ThmTwivoq+wz9ENMgaNDHkM2YL4qsO90ZJoewo07i2T1LCfmRAgLzBJmd7tqZT
 Q2uw==
X-Gm-Message-State: AOAM533+ktdq3PRZyO1s03/JU+YJ/221GW0x7LMdNsUXbFAHI0w359ou
 WJCNBhVIA/d2DfR/7Ao4XzqTHQ==
X-Google-Smtp-Source: ABdhPJxCJ6gQCM3TE/b1oFhnJem+VjQGIDSaeTOcL+/Vi4vqJVUUPZGlmMgnbQGlLmdRAYG/drlWHg==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr21312797wmc.88.1619449722700; 
 Mon, 26 Apr 2021 08:08:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id g5sm354976wrq.30.2021.04.26.08.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Apr 2021 08:08:41 -0700 (PDT)
Date: Mon, 26 Apr 2021 17:08:03 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 0/9] drm: Support simple-framebuffer devices and
 firmware fbs
Message-ID: <YIbXUxLAjB5e5BV4@phenom.ffwll.local>
References: <20210416090048.11492-1-tzimmermann@suse.de>
 <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
 <YH6U92Q71ntU6Z1R@phenom.ffwll.local>
 <86308b36-57ec-a796-90c1-e4349e914823@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86308b36-57ec-a796-90c1-e4349e914823@suse.de>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Cc: bluescreen_avenger@verizon.net, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Emil Velikov <emil.l.velikov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
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

On Mon, Apr 26, 2021 at 02:18:05PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.04.21 um 10:46 schrieb Daniel Vetter:
> > On Mon, Apr 19, 2021 at 10:00:56AM +0200, Geert Uytterhoeven wrote:
> > > Hi Thomas,
> > > 
> > > On Fri, Apr 16, 2021 at 11:00 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > This patchset adds support for simple-framebuffer platform devices and
> > > > a handover mechanism for native drivers to take-over control of the
> > > > hardware.
> > > > 
> > > > The new driver, called simpledrm, binds to a simple-frambuffer platform
> > > > device. The kernel's boot code creates such devices for firmware-provided
> > > > framebuffers, such as EFI-GOP or VESA. Typically the BIOS, UEFI or boot
> > > > loader sets up the framebuffers. Description via device tree is also an
> > > > option.
> > > 
> > > I guess this can be used as a replacement for offb, too...
> > > 
> > > > Patches 4 to 8 add the simpledrm driver. It's build on simple DRM helpers
> > > > and SHMEM. It supports 16-bit, 24-bit and 32-bit RGB framebuffers. During
> > > 
> > > .... if support for 8-bit frame buffers would be added?
> 
> Offb doesn't seem to be tied to the simple-framebuffer support. So adding a
> new driver or extending the simple-framebuffer code would be required. Not a
> big deal, though. Patch 3 of this patchset adds the ability to create
> generic drivers within DRM.
> 
> > 
> > Is that 8-bit greyscale or 8-bit indexed with 256 entry palette? Former
> > shouldn't be a big thing, but the latter is only really supported by the
> > overall drm ecosystem in theory. Most userspace assumes that xrgb8888
> > works, and we keep that illusion up by emulating it in kernel for hw which
> > just doesn't support it. But reformatting xrgb8888 to c8 is tricky at
> > best. The uapis are all there for setting the palette, and C8 is a defined
> > format even with atomic kms interface, but really there's not much
> > userspace for it. In other words, it would work as well as current offb
> > would, but that's at least that.
> 
> I think we can just use a shadow palette in the drm driver: If the drm
> framebuffer is in C8, use the userspace's palette. If the drm framebuffer is
> in XRGB, use a palette that represents RGB332. The driver would do
> on-the-fly conversion; just like cirrus does.

Hm yeah rgb332 palette sounds like a reasonable idea. Could even have that
palette defined/generated in format conversion helpers, and then an
xrgb8888->rgb332 converter.

Lower palettes probably stop making sense as rgb, maybe there we just do
greyscale or something like that for the xrgb8888 emulation.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
