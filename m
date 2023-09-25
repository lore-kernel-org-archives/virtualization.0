Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766DDCE7A98
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 14:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB38641598;
	Mon, 25 Sep 2023 14:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB38641598
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UtIyXlZB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LhPOx-pe-6xF; Mon, 25 Sep 2023 14:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C86940185;
	Mon, 25 Sep 2023 14:14:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C86940185
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30288C0071;
	Mon, 25 Sep 2023 14:14:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB397C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9943741598
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:14:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9943741598
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-d8qixnn-6O
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:14:40 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 793BE40185
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:14:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 793BE40185
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1dd5b98d9aeso214564fac.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695651279; x=1696256079;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJfyUt1ShfjZl6t8cnVtNZYV0Rqi3aBl3H7mr80x/Gw=;
 b=UtIyXlZBtes5PcdLrcYH+9xJxD4LZizmfH3ydELX5pwUKGp/hMjlWMzGZmpX7dn7d+
 +s/v1fWHWRGu2ckyY6piWfdZ+pUS/h1CtvTnMRviamSE/6Sr7/0j+9YpOTKVF383RG82
 vHIlXxEJX6llZ/B/RKPE7wahNBHX9rpWi3W5lSa4loYmMxO78ZPMMdp4tWr5ZcV43W6r
 TViyepK4wDeYEm+UsxEE6hi3C18Fc+ByfYtv06iK0h2xuAWcbogGfd5liad062H2TSLh
 iekHM62kumL3aRRVPZzR05OQa5wcJTAqRvIr586fYy4MJrkJow31j+tIRJq+jNAhl2LD
 1YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695651279; x=1696256079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJfyUt1ShfjZl6t8cnVtNZYV0Rqi3aBl3H7mr80x/Gw=;
 b=O2AEL9XUbexrgWXww4taN5YLTbgfd4id5MGd8C6u2CwJmoAkSbVH6xbAC3aRBFyJXk
 nY0+JJKYS+UmpgDm381eS7KQUxrHpwlmrtVmNPFWBuqp0AoiUYm4suj8wMB6XS7QN/d6
 PsU+9MlluiqogOPiSgOwgGL/uvy0SuHrAEDYtH9eD4oltU8M0UWiFoDFc7hDU8MGzy9X
 4jEEqRAkloUDdliN5W2M/g14QVvsZKGI/cB8wiHeylFWI0l9XoxxGL+mQh3bRCBfn67e
 c3ELjdNpaCkZj+2BsnRRwT9HxmSDMu+AJPjbOdQDKE2ASOz8WiEauG8K6wN8d03ze1LL
 zCgQ==
X-Gm-Message-State: AOJu0Yz3kq1z/xXa4dZ26TXVOVOgCqxkM7O9C+/f0XxxYIbJlyKJkJ6o
 qvjMgdLax0V0SOLtCK0teqKrO606mnCBA4n5R0g=
X-Google-Smtp-Source: AGHT+IGzozeIAKQxxu15vnXC4O0U2/wFx2Ttdhu1Ykj7GBRveGIst2ctDf9dvYvaREsBKdttLh7p7tRIuZBiTVLnOX8=
X-Received: by 2002:a05:6871:c10:b0:1dc:dcf9:18d8 with SMTP id
 ve16-20020a0568710c1000b001dcdcf918d8mr4061353oab.24.1695651279489; Mon, 25
 Sep 2023 07:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-1-keescook@chromium.org>
 <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
 <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
 <CADnq5_P1tg2-rWUmsRAy3aPJLT7ZmaZORMSOrPa6t6oSc5xS3g@mail.gmail.com>
In-Reply-To: <CADnq5_P1tg2-rWUmsRAy3aPJLT7ZmaZORMSOrPa6t6oSc5xS3g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Sep 2023 10:14:28 -0400
Message-ID: <CADnq5_P3xDDi-MS2PkAA7paAOQ3f7DQ8+sL6W7O5HcWTFQ0BSg@mail.gmail.com>
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMTA6MDfigK9BTSBBbGV4IERldWNoZXIgPGFsZXhkZXVj
aGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIFNlcCAyNSwgMjAyMyBhdCAyOjMw4oCv
QU0gQ2hyaXN0aWFuIEvDtm5pZwo+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+
ID4KPiA+IEFtIDIyLjA5LjIzIHVtIDE5OjQxIHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+ID4gPiBP
biBGcmksIFNlcCAyMiwgMjAyMyBhdCAxOjMy4oCvUE0gS2VlcyBDb29rIDxrZWVzY29va0BjaHJv
bWl1bS5vcmc+IHdyb3RlOgo+ID4gPj4gUHJlcGFyZSBmb3IgdGhlIGNvbWluZyBpbXBsZW1lbnRh
dGlvbiBieSBHQ0MgYW5kIENsYW5nIG9mIHRoZSBfX2NvdW50ZWRfYnkKPiA+ID4+IGF0dHJpYnV0
ZS4gRmxleGlibGUgYXJyYXkgbWVtYmVycyBhbm5vdGF0ZWQgd2l0aCBfX2NvdW50ZWRfYnkgY2Fu
IGhhdmUKPiA+ID4+IHRoZWlyIGFjY2Vzc2VzIGJvdW5kcy1jaGVja2VkIGF0IHJ1bi10aW1lIGNo
ZWNraW5nIHZpYSBDT05GSUdfVUJTQU5fQk9VTkRTCj4gPiA+PiAoZm9yIGFycmF5IGluZGV4aW5n
KSBhbmQgQ09ORklHX0ZPUlRJRllfU09VUkNFIChmb3Igc3RyY3B5L21lbWNweS1mYW1pbHkKPiA+
ID4+IGZ1bmN0aW9ucykuCj4gPiA+Pgo+ID4gPj4gQXMgZm91bmQgd2l0aCBDb2NjaW5lbGxlWzFd
LCBhZGQgX19jb3VudGVkX2J5IGZvciBzdHJ1Y3Qgc211MTBfdm9sdGFnZV9kZXBlbmRlbmN5X3Rh
YmxlLgo+ID4gPj4KPiA+ID4+IFsxXSBodHRwczovL2dpdGh1Yi5jb20va2Vlcy9rZXJuZWwtdG9v
bHMvYmxvYi90cnVuay9jb2NjaW5lbGxlL2V4YW1wbGVzL2NvdW50ZWRfYnkuY29jY2kKPiA+ID4+
Cj4gPiA+PiBDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPiA+ID4+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiA+PiBDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiA+PiBDYzogIlBhbiwgWGlu
aHVpIiA8WGluaHVpLlBhbkBhbWQuY29tPgo+ID4gPj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBnbWFpbC5jb20+Cj4gPiA+PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+
ID4gPj4gQ2M6IFhpYW9qaWFuIER1IDxYaWFvamlhbi5EdUBhbWQuY29tPgo+ID4gPj4gQ2M6IEh1
YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gPiA+PiBDYzogS2V2aW4gV2FuZyA8a2V2aW4x
LndhbmdAYW1kLmNvbT4KPiA+ID4+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
ID4gPj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+ID4+IFNpZ25lZC1v
ZmYtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPgo+ID4gPiBBY2tlZC1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4KPiA+IE1obSwgSSdt
IG5vdCBzdXJlIGlmIHRoaXMgaXMgYSBnb29kIGlkZWEuIFRoYXQgaXMgYSBzdHJ1Y3R1cmUgZmls
bGVkIGluCj4gPiBieSB0aGUgZmlybXdhcmUsIGlzbid0IGl0Pwo+ID4KPiA+IFRoYXQgd291bGQg
aW1wbHkgdGhhdCB3ZSBtaWdodCBuZWVkIHRvIGJ5dGUgc3dhcCBjb3VudCBiZWZvcmUgaXQgaXMK
PiA+IGNoZWNrYWJsZS4KPgo+IFRydWUuIEdvb2QgcG9pbnQuICBTYW1lIGZvciB0aGUgb3RoZXIg
YW1kZ3B1IHBhdGNoLgoKQWN0dWFsbHkgdGhlIG90aGVyIHBhdGNoIGlzIGZpbmUuICBUaGF0J3Mg
anVzdCBhIGxvY2FsIHN0cnVjdHVyZS4KCkFsZXgKCj4KPiBBbGV4Cj4KPiA+Cj4gPiBSZWdhcmRz
LAo+ID4gQ2hyaXN0aWFuLgo+ID4KPiA+ID4KPiA+ID4+IC0tLQo+ID4gPj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5oIHwgMiArLQo+ID4gPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+ID4+Cj4g
PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Iv
c211MTBfaHdtZ3IuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3Nt
dTEwX2h3bWdyLmgKPiA+ID4+IGluZGV4IDgwOGUwZWNiZTFmMC4uNDJhZGMyYTNkY2JjIDEwMDY0
NAo+ID4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211
MTBfaHdtZ3IuaAo+ID4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkv
aHdtZ3Ivc211MTBfaHdtZ3IuaAo+ID4gPj4gQEAgLTE5Miw3ICsxOTIsNyBAQCBzdHJ1Y3Qgc211
MTBfY2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5X3JlY29yZCB7Cj4gPiA+Pgo+ID4gPj4gICBzdHJ1
Y3Qgc211MTBfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlIHsKPiA+ID4+ICAgICAgICAgIHVpbnQz
Ml90IGNvdW50Owo+ID4gPj4gLSAgICAgICBzdHJ1Y3Qgc211MTBfY2xvY2tfdm9sdGFnZV9kZXBl
bmRlbmN5X3JlY29yZCBlbnRyaWVzW107Cj4gPiA+PiArICAgICAgIHN0cnVjdCBzbXUxMF9jbG9j
a192b2x0YWdlX2RlcGVuZGVuY3lfcmVjb3JkIGVudHJpZXNbXSBfX2NvdW50ZWRfYnkoY291bnQp
Owo+ID4gPj4gICB9Owo+ID4gPj4KPiA+ID4+ICAgc3RydWN0IHNtdTEwX2Nsb2NrX3ZvbHRhZ2Vf
aW5mb3JtYXRpb24gewo+ID4gPj4gLS0KPiA+ID4+IDIuMzQuMQo+ID4gPj4KPiA+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
