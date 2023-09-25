Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C331CE7AB5
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 17:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C621416A2;
	Mon, 25 Sep 2023 17:50:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C621416A2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=n1ATiAGl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iiMy01HqFD_t; Mon, 25 Sep 2023 17:50:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E6994409E6;
	Mon, 25 Sep 2023 17:50:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6994409E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7B0BC0039;
	Mon, 25 Sep 2023 17:50:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47575C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13C2940A87
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:50:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13C2940A87
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G5OIhz4crEVP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:50:05 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 053CF409E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 17:50:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 053CF409E6
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1d651ab1d77so4652655fac.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695664204; x=1696269004;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LrNZUYK9GVon3CstC3PAw8y74HnTAoBSBfYauDl4OzM=;
 b=n1ATiAGlrtv54YHB8K2CqDqle5cAtu5sLwgCTMKyTEsCQ+ryiclKMgWoo6pDHZhfKe
 MTn0Y+EzeCCgR1tGQRYr81YjM94xQcsNC24C/bqT+PJ6156KZ3ADMS6snCOyC3o6A8Cs
 2Ifc93LlfPwSMAGd4owfx+nR+IYtlxxtkTt/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664204; x=1696269004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrNZUYK9GVon3CstC3PAw8y74HnTAoBSBfYauDl4OzM=;
 b=pEdQtSs3TE0RPpCrcVFRvEW1QfP4dJsyhn6JmeAdJslp/ThQ9v/zU7+olEOpZCldHG
 SmIG3PPHtGDbELBBhTmgEwuEoVbfDnWFa4NkoaHomMsZgr2x0H5V301GQ1yaAbgVPscD
 FAtoeQpUUl2e9UD5Hd0k2a6JafHmGcq0z7v33MoD8Sf05U1uGGs/tzA1E8ZP8fthG5eI
 Nt2zBnvUNeoy0HkYxF+Ud404RLZux2WZrZJswZzZTJeCzlqU37m0gK1+xnSvTfRWleNk
 SNFdgPnRCO1nBv/sNijeAnAH7sDRxbnVvN3J0BDq2Mo+ek4+zeoboju6VRTrVBq+BudA
 N/9Q==
X-Gm-Message-State: AOJu0YysKnRuX3kxRVXiylE4HNynyTM5OPNAv7XHbUfnfWbAIF/o4q9I
 8k740mSqCUzJvVhknAVwe74zxg==
X-Google-Smtp-Source: AGHT+IEnVXJWnUtJ+JjUoJ2wutCIFPzVwQv9Kt/j17reyYiG5PztEKwn4JCr3bhZYPWh/NJDzvVOfA==
X-Received: by 2002:a05:6870:3323:b0:1d5:5a83:22b7 with SMTP id
 x35-20020a056870332300b001d55a8322b7mr9920226oae.51.1695664203813; 
 Mon, 25 Sep 2023 10:50:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 p19-20020a639513000000b00578afd8e012sm7498975pgd.92.2023.09.25.10.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:50:03 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:50:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: [PATCH 3/9] drm/i915/selftests: Annotate struct perf_series with
 __counted_by
Message-ID: <202309251043.2D1F7D08@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-3-keescook@chromium.org>
 <b668d521-c8fd-1207-0a65-e1200e7ebb2c@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b668d521-c8fd-1207-0a65-e1200e7ebb2c@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Karol Herbst <kherbst@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 amd-gfx@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Nathan Chancellor <nathan@kernel.org>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
 Lyude Paul <lyude@redhat.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Kevin Wang <kevin1.wang@amd.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Sep 25, 2023 at 12:08:36PM +0200, Andrzej Hajda wrote:
> 
> 
> On 22.09.2023 19:32, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> > 
> > As found with Coccinelle[1], add __counted_by for struct perf_series.
> > 
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > 
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: John Harrison <john.c.harrison@Intel.com>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I am surprised this is the only finding in i915, I would expected more.

I'm sure there are more, but it's likely my Coccinelle pattern didn't
catch it. There are many many flexible arrays in drm. :)

$ grep -nRH '\[\];$' drivers/gpu/drm include/uapi/drm | grep -v :extern | wc -l
122

If anyone has some patterns I can add to the Coccinelle script, I can
take another pass at it.

> Anyway:
> 
> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Thank you!

-Kees

-- 
Kees Cook
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
