Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD3DE75451
	for <virtualization@archiver.kernel.org>; Thu,  5 Oct 2023 16:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CAC082ECF;
	Thu,  5 Oct 2023 16:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CAC082ECF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZqKuvEyz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPWBXfGNBNg0; Thu,  5 Oct 2023 16:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9512D83145;
	Thu,  5 Oct 2023 16:16:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9512D83145
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67A4EC0071;
	Thu,  5 Oct 2023 16:16:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 619C1C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 16:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3042E60F10
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 16:16:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3042E60F10
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ZqKuvEyz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IWgGBmdPMd2j
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 16:16:24 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBAC760F5F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 16:16:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBAC760F5F
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-692779f583fso931389b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Oct 2023 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696522583; x=1697127383;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xpZu6lqlyEvAN7T4WQyZZbFvUnbP262xmkxGmbRAMgI=;
 b=ZqKuvEyzWgWhIFs7/X5QYe6f/mZqyEsYJQhvHdcb9/lsjAdsNbwkn/ChcIJ3wc4eOw
 dyw/0xaG0OszjpUPu0moDUpBbQYg3GVf0AJX0mhIeb0N3vrOi7Uatlf8asqQJJNrrgq2
 XdeCmwEnGGbZsR0lThvmcCQUu2dujnT3MmmzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696522583; x=1697127383;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpZu6lqlyEvAN7T4WQyZZbFvUnbP262xmkxGmbRAMgI=;
 b=mO2i2HzrZsIOW9f4WoGwcxHTC+CxsIzJPb23PvyGBXV6L5AQDfF+qtnKf9DAGqzKB6
 hwYNDRvpEMZJiIOzw1+uNxoc1Fb+KXiIlAk5t43jFCb2Em+0QfEM2f1oh2pnxxdS0UZu
 MiysHVDFIs9YzYo3kaeE+g19z36AK/d+6qBcBVVuMe/+w0lRMbGiUO9H6DNjztWluRUc
 3UxHMlkaX7RI4Eij1UmJfqIlGIcH5sI3McSeEWcDF1CHf+2CtsXLVCNsJKbH+MVwae1+
 gJ4HrFbdjhRZ7aYwGK65BbqunX/OnyITYYKvOYQzJYENkPctugM1g0Ovh1YdBce1kx9O
 HoOg==
X-Gm-Message-State: AOJu0YyWgO4l4gR+o+HvQ3TJ5pMQUYXHQfP+8pnFp2084bW9Y8+Sw4pB
 fMvkVhibF5KLQ2G5p2Mnassexg==
X-Google-Smtp-Source: AGHT+IFXrkOsf8NbaVIJ+XbxUqZLmBzsbpEzEa+s/qtoOV9I4bEmWp8zGBhz1z3Jkv2V6R2XFzEStQ==
X-Received: by 2002:a05:6a20:9152:b0:14e:509:1d7b with SMTP id
 x18-20020a056a20915200b0014e05091d7bmr6301990pzc.8.1696522583218; 
 Thu, 05 Oct 2023 09:16:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 a26-20020a62e21a000000b00672ea40b8a9sm1612998pfi.170.2023.10.05.09.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 09:16:23 -0700 (PDT)
Date: Thu, 5 Oct 2023 09:16:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Message-ID: <202310050915.ABB0419C@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
 <202310021107.9BB46FB8E@keescook>
 <0be2dfa4-b6c1-f62a-66e1-615da7aa3c76@amd.com>
 <202310021122.B6DA850FB0@keescook>
 <d58bbe17-efa7-4548-9c7d-bf0310d31ef5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d58bbe17-efa7-4548-9c7d-bf0310d31ef5@gmail.com>
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

T24gVGh1LCBPY3QgMDUsIDIwMjMgYXQgMTE6NDI6MzhBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAwMi4xMC4yMyB1bSAyMDoyMiBzY2hyaWViIEtlZXMgQ29vazoKPiA+IE9u
IE1vbiwgT2N0IDAyLCAyMDIzIGF0IDA4OjExOjQxUE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4gPiA+IEFtIDAyLjEwLjIzIHVtIDIwOjA4IHNjaHJpZWIgS2VlcyBDb29rOgo+ID4g
PiA+IE9uIE1vbiwgT2N0IDAyLCAyMDIzIGF0IDA4OjAxOjU3UE0gKzAyMDAsIENocmlzdGlhbiBL
w7ZuaWcgd3JvdGU6Cj4gPiA+ID4gPiBBbSAwMi4xMC4yMyB1bSAxODo1MyBzY2hyaWViIEtlZXMg
Q29vazoKPiA+ID4gPiA+ID4gT24gTW9uLCBPY3QgMDIsIDIwMjMgYXQgMTE6MDY6MTlBTSAtMDQw
MCwgQWxleCBEZXVjaGVyIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgT2N0IDIsIDIwMjMg
YXQgNToyMOKAr0FNIENocmlzdGlhbiBLw7ZuaWcKPiA+ID4gPiA+ID4gPiA8Y2tvZW5pZy5sZWlj
aHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gQW0gMjkuMDkuMjMg
dW0gMjE6MzMgc2NocmllYiBLZWVzIENvb2s6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgMjIg
U2VwIDIwMjMgMTA6MzI6MDUgLTA3MDAsIEtlZXMgQ29vayB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
ID4gPiBUaGlzIGlzIGEgYmF0Y2ggb2YgcGF0Y2hlcyB0b3VjaGluZyBkcm0gZm9yIHByZXBhcmlu
ZyBmb3IgdGhlIGNvbWluZwo+ID4gPiA+ID4gPiA+ID4gPiA+IGltcGxlbWVudGF0aW9uIGJ5IEdD
QyBhbmQgQ2xhbmcgb2YgdGhlIF9fY291bnRlZF9ieSBhdHRyaWJ1dGUuIEZsZXhpYmxlCj4gPiA+
ID4gPiA+ID4gPiA+ID4gYXJyYXkgbWVtYmVycyBhbm5vdGF0ZWQgd2l0aCBfX2NvdW50ZWRfYnkg
Y2FuIGhhdmUgdGhlaXIgYWNjZXNzZXMKPiA+ID4gPiA+ID4gPiA+ID4gPiBib3VuZHMtY2hlY2tl
ZCBhdCBydW4tdGltZSBjaGVja2luZyB2aWEgQ09ORklHX1VCU0FOX0JPVU5EUyAoZm9yIGFycmF5
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gaW5kZXhpbmcpIGFuZCBDT05GSUdfRk9SVElGWV9TT1VSQ0Ug
KGZvciBzdHJjcHkvbWVtY3B5LWZhbWlseSBmdW5jdGlvbnMpLgo+ID4gPiA+ID4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiA+ID4gPiA+IEFzIGZvdW5kIHdpdGggQ29jY2luZWxsZVsxXSwgYWRkIF9f
Y291bnRlZF9ieSB0byBzdHJ1Y3RzIHRoYXQgd291bGQKPiA+ID4gPiA+ID4gPiA+ID4gPiBiZW5l
Zml0IGZyb20gdGhlIGFubm90YXRpb24uCj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+ID4gWy4uLl0KPiA+ID4gPiA+ID4gPiA+ID4gU2luY2UgdGhpcyBnb3QgQWNrcywgSSBm
aWd1cmUgSSBzaG91bGQgY2FycnkgaXQgaW4gbXkgdHJlZS4gTGV0IG1lIGtub3cKPiA+ID4gPiA+
ID4gPiA+ID4gaWYgdGhpcyBzaG91bGQgZ28gdmlhIGRybSBpbnN0ZWFkLgo+ID4gPiA+ID4gPiA+
ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gQXBwbGllZCB0byBmb3ItbmV4dC9oYXJkZW5pbmcsIHRo
YW5rcyEKPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IFsxLzldIGRybS9hbWQv
cG06IEFubm90YXRlIHN0cnVjdCBzbXUxMF92b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUgd2l0aCBf
X2NvdW50ZWRfYnkKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcva2Vlcy9jL2E2MDQ2YWM2NTlkNgo+ID4gPiA+ID4gPiA+ID4gU1RPUCEgSW4gYSBmb2xs
b3cgdXAgZGlzY3Vzc2lvbiBBbGV4IGFuZCBJIGZpZ3VyZWQgb3V0IHRoYXQgdGhpcyB3b24ndCB3
b3JrLgo+ID4gPiA+ID4gPiBJJ20gc28gY29uZnVzZWQ7IGZyb20gdGhlIGRpc2N1c3Npb24gSSBz
YXcgdGhhdCBBbGV4IHNhaWQgYm90aCBpbnN0YW5jZXMKPiA+ID4gPiA+ID4gd2VyZSBmYWxzZSBw
b3NpdGl2ZXM/Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gVGhlIHZhbHVlIGluIHRoZSBz
dHJ1Y3R1cmUgaXMgYnl0ZSBzd2FwcGVkIGJhc2VkIG9uIHNvbWUgZmlybXdhcmUKPiA+ID4gPiA+
ID4gPiA+IGVuZGlhbm5lc3Mgd2hpY2ggbm90IG5lY2Vzc2FyeSBtYXRjaGVzIHRoZSBDUFUgZW5k
aWFubmVzcy4KPiA+ID4gPiA+ID4gPiBTTVUxMCBpcyBBUFUgb25seSBzbyB0aGUgZW5kaWFuZXNz
IG9mIHRoZSBTTVUgZmlybXdhcmUgYW5kIHRoZSBDUFUKPiA+ID4gPiA+ID4gPiB3aWxsIGFsd2F5
cyBtYXRjaC4KPiA+ID4gPiA+ID4gV2hpY2ggSSB0aGluayBpcyB3aGF0IGlzIGJlaW5nIHNhaWQg
aGVyZT8KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBQbGVhc2UgcmV2ZXJ0IHRoYXQgb25l
IGZyb20gZ29pbmcgdXBzdHJlYW0gaWYgaXQncyBhbHJlYWR5IG9uIGl0J3Mgd2F5Lgo+ID4gPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBBbmQgYmVjYXVzZSBvZiB0aG9zZSByZWFzb25zIEkg
c3Ryb25nbHkgdGhpbmsgdGhhdCBwYXRjaGVzIGxpa2UgdGhpcwo+ID4gPiA+ID4gPiA+ID4gc2hv
dWxkIGdvIHRocm91Z2ggdGhlIERSTSB0cmVlIDopCj4gPiA+ID4gPiA+IFN1cmUsIHRoYXQncyBm
aW5lIC0tIHBsZWFzZSBsZXQgbWUga25vdy4gSXQgd2FzIG90aGVycyBBY2tlZC9ldGMuIFdobwo+
ID4gPiA+ID4gPiBzaG91bGQgY2FycnkgdGhlc2UgcGF0Y2hlcz8KPiA+ID4gPiA+IFByb2JhYmx5
IGJlc3QgaWYgdGhlIHJlbGV2YW50IG1haW50YWluZXIgcGljayB0aGVtIHVwIGluZGl2aWR1YWxs
eS4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU29tZSBvZiB0aG9zZSBzdHJ1Y3R1cmVzIGFyZSBmaWxs
ZWQgaW4gYnkgZmlybXdhcmUvaGFyZHdhcmUgYW5kIG9ubHkgdGhlCj4gPiA+ID4gPiBtYWludGFp
bmVycyBjYW4ganVkZ2UgaWYgdGhhdCB2YWx1ZSBhY3R1YWxseSBtYXRjaGVzIHdoYXQgdGhlIGNv
bXBpbGVyCj4gPiA+ID4gPiBuZWVkcy4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gV2UgaGF2ZSBjYXNl
cyB3aGVyZSBpbmRpdmlkdWFsIGJpdHMgYXJlIHVzZWQgYXMgZmxhZ3Mgb3Igd2hlbiB0aGUgc2l6
ZSBpcwo+ID4gPiA+ID4gYnl0ZSBzd2FwcGVkIGV0Yy4uLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBF
dmVuIEFsZXggYW5kIEkgZGlkbid0IGltbWVkaWF0ZWx5IHNheSBob3cgYW5kIHdoZXJlIHRoYXQg
ZmllbGQgaXMgYWN0dWFsbHkKPiA+ID4gPiA+IHVzZWQgYW5kIGhhZCB0byBkaWcgdGhhdCB1cC4g
VGhhdCdzIHdoZXJlIHRoZSBjb25mdXNpb24gY2FtZSBmcm9tLgo+ID4gPiA+IE9rYXksIEkndmUg
ZHJvcHBlZCB0aGVtIGFsbCBmcm9tIG15IHRyZWUuIFNldmVyYWwgaGFkIEFja3MvUmV2aWV3cywg
c28KPiA+ID4gPiBob3BlZnVsbHkgdGhvc2UgY2FuIGdldCBwaWNrZWQgdXAgZm9yIHRoZSBEUk0g
dHJlZT8KPiA+ID4gSSB3aWxsIHBpY2sgdGhvc2UgdXAgdG8gZ28gdGhyb3VnaCBkcm0tbWlzYy1u
ZXh0Lgo+ID4gPiAKPiA+ID4gR29pbmcgdG8gcGluZyBtYWludGFpbmVycyBvbmNlIG1vcmUgd2hl
biBJJ20gbm90IHN1cmUgaWYgc3R1ZmYgaXMgY29ycmVjdCBvcgo+ID4gPiBub3QuCj4gPiBTb3Vu
ZHMgZ3JlYXQ7IHRoYW5rcyEKPiAKPiBJIHdhc24ndCAxMDAlIHN1cmUgZm9yIHRoZSBWQzQgcGF0
Y2gsIGJ1dCBwdXNoZWQgdGhlIHdob2xlIHNldCB0bwo+IGRybS1taXNjLW5leHQgYW55d2F5Lgo+
IAo+IFRoaXMgYWxzbyBtZWFucyB0aGF0IHRoZSBwYXRjaGVzIGFyZSBub3cgYXV0byBtZXJnZWQg
aW50byB0aGUgZHJtLXRpcAo+IGludGVncmF0aW9uIGJyYW5jaCBhbmQgc2hvdWxkIGFueSBidWls
ZCBvciB1bml0IHRlc3QgZ28gYm9vbSB3ZSBzaG91bGQKPiBub3RpY2UgaW1tZWRpYXRlbHkgYW5k
IGNhbiByZXZlcnQgaXQgcHJldHR5IGVhc2lseS4KClRoYW5rcyB2ZXJ5IG11Y2g7IEknbGwga2Vl
cCBhbiBleWUgb3V0IGZvciBhbnkgcmVwb3J0cy4KCi0tIApLZWVzIENvb2sKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
