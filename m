Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42759CE7AB4
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 17:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB5FC6124A;
	Mon, 25 Sep 2023 17:56:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB5FC6124A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z4WlA0Ki
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xCJOwle2TzdU; Mon, 25 Sep 2023 17:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4523860B9F;
	Mon, 25 Sep 2023 17:56:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4523860B9F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D001C0039;
	Mon, 25 Sep 2023 17:56:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2194DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EED3741B14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:56:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EED3741B14
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=Z4WlA0Ki
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5RuCI_kuroZZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:56:28 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 104CB41B13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:56:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 104CB41B13
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1c4c5375329so3839462fac.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695664587; x=1696269387;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1F9rg4X23ujFzzgF5l8L8aKk/znEnb8MB1jEXGz6ng=;
 b=Z4WlA0KiqOvC7hLWcrondRu8NNshDF77eVAt4k3pRUQL6EZnj3SI3SMwFX4033vmqS
 5fghWpGAZvUMypkgtiCxPFi4imtSoEiljFckba2ED062eoXFnuC8WAutTHzD19tX4lsX
 qGVX6m7YX2J7uVVxogiiPfWuvNUAgIZCOr1wvPG+OmeTWfhIahIp9hHK8G4121fyIobL
 9QoUD3jXiG74UVq4NoJT2+YlltA44tarX5ADBp3fJvkvwZq93g3/D/rz5JOi/svhqF6T
 CUz+qbRsSRkIKp1LRldQUGXl07ABFKD9Jlte20JKQlu6nkuC5MOCgko74k/JwCoiaUkV
 tZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664587; x=1696269387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1F9rg4X23ujFzzgF5l8L8aKk/znEnb8MB1jEXGz6ng=;
 b=BKh/O+UGkf1oDzh/ZM1FBDOqW030RpWYKfSGCtZ8vlkNAgVuKgfvUHHEj7OlafRDFm
 2Uk2hDIqSkbgBVvc/AxSSK+20K+QJFS7ENvjqFoZtokkYIQS0rAEWxJy2xgy7sguZU7m
 Bh5HFVeqr/Sr/KnXxN1vXEiXTK182FqsJizZ2dfGUU4IyIxuNReiGAdWhDmcgMrkj10f
 oGNOUmVufooiaZS74pv34dx2rG9TcgwpN9P/l853R+nedFw8MDYOzMdtVaW/jBF1/G70
 ATXo5c8BeIONKEN9q5iSjM9bE4pLD1tIJxumMVMT7bsYCiow7RnZXZpDb6ZlHHX/6Y5z
 sOow==
X-Gm-Message-State: AOJu0YyBzPTeMj/YQ/FbsIDikqbwFRYA92JJDQ7q3hrPDINqYg/+MQKC
 PryWJp+XoiAwjeKpUnV46hCUxqO3cdOYUA1ZbUw=
X-Google-Smtp-Source: AGHT+IHKGmpSNoLKRlPKgMz3PfLu9l0asTJ/KJeRR4YlCqKx/0xgmJzaJCWHK+NWln0berAZsxELHx2SNeMkUMNHpCU=
X-Received: by 2002:a05:6870:c227:b0:1db:3679:198a with SMTP id
 z39-20020a056870c22700b001db3679198amr8758871oae.24.1695664587047; Mon, 25
 Sep 2023 10:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-1-keescook@chromium.org>
 <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
 <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
 <202309251051.EE3ECE7B@keescook>
In-Reply-To: <202309251051.EE3ECE7B@keescook>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Sep 2023 13:56:16 -0400
Message-ID: <CADnq5_PaXmFa6N_2-NRp7_2+m3TYt8s--4aYm1UTnQKXDUhwYw@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct
 smu10_voltage_dependency_table with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Karol Herbst <kherbst@redhat.com>,
 Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Evan Quan <evan.quan@amd.com>, Emma Anholt <emma@anholt.net>,
 amd-gfx@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Maxime Ripard <mripard@kernel.org>,
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMTo1MuKAr1BNIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hy
b21pdW0ub3JnPiB3cm90ZToKPgo+IE9uIE1vbiwgU2VwIDI1LCAyMDIzIGF0IDA4OjMwOjMwQU0g
KzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gPiBBbSAyMi4wOS4yMyB1bSAxOTo0MSBz
Y2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+ID4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTozMuKA
r1BNIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPiB3cm90ZToKPiA+ID4gPiBQcmVw
YXJlIGZvciB0aGUgY29taW5nIGltcGxlbWVudGF0aW9uIGJ5IEdDQyBhbmQgQ2xhbmcgb2YgdGhl
IF9fY291bnRlZF9ieQo+ID4gPiA+IGF0dHJpYnV0ZS4gRmxleGlibGUgYXJyYXkgbWVtYmVycyBh
bm5vdGF0ZWQgd2l0aCBfX2NvdW50ZWRfYnkgY2FuIGhhdmUKPiA+ID4gPiB0aGVpciBhY2Nlc3Nl
cyBib3VuZHMtY2hlY2tlZCBhdCBydW4tdGltZSBjaGVja2luZyB2aWEgQ09ORklHX1VCU0FOX0JP
VU5EUwo+ID4gPiA+IChmb3IgYXJyYXkgaW5kZXhpbmcpIGFuZCBDT05GSUdfRk9SVElGWV9TT1VS
Q0UgKGZvciBzdHJjcHkvbWVtY3B5LWZhbWlseQo+ID4gPiA+IGZ1bmN0aW9ucykuCj4gPiA+ID4K
PiA+ID4gPiBBcyBmb3VuZCB3aXRoIENvY2NpbmVsbGVbMV0sIGFkZCBfX2NvdW50ZWRfYnkgZm9y
IHN0cnVjdCBzbXUxMF92b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUuCj4gPiA+ID4KPiA+ID4gPiBb
MV0gaHR0cHM6Ly9naXRodWIuY29tL2tlZXMva2VybmVsLXRvb2xzL2Jsb2IvdHJ1bmsvY29jY2lu
ZWxsZS9leGFtcGxlcy9jb3VudGVkX2J5LmNvY2NpCj4gPiA+ID4KPiA+ID4gPiBDYzogRXZhbiBR
dWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPiA+ID4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gPiA+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+ID4gPiBDYzogIlBhbiwgWGluaHVpIiA8WGluaHVpLlBh
bkBhbWQuY29tPgo+ID4gPiA+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPgo+
ID4gPiA+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gPiA+ID4gQ2M6IFhp
YW9qaWFuIER1IDxYaWFvamlhbi5EdUBhbWQuY29tPgo+ID4gPiA+IENjOiBIdWFuZyBSdWkgPHJh
eS5odWFuZ0BhbWQuY29tPgo+ID4gPiA+IENjOiBLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0BhbWQu
Y29tPgo+ID4gPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gPiA+IENj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
S2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+Cj4gPiA+IEFja2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPgo+ID4gTWhtLCBJJ20gbm90IHN1
cmUgaWYgdGhpcyBpcyBhIGdvb2QgaWRlYS4gVGhhdCBpcyBhIHN0cnVjdHVyZSBmaWxsZWQgaW4g
YnkKPiA+IHRoZSBmaXJtd2FyZSwgaXNuJ3QgaXQ/Cj4gPgo+ID4gVGhhdCB3b3VsZCBpbXBseSB0
aGF0IHdlIG1pZ2h0IG5lZWQgdG8gYnl0ZSBzd2FwIGNvdW50IGJlZm9yZSBpdCBpcwo+ID4gY2hl
Y2thYmxlLgo+Cj4gVGhlIHNjcmlwdCBmb3VuZCB0aGlzIGluc3RhbmNlIGJlY2F1c2Ugb2YgdGhp
czoKPgo+IHN0YXRpYyBpbnQgc211MTBfZ2V0X2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJs
ZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBzbXUxMF92b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUgKipwcHRhYmxlLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90IG51bV9lbnRyeSwgY29uc3QgRHBtQ2xvY2tfdCAqcGNsa19k
ZXBlbmRlbmN5X3RhYmxlKQo+IHsKPiAgICAgICAgIHVpbnQzMl90IGk7Cj4gICAgICAgICBzdHJ1
Y3Qgc211MTBfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlICpwdGFibGU7Cj4KPiAgICAgICAgIHB0
YWJsZSA9IGt6YWxsb2Moc3RydWN0X3NpemUocHRhYmxlLCBlbnRyaWVzLCBudW1fZW50cnkpLCBH
RlBfS0VSTkVMKTsKPiAgICAgICAgIGlmIChOVUxMID09IHB0YWJsZSkKPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07Cj4KPiAgICAgICAgIHB0YWJsZS0+Y291bnQgPSBudW1fZW50cnk7
Cj4KPiBTbyB0aGUgaW1wbGljYXRpb24gaXMgdGhhdCBpdCdzIG5hdGl2ZSBieXRlIG9yZGVyLi4u
IGJ1dCB5b3UgdGVsbCBtZSEgSQo+IGNlcnRhaW5seSBkb24ndCB3YW50IHRoaXMgYW5ub3RhdGlv
biBpZiBpdCdzIGdvaW5nIHRvIGJyZWFrIHN0dWZmLiA6KQoKSW4gdGhpcyBjYXNlLCB0aGUgY29k
ZSBpcyBmb3IgYW4gaW50ZWdyYXRlZCBHUFUgaW4gYW4geDg2IENQVSBzbyB0aGUKZmlybXdhcmUg
YW5kIGRyaXZlciBlbmRpYW5uZXNzIG1hdGNoLiAgWW91IHdvdWxkbid0IGZpbmQgYSBzdGFuZCBh
bG9uZQpkR1BVIHRoYXQgdXNlcyB0aGlzIHN0cnVjdHVyZS4gIEluIHRoaXMgY2FzZSBpdCdzIG9r
LiAgRmFsc2UgYWxhcm0uCgpBbGV4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
