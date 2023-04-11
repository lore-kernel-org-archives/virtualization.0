Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B07C77B6F
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 11:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 358EF61461;
	Tue, 11 Apr 2023 11:07:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 358EF61461
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=P1p4uydI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOnP39em9Rnx; Tue, 11 Apr 2023 11:07:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB76560FA0;
	Tue, 11 Apr 2023 11:07:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB76560FA0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8312FC0037;
	Tue, 11 Apr 2023 11:07:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBA75C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 11:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B911041B5C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 11:07:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B911041B5C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=P1p4uydI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OetXDy45pODp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 11:07:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A10A841B55
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A10A841B55
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 11:07:27 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id i20so11295573ybg.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681211246; x=1683803246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QerpMJ/NA5o5HDiSA3h+P57cppudy/lyaLjUt/s72Nk=;
 b=P1p4uydIJpnDhwTMHvIiYwhOy9N/YHBO8setIkidVtg4qb9a0mSM/psFJQIemWKi8J
 d7dPv8CxCt3v16h0beXniLI/7KGGcPqhSydzWlU1d2V6la0nXYgnpWGgbrODvSReN5z7
 1R+yzYQUcSMTV9dOfKG+E38guJB6Ih/UeZGIGGlUzyA9qH73cZXPJQkqLMHbzQrz7lSJ
 glzqN9mcJvXbaz1zcH6zKJVHCE7MXxgMyzbONjEF74VrmK3eL0FctKKcbkyvsA3RgTls
 7b91qdzQIkSw3c6aqdrwRYFiDn3HFp8/qJFdqYaFwi5+tGHeLrMsEu3zWHxDWrpC7O5N
 hECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681211246; x=1683803246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QerpMJ/NA5o5HDiSA3h+P57cppudy/lyaLjUt/s72Nk=;
 b=fjxEH/LbQs0brPy9Kx9tENu2k8huXlz3XbwSJ5KQCBA++DP4f5eeAgSq53QPCF2MZp
 zXPleP64aiacC4u/WhAGGVNPyJS10YIrsVaruJz/0lzNj+s75ytM0tJZOojIMAp/MKwy
 /fiXJpAtUhr8D9MmQPWJSu3SPBtw9dkuPd3js7AJcuyeq2cKvG60ZeV6s6vJalAvDnJk
 jAFVcYxsfRQUvIl9zfXogQFcKt0d8BrXL1KTDNtp96dvy2E2K6RUzTF4xq9Xb+vqJnwF
 W1OSWus2qfax7iBV4nQINyVwdo/HIFLrp5ddykvO41Aw1Y4OyNgh4V+DEvoBOVJCDJ8h
 T0Ow==
X-Gm-Message-State: AAQBX9e6nvy26CTzkEBY57t2kLqbAW2ntyKM1vlTaO7NklpVB/899qp4
 G5lunOpFWf6KzQawITS82q/y7VhU48m0OLghiFM=
X-Google-Smtp-Source: AKy350Y6zyd2nTxF/toCmuH9AcTxR2J8JoVG19fu966k0sPHAcoGvI1pQPCv+IX45om9J/K+uwKIIXZ7WLfYB4XJqOA=
X-Received: by 2002:a25:be11:0:b0:b7d:4c96:de0 with SMTP id
 h17-20020a25be11000000b00b7d4c960de0mr4796447ybk.5.1681211246434; Tue, 11 Apr
 2023 04:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230409123957.29553-1-dmitry.osipenko@collabora.com>
 <20230409123957.29553-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20230409123957.29553-4-dmitry.osipenko@collabora.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 11 Apr 2023 12:07:14 +0100
Message-ID: <CACvgo51719VsgNqiTO-RnZxXruRvtuMgJ1v5oaq4x5Lrniuaaw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drm/virtio: Support sync objects
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
 Chia-I Wu <olvaffe@gmail.com>, Emil Velikov <emil.velikov@collabora.com>
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

Hi Dmitry,

On Sun, 9 Apr 2023 at 13:40, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> +static void virtio_gpu_free_syncobjs(struct drm_syncobj **syncobjs,
> +                                    uint32_t nr_syncobjs)
> +{
> +       uint32_t i = nr_syncobjs;
> +
> +       while (i--) {
> +               if (syncobjs[i])
> +                       drm_syncobj_put(syncobjs[i]);
> +       }
> +
> +       kvfree(syncobjs);
> +}
> +

> +static void virtio_gpu_reset_syncobjs(struct drm_syncobj **syncobjs,
> +                                     uint32_t nr_syncobjs)
> +{
> +       uint32_t i;
> +
> +       for (i = 0; i < nr_syncobjs; i++) {
> +               if (syncobjs[i])
> +                       drm_syncobj_replace_fence(syncobjs[i], NULL);
> +       }
> +}
> +

Can I bribe you (with cookies) about dropping the NULL checks above?
They're dead code and rather misleading IMHO.


> +static void
> +virtio_gpu_free_post_deps(struct virtio_gpu_submit_post_dep *post_deps,
> +                         uint32_t nr_syncobjs)
> +{
> +       uint32_t i = nr_syncobjs;
> +
> +       while (i--) {
> +               kfree(post_deps[i].chain);
> +               drm_syncobj_put(post_deps[i].syncobj);
> +       }
> +
> +       kvfree(post_deps);
> +}
> +
> +static int virtio_gpu_parse_post_deps(struct virtio_gpu_submit *submit)
> +{
> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
> +       struct virtio_gpu_submit_post_dep *post_deps;
> +       u32 num_out_syncobjs = exbuf->num_out_syncobjs;
> +       size_t syncobj_stride = exbuf->syncobj_stride;
> +       int ret = 0, i;
> +
> +       if (!num_out_syncobjs)
> +               return 0;
> +
> +       post_deps = kvcalloc(num_out_syncobjs, sizeof(*post_deps), GFP_KERNEL);
> +       if (!post_deps)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < num_out_syncobjs; i++) {
> +               uint64_t address = exbuf->out_syncobjs + i * syncobj_stride;
> +

For my own education: what's the specifics/requirements behind the
stride? is there a use-case for the stride to vary across in/out
syncobj?

Off the top of my head: userspace could have an array of larger
structs, each embedding an syncobj. Thus passing the stride, the
kernel will fetch/update them in-place w/o caring about the other
data.
Or perhaps there is another trick that userspace utilises the stride for?


> +               if (copy_from_user(&syncobj_desc,
> +                                  u64_to_user_ptr(address),
> +                                  min(syncobj_stride, sizeof(syncobj_desc)))) {
> +                       ret = -EFAULT;
> +                       break;
> +               }
> +

We seem to be parsing garbage(?) stack data in the syncobj_stride <
sizeof(syncobj_desc) case.

Zeroing/reseting the syncobj_desc on each iteration is one approach -
be that fully or in part. Alternatively we could error out on
syncobj_stride < sizeof(syncobj_desc).


> +               post_deps[i].point = syncobj_desc.point;
> +
> +               if (syncobj_desc.flags) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
> +               if (syncobj_desc.point) {
> +                       post_deps[i].chain = dma_fence_chain_alloc();
> +                       if (!post_deps[i].chain) {
> +                               ret = -ENOMEM;
> +                               break;
> +                       }
> +               }
> +
> +               post_deps[i].syncobj = drm_syncobj_find(submit->file,
> +                                                       syncobj_desc.handle);
> +               if (!post_deps[i].syncobj) {
> +                       ret = -EINVAL;

I think we want a kfree(chain) here. Otherwise we'll leak it, right?


> +                       break;
> +               }
> +       }
> +
> +       if (ret) {
> +               virtio_gpu_free_post_deps(post_deps, i);
> +               return ret;
> +       }
> +
> +       submit->num_out_syncobjs = num_out_syncobjs;
> +       submit->post_deps = post_deps;
> +
> +       return 0;
> +}
> +


With the two issues in virtio_gpu_parse_post_deps() addressed, the series is:
Reviewed-by; Emil Velikov <emil.velikov@collabora.com>


HTH
Emil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
