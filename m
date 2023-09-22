Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093F5CD4847
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98561610F3;
	Fri, 22 Sep 2023 17:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98561610F3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JDONcoLZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id brqlgAVI74gw; Fri, 22 Sep 2023 17:35:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F379861120;
	Fri, 22 Sep 2023 17:35:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F379861120
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4317FC0DD2;
	Fri, 22 Sep 2023 17:35:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 449A8C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E71A42012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E71A42012
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=JDONcoLZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YEhsSv7KmPGI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:18 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34AF64175B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34AF64175B
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c44c7dbaf9so22017115ad.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695403937; x=1696008737;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=maP8YXhB08F9LY5OG0jMprTbidCF0YS16nloYI5WUaA=;
 b=JDONcoLZSJZeL+NP8TGidif7KRjhyr+tlEgaxS83Dwk+zVjc+2JG7Gf/x7cunVeiYo
 nwMWiAUfhfrVIezZrZWfhUFTjSrEj0Ep2zsoUbus+/x9f4CMSZdSymv70qIt7pBb8RCm
 Ww6gDE3JhzmTWkuprpcY3pRR+j5M69wBnWNTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695403937; x=1696008737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=maP8YXhB08F9LY5OG0jMprTbidCF0YS16nloYI5WUaA=;
 b=k5xlfUeRF33U9p0ymg/bazbYHnKB/d7AkTRLwFBM1JP4oqLlOZJdRQEMY0CsB0jxfg
 AqYaFj9SNDvFlbkE4Kndgp32/9dd3nNcD6RrDVHkg3G7uTdKgrzOrIp70Tl8+CfWHu2D
 ue4eTaXIQjBWTB+TmUgdctkdbh1iP8FlHTRIIBMSnoapAGWhDxatbm8te1MvSp+IXspQ
 xJzemBr9UX92QQ7uBzSlm08Hb0Byjiv6S1UVdq1tx4AqTmHO7ITCCYDKnWYCu8CL2f6v
 XHAL7RYr9UtM8BGE3UyHRiB7WisPkO3Io/lxq8op1e0hvV7XwQCN1+sVFu1XOqKH+zLi
 za3A==
X-Gm-Message-State: AOJu0YzJbsLB3RR62402u6pD6wBHUwoD8vv1bn8eaTOdYvffF0VeA1I6
 8+paf36S7osXaEsG7RErgHMsIw==
X-Google-Smtp-Source: AGHT+IEElaiJXwd+cHN0UEyfbPuovVQdbx97tEz5jWVvCwnMzBcyrsLzHF1i0U0dBU7w1PZYxVLT7w==
X-Received: by 2002:a17:903:1cf:b0:1bd:d911:2a85 with SMTP id
 e15-20020a17090301cf00b001bdd9112a85mr102054plh.12.1695403937531; 
 Fri, 22 Sep 2023 10:32:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 v10-20020a1709029a0a00b001b53953f306sm3755352plp.178.2023.09.22.10.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:32:17 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH 0/9] drm: Annotate structs with __counted_by
Date: Fri, 22 Sep 2023 10:32:05 -0700
Message-Id: <20230922173110.work.084-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=keescook@chromium.org; 
 h=from:subject:message-id;
 bh=YV47XR+Dr1NybdP/JWrsHmoQYKkqVQbnuP88RsqPU7s=; 
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+dsj3+Vh5qemjuEPg29sGFlFmzA+yi/v3Rh
 XtvZqOfqaGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PnQAKCRCJcvTf3G3A
 JiHwEACLzTcgywMl1i+ngflg0YluRoEeJQAxOBHxuE5H6DZMdzVg2q1O7AYcZvuFgGEob07505+
 PzEtpDzTZH/46SXLgI4Sgl0XmudzghRjlp0XTK1UC22xnOBNM9k0OIJif5wStFA/0uiZLRrHII7
 A/+AqzgBiY88gBa4O+x8Vj0+JBJGnDCr0QudEO6XyIcvvmLLgiRCce78vOKBXTXq6Dktknkayr7
 GSRsmx3ZTid9GiUDFYYu7/JLETFdk3ZPoT0iX6O1OocWU9VVd8IE71u38u38X+AdokHQtuEXbCe
 GXNdGJrLV9VqJ6qvypVr3S1EhagL/Z+f7Xz/GMY6nMu+6H9YM0Nbh7PQ8fyD/y9rlT2jcsSJY3r
 eqE3X+ATIdov/4puub/Z5OUm9R4z3dXWHGfnc/vb5l24ZPzLfhFdjlnbl4LYKnZyxK/lH0OGSkH
 9Wks6MuSdRE+bNJFV0VibfzZlV0+wemFXXSlAxxVQGcZ7CWgQaV2w7wE1Y3AMJLRthOuVUU6Kts
 VfGI7p8XZRScEI6mnWSh8w9zLZOftTtdiCxcVj1gdXRTx2/K3Xfv0UkoHgdzOBqTTEPqGetCOjs
 WS30PIjoUXxpO+DRvCTjySDsnQXksC7AsjBRhvnXyIR8tgFSEAywP6FcLYaX3ltdG79BvgAkkzq
 Bs7QmlF kGRGYttQ==
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
 Alex Deucher <alexander.deucher@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, Le Ma <le.ma@amd.com>,
 freedreno@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nirmoy Das <nirmoy.das@intel.com>, Lang Yu <Lang.Yu@amd.com>,
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

Hi,

This is a batch of patches touching drm for preparing for the coming
implementation by GCC and Clang of the __counted_by attribute. Flexible
array members annotated with __counted_by can have their accesses
bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).

As found with Coccinelle[1], add __counted_by to structs that would
benefit from the annotation.

Since the element count member must be set before accessing the annotated
flexible array member, some patches also move the member's initialization
earlier. (These are noted in the individual patches.)

-Kees

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Kees Cook (9):
  drm/amd/pm: Annotate struct smu10_voltage_dependency_table with
    __counted_by
  drm/amdgpu/discovery: Annotate struct ip_hw_instance with __counted_by
  drm/i915/selftests: Annotate struct perf_series with __counted_by
  drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
  drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
  drm/vc4: Annotate struct vc4_perfmon with __counted_by
  drm/virtio: Annotate struct virtio_gpu_object_array with __counted_by
  drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
  drm/v3d: Annotate struct v3d_perfmon with __counted_by

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c        | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h | 2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c        | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h    | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h        | 2 +-
 drivers/gpu/drm/v3d/v3d_drv.h                        | 2 +-
 drivers/gpu/drm/vc4/vc4_drv.h                        | 2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h                 | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
