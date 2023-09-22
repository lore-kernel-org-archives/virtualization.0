Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EC8CD4846
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4789416F8;
	Fri, 22 Sep 2023 17:35:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4789416F8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Mch2cL1z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXrY2qVjel1D; Fri, 22 Sep 2023 17:35:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 326FF415A4;
	Fri, 22 Sep 2023 17:35:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 326FF415A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D051C0071;
	Fri, 22 Sep 2023 17:35:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14E84C0071
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F005283C6D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F005283C6D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Mch2cL1z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YJBPL8R_dlR1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:22 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C2D080BF8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:32:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C2D080BF8
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so20612685ad.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695403941; x=1696008741;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWOiU92ExO1tEuVJ2ItejZKQh8uiQWENZYmfi07W000=;
 b=Mch2cL1ztoFsfjy6UJcf60DCcVuiYB2zCcFhTPoAvQG6rBitxinrwSBz2L3D8QsnOe
 ZnGJmJlRy17dznRcmPIdDSQCKkSQ4yeYFrV26H80Ap2o3Ze0xBZ+0ANMULQl0JMGXlxo
 OqfcgnVO+hgRw1Jx4PnyRy/KbGMll89o6doEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695403941; x=1696008741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWOiU92ExO1tEuVJ2ItejZKQh8uiQWENZYmfi07W000=;
 b=pStzqyNeMMCAyrxgAQGxeSJjYF05E5MoT8AEX9synu5iebXfMLbrof4rhzQHZ3BFCH
 BdQnXqWya0BnQK8pjpepm5tKsusatKll8f2vW36sM7iRQAg2VkqNdHIsJkwR1s/XeLiP
 8qL6SJmHGKxG/4lqZrIQy+7AJtuR16aIdGO4z+fd7PP5Rh7g8OZQiXPTclbA58Cg/ECr
 hlhV/GPzBN/ckYY4qhEee7rZTsicWJgxTUdeH7W5AbESDqpWxAbZKDIV+5i8lLELf2TS
 6CpKJ+uiYGqT0KBn3fvj/hCy3IetdKFRIdPKssv7QsHCoGzqv6cUVaFTn4lt6+/RO26v
 HAJw==
X-Gm-Message-State: AOJu0Yx4XSsXIq0SvbUuLJF5bLMzdYmeDl1IjhNVyA5MBgNpWb6mywoS
 DiS4YGBb0bTJL4StH93CtYtO+A==
X-Google-Smtp-Source: AGHT+IHozbo6RGGEOfFNm2quF7eyhyB1jYnKoC2EoQE9eESJOC/u5eL19BCqbdONa5XuKmexTM0hYA==
X-Received: by 2002:a17:902:e5c1:b0:1c3:d07f:39f7 with SMTP id
 u1-20020a170902e5c100b001c3d07f39f7mr152502plf.62.1695403941371; 
 Fri, 22 Sep 2023 10:32:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 h6-20020a170902f54600b001c5f7e06256sm8967plf.152.2023.09.22.10.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:32:19 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH 4/9] drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
Date: Fri, 22 Sep 2023 10:32:09 -0700
Message-Id: <20230922173216.3823169-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=keescook@chromium.org; 
 h=from:subject;
 bh=xDkJWau6qmNIlEczl2n21zh31yaWnnGb4ZbtRzkDM5w=; 
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+eutUHe9SLnXaUpaJySdpFne687ECfxzj9x
 c9gWcqZLYaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JjnbD/9OQiE+N5TDN74IQPEo9SgzH0oAvZBxcgjjWQ+yn1SxoSDB5LIrgeGtiyQGvx7BYlpt+Mk
 MT5bPfHehA9na7K4kzqg9quYRtDWvIN27rP/uwZxsg6q5pZKW93YRamZq1G+itcAKW6RA20Gl5L
 oXzlXw8xjsnhIYhIM57Pko4wOg7e7p9M1OFiWoZvPmi3jXsn0iVx99yrPXIgM7uK4j+SGaJVO/e
 Db6B/ovadEGxmj6A5SpZjflvdzGUHbCnD/wxy8R6PCGroCHj+rG2bB4Bzu1Bz+aXu2YhIKPBoAr
 CfA7YAuzv8p7/Dy4rMzzOl1WMQu/T5Rh5tIJo2Eg44ksRdJK4w4OJBgr+8wPd1dntiatR4Ulsgn
 ZfRzuaLWVaPb+FcgFpd7LGX/chEK+f5iu5eFguQ8F1ZvI4wUYZ1dYV0HliOOkBFszZQ42WITuND
 M88ZKBxyD4ccXy0nUhHCMZsLs9jr152hzbB82sQrCyl+qJ7p0yYLaHOjzT6CRZvzNUXk0DrXNdf
 cM+AdoWXZHFWhEsT+HLVIWg+oEAfqN+3W2w08etC077cqQ4Kj366BbtIh2HIlNX7LYF3uztip5O
 Cy/EA3VNLkh7U/Gwv7/PDy6HCSs6sJ32cEGquxZ7iLKQf7SPjcZHlBvml7AJOep9Fs2EukYfNDz
 1KplYtpYhU7H+uA==
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
 Lang Yu <Lang.Yu@amd.com>, Bjorn Andersson <andersson@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Nirmoy Das <nirmoy.das@intel.com>,
 freedreno@lists.freedesktop.org,
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

As found with Coccinelle[1], add __counted_by for struct dpu_hw_intr.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index dab761e54863..50cf9523d367 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -61,7 +61,7 @@ struct dpu_hw_intr {
 		void (*cb)(void *arg, int irq_idx);
 		void *arg;
 		atomic_t count;
-	} irq_tbl[];
+	} irq_tbl[] __counted_by(total_irqs);
 };
 
 /**
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
