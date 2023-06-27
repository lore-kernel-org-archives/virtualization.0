Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C98EB64D9
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 12:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E210840176;
	Tue, 27 Jun 2023 12:01:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E210840176
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UC0GItNxGrvB; Tue, 27 Jun 2023 12:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E06E40122;
	Tue, 27 Jun 2023 12:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E06E40122
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23276C0072;
	Tue, 27 Jun 2023 12:01:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFA09C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 12:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A28941A49
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 12:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A28941A49
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O9WeKrJZxicO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 12:01:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB71C41A43
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB71C41A43
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 12:01:49 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-57338656a8aso35452437b3.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 05:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867308; x=1690459308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaDvMAxfFXfyEZM4SJAuMBnx36vSWVo7HcR7XHEqTMs=;
 b=Y0AR05W05uks1Gyh3b7v7J4J2RKvptMC4ak76R39lecBZKIiROVDYNlZ9Eo+bHyc4/
 MhA1T2/RaW5G5tinnpFQFZ4mCUOnr8fnbWqYQZ33/aYF/DvrNYYJhNpdrI0Fol4iexNN
 xL5SyYRviDvTvgfR285dB2nxi36O2CxPIOvZxi7n8Y87/Wn3D+fFRzNHINnlKSGJlepx
 8QljBRil9a6dTbAHTdBq6thpSED1asS1NqSHOFCR+QvFqdj4P9jCieVYuw45gLeKU1gw
 lnTJZaN24JpqeRtxlPhIRobxBqi1Y9IPCafK/3R2Dy/7+kHFaLPLD1wV1SB8EzQCx1U9
 wsIQ==
X-Gm-Message-State: AC+VfDy89vOmJRzzaFahYSeL8AgXCpn9uQ6k+UZ61Mw82qtwARRgj/aw
 Qj+2TR8dsOk/Y3GV9c/aYHLQjfmA2+mIn9+U
X-Google-Smtp-Source: ACHHUZ4yuid35v+jd1r9UnGEcXgaW81JQEo4wiOZP5W/jFL9P0DPRFNpJjE/Jiap2s+cq5stpRxGTw==
X-Received: by 2002:a81:7bd5:0:b0:565:9fc5:f0a1 with SMTP id
 w204-20020a817bd5000000b005659fc5f0a1mr27713282ywc.36.1687867308564; 
 Tue, 27 Jun 2023 05:01:48 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com.
 [209.85.219.170]) by smtp.gmail.com with ESMTPSA id
 h126-20020a0dde84000000b00576e5af0249sm514775ywe.20.2023.06.27.05.01.46
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:01:47 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-bff89873d34so2970234276.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 05:01:46 -0700 (PDT)
X-Received: by 2002:a25:f802:0:b0:b9e:712f:4a17 with SMTP id
 u2-20020a25f802000000b00b9e712f4a17mr22534779ybd.6.1687867306425; Tue, 27 Jun
 2023 05:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com>
 <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
 <0ca8034d-0377-26b9-51c8-8caff6c4174a@collabora.com>
 <CAMuHMdWfE=6xFsYFv=mCACpwZp45AiCzFxEB=suEFBhv9ry5aw@mail.gmail.com>
 <2f4d3e96-1e10-3662-bfc5-8c361a4c1366@collabora.com>
In-Reply-To: <2f4d3e96-1e10-3662-bfc5-8c361a4c1366@collabora.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Jun 2023 14:01:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV924gJs1X1nMUbQ5LEbFe8hrrXgxxvgZ_dXf95O0bK5Q@mail.gmail.com>
Message-ID: <CAMuHMdV924gJs1X1nMUbQ5LEbFe8hrrXgxxvgZ_dXf95O0bK5Q@mail.gmail.com>
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

SGkgRG1pdHJ5LAoKT24gTW9uLCBKdW4gMjYsIDIwMjMgYXQgNjoxMeKAr1BNIERtaXRyeSBPc2lw
ZW5rbwo8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+IE9uIDYvMjUvMjMg
MTg6MzYsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToKPiA+IE9uIFN1biwgSnVuIDI1LCAyMDIz
IGF0IDI6NDHigK9QTSBEbWl0cnkgT3NpcGVua28KPiA+IDxkbWl0cnkub3NpcGVua29AY29sbGFi
b3JhLmNvbT4gd3JvdGU6Cj4gPj4gT24gNi8yNS8yMyAxMTo0NywgR2VlcnQgVXl0dGVyaG9ldmVu
IHdyb3RlOgo+ID4+PiBPbiBTdW4sIEFwciAxNiwgMjAyMyBhdCAxOjU14oCvUE0gRG1pdHJ5IE9z
aXBlbmtvCj4gPj4+IDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gPj4+
PiBBZGQgc3luYyBvYmplY3QgRFJNIFVBUEkgc3VwcG9ydCB0byBWaXJ0SU8tR1BVIGRyaXZlci4g
U3luYyBvYmplY3RzCj4gPj4+PiBzdXBwb3J0IGlzIG5lZWRlZCBieSBuYXRpdmUgY29udGV4dCBW
aXJ0SU8tR1BVIE1lc2EgZHJpdmVycywgaXQgYWxzbyB3aWxsCj4gPj4+PiBiZSB1c2VkIGJ5IFZl
bnVzIGFuZCBWaXJnbCBjb250ZXh0cy4KPiA+Pj4+Cj4gPj4+PiBSZXZpZXdlZC1ieTsgRW1pbCBW
ZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6
IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+Cj4gPj4+Cj4g
Pj4+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCEKPiA+Pj4KPiA+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS92aXJ0aW8vdmlydGdwdV9zdWJtaXQuYwo+ID4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3ZpcnRpby92aXJ0Z3B1X3N1Ym1pdC5jCj4gPj4+Cj4gPj4+PiArc3RhdGljIGludAo+ID4+Pj4g
K3ZpcnRpb19ncHVfcGFyc2VfZGVwcyhzdHJ1Y3QgdmlydGlvX2dwdV9zdWJtaXQgKnN1Ym1pdCkK
PiA+Pj4+ICt7Cj4gPj4+PiArICAgICAgIHN0cnVjdCBkcm1fdmlydGdwdV9leGVjYnVmZmVyICpl
eGJ1ZiA9IHN1Ym1pdC0+ZXhidWY7Cj4gPj4+PiArICAgICAgIHN0cnVjdCBkcm1fdmlydGdwdV9l
eGVjYnVmZmVyX3N5bmNvYmogc3luY29ial9kZXNjOwo+ID4+Pj4gKyAgICAgICBzaXplX3Qgc3lu
Y29ial9zdHJpZGUgPSBleGJ1Zi0+c3luY29ial9zdHJpZGU7Cj4gPj4+PiArICAgICAgIHUzMiBu
dW1faW5fc3luY29ianMgPSBleGJ1Zi0+bnVtX2luX3N5bmNvYmpzOwo+ID4+Pj4gKyAgICAgICBz
dHJ1Y3QgZHJtX3N5bmNvYmogKipzeW5jb2JqczsKPiA+Pj4+ICsgICAgICAgaW50IHJldCA9IDAs
IGk7Cj4gPj4+PiArCj4gPj4+PiArICAgICAgIGlmICghbnVtX2luX3N5bmNvYmpzKQo+ID4+Pj4g
KyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4+Pj4gKwo+ID4+Pj4gKyAgICAgICAvKgo+ID4+
Pj4gKyAgICAgICAgKiBrdmFsbG9jIGF0IGZpcnN0IHRyaWVzIHRvIGFsbG9jYXRlIG1lbW9yeSB1
c2luZyBrbWFsbG9jIGFuZAo+ID4+Pj4gKyAgICAgICAgKiBmYWxscyBiYWNrIHRvIHZtYWxsb2Mg
b25seSBvbiBmYWlsdXJlLiBJdCBhbHNvIHVzZXMgR0ZQX05PV0FSTgo+ID4+Pgo+ID4+PiBHRlBf
Tk9XQVJOIGRvZXMgbm90IGV4aXN0Lgo+ID4+Cj4gPj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjYuNC1yYzcvc291cmNlL2luY2x1ZGUvbGludXgvZ2ZwX3R5cGVzLmgjTDM4Cj4g
Pgo+ID4gVGhhdCBsaW5lIGRlZmluZXMgIl9fR0ZQX05PV0FSTiIsIG5vdCAiR0ZQX05PV0FSTiIu
Cj4gPiBDIGlzIGNhc2UtIGFuZCB1bmRlcnNjb3JlLXNlbnNpdGl2ZS4gYXMgaXMgImdpdCBncmVw
IC13IiA7LSkKPgo+IFRoZSByZW1vdmFsIG9mIHVuZGVyc2NvcmVzIHdhcyBkb25lIGludGVudGlv
bmFsbHkgZm9yIGltcHJvdmluZwo+IHJlYWRhYmlsaXR5IG9mIHRoZSBjb21tZW50CgpQbGVhc2Ug
ZG9uJ3QgZG8gdGhhdCwgYXMgSU1ITyBpdCBhY3R1YWxseSBoYW1wZXJzIHJlYWRhYmlsaXR5Ogog
IDEuIEZvciBzb21lIHh4eCwgYm90aCBHRlBfeHh4IGFuZCBfX0dGUF94eHggYXJlIGRlZmluZWQs
CiAgICAgc28gaXQgZG9lcyBtYXR0ZXIgd2hpY2ggb25lIHlvdSBhcmUgcmVmZXJyaW5nIHRvLAog
IDIuIEFmdGVyIGRyb3BwaW5nIHRoZSB1bmRlcnNjb3JlcywgImdpdCBncmVwIC13IiBjYW4gbm8g
bG9uZ2VyIGZpbmQKICAgICB0aGUgZGVmaW5pdGlvbiwgbm9yIGl0cyB1c2Vycy4KClRoYW5rcyEK
Ckdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApH
ZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0t
IGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVj
aG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtp
bmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxp
a2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxk
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
