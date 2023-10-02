Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724EDE784B0
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 09:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC10360F71;
	Mon,  2 Oct 2023 09:20:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC10360F71
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a5SsAz/N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3QJmoZOVrq-U; Mon,  2 Oct 2023 09:20:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 69B7F607E3;
	Mon,  2 Oct 2023 09:20:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69B7F607E3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47674C0071;
	Mon,  2 Oct 2023 09:20:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3A1AC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 09:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D82A41767
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 09:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D82A41767
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=a5SsAz/N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WQX-0uZEcFG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 09:20:18 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03F9A4175B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 09:20:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03F9A4175B
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-327b7e08456so1180295f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Oct 2023 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696238416; x=1696843216;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vNiEun8BJgZFmuZelXrrpN/XVazT12AxKny5brwsu7w=;
 b=a5SsAz/NcOC0j9ef3CoBSKHRWA5RN3axyWaVhLdW1fboivE+Na9ckIVaeDcMgL/GW2
 jhVwGlL2xANhuxmhzt5UrWDHNTY50eZWifV4Xlz9ftwgUnBCAQyCArQaUFPYP2L3TuHV
 ObFXyl7qUav1AZLffgterK9a9IrVlmsjvUIkZ0o+66XQd94kfMXy6aLbPL9m2sthaQfw
 ySX/6dhHH8gdjvahY1NBsS03n19/QUfxg7fCxqR4bP9mq8gULzBLtfisIjcS4VG5brDZ
 fb34iMirpXtgONY7kvxSDudoMX0mEs/mK/vZDX0o1z1akymVWHDm3eKc5CJjj1oaWiQK
 qNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696238416; x=1696843216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vNiEun8BJgZFmuZelXrrpN/XVazT12AxKny5brwsu7w=;
 b=aSwB93rqYmnfLGt8nz2IH0GlfrHGykIRJ2xHF6C+dghbepnfZ2foWxuqlJxuNEhkli
 J8M71vVcF6BN/nG+x/VFg2pBebwURvjwDbnx6n4HG8JNddugE6mmTBCVDsk3modDe4ze
 Yk4s8ypdmrzXn4hRMvSYuJFXK2UShk4UFnL7c6wUCgaSC7C98KU6EyWqtuq98zh6HGN2
 7tJAEsiXY8fyMIylPgUoVMtUSS2OjbiVFvZEw0g3vLOLXVDh4JilUuncufQpAUxneoFb
 odWoQotpF72KH5f0j0dM/OfS9YWaxZ1MyxhPQFdee6gw1M2oLrTipcKxkAUn8LVKvB0H
 oqmw==
X-Gm-Message-State: AOJu0YyRsH9hSt8CaAXaOAR3aKdjCc/iYrZ6gZlba51zNxRo7WeR/6OK
 yPgYSHtf/JENOg7fG92xH1k=
X-Google-Smtp-Source: AGHT+IHbGguNFjowt/WUg4Hv4Wpy0nhMxW4/Lz37ilFeyba8QPT16aUDMsJeXvW8elMT4DQ7Chc9QA==
X-Received: by 2002:adf:ee10:0:b0:319:71be:9248 with SMTP id
 y16-20020adfee10000000b0031971be9248mr9703358wrn.19.1696238415942; 
 Mon, 02 Oct 2023 02:20:15 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a5d5343000000b0030ae53550f5sm27500038wrv.51.2023.10.02.02.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 02:20:15 -0700 (PDT)
Message-ID: <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
Date: Mon, 2 Oct 2023 11:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, David Airlie <airlied@gmail.com>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Karol Herbst <kherbst@redhat.com>,
 Tom Rix <trix@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Matthew Brost <matthew.brost@intel.com>, Evan Quan <evan.quan@amd.com>,
 Emma Anholt <emma@anholt.net>, amd-gfx@lists.freedesktop.org,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Lijo Lazar <lijo.lazar@amd.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Chia-I Wu <olvaffe@gmail.com>,
 llvm@lists.linux.dev, Yifan Zhang <yifan1.zhang@amd.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Kevin Wang <kevin1.wang@amd.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>, Le Ma <le.ma@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 virtualization@lists.linux-foundation.org, Sean Paul <sean@poorly.run>,
 Neil Armstrong <neil.armstrong@linaro.org>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Bjorn Andersson <andersson@kernel.org>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Rob Clark <robdclark@gmail.com>,
 Melissa Wen <mwen@igalia.com>, John Harrison <john.c.harrison@Intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Nirmoy Das <nirmoy.das@intel.com>, freedreno@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>, linux-hardening@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Am 29.09.23 um 21:33 schrieb Kees Cook:
> On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
>> This is a batch of patches touching drm for preparing for the coming
>> implementation by GCC and Clang of the __counted_by attribute. Flexible
>> array members annotated with __counted_by can have their accesses
>> bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
>> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
>>
>> As found with Coccinelle[1], add __counted_by to structs that would
>> benefit from the annotation.
>>
>> [...]
> Since this got Acks, I figure I should carry it in my tree. Let me know
> if this should go via drm instead.
>
> Applied to for-next/hardening, thanks!
>
> [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
>        https://git.kernel.org/kees/c/a6046ac659d6

STOP! In a follow up discussion Alex and I figured out that this won't work.

The value in the structure is byte swapped based on some firmware 
endianness which not necessary matches the CPU endianness.

Please revert that one from going upstream if it's already on it's way.

And because of those reasons I strongly think that patches like this 
should go through the DRM tree :)

Regards,
Christian.

> [2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance with __counted_by
>        https://git.kernel.org/kees/c/4df33089b46f
> [3/9] drm/i915/selftests: Annotate struct perf_series with __counted_by
>        https://git.kernel.org/kees/c/ffd3f823bdf6
> [4/9] drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
>        https://git.kernel.org/kees/c/2de35a989b76
> [5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
>        https://git.kernel.org/kees/c/188aeb08bfaa
> [6/9] drm/vc4: Annotate struct vc4_perfmon with __counted_by
>        https://git.kernel.org/kees/c/59a54dc896c3
> [7/9] drm/virtio: Annotate struct virtio_gpu_object_array with __counted_by
>        https://git.kernel.org/kees/c/5cd476de33af
> [8/9] drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
>        https://git.kernel.org/kees/c/b426f2e5356a
> [9/9] drm/v3d: Annotate struct v3d_perfmon with __counted_by
>        https://git.kernel.org/kees/c/dc662fa1b0e4
>
> Take care,
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
