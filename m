Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FD2E728DF
	for <virtualization@archiver.kernel.org>; Fri, 29 Sep 2023 19:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AC8E83D4D;
	Fri, 29 Sep 2023 19:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AC8E83D4D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BRQn8blj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q1Yj49F1slxd; Fri, 29 Sep 2023 19:34:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9DE1983D49;
	Fri, 29 Sep 2023 19:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DE1983D49
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 747E8C0039;
	Fri, 29 Sep 2023 19:34:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFB3FC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 19:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9523E41BF3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 19:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9523E41BF3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BRQn8blj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VqsC9_8klgN7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 19:34:02 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8F4941BE7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 19:34:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8F4941BE7
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c328b53aeaso130498765ad.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696016042; x=1696620842;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ym+ucW6MHQZimVVr4/aWJAbaMhbjuFeNaLImS0cTOp0=;
 b=BRQn8bljbowJEYhDYhsY0vM9o2YLToMn080/tPVd8hleCXM2o1NcZY1Eorj4WErR27
 XQtWeD2FsHUuTvyHCoL94Mlsv45JjUtwl2dGeMSwhNWCL+xnWYKHmO4oZfbfgxiG+9Y+
 7kGWCH1yxz+AjBmQtc/WMbw19I11kKpwpvPeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696016042; x=1696620842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ym+ucW6MHQZimVVr4/aWJAbaMhbjuFeNaLImS0cTOp0=;
 b=XOzOevLM2IRqhpUge1Sa1EhBgoU+5o/4WcRSqeBav/3Emwsy/y41zf8FHrvtpir1lz
 S9gvc2NcKVEFXGGXeIHVkepkeqJlk9hHJhBGofF70/Pa4NTFqIuyY67Z4aFL9VE7sZRD
 HiliiC1ofUByCiohJCc1OAMHaGEmF3klCFESX18KcUjFIM0+BMmuyloozospdG0f3UPa
 M4ltSr/07WeMzF6041WrQS6CQU2/acwtXUXtyovtYbYYIv8guiXVy3Himj49qn5nhtH+
 ziHhN8/wOq/I6MSgqCMOW0GDN/vm0rjYVJMqKLR0wt6xAyr0+1/nYIbf9cE4EkaBYjTl
 ltcw==
X-Gm-Message-State: AOJu0YybJ7oPSfu8EVbdGzomGpIBqRayGMxCf+U/AqnF8atZyRUnClsE
 2Sys1rkytsb7MBlSX+MlYZXIEQ==
X-Google-Smtp-Source: AGHT+IGQWTdEpdWeBEvd5foAb6HBvD/EqemA8SP9BycZ81OPm2PcYAndv1e0P5bQalrHP7ERsAZdBw==
X-Received: by 2002:a17:902:720a:b0:1c1:dbd6:9bf6 with SMTP id
 ba10-20020a170902720a00b001c1dbd69bf6mr4494391plb.41.1696016042045; 
 Fri, 29 Sep 2023 12:34:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 jg6-20020a17090326c600b001c61df93afdsm10225856plb.59.2023.09.29.12.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 12:34:01 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Date: Fri, 29 Sep 2023 12:33:24 -0700
Message-Id: <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
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
 Lyude Paul <lyude@redhat.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Kevin Wang <kevin1.wang@amd.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
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

On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
> This is a batch of patches touching drm for preparing for the coming
> implementation by GCC and Clang of the __counted_by attribute. Flexible
> array members annotated with __counted_by can have their accesses
> bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
> 
> As found with Coccinelle[1], add __counted_by to structs that would
> benefit from the annotation.
> 
> [...]

Since this got Acks, I figure I should carry it in my tree. Let me know
if this should go via drm instead.

Applied to for-next/hardening, thanks!

[1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
      https://git.kernel.org/kees/c/a6046ac659d6
[2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance with __counted_by
      https://git.kernel.org/kees/c/4df33089b46f
[3/9] drm/i915/selftests: Annotate struct perf_series with __counted_by
      https://git.kernel.org/kees/c/ffd3f823bdf6
[4/9] drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
      https://git.kernel.org/kees/c/2de35a989b76
[5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
      https://git.kernel.org/kees/c/188aeb08bfaa
[6/9] drm/vc4: Annotate struct vc4_perfmon with __counted_by
      https://git.kernel.org/kees/c/59a54dc896c3
[7/9] drm/virtio: Annotate struct virtio_gpu_object_array with __counted_by
      https://git.kernel.org/kees/c/5cd476de33af
[8/9] drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
      https://git.kernel.org/kees/c/b426f2e5356a
[9/9] drm/v3d: Annotate struct v3d_perfmon with __counted_by
      https://git.kernel.org/kees/c/dc662fa1b0e4

Take care,

-- 
Kees Cook

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
