Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35219CD484B
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFA0641C1F;
	Fri, 22 Sep 2023 17:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFA0641C1F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=N4Rm8vEX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwIvQ6NTUt-U; Fri, 22 Sep 2023 17:35:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F1D8641753;
	Fri, 22 Sep 2023 17:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1D8641753
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB580C0DD2;
	Fri, 22 Sep 2023 17:35:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4925C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66C7E421DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66C7E421DE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tda9VAAsoQc7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:20 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1726B4224E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1726B4224E
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c47309a8ccso28297485ad.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695403939; x=1696008739;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+ctTEyoq7sOv+FAZHxESomcnOOr3ZQuAJoEIOqh0C4=;
 b=N4Rm8vEXlDBkgYuUBxCV47wqzOV0f6sgNWagkn7XT2B0DIloyG6aEXpOzYkb67DLmd
 /eYuQn9qvAQy6BMJ7kMnDX6dv4R/cIzYixAkrxSdx4f/+NpjLUnqRO1X/0gHuy3a0CTc
 jumInY9syiU13SNthWmm+m7yeZZWr1oD4PElA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695403939; x=1696008739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+ctTEyoq7sOv+FAZHxESomcnOOr3ZQuAJoEIOqh0C4=;
 b=YzjDqg/AgJ3hGOvHFgjv78vrbmvwC6hRK/g41fIPwQee1GaKqxcIgNmb24gI2qyYj/
 91TwSs8YIwt1uUkdxiZ2nYCnONsmSpASaAJX5MahAuNmoZZI08lb6YQhQKcUL0iPqayK
 6rWHhojPIlY66DVvrB+sit3BAohWVDBLQtwI23PVTpBosPHc+Pv5ug6w2DWgt7PfVwya
 7s+B/4faO5uaxYqtx+Sr1dqhpJHLqwoBEfhzLgRXhX2f8feqOYEG6QqG1cOkIUel2Vyw
 +iBGOwniKp7ggG/ulEuCVryfmNXAJFhtBqzXH59szniedjPT5PE3h5S/0vGscy2LSbjn
 9R9Q==
X-Gm-Message-State: AOJu0YxaIISPKovnaQ8VvnXYBBntteHPoDXZ9XpISbFGpNQOK2lLANb+
 OEuEOTVfN6R9ij/f3iGwcDSgkg==
X-Google-Smtp-Source: AGHT+IGC6/6NdvEqz8he++fdJuEaamt9Op5nnYZ05uajn7JWoal4nRh6sAA+e6vH/dWEyyl5jl0kkA==
X-Received: by 2002:a17:903:32cf:b0:1c0:e87e:52ba with SMTP id
 i15-20020a17090332cf00b001c0e87e52bamr547482plr.2.1695403939425; 
 Fri, 22 Sep 2023 10:32:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 j5-20020a170902da8500b001c57aac6e5esm3763379plx.23.2023.09.22.10.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:32:17 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH 2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance with
 __counted_by
Date: Fri, 22 Sep 2023 10:32:07 -0700
Message-Id: <20230922173216.3823169-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=keescook@chromium.org; 
 h=from:subject;
 bh=i2UpbGfuADbvlbxlhkLDZa/xyj6FED75tdnO2fZlmjo=; 
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+dEehHl9nbm4bhCFwpbMmpO3Xxql5kFxhRj
 Diayf24WdaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PnQAKCRCJcvTf3G3A
 JvkkEACyRaaPJcAJJrT69OHPNJ7Sh8M7AKH2fzwSzceuPqxB6RysYYS6VR2iPdaDZg9zSS+vTbb
 fL60uv9o1ah81G8VJPhZppP9CtgmmA8a42Bpbs53luiTn/LGzycDXWPETOIgJGNsrJMgTFQyPMo
 241VVShLmM8kxtLnJkLOnDZEqzjh4lSZG5ygNcH9YpR0LH3S9yhYSaBm0oamf3UpID1Xs/g89RE
 2GjQlWgZzPdM7WCNcNNAIhK00fTWSD5DmnFGm50TziH8XWc8eGZZ2VknCk1GbO1UtJO7OW7lysZ
 dzxYyw9Eifo8NVwr14wp43rm0towIlCQv++/9z7OLpwblt6E0YNRNpTjv9DQV+xS5euSf4ETfjV
 IJ9vdSq6WjnidZkTBKdhROCuszJxRQ9b3HqXm169h7IYEdXvDeMvTQ2xgv9UwiFYpPlLImhrCYh
 r/oOkRSzfxf22LJvTsqX/WXIRpOCLm1gQa2ApJjyfzEXAegAaVehjC7856bxlgo+pE5tqm7PAvm
 JLb5hweD/O8L+7Tf7ij2oggZ9HmU2VGBIGVs0/EP7R6GeKLWO5KBBVa3/aADP01hJ2ZTfyjJsLl
 NqBiuVwLDZSWs6x18B1633XvJJtLwLIUg5eA8U/N4Q1qXUMezt3ySBuq4TSxO56Xod8iBUwzCfw
 TsBbpN+0JCLa/Ag==
X-Developer-Key: i=keescook@chromium.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Matthew Brost <matthew.brost@intel.com>, Karol Herbst <kherbst@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, amd-gfx@lists.freedesktop.org,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Nathan Chancellor <nathan@kernel.org>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
 Lyude Paul <lyude@redhat.com>, Kees Cook <keescook@chromium.org>,
 Yifan Zhang <yifan1.zhang@amd.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Melissa Wen <mwen@igalia.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, Le Ma <le.ma@amd.com>,
 freedreno@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Nirmoy Das <nirmoy.das@intel.com>,
 Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Harrison <john.c.harrison@Intel.com>,
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

UHJlcGFyZSBmb3IgdGhlIGNvbWluZyBpbXBsZW1lbnRhdGlvbiBieSBHQ0MgYW5kIENsYW5nIG9m
IHRoZSBfX2NvdW50ZWRfYnkKYXR0cmlidXRlLiBGbGV4aWJsZSBhcnJheSBtZW1iZXJzIGFubm90
YXRlZCB3aXRoIF9fY291bnRlZF9ieSBjYW4gaGF2ZQp0aGVpciBhY2Nlc3NlcyBib3VuZHMtY2hl
Y2tlZCBhdCBydW4tdGltZSBjaGVja2luZyB2aWEgQ09ORklHX1VCU0FOX0JPVU5EUwooZm9yIGFy
cmF5IGluZGV4aW5nKSBhbmQgQ09ORklHX0ZPUlRJRllfU09VUkNFIChmb3Igc3RyY3B5L21lbWNw
eS1mYW1pbHkKZnVuY3Rpb25zKS4KCkFzIGZvdW5kIHdpdGggQ29jY2luZWxsZVsxXSwgYWRkIF9f
Y291bnRlZF9ieSBmb3Igc3RydWN0IGlwX2h3X2luc3RhbmNlLgoKWzFdIGh0dHBzOi8vZ2l0aHVi
LmNvbS9rZWVzL2tlcm5lbC10b29scy9ibG9iL3RydW5rL2NvY2NpbmVsbGUvZXhhbXBsZXMvY291
bnRlZF9ieS5jb2NjaQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzog
IlBhbiwgWGluaHVpIiA8WGluaHVpLlBhbkBhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGdtYWlsLmNvbT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEhh
d2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1v
ZmYtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYwppbmRleCBkMWJjN2IyMTI1MjAuLmJlNGM5N2EzZDdi
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVy
eS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYwpA
QCAtNjYyLDcgKzY2Miw3IEBAIHN0cnVjdCBpcF9od19pbnN0YW5jZSB7CiAJdTggIGhhcnZlc3Q7
CiAKIAlpbnQgbnVtX2Jhc2VfYWRkcmVzc2VzOwotCXUzMiBiYXNlX2FkZHJbXTsKKwl1MzIgYmFz
ZV9hZGRyW10gX19jb3VudGVkX2J5KG51bV9iYXNlX2FkZHJlc3Nlcyk7CiB9OwogCiBzdHJ1Y3Qg
aXBfaHdfaWQgewotLSAKMi4zNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
