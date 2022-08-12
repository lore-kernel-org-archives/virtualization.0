Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EA0C00140
	for <virtualization@archiver.kernel.org>; Fri, 12 Aug 2022 11:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39BD76108A;
	Fri, 12 Aug 2022 11:34:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39BD76108A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WzmVA6wJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AMIhaY0JTe6p; Fri, 12 Aug 2022 11:34:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C5197610D3;
	Fri, 12 Aug 2022 11:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5197610D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A7B7C0032;
	Fri, 12 Aug 2022 11:34:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C87CAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90AB940BA9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:34:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90AB940BA9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=WzmVA6wJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DuvpfkhMqNXe
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:34:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACF3340BA8
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACF3340BA8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 11:34:07 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id kb8so1553572ejc.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=2maBmCwKBmigg6muaEXXhf/Ng5GHmKY483ELQvBK7bw=;
 b=WzmVA6wJmViKgJcjJ28fwTes4+4nkLVN3Mx6n7aAByQjaF1kqlO8c/DkZzzNbQ5PMJ
 Q6QRifhtEywKPW0BRycraqPgJbNNV4Fkr0BDi9NwSjofj+/eExHcmIHXfmWBqj8nEM+V
 SJ6yUML0yO8yFd9lLsoNczBtQtybcTMT4WUr1ptuUKBS3/Rda9YC3hjAtXIBeNWzrfQv
 8awekeP8HdFvSg9RwEt6hfJjxWj4IHX4MucvbIt4QDscDPd/6Xe/c8eYLuCx5yo9ewIX
 pCKNLJxEdZn4+tUGCfNxm+c1cgbj7a+b8mhWZ+qT9Wu2+c+9oyIWqC1lkYhae0HgqZSg
 TC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=2maBmCwKBmigg6muaEXXhf/Ng5GHmKY483ELQvBK7bw=;
 b=c2IeBwGrmzru5+Egz5ZcV4MAGZ4XwH97qLu70uMWtUEzfAC2QV61mI92C7I5q7lZjc
 fLQ2/+E/Wissuv6Zfhn4TsnKHviIb5T9UjX+5NGOBxerY8rBJhi2BLFIAvK4XHaSI1Ut
 ZKAPx/nQRUtJk3FRnVPb+yZY13pqsWpa3ahLTsZ2SYPWDdg3me4rx8cN8I226LxTdOJy
 kHyqawkxK0i9uMCztt8PN8IgvEZboFB/EHZuRM6rq1pA3OyBNl4J/p5J0i8gx6/zMyZd
 IwG2cYjKxloAEvVgAMdaKQzsaDM4TPRyKqdFD5w0+gdMLFP+Pb1ckJi7mhxhjQASV3rh
 X6/Q==
X-Gm-Message-State: ACgBeo1nNEWqqpGNBZnz43C/sxFwTiNKxXfQGKgZ4H0v4LNH23PMtqB3
 krIzayntWiZQ0pKcC2/6XnQ=
X-Google-Smtp-Source: AA6agR7yLrz2JyTe8JHAoaW31lDloNP6q9ah/gkL0Xj0JLrU44S+nATJXnQ7Xvnv8KPuB3tTB73pJw==
X-Received: by 2002:a17:906:eeca:b0:730:6880:c397 with SMTP id
 wu10-20020a170906eeca00b007306880c397mr2352637ejb.593.1660304045907; 
 Fri, 12 Aug 2022 04:34:05 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 jj23-20020a170907985700b0073151ce7726sm696022ejc.100.2022.08.12.04.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Aug 2022 04:34:05 -0700 (PDT)
Message-ID: <93484389-1f79-b364-700f-60769fc5f8a5@gmail.com>
Date: Fri, 12 Aug 2022 13:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Linaro-mm-sig] [PATCH v2 3/5] dma-buf: Move all dma-bufs to
 dynamic locking specification
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20220725151839.31622-1-dmitry.osipenko@collabora.com>
 <20220725151839.31622-4-dmitry.osipenko@collabora.com>
 <6c8bded9-1809-608f-749a-5ee28b852d32@gmail.com>
 <562fbacf-3673-ff3c-23a1-124284b4456c@collabora.com>
 <87724722-b9f3-a016-c25c-4b0415f2c37f@amd.com>
 <0863cafa-c252-e194-3d23-ef640941e36e@collabora.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <0863cafa-c252-e194-3d23-ef640941e36e@collabora.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, Sumit Semwal <sumit.semwal@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-rdma@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Daniel Stone <daniel@fooishbar.org>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 spice-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-media@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>,
 amd-gfx@lists.freedesktop.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpBbSAxMC4wOC4yMiB1bSAyMDo1MyBzY2hyaWViIERtaXRyeSBPc2lwZW5rbzoKPiBPbiA4LzEw
LzIyIDIxOjI1LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxMC4wOC4yMiB1bSAxOTo0
OSBzY2hyaWViIERtaXRyeSBPc2lwZW5rbzoKPj4+IE9uIDgvMTAvMjIgMTQ6MzAsIENocmlzdGlh
biBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMjUuMDcuMjIgdW0gMTc6MTggc2NocmllYiBEbWl0cnkg
T3NpcGVua286Cj4+Pj4+IFRoaXMgcGF0Y2ggbW92ZXMgdGhlIG5vbi1keW5hbWljIGRtYS1idWYg
dXNlcnMgb3ZlciB0byB0aGUgZHluYW1pYwo+Pj4+PiBsb2NraW5nIHNwZWNpZmljYXRpb24uIFRo
ZSBzdHJpY3QgbG9ja2luZyBjb252ZW50aW9uIHByZXZlbnRzIGRlYWRsb2NrCj4+Pj4+IHNpdHVh
dGlvbiBmb3IgZG1hLWJ1ZiBpbXBvcnRlcnMgYW5kIGV4cG9ydGVycy4KPj4+Pj4KPj4+Pj4gUHJl
dmlvdXNseSB0aGUgInVubG9ja2VkIiB2ZXJzaW9ucyBvZiB0aGUgZG1hLWJ1ZiBBUEkgZnVuY3Rp
b25zIHdlcmVuJ3QKPj4+Pj4gdGFraW5nIHRoZSByZXNlcnZhdGlvbiBsb2NrIGFuZCB0aGlzIHBh
dGNoIG1ha2VzIHRoZW0gdG8gdGFrZSB0aGUgbG9jay4KPj4+Pj4KPj4+Pj4gSW50ZWwgYW5kIEFN
RCBHUFUgZHJpdmVycyBhbHJlYWR5IHdlcmUgbWFwcGluZyBpbXBvcnRlZCBkbWEtYnVmcyB1bmRl
cgo+Pj4+PiB0aGUgaGVsZCBsb2NrLCBoZW5jZSB0aGUgImxvY2tlZCIgdmFyaWFudCBvZiB0aGUg
ZnVuY3Rpb25zIGFyZSBhZGRlZAo+Pj4+PiBmb3IgdGhlbSBhbmQgdGhlIGRyaXZlcnMgYXJlIHVw
ZGF0ZWQgdG8gdXNlIHRoZSAibG9ja2VkIiB2ZXJzaW9ucy4KPj4+PiBJbiBnZW5lcmFsICJZZXMs
IHBsZWFzZSIsIGJ1dCB0aGF0IHdvbid0IGJlIHRoYXQgZWFzeS4KPj4+Pgo+Pj4+IFlvdSBub3Qg
b25seSBuZWVkIHRvIGNoYW5nZSBhbWRncHUgYW5kIGk5MTUsIGJ1dCBhbGwgZHJpdmVycwo+Pj4+
IGltcGxlbWVudGluZyB0aGUgbWFwX2RtYV9idWYoKSwgdW5tYXBfZG1hX2J1ZigpIGNhbGxiYWNr
cy4KPj4+Pgo+Pj4+IEF1ZGl0aW5nIGFsbCB0aGF0IGNvZGUgaXMgYSBodWdlIGJ1bmNoIG9mIHdv
cmsuCj4+PiBIbSwgbmVpdGhlciBvZiBkcml2ZXJzIHRha2UgdGhlIHJlc3YgbG9jayBpbiBtYXBf
ZG1hX2J1Zi91bm1hcF9kbWFfYnVmLgo+Pj4gSXQncyBlYXN5IHRvIGF1ZGl0IHRoZW0gYWxsIGFu
ZCBJIGRpZCBpdC4gU28gZWl0aGVyIEknbSBtaXNzaW5nCj4+PiBzb21ldGhpbmcgb3IgaXQgZG9l
c24ndCB0YWtlIG11Y2ggdGltZSB0byBjaGVjayB0aGVtIGFsbC4gQW0gSSByZWFsbHkKPj4+IG1p
c3Npbmcgc29tZXRoaW5nPwo+PiBPaywgc28gdGhpcyBpcyBvbmx5IGNoYW5naW5nIG1hcC91bm1h
cCBub3c/Cj4gSXQgYWxzbyB2bWFwL3Z1bm1hcCBhbmQgYXR0YWNoL2RldGFjaDogSW4gdGhlIHBy
ZXZpb3VzIHBhdGNoIEkgYWRkZWQgdGhlCj4gX3VubG9ja2VkIHBvc3RmaXggdG8gdGhlIGZ1bmMg
bmFtZXMgYW5kIGluIHRoaXMgcGF0Y2ggSSBtYWRlIHRoZW0gYWxsIHRvCj4gYWN0dWFsbHkgdGFr
ZSB0aGUgbG9jay4KCgpUYWtlIHlvdXIgcGF0Y2ggIltQQVRDSCB2MiAyLzVdIGRybS9nZW06IFRh
a2UgcmVzZXJ2YXRpb24gbG9jayBmb3IgCnZtYXAvdnVubWFwIG9wZXJhdGlvbnMiIGFzIGEgYmx1
ZXByaW50IG9uIGhvdyB0byBhcHByb2FjaCBpdC4KCkUuZy4gb25lIGNhbGxiYWNrIGF0IGEgdGlt
ZSBhbmQgdGhlbiBkb2N1bWVudCB0aGUgcmVzdWx0IGluIHRoZSBlbmQuCgpSZWdhcmRzLApDaHJp
c3RpYW4uCgo+Cj4+IEluIHRoaXMgY2FzZSBwbGVhc2Ugc2VwYXJhdGUgdGhpcyBmcm9tIHRoZSBk
b2N1bWVudGF0aW9uIGNoYW5nZS4KPiBJJ2xsIGZhY3RvciBvdXQgdGhlIGRvYyBpbiB0aGUgdjMu
Cj4KPj4gSSB3b3VsZCBhbHNvIGRyb3AgdGhlIF9sb2NrZWQgcG9zdGZpeCBmcm9tIHRoZSBmdW5j
dGlvbiBuYW1lLCBqdXN0Cj4+IGhhdmluZyBfdW5sb2NrZWQgb24gYWxsIGZ1bmN0aW9ucyB3aGlj
aCBhcmUgc3VwcG9zZWQgdG8gYmUgY2FsbGVkIHdpdGgKPj4gdGhlIGxvY2sgaGVsZCBzaG91bGQg
YmUgc3VmZmljaWVudC4KPiBOb3RlZCBmb3IgdGhlIHYzLgo+Cj4+IFRoYW5rcyBmb3IgbG9va2lu
ZyBpbnRvIHRoaXMsCj4+IENocmlzdGlhbi4KPiBUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
