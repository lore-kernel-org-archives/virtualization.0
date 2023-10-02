Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E8E74902
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 18:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A5C440470;
	Mon,  2 Oct 2023 18:08:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A5C440470
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jIRf6lBq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuPCZTCIOgOe; Mon,  2 Oct 2023 18:08:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5A4440B16;
	Mon,  2 Oct 2023 18:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5A4440B16
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8022CC0071;
	Mon,  2 Oct 2023 18:08:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7CC5C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95B2960B3C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:08:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95B2960B3C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=jIRf6lBq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O6y3znCUHpFx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:08:20 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45C2560B2D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:08:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45C2560B2D
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57bb6a2481fso18407eaf.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Oct 2023 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696270099; x=1696874899;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=muC7B8fW75NQ6UziQ28q/q7hcKRLv9QhdzwxKJUqnpg=;
 b=jIRf6lBqrBUvAuXuzeO/Nq/1zxBQMYtwdIxVYzY/GTC/BinzafMlO2njDx/tEryloL
 KoSt1AyXCpLaXHw+VvNUA93znAnsgKKQCugwH6dB0thNGiShy6FMgef3CJTMdym1mm0M
 YMbof91FQZY3t6r3MOUVFoSLXBbbSTiEd4JDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696270099; x=1696874899;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=muC7B8fW75NQ6UziQ28q/q7hcKRLv9QhdzwxKJUqnpg=;
 b=ijUHGDSjhZnRkMZAYjULE5rzJNerRKkWOH6ofrValMliQfGgV+gaNm1QdgOysaduD+
 zKpS92UVQ3D3hImPy9A4CXNPpe7cIQXCBZpYK/cxsxnOlEVoen4E1zGao6cUnES8kEEA
 /N9eflMS/KMLTYoT9frxf99gjpjAf6DIF2qVnguWrRKvCEne4y7TEhrpOK1m/Gswk9zc
 sOBcrUopHnk8QFWcYpYBfn4Ps+QZzKBdFhTE31qXa00gdH4pRKIANKExO953b3d2cPCS
 7FltXW9xcSy8qkz+cq2LkVu8Re4B8soTGikbTu7x46hVPFqQOrKaT0nbj9raMMxJypu6
 CIow==
X-Gm-Message-State: AOJu0YxVuIYjj47ZR9UWMFZl50pUgBcfZ8Wrsu3L9WXZUH8nd98+cvCe
 12MqeD8xZJ2lfrX5uSV/K0p/lA==
X-Google-Smtp-Source: AGHT+IFxp3WuQLBF6a4Zx6RmI26vX0risXfepC82ZiUfTaJR3IBCtfYoiOluvuBsDmgpQQL/ViltxA==
X-Received: by 2002:a05:6358:728:b0:14c:e2d3:fb2d with SMTP id
 e40-20020a056358072800b0014ce2d3fb2dmr9868464rwj.5.1696270098901; 
 Mon, 02 Oct 2023 11:08:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 it21-20020a056a00459500b0069319bfed42sm5485937pfb.79.2023.10.02.11.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 11:08:18 -0700 (PDT)
Date: Mon, 2 Oct 2023 11:08:16 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Message-ID: <202310021107.9BB46FB8E@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
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
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-arm-msm@vger.kernel.org,
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
 Lang Yu <Lang.Yu@amd.com>,
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

T24gTW9uLCBPY3QgMDIsIDIwMjMgYXQgMDg6MDE6NTdQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAwMi4xMC4yMyB1bSAxODo1MyBzY2hyaWViIEtlZXMgQ29vazoKPiA+IE9u
IE1vbiwgT2N0IDAyLCAyMDIzIGF0IDExOjA2OjE5QU0gLTA0MDAsIEFsZXggRGV1Y2hlciB3cm90
ZToKPiA+ID4gT24gTW9uLCBPY3QgMiwgMjAyMyBhdCA1OjIw4oCvQU0gQ2hyaXN0aWFuIEvDtm5p
Zwo+ID4gPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+
IEFtIDI5LjA5LjIzIHVtIDIxOjMzIHNjaHJpZWIgS2VlcyBDb29rOgo+ID4gPiA+ID4gT24gRnJp
LCAyMiBTZXAgMjAyMyAxMDozMjowNSAtMDcwMCwgS2VlcyBDb29rIHdyb3RlOgo+ID4gPiA+ID4g
PiBUaGlzIGlzIGEgYmF0Y2ggb2YgcGF0Y2hlcyB0b3VjaGluZyBkcm0gZm9yIHByZXBhcmluZyBm
b3IgdGhlIGNvbWluZwo+ID4gPiA+ID4gPiBpbXBsZW1lbnRhdGlvbiBieSBHQ0MgYW5kIENsYW5n
IG9mIHRoZSBfX2NvdW50ZWRfYnkgYXR0cmlidXRlLiBGbGV4aWJsZQo+ID4gPiA+ID4gPiBhcnJh
eSBtZW1iZXJzIGFubm90YXRlZCB3aXRoIF9fY291bnRlZF9ieSBjYW4gaGF2ZSB0aGVpciBhY2Nl
c3Nlcwo+ID4gPiA+ID4gPiBib3VuZHMtY2hlY2tlZCBhdCBydW4tdGltZSBjaGVja2luZyB2aWEg
Q09ORklHX1VCU0FOX0JPVU5EUyAoZm9yIGFycmF5Cj4gPiA+ID4gPiA+IGluZGV4aW5nKSBhbmQg
Q09ORklHX0ZPUlRJRllfU09VUkNFIChmb3Igc3RyY3B5L21lbWNweS1mYW1pbHkgZnVuY3Rpb25z
KS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEFzIGZvdW5kIHdpdGggQ29jY2luZWxsZVsxXSwg
YWRkIF9fY291bnRlZF9ieSB0byBzdHJ1Y3RzIHRoYXQgd291bGQKPiA+ID4gPiA+ID4gYmVuZWZp
dCBmcm9tIHRoZSBhbm5vdGF0aW9uLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gWy4uLl0KPiA+
ID4gPiA+IFNpbmNlIHRoaXMgZ290IEFja3MsIEkgZmlndXJlIEkgc2hvdWxkIGNhcnJ5IGl0IGlu
IG15IHRyZWUuIExldCBtZSBrbm93Cj4gPiA+ID4gPiBpZiB0aGlzIHNob3VsZCBnbyB2aWEgZHJt
IGluc3RlYWQuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEFwcGxpZWQgdG8gZm9yLW5leHQvaGFyZGVu
aW5nLCB0aGFua3MhCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFsxLzldIGRybS9hbWQvcG06IEFubm90
YXRlIHN0cnVjdCBzbXUxMF92b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUgd2l0aCBfX2NvdW50ZWRf
YnkKPiA+ID4gPiA+ICAgICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9rZWVzL2MvYTYwNDZh
YzY1OWQ2Cj4gPiA+ID4gU1RPUCEgSW4gYSBmb2xsb3cgdXAgZGlzY3Vzc2lvbiBBbGV4IGFuZCBJ
IGZpZ3VyZWQgb3V0IHRoYXQgdGhpcyB3b24ndCB3b3JrLgo+ID4gSSdtIHNvIGNvbmZ1c2VkOyBm
cm9tIHRoZSBkaXNjdXNzaW9uIEkgc2F3IHRoYXQgQWxleCBzYWlkIGJvdGggaW5zdGFuY2VzCj4g
PiB3ZXJlIGZhbHNlIHBvc2l0aXZlcz8KPiA+IAo+ID4gPiA+IFRoZSB2YWx1ZSBpbiB0aGUgc3Ry
dWN0dXJlIGlzIGJ5dGUgc3dhcHBlZCBiYXNlZCBvbiBzb21lIGZpcm13YXJlCj4gPiA+ID4gZW5k
aWFubmVzcyB3aGljaCBub3QgbmVjZXNzYXJ5IG1hdGNoZXMgdGhlIENQVSBlbmRpYW5uZXNzLgo+
ID4gPiBTTVUxMCBpcyBBUFUgb25seSBzbyB0aGUgZW5kaWFuZXNzIG9mIHRoZSBTTVUgZmlybXdh
cmUgYW5kIHRoZSBDUFUKPiA+ID4gd2lsbCBhbHdheXMgbWF0Y2guCj4gPiBXaGljaCBJIHRoaW5r
IGlzIHdoYXQgaXMgYmVpbmcgc2FpZCBoZXJlPwo+ID4gCj4gPiA+ID4gUGxlYXNlIHJldmVydCB0
aGF0IG9uZSBmcm9tIGdvaW5nIHVwc3RyZWFtIGlmIGl0J3MgYWxyZWFkeSBvbiBpdCdzIHdheS4K
PiA+ID4gPiAKPiA+ID4gPiBBbmQgYmVjYXVzZSBvZiB0aG9zZSByZWFzb25zIEkgc3Ryb25nbHkg
dGhpbmsgdGhhdCBwYXRjaGVzIGxpa2UgdGhpcwo+ID4gPiA+IHNob3VsZCBnbyB0aHJvdWdoIHRo
ZSBEUk0gdHJlZSA6KQo+ID4gU3VyZSwgdGhhdCdzIGZpbmUgLS0gcGxlYXNlIGxldCBtZSBrbm93
LiBJdCB3YXMgb3RoZXJzIEFja2VkL2V0Yy4gV2hvCj4gPiBzaG91bGQgY2FycnkgdGhlc2UgcGF0
Y2hlcz8KPiAKPiBQcm9iYWJseSBiZXN0IGlmIHRoZSByZWxldmFudCBtYWludGFpbmVyIHBpY2sg
dGhlbSB1cCBpbmRpdmlkdWFsbHkuCj4gCj4gU29tZSBvZiB0aG9zZSBzdHJ1Y3R1cmVzIGFyZSBm
aWxsZWQgaW4gYnkgZmlybXdhcmUvaGFyZHdhcmUgYW5kIG9ubHkgdGhlCj4gbWFpbnRhaW5lcnMg
Y2FuIGp1ZGdlIGlmIHRoYXQgdmFsdWUgYWN0dWFsbHkgbWF0Y2hlcyB3aGF0IHRoZSBjb21waWxl
cgo+IG5lZWRzLgo+IAo+IFdlIGhhdmUgY2FzZXMgd2hlcmUgaW5kaXZpZHVhbCBiaXRzIGFyZSB1
c2VkIGFzIGZsYWdzIG9yIHdoZW4gdGhlIHNpemUgaXMKPiBieXRlIHN3YXBwZWQgZXRjLi4uCj4g
Cj4gRXZlbiBBbGV4IGFuZCBJIGRpZG4ndCBpbW1lZGlhdGVseSBzYXkgaG93IGFuZCB3aGVyZSB0
aGF0IGZpZWxkIGlzIGFjdHVhbGx5Cj4gdXNlZCBhbmQgaGFkIHRvIGRpZyB0aGF0IHVwLiBUaGF0
J3Mgd2hlcmUgdGhlIGNvbmZ1c2lvbiBjYW1lIGZyb20uCgpPa2F5LCBJJ3ZlIGRyb3BwZWQgdGhl
bSBhbGwgZnJvbSBteSB0cmVlLiBTZXZlcmFsIGhhZCBBY2tzL1Jldmlld3MsIHNvCmhvcGVmdWxs
eSB0aG9zZSBjYW4gZ2V0IHBpY2tlZCB1cCBmb3IgdGhlIERSTSB0cmVlPwoKVGhhbmtzIQoKLUtl
ZXMKCi0tIApLZWVzIENvb2sKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
