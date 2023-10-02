Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E1FE784BF
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 15:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E2FE81FCA;
	Mon,  2 Oct 2023 15:06:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E2FE81FCA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=c3gzoiri
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QygfKmzRgpjy; Mon,  2 Oct 2023 15:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 52B898197D;
	Mon,  2 Oct 2023 15:06:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52B898197D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2076FC0071;
	Mon,  2 Oct 2023 15:06:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F2B6C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 15:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 251FC40C2A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 15:06:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 251FC40C2A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=c3gzoiri
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEp_zmIz5she
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 15:06:32 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCC22405BE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 15:06:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCC22405BE
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1dcead29b3eso7339461fac.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Oct 2023 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696259191; x=1696863991;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0wIcnLi0eW3KIpAYRJEn1N+1DF/SZtUbN/0mO//zy4=;
 b=c3gzoiriNwKJ4U+i1Q1rqRlCGLtDJCrWTRwD8b7sEtF5mRFekdh7XP+zNovQhBuZa+
 kByayu23CjBn4ZSBUv7j/NTaObazVLEdj+IyvGe9LfiMCbAlIVp6bzSZWTa1rlsQBvl0
 mjN6QSiEc5dlhaNH+5BsD66RNmnuidcUycEjsn1Tfll/Z3NubWsGJPjixGVTeb4KSTA0
 t24q1lOfaBDzCo0EccEPTyZDybgkB3JakF46/v+O1fN1hrb20g8bGR1VlCEeCSA2xE4x
 ugYcYC/IhpGaOSW8Jj1LsLEsuCVahXkRbW6mVK2/n6mlykzN4bNt/f/NRGxiyYLSJS8c
 gn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696259191; x=1696863991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0wIcnLi0eW3KIpAYRJEn1N+1DF/SZtUbN/0mO//zy4=;
 b=Nc4fF9XHS25+ICpw9SRqjtIyRJkig9Ac6tacqzq7PdN8yrEslcCEMkr38jisAUrH5y
 cSp5HD+bB6nk8FhBWCBFI7Q+yIwZZ0n/7fdFOQ9uEJVV1wJKF2XnqeoUyyWWiFUXoUh4
 /AYXLOgYrZs0DBecAkkyI3Zkf5/MaXwHxNor5JUXgRL3rq6rW7CBmyqTy8b01VELUNL5
 pXGy03hVY6m48mlSbNx392+GelyzJHFHpEjS/z3rkItztAntxeVPYvknXjJyfMupBVnQ
 ltNzHbZ9xEEfPNMlaVee2pi1DhwrFyd2kA3YuEAveFJM1oelNp/EP7VLj0b7wV4+jEWY
 iU1A==
X-Gm-Message-State: AOJu0YynxHmQXqEnegvfMeJFOIRwm8DqU4eormDYbWq73v119j2PX63m
 OvV4xBaI/V1Z8LX47z/xAJD7R5cNkDEjhk90MoM=
X-Google-Smtp-Source: AGHT+IEX1je+61h+JUKWDKJZA+eu4NOUlivFnUEzoxSozC/G9+CulawvWCmD9DLQxtVZD1wdvqrdGNPyL3ZP6lrp6ME=
X-Received: by 2002:a05:6870:a115:b0:1dd:7fa9:ed52 with SMTP id
 m21-20020a056870a11500b001dd7fa9ed52mr15044564oae.17.1696259190738; Mon, 02
 Oct 2023 08:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
In-Reply-To: <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Oct 2023 11:06:19 -0400
Message-ID: <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Karol Herbst <kherbst@redhat.com>, Tom Rix <trix@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Emma Anholt <emma@anholt.net>, Neil Armstrong <neil.armstrong@linaro.org>,
 amd-gfx@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kees Cook <keescook@chromium.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-arm-msm@vger.kernel.org,
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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

T24gTW9uLCBPY3QgMiwgMjAyMyBhdCA1OjIw4oCvQU0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gQW0gMjkuMDkuMjMgdW0gMjE6
MzMgc2NocmllYiBLZWVzIENvb2s6Cj4gPiBPbiBGcmksIDIyIFNlcCAyMDIzIDEwOjMyOjA1IC0w
NzAwLCBLZWVzIENvb2sgd3JvdGU6Cj4gPj4gVGhpcyBpcyBhIGJhdGNoIG9mIHBhdGNoZXMgdG91
Y2hpbmcgZHJtIGZvciBwcmVwYXJpbmcgZm9yIHRoZSBjb21pbmcKPiA+PiBpbXBsZW1lbnRhdGlv
biBieSBHQ0MgYW5kIENsYW5nIG9mIHRoZSBfX2NvdW50ZWRfYnkgYXR0cmlidXRlLiBGbGV4aWJs
ZQo+ID4+IGFycmF5IG1lbWJlcnMgYW5ub3RhdGVkIHdpdGggX19jb3VudGVkX2J5IGNhbiBoYXZl
IHRoZWlyIGFjY2Vzc2VzCj4gPj4gYm91bmRzLWNoZWNrZWQgYXQgcnVuLXRpbWUgY2hlY2tpbmcg
dmlhIENPTkZJR19VQlNBTl9CT1VORFMgKGZvciBhcnJheQo+ID4+IGluZGV4aW5nKSBhbmQgQ09O
RklHX0ZPUlRJRllfU09VUkNFIChmb3Igc3RyY3B5L21lbWNweS1mYW1pbHkgZnVuY3Rpb25zKS4K
PiA+Pgo+ID4+IEFzIGZvdW5kIHdpdGggQ29jY2luZWxsZVsxXSwgYWRkIF9fY291bnRlZF9ieSB0
byBzdHJ1Y3RzIHRoYXQgd291bGQKPiA+PiBiZW5lZml0IGZyb20gdGhlIGFubm90YXRpb24uCj4g
Pj4KPiA+PiBbLi4uXQo+ID4gU2luY2UgdGhpcyBnb3QgQWNrcywgSSBmaWd1cmUgSSBzaG91bGQg
Y2FycnkgaXQgaW4gbXkgdHJlZS4gTGV0IG1lIGtub3cKPiA+IGlmIHRoaXMgc2hvdWxkIGdvIHZp
YSBkcm0gaW5zdGVhZC4KPiA+Cj4gPiBBcHBsaWVkIHRvIGZvci1uZXh0L2hhcmRlbmluZywgdGhh
bmtzIQo+ID4KPiA+IFsxLzldIGRybS9hbWQvcG06IEFubm90YXRlIHN0cnVjdCBzbXUxMF92b2x0
YWdlX2RlcGVuZGVuY3lfdGFibGUgd2l0aCBfX2NvdW50ZWRfYnkKPiA+ICAgICAgICBodHRwczov
L2dpdC5rZXJuZWwub3JnL2tlZXMvYy9hNjA0NmFjNjU5ZDYKPgo+IFNUT1AhIEluIGEgZm9sbG93
IHVwIGRpc2N1c3Npb24gQWxleCBhbmQgSSBmaWd1cmVkIG91dCB0aGF0IHRoaXMgd29uJ3Qgd29y
ay4KPgo+IFRoZSB2YWx1ZSBpbiB0aGUgc3RydWN0dXJlIGlzIGJ5dGUgc3dhcHBlZCBiYXNlZCBv
biBzb21lIGZpcm13YXJlCj4gZW5kaWFubmVzcyB3aGljaCBub3QgbmVjZXNzYXJ5IG1hdGNoZXMg
dGhlIENQVSBlbmRpYW5uZXNzLgoKU01VMTAgaXMgQVBVIG9ubHkgc28gdGhlIGVuZGlhbmVzcyBv
ZiB0aGUgU01VIGZpcm13YXJlIGFuZCB0aGUgQ1BVCndpbGwgYWx3YXlzIG1hdGNoLgoKQWxleAoK
Pgo+IFBsZWFzZSByZXZlcnQgdGhhdCBvbmUgZnJvbSBnb2luZyB1cHN0cmVhbSBpZiBpdCdzIGFs
cmVhZHkgb24gaXQncyB3YXkuCj4KPiBBbmQgYmVjYXVzZSBvZiB0aG9zZSByZWFzb25zIEkgc3Ry
b25nbHkgdGhpbmsgdGhhdCBwYXRjaGVzIGxpa2UgdGhpcwo+IHNob3VsZCBnbyB0aHJvdWdoIHRo
ZSBEUk0gdHJlZSA6KQo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPiA+IFsyLzldIGRybS9h
bWRncHUvZGlzY292ZXJ5OiBBbm5vdGF0ZSBzdHJ1Y3QgaXBfaHdfaW5zdGFuY2Ugd2l0aCBfX2Nv
dW50ZWRfYnkKPiA+ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tlZXMvYy80ZGYzMzA4
OWI0NmYKPiA+IFszLzldIGRybS9pOTE1L3NlbGZ0ZXN0czogQW5ub3RhdGUgc3RydWN0IHBlcmZf
c2VyaWVzIHdpdGggX19jb3VudGVkX2J5Cj4gPiAgICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9rZWVzL2MvZmZkM2Y4MjNiZGY2Cj4gPiBbNC85XSBkcm0vbXNtL2RwdTogQW5ub3RhdGUgc3Ry
dWN0IGRwdV9od19pbnRyIHdpdGggX19jb3VudGVkX2J5Cj4gPiAgICAgICAgaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9rZWVzL2MvMmRlMzVhOTg5Yjc2Cj4gPiBbNS85XSBkcm0vbm91dmVhdS9wbTog
QW5ub3RhdGUgc3RydWN0IG52a21fcGVyZmRvbSB3aXRoIF9fY291bnRlZF9ieQo+ID4gICAgICAg
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcva2Vlcy9jLzE4OGFlYjA4YmZhYQo+ID4gWzYvOV0gZHJt
L3ZjNDogQW5ub3RhdGUgc3RydWN0IHZjNF9wZXJmbW9uIHdpdGggX19jb3VudGVkX2J5Cj4gPiAg
ICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9rZWVzL2MvNTlhNTRkYzg5NmMzCj4gPiBbNy85
XSBkcm0vdmlydGlvOiBBbm5vdGF0ZSBzdHJ1Y3QgdmlydGlvX2dwdV9vYmplY3RfYXJyYXkgd2l0
aCBfX2NvdW50ZWRfYnkKPiA+ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tlZXMvYy81
Y2Q0NzZkZTMzYWYKPiA+IFs4LzldIGRybS92bXdnZng6IEFubm90YXRlIHN0cnVjdCB2bXdfc3Vy
ZmFjZV9kaXJ0eSB3aXRoIF9fY291bnRlZF9ieQo+ID4gICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcva2Vlcy9jL2I0MjZmMmU1MzU2YQo+ID4gWzkvOV0gZHJtL3YzZDogQW5ub3RhdGUgc3Ry
dWN0IHYzZF9wZXJmbW9uIHdpdGggX19jb3VudGVkX2J5Cj4gPiAgICAgICAgaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9rZWVzL2MvZGM2NjJmYTFiMGU0Cj4gPgo+ID4gVGFrZSBjYXJlLAo+ID4KPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
