Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D6AC32793
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 14:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 978C4827BB;
	Wed, 24 Aug 2022 14:11:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 978C4827BB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=jTVBzq0q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tJRfHA100Jm; Wed, 24 Aug 2022 14:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C5E0827A5;
	Wed, 24 Aug 2022 14:11:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C5E0827A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2CA6C0032;
	Wed, 24 Aug 2022 14:11:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A15DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B7CD40B7E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:10:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B7CD40B7E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=jTVBzq0q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a9fIMg23OSGB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:10:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6748A4024B
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6748A4024B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:10:58 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id q2so20098440edb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=kqPUQCej5vuqxvtj8Chlk3T/0EwQ6MX8daIfGCr7o8M=;
 b=jTVBzq0qwP/Jiix3oxmDZ7+wYfTBhEWTauZQdu8hOviYHBGCplvf/sjEo/RV5EynDV
 F/3igCTqIWBw9y1M+Tz1KtUNZJ/Vc7vYsDCQckxSEEaEAATSUMLMhhZM/uRvXPKJwTID
 JFPXKVME1YPvW3AWEEt8IY1tnflEl6+s2+VTI3lNdEf9I2/bpW1ED4ELRE0sMfvAneeH
 /StlMvl5hA5f4v6Ub32YqKj3011/RpihmCQ/mxpFLVUJNkoTI8bwaIrfE8kqKCGPv4z9
 I+UIpLo6Qj3px/bXQ4vWO4iPykWOgMwW3vwWBjvKVJT+EdtLeVH/fQX5AFSNWc9Rj8ry
 Hsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=kqPUQCej5vuqxvtj8Chlk3T/0EwQ6MX8daIfGCr7o8M=;
 b=zcSoemAjEI4A7yf9dpA+2hP5wOeQSnJMcqy4KqzqWqZsG4fBBJOwttPJMA6cKFMvH5
 h0XLG6y7pyDB6ykkQ0vmzbZmXTNXSyo1ZMjn03xlIMb5WWTtqmfgAi8RcI1oSRJonuCn
 P+wIX+zpaSWm3yLZiXSfFmmEB9Hw1XM0iJ85b+RNIu96BPU3v5rdHztZaubAlWcp+OMS
 nqC3rjGhgW8ol92Igb0utKY9iX8avkiPrbTkk7w1ewClJnulqHeiB619HmtIHvs9H27U
 AayooOiH3mKZ7jrU29WRSsCQrdHkM/WgsnanbBay8lC/Yd4cp7t+NaBKrAdLxu7Hqamf
 H8vQ==
X-Gm-Message-State: ACgBeo3f/tjotlQfl4sou5uQ+dwWWMXtDcr39Wlkgm6sqRIMqshZQfMo
 KJ+0OyUPuy4lbJJPWlRwlts=
X-Google-Smtp-Source: AA6agR4FhXaC9pbWpsAk9+dYxjrSjwUKJso4IGx0zPGDwcQGaUM8T/17R/PS2YwW53RL5Bz2crZ4pw==
X-Received: by 2002:a05:6402:358a:b0:446:da94:e68c with SMTP id
 y10-20020a056402358a00b00446da94e68cmr7682224edc.356.1661350256435; 
 Wed, 24 Aug 2022 07:10:56 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:62ca:57d9:b533:6057?
 ([2a02:908:1256:79a0:62ca:57d9:b533:6057])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a1709061db200b0073d6d760daesm1229270ejh.60.2022.08.24.07.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Aug 2022 07:10:55 -0700 (PDT)
Message-ID: <abb7842a-ca07-59db-927b-06c3dc17974c@gmail.com>
Date: Wed, 24 Aug 2022 16:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 9/9] dma-buf: Remove internal lock
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robdclark@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Thierry Reding
 <thierry.reding@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Qiang Yu <yuq825@gmail.com>
References: <20220824102248.91964-1-dmitry.osipenko@collabora.com>
 <20220824102248.91964-10-dmitry.osipenko@collabora.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220824102248.91964-10-dmitry.osipenko@collabora.com>
Cc: lima@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, linux-media@vger.kernel.org
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

QW0gMjQuMDguMjIgdW0gMTI6MjIgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gVGhlIGludGVy
bmFsIGRtYS1idWYgbG9jayBpc24ndCBuZWVkZWQgYW55bW9yZSBiZWNhdXNlIHRoZSB1cGRhdGVk
Cj4gbG9ja2luZyBzcGVjaWZpY2F0aW9uIGNsYWltcyB0aGF0IGRtYS1idWYgcmVzZXJ2YXRpb24g
bXVzdCBiZSBsb2NrZWQKPiBieSBpbXBvcnRlcnMsIGFuZCB0aHVzLCB0aGUgaW50ZXJuYWwgZGF0
YSBpcyBhbHJlYWR5IHByb3RlY3RlZCBieSB0aGUKPiByZXNlcnZhdGlvbiBsb2NrLiBSZW1vdmUg
dGhlIG9ic29sZXRlZCBpbnRlcm5hbCBsb2NrLgo+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9z
aXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9kbWEtYnVmL2RtYS1idWYuYyB8IDE0ICsrKystLS0tLS0tLS0tCj4gICBpbmNsdWRlL2xpbnV4
L2RtYS1idWYuaCAgIHwgIDkgLS0tLS0tLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVm
L2RtYS1idWYuYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKPiBpbmRleCA2OTZkMTMyYjAy
ZjQuLmEwNDA2MjU0ZjBhZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5j
Cj4gKysrIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwo+IEBAIC02NTYsNyArNjU2LDYgQEAg
c3RydWN0IGRtYV9idWYgKmRtYV9idWZfZXhwb3J0KGNvbnN0IHN0cnVjdCBkbWFfYnVmX2V4cG9y
dF9pbmZvICpleHBfaW5mbykKPiAgIAo+ICAgCWRtYWJ1Zi0+ZmlsZSA9IGZpbGU7Cj4gICAKPiAt
CW11dGV4X2luaXQoJmRtYWJ1Zi0+bG9jayk7Cj4gICAJSU5JVF9MSVNUX0hFQUQoJmRtYWJ1Zi0+
YXR0YWNobWVudHMpOwo+ICAgCj4gICAJbXV0ZXhfbG9jaygmZGJfbGlzdC5sb2NrKTsKPiBAQCAt
MTUwMyw3ICsxNTAyLDcgQEAgRVhQT1JUX1NZTUJPTF9OU19HUEwoZG1hX2J1Zl9tbWFwX3VubG9j
a2VkLCBETUFfQlVGKTsKPiAgIGludCBkbWFfYnVmX3ZtYXAoc3RydWN0IGRtYV9idWYgKmRtYWJ1
Ziwgc3RydWN0IGlvc3lzX21hcCAqbWFwKQo+ICAgewo+ICAgCXN0cnVjdCBpb3N5c19tYXAgcHRy
Owo+IC0JaW50IHJldCA9IDA7Cj4gKwlpbnQgcmV0Owo+ICAgCj4gICAJaW9zeXNfbWFwX2NsZWFy
KG1hcCk7Cj4gICAKPiBAQCAtMTUxNSwyOCArMTUxNCwyNSBAQCBpbnQgZG1hX2J1Zl92bWFwKHN0
cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBpb3N5c19tYXAgKm1hcCkKPiAgIAlpZiAoIWRt
YWJ1Zi0+b3BzLT52bWFwKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+IC0JbXV0ZXhfbG9j
aygmZG1hYnVmLT5sb2NrKTsKPiAgIAlpZiAoZG1hYnVmLT52bWFwcGluZ19jb3VudGVyKSB7Cj4g
ICAJCWRtYWJ1Zi0+dm1hcHBpbmdfY291bnRlcisrOwo+ICAgCQlCVUdfT04oaW9zeXNfbWFwX2lz
X251bGwoJmRtYWJ1Zi0+dm1hcF9wdHIpKTsKPiAgIAkJKm1hcCA9IGRtYWJ1Zi0+dm1hcF9wdHI7
Cj4gLQkJZ290byBvdXRfdW5sb2NrOwo+ICsJCXJldHVybiAwOwo+ICAgCX0KPiAgIAo+ICAgCUJV
R19PTihpb3N5c19tYXBfaXNfc2V0KCZkbWFidWYtPnZtYXBfcHRyKSk7Cj4gICAKPiAgIAlyZXQg
PSBkbWFidWYtPm9wcy0+dm1hcChkbWFidWYsICZwdHIpOwo+ICAgCWlmIChXQVJOX09OX09OQ0Uo
cmV0KSkKPiAtCQlnb3RvIG91dF91bmxvY2s7Cj4gKwkJcmV0dXJuIHJldDsKPiAgIAo+ICAgCWRt
YWJ1Zi0+dm1hcF9wdHIgPSBwdHI7Cj4gICAJZG1hYnVmLT52bWFwcGluZ19jb3VudGVyID0gMTsK
PiAgIAo+ICAgCSptYXAgPSBkbWFidWYtPnZtYXBfcHRyOwo+ICAgCj4gLW91dF91bmxvY2s6Cj4g
LQltdXRleF91bmxvY2soJmRtYWJ1Zi0+bG9jayk7Cj4gLQlyZXR1cm4gcmV0Owo+ICsJcmV0dXJu
IDA7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX05TX0dQTChkbWFfYnVmX3ZtYXAsIERNQV9CVUYp
Owo+ICAgCj4gQEAgLTE1NzgsMTMgKzE1NzQsMTEgQEAgdm9pZCBkbWFfYnVmX3Z1bm1hcChzdHJ1
Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgaW9zeXNfbWFwICptYXApCj4gICAJQlVHX09OKGRt
YWJ1Zi0+dm1hcHBpbmdfY291bnRlciA9PSAwKTsKPiAgIAlCVUdfT04oIWlvc3lzX21hcF9pc19l
cXVhbCgmZG1hYnVmLT52bWFwX3B0ciwgbWFwKSk7Cj4gICAKPiAtCW11dGV4X2xvY2soJmRtYWJ1
Zi0+bG9jayk7Cj4gICAJaWYgKC0tZG1hYnVmLT52bWFwcGluZ19jb3VudGVyID09IDApIHsKPiAg
IAkJaWYgKGRtYWJ1Zi0+b3BzLT52dW5tYXApCj4gICAJCQlkbWFidWYtPm9wcy0+dnVubWFwKGRt
YWJ1ZiwgbWFwKTsKPiAgIAkJaW9zeXNfbWFwX2NsZWFyKCZkbWFidWYtPnZtYXBfcHRyKTsKPiAg
IAl9Cj4gLQltdXRleF91bmxvY2soJmRtYWJ1Zi0+bG9jayk7Cj4gICB9Cj4gICBFWFBPUlRfU1lN
Qk9MX05TX0dQTChkbWFfYnVmX3Z1bm1hcCwgRE1BX0JVRik7Cj4gICAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9kbWEtYnVmLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaAo+IGluZGV4
IGQ0OGQ1MzRkYzU1Yy4uYWVkNjY5NWJiYjUwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgv
ZG1hLWJ1Zi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9kbWEtYnVmLmgKPiBAQCAtMzI2LDE1ICsz
MjYsNiBAQCBzdHJ1Y3QgZG1hX2J1ZiB7Cj4gICAJLyoqIEBvcHM6IGRtYV9idWZfb3BzIGFzc29j
aWF0ZWQgd2l0aCB0aGlzIGJ1ZmZlciBvYmplY3QuICovCj4gICAJY29uc3Qgc3RydWN0IGRtYV9i
dWZfb3BzICpvcHM7Cj4gICAKPiAtCS8qKgo+IC0JICogQGxvY2s6Cj4gLQkgKgo+IC0JICogVXNl
ZCBpbnRlcm5hbGx5IHRvIHNlcmlhbGl6ZSBsaXN0IG1hbmlwdWxhdGlvbiwgYXR0YWNoL2RldGFj
aCBhbmQKPiAtCSAqIHZtYXAvdW5tYXAuIE5vdGUgdGhhdCBpbiBtYW55IGNhc2VzIHRoaXMgaXMg
c3VwZXJzZWVkZWQgYnkKPiAtCSAqIGRtYV9yZXN2X2xvY2soKSBvbiBAcmVzdi4KPiAtCSAqLwo+
IC0Jc3RydWN0IG11dGV4IGxvY2s7Cj4gLQo+ICAgCS8qKgo+ICAgCSAqIEB2bWFwcGluZ19jb3Vu
dGVyOgo+ICAgCSAqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
