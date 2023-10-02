Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80739E748FE
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 16:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1A9682192;
	Mon,  2 Oct 2023 16:53:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1A9682192
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XF5AoUr9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Stsirxu2VNPn; Mon,  2 Oct 2023 16:53:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B29682295;
	Mon,  2 Oct 2023 16:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B29682295
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B3B8C0039;
	Mon,  2 Oct 2023 16:53:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37EE8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 16:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0644882295
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 16:53:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0644882295
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id naMsMZTboLM2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 16:53:26 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1235282192
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 16:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1235282192
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso10663077b3a.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Oct 2023 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696265605; x=1696870405;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zPrUH5J+k/nTCuPqHTvyGlvTCCkInD9EOwhmWD637e8=;
 b=XF5AoUr9KNH5qeSplj1Dx6RNHNgmCoKqVxJIcVQQcDACg8yQ3OfiJDY5TWAeCk674s
 UTHGOfbpoG5yHRCoGNoG1BaMuHWFI9aBFxPVeJr/HWXJ/1HYnVgrfyD6bnebNo29QlOr
 zzahRBRcAoxW8+iuZzL+OZfUmphNndOcGnB/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696265605; x=1696870405;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zPrUH5J+k/nTCuPqHTvyGlvTCCkInD9EOwhmWD637e8=;
 b=hpeyJ2EVjC04w4ZH5xUShzn4olDlWIlJNcyX+CduOpjSwumXzA5SKxBA52OKWwd4bl
 UbEPYsAbU5Sp5S1WeHxnS1oW9gpLf3vY3fp6bpe3FBWWYbGbXkJSv8jDHRvHRwPhUS3A
 vJEkpyHYWgjlCnS6DZowoWXJlmaH3RthOlPwsQAnPg/X5iynfsUGVKPFj0giVuUBZXRW
 pwV7JBT0cEUlHg60hmXsyFNP1SUqgxx3hXHVA0ZFk/VVxVk+hTuB7gaw+Jqe2sT9bixF
 3jDud3HtA975hrSXBm5G3go8jaz4yAuA0D4bhmYwIa2fN7zECcPdzlYmJUe/poXoItdb
 Yi5g==
X-Gm-Message-State: AOJu0Yw0o7ZHBFuY+ekplRm6mBAxzE3zW+Nya+NbRxr25KbtQbISgQSG
 aJiNEG7JJ730se+yumB+zMXsQg==
X-Google-Smtp-Source: AGHT+IFEV6bmAIpHw+or7unvvp4cwTsozoazziwp2MnJPMacuVlS3tG5VZyJpyiWZTmsINX1q284Ww==
X-Received: by 2002:a05:6a20:9687:b0:15a:836:7239 with SMTP id
 hp7-20020a056a20968700b0015a08367239mr8898824pzc.11.1696265605341; 
 Mon, 02 Oct 2023 09:53:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 s24-20020aa78d58000000b0068fdb59e9d6sm19485160pfe.78.2023.10.02.09.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 09:53:24 -0700 (PDT)
Date: Mon, 2 Oct 2023 09:53:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Message-ID: <202310020952.E7DE0948C0@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Karol Herbst <kherbst@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 amd-gfx@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 intel-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>, Le Ma <le.ma@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Yifan Zhang <yifan1.zhang@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 freedreno@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Melissa Wen <mwen@igalia.com>, Zack Rusin <zackr@vmware.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nirmoy Das <nirmoy.das@intel.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Harrison <john.c.harrison@intel.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
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

T24gTW9uLCBPY3QgMDIsIDIwMjMgYXQgMTE6MDY6MTlBTSAtMDQwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IE9uIE1vbiwgT2N0IDIsIDIwMjMgYXQgNToyMOKAr0FNIENocmlzdGlhbiBLw7ZuaWcK
PiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IEFtIDI5
LjA5LjIzIHVtIDIxOjMzIHNjaHJpZWIgS2VlcyBDb29rOgo+ID4gPiBPbiBGcmksIDIyIFNlcCAy
MDIzIDEwOjMyOjA1IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6Cj4gPiA+PiBUaGlzIGlzIGEgYmF0
Y2ggb2YgcGF0Y2hlcyB0b3VjaGluZyBkcm0gZm9yIHByZXBhcmluZyBmb3IgdGhlIGNvbWluZwo+
ID4gPj4gaW1wbGVtZW50YXRpb24gYnkgR0NDIGFuZCBDbGFuZyBvZiB0aGUgX19jb3VudGVkX2J5
IGF0dHJpYnV0ZS4gRmxleGlibGUKPiA+ID4+IGFycmF5IG1lbWJlcnMgYW5ub3RhdGVkIHdpdGgg
X19jb3VudGVkX2J5IGNhbiBoYXZlIHRoZWlyIGFjY2Vzc2VzCj4gPiA+PiBib3VuZHMtY2hlY2tl
ZCBhdCBydW4tdGltZSBjaGVja2luZyB2aWEgQ09ORklHX1VCU0FOX0JPVU5EUyAoZm9yIGFycmF5
Cj4gPiA+PiBpbmRleGluZykgYW5kIENPTkZJR19GT1JUSUZZX1NPVVJDRSAoZm9yIHN0cmNweS9t
ZW1jcHktZmFtaWx5IGZ1bmN0aW9ucykuCj4gPiA+Pgo+ID4gPj4gQXMgZm91bmQgd2l0aCBDb2Nj
aW5lbGxlWzFdLCBhZGQgX19jb3VudGVkX2J5IHRvIHN0cnVjdHMgdGhhdCB3b3VsZAo+ID4gPj4g
YmVuZWZpdCBmcm9tIHRoZSBhbm5vdGF0aW9uLgo+ID4gPj4KPiA+ID4+IFsuLi5dCj4gPiA+IFNp
bmNlIHRoaXMgZ290IEFja3MsIEkgZmlndXJlIEkgc2hvdWxkIGNhcnJ5IGl0IGluIG15IHRyZWUu
IExldCBtZSBrbm93Cj4gPiA+IGlmIHRoaXMgc2hvdWxkIGdvIHZpYSBkcm0gaW5zdGVhZC4KPiA+
ID4KPiA+ID4gQXBwbGllZCB0byBmb3ItbmV4dC9oYXJkZW5pbmcsIHRoYW5rcyEKPiA+ID4KPiA+
ID4gWzEvOV0gZHJtL2FtZC9wbTogQW5ub3RhdGUgc3RydWN0IHNtdTEwX3ZvbHRhZ2VfZGVwZW5k
ZW5jeV90YWJsZSB3aXRoIF9fY291bnRlZF9ieQo+ID4gPiAgICAgICAgaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9rZWVzL2MvYTYwNDZhYzY1OWQ2Cj4gPgo+ID4gU1RPUCEgSW4gYSBmb2xsb3cgdXAg
ZGlzY3Vzc2lvbiBBbGV4IGFuZCBJIGZpZ3VyZWQgb3V0IHRoYXQgdGhpcyB3b24ndCB3b3JrLgoK
SSdtIHNvIGNvbmZ1c2VkOyBmcm9tIHRoZSBkaXNjdXNzaW9uIEkgc2F3IHRoYXQgQWxleCBzYWlk
IGJvdGggaW5zdGFuY2VzCndlcmUgZmFsc2UgcG9zaXRpdmVzPwoKPiA+Cj4gPiBUaGUgdmFsdWUg
aW4gdGhlIHN0cnVjdHVyZSBpcyBieXRlIHN3YXBwZWQgYmFzZWQgb24gc29tZSBmaXJtd2FyZQo+
ID4gZW5kaWFubmVzcyB3aGljaCBub3QgbmVjZXNzYXJ5IG1hdGNoZXMgdGhlIENQVSBlbmRpYW5u
ZXNzLgo+IAo+IFNNVTEwIGlzIEFQVSBvbmx5IHNvIHRoZSBlbmRpYW5lc3Mgb2YgdGhlIFNNVSBm
aXJtd2FyZSBhbmQgdGhlIENQVQo+IHdpbGwgYWx3YXlzIG1hdGNoLgoKV2hpY2ggSSB0aGluayBp
cyB3aGF0IGlzIGJlaW5nIHNhaWQgaGVyZT8KCj4gPiBQbGVhc2UgcmV2ZXJ0IHRoYXQgb25lIGZy
b20gZ29pbmcgdXBzdHJlYW0gaWYgaXQncyBhbHJlYWR5IG9uIGl0J3Mgd2F5Lgo+ID4KPiA+IEFu
ZCBiZWNhdXNlIG9mIHRob3NlIHJlYXNvbnMgSSBzdHJvbmdseSB0aGluayB0aGF0IHBhdGNoZXMg
bGlrZSB0aGlzCj4gPiBzaG91bGQgZ28gdGhyb3VnaCB0aGUgRFJNIHRyZWUgOikKClN1cmUsIHRo
YXQncyBmaW5lIC0tIHBsZWFzZSBsZXQgbWUga25vdy4gSXQgd2FzIG90aGVycyBBY2tlZC9ldGMu
IFdobwpzaG91bGQgY2FycnkgdGhlc2UgcGF0Y2hlcz8KClRoYW5rcyEKCi1LZWVzCgoKPiA+Cj4g
PiBSZWdhcmRzLAo+ID4gQ2hyaXN0aWFuLgo+ID4KPiA+ID4gWzIvOV0gZHJtL2FtZGdwdS9kaXNj
b3Zlcnk6IEFubm90YXRlIHN0cnVjdCBpcF9od19pbnN0YW5jZSB3aXRoIF9fY291bnRlZF9ieQo+
ID4gPiAgICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9rZWVzL2MvNGRmMzMwODliNDZmCj4g
PiA+IFszLzldIGRybS9pOTE1L3NlbGZ0ZXN0czogQW5ub3RhdGUgc3RydWN0IHBlcmZfc2VyaWVz
IHdpdGggX19jb3VudGVkX2J5Cj4gPiA+ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tl
ZXMvYy9mZmQzZjgyM2JkZjYKPiA+ID4gWzQvOV0gZHJtL21zbS9kcHU6IEFubm90YXRlIHN0cnVj
dCBkcHVfaHdfaW50ciB3aXRoIF9fY291bnRlZF9ieQo+ID4gPiAgICAgICAgaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9rZWVzL2MvMmRlMzVhOTg5Yjc2Cj4gPiA+IFs1LzldIGRybS9ub3V2ZWF1L3Bt
OiBBbm5vdGF0ZSBzdHJ1Y3QgbnZrbV9wZXJmZG9tIHdpdGggX19jb3VudGVkX2J5Cj4gPiA+ICAg
ICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tlZXMvYy8xODhhZWIwOGJmYWEKPiA+ID4gWzYv
OV0gZHJtL3ZjNDogQW5ub3RhdGUgc3RydWN0IHZjNF9wZXJmbW9uIHdpdGggX19jb3VudGVkX2J5
Cj4gPiA+ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tlZXMvYy81OWE1NGRjODk2YzMK
PiA+ID4gWzcvOV0gZHJtL3ZpcnRpbzogQW5ub3RhdGUgc3RydWN0IHZpcnRpb19ncHVfb2JqZWN0
X2FycmF5IHdpdGggX19jb3VudGVkX2J5Cj4gPiA+ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL2tlZXMvYy81Y2Q0NzZkZTMzYWYKPiA+ID4gWzgvOV0gZHJtL3Ztd2dmeDogQW5ub3RhdGUg
c3RydWN0IHZtd19zdXJmYWNlX2RpcnR5IHdpdGggX19jb3VudGVkX2J5Cj4gPiA+ICAgICAgICBo
dHRwczovL2dpdC5rZXJuZWwub3JnL2tlZXMvYy9iNDI2ZjJlNTM1NmEKPiA+ID4gWzkvOV0gZHJt
L3YzZDogQW5ub3RhdGUgc3RydWN0IHYzZF9wZXJmbW9uIHdpdGggX19jb3VudGVkX2J5Cj4gPiA+
ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tlZXMvYy9kYzY2MmZhMWIwZTQKPiA+ID4K
PiA+ID4gVGFrZSBjYXJlLAo+ID4gPgo+ID4KCi0tIApLZWVzIENvb2sKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
