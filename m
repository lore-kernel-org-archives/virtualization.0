Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED03CE7AB5
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 17:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C0B340195;
	Mon, 25 Sep 2023 17:52:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C0B340195
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kNAxiGvs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aDR3rOuIsTGf; Mon, 25 Sep 2023 17:52:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7A08640A87;
	Mon, 25 Sep 2023 17:52:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A08640A87
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B593C0039;
	Mon, 25 Sep 2023 17:52:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AC7DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F82C6125F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:52:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F82C6125F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=kNAxiGvs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ePHToWH_VxvH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:52:35 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31CAC61259
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:52:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31CAC61259
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so5180961b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695664354; x=1696269154;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YKkjlOQ/GPkFrKX9bDbfTnpErQ+3hoiSxDUiC5xM1v4=;
 b=kNAxiGvsuhz+CmYgWGiW3mnPQByY68dPK3P2jXUDL4+fG0povRiPAU1QWgnswAeEx8
 16W9EdFiz5teVTiyfKcO+ljr226f/AcZWt130WWKTWnJBbdm3vzNM6pivQuVeqsRHdXY
 QPY4ZpAeE+gTH+Y49c+WP6z9IPNB3k5+9wwtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664354; x=1696269154;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YKkjlOQ/GPkFrKX9bDbfTnpErQ+3hoiSxDUiC5xM1v4=;
 b=hG7m3Z934L3Iy6eEijxxvsXkJP6bJU842p6TvyA3aMSWvGJVB8cby1hjzkX2KHIwpY
 DwpkUaVHIBl6caZzkOpmeROjE5bQFCgAjwems9IvKc3DqIQ5DVc1IDdDrK1Ga2QahjEQ
 xXpOp7ShiNRAVAaRqVjl4cruYLuIFA7tydL77b12QJGjMix9J5WJAwFrUCWiQ3GHPjLf
 JH8iB7RkQKnp80UFA7BCECHYEA8ak8/8GBQR4TclJNfzZhn8M2URVsx3Re+XSaV6uDTa
 cUrUQGN4ZDlx4MN9+daJYJg+bZpjPeEh/5hC4FuTEkjywj44nWbloSmXWQWOXCZ29vu+
 yuwQ==
X-Gm-Message-State: AOJu0Yy9Xuiwra5HeHqE3SaAmieDQN09QEvHPG/CG8HAJbBsLxLpADHZ
 kbWEKIzuxenRfY1tO2MbQURJ8A==
X-Google-Smtp-Source: AGHT+IGbOeCWSbVNrAKbhj9D9vKUNI/wwQgYtn6Pn0L0F9XDlvUNhyZJFZGUIjA69DGrRpph9k1vJQ==
X-Received: by 2002:a05:6a20:3ca6:b0:13e:90aa:8c8b with SMTP id
 b38-20020a056a203ca600b0013e90aa8c8bmr576006pzj.4.1695664354536; 
 Mon, 25 Sep 2023 10:52:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 h19-20020a633853000000b0057c3b21c01dsm6967245pgn.49.2023.09.25.10.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:52:33 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:52:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct
 smu10_voltage_dependency_table with __counted_by
Message-ID: <202309251051.EE3ECE7B@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-1-keescook@chromium.org>
 <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
 <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2635922e-f52a-4e91-40c6-4f1358972786@amd.com>
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
 Nathan Chancellor <nathan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 virtualization@lists.linux-foundation.org, Sean Paul <sean@poorly.run>,
 Neil Armstrong <neil.armstrong@linaro.org>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Le Ma <le.ma@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Melissa Wen <mwen@igalia.com>,
 Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@intel.com>,
 freedreno@lists.freedesktop.org, John Harrison <john.c.harrison@intel.com>,
 linux-hardening@vger.kernel.org
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMDg6MzA6MzBBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyMi4wOS4yMyB1bSAxOTo0MSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+
IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDE6MzLigK9QTSBLZWVzIENvb2sgPGtlZXNjb29rQGNo
cm9taXVtLm9yZz4gd3JvdGU6Cj4gPiA+IFByZXBhcmUgZm9yIHRoZSBjb21pbmcgaW1wbGVtZW50
YXRpb24gYnkgR0NDIGFuZCBDbGFuZyBvZiB0aGUgX19jb3VudGVkX2J5Cj4gPiA+IGF0dHJpYnV0
ZS4gRmxleGlibGUgYXJyYXkgbWVtYmVycyBhbm5vdGF0ZWQgd2l0aCBfX2NvdW50ZWRfYnkgY2Fu
IGhhdmUKPiA+ID4gdGhlaXIgYWNjZXNzZXMgYm91bmRzLWNoZWNrZWQgYXQgcnVuLXRpbWUgY2hl
Y2tpbmcgdmlhIENPTkZJR19VQlNBTl9CT1VORFMKPiA+ID4gKGZvciBhcnJheSBpbmRleGluZykg
YW5kIENPTkZJR19GT1JUSUZZX1NPVVJDRSAoZm9yIHN0cmNweS9tZW1jcHktZmFtaWx5Cj4gPiA+
IGZ1bmN0aW9ucykuCj4gPiA+IAo+ID4gPiBBcyBmb3VuZCB3aXRoIENvY2NpbmVsbGVbMV0sIGFk
ZCBfX2NvdW50ZWRfYnkgZm9yIHN0cnVjdCBzbXUxMF92b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUu
Cj4gPiA+IAo+ID4gPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2tlZXMva2VybmVsLXRvb2xzL2Js
b2IvdHJ1bmsvY29jY2luZWxsZS9leGFtcGxlcy9jb3VudGVkX2J5LmNvY2NpCj4gPiA+IAo+ID4g
PiBDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPiA+ID4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+ID4gQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gPiBDYzogIlBhbiwgWGluaHVpIiA8WGlu
aHVpLlBhbkBhbWQuY29tPgo+ID4gPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGdtYWlsLmNv
bT4KPiA+ID4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiA+ID4gQ2M6IFhp
YW9qaWFuIER1IDxYaWFvamlhbi5EdUBhbWQuY29tPgo+ID4gPiBDYzogSHVhbmcgUnVpIDxyYXku
aHVhbmdAYW1kLmNvbT4KPiA+ID4gQ2M6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+
Cj4gPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gPiBDYzogZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLZWVzIENvb2sg
PGtlZXNjb29rQGNocm9taXVtLm9yZz4KPiA+IEFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gCj4gTWhtLCBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBh
IGdvb2QgaWRlYS4gVGhhdCBpcyBhIHN0cnVjdHVyZSBmaWxsZWQgaW4gYnkKPiB0aGUgZmlybXdh
cmUsIGlzbid0IGl0Pwo+IAo+IFRoYXQgd291bGQgaW1wbHkgdGhhdCB3ZSBtaWdodCBuZWVkIHRv
IGJ5dGUgc3dhcCBjb3VudCBiZWZvcmUgaXQgaXMKPiBjaGVja2FibGUuCgpUaGUgc2NyaXB0IGZv
dW5kIHRoaXMgaW5zdGFuY2UgYmVjYXVzZSBvZiB0aGlzOgoKc3RhdGljIGludCBzbXUxMF9nZXRf
Y2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsCiAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzbXUxMF92b2x0YWdlX2RlcGVuZGVuY3lfdGFi
bGUgKipwcHRhYmxlLAogICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBudW1fZW50cnks
IGNvbnN0IERwbUNsb2NrX3QgKnBjbGtfZGVwZW5kZW5jeV90YWJsZSkKewogICAgICAgIHVpbnQz
Ml90IGk7CiAgICAgICAgc3RydWN0IHNtdTEwX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJsZSAqcHRh
YmxlOwoKICAgICAgICBwdGFibGUgPSBremFsbG9jKHN0cnVjdF9zaXplKHB0YWJsZSwgZW50cmll
cywgbnVtX2VudHJ5KSwgR0ZQX0tFUk5FTCk7CiAgICAgICAgaWYgKE5VTEwgPT0gcHRhYmxlKQog
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07CgogICAgICAgIHB0YWJsZS0+Y291bnQgPSBu
dW1fZW50cnk7CgpTbyB0aGUgaW1wbGljYXRpb24gaXMgdGhhdCBpdCdzIG5hdGl2ZSBieXRlIG9y
ZGVyLi4uIGJ1dCB5b3UgdGVsbCBtZSEgSQpjZXJ0YWlubHkgZG9uJ3Qgd2FudCB0aGlzIGFubm90
YXRpb24gaWYgaXQncyBnb2luZyB0byBicmVhayBzdHVmZi4gOikKCi0tIApLZWVzIENvb2sKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
