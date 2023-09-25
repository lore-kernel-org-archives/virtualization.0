Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F39DCE7A97
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 14:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C59E41A48;
	Mon, 25 Sep 2023 14:07:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C59E41A48
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nAmCp6HR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OLqPMlbooiHx; Mon, 25 Sep 2023 14:07:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4AAD541938;
	Mon, 25 Sep 2023 14:07:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AAD541938
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB33C0039;
	Mon, 25 Sep 2023 14:07:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E95FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68EF641974
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:07:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68EF641974
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ce7JsoDGUETu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:07:40 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FFB041938
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:07:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FFB041938
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1dcfe9cd337so1391451fac.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695650859; x=1696255659;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOm71FSa/a54JWdPxFTdFQYbsSYB0XKCvLJel7l+Bek=;
 b=nAmCp6HRZNp00hnIUqy/chr+3LUu3FgLIWFb/62I9FIhTKF1VwayGt5bPx2oa5OCpA
 ect3iSiisB3EGp4hzcuIe0JhrAq8UI07PAQ0AK3lkOdlMDsi8D0juqPmJv/Yv4k8ipwR
 6xP+KyO37RhOym9flon65MADF7WVgPymqtqY79djlqb3xEsKkcMWy0ysswM0LJ9Nxke9
 KWR4/sdA9C/E/PW5uPNypcZ0yWDcDcRoA8i/C49XlesURNlIHrVUB3Ix4juGYN//XA0O
 jzgq/GkmdNz9ByGbkdjJMJs2szq+gTRzPv96Kp2u+MbMb9T5yMMgr9mEgjGCMkXSp6xM
 DW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650859; x=1696255659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eOm71FSa/a54JWdPxFTdFQYbsSYB0XKCvLJel7l+Bek=;
 b=oXTbpBIA/gh0Ul0GBif5bSaW+WYwlwTPSBsaMT0+Oiiah0qR/RPhi9n0n7xlZvS/mz
 tsHoW8EXVhF18HeHjamuc3c4dpq5h6n3RtP1IeZx0Lk9qoAgiv3X6MYwMF2j5LMcMx+y
 oDZuVERW/4UQ4lAgHn/y769/evCynzH011Bb3AVm2oLTa01hJVmjRBgZUN2jWudqErZN
 wqfYe5fg+cKEIzdHnymqo9m6FYJizeW/jOZL7+BG1zUX7EaCzpZXfaNIfmCLDz94vr4e
 1+r9Xy+d/3qz4T9JoZVf8uRsbqOoG5+UXMRtaUNCtKDF5jMlSWJKHFYYi+zNXh8vcwRR
 ckAw==
X-Gm-Message-State: AOJu0Yzs6z6IK6AbPkZYh5+b0FLlwbFLi9ytjP0Em8F+C8+GSkG4ZvWH
 W1uxiEZehZt5EfdKD/xxXwwDfG359Mkcc+/rEVI=
X-Google-Smtp-Source: AGHT+IEAGihrK0Fxy+zmQS+jCavrD8i0S0F6RPaTyUWR0Tsr+swWkiWj17Z4gpkbPnpNw9W+uaTcvGPHY2GFxPPQ6jk=
X-Received: by 2002:a05:6870:b68b:b0:19e:fa1f:fc2f with SMTP id
 cy11-20020a056870b68b00b0019efa1ffc2fmr7668945oab.38.1695650859043; Mon, 25
 Sep 2023 07:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-1-keescook@chromium.org>
 <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
 <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
In-Reply-To: <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Sep 2023 10:07:27 -0400
Message-ID: <CADnq5_P1tg2-rWUmsRAy3aPJLT7ZmaZORMSOrPa6t6oSc5xS3g@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct
 smu10_voltage_dependency_table with __counted_by
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Evan Quan <evan.quan@amd.com>, Karol Herbst <kherbst@redhat.com>,
 amd-gfx@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Kees Cook <keescook@chromium.org>, Yifan Zhang <yifan1.zhang@amd.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Kevin Wang <kevin1.wang@amd.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Maxime Ripard <mripard@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>, Le Ma <le.ma@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 virtualization@lists.linux-foundation.org, Sean Paul <sean@poorly.run>,
 Neil Armstrong <neil.armstrong@linaro.org>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Bjorn Andersson <andersson@kernel.org>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Melissa Wen <mwen@igalia.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nirmoy Das <nirmoy.das@intel.com>, freedreno@lists.freedesktop.org,
 John Harrison <john.c.harrison@intel.com>, linux-hardening@vger.kernel.org
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMjozMOKAr0FNIENocmlzdGlhbiBLw7ZuaWcKPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAyMi4wOS4yMyB1bSAxOTo0MSBzY2hy
aWViIEFsZXggRGV1Y2hlcjoKPiA+IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDE6MzLigK9QTSBL
ZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4gd3JvdGU6Cj4gPj4gUHJlcGFyZSBmb3Ig
dGhlIGNvbWluZyBpbXBsZW1lbnRhdGlvbiBieSBHQ0MgYW5kIENsYW5nIG9mIHRoZSBfX2NvdW50
ZWRfYnkKPiA+PiBhdHRyaWJ1dGUuIEZsZXhpYmxlIGFycmF5IG1lbWJlcnMgYW5ub3RhdGVkIHdp
dGggX19jb3VudGVkX2J5IGNhbiBoYXZlCj4gPj4gdGhlaXIgYWNjZXNzZXMgYm91bmRzLWNoZWNr
ZWQgYXQgcnVuLXRpbWUgY2hlY2tpbmcgdmlhIENPTkZJR19VQlNBTl9CT1VORFMKPiA+PiAoZm9y
IGFycmF5IGluZGV4aW5nKSBhbmQgQ09ORklHX0ZPUlRJRllfU09VUkNFIChmb3Igc3RyY3B5L21l
bWNweS1mYW1pbHkKPiA+PiBmdW5jdGlvbnMpLgo+ID4+Cj4gPj4gQXMgZm91bmQgd2l0aCBDb2Nj
aW5lbGxlWzFdLCBhZGQgX19jb3VudGVkX2J5IGZvciBzdHJ1Y3Qgc211MTBfdm9sdGFnZV9kZXBl
bmRlbmN5X3RhYmxlLgo+ID4+Cj4gPj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9rZWVzL2tlcm5l
bC10b29scy9ibG9iL3RydW5rL2NvY2NpbmVsbGUvZXhhbXBsZXMvY291bnRlZF9ieS5jb2NjaQo+
ID4+Cj4gPj4gQ2M6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Cj4gPj4gQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+PiBDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPj4gQ2M6ICJQYW4sIFhpbmh1aSIg
PFhpbmh1aS5QYW5AYW1kLmNvbT4KPiA+PiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGdtYWls
LmNvbT4KPiA+PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+ID4+IENjOiBY
aWFvamlhbiBEdSA8WGlhb2ppYW4uRHVAYW1kLmNvbT4KPiA+PiBDYzogSHVhbmcgUnVpIDxyYXku
aHVhbmdAYW1kLmNvbT4KPiA+PiBDYzogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4K
PiA+PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+PiBDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4+IFNpZ25lZC1vZmYtYnk6IEtlZXMgQ29vayA8a2Vl
c2Nvb2tAY2hyb21pdW0ub3JnPgo+ID4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KPgo+IE1obSwgSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgYSBnb29k
IGlkZWEuIFRoYXQgaXMgYSBzdHJ1Y3R1cmUgZmlsbGVkIGluCj4gYnkgdGhlIGZpcm13YXJlLCBp
c24ndCBpdD8KPgo+IFRoYXQgd291bGQgaW1wbHkgdGhhdCB3ZSBtaWdodCBuZWVkIHRvIGJ5dGUg
c3dhcCBjb3VudCBiZWZvcmUgaXQgaXMKPiBjaGVja2FibGUuCgpUcnVlLiBHb29kIHBvaW50LiAg
U2FtZSBmb3IgdGhlIG90aGVyIGFtZGdwdSBwYXRjaC4KCkFsZXgKCj4KPiBSZWdhcmRzLAo+IENo
cmlzdGlhbi4KPgo+ID4KPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93
ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmggfCAyICstCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuaAo+ID4+IGluZGV4
IDgwOGUwZWNiZTFmMC4uNDJhZGMyYTNkY2JjIDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmgKPiA+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5oCj4gPj4gQEAg
LTE5Miw3ICsxOTIsNyBAQCBzdHJ1Y3Qgc211MTBfY2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5X3Jl
Y29yZCB7Cj4gPj4KPiA+PiAgIHN0cnVjdCBzbXUxMF92b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUg
ewo+ID4+ICAgICAgICAgIHVpbnQzMl90IGNvdW50Owo+ID4+IC0gICAgICAgc3RydWN0IHNtdTEw
X2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV9yZWNvcmQgZW50cmllc1tdOwo+ID4+ICsgICAgICAg
c3RydWN0IHNtdTEwX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV9yZWNvcmQgZW50cmllc1tdIF9f
Y291bnRlZF9ieShjb3VudCk7Cj4gPj4gICB9Owo+ID4+Cj4gPj4gICBzdHJ1Y3Qgc211MTBfY2xv
Y2tfdm9sdGFnZV9pbmZvcm1hdGlvbiB7Cj4gPj4gLS0KPiA+PiAyLjM0LjEKPiA+Pgo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
