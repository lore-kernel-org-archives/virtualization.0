Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B88C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 08:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92CA481300;
	Wed, 10 Aug 2022 08:33:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92CA481300
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=Xo7HewGo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XBm9Xv999pPP; Wed, 10 Aug 2022 08:33:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0984C8127F;
	Wed, 10 Aug 2022 08:33:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0984C8127F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5FFBC0032;
	Wed, 10 Aug 2022 08:33:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E152C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 08:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D92E1409D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 08:33:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D92E1409D8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=Xo7HewGo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VeLLnVHdneOQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 08:33:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8343400CB
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8343400CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 08:33:34 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id w196so11830147oiw.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=qng18ezuViFS4JHv1suUwHMOD3dA0ddp/TS8ruYkzxY=;
 b=Xo7HewGoXQ93vdJ673ZkR+tcoUdDl9VfPro55Vby9VrJvIMSVQRWW+l8IzswksIecM
 FJ23GJpiXQh/pyuvnpU5g3iQbV02xodcvNiDJwDMgL67ZXX2fNtmG9OBAvT/AJiLKz1O
 m57OQJzScr8ptLkEC3wAZsB50Mtf/5dHx8myw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=qng18ezuViFS4JHv1suUwHMOD3dA0ddp/TS8ruYkzxY=;
 b=hjWDx4GbyHuFuIs26lJMYgKpMFknye4pCE9dRyDH+xWI9vSYBrOTsVwDmJ8i92pau8
 +1on8s0a0xmGmNrMVVNxqOkbf5lnEqTEdqrKTCdZ3h8HbIqnGR0h9z3zpxtnaPd+CGhZ
 r/RvXOiQe1ub2eHubGZbGBU012pa1jtsY30L7DrAUtB6Jeo1PPkMEZZzBMhfG4dZgLo9
 GeOVA4ca9IKqWMIE+JoD5zAl92MuRhqUOisqaDUNcyj2e0NH1xCW0DCgsVH1FZkWaSnw
 P9XiqESt5/eOPOq129CHz0860TsAPuItFZ3DSfgYIbcpHtySeKELwBuGCLg6CEezV5SF
 vDaw==
X-Gm-Message-State: ACgBeo218UTbTKzeDFk9wanBeI7xGBxhOMd7piEqr4P2CMcWa4ZgL0OV
 CE8fFqKeaDRHOaZzjANSPpFgDvZjVv0FdT0APxNmcQ==
X-Google-Smtp-Source: AA6agR6cStCNNsa+U2EXzNpks0Z071z2RD/SJln63AZJsOezVgSlE5S5WcCDeNCK/XxqGOBfJDhs4RSMetdDlNSIpBY=
X-Received: by 2002:a05:6808:1489:b0:33a:861c:838e with SMTP id
 e9-20020a056808148900b0033a861c838emr895072oiw.228.1660120413972; Wed, 10 Aug
 2022 01:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-2-dmitry.osipenko@collabora.com>
 <a42237c9-6304-4b06-cede-2175c7e7b87d@amd.com>
 <YvKO5r5Sr56e9vBf@phenom.ffwll.local>
 <e760f555-7f2d-dea9-70b2-c0881adc3afc@amd.com>
In-Reply-To: <e760f555-7f2d-dea9-70b2-c0881adc3afc@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 10 Aug 2022 10:33:22 +0200
Message-ID: <CAKMK7uEd1xX6P4YRgYOfjvqpwVmQ0YZPkHdK=4auwrkBE9CEzQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] drm/gem: Properly annotate WW context on
 drm_gem_lock_reservations() error
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>
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

T24gV2VkLCAxMCBBdWcgMjAyMiBhdCAwODo1MiwgQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFtIDA5LjA4LjIyIHVtIDE4OjQ0IHNjaHJpZWIg
RGFuaWVsIFZldHRlcjoKPiA+IE9uIFR1ZSwgSnVsIDA1LCAyMDIyIGF0IDAxOjMzOjUxUE0gKzAy
MDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gPj4gQW0gMDEuMDcuMjIgdW0gMTE6MDIgc2No
cmllYiBEbWl0cnkgT3NpcGVua286Cj4gPj4+IFVzZSB3d19hY3F1aXJlX2ZpbmkoKSBpbiB0aGUg
ZXJyb3IgY29kZSBwYXRocy4gT3RoZXJ3aXNlIGxvY2tkZXAKPiA+Pj4gdGhpbmtzIHRoYXQgbG9j
ayBpcyBoZWxkIHdoZW4gbG9jaydzIG1lbW9yeSBpcyBmcmVlZCBhZnRlciB0aGUKPiA+Pj4gZHJt
X2dlbV9sb2NrX3Jlc2VydmF0aW9ucygpIGVycm9yLiBUaGUgd3dfYWNxdWlyZV9jb250ZXh0IG5l
ZWRzIHRvIGJlCj4gPj4+IGFubm90YXRlZCBhcyAicmVsZWFzZWQiLCB3aGljaCBmaXhlcyB0aGUg
bm9pc3kgIldBUk5JTkc6IGhlbGQgbG9jayBmcmVlZCEiCj4gPj4+IHNwbGF0IG9mIFZpcnRJTy1H
UFUgZHJpdmVyIHdpdGggQ09ORklHX0RFQlVHX01VVEVYRVM9eSBhbmQgZW5hYmxlZCBsb2NrZGVw
Lgo+ID4+Pgo+ID4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+ID4+PiBGaXhlczogN2Vk
YzNlM2I5NzViNSAoImRybTogQWRkIGhlbHBlcnMgZm9yIGxvY2tpbmcgYW4gYXJyYXkgb2YgQk8g
cmVzZXJ2YXRpb25zLiIpCj4gPj4+IFJldmlld2VkLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhv
bWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IERtaXRy
eSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+Cj4gPj4gUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+IEFsc28g
YWRkZWQgdGhpcyByLWIgdGFnIHdoZW4gbWVyZ2luZyB0byBkcm0tbWlzYy1uZXh0LWZpeGVzLgo+
Cj4gSUlSQyBJJ3ZlIGFscmVhZHkgcHVzaGVkIHRoaXMgdG8gZHJtLW1pc2MtZml4ZXMgd2l0aCBh
IENDIHN0YWJsZSB0YWcKPiBhYm91dCAyIHdlZWtzIGFnby4KPgo+IFBsZWFzZSBkb3VibGUgY2hl
Y2ssIGl0IHByb2JhYmx5IGp1c3QgaGFzbid0IGNvbWUgZG93biB0aGUgc3RyZWFtIGFnYWluIHll
dC4KCkhtIHF1aWNrbHkgY2hlY2sgYW5kIEkgZGlkbid0IHNwb3QgaXQ/IFRoZXJlJ3MgYSBmZXcg
cGF0Y2hlcyBmcm9tCkRtaXRyeSBpbiB0aGUgbGFzdCBmZXcgcHVsbHMsIGFuZCBzb21lIG1vcmUg
c3R1ZmYgcGVuZGluZywgYnV0IG5vdAp0aGVzZSB0d28gYWZhaWNzPwotRGFuaWVsCgo+Cj4gQ2hy
aXN0aWFuLgo+Cj4gPiAtRGFuaWVsCj4gPgo+ID4+PiAtLS0KPiA+Pj4gICAgZHJpdmVycy9ncHUv
ZHJtL2RybV9nZW0uYyB8IDQgKystLQo+ID4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2RybV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPiA+Pj4gaW5kZXgg
ZWIwYzJkMDQxZjEzLi44NmQ2NzBjNzEyODYgMTAwNjQ0Cj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9kcm1fZ2VtLmMKPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+ID4+
PiBAQCAtMTIyNiw3ICsxMjI2LDcgQEAgZHJtX2dlbV9sb2NrX3Jlc2VydmF0aW9ucyhzdHJ1Y3Qg
ZHJtX2dlbV9vYmplY3QgKipvYmpzLCBpbnQgY291bnQsCj4gPj4+ICAgICAgICAgICAgIHJldCA9
IGRtYV9yZXN2X2xvY2tfc2xvd19pbnRlcnJ1cHRpYmxlKG9iai0+cmVzdiwKPiA+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFj
cXVpcmVfY3R4KTsKPiA+Pj4gICAgICAgICAgICAgaWYgKHJldCkgewo+ID4+PiAtICAgICAgICAg
ICAgICAgICAgIHd3X2FjcXVpcmVfZG9uZShhY3F1aXJlX2N0eCk7Cj4gPj4+ICsgICAgICAgICAg
ICAgICAgICAgd3dfYWNxdWlyZV9maW5pKGFjcXVpcmVfY3R4KTsKPiA+Pj4gICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Owo+ID4+PiAgICAgICAgICAgICB9Cj4gPj4+ICAgICB9Cj4gPj4+
IEBAIC0xMjUxLDcgKzEyNTEsNyBAQCBkcm1fZ2VtX2xvY2tfcmVzZXJ2YXRpb25zKHN0cnVjdCBk
cm1fZ2VtX29iamVjdCAqKm9ianMsIGludCBjb3VudCwKPiA+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gcmV0cnk7Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgfQo+ID4+PiAt
ICAgICAgICAgICAgICAgICAgIHd3X2FjcXVpcmVfZG9uZShhY3F1aXJlX2N0eCk7Cj4gPj4+ICsg
ICAgICAgICAgICAgICAgICAgd3dfYWNxdWlyZV9maW5pKGFjcXVpcmVfY3R4KTsKPiA+Pj4gICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4+PiAgICAgICAgICAgICB9Cj4gPj4+ICAg
ICB9Cj4KCgotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9y
YXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
