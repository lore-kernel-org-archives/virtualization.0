Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFE8C11
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421573; cv=none; b=YGgkTaKzCpA4Q4QwNmAuALJooEtvuDTAiaf0IYujX+62KvQPCMHvPIffxg8VOLZxhEZQz7cK336ESuh27qvk38ZXwZmBUlxQ5HCt3a+dd6N796fJni/+egqWaLgqJ/LBaGM3Ht9unOJHElC9EDAey9FdW7Cp3ki8RGqC9hIXGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421573; c=relaxed/simple;
	bh=K1zbq6PPOj2Nt3RTfjEHCocHtfTNgnmPAGzwIG6Qz4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hcWGlJ1vo3jFNOAmG9yY+Ut6I0lxLJwjYWWsbEegxa3I1HRDFCTQfuiPj+ERAWJ95vt7KsWRPN2/K1Ejq+wo6aTS8OisOq2wZ8eWlE1YtfaWPNJwPbisi4TtKcO8jUfFeA3BInwJT7fSmAy7md7PCUT2B4ZAcVDgsH6P2/ADVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AgYnscwL; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AgYnscwL"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c718ddd87eso208959b6e.0
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713421570; x=1714026370; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1v/jI2hXzIfhgMNddOW2kA5hdfBy4Wa/kY3ba32ESU=;
        b=AgYnscwLMEjgEmjfXMkfKyA6FwTa+MdsWS9X3USVl2e+fu2ydrVpI9Dt1qLv8qFvDW
         oPghDVSwykRrQfAFoEMdB6R6LAoaf0o/6PAbcoIkCywufpqfWZQdcglApP6cT55LcI1n
         98zg8emdI8cZORt+frHED94tr4AfNDjfKiCN1v0El7r/uZ5loTrfVz+kyY3H1UrH8Uy1
         xVCmBkKMSnai76eSW5eZtKhf0XXeQE5m9ubGRhbSnty2Ly8bd0g+11g3FFbAfY/Wl8wa
         i0CJBKuFRYVbOpqlgoMhIrp1GFD7Dj34jqseiwzL9asiXuqvvl7CCfSRQtSW+MjSw5p0
         JGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421570; x=1714026370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1v/jI2hXzIfhgMNddOW2kA5hdfBy4Wa/kY3ba32ESU=;
        b=ZlL3ojc2lBVrP7omlB7ctEYu9LZE0u5CNt38DwNE8oIHdUPJXFv3uwj5I47HF7v1Uv
         O1ZyrfQ+6dlEMZywllrUdcDorxC0wPcHKRsV/o4PYi+0yUx7ljmJuXQ+Ua+1qW6RYK5R
         MMqU5U1tdOUadJ1zEKV/w3x7yWtYFwr0U+QTNHOcDa/XPyYrCp73hHhLlVjrLDWOdTnn
         nuyEZjZT9ezMh0VU8p2uiU/hpHW2YEcMjRmLQikKVzTCD3484N6CFJDrGnf9qlAJsUuO
         /uJeMlSOvcyuGVD15EmsdzTo94xrYlmDsW9SoW8oxWWiD7iR9+fpQercxBbG00Q2WtrN
         LIEg==
X-Forwarded-Encrypted: i=1; AJvYcCW0hTVA7UdLyB5Vz7Ar1BDtBeHKGwOQC7hvYzaPz98nSsQ+D2duLY6g37mA+k8DFolYed3DYK7hAOoHwdSImHF5P0Fl80WF2jrvSbvYHvw=
X-Gm-Message-State: AOJu0YyeZgbFNkmZoUW1mSSrYwVfSwXKEhaYFWwi8YkTl62Rzo2teaFW
	vx1pLentvQjBL5RTmx3xZRlVwI/kXlq0c7MfQj1YY1l8n+3xOjJZe88iEb/S6J8=
X-Google-Smtp-Source: AGHT+IGhj7EAWggo4CaUaClDH/BTuOmWGmN3tEcf9kJ6Ea3ULSg/eqjNI+uRAJpd+fVuL7oXc0AlHQ==
X-Received: by 2002:a05:6808:2803:b0:3c7:bdc:c709 with SMTP id et3-20020a056808280300b003c70bdcc709mr2028041oib.14.1713421569927;
        Wed, 17 Apr 2024 23:26:09 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm666392pgm.23.2024.04.17.23.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:26:09 -0700 (PDT)
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
Subject: [PATCH 0/3] Improve memory statistics for virtio balloon
Date: Thu, 18 Apr 2024 14:25:59 +0800
Message-Id: <20240418062602.1291391-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC -> v1:
- several text changes: oom-kill -> oom-kills, SCAN_ASYNC -> ASYN_SCAN.
- move vm events codes into '#ifdef CONFIG_VM_EVENT_COUNTERS'

RFC version:
Link: https://lore.kernel.org/lkml/20240415084113.1203428-1-pizhenwei@bytedance.com/T/#m1898963b3c27a989b1123db475135c3ca687ca84

zhenwei pi (3):
  virtio_balloon: introduce oom-kill invocations
  virtio_balloon: introduce memory allocation stall counter
  virtio_balloon: introduce memory scan/reclaim info

 drivers/virtio/virtio_balloon.c     | 30 ++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_balloon.h | 16 +++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.34.1

