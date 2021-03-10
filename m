Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8433C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 08:28:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708E064FDE
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 08:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708E064FDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 289B840182;
	Wed, 10 Mar 2021 08:28:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5rU5YC-KqszE; Wed, 10 Mar 2021 08:28:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF42B4314A;
	Wed, 10 Mar 2021 08:28:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABBC8C000A;
	Wed, 10 Mar 2021 08:28:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2AAFC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 08:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB64F4314A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 08:28:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8GXVjeZj0e3t
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 08:28:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A591D40182
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 08:27:59 +0000 (UTC)
Received: from mail-oi1-f172.google.com ([209.85.167.172]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MqJyX-1m72T81JQZ-00nSKS for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 09:27:57 +0100
Received: by mail-oi1-f172.google.com with SMTP id d16so8934593oic.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 00:27:57 -0800 (PST)
X-Gm-Message-State: AOAM532uNE25Wxp25hQkydiRrRIxLJPlB/envOQtE7g3O6iFJGtVfxTd
 qHQV/w5AuJHG/hOBj81vwm0408DdE2S56EIIVeg=
X-Google-Smtp-Source: ABdhPJxUhp0PQlwZhuWBNMm9oBfXDiwFXSQirR9+uVR5kqr2lW3VW2x9+3+VkueduIybWF/5lKAChdCwsc7m15dMWKc=
X-Received: by 2002:aca:bf44:: with SMTP id p65mr1571024oif.11.1615364876081; 
 Wed, 10 Mar 2021 00:27:56 -0800 (PST)
MIME-Version: 1.0
References: <9a2086f37c0a62069b67c39a3f75941b78a0039c.1614749417.git.jie.deng@intel.com>
 <43b0842b-8b0f-1979-ed07-d6124e3a6b79@redhat.com>
 <db9350b3-b847-8f54-546f-9a0bdec425d4@intel.com>
 <a3d4ce55-db25-5f96-ff44-5b76edfe9e08@redhat.com>
In-Reply-To: <a3d4ce55-db25-5f96-ff44-5b76edfe9e08@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Mar 2021 09:27:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a04u9Xv15K06zrsOtzZF18+1wDpJbBHUU3wYwU--Hdz5A@mail.gmail.com>
Message-ID: <CAK8P3a04u9Xv15K06zrsOtzZF18+1wDpJbBHUU3wYwU--Hdz5A@mail.gmail.com>
Subject: Re: [PATCH v6] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>
X-Provags-ID: V03:K1:IPvP1MvAA0aXZ+m/siSRtv8E3a1j9cbzcld5oBo0Rf3GKCDXj5W
 E0fcpBD+G7l0qsQWt02E1ApluGfp/zNQ7Kbi/wYEv0r0+HshgNPW6cXunbRyTS8AZBUiNRt
 5IpEM8I0AxtVjSdy8+aqmN39lX/GS1Ap9GLScH8mAUeoH1mfgwfdQAlf6FjZTfeOec++LD/
 kKvclNbsU2jRg2+q83Uvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZrtuJTOqz5Q=:P7qaiQnJ/xHpOJVU93PoWK
 n0dFk3uCADMfuy3WPjil1DFiMmdKTqJHuRAkPxJv2yMfpLgoeUyW0/d+lB5ggnYu0XoRR4Svg
 EqVKVFP+I9t/fweAZv8iXPOyMV9EHRlH/Ay6BjWh8NGYYeCJWLybbL+N9Pex1vJ/qw/tckAMh
 rJxZ6TrHqi2UMPOG1/j07+0FYd4L1vr75a0ffqh0+PgqTfUr3/5OjKTdr47f9ncrBgUGL7Wn9
 1qjdpMYrDr5GtLS9ywntWIvjQGzc7M2qwa41+VxDZMFwhI7sQPFEKEYBI6SNc0VIoNIsISJZC
 IwmzvC7+VYgZrfq8gpotDsu3QCRJvYMDOV636agCJhTeBZ0dYD0giF2HWs3W3hGca29W4W4ME
 H0xo1v2kFhHZwRa811zw+YUJbFDvuq+uAwPKSxktH2U36VhSv9foXWSQoYHdnlyRy0L26Rq86
 ojquAEHtLuz666HOEH2YB57nZ8uth9scoVf9RdvL3cAefhVxsBEkUlF0eXjvfKZp94WGU4Sbq
 WQbbsbM07aG/B4FfZPb+Tnu32Jc8XF4m/I/iF9b3NbnJmmNAo6rwXypwM1LpXfMEA==
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, loic.poulain@linaro.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgNDo1OSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiBPbiAyMDIxLzMvMTAgMTA6MjIg5LiK5Y2ILCBKaWUgRGVuZyB3cm90
ZToKPiA+IE9uIDIwMjEvMy80IDE3OjE1LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+Cj4gPj4KPiA+
Pj4gKyAgICAgICAgfQo+ID4+PiArCj4gPj4+ICsgICAgICAgIGlmIChtc2dzW2ldLmZsYWdzICYg
STJDX01fUkQpCj4gPj4+ICsgICAgICAgICAgICBtZW1jcHkobXNnc1tpXS5idWYsIHJlcS0+YnVm
LCBtc2dzW2ldLmxlbik7Cj4gPj4KPiA+Pgo+ID4+IFNvcnJ5IGlmIEkgaGFkIGFza2VkIHRoaXMg
YmVmb3JlIGJ1dCBhbnkgcmFzb24gbm90IHRvIHVzZSBtc2dbaV0uYnVmCj4gPj4gZGlyZWN0bHk/
Cj4gPj4KPiA+Pgo+ID4gVGhlIG1zZ1tpXS5idWYgaXMgcGFzc2VkIGJ5IHRoZSBJMkMgY29yZS4g
SSBqdXN0IG5vdGljZWQgdGhhdCB0aGVzZQo+ID4gYnVmcyBhcmUgbm90Cj4gPiBhbHdheXMgYWxs
b2NhdGVkIGJ5IGttYWxsb2MuIFRoZXkgbWF5IGNvbWUgZnJvbSB0aGUgc3RhY2ssIHdoaWNoIG1h
eQo+ID4gY2F1c2UKPiA+IHRoZSBjaGVjayAic2dfaW5pdF9vbmUgLT4gc2dfc2V0X2J1ZiAtPiB2
aXJ0X2FkZHJfdmFsaWQiICB0byBmYWlsLgo+ID4gVGhlcmVmb3JlIHRoZQo+ID4gbXNnW2ldLmJ1
ZiBpcyBub3Qgc3VpdGFibGUgZm9yIGRpcmVjdCB1c2UgaGVyZS4KPgo+IFJpZ2h0LCBzdGFjayBp
cyB2aXJ0dWFsbHkgbWFwcGVkLgoKTWF5YmUgdGhlcmUgaXMgKG9yIHNob3VsZCBiZSkgYSB3YXkg
dG8gbGV0IHRoZSBpMmMgY29yZSBjb2RlIGhhbmRsZQp0aGUgYm91bmNlIGJ1ZmZlcmluZyBpbiB0
aGlzIGNhc2UuIFRoaXMgaXMgc3VyZWx5IG5vdCBhIHByb2JsZW0gdGhhdAppcyB1bmlxdWUgdG8g
dGhpcyBkcml2ZXIsIGFuZCBJJ20gc3VyZSBpdCBoYXMgY29tZSB1cCBtYW55IHRpbWVzIGluCnRo
ZSBwYXN0LgoKSSBzZWUgdGhhdCB0aGVyZSBpcyBhIGkyY19nZXRfZG1hX3NhZmVfbXNnX2J1Zigp
IGhlbHBlciBmb3IgdGhpcwpwdXJwb3NlLCBidXQgaXQgaGFzIHRvIGJlIGNhbGxlZCBieSB0aGUg
ZHJpdmVyIHJhdGhlciB0aGFuIHRoZSBjb3JlLApzbyB0aGUgZHJpdmVyIHN0aWxsIG5lZWRzIHRv
IGtlZXAgdHJhY2sgb2YgZWFjaCBhZGRyZXNzIHdoZW4gaXQKc2VuZHMgbXVsdGlwbGUgaTJjX21z
ZyBhdCBvbmNlLCBidXQgbWF5YmUgaXQgY2FuIGFsbCBiZSBkb25lCmluc2lkZSB0aGUgc2dfdGFi
bGUgaW5zdGVhZCBvZiB5ZXQgYW5vdGhlciBzdHJ1Y3R1cmUuCgpBdCBsZWFzdCB0aGlzIG9uZSBh
dm9pZHMgY29weWluZyBkYXRhIHRoYXQgaXMgbWFya2VkIHdpdGggdGhlCkkyQ19NX0RNQV9TQUZF
IGZsYWcuCgogICAgICAgQXJuZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
