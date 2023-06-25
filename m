Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A38EB64DD
	for <virtualization@archiver.kernel.org>; Sun, 25 Jun 2023 08:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6685E41604;
	Sun, 25 Jun 2023 08:47:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6685E41604
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJjhPFzHd3fj; Sun, 25 Jun 2023 08:47:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 97EB9415E3;
	Sun, 25 Jun 2023 08:47:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97EB9415E3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 589EDC0037;
	Sun, 25 Jun 2023 08:47:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD9AC0029
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 08:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76552404B4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 08:47:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76552404B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2sLU1CNcEfr3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 08:47:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35FD34025D
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35FD34025D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 08:47:28 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-57040e313c5so34881477b3.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 01:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687682847; x=1690274847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jT0thIwO68HESVXBQpbJg4htP276Ynn85luHFgMgvjM=;
 b=fufIeqVh53Or5RU68LwojYhA1+cmJJBnjgs7WjRKn3jKSfP+K0G0GKolxw65qNK07A
 p09kk/cX4z9bFogdRTAs83WLx0pQ0cK2OlDfG2bN6P3xZHtlk6LMRDZcVMXMN45hrHrr
 dUlHFOQZPDvF9b3H3UB25NFoT9eLjY3YSsfPGpgmBaT29v0H9Y0YD/FFHIYBIseTPwxf
 gH49RwItOHLNZaau70dnXYWiBDMAxDr6zz0lANpv1Hhwpj6mBgopKhni8i87xHJItmq8
 oEiXzFT3wuPglo2b3bt4WybhEy9b+tATnqBNmxXtPJy83FQD3UTIhh8yWK5ki/iCBFtq
 3keQ==
X-Gm-Message-State: AC+VfDwgdKy6hPTlFL2qoU6vWIFkTBuwlSTKtI50o3DcvoyKBnG6/R7T
 Zp7PPtZhAcMWm8GdMJsd59gd7QGtk9CxuQ==
X-Google-Smtp-Source: ACHHUZ6qd8Njq2O+wef+XskmJNM9wwjsanCgMYs+M6LVZe+sOu8TU6sTWYUS+6d7S870hfhe3ZFQkw==
X-Received: by 2002:a0d:db87:0:b0:56d:c8d:be26 with SMTP id
 d129-20020a0ddb87000000b0056d0c8dbe26mr26817777ywe.26.1687682846968; 
 Sun, 25 Jun 2023 01:47:26 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com.
 [209.85.219.180]) by smtp.gmail.com with ESMTPSA id
 a63-20020a818a42000000b0056cd44f9f23sm721418ywg.63.2023.06.25.01.47.26
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 01:47:26 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-c1aad78d5b2so675665276.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 01:47:26 -0700 (PDT)
X-Received: by 2002:a25:1046:0:b0:bc7:7fe4:afbc with SMTP id
 67-20020a251046000000b00bc77fe4afbcmr11054044ybq.20.1687682845949; Sun, 25
 Jun 2023 01:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <20230416115237.798604-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20230416115237.798604-4-dmitry.osipenko@collabora.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 25 Jun 2023 10:47:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
Message-ID: <CAMuHMdVrJsmQx8X-_Tnxir9W752Mdh8ye7ob2srtY+6HFDEMGw@mail.gmail.com>
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

SGkgRG1pdHJ5LAoKT24gU3VuLCBBcHIgMTYsIDIwMjMgYXQgMTo1NeKAr1BNIERtaXRyeSBPc2lw
ZW5rbwo8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+IEFkZCBzeW5jIG9i
amVjdCBEUk0gVUFQSSBzdXBwb3J0IHRvIFZpcnRJTy1HUFUgZHJpdmVyLiBTeW5jIG9iamVjdHMK
PiBzdXBwb3J0IGlzIG5lZWRlZCBieSBuYXRpdmUgY29udGV4dCBWaXJ0SU8tR1BVIE1lc2EgZHJp
dmVycywgaXQgYWxzbyB3aWxsCj4gYmUgdXNlZCBieSBWZW51cyBhbmQgVmlyZ2wgY29udGV4dHMu
Cj4KPiBSZXZpZXdlZC1ieTsgRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xs
YWJvcmEuY29tPgoKVGhhbmtzIGZvciB5b3VyIHBhdGNoIQoKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vdmlydGlvL3ZpcnRncHVfc3VibWl0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdmlydGlv
L3ZpcnRncHVfc3VibWl0LmMKCj4gK3N0YXRpYyBpbnQKPiArdmlydGlvX2dwdV9wYXJzZV9kZXBz
KHN0cnVjdCB2aXJ0aW9fZ3B1X3N1Ym1pdCAqc3VibWl0KQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3Qg
ZHJtX3ZpcnRncHVfZXhlY2J1ZmZlciAqZXhidWYgPSBzdWJtaXQtPmV4YnVmOwo+ICsgICAgICAg
c3RydWN0IGRybV92aXJ0Z3B1X2V4ZWNidWZmZXJfc3luY29iaiBzeW5jb2JqX2Rlc2M7Cj4gKyAg
ICAgICBzaXplX3Qgc3luY29ial9zdHJpZGUgPSBleGJ1Zi0+c3luY29ial9zdHJpZGU7Cj4gKyAg
ICAgICB1MzIgbnVtX2luX3N5bmNvYmpzID0gZXhidWYtPm51bV9pbl9zeW5jb2JqczsKPiArICAg
ICAgIHN0cnVjdCBkcm1fc3luY29iaiAqKnN5bmNvYmpzOwo+ICsgICAgICAgaW50IHJldCA9IDAs
IGk7Cj4gKwo+ICsgICAgICAgaWYgKCFudW1faW5fc3luY29ianMpCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOwo+ICsKPiArICAgICAgIC8qCj4gKyAgICAgICAgKiBrdmFsbG9jIGF0IGZpcnN0
IHRyaWVzIHRvIGFsbG9jYXRlIG1lbW9yeSB1c2luZyBrbWFsbG9jIGFuZAo+ICsgICAgICAgICog
ZmFsbHMgYmFjayB0byB2bWFsbG9jIG9ubHkgb24gZmFpbHVyZS4gSXQgYWxzbyB1c2VzIEdGUF9O
T1dBUk4KCkdGUF9OT1dBUk4gZG9lcyBub3QgZXhpc3QuCgo+ICsgICAgICAgICogaW50ZXJuYWxs
eSBmb3IgYWxsb2NhdGlvbnMgbGFyZ2VyIHRoYW4gYSBwYWdlIHNpemUsIHByZXZlbnRpbmcKPiAr
ICAgICAgICAqIHN0b3JtIG9mIEtNU0cgd2FybmluZ3MuCj4gKyAgICAgICAgKi8KPiArICAgICAg
IHN5bmNvYmpzID0ga3ZjYWxsb2MobnVtX2luX3N5bmNvYmpzLCBzaXplb2YoKnN5bmNvYmpzKSwg
R0ZQX0tFUk5FTCk7Cj4gKyAgICAgICBpZiAoIXN5bmNvYmpzKQo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gLUVOT01FTTsKPiArCj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnVtX2luX3N5bmNv
YmpzOyBpKyspIHsKPiArICAgICAgICAgICAgICAgdTY0IGFkZHJlc3MgPSBleGJ1Zi0+aW5fc3lu
Y29ianMgKyBpICogc3luY29ial9zdHJpZGU7Cj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBkbWFf
ZmVuY2UgKmZlbmNlOwo+ICsKCkdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAg
ICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExp
bnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252
ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4g
QnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1l
ciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtLSBMaW51cyBUb3J2YWxkcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
