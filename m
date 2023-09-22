Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E632ECD4847
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63BE041B19;
	Fri, 22 Sep 2023 17:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63BE041B19
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MAs2TGcY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VYhkUcOWXPDc; Fri, 22 Sep 2023 17:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 84018415EF;
	Fri, 22 Sep 2023 17:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84018415EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B01AAC0DD2;
	Fri, 22 Sep 2023 17:34:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D7FBC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF7CD41A1D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF7CD41A1D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MAs2TGcY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q0Px0qgaW87e
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:24 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A050041A19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A050041A19
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-274972a4cb6so1805932a91.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695403944; x=1696008744;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTtgeSpUdLuurLr/un8bnu1axQ+1dpOqA/3ccL3TFAo=;
 b=MAs2TGcYnAWTc99LyO2ZDSfTgmteQHaQi9WA9kRTkXwPsvcJ6QexCXdx7QaU03PbpP
 RkPY/lhe22VdKIhINY+v682iTsf2bt8F5L0PuPKzBUngYrZs4EE/nuPVcoBKzyzM5muF
 9K2qwWNr+is/7zNsvAzaaXoq91EMex5nbglIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695403944; x=1696008744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTtgeSpUdLuurLr/un8bnu1axQ+1dpOqA/3ccL3TFAo=;
 b=UX0fnenDkw9P/XETNCzG0D0+7jMSFkr9yXSjlMOv3jzx4Uy0rph5BVBS3JTT6EIzbi
 5p3S7pWquvswMARdF4ow5AzZuwT5I7QWYmK8BOSfFEh2iE+3kGH8Lf0N+QWGQ+md7xgZ
 K9F+SK5L58WJilUS5uFZOUzKWRHMdzNi162QD50084ViYzNeS+QZ7XWEbXXMeg0GMhhN
 CP0Lmi+KHxHxFrpxQaph1xrGR5v3+v4oCGD082hlIloQtq+1HQqNMQ0W6JkHSonxFvOO
 Tg5n9xsQuGC2R0MLQtAo6O1tE32fByjxBN1BqRWz8gD5AXfMXSKWi1JXa+NVlywZMihQ
 O3xA==
X-Gm-Message-State: AOJu0YxxVnAFvJAac9TN+NijGN9HWMRb3xMWjfmvDbwulAum5ZiI3WYD
 yuAbR9sLNyDS+axrAN1cgxyGFg==
X-Google-Smtp-Source: AGHT+IH1kOxHRj7LaiNXbzPksDVzBRenY9YKDNpSK1EEyPL6u9P78p9pejQ3U+rxat+v82Jd4FEuCw==
X-Received: by 2002:a17:90b:128a:b0:274:729c:e4f with SMTP id
 fw10-20020a17090b128a00b00274729c0e4fmr390309pjb.15.1695403944032; 
 Fri, 22 Sep 2023 10:32:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 c4-20020a17090a020400b0026b26181ac9sm5637279pjc.14.2023.09.22.10.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:32:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH 7/9] drm/virtio: Annotate struct virtio_gpu_object_array with
 __counted_by
Date: Fri, 22 Sep 2023 10:32:12 -0700
Message-Id: <20230922173216.3823169-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=keescook@chromium.org; 
 h=from:subject;
 bh=eZm0aznK0m8B2PZ9kKPoriymoURbDsQWuTqSiG5Zn6g=; 
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+ecN7AHVyI0F/T2hAcEM09nm5XXW5LLfQTE
 HSHvLmbqbqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JmrOD/wOpyQVRHrGQGo8XfD5jMBVmYMEWa7mtPz8TQHyKwul0h4DAnDuY1syEElYvTvb0qCuTg6
 YHpqfYbVJonRUjUd83cqsdEqsNMRkx8ryd+FwIwDMcHFmp3kEWfg5s9zyJpQlhMbIA8qRhFRzp6
 1nctWnxSwK5Y+R6FATebIjhT9U2Y8CD6khRnkG9NQuimrbhgcl/f447wIiYiu5X7idIzuMwSDFR
 Prf1JJwDz4YkxahRTnX8WrJXhYUDJjWqyw7MOMkMW6ybVBIL8ie1WLAZlKfuNoq/ypItBU4eAMz
 +BDqWKau3tdzcpK42SAJNB9SVOIvsM8EHP5boshP1NmOAEdUKG8SXMJr6bbYAfFt/Zdk5ZmYfpJ
 Yxipt98I+ZRxsbNFS4Y+4kVDYW0QBySazXXvWa8U736thID88na3V/aHvwB4Ql0tKp5Mk3oaHjZ
 VIJkT0hMJ0c+tnjLvg6pHMeQM7yKNB+s0mGuL84RFj6OyWPATVyWvcrsQ/dAxuy53EitcBlWyzG
 OhHlG4pbiUAIcoN9Kju8k9tthCpSQohkyEr1pwg2o2OfnyfTD7GoFuTt85RlHxHFcx2PYl1nV2x
 FeRCY+2qIpNwX19xvQ8Lx3Vt8SeFDNnJWY5M6UFCEs1Kyk4337zXOTTH+xiGEYKfZpRPhfZZ+7Z
 CzpyiCN8tLdjdOg==
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct virtio_gpu_object_array.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 8513b671f871..96365a772f77 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -119,7 +119,7 @@ struct virtio_gpu_object_array {
 	struct ww_acquire_ctx ticket;
 	struct list_head next;
 	u32 nents, total;
-	struct drm_gem_object *objs[];
+	struct drm_gem_object *objs[] __counted_by(total);
 };
 
 struct virtio_gpu_vbuffer;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
