Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A883C3F41
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896260; cv=pass; b=BrhPW1P/wTRDFJh30HSOBMycqA0uF5DJRb7qubxw7GHWDh8u3dlJ4/spLqjnVAJ5Z/mv5RzkrYq3qFHmuCpbMcta8HHyTgdeL1qRwc2gwJY0gt0W589val7eG57Qdpl2FPV1hfBHB5OwQw3xsJRmxNxpwAnqpwUmyY/zujhJ27M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896260; c=relaxed/simple;
	bh=D98ZnRgZoVKsWJBIF5bIt1WfQkQAqbgwBKPenuCxKcc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=e0ci31UDBc+Bi3Oj1EigQi4GVwwHm03Etj1QygwONS77GaPFHYy2fE8ycZM7LYw+AOwlqowtVm4IPQ17vXKFk3SGlZlAArZ6qq07Ki3WfaopMIDk3yTAJ7Za69kcwvAqoQNxWfNJi2shRDUqYzsTkf+9DijIvsKGjeDy5hyqBcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=e3+63MkH; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="e3+63MkH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf452def93so14764335ad.1
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 22:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896258; cv=none;
        d=google.com; s=arc-20260327;
        b=hne24vpridz1zX+GsCzJ+7CVNvm3CbV0z0m4BctAkgIPajAanmaFoszfhbGlr1z9WO
         gAZukBAcEM0p1JBxO/en3GXOacXJFOHqLmnOfq8QbBkP0XJXUueMUjYXRGHbNerKhHwv
         /0w87THW50Y427k84QPd34PdXFeu4Ry6wpQmghasGJ73bQ5SZ74ZkF4dTeGK/Nuxy9fv
         CPriZvEdo36M36X3q8Vo3nxW6jb52UQVodMHcEaKvL7s3ytB5xaKdIZlS2dDyTAplHQU
         ZMajdSaxuvidUi9pUHZY9wlNuJ0hH5YrIfPXabc4NWSRnVTtWha/X9gA+BT17SS/6QWA
         UbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=e87d5G70BjGRX707l9cgaVd7OCZfs4SUPvQc3fL2fBE=;
        fh=ZBtzuydxmM2sHCPLvjIQuhJxAEovKLGJGgdPCOUFFpY=;
        b=MkXrdKVJNn7ziiNq2gtnk2bb8cp0Hjd2kBZmyJ8+9qGJnQSc40pucid1C4NGhepQL+
         /SNYXbVK4+qRYbHZ1DnXU3ta3YAJIcAcnodDqXbleZqVMw8fwjO3/xoRELk1hX3COw4j
         vOXJgnzKuOPtvfc2Djp+eLnFhP6OFSJULqiSbTI9JsP74Wzdah+S5Zd/NudsZpT3rwdB
         Vyi8IETQY82H950xgkHZwGXVhb6Rb+UDLdmmDeOArg1o80DyV0Iy6WtqmHLiE5dYLuUV
         b4TGExha4BETtoAnbdx2/4QMdL1Myi0SGe03oP1vXemX7FDUOP0VXvLsYFAPgPghX5n9
         AjIA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896258; x=1788501058; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e87d5G70BjGRX707l9cgaVd7OCZfs4SUPvQc3fL2fBE=;
        b=e3+63MkHnNCGlElbTcrqYnTJAewZ8fGxNnvCi9xkP97QP0ZR2mQPqTwm9p/PA9Mle9
         ExxGSsAIqIX7vBBBN+U3zoN/HpuMFdAH17zRSo2fckFfTgU9eXpm2Ewrq8tovfXZfI9F
         Me4Vi4HYP/pXZgnSwS9pWXg9flQCoDi1tYZYeVo7yqyhiI4F9ZzWfXXzSXF9Oa846g2k
         Par0IHELRAB7TmLZ6HPskdib3y1n+x17IwAY/ScH+VrAkLMZMj08TbLC49IX4ySO43Bf
         /oR6UzGBnKcF5gunUUJQzNnOcBT3GQWQqSdVby9ai+GWGioC/ndl4a/+vc3bKf82S5Lv
         anGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896258; x=1788501058;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e87d5G70BjGRX707l9cgaVd7OCZfs4SUPvQc3fL2fBE=;
        b=d1pNqpJ8LwGMuXJ7o0+1KEGiQfU5IW4qzbaPU/GuQyBVEc2gTvdpWWjZKRwt8GdK3c
         FsqAhlMV/QFY/ygDjKtRmvxz2dQQzkKIHFcjby2bLelc4XDXLXFxv6S+K1hqVfjAW2/6
         NjTMcOfEU1TTBwdFbf3DelcDAZVYIvhPuaS3coCw7uk6kJS474aUh0quOL88kUsbG3Zp
         9y+fsVYllA6T2qTON78KRJZqQauPLFEpRlPhaQZQwcq8IivvzDk2m9i5fD0ctF9vwBi5
         c/4NvVwza2AIyFMcsH8xHmpWE8646c7nomaiwbIrlYKRGuCpLSZq+X6sqt1WiuzQ7wox
         Lkng==
X-Forwarded-Encrypted: i=1; AHgh+Rrg56VeI2GwUGs15akWSkVDoCfgnmyd26OnkD6IQeUuonGg9cWH78g4ZJulEHRkgD4Czbd4wFHfVcWFl6Rx5g==@lists.linux.dev
X-Gm-Message-State: AFuF++lHlFcj5Y4M+zW8oNeya8tdD1tK5MM+M18HhG6OpfYHamFxQqtX
	Qqj7jVh6XQAb65O621CgkcSQ+8Ag6Zlsuric7xPtUpJP3bKNqrT26HNGeVC6uvwrs7ZRXjF0aNX
	ptzQFniY1ZC54sxETCMBDpRqdbrUecx8+VtDqO/CI
X-Gm-Gg: AR+sD13pANfmiTrNA7+ueGi4hoA66e7siQSeBnBhWpWY6JkxrqpW8WLLDsXERPEH/tv
	70Tgm0WsZHlQT+m1Rdk2YGC1zQilBiTME2H9Dl8AHBbp6FUKobBpWHBD3elT7W8YbX8byCi9Q4H
	bFHl+qalahZ7GpIwDG7f/s9Kyj6Z+5pleLkw7grkn1y1Jlryg5OPi0ybAHOg5cZJpWq96c5QKbE
	FVmBit3ui1GqO+JrefvlUyKGe0xPDDyoa/Dm8M7Op1AlmcJ8bJm2JMOV3j4OWWlBe3prGbQu51Y
	FYnbDJHwy4pDJ2J61bYefEeY05AisA9Cy+sOXogSWfzllmHkjRl+InT3Grj1ylMSxtBU9p3sBMS
	Z1Z81wq1KvRcl3BNjbxK8Te1jb/VYv9ShMQ==
X-Received: by 2002:a17:902:f647:b0:2d7:1cbd:9ceb with SMTP id
 d9443c01a7336-2d7269d6badmr162549875ad.12.1787896257763; Thu, 27 Aug 2026
 22:50:57 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:50:55 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:50:55 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:50:55 -0700
X-Gm-Features: AcwNN1WWqcM5yhXJkATKhrOpZ343F8pl4CTVCtlosXKNbW4VXRhrPmb_dA1bLu4
Message-ID: <CA+0ovCgp6tg_QwAh01C3RAV4-s0Lv2BarzoRZtnpor63TRTX-g@mail.gmail.com>
Subject: [BUG] drm/bochs: drm_gem_shmem_release() WARN on nonzero
 vmap_use_count when unbinding bochs-drm
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: falemi@asu.edu, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/192-warning-in-drm-gem-shmem-release/

  bochs-drm 0000:00:01.0: [drm]
drm_WARN_ON(refcount_read(&shmem->vmap_use_count))
  WARNING: drivers/gpu/drm/drm_gem_shmem_helper.c:177 at
drm_gem_shmem_release+0x2d2/0x6d0
drivers/gpu/drm/drm_gem_shmem_helper.c:177, CPU#1: syz.1.397/14947
  RIP: 0010:drm_gem_shmem_release+0x5bb/0x6d0
drivers/gpu/drm/drm_gem_shmem_helper.c:177
  Call Trace:
   drm_gem_shmem_release+0x5bb/0x6d0 drivers/gpu/drm/drm_gem_shmem_helper.c:177
   drm_gem_shmem_free drivers/gpu/drm/drm_gem_shmem_helper.c:207 [inline]
   drm_gem_shmem_object_free+0x15/0x20 include/drm/drm_gem_shmem_helper.h:161
   drm_client_buffer_delete+0x189/0x2d0 drivers/gpu/drm/drm_client.c:201
   drm_fbdev_shmem_fb_destroy+0xac/0xd0 drivers/gpu/drm/drm_fbdev_shmem.c:67
   do_unregister_framebuffer drivers/video/fbdev/core/fbmem.c:561 [inline]
   unregister_framebuffer+0x2bd/0x3b0 drivers/video/fbdev/core/fbmem.c:606
   drm_client_dev_unregister+0x223/0x2d0 drivers/gpu/drm/drm_client_event.c:46
   drm_dev_unregister+0x44/0x730 drivers/gpu/drm/drm_drv.c:1155
   drm_dev_unplug+0x45/0xa0 drivers/gpu/drm/drm_drv.c:497
   bochs_pci_remove+0x3e/0x50 drivers/gpu/drm/tiny/bochs.c:785
   pci_device_remove+0xa3/0x250 drivers/pci/pci-driver.c:512
   unbind_store+0x1a1/0x1d0 drivers/base/bus.c:244

We do not have a reproducer for this one -- it was found by the fuzzer and we
have not been able to reproduce it deliberately.

Happy to test a patch if that would help.

Regards,
