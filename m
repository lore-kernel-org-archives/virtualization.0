Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0335C185
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895640; cv=pass; b=P/EskPXExwH1HO566kV4qYyWq1fwv47Bm4cS5Gk1Remd1qYlRlWQ7BE4plSqD9pogzVB0nNsHg+88lq0US52Oa7D3LRVq6GQODyRlKYeW9jD87Bp9gewv7SOF9OlSg3nH0DFhmoL2HVRkeyDIeccbGUHfHCOh1SLNkNcoGj4P+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895640; c=relaxed/simple;
	bh=7MFD6a5UcICIN91+63n2xHiJ/bosqwow989wzJAVM3g=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Gsc+KmAzlYu8EYVor0YPMY2/CFauLM6t0k0Zv9Igl8mNWrYgjxS27E87aPZh9s5aaLJGrj5LlxyLGtKbdbTJrWa7av2h3TFpQyk+oXYHlhAIzSem59/KGjsC3l7IWWwZIsAhZbe/Aoj0nyCuAF5Jq+s1QE14ItytPNwLn0Bovz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=QtAzgzRe; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="QtAzgzRe"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39647184c73so1709585a91.1
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 22:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895638; cv=none;
        d=google.com; s=arc-20260327;
        b=HNsSKLYTxietOeba8D33LlgCs88iv9U4BhzSYcXUj20HGCWewxUFiTjgsB6FrKLk1C
         VdODlxv4W+Fwwhnp2iV1F7YP8+b9EiWhd78jRNGvlqMmVYQBfCZBD+1AVphWTY7ia/W7
         NlJNJYn+oM+M4pTBQv0r7X9SyqIuUN2C3rLN2F/WNx58p/1iznQQKNQVws+H1Hj59XtL
         1GHLU7RJJPnRZ/utC72fhQ78f9amXCqWPlkGNumfqvHUQtIAcqK2P+SCNPrNgnw1qrt6
         tXtNf6Uw9ewfj6cZrHtoTmjgNP2G9IXljx/ohSBsg9xxWlwz50Kw/v+q90No+gIcbdUW
         qS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=jsenq/svfSpf875K1kOfPTKZMXOCv4+dehz8pL28IZ8=;
        fh=hJAVTTFgkN8WMLN92RkxkTCYwFrAvPKo3muihMvJmkk=;
        b=BCVN5h3OAwcsh/sc5HfdJ2ixbflCDnWWSEjhO3u/Yr2v5J08fgbnv9uVKl+f1eGNX+
         nnD+pJkGDMI35+84WzgEVS3zpxUSYMiSQtcTOBfF9830hft3lu94/6J3sNb+OB80zz5M
         WvSSp+mzUqH4B/9R+eexQDk4YZvoV7slbeQx49otpGsceGULHP418+khMuJ+k1qi8szv
         ypxNOtWeL0ySK789JRcGQTQMZMPavm6nZas2uxrtNSxstqNJq8KdyOCSQXXWBDe1mx32
         yP0Qq7srcP9GwtNDzUG6VKy7q/OSpayVOEB+B5b615C+0nLoCkeTnVe6QugEwu0K+I96
         pRfw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895638; x=1788500438; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsenq/svfSpf875K1kOfPTKZMXOCv4+dehz8pL28IZ8=;
        b=QtAzgzReJJP21a4JN0efHACzdv8XDfkBnUxeNy4MWpLIGHXBNHK6BFSzFr56BlunlJ
         NN1YV+2+V7/NqC2yAcJtDqkCEFW2c+Yc+RfwY9ESrPGxG4R6dFZYjk+uD45ABd+xf3rI
         fhv+PDtKmq81EQFOD0UucHHYrpudzjUYBMPy82mZsHfukSRn4blqoZv/EuoLLrAO41Jp
         fJH4OFIaiyD/SCN1U9pB6t3PODegWf/g+MhegzR+blUpXzPm/nGOHhVmlZDJqNaCSxLO
         RqroeKByTMnB8yj35fNXsDCcgmoNi8YMPZc+b1nW6D/DxhaQJJFxloYenqZYc48xfato
         P8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895638; x=1788500438;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jsenq/svfSpf875K1kOfPTKZMXOCv4+dehz8pL28IZ8=;
        b=nwgyJ43qo40ocuQIWj3NleRhyYr1fudgSyqxVj+oKYUF+bJsBUyYg4yEeJ5xu35bD9
         hg9F8KjOODgB5YG5uGPHsQ0W8nI6DOZxPxPS8kEzs/52O7ThubLElgJDnd6bAikXVq8+
         917uAdKpqVgiAZ0pD//hRyyP3uHQLvsxF6LrBZs5DHN6YSdvxrZgrPZQGUuectnfyZv0
         ZAByVlis60PqIEs7GWPtMl4BD2dPmddbi4Jxy8uWnm6PZzEbLWyhG9q+o6sWBZ7PMaSn
         T5pPYL4Taz+NUzEqn/g9PQYl1AwCh7SmytV/5dhH6r0f6creR8r0A1f5y6lKEBefnnea
         hm9w==
X-Forwarded-Encrypted: i=1; AHgh+RqfRRBBIFqF/+cAjMNU7X4XhWT1axr8oA1MQ1A4IGmu7V3A5ya71Wu5j6YMlCua156LJ9MbKGEIcneAuu8UEA==@lists.linux.dev
X-Gm-Message-State: AFuF++l9gI2cAxX8qhFFUvkJy7L/u6dU5mzVKc2PpBDRYXseCZttSsEQ
	AikT9i/zZZJR+TYZIPY3thQEpogekEl4Nl1I3Cl7hlkJiHB8Q6QvmWVH5X66qxHQj8B3TnBlHQs
	5R/NStsvqLEOHAxtSsjiBvzEqmV3MgiwP4CjiAUnG
X-Gm-Gg: AR+sD122W7nOgP7JQXz7tP5tL2b2Xm0bs5vBFLlD5FNYnJ8cp/uoCNJ4RJ2lTll42Mf
	XVNC2SKJOFh0twUWqCtGiJgo2I4dwXNT3WQqS5V1tRiDVy9khOmLuxKN3OTooE3ICX++YxkxIXC
	Bb7C1FXwgBH0fNdY4TTdYQJrCzYF5vo7Z8B5dUH0PmrapqpHj54flfe/i76UG4ntZ2BiT350Dcj
	wE5AclaZ3FVCFOCwuZ63Y/m60UP7iXOmAdq7RMwb4jsTrij1KFTlhDCxd0Vvhb7S3dZOs3hhJJT
	OsnHA9f3gnwLks+s6SBNIQJZ8o1zzqlN+Ywzk7PMBQRfTHe4OPvnzKVK1SO4GSHZTIH+smDrI2h
	QO7bh3M66JoD49UXmW8WKOtD3ziGkpDKqu+qI3DYn3gg=
X-Received: by 2002:a17:90b:5866:b0:395:8124:ac53 with SMTP id
 98e67ed59e1d1-396d0ebcf2bmr4947908a91.6.1787895637222; Thu, 27 Aug 2026
 22:40:37 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:40:36 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:40:36 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:40:36 +0000
X-Gm-Features: AcwNN1XkTEj13XqKoskb6cDvrq-g1IZfLKRJ4nrZx7V9XG2vZIZqA0FIppbPi3w
Message-ID: <CA+0ovCj_MtGXFvyQwFiaLN0uqO9WprxXkAwhiqKA=JzBp40K=Q@mail.gmail.com>
Subject: [BUG] vdpa: use-after-free and WARN in _vdpa_unregister_device()
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
Cc: falemi@asu.edu, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/163-warning-in-vdpa-unregister-device/

  BUG: KASAN: slab-use-after-free in _vdpa_unregister_device+0x35/0x60
drivers/vdpa/vdpa.c:250
  Read of size 8 at addr ffff88810eeef350 by task syz.1.2/11300
  Call Trace:
   _vdpa_unregister_device+0x35/0x60 drivers/vdpa/vdpa.c:250
   vp_vdpa_dev_del+0x3d/0x60 drivers/vdpa/virtio_pci/vp_vdpa.c:593
   vdpa_match_remove+0x97/0xb0 drivers/vdpa/vdpa.c:321
   bus_for_each_dev+0x23a/0x2c0 drivers/base/bus.c:383
   vdpa_mgmtdev_unregister+0x110/0x130 drivers/vdpa/vdpa.c:332
   vp_vdpa_remove+0x5e/0xa0 drivers/vdpa/virtio_pci/vp_vdpa.c:683
   pci_device_remove+0xa3/0x250 drivers/pci/pci-driver.c:512
   device_release_driver_internal+0x464/0x860 drivers/base/dd.c:1375

  WARNING: drivers/vdpa/vdpa.c:250 at
_vdpa_unregister_device+0x51/0x60 drivers/vdpa/vdpa.c:250, CPU#0:
syz.8.826/22808

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
