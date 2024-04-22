Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980A4CDEC
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771784; cv=none; b=Gyl2WETyy4TNTQq2qMljKjmKw8GE+fKcy5j2y3p6od5AOrhMzaMPPr8lMrtc0fNFx+BAfvS3eSeDVuNRdDiohvCVxSirgtw9vKzS/nJz6zXVmL1Q3reaGygUHdPDhKcOtb7d+8S6F9L2gxRBr8xIWgArF6o4Lbs08IDeXhXLMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771784; c=relaxed/simple;
	bh=BL2/0H6F8WBTWUlSs53lzMzQSUcfTxv4A65JDP4NViU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goVfhg0aHQ8PmZmcRIG3sKl7RwBSHcEL3CQEGSFTiSM2VU2xEOF+/gOP1jePIC2XKozDCFEXPTtDYKd4Gcj6YyjuSUi/ahRRWEfXRyzQLWnQ98EPPpSa42vXQZSBf/UWCH72ez7KcBBKlkjWphL/Pvz1xOiIh0mwdgecpbMQ8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vr9/4qqM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vr9/4qqM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e9451d8b71so11141385ad.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771782; x=1714376582; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYgATfqd8PwpzBjyvQ3X5QGhq7/z0CGn9EB+eG5v+V4=;
        b=Vr9/4qqMQs8bupi1h0WHf137GhCLqy9xbWmE4CWlkLTgd3UkFov/HVhIMvxa577RTs
         X0EyEs+0AJr1OMwaRt8jqqKdjWYQw43P/ltH2iqNdVgAnUXOigyf0QrCtl//4gCIJoMd
         XY+ZwHC7ED911eKPoBZpUOv7aYCPksogdULgZmaqBpqFGzeibBFsoZE3mkuyfMOhv4Fz
         DtKev5gF6TfQ38HZvKGGRITfvgXqtn0tiiTiLW8sW+KnzLAMDP9cvW2069wSPdPnXx3H
         JPCWrD6w+YC7WfuFPsjVOlDWhyS8ZNt5tqk5BgxuDUCEXhlJb9VHmje7DGFNqZmdG0iq
         yIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771782; x=1714376582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYgATfqd8PwpzBjyvQ3X5QGhq7/z0CGn9EB+eG5v+V4=;
        b=M8ZkY8It0gjRnoc79bBp8tYPFH2xE7Exv2obw5k5FhjmdWAWvNS3danSAEPp8ag2DE
         rJ0aDYdfI0VibLxKUqdmd4R2Ye53tFDTJ5fjtY1MavkIBKOW2TgP9dvlTI8MbI2c2kR0
         uizZLF0XcpO+88D/EnprYTnJ7YlcHJW698XMiYbKuClTY6if/7yaEXltkP2PtevPcI2Q
         l9CZNlMuZLd+Hr33LpdktDSG9Bxv3WktLbkUBtGH4J21k+c9jdlEbkRASUpy9UKgsGwy
         ooeW9odJ01MbG4qQaIqfNlaLIIZ3iFG6NBTn/60xISvHkq4zjlUUHI/NZldpe0022IZR
         yaKA==
X-Forwarded-Encrypted: i=1; AJvYcCVCsM+StEqmmYgTWqM4L/0M6IX6WYKxZTmTIeaOUO2or/qUhSH1Fh5e+/wzXBl2qyZR8P/vNMEcnl0DVgg65mblhIgy0v1Ghk1DmRX859w=
X-Gm-Message-State: AOJu0YytyUiFjdNAbZUrmHGUe+NuwzLVAKcfnbCorIJ5TjJuKPzCH+Xr
	0QSkwrdTb6uQcnUZy+KS0Isq+94V/HmJ0/08zI4UrbcMoBli4Ql5hDoLpfbAqSA=
X-Google-Smtp-Source: AGHT+IFol5Y5ktMWyOI2cuPBIxmgu7AtxVOQpJvNM6eO27t1EtFMPHBED8lk/OFCqWjv6MNhStM2qg==
X-Received: by 2002:a17:902:ec8a:b0:1e9:a0ce:f60e with SMTP id x10-20020a170902ec8a00b001e9a0cef60emr3671572plg.19.1713771781857;
        Mon, 22 Apr 2024 00:43:01 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:01 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Improve memory statistics for virtio balloon
Date: Mon, 22 Apr 2024 15:42:50 +0800
Message-Id: <20240422074254.1440457-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

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

 drivers/virtio/virtio_balloon.c     | 62 ++++++++++++++++++++++-------
 include/uapi/linux/virtio_balloon.h | 16 +++++++-
 2 files changed, 61 insertions(+), 17 deletions(-)

-- 
2.34.1

