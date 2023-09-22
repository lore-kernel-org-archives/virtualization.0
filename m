Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88424CD484A
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 373444173F;
	Fri, 22 Sep 2023 17:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 373444173F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MOmUh/2I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iYbj4yNvVPyY; Fri, 22 Sep 2023 17:35:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB037415A4;
	Fri, 22 Sep 2023 17:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB037415A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EA5EC0071;
	Fri, 22 Sep 2023 17:35:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 429DBC008D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D10B680BF8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D10B680BF8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MOmUh/2I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BMPRx2kIB-Wp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:22 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87E26822D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87E26822D1
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690bfd4f3ebso2122256b3a.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695403942; x=1696008742;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxN1BE4ZHdJI3Tb4/0aUqoFzscF/JkAVA7bHFE5N/Lw=;
 b=MOmUh/2IBSKmTzTtg6lg9Rz1Y8mctUWny/eIsdC9Nt5LERzbvvc7ATu4mvi3hFiApy
 DJg/rH2rU2y3Y6K3tfr+dp5w4dJz0KVON3GYLoJhPHm51iziE8HUQ83xuVCblO7ikbAK
 5mH/WW7WdT59kGXGDyy3bgE7eIzZHi4xQ60Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695403942; x=1696008742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxN1BE4ZHdJI3Tb4/0aUqoFzscF/JkAVA7bHFE5N/Lw=;
 b=aScJlwsinO3yEODEm53QugEyxXpHd5+TqQXvsjMfY3N4WKg3clBnWINsRfY86Lvh3Z
 /VOiGhMbrGMF1W6q3YYa7N4C7NcBjQD1WrPNc+5+uA7Fue0/AjVjr9IyjGJpJot5HWVM
 XoQ+10IdSbAt0EVn7+DwpNozMt91V/EsCO4AMbKA2tjULCfBxYpiKuAi1YVgchLEI97N
 Za+1050TicRaKZpyqARt9jjJ3cj0kwQ7Pf2pF6RPyd/jT9N3jwBNOSde9NJo0s+j4xx2
 JumPlVij/6YjSjzWVU0vz6ASyA3+VlZ2MFHQxhYkTh3ckV07Xa8YIk9P57jU4wM7k9DH
 yqPw==
X-Gm-Message-State: AOJu0Yyklm2kcv85Cm0Mz6M0aHtDGITdlElZ25pzweyTxO+ZBaYAZeJf
 8p7AFfNjMnJoGhHhkano7gBUbg==
X-Google-Smtp-Source: AGHT+IH//vRAyYVOKaaq6VhS1fbYsjjpT5jue+Yc4/zN4nLEb/l32hmv6bVyDmgeyxxMAVlMxqzNow==
X-Received: by 2002:a17:90a:5806:b0:26b:4ce1:9705 with SMTP id
 h6-20020a17090a580600b0026b4ce19705mr304838pji.38.1695403941884; 
 Fri, 22 Sep 2023 10:32:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 30-20020a17090a005e00b00274c541ac9esm3815585pjb.48.2023.09.22.10.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:32:19 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH 5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with
 __counted_by
Date: Fri, 22 Sep 2023 10:32:10 -0700
Message-Id: <20230922173216.3823169-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=keescook@chromium.org; 
 h=from:subject;
 bh=IPCNKuct38YwTzB2zIOXZz855pzU163uvmhflCBSQWQ=; 
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+ePLJ5Y9ji0102KrPkzSXaeWKfcfISds5DF
 aJ14tx1Y4aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JtXrD/0RXHf3wSRStY2vqlZH/um0jQPMLbKbehlFgssNmiWNKLGOpr9br8S3vwu1QvHGz1HXrqy
 ek4gD5gpWq9HZI5TJ2S0ATi0PCNLJBhXIuhc34RvAQY4zFQ3xDP1+U9nxWirglYoYpY8M62/YSo
 B0HX0gFwkDnSKjEiTZRLqLNrHJ2uDlJPrCaCz4/eG9EdAXU5odsdQXdC9MXbzm7VxjwSRLgFwVK
 GHLJXusf7Ruisahsoa0m9dY0LDoKPcUPSm6nZyyulGzjj8O7nZD5mkW5LmE3acjay9ccGO6xVQV
 CEmQ8fU5KxWIXh39kd9vqnEzf3cWZgF/XottaJZSmQfT1Ch1cecAsaQT61aXa0XgwnSoBRR1Adm
 pc0Dq6V8Dq2SSnL3qijLYnz0JJZIxQ2Vea1R0y83xCcXxYu29UWHu78xEIII3D5O3DQH7LTIFRk
 64XrJvEWliQkDVEjTU9AAQ1DmI0+XI32xp59hVd2qxbLXVzaJbyW96YRrwk0Z8tybyQKuBGbl+N
 UjYgjPXkrQlaLwdvsSB5hxsSwDYFtZYt+C8rKOWeJuWm6hWS/WNw8to6mNAPP2UcQkbXemA4N1n
 LDw+BMjjOgfNdMdxGQwv3iqnBs5Ov3VImnlMxKxr+X4ixt4v0594/VlXa7PXU40u430EsrX9Bgl
 2ggHJiZsUawsmBg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Matthew Brost <matthew.brost@intel.com>, Emma Anholt <emma@anholt.net>,
 Neil Armstrong <neil.armstrong@linaro.org>, amd-gfx@lists.freedesktop.org,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Nathan Chancellor <nathan@kernel.org>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Tom Rix <trix@redhat.com>, David Airlie <airlied@redhat.com>,
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

As found with Coccinelle[1], add __counted_by for struct nvkm_perfdom.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
index 6ae25d3e7f45..c011227f7052 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
@@ -82,7 +82,7 @@ struct nvkm_perfdom {
 	u8  mode;
 	u32 clk;
 	u16 signal_nr;
-	struct nvkm_perfsig signal[];
+	struct nvkm_perfsig signal[] __counted_by(signal_nr);
 };
 
 struct nvkm_funcdom {
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
