Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A8AE74905
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 18:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D710140951;
	Mon,  2 Oct 2023 18:22:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D710140951
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=P0MYoxdD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OWorfAKZmcb8; Mon,  2 Oct 2023 18:22:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C4F4F40937;
	Mon,  2 Oct 2023 18:22:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4F4F40937
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 755B8C0039;
	Mon,  2 Oct 2023 18:22:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F7ECC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74C8B4146D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:22:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74C8B4146D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=P0MYoxdD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lo-fGqd2PKjK
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:22:25 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CCC140904
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CCC140904
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-577fff1cae6so5936a12.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Oct 2023 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696270945; x=1696875745;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6vMwsjYrlAei3Hxc6ZjjNt+EO9kZEbPnxPSvxjTe6qw=;
 b=P0MYoxdDOYMnM6IFJe8LBNZ4jN2LUc/QhTgSYprkxN45nCNfK2o4g2gpUEmCVyd0Go
 bOrlPYtq2Gzub+t/AQMlPWhFPwdxd+A0ErwDIeGikwbIaR3AmUvA+pC82AIR6hb+FwWX
 1eOdIteu9fL1B/wFfLCxpMmhfyX5iyy6qjr5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696270945; x=1696875745;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6vMwsjYrlAei3Hxc6ZjjNt+EO9kZEbPnxPSvxjTe6qw=;
 b=NGVS5yclAn5UNWzA9LqdaK83Hc2xlw0R2Mkz1Fro3vEYQal22UHfDk0onrV7w4w/AX
 ijWVMZXUoFhqaU3wQ2+1M/jAXwet5K+UI4O1ulQeZKX7yXPkQI/BoErS26nF7JiT9uLR
 zBR+b/crUpgxEIS1vHc+gWZD3rvkjBVyZyCg6K44WxAvm1Rs/W+sQjm1y519vws1eYW/
 Zhi6YJr4MFKRlpQmvzLBINLksfpwQmOmYCgq1j8Q93Yiy9/jV7AeyL3rYYGHPKfik1Rp
 m0+IaH06v58eo0NBMF2JCSD4SlrzL8PZQf6U/O3oa+7AT/eZ5f4WON/PvESvjCLyZX9Y
 l8tQ==
X-Gm-Message-State: AOJu0YzpDLmbnCyXmRdBXbgte3X0HGcURRYOStOj5p8Wj5D1G2gvB/Ym
 tzKxJJpORkssO/ZFnctH0Z3qbw==
X-Google-Smtp-Source: AGHT+IFu7XIuUCGOlcsyNLly9unt/oHCJHSK53R4jpfqHFz2qYx70ADEn6oBAlKq5k57qw3fzv2Kwg==
X-Received: by 2002:a17:90b:4a42:b0:277:3afc:f27 with SMTP id
 lb2-20020a17090b4a4200b002773afc0f27mr561738pjb.1.1696270944558; 
 Mon, 02 Oct 2023 11:22:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 d12-20020a17090a498c00b0026b3ed37ddcsm6358499pjh.32.2023.10.02.11.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 11:22:23 -0700 (PDT)
Date: Mon, 2 Oct 2023 11:22:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Message-ID: <202310021122.B6DA850FB0@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
 <202310021107.9BB46FB8E@keescook>
 <0be2dfa4-b6c1-f62a-66e1-615da7aa3c76@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0be2dfa4-b6c1-f62a-66e1-615da7aa3c76@amd.com>
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
 Nathan Chancellor <nathan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Yifan Zhang <yifan1.zhang@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Le Ma <le.ma@amd.com>, freedreno@lists.freedesktop.org,
 Bjorn Andersson <andersson@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@intel.com>,
 Lang Yu <Lang.Yu@amd.com>, John Harrison <john.c.harrison@intel.com>,
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

T24gTW9uLCBPY3QgMDIsIDIwMjMgYXQgMDg6MTE6NDFQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAwMi4xMC4yMyB1bSAyMDowOCBzY2hyaWViIEtlZXMgQ29vazoKPiA+IE9u
IE1vbiwgT2N0IDAyLCAyMDIzIGF0IDA4OjAxOjU3UE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4gPiA+IEFtIDAyLjEwLjIzIHVtIDE4OjUzIHNjaHJpZWIgS2VlcyBDb29rOgo+ID4g
PiA+IE9uIE1vbiwgT2N0IDAyLCAyMDIzIGF0IDExOjA2OjE5QU0gLTA0MDAsIEFsZXggRGV1Y2hl
ciB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgT2N0IDIsIDIwMjMgYXQgNToyMOKAr0FNIENocmlz
dGlhbiBLw7ZuaWcKPiA+ID4gPiA+IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiA+IEFtIDI5LjA5LjIzIHVtIDIxOjMzIHNjaHJpZWIgS2VlcyBDb29r
Ogo+ID4gPiA+ID4gPiA+IE9uIEZyaSwgMjIgU2VwIDIwMjMgMTA6MzI6MDUgLTA3MDAsIEtlZXMg
Q29vayB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgYSBiYXRjaCBvZiBwYXRjaGVzIHRv
dWNoaW5nIGRybSBmb3IgcHJlcGFyaW5nIGZvciB0aGUgY29taW5nCj4gPiA+ID4gPiA+ID4gPiBp
bXBsZW1lbnRhdGlvbiBieSBHQ0MgYW5kIENsYW5nIG9mIHRoZSBfX2NvdW50ZWRfYnkgYXR0cmli
dXRlLiBGbGV4aWJsZQo+ID4gPiA+ID4gPiA+ID4gYXJyYXkgbWVtYmVycyBhbm5vdGF0ZWQgd2l0
aCBfX2NvdW50ZWRfYnkgY2FuIGhhdmUgdGhlaXIgYWNjZXNzZXMKPiA+ID4gPiA+ID4gPiA+IGJv
dW5kcy1jaGVja2VkIGF0IHJ1bi10aW1lIGNoZWNraW5nIHZpYSBDT05GSUdfVUJTQU5fQk9VTkRT
IChmb3IgYXJyYXkKPiA+ID4gPiA+ID4gPiA+IGluZGV4aW5nKSBhbmQgQ09ORklHX0ZPUlRJRllf
U09VUkNFIChmb3Igc3RyY3B5L21lbWNweS1mYW1pbHkgZnVuY3Rpb25zKS4KPiA+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+ID4gQXMgZm91bmQgd2l0aCBDb2NjaW5lbGxlWzFdLCBhZGQgX19j
b3VudGVkX2J5IHRvIHN0cnVjdHMgdGhhdCB3b3VsZAo+ID4gPiA+ID4gPiA+ID4gYmVuZWZpdCBm
cm9tIHRoZSBhbm5vdGF0aW9uLgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBbLi4u
XQo+ID4gPiA+ID4gPiA+IFNpbmNlIHRoaXMgZ290IEFja3MsIEkgZmlndXJlIEkgc2hvdWxkIGNh
cnJ5IGl0IGluIG15IHRyZWUuIExldCBtZSBrbm93Cj4gPiA+ID4gPiA+ID4gaWYgdGhpcyBzaG91
bGQgZ28gdmlhIGRybSBpbnN0ZWFkLgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IEFwcGxp
ZWQgdG8gZm9yLW5leHQvaGFyZGVuaW5nLCB0aGFua3MhCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gWzEvOV0gZHJtL2FtZC9wbTogQW5ub3RhdGUgc3RydWN0IHNtdTEwX3ZvbHRhZ2VfZGVw
ZW5kZW5jeV90YWJsZSB3aXRoIF9fY291bnRlZF9ieQo+ID4gPiA+ID4gPiA+ICAgICAgICAgIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcva2Vlcy9jL2E2MDQ2YWM2NTlkNgo+ID4gPiA+ID4gPiBTVE9Q
ISBJbiBhIGZvbGxvdyB1cCBkaXNjdXNzaW9uIEFsZXggYW5kIEkgZmlndXJlZCBvdXQgdGhhdCB0
aGlzIHdvbid0IHdvcmsuCj4gPiA+ID4gSSdtIHNvIGNvbmZ1c2VkOyBmcm9tIHRoZSBkaXNjdXNz
aW9uIEkgc2F3IHRoYXQgQWxleCBzYWlkIGJvdGggaW5zdGFuY2VzCj4gPiA+ID4gd2VyZSBmYWxz
ZSBwb3NpdGl2ZXM/Cj4gPiA+ID4gCj4gPiA+ID4gPiA+IFRoZSB2YWx1ZSBpbiB0aGUgc3RydWN0
dXJlIGlzIGJ5dGUgc3dhcHBlZCBiYXNlZCBvbiBzb21lIGZpcm13YXJlCj4gPiA+ID4gPiA+IGVu
ZGlhbm5lc3Mgd2hpY2ggbm90IG5lY2Vzc2FyeSBtYXRjaGVzIHRoZSBDUFUgZW5kaWFubmVzcy4K
PiA+ID4gPiA+IFNNVTEwIGlzIEFQVSBvbmx5IHNvIHRoZSBlbmRpYW5lc3Mgb2YgdGhlIFNNVSBm
aXJtd2FyZSBhbmQgdGhlIENQVQo+ID4gPiA+ID4gd2lsbCBhbHdheXMgbWF0Y2guCj4gPiA+ID4g
V2hpY2ggSSB0aGluayBpcyB3aGF0IGlzIGJlaW5nIHNhaWQgaGVyZT8KPiA+ID4gPiAKPiA+ID4g
PiA+ID4gUGxlYXNlIHJldmVydCB0aGF0IG9uZSBmcm9tIGdvaW5nIHVwc3RyZWFtIGlmIGl0J3Mg
YWxyZWFkeSBvbiBpdCdzIHdheS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEFuZCBiZWNhdXNl
IG9mIHRob3NlIHJlYXNvbnMgSSBzdHJvbmdseSB0aGluayB0aGF0IHBhdGNoZXMgbGlrZSB0aGlz
Cj4gPiA+ID4gPiA+IHNob3VsZCBnbyB0aHJvdWdoIHRoZSBEUk0gdHJlZSA6KQo+ID4gPiA+IFN1
cmUsIHRoYXQncyBmaW5lIC0tIHBsZWFzZSBsZXQgbWUga25vdy4gSXQgd2FzIG90aGVycyBBY2tl
ZC9ldGMuIFdobwo+ID4gPiA+IHNob3VsZCBjYXJyeSB0aGVzZSBwYXRjaGVzPwo+ID4gPiBQcm9i
YWJseSBiZXN0IGlmIHRoZSByZWxldmFudCBtYWludGFpbmVyIHBpY2sgdGhlbSB1cCBpbmRpdmlk
dWFsbHkuCj4gPiA+IAo+ID4gPiBTb21lIG9mIHRob3NlIHN0cnVjdHVyZXMgYXJlIGZpbGxlZCBp
biBieSBmaXJtd2FyZS9oYXJkd2FyZSBhbmQgb25seSB0aGUKPiA+ID4gbWFpbnRhaW5lcnMgY2Fu
IGp1ZGdlIGlmIHRoYXQgdmFsdWUgYWN0dWFsbHkgbWF0Y2hlcyB3aGF0IHRoZSBjb21waWxlcgo+
ID4gPiBuZWVkcy4KPiA+ID4gCj4gPiA+IFdlIGhhdmUgY2FzZXMgd2hlcmUgaW5kaXZpZHVhbCBi
aXRzIGFyZSB1c2VkIGFzIGZsYWdzIG9yIHdoZW4gdGhlIHNpemUgaXMKPiA+ID4gYnl0ZSBzd2Fw
cGVkIGV0Yy4uLgo+ID4gPiAKPiA+ID4gRXZlbiBBbGV4IGFuZCBJIGRpZG4ndCBpbW1lZGlhdGVs
eSBzYXkgaG93IGFuZCB3aGVyZSB0aGF0IGZpZWxkIGlzIGFjdHVhbGx5Cj4gPiA+IHVzZWQgYW5k
IGhhZCB0byBkaWcgdGhhdCB1cC4gVGhhdCdzIHdoZXJlIHRoZSBjb25mdXNpb24gY2FtZSBmcm9t
Lgo+ID4gT2theSwgSSd2ZSBkcm9wcGVkIHRoZW0gYWxsIGZyb20gbXkgdHJlZS4gU2V2ZXJhbCBo
YWQgQWNrcy9SZXZpZXdzLCBzbwo+ID4gaG9wZWZ1bGx5IHRob3NlIGNhbiBnZXQgcGlja2VkIHVw
IGZvciB0aGUgRFJNIHRyZWU/Cj4gCj4gSSB3aWxsIHBpY2sgdGhvc2UgdXAgdG8gZ28gdGhyb3Vn
aCBkcm0tbWlzYy1uZXh0Lgo+IAo+IEdvaW5nIHRvIHBpbmcgbWFpbnRhaW5lcnMgb25jZSBtb3Jl
IHdoZW4gSSdtIG5vdCBzdXJlIGlmIHN0dWZmIGlzIGNvcnJlY3Qgb3IKPiBub3QuCgpTb3VuZHMg
Z3JlYXQ7IHRoYW5rcyEKCi1LZWVzCgotLSAKS2VlcyBDb29rCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
