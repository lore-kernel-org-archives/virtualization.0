Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1539FC77B6C
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 08:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FD4D615E4;
	Thu, 13 Apr 2023 08:54:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FD4D615E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YVSlyeMiqB87; Thu, 13 Apr 2023 08:54:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1059C615D6;
	Thu, 13 Apr 2023 08:54:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1059C615D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7450C0037;
	Thu, 13 Apr 2023 08:54:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD2A3C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 08:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7CE783CDA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 08:54:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7CE783CDA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O__XWTsUOY5b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 08:54:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B83BC83CBA
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B83BC83CBA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 08:54:50 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-54bfa5e698eso422873757b3.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 01:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681376089; x=1683968089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/2r5n3qVynI/hX8mONBVdeZonUO/+YUa7xUJZQBOn8=;
 b=Lj/li3Zp3x0nUTdIXkBRd5u6e8skFNALARFcc1lY6T7idCm96vg++DGSOlg7T8O5Al
 GwGAV/vhw+C8/2rhuEXiYng4ykvxFQ9DA7Kcxt0yRAOKyhyq+2JwMOvpkQDi/evV2QpV
 PIkgyFJRXlooqrwYCFk5pxpgphCCRSlAml0Cq7ty6iwKsBBSaYJ3AgW9u/KLKSAdNapg
 Fp54UQf5qVJeLPcn+YLyRGGFOfUs0W9qI2yr4MoakRz0UNahmxee66DiwH1pGKd2N20b
 UhG91GswZuYOIRsOOPSQi1Nx8+b76BJjyudWLFaSOfTWEctIy/tMSEITlGwOrNImsHJ3
 B2kw==
X-Gm-Message-State: AAQBX9czU7lHJyxBPpDC7RlFD368amBVS0a2qF84rYYmV067i+D2pElO
 qm18M0Vp7J/rZ+o89424N70IJova3bmo1wWs
X-Google-Smtp-Source: AKy350Y+4f51HVlbbAWwWmR4AL06aLjqyCk5Wf+BUzqMrh3wrYdTiHsEURk6sNknZv/6dGj2NMtfuA==
X-Received: by 2002:a0d:d50d:0:b0:54c:288a:a2a1 with SMTP id
 x13-20020a0dd50d000000b0054c288aa2a1mr1073509ywd.27.1681376089325; 
 Thu, 13 Apr 2023 01:54:49 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com.
 [209.85.219.174]) by smtp.gmail.com with ESMTPSA id
 10-20020a81010a000000b0054662f7b42dsm315254ywb.63.2023.04.13.01.54.47
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 01:54:48 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id q5so17383027ybk.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 01:54:47 -0700 (PDT)
X-Received: by 2002:a25:d057:0:b0:b8f:5c64:cc2e with SMTP id
 h84-20020a25d057000000b00b8f5c64cc2emr459363ybg.12.1681376087527; Thu, 13 Apr
 2023 01:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
 <58f91e983ac95b7f252606ecac12f016@bootlin.com>
In-Reply-To: <58f91e983ac95b7f252606ecac12f016@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Apr 2023 10:54:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVqyY=tg6iU4feRwQhPt9c7ZZK9ifBCYf5AAgkxWjYOBA@mail.gmail.com>
Message-ID: <CAMuHMdVqyY=tg6iU4feRwQhPt9c7ZZK9ifBCYf5AAgkxWjYOBA@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Add interrupt support
To: kamel.bouhara@bootlin.com
Cc: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 metux IT consult <lkml@metux.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 stratos-dev@op-lists.linaro.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgS2FtZWwsCgpPbiBUaHUsIEFwciAxMywgMjAyMyBhdCA5OjQ44oCvQU0gPGthbWVsLmJvdWhh
cmFAYm9vdGxpbi5jb20+IHdyb3RlOgo+IExlIDIwMjEtMTAtMDQgMTQ6NDQsIEdlZXJ0IFV5dHRl
cmhvZXZlbiBhIMOpY3JpdCA6Cj4gV2hhdCBpcyB0aGUgc3RhdHVzIGZvciB0aGlzIHBhdGNoLCBp
cyB0aGVyZSBhbnkgcmVtYWluaW5nCj4gY2hhbmdlcyB0byBiZSBtYWRlID8KCllvdSBtZWFuIGNv
bW1pdCBhMDAxMjhkZmM4ZmMwY2M4ICgiZ3BpbzogYWdncmVnYXRvcjogQWRkIGludGVycnVwdApz
dXBwb3J0IikgaW4gdjUuMTc/CgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAg
ICAgICAgIEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBM
aW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29u
dmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIu
IEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1t
ZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLS0gTGludXMgVG9ydmFsZHMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
