Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050BDCD4847
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A86D841480;
	Fri, 22 Sep 2023 17:35:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A86D841480
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JYfwPKa5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S4m_8OTQDEV1; Fri, 22 Sep 2023 17:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C5DA041992;
	Fri, 22 Sep 2023 17:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5DA041992
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3112C0071;
	Fri, 22 Sep 2023 17:35:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5874CC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C0FC83EC3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C0FC83EC3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=JYfwPKa5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xTKBFZjz3UUT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:26 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D844822D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D844822D1
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-692b2bdfce9so652691b3a.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695403945; x=1696008745;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aju3+JSf6eGUIv+LcbKwNlrE4eQbXi+VM+zVoGclrt0=;
 b=JYfwPKa5Io20jo4eHAsux1l5TmbKKcsbF6/OkxnDlNDvxPwIzVdFBuBf1pOx+UV/68
 3gxo7zj/q13VC8z/NykmJOnSx2/OhjC5B/0qwkp282CqkYzQrzwlQMynnsKrxutRqSTF
 Ft7fy1lfe6ZBI9H5Fv3z6xBpQzLEZqbOuCAwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695403945; x=1696008745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aju3+JSf6eGUIv+LcbKwNlrE4eQbXi+VM+zVoGclrt0=;
 b=J54Rwvelso4NYKhK6s69V5Q5ybHGTBAxtOj+++XynLZbxOcPaWNDIbHbuIl6WI8O2W
 igA2Si+XBlyr3wvi6gT3fptIxnxgt7mhsHNkfokO9H9iHf+Sja/0j24SqJQvPOHGntv2
 1FE0KxGz1uPRiGa3B9/5S9ZvTFRIhi5vk7UVu5Fjhoy9tcLE5P4xCLQSX7MwU1EK/qe0
 Dth1mbYP7VYY8FDejEHamZMDrf351mdjxZMTDh1SxE2Bwbt7dTgSnonKYhCP8Kt4YN8j
 vOJlTbzMs5UICwLEUtuqIVL9Z2HRy4WSA+f3tKU5apzqkWjp/xIYgOtLsVRO0J1bbC9I
 02FQ==
X-Gm-Message-State: AOJu0YyZn0RFCwYDaGH3ht8pLGZm+ekuQkiumsPXEsxYUCL0zKe5+7mp
 1hiKvMNzMc5R+MUAIHieNHfciw==
X-Google-Smtp-Source: AGHT+IHgT/bhDe7l/fJSBw+bewXNYr1woAQ273HxnwMMW/1b4ePjBTtMzVLx9TJ9ssFNw7g8YFAmqQ==
X-Received: by 2002:a05:6a20:3d8b:b0:137:74f8:62ee with SMTP id
 s11-20020a056a203d8b00b0013774f862eemr269550pzi.18.1695403945599; 
 Fri, 22 Sep 2023 10:32:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 z27-20020a637e1b000000b00563e1ef0491sm3423207pgc.8.2023.09.22.10.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:32:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH 8/9] drm/vmwgfx: Annotate struct vmw_surface_dirty with
 __counted_by
Date: Fri, 22 Sep 2023 10:32:13 -0700
Message-Id: <20230922173216.3823169-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=keescook@chromium.org; 
 h=from:subject;
 bh=arqXb+Ta6Sc7/P6cgbiuTW33qm7tl3AbrpWLIpWMOrs=; 
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+eMheJSZWlkxEjVkQYSxOb48cD+nN4OVb7V
 LKQ+3uUqo6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JrX8D/4u4mGTNY0H31raYIAy39e0MQyr+8F7lCaJtmz2p55bHTGxLREiFkYdiEpuailORE0wwsW
 BdlQDhRjLTf2KU9T7kldf6gcsBqFx5GS03UQDFirRowApSq5fh8IhxpEuGCuARDeUQrxNtmKCN0
 kN+bcH9BoSyxbEJQzpBBCbp5RMSt4XXDDkDi3oSsbZuZRkPmbszcp8iXrqUoFv7S/Vb8X5tGSRw
 nMO+fGglPvpNerLuaODEVbqAcj6XsI5FnEUPAbqIRdOyr/vAf4ZrHXXTeukSN6uOcb1w6XAw9GC
 4wnO7W4eW8CaLB6Kn2OhET6y8+h69ft05VnFFrnCTVxxJScjLTXrSCCsV544YFnE9eWFcjVivpW
 F3KuWexvi43Nc986ga140ka16uCaP//Thnt3s311iQsr5hvWJH4fkl32zdBPXWCwGX4ceRWSch2
 JEogxta26Yvy5CIJRHdU1z5humCdNzFVvMxbgMwQIRSKyKG1M7mMT/nBOIMfytjgY8S0vaBALVu
 EciVOC1nl86GXTm1b+MB9R8ZKZyOZPrX7vK8PyRCASDUnCN/37sg23Cq5Aqn4UUJ+sZeFPAF+11
 o0r5FyrPrmPW3O3hQUprUGrQsd68XMRpXTFcnKOPsEaG9G23VqHiDSPPILF+sczZ20HKQ+LMyhP
 63vfZbPCZqHgx8g==
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

As found with Coccinelle[1], add __counted_by for struct vmw_surface_dirty.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Zack Rusin <zackr@vmware.com>
Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5db403ee8261..2d1d857f99ae 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -77,7 +77,7 @@ struct vmw_surface_offset {
 struct vmw_surface_dirty {
 	struct vmw_surface_cache cache;
 	u32 num_subres;
-	SVGA3dBox boxes[];
+	SVGA3dBox boxes[] __counted_by(num_subres);
 };
 
 static void vmw_user_surface_free(struct vmw_resource *res);
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
