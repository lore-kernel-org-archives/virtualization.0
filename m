Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA9360EDE
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025884; cv=none; b=Mbtt+29ELYw5zcyjQuZzQYkqwzhcjGCjZujMnWGg+3yu5M2qPDbfv8fuBGXR9rcD44R/SjgS0JWGSrEHmdbFkGjZvALdH6SwUPA9Iwu5Ge8rXl+NQlpFKRqlvNxzUTLElSMasiAynGSl1C/eg8zQKGDEQMb27fXq8IzP4Xpqd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025884; c=relaxed/simple;
	bh=lwzenrEmvFq6Ms+TlrhhSnfYi9JXU6L7/Vuwgf6D3Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usWzaICjM+yoRxTgoSKlTTAto1rw3QpC1jECzRDupEBcRFydm/GEt7pNoJJgAELjMR2xeJPuAY+cru1QX3lmY1OKeggjmCvDJplhh/D7aIFMWsPupYkxqsFoGVjJEd3aE6pXEGVI6PHAbyrBlrd5kOhObIO0IjXzqvphYnBnyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu2U/6cZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu2U/6cZ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4815b8781c7so1647365f8f.0
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 21:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787025881; x=1787630681; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoGu1OAypKCl2TYpCNd8T62EqWCSWGfh3kJlxm+m1qo=;
        b=Fu2U/6cZImFBcUG8zztME1W8PnSvcA4trjuElK8UBwDrYWIc5HhFXiXR+hbTmIna/D
         AdIukZArhzCrL7+LHWgxsDmM7hoG9oa4uR2EiplIIBsCQEpqu3vlzOGDqsZJyDcmGhrc
         i9VYvufYhedtVrgja1nA++KKJfmiIxNGbjGWX1RzD9VBoGdsdLIkdtL9FCVpR6KmFPEx
         cdm/RPgkdsQ4g+Ij0oKj5YbvSKeRg+eTll4DEfzYtWNzObdnvBQ2cIQ4vtwOkLaaM7ti
         EKIQ2mqDn66LWuyGf4vhvqNS2Gz1vOobDC66BZufMSAzRcyVXRJ3tj9bT4hvLi+ydcp6
         Auqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787025881; x=1787630681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HoGu1OAypKCl2TYpCNd8T62EqWCSWGfh3kJlxm+m1qo=;
        b=pVlb0QwqoUK5+MJiymxVtp6bt/i9kO9xmMcT8PI9nUyo92ZDOmvOEhD5QFiBUISDkr
         fs65SaifGM6tqRPu+rAmp4KKsUdR9AVLEcRhHD31WQjI3YfSbck+zpUc+xUxT63sS5Ln
         2lUg0umbp+t3+4OWyJYDBmalv70CsnZ/imzmhmvpwmFHCgx5sPxesmpuyKX97j4z2qtZ
         tJjbTlZfkcu+bXADNJP6mXxGp1y5UXfO+4hXkfieuikAo4Fe5xWA1v+Wx06BNin4gYd2
         aYg54rpE0EOrX6ZRS5rPIoZFOrS0pXwtDfGS2ZLllf1vq591II45Wh0k4YtmfEHWoFot
         dqHw==
X-Forwarded-Encrypted: i=1; AHgh+RrOyXQZ4+bfd+QB5o1uLLvvwQFvJdcPxlK12FTqIpBaQkAtMq67LAfigU0HFSkyER8Cwafn4PMhDwOa1HosVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzidlGP431PB8oB6ui/JuCt9+HFb4Fu9RC2kxRRDjRloGQ1YXka
	Vge8lcHgZjEb3HutXfqzg+uwEsFvetyUQeN1o1DTdmnLhKHzHRZsn+Po
X-Gm-Gg: AR+sD12i3fguRMbpAc995xsdCev51W1MMiMtmT9J+IIq144gGrEjPdC44tiDDk+8+Ku
	aPqiEj17ffxN3MyE35JyDDdiIQJ+R0tbcNsiyAUFsFFZSSUS5YswxtFTqz7+u5qeu1BMqXMnTiu
	cOVGTyh7Yg7KvYiwwz2dUpwymsXCW/wZe/DW09lBMuRmzwK9A/6CyHkfElvECTpwEQbJXdyiZrg
	k8hZr1SGz1+rTTLGW5D1HBZYELsynLj50F62YuvCNEQzmIsGpaAiDRzSdg/i/4Wc90Rlp9ZZsud
	4VZtGqbQLJz4+6flXpZ1RmNLE26PD59WDVNHbnvZ9CAgGzhJ5C4YvZUpX4ibxNcuSkiKTB5U3iW
	m0ETdowaQ/Ew1gU/5bYnuUWZGgZZOnljb4g+FV8XdvC2Mv5JmUwGh9dalKnEIxT69gvFPnEnuJm
	zLtDpiHTnPDemBfUX9IFp4EXVM+sa3xpLHXmxFEoVtxx+wD3CjrOhuUL1ST7S7C3oGHIfcCCMg3
	gEUT7jNC3l2Od2oB8+Hmybdzw5HV/kwEwF3BN3XRa6VMm1LhbzCIyfcxMg4s5kzQbWVp6nTEtli
	GO8PiWYYqYG5tPuiL7mVvAc4Q650Sop52JgY6IRKK052JjLm7d5HeGymth/xepzn3/ovFoaGgVc
	G1kT8YlE=
X-Received: by 2002:a05:6000:25fe:b0:482:a9d7:7ced with SMTP id ffacd0b85a97d-482a9d77d37mr6882286f8f.14.1787025880688;
        Mon, 17 Aug 2026 21:04:40 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a88f-5701-94a8-6746-801e-fa61.310.pool.telefonica.de. [2a02:3100:a88f:5701:94a8:6746:801e:fa61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm9030108f8f.32.2026.08.17.21.04.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 21:04:39 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] virtio: synchronize callbacks during device reset
Date: Tue, 18 Aug 2026 06:04:31 +0200
Message-Id: <20260818040433.66986-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_reset_device() documents that vq callbacks are not in progress
once it returns. virtio-pci delivers that by ending vp_reset() with
vp_synchronize_vectors(), virtio-mmio does not, and a driver that frees
state its callback uses then hits a use after free.

Patch 1 brings virtio-mmio in line with virtio-pci.

Patch 2 makes virtio_input reset before unregistering its input device
and stop its callback once teardown has begun.

Together these patches fix the use after free on virtio-pci and
virtio-mmio. Classic virtio-ccw and other transports still
do not provide the documented guarantee.

The use-after-free was reproduced under KASAN with the race window
artificially widened.

Callback synchronization was tested in an arm64 QEMU guest with a
virtio-input device over virtio-mmio and four vCPUs. The event callback
used a busy delay, not a sleep, and an in-progress counter tracked
overlap with unbind.

The driver was unbound and rebound 120 times under continuous input.
With patch 2 alone, virtio_reset_device() returned before the callback
finished in all 109 races, each in under 1 ms. With both patches,
vm_reset() waited for the callback in all 111 races, taking 24 to 86 ms.

Karl Mehltretter (2):
  virtio-mmio: synchronize callbacks during device reset
  virtio_input: stop callbacks before unregistering input device

 drivers/virtio/virtio_input.c | 8 ++++++--
 drivers/virtio/virtio_mmio.c  | 6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)


base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
-- 
2.53.0
