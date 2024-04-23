Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F815E89
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843680; cv=none; b=Md5uEzKl/tORE+ZTaw2oDeri0Ts9apH7PEfp8Qfw8QCZNOzhaSG4+hjwWi5KacJ1iXkel9iR3YfbHbZdTyw/+PXmwTsttA9DZ7ZeOKnunP8Mb3y3ca2F3GlcBmCVNBQgdTDjtZSPFO83bPeb3E7mZr3X+TtgVCFyYdf0iO6hZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843680; c=relaxed/simple;
	bh=+rXh4B5S1uh8zmTXh6puCWL3M5rykn5+v7UEjZMHFl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hR3ndQhQpnqepiErRbaPJWZOu2RJci41QH807+QrbcXI/xY23G1JCsviDyZZi4DZLU4KfSjuTci30kHzQYgurnM8ddMRmXAfsFr2fVatHzU6jc40QxDrweltcGhcyE37Lj7Hk3zYK4fbBAdPPaBIueAKQDmtW9XUcxDBK0nwEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XlAW6upu; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XlAW6upu"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c70ef25e19so2602652b6e.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843677; x=1714448477; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjJS7WqCOZAp/WxLm3nihNxnVyk7dtqgQ5dpKk/9wR4=;
        b=XlAW6upuuzGJAaJIK6iVg4w5mAPrZlYjxY2y/obj6bQV7T066v2+LDFudYKfhdrVZD
         med5er2EaZ5k85Fg73yJlQIJqvbYz7zX6klsFg9GA1SnXPc7jPQWNLqBAhKCnPZ899a1
         FWovWY+00LK93Mhp/0/3DWdJpQibnRVfBQizIxFdnk4bDXY51WTs37YJLPA/vC2KF5g9
         HEriNK2Qz/0Vw4eNmIj3A4HXjTY93cqPvIxgJbO+YjVn75aba0A6kAlFhpsMKyuv+Z6Y
         Gp4Qwp6Nm8ExkXSc5xU3QWZeWXZ7lfAXRa0bhyonNMfSKkmS1+cIgTroo7LznuFv0dvC
         kgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843677; x=1714448477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjJS7WqCOZAp/WxLm3nihNxnVyk7dtqgQ5dpKk/9wR4=;
        b=pQHd/YKJBJGtkd/fXbu/SOk8XgMqqgYR66mTDnUvhbVq8ugVG7Cv9TBUvJs7utBqY9
         ynflNMdndUkkEIqbFL038gJCZ3jbBERIsnp0mjU7Y6efXciVa0ckjNyLldrmvk5BXzf9
         UabftFb01rNWo9nHeV/nTwu64tfjI2xTqu8w81swqwylRpYghTf982Uq+uLj/n5030sd
         HGtnRYjWCQtJu7HqqEXzt2goAq5RkOCFStpKf1cjbkfMtDadLxlwp0y6W+TiAP+/KoMR
         Mp0eMDf0WAJc4sujj9ce0jHPuXukdZHbUOvU8mv3jObuYdVykFgsdZB6/cBvcKHcNflc
         ZKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0kYLLNwZwWItlFMmlmarfgvPdvFOsgLZe6dYyQoALx4s/QR9X6xzAzjaND4fXW9YAJ1GEpXHgKsYOiau0ll4yIc+FVMQ0LZg37Y/bpRA=
X-Gm-Message-State: AOJu0YwE9JAhL6aaN6WXnYXovLbLnhC19tEQ7+ib6GZpsfv69tYiZHGq
	PDSc2oxEfTFd9OC/KgBttHiqWJLWjKWnBy/8w43RnpsmHnHTzZQYyT00zwjsS+4=
X-Google-Smtp-Source: AGHT+IE/aRevXp1DoAmVuqihOBa4j/597rgYv21zcw5kCptxPV/GAXROJbpNbFqZnRba+Tfc/UXisQ==
X-Received: by 2002:aca:2404:0:b0:3c7:4f19:3b9e with SMTP id n4-20020aca2404000000b003c74f193b9emr11880071oic.0.1713843676781;
        Mon, 22 Apr 2024 20:41:16 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:16 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 0/4] Improve memory statistics for virtio balloon
Date: Tue, 23 Apr 2024 11:41:05 +0800
Message-Id: <20240423034109.1552866-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v2 -> v3:
- A few coding style change in
  '[PATCH v3 1/4] virtio_balloon: separate vm events into a function'

v1 -> v2:
- Add a new patch 'virtio_balloon: separate vm events into a function'
  to avoid any compiler warnings(unused stack variable on
  CONFIG_VM_EVENT_COUNTERS=n)
- Suggested by David, use a loop 'for (zid = 0; zid < MAX_NR_ZONES; zid++)'
  to obtain all the stall events.

RFC -> v1:
- several text changes: oom-kill -> oom-kills, SCAN_ASYNC -> ASYN_SCAN.
- move vm events codes into '#ifdef CONFIG_VM_EVENT_COUNTERS'

RFC version:
Link: https://lore.kernel.org/lkml/20240415084113.1203428-1-pizhenwei@bytedance.com/T/#m1898963b3c27a989b1123db475135c3ca687ca84

zhenwei pi (4):
  virtio_balloon: separate vm events into a function
  virtio_balloon: introduce oom-kill invocations
  virtio_balloon: introduce memory allocation stall counter
  virtio_balloon: introduce memory scan/reclaim info

 drivers/virtio/virtio_balloon.c     | 61 ++++++++++++++++++++++-------
 include/uapi/linux/virtio_balloon.h | 16 +++++++-
 2 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.34.1

