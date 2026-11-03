Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793671442;
	b=23VJUUTZiqmp5HKs7MXLgOt2XjSODEOSZ3w+UEfnXnWRbckam8b1BgleAza2KhC78IR8
	 hx99eIzIW3kjl9No1p5FVFCb1Wff8pF8P8ENr69wfxrWOvy+ZA2AVi7vor9091yZJED7i
	 BafoHpJuNxb+lBITEvamxQ+0W09PF6DGk99no3oHICkVulWPU/z2hovjp2EIF9zn1T3BA
	 30qw//O2ZAQQUtWA1s8eFXO/5Q/3z6Hs8YxQrHx3t1WrkO5/eg0RL3kNOUUbjEuwdhjB3
	 8MsDkiSsq4EdfU8BUw1Bbp+MLol1VAfUsVGBw6oHEKh6ze3HUBnDx1yssNrX9/f7u0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=0IrGdy0k8kotaQ2et/GjO56hruCD8YqC+4+Sdjmhfyc=;
	b=X1dw3e5Vil32F7L03iygkLCaVyqEWzyAvnpuuObxzyiAVrJkv08o+scN8MynjaYNe5XG
	 c4dPUBv4iEo0wJ+IUOs8cHC4ADGdwfMJf8oGBdfA4YqWYGIpmmNQ+sJdsFvbxRfMF9XfM
	 mW6UaXRVTDEfMvSBYnj72zUPKiiC27XASP3X3DMRSVs/FhBNr3Yd4lNlgq/m3OnASzSt0
	 HHmsQOAVvjRovpBFXMLFw8WMusO+5QBtRvlm7GlQBWitNW8AjEfztUmfe0Nx7qAEOI/pR
	 OcLsLE+C86XTGTd2G1/ydPTXDVqr7cy5SF+QTRJISHPmFxGRsA//gnCDq8G+8ozliGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MULKKnSv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F36F606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 02:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F36F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MULKKnSv
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cc0892f92cso1199940137.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 18:04:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793671440; cv=none;
        d=google.com; s=arc-20260327;
        b=A3TR6nlfUaf1KaN8Mx779pxM9IbTgSf85HYY4WjLxmF8i3/TMFS7TOcnzhOLZNuXOv
         7GmVYeGx298DyeVng2w3YratFNroFpaHpMxiDMFvU2zniEBmsmUjgeazLkh+ql55vOzl
         RySQ/ooXK2raaZWAMrFfzfDlvdWVMurwoETYWAMML4BR273dsU7/J4OuMWI7Wv8kX57A
         vfO1KanoyGyvOuMUhLgwgZa/H2jUA49gf2a1wsWUhdnAMDUZ6LCYbNz1GXP9lo+MWysh
         ZirOETnn5GY/uuzrnst5QIIhwnVw3uvxROfbhwBgVIyAS2xPmaO6ixCE6NXgASYV/Vaz
         WOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0IrGdy0k8kotaQ2et/GjO56hruCD8YqC+4+Sdjmhfyc=;
        fh=jZa5eiLTRGk/leJ7toW4KtNJN1tkcVGsMsDRtep+wTY=;
        b=UPMjBwtIJHCI9ar/aThq1yeYCmJNHYJkXcJVyT+2o9zj7JJOeeAUutYuBRDATiB5hD
         J2raB96R+qoOix/ewDpxVxyt8ajh9VtsHS6jFCOmtXesW/DNyl1994HNoro8BiniwoJG
         c9l8Np1OiW0VPwrtBwYHFoe28zCzXxomEpU0Wnce+jTjS+CQ0ClqCgcx7dOO+0mR13co
         ARzIbCFeD8dkql4+iew48iFEEiB/9wrE5OAynh8cAaF1S7nclP8tNcbFOwVBGZ+Qcn6Q
         Tv28MdvrXxehMcEjNCDVlvhyC/g/K6WP2b8UKPGJxt0eLdVziwZ7dAwkm97tWoRnHM1o
         AbmQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793671440; x=1794276240; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0IrGdy0k8kotaQ2et/GjO56hruCD8YqC+4+Sdjmhfyc=;
        b=MULKKnSvQUTeBVwFEZN9vZlBj++vZ5dvo1TB7pBGenp4ETZxBGoLxmDvGdV1Pz5nnD
         NFJeXFBU9YR8SNpNR+BjlxMxPI/iZE2O2nRDa1pglyWqcIfwXY6OE5U6oeDyed2kYRfb
         I+a6iqiqgCQsroZcNoDQEpD4ZaDCC1YMYHKvz49kMV5kJe4c8FnJFab62KIXgNV1xFw5
         YbZgdosaDMGCaxoRHZ/CJf0yFfRW+ndb2Afnm2+d9dwkEa95txmSOFZnyd0c5p5wMEP6
         MoI2Gi1V8K6lNS0kqNACyqDSBcxDbPHYuNRHd1zzos1J263LOGM1yZllG2EYYwEPDUpy
         ufAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793671440; x=1794276240;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IrGdy0k8kotaQ2et/GjO56hruCD8YqC+4+Sdjmhfyc=;
        b=vw3107d8HAeyk1XNFmihmLH7sHDpm+mtpf8Pw2KZgzFRobQFwiJnm/tzSLyJYJL3x8
         y0vL8MI98Zk3fAwxjg9Ga53oGdylNeAWQ5FxORGiOgvkKLXJ9+GAOeThuxB6sS7G/sdy
         nU76XF1IFTUzEIiMZdsi55OxiRzw8adhxN16tAOmGMRzr9xNsyNezxrjGSIQP6eXJvUP
         EHFdFCFJYL09iAbbuqzMrundKT+ZMjSgqI3B0129+E03zq+c0QIwk1EgIubR/0uR7MSP
         RXb7EkyW/E2JGlX7t0BvnTYVSD9RmsBNdPMNtsWmUsSA0+FhnzqsuAtzosyDG/lAcW0H
         WunA==
X-Gm-Message-State: APuU4Z+6UZS5UX0hXj/4yj+B48EZSET3qMKHYvXtpU3QyCn61bedN2Cu
	kr63Tj0V/tCqhang//KA6LC6czPWWn9b5lQc6df9ITHUJA32dStvVLHCGWA6Y/ZBUD5ulfWxJhX
	Uy1Dxe2JsB9+2MuM6Z/4yrTMfaW1orG7GjCI7pxs=
X-Gm-Gg: AYBFou3WzE2uX8iWp+tNqWtpNQKHj08Ofi1n/O9NKOKHdF00TK06tRlBRsNDafuHE1W
	giiQG0B3r6ju9unFcfOfQuMavwKrzoHmQOghff1IGL+ST8yf5SE4SC9uNTOe+ecyrzNuZpT6Oe3
	8NORsmRvQQik9Bwv1isuhbAJiqaGDNdNIqCW90PCoU9tZ8jIbbcRjdcv5YcURYA4ALrSLHhlYcX
	ff7iibnXFzGNk+aK+AnqHY6+Js6PjqAx/gGApmR8PUtT9laCav/VGn+enwhyZ1Y9QfdUr/h3EQf
	gU3RHb2pmkk4fa9vlWTCg5iKWHkfZKRTbEdCJ50lFXphIraGdVGpF9vADvpJ4YbfDujgYoP1Fox
	UD4tC+sj9Ay+oa9STjP+a4FA99G9n4aERk1r01m/7Gy6vejBptGwT405hpeohLL64T5RYtheh//
	MRth1j6+1/Oy1A
X-Received: by 2002:a05:6102:5486:b0:7c5:4da3:aefb with SMTP id
 ada2fe7eead31-7d0728c1b0amr4189475137.34.1793671440332; Mon, 02 Nov 2026
 18:04:00 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: "Balakondareddy.M" <mbalakondareddy@gmail.com>
Date: Mon, 2 Nov 2026 18:03:48 -0800
X-Gm-Features: AclHuK_p_aLLBOhJlhfBh-v00-gxXdsjq8BFem3ZshOJEmnfPk9hTnVFmscjkdc
Message-ID: <CAGETjgxqw5rE9Yfxq0oqNs+VzuHDeQPH0Djd-GfwqbOi06nq0g@mail.gmail.com>
Subject: virtio-gpu: question about device-aware logging conversion
To: virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Resending in plain text because my original message was rejected by
the list for containing html. Other recipients were included in the
original email.

Hello Everyone,
My name is Bala Konda Reddy Mekala. I would like to contribute to the
Linux kernel.

While reading the DRM TODO list, I found the " Convert logging to
drm_* functions with drm_device parameter" item and chose it because
it is marked as a starter.
https://www.kernel.org/doc/html/latest/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter

The TODO recommends contacting the relevant maintainers before
starting the conversion process. So, I am checking whether you would
welcome patches converting the legacy DRM_ERROR/DRM_INFO calls
throughout virtio-gpu to device-aware drm_err/drm_info calls.

I made a small local change in the
drivers/gpu/drm/virtio/virtgpu_prime.c file by replacing DRM_ERROR()
calls with drm_err() call. The message strings, failure conditions,
and return values remain unchanged. I compiled virtgpu_prime.o before
and after the change with W=1, with no warnings observed.

If the conversion is welcome, which tree and branch should I base the
patch on? I plan to submit this as a single patch, since it is a
logging cleanup across a few files in virtio-gpu.

For reference, the initial two call diff below of two changes

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c
b/drivers/gpu/drm/virtio/virtgpu_prime.c
index ebf471044d06..8d764e4001f6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -289,13 +289,13 @@ int virtgpu_dma_buf_obj_resubmit(struct
virtio_gpu_device *vgdev,
        int i;

        if (!bo->sgt) {
-               DRM_ERROR("no sgt bound to virtio_gpu_object\n");
+               drm_err(vgdev->ddev, "no sgt bound to virtio_gpu_object\n");
                return -ENOMEM;
        }

        ents = kvmalloc_objs(struct virtio_gpu_mem_entry, bo->sgt->nents);
        if (!ents) {
-               DRM_ERROR("failed to allocate ent list\n");
+               drm_err(vgdev->ddev, "failed to allocate ent list\n");
                return -ENOMEM;
        }


Thanks,
Bala
