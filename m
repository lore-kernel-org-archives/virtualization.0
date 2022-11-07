Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772C3C43219
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 17:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDF5940384;
	Mon,  7 Nov 2022 17:26:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDF5940384
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=aigTDkQo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRGy0pgO3zCI; Mon,  7 Nov 2022 17:26:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05C3E40302;
	Mon,  7 Nov 2022 17:26:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05C3E40302
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4576C0032;
	Mon,  7 Nov 2022 17:26:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE97BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 17:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1B2460687
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 17:26:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1B2460687
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=aigTDkQo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id njuBbqqSIt8d
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 17:26:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6182605E0
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6182605E0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 17:26:02 +0000 (UTC)
Received: by mail-il1-x12d.google.com with SMTP id z9so6191547ilu.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Nov 2022 09:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k05Y4e+PrHzSfY5WD7UasfT68aLf+beRaOmVJAx50IE=;
 b=aigTDkQoIrZ5du6qge/d6nU8XEtnOQxQGbL3jhraCwqwWSZTnNbLNTpEqxU68U6tqz
 dT7IR3PAOIU4mgnAoPDn37z3q9yYgeFFX+uYApeVR69MSmpm3kFyqRjh7+MlJpUiBvhf
 qt3+8nXCBsc8ZVaoQNdO/n7ydEFoq3KzLvkRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k05Y4e+PrHzSfY5WD7UasfT68aLf+beRaOmVJAx50IE=;
 b=zpi+/DPRnD/WUQUIRIymgklNonMKapZpj5SvDWin+eqyGdFwecvJTQEhKw40sFrWQB
 2eH72R4uxsPLSw+WyGJ36DB3/6ydISnOYqaDe4suCtsdbytZ6Hqqy4+phqedHzYKFukK
 l9hujmBeSP8EZEg+b0bfcu5OUtrfmBvUsbsSeM9sl94rzAqaVMqjI2MgPSURpYvJAjKR
 tJA+MQbtVw6BB1T5KEQNeL3jdZkZV9+dNMyKmUrJxlDzP08gHd5Obt7eflwaw1ZaK85O
 ffELukxcWEOexoFNi7jPsLOHT92kshi+vWMmP/4HlPYg7pE4kQ0TM8YPhm01ZxEjqN6q
 6w8w==
X-Gm-Message-State: ACrzQf1xKFfNpSGKt8whco7H5WEdpW1yTEUgdg8mfoJ4fYHohoak7ET8
 9WUA0bTHYTErNGQm9FtpCKBDPnNMuvSVXdUqnoOdrQ==
X-Google-Smtp-Source: AMsMyM7TUXJXcis8PmcF9tz+mPP8pp0mnUv/KZmZclnSef+BAXAmZIP+VqDuAGl+a0+0RYzgd/QOqiORrMVMDd6y2JE=
X-Received: by 2002:a92:d681:0:b0:2ff:573c:8d44 with SMTP id
 p1-20020a92d681000000b002ff573c8d44mr29932067iln.203.1667841961903; Mon, 07
 Nov 2022 09:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20221017172229.42269-1-dmitry.osipenko@collabora.com>
 <20221017172229.42269-19-dmitry.osipenko@collabora.com>
In-Reply-To: <20221017172229.42269-19-dmitry.osipenko@collabora.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 7 Nov 2022 18:25:50 +0100
Message-ID: <CAKMK7uFFwTfNYT2BrubYvUMrH4fEmtF=yJshUck3-gKYLGqxCg@mail.gmail.com>
Subject: Re: [PATCH v7 18/21] dma-buf: Move dma_buf_mmap() to dynamic locking
 specification
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Ruhl Michael J <michael.j.ruhl@intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Russell King <linux@armlinux.org.uk>, Daniel Stone <daniel@fooishbar.org>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Juergen Gross <jgross@suse.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 Tomi Valkeinen <tomba@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Rob Clark <robdclark@gmail.com>, Qiang Yu <yuq825@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
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

T24gTW9uLCAxNyBPY3QgMjAyMiBhdCAxOToyNSwgRG1pdHJ5IE9zaXBlbmtvCjxkbWl0cnkub3Np
cGVua29AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4KPiBNb3ZlIGRtYV9idWZfbW1hcCgpIGZ1bmN0
aW9uIHRvIHRoZSBkeW5hbWljIGxvY2tpbmcgc3BlY2lmaWNhdGlvbiBieQo+IHRha2luZyB0aGUg
cmVzZXJ2YXRpb24gbG9jay4gTmVpdGhlciBvZiB0aGUgdG9kYXkncyBkcml2ZXJzIHRha2UgdGhl
Cj4gcmVzZXJ2YXRpb24gbG9jayB3aXRoaW4gdGhlIG1tYXAoKSBjYWxsYmFjaywgaGVuY2UgaXQn
cyBzYWZlIHRvIGVuZm9yY2UKPiB0aGUgbG9ja2luZy4KPgo+IEFja2VkLWJ5OiBTdW1pdCBTZW13
YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgo+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9zaXBl
bmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KCkp1c3Qgbm90aWNlZCB0aGlzIHdo
aWxlIHJlYWRpbmcgY29kZSAuLi4gdGhpcyBwYXRjaCBzZWVtcyB0byBoYXZlCm1pc3NlZCBkbWFf
YnVmX21tYXBfaW50ZXJuYWwoKT8KCk1pZ2h0IGJlIGdvb2QgaWYgYXQgbGVhc3Qgc29tZSBkcml2
ZXJzIGdhaW4gYSBkbWFfcmVzdl9hc3NlcnRfaGVsZCBpbgp0aGF0IHBhdGggdG8gbWFrZSBzdXJl
IHdlJ3JlIG5vdCBxdWl0ZSB0aGlzIGJhZCwgdG9nZXRoZXIgd2l0aCBmaXhpbmcKdGhpcyBpc3N1
ZS4KLURhbmllbAoKPiAtLS0KPiAgZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYyB8IDggKysrKysr
Ky0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2ZXJzL2RtYS1idWYv
ZG1hLWJ1Zi5jCj4gaW5kZXggZjU0YzY0OWY5MjJhLi5mMTQ5YjM4NGY0ZGQgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwo+ICsrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEt
YnVmLmMKPiBAQCAtMTM5MCw2ICsxMzkwLDggQEAgRVhQT1JUX1NZTUJPTF9OU19HUEwoZG1hX2J1
Zl9lbmRfY3B1X2FjY2VzcywgRE1BX0JVRik7Cj4gIGludCBkbWFfYnVmX21tYXAoc3RydWN0IGRt
YV9idWYgKmRtYWJ1Ziwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCj4gICAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBsb25nIHBnb2ZmKQo+ICB7Cj4gKyAgICAgICBpbnQgcmV0Owo+ICsKPiAg
ICAgICAgIGlmIChXQVJOX09OKCFkbWFidWYgfHwgIXZtYSkpCj4gICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOwo+Cj4gQEAgLTE0MTAsNyArMTQxMiwxMSBAQCBpbnQgZG1hX2J1Zl9tbWFw
KHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+ICAg
ICAgICAgdm1hX3NldF9maWxlKHZtYSwgZG1hYnVmLT5maWxlKTsKPiAgICAgICAgIHZtYS0+dm1f
cGdvZmYgPSBwZ29mZjsKPgo+IC0gICAgICAgcmV0dXJuIGRtYWJ1Zi0+b3BzLT5tbWFwKGRtYWJ1
Ziwgdm1hKTsKPiArICAgICAgIGRtYV9yZXN2X2xvY2soZG1hYnVmLT5yZXN2LCBOVUxMKTsKPiAr
ICAgICAgIHJldCA9IGRtYWJ1Zi0+b3BzLT5tbWFwKGRtYWJ1Ziwgdm1hKTsKPiArICAgICAgIGRt
YV9yZXN2X3VubG9jayhkbWFidWYtPnJlc3YpOwo+ICsKPiArICAgICAgIHJldHVybiByZXQ7Cj4g
IH0KPiAgRVhQT1JUX1NZTUJPTF9OU19HUEwoZG1hX2J1Zl9tbWFwLCBETUFfQlVGKTsKPgo+IC0t
Cj4gMi4zNy4zCj4KCgotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwg
Q29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
