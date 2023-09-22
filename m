Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F962CD4847
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C6E7813CE;
	Fri, 22 Sep 2023 17:34:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C6E7813CE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Bg/MWgqA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2J1uNpHqIdF1; Fri, 22 Sep 2023 17:34:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E7D780C37;
	Fri, 22 Sep 2023 17:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E7D780C37
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44D6FC0071;
	Fri, 22 Sep 2023 17:34:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC9CC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0120A41A18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0120A41A18
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Bg/MWgqA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gujm--28Lptv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:18 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4237419E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4237419E2
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso20910735ad.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695403938; x=1696008738;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7mFLDUO5Hv4nuyIM6aHVjhOJF2f1Ccv+t7gCPQABb0=;
 b=Bg/MWgqAqK6oJjL5kGOtCEOtAOsssxE0q7FKqk0Kvw//bnskPY+eKNFt9eJFPXhybg
 XqSpFeHjvTaB8qsILN3x15OyfGnoov+omGwJZM2iLOUTIsm5H8uoKLbd9vHOel9740pk
 xxcRnvGEYLdhcaw1xn8xcwVHRhQor3N0pIH/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695403938; x=1696008738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7mFLDUO5Hv4nuyIM6aHVjhOJF2f1Ccv+t7gCPQABb0=;
 b=sVQlOc4EuyxIhiSHyzl0ortbVehcdrVxtDNUnnHFbt9Rc8TmpIn8fQdmxw1NOdU5LK
 iR52BY80+hXe1sEBYPd/CEp2JNvh7IZzqLWAsu7RXjxhpuGtS+ASsFi9L81jO888XBJw
 I68s0VuoJyyDJfPC3oEV3fJtf+MIKQ7J0i7qiGHHnUAnBlHEqcoEDcZTJq4/OGNSYhzJ
 qLGkt3PI6yBEorERGFo5v+nIWYNY7lkPtaESo2e83YbZr7Tfpn0A6RMnFfUm6uXgcs8a
 deZ+RnXapO7H9M7i4ngpO1qcc0S06N3rIf5hEQqevOfJ69XNH28M7ePnd3JYwxrHCSkK
 Q9kg==
X-Gm-Message-State: AOJu0Yw30I+sl9kkOJwqHz0cDOPim0coxhLcJxLdo5AkZrrRlLcWJlvP
 r6Fh2nEuBEt6EN3+7ULy4tsq6g==
X-Google-Smtp-Source: AGHT+IE6F6K7CDwEaF3fHkMJFZDdCooH5rNl5USI0rssAlTS7mc8rdfuFtX4TpzsK8su4KRyBFD88Q==
X-Received: by 2002:a17:902:e847:b0:1b6:bced:1dc2 with SMTP id
 t7-20020a170902e84700b001b6bced1dc2mr224040plg.0.1695403938058; 
 Fri, 22 Sep 2023 10:32:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001b8c6662094sm3752514plb.188.2023.09.22.10.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:32:17 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH 1/9] drm/amd/pm: Annotate struct
 smu10_voltage_dependency_table with __counted_by
Date: Fri, 22 Sep 2023 10:32:06 -0700
Message-Id: <20230922173216.3823169-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=keescook@chromium.org; 
 h=from:subject;
 bh=kCvC5X4RJuHaoweqFnQ9xMUwIDOFINcpTmqcFOUOp9g=; 
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+dzQGoS9m8Q71IG/SluCNIy0Np4uBUNCXIF
 2oTBIaso6OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PnQAKCRCJcvTf3G3A
 JjY9EACkZXMo7wzxY4THEhXZJmkYixLA2UlloTPXgPy8CvMUYiNLBwVLSqoh/h/5MhgdgB+pVHX
 gjEPVRbNLsQ1sMYLw31nppSpdtNmrx+qI2Xv8/FCIrTsOHuBoHSi+9nwoY2LW7IEx8xVxDORb01
 i9WnFgRMl8JlxFCnGrKgYtrWpQVCGXMfpunpsPAAmh2g5Yfkoo8Yodegj0WGJdFnSQzp2irODLS
 4fzO25EG9TH3jtCwjZItDt5m0cT8oO2gC1LVyKm/WXFfllivnEC967z9zUAtQtABdtjhtosOPHC
 1jSJ119A0nTIyM6aLwtiK32qSZA2Of2ooijB8afmhRUb5Jb+iPKwLmRnvY+TycfX8U8VtGQBkbA
 PsbT82Qj4Qqirr4cuxGVW/oAnE7XDwMh8IEHMNP1n3XOmEtlx7TVlgUKL774++kkLb5/dO90oUm
 DGOwxoXK9G23PdRFLUZ82z/F0glCWWkDrqrmKUkcKnY7rdSxGYAapRKXY6YbnmQ3EA3hqkEBXtV
 Df/r+VTS0EiXZ6VrmE54NZ2HQTkIjn/3uMxtp2UVPqb2tn6zRXFLAI85C3NUtvV2TNniYKdU/mB
 V12ppntQS4AmfEbCBhZc3biSLzO4h5eErGTnBoeVzf8NDuINYiUgr2+IDcyvEE0XObVZcrukMxP
 e9S9RTOiaW+wWUw==
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
Y291bnRlZF9ieSBmb3Igc3RydWN0IHNtdTEwX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJsZS4KClsx
XSBodHRwczovL2dpdGh1Yi5jb20va2Vlcy9rZXJuZWwtdG9vbHMvYmxvYi90cnVuay9jb2NjaW5l
bGxlL2V4YW1wbGVzL2NvdW50ZWRfYnkuY29jY2kKCkNjOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBh
bWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiAiUGFuLCBY
aW5odWkiIDxYaW5odWkuUGFuQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21h
aWwuY29tPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogWGlhb2ppYW4g
RHUgPFhpYW9qaWFuLkR1QGFtZC5jb20+CkNjOiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29t
PgpDYzogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25l
ZC1vZmYtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmggfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuaAppbmRleCA4
MDhlMGVjYmUxZjAuLjQyYWRjMmEzZGNiYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5oCkBAIC0xOTIsNyArMTkyLDcgQEAg
c3RydWN0IHNtdTEwX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV9yZWNvcmQgewogCiBzdHJ1Y3Qg
c211MTBfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlIHsKIAl1aW50MzJfdCBjb3VudDsKLQlzdHJ1
Y3Qgc211MTBfY2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5X3JlY29yZCBlbnRyaWVzW107CisJc3Ry
dWN0IHNtdTEwX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV9yZWNvcmQgZW50cmllc1tdIF9fY291
bnRlZF9ieShjb3VudCk7CiB9OwogCiBzdHJ1Y3Qgc211MTBfY2xvY2tfdm9sdGFnZV9pbmZvcm1h
dGlvbiB7Ci0tIAoyLjM0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
