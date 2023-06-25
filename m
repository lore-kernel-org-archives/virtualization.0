Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C62BC001B0
	for <virtualization@archiver.kernel.org>; Sun, 25 Jun 2023 15:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 185E9415F0;
	Sun, 25 Jun 2023 15:36:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 185E9415F0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YO0hm8OZ1W1Q; Sun, 25 Jun 2023 15:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3D312415C9;
	Sun, 25 Jun 2023 15:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D312415C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E1F5C007A;
	Sun, 25 Jun 2023 15:36:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 737E3C0029
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 15:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 469ED607EC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 15:36:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 469ED607EC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AkwkjIOZYCJP
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 15:36:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 716F560675
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 716F560675
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 15:36:21 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-576918f4cf7so15301957b3.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 08:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687707380; x=1690299380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6hADTvRtybxnAgwb/MiYU3LVBKmH7BajnYoRP9HcuU=;
 b=ZSqxxw+37AQehK6vnKX8IKPF1RF1qQptaEpEf2tkBU2NpOfkIDCbc9WJmPb+mA1d9R
 v/YIyTrEXa2fRjHVm1Lx8bFE2CC33pnE78pLiQ1PS1S0QcRK66bBG1lF7/d6fyOPaeM1
 mSlLdzjIAjWKVzbgYmmozmDKydB8FiKQvkVUVe5+NEC6/QxvlON8KptNgjzrrB7gPwvw
 JLsH0XfqSle+QUEnAPSLTUqugjjdeCyKqm4/Luj0tYsmW2LXX4T9n1xRY/tXSHHNdnoI
 w64RmtbxlfFkVpK77FrhC7VHIMjtbjIVOEHAuR6fTKn6TpbkE+AeAlpKMJxpyjKhpWKL
 /a9Q==
X-Gm-Message-State: AC+VfDw443GE+JeYlgdITdoFyjfSu7vqL10SV8HL2HXLombAxwAvvRui
 VjQejWp3VtVSbpvqe4PNwA3EYyFfLcNd8w==
X-Google-Smtp-Source: ACHHUZ5S7hk02ItmEKf46aOzGTf6MhRtSagtTtddORKJH/qMmbeiY2XPb3TNNZCZI7vR4wJhbXSyFQ==
X-Received: by 2002:a81:7109:0:b0:572:2759:c099 with SMTP id
 m9-20020a817109000000b005722759c099mr19882694ywc.52.1687707380133; 
 Sun, 25 Jun 2023 08:36:20 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com.
 [209.85.219.176]) by smtp.gmail.com with ESMTPSA id
 k63-20020a0dc842000000b0056cd3e598d8sm856631ywd.114.2023.06.25.08.36.18
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 08:36:19 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id
 3f1490d57ef6-bb3a77abd7bso2446955276.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 08:36:18 -0700 (PDT)
X-Received: by 2002:a0d:d649:0:b0:56d:c02:58a7 with SMTP id
 y70-20020a0dd649000000b0056d0c0258a7mr27473610ywd.18.1687707378531; Sun, 25
 Jun 2023 08:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com>
 <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
 <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com>
In-Reply-To: <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 25 Jun 2023 17:36:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
Message-ID: <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/virtio: Support sync objects
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
 Chia-I Wu <olvaffe@gmail.com>, Emil Velikov <emil.velikov@collabora.com>
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

SGkgRG1pdHJ5LAoKT24gU3VuLCBKdW4gMjUsIDIwMjMgYXQgMjo0MeKAr1BNIERtaXRyeSBPc2lw
ZW5rbwo8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+IE9uIDYvMjUvMjMg
MTE6NDcsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToKPiA+IE9uIFN1biwgQXByIDE2LCAyMDIz
IGF0IDE6NTXigK9QTSBEbWl0cnkgT3NpcGVua28KPiA+IDxkbWl0cnkub3NpcGVua29AY29sbGFi
b3JhLmNvbT4gd3JvdGU6Cj4gPj4gQWRkIHN5bmMgb2JqZWN0IERSTSBVQVBJIHN1cHBvcnQgdG8g
VmlydElPLUdQVSBkcml2ZXIuIFN5bmMgb2JqZWN0cwo+ID4+IHN1cHBvcnQgaXMgbmVlZGVkIGJ5
IG5hdGl2ZSBjb250ZXh0IFZpcnRJTy1HUFUgTWVzYSBkcml2ZXJzLCBpdCBhbHNvIHdpbGwKPiA+
PiBiZSB1c2VkIGJ5IFZlbnVzIGFuZCBWaXJnbCBjb250ZXh0cy4KPiA+Pgo+ID4+IFJldmlld2Vk
LWJ5OyBFbWlsIFZlbGlrb3YgPGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgo+ID4+IFNpZ25l
ZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+
Cj4gPgo+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQo+ID4KPiA+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vdmlydGlvL3ZpcnRncHVfc3VibWl0LmMKPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
dmlydGlvL3ZpcnRncHVfc3VibWl0LmMKPiA+Cj4gPj4gK3N0YXRpYyBpbnQKPiA+PiArdmlydGlv
X2dwdV9wYXJzZV9kZXBzKHN0cnVjdCB2aXJ0aW9fZ3B1X3N1Ym1pdCAqc3VibWl0KQo+ID4+ICt7
Cj4gPj4gKyAgICAgICBzdHJ1Y3QgZHJtX3ZpcnRncHVfZXhlY2J1ZmZlciAqZXhidWYgPSBzdWJt
aXQtPmV4YnVmOwo+ID4+ICsgICAgICAgc3RydWN0IGRybV92aXJ0Z3B1X2V4ZWNidWZmZXJfc3lu
Y29iaiBzeW5jb2JqX2Rlc2M7Cj4gPj4gKyAgICAgICBzaXplX3Qgc3luY29ial9zdHJpZGUgPSBl
eGJ1Zi0+c3luY29ial9zdHJpZGU7Cj4gPj4gKyAgICAgICB1MzIgbnVtX2luX3N5bmNvYmpzID0g
ZXhidWYtPm51bV9pbl9zeW5jb2JqczsKPiA+PiArICAgICAgIHN0cnVjdCBkcm1fc3luY29iaiAq
KnN5bmNvYmpzOwo+ID4+ICsgICAgICAgaW50IHJldCA9IDAsIGk7Cj4gPj4gKwo+ID4+ICsgICAg
ICAgaWYgKCFudW1faW5fc3luY29ianMpCj4gPj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+
ID4+ICsKPiA+PiArICAgICAgIC8qCj4gPj4gKyAgICAgICAgKiBrdmFsbG9jIGF0IGZpcnN0IHRy
aWVzIHRvIGFsbG9jYXRlIG1lbW9yeSB1c2luZyBrbWFsbG9jIGFuZAo+ID4+ICsgICAgICAgICog
ZmFsbHMgYmFjayB0byB2bWFsbG9jIG9ubHkgb24gZmFpbHVyZS4gSXQgYWxzbyB1c2VzIEdGUF9O
T1dBUk4KPiA+Cj4gPiBHRlBfTk9XQVJOIGRvZXMgbm90IGV4aXN0Lgo+Cj4gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNC1yYzcvc291cmNlL2luY2x1ZGUvbGludXgvZ2ZwX3R5
cGVzLmgjTDM4CgpUaGF0IGxpbmUgZGVmaW5lcyAiX19HRlBfTk9XQVJOIiwgbm90ICJHRlBfTk9X
QVJOIi4KQyBpcyBjYXNlLSBhbmQgdW5kZXJzY29yZS1zZW5zaXRpdmUuIGFzIGlzICJnaXQgZ3Jl
cCAtdyIgOy0pCgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAgIEdl
ZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlv
bmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9u
cyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVu
IEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNv
bWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGlu
dXMgVG9ydmFsZHMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
