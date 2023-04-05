Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6A9C7618D
	for <virtualization@archiver.kernel.org>; Wed,  5 Apr 2023 23:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFF7F61452;
	Wed,  5 Apr 2023 23:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFF7F61452
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IovCAhPl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O192z1QB0sx3; Wed,  5 Apr 2023 23:19:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B3DF6144D;
	Wed,  5 Apr 2023 23:19:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B3DF6144D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC0EC0037;
	Wed,  5 Apr 2023 23:19:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74B9CC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 23:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4202B4178D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 23:19:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4202B4178D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=IovCAhPl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWMKPZJn4C5Z
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 23:19:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D58D141759
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D58D141759
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 23:19:48 +0000 (UTC)
Received: by mail-yb1-xb2b.google.com with SMTP id p203so44442329ybb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Apr 2023 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680736788; x=1683328788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xdWmttMtaebi+vSShIGyAU+sz8Wf4roGdslxn9RsIo=;
 b=IovCAhPl9rKqxorMiR+XEI979xtu8kG0W1HyWDDwbFfOhMAiE7t65qfk/k+dT0nEYu
 S35ACQpsr855z2Rhr/0jzicj8mYv836lTwxkONfmKZyTfCpwt4a9JpZ9nEBGbCKGUQnC
 KCWiqd7Q5fbj99py26dFqN1pvscI+3IpzCCzjSkzvEc0scmkP3CWmIxc7RRco+Z0sxcx
 mENO6Bhh1Ikdfng3a6BNcp3bVfMT+eOLH2uCbKa/4H3RC204S/06EresKMnDCIE1BQoJ
 3P7iZo/7bINDVcq2Ys7FDOFYjcpEem6zcQpOUzmw6r7r9VvXKz0EPpTrJnOhGiiS8457
 acnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680736788; x=1683328788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xdWmttMtaebi+vSShIGyAU+sz8Wf4roGdslxn9RsIo=;
 b=qLM2ikHQpqMrSGuQlvSa0/LplHSJLiQR1A5R8kKFmyPRlVq6g182rat5VguH3wDnqq
 31u97Y6UcCAUr3ZXXPYPF60uBk02smCnXYIZLk4tG7NszV9nC821+znljmHLhVodEQI7
 6nLDRtGMO9A+zNXyQI44uw7tQJ09/F3m347Ovwi5RVSRzGDd647k9L8KIvtSqo2PrYU9
 HWIoEbizsXLm18WtTcaf0GCagRMvm48bhfoVwaqjwcUDpXv6SbG96SstSfbhstnxgLaF
 FaB1Zl0mLbKCADC9YTliNMQrFeORreM8oAhFZ9mGs8UxCEIhR274YZ9SaGOTMq78bmfB
 9fvg==
X-Gm-Message-State: AAQBX9dV/WjLygaDKasZs+VmggFzrLp+OK4f0ViEpGiQJaDhGflvfrbE
 e2ip7GVlgAzxOdFoIU4Ojzb8AUVeOWuzMq0cVgk=
X-Google-Smtp-Source: AKy350aebxuJNzwRIXI+ftFotr0WiAb4hMpaTqhzruVTjvEepVx/aJIXT10TUO5P1x3R58/taDGKO2cr+xfWgT0DdfU=
X-Received: by 2002:a25:7349:0:b0:b75:968e:f282 with SMTP id
 o70-20020a257349000000b00b75968ef282mr707139ybc.11.1680736787750; Wed, 05 Apr
 2023 16:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
In-Reply-To: <20230405201416.395840-1-daniel.almeida@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Apr 2023 01:19:36 +0200
Message-ID: <CANiq72m-Ez91L0kH8pYTqGNaG+stPznY7-GPq16Q2wTcvj75uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: virtio: add virtio support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: ojeda@kernel.org, wedsonaf@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, virtualization@lists.linux-foundation.org
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

SGkgRGFuaWVsLAoKT24gV2VkLCBBcHIgNSwgMjAyMyBhdCAxMDoxNOKAr1BNIERhbmllbCBBbG1l
aWRhCjxkYW5pZWwuYWxtZWlkYUBjb2xsYWJvcmEuY29tPiB3cm90ZToKPgo+IEFnYWluIGEgYml0
IG5ldyB3aXRoIFJ1c3Qgc3VibWlzc2lvbnMuIEkgd2FzIHRvbGQgYnkgR2FyeSBHdW8gdG8KPiBy
ZWJhc2Ugb24gdG9wIG9mIHJ1c3QtbmV4dCwgYnV0IGl0IHNlZW1zICp2ZXJ5KiBiZWhpbmQ/CgpJ
biBnZW5lcmFsLCBwcmVmZXIgdGhlIG1vc3Qgc3RhYmxlIGJhc2UgeW91IGNhbiBmaW5kOiBMaW51
cycgdGFncyBpZgpwb3NzaWJsZSwgb3RoZXJ3aXNlIGBydXN0LW5leHRgIGlmIHlvdSBuZWVkIHNv
bWV0aGluZyBmcm9tIHRoZXJlLApvdGhlcndpc2UgeW91IG1heSBzZW5kIHNvbWV0aGluZyBvbiB0
b3Agb2Ygc29tZSBwcmVyZXF1aXNpdGVzIHRoYXQgbWF5Cm5vdCBoYXZlIGxhbmRlZCB5ZXQuIFBs
ZWFzZSBzZWUKaHR0cHM6Ly9ydXN0LWZvci1saW51eC5jb20vY29udHJpYnV0aW5nI3RoZS1ydXN0
LXN1YnN5c3RlbSBmb3Igc29tZQpvdGhlciBkZXRhaWxzLiBgcnVzdC1uZXh0YCBpcyB0aGUgbGF0
ZXN0IFJ1c3Qgc3RhdGUgKHdoaWNoIGF0IHRoZQptb21lbnQgaXMganVzdCBMaW51cycgLXJjMSAt
LSBkaWQgeW91IG5lZWQgc29tZXRoaW5nIHRoYXQgbGFuZGVkIGxhdGVyCmluIG1haW5saW5lPyBJ
biBhbnkgY2FzZSwgdG9tb3Jyb3cgSSB3aWxsIGxpa2VseSBtb3ZlIGl0IHRvIC1yYzUgc2luY2UK
SSB3aWxsIHN0YXJ0IG1lcmdpbmcpLgoKPiBUaGUgZmlyc3QgcGF0Y2ggZG9lcyBub3QgYnVpbGQg
b24gaXRzIG93biBkdWUgdG8gYSBkZWFkX2NvZGUgd2FybmluZy4KPiBJdCBpcyBoYXJkIHRvIG5v
dCBoYXZlIGRlYWQgY29kZSB3aGVuIG9uZSBpcyBhZGRpbmcgaW5mcmFzdHJ1Y3R1cmUgdG8gYmUK
PiB1c2VkIGJ5IG90aGVycyBhdCBhIGxhdGVyIG9wcG9ydHVuaXR5LiBMZXQgbWUga25vdyBpZiB5
b3Ugd291bGQgbGlrZSB0bwo+IHNlZSB0aGUgcGF0Y2hlcyBzcXVhc2hlZCBpbnRvIG9uZSB0byBm
aXggdGhpcy4KClBhdGNoZXMgc2VyaWVzIG11c3QgYnVpbGQgYmV0d2VlbiBlYWNoIHBhdGNoLiBI
b3dldmVyLCBpbnN0ZWFkIG9mCnNxdWFzaGluZywgeW91IG1heSB1c2UgYGFsbG93KGRlYWRfY29k
ZSlgIHRvIHNwbGl0IHBhdGNoZXMgYXMgdGhleQp3b3VsZCBub3JtYWxseSBiZSBzcGxpdC4gSW4g
b3RoZXIgd29yZHMsIGl0IGlzIG1vcmUgaW1wb3J0YW50IHRvIGhhdmUKcGF0Y2hlcyBtb3JlIGVh
c2lseSByZXZpZXdhYmxlIHRoYW4gYXZvaWRpbmcgYW4gYGFsbG93YCBsaW5lLgoKQ2hlZXJzLApN
aWd1ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
