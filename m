Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34C7E74902
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 18:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35FE760B1B;
	Mon,  2 Oct 2023 18:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35FE760B1B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LtBbuGu+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAM5mWa8lKGe; Mon,  2 Oct 2023 18:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA66760B21;
	Mon,  2 Oct 2023 18:02:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA66760B21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 825A4C0071;
	Mon,  2 Oct 2023 18:02:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F7A8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E760260B21
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:02:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E760260B21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LaE9_xRPRh1Z
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:02:06 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 419C160B1B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:02:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 419C160B1B
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32320381a07so93575f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Oct 2023 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696269724; x=1696874524;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zam6JpvTJFSRB7Mf1N6WASAM0s+ax1vMTASmJwGp/GQ=;
 b=LtBbuGu+hkgxW1hrFy3q13PmozUDKyp3akZmuu2ptjhZZh76FqdjEfD8VqqZfFur23
 Lc9HffA7Qg0xqd5+WySFAAtHn3fzxIH/jFrWtRTfpnrGO+1i8egRqf3dqxMLoOKXS4Ca
 MuzOT4VQKc1orPUHVT9+RQLSoKppIwmlEfgaVqJkUr4xIjbVkgy6rIF22MuQRLNaRFf+
 ttYPOPnYKhv+I1lBHptGiw9fZEXRPfqJM6PpfcG134nYQCvsiYGLHUI0+2ewYgQ6aEEc
 FGEqGi/c50UAeReb4zF9VcTQ7usSXrJzcZwm0eglCze0qnAMFvZZB8xouvsNL1eMZZ7v
 e5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696269724; x=1696874524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zam6JpvTJFSRB7Mf1N6WASAM0s+ax1vMTASmJwGp/GQ=;
 b=sraB0RCetzHVlCPLUiJj7mKHqMfM4nAtmebaA665B4DjbPgArAwIHSu0k+uCC5omBw
 i9ahq3cLY2f3CkkwlByD3Utqnqg6QLe8P3pIfwgwBPKiIGcbCKr8G2RllxmSH+7AxeL5
 XMJCc+07P6V8jJ/kH1uBgKT4oxcG0iLb5EDLEqAR691+zemnvm7baTD4oO7oz+dldz2L
 s5yWQMcst75FCaZLE2Xw0H77bYjLfsZTQO/RbuO1odqLUCQwsh/4p8Uo4MlUpv4YVDOu
 LxVCDb7FAFzmjKd4v/K7WJeiDfzqX2Fsldr5SfLq/kGya5VpV4Gj+z2G47UE3bfLeZvb
 VnOg==
X-Gm-Message-State: AOJu0YyoC58wQXCCctH5dGSwVUfeOKGZweRbFcR5odCbv2C845EyWFm+
 W3xTb1hdD2YQD4GWL3Q3sVs=
X-Google-Smtp-Source: AGHT+IHXROz9dJDWlLZd0E9oyaIxp9J/Vso2ikdsfsbdxkJUFVX9OGXOEmAj9p/hMQ4gi+RMtS0pLQ==
X-Received: by 2002:adf:d4c2:0:b0:317:ddd3:1aed with SMTP id
 w2-20020adfd4c2000000b00317ddd31aedmr10422745wrk.68.1696269723540; 
 Mon, 02 Oct 2023 11:02:03 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g16-20020adfa490000000b003232380ffd5sm20650839wrb.106.2023.10.02.11.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 11:02:02 -0700 (PDT)
Message-ID: <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
Date: Mon, 2 Oct 2023 20:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Alex Deucher <alexdeucher@gmail.com>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <202310020952.E7DE0948C0@keescook>
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMDIuMTAuMjMgdW0gMTg6NTMgc2NocmllYiBLZWVzIENvb2s6Cj4gT24gTW9uLCBPY3QgMDIs
IDIwMjMgYXQgMTE6MDY6MTlBTSAtMDQwMCwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBPbiBNb24s
IE9jdCAyLCAyMDIzIGF0IDU6MjDigK9BTSBDaHJpc3RpYW4gS8O2bmlnCj4+IDxja29lbmlnLmxl
aWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+PiBBbSAyOS4wOS4yMyB1bSAyMTozMyBz
Y2hyaWViIEtlZXMgQ29vazoKPj4+PiBPbiBGcmksIDIyIFNlcCAyMDIzIDEwOjMyOjA1IC0wNzAw
LCBLZWVzIENvb2sgd3JvdGU6Cj4+Pj4+IFRoaXMgaXMgYSBiYXRjaCBvZiBwYXRjaGVzIHRvdWNo
aW5nIGRybSBmb3IgcHJlcGFyaW5nIGZvciB0aGUgY29taW5nCj4+Pj4+IGltcGxlbWVudGF0aW9u
IGJ5IEdDQyBhbmQgQ2xhbmcgb2YgdGhlIF9fY291bnRlZF9ieSBhdHRyaWJ1dGUuIEZsZXhpYmxl
Cj4+Pj4+IGFycmF5IG1lbWJlcnMgYW5ub3RhdGVkIHdpdGggX19jb3VudGVkX2J5IGNhbiBoYXZl
IHRoZWlyIGFjY2Vzc2VzCj4+Pj4+IGJvdW5kcy1jaGVja2VkIGF0IHJ1bi10aW1lIGNoZWNraW5n
IHZpYSBDT05GSUdfVUJTQU5fQk9VTkRTIChmb3IgYXJyYXkKPj4+Pj4gaW5kZXhpbmcpIGFuZCBD
T05GSUdfRk9SVElGWV9TT1VSQ0UgKGZvciBzdHJjcHkvbWVtY3B5LWZhbWlseSBmdW5jdGlvbnMp
Lgo+Pj4+Pgo+Pj4+PiBBcyBmb3VuZCB3aXRoIENvY2NpbmVsbGVbMV0sIGFkZCBfX2NvdW50ZWRf
YnkgdG8gc3RydWN0cyB0aGF0IHdvdWxkCj4+Pj4+IGJlbmVmaXQgZnJvbSB0aGUgYW5ub3RhdGlv
bi4KPj4+Pj4KPj4+Pj4gWy4uLl0KPj4+PiBTaW5jZSB0aGlzIGdvdCBBY2tzLCBJIGZpZ3VyZSBJ
IHNob3VsZCBjYXJyeSBpdCBpbiBteSB0cmVlLiBMZXQgbWUga25vdwo+Pj4+IGlmIHRoaXMgc2hv
dWxkIGdvIHZpYSBkcm0gaW5zdGVhZC4KPj4+Pgo+Pj4+IEFwcGxpZWQgdG8gZm9yLW5leHQvaGFy
ZGVuaW5nLCB0aGFua3MhCj4+Pj4KPj4+PiBbMS85XSBkcm0vYW1kL3BtOiBBbm5vdGF0ZSBzdHJ1
Y3Qgc211MTBfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlIHdpdGggX19jb3VudGVkX2J5Cj4+Pj4g
ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tlZXMvYy9hNjA0NmFjNjU5ZDYKPj4+IFNU
T1AhIEluIGEgZm9sbG93IHVwIGRpc2N1c3Npb24gQWxleCBhbmQgSSBmaWd1cmVkIG91dCB0aGF0
IHRoaXMgd29uJ3Qgd29yay4KPiBJJ20gc28gY29uZnVzZWQ7IGZyb20gdGhlIGRpc2N1c3Npb24g
SSBzYXcgdGhhdCBBbGV4IHNhaWQgYm90aCBpbnN0YW5jZXMKPiB3ZXJlIGZhbHNlIHBvc2l0aXZl
cz8KPgo+Pj4gVGhlIHZhbHVlIGluIHRoZSBzdHJ1Y3R1cmUgaXMgYnl0ZSBzd2FwcGVkIGJhc2Vk
IG9uIHNvbWUgZmlybXdhcmUKPj4+IGVuZGlhbm5lc3Mgd2hpY2ggbm90IG5lY2Vzc2FyeSBtYXRj
aGVzIHRoZSBDUFUgZW5kaWFubmVzcy4KPj4gU01VMTAgaXMgQVBVIG9ubHkgc28gdGhlIGVuZGlh
bmVzcyBvZiB0aGUgU01VIGZpcm13YXJlIGFuZCB0aGUgQ1BVCj4+IHdpbGwgYWx3YXlzIG1hdGNo
Lgo+IFdoaWNoIEkgdGhpbmsgaXMgd2hhdCBpcyBiZWluZyBzYWlkIGhlcmU/Cj4KPj4+IFBsZWFz
ZSByZXZlcnQgdGhhdCBvbmUgZnJvbSBnb2luZyB1cHN0cmVhbSBpZiBpdCdzIGFscmVhZHkgb24g
aXQncyB3YXkuCj4+Pgo+Pj4gQW5kIGJlY2F1c2Ugb2YgdGhvc2UgcmVhc29ucyBJIHN0cm9uZ2x5
IHRoaW5rIHRoYXQgcGF0Y2hlcyBsaWtlIHRoaXMKPj4+IHNob3VsZCBnbyB0aHJvdWdoIHRoZSBE
Uk0gdHJlZSA6KQo+IFN1cmUsIHRoYXQncyBmaW5lIC0tIHBsZWFzZSBsZXQgbWUga25vdy4gSXQg
d2FzIG90aGVycyBBY2tlZC9ldGMuIFdobwo+IHNob3VsZCBjYXJyeSB0aGVzZSBwYXRjaGVzPwoK
UHJvYmFibHkgYmVzdCBpZiB0aGUgcmVsZXZhbnQgbWFpbnRhaW5lciBwaWNrIHRoZW0gdXAgaW5k
aXZpZHVhbGx5LgoKU29tZSBvZiB0aG9zZSBzdHJ1Y3R1cmVzIGFyZSBmaWxsZWQgaW4gYnkgZmly
bXdhcmUvaGFyZHdhcmUgYW5kIG9ubHkgdGhlIAptYWludGFpbmVycyBjYW4ganVkZ2UgaWYgdGhh
dCB2YWx1ZSBhY3R1YWxseSBtYXRjaGVzIHdoYXQgdGhlIGNvbXBpbGVyIApuZWVkcy4KCldlIGhh
dmUgY2FzZXMgd2hlcmUgaW5kaXZpZHVhbCBiaXRzIGFyZSB1c2VkIGFzIGZsYWdzIG9yIHdoZW4g
dGhlIHNpemUgCmlzIGJ5dGUgc3dhcHBlZCBldGMuLi4KCkV2ZW4gQWxleCBhbmQgSSBkaWRuJ3Qg
aW1tZWRpYXRlbHkgc2F5IGhvdyBhbmQgd2hlcmUgdGhhdCBmaWVsZCBpcyAKYWN0dWFsbHkgdXNl
ZCBhbmQgaGFkIHRvIGRpZyB0aGF0IHVwLiBUaGF0J3Mgd2hlcmUgdGhlIGNvbmZ1c2lvbiBjYW1l
IGZyb20uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gVGhhbmtzIQo+Cj4gLUtlZXMKPgo+Cj4+
PiBSZWdhcmRzLAo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+PiBbMi85XSBkcm0vYW1kZ3B1L2Rpc2Nv
dmVyeTogQW5ub3RhdGUgc3RydWN0IGlwX2h3X2luc3RhbmNlIHdpdGggX19jb3VudGVkX2J5Cj4+
Pj4gICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tlZXMvYy80ZGYzMzA4OWI0NmYKPj4+
PiBbMy85XSBkcm0vaTkxNS9zZWxmdGVzdHM6IEFubm90YXRlIHN0cnVjdCBwZXJmX3NlcmllcyB3
aXRoIF9fY291bnRlZF9ieQo+Pj4+ICAgICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9rZWVz
L2MvZmZkM2Y4MjNiZGY2Cj4+Pj4gWzQvOV0gZHJtL21zbS9kcHU6IEFubm90YXRlIHN0cnVjdCBk
cHVfaHdfaW50ciB3aXRoIF9fY291bnRlZF9ieQo+Pj4+ICAgICAgICAgaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9rZWVzL2MvMmRlMzVhOTg5Yjc2Cj4+Pj4gWzUvOV0gZHJtL25vdXZlYXUvcG06IEFu
bm90YXRlIHN0cnVjdCBudmttX3BlcmZkb20gd2l0aCBfX2NvdW50ZWRfYnkKPj4+PiAgICAgICAg
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcva2Vlcy9jLzE4OGFlYjA4YmZhYQo+Pj4+IFs2LzldIGRy
bS92YzQ6IEFubm90YXRlIHN0cnVjdCB2YzRfcGVyZm1vbiB3aXRoIF9fY291bnRlZF9ieQo+Pj4+
ICAgICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9rZWVzL2MvNTlhNTRkYzg5NmMzCj4+Pj4g
WzcvOV0gZHJtL3ZpcnRpbzogQW5ub3RhdGUgc3RydWN0IHZpcnRpb19ncHVfb2JqZWN0X2FycmF5
IHdpdGggX19jb3VudGVkX2J5Cj4+Pj4gICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2tl
ZXMvYy81Y2Q0NzZkZTMzYWYKPj4+PiBbOC85XSBkcm0vdm13Z2Z4OiBBbm5vdGF0ZSBzdHJ1Y3Qg
dm13X3N1cmZhY2VfZGlydHkgd2l0aCBfX2NvdW50ZWRfYnkKPj4+PiAgICAgICAgIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcva2Vlcy9jL2I0MjZmMmU1MzU2YQo+Pj4+IFs5LzldIGRybS92M2Q6IEFu
bm90YXRlIHN0cnVjdCB2M2RfcGVyZm1vbiB3aXRoIF9fY291bnRlZF9ieQo+Pj4+ICAgICAgICAg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9rZWVzL2MvZGM2NjJmYTFiMGU0Cj4+Pj4KPj4+PiBUYWtl
IGNhcmUsCj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
