Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C433B6F4
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027191; cv=none; b=TiiGb9NvEniwyvhSg4Q10MvQqVxxVhOYr+lPUeWUkv9L/gj0wJgwWRZq/M8zGp7uHQSv2q8o/rQ0E8kKRjYTU0zrCrN52UCI/6QYsdI/XhmgRwJyao+wLIHwkWMn1+eU7ehvJTzUSn3KHQK217Q4hYxjALMl9WUPSf+U0MabYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027191; c=relaxed/simple;
	bh=0EL2LR7po/s9DUjjNqlWFSV+gjd+xJ1WILPheMV+JFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sptY6KJk6q5xU+k51Hxo1jlv3cdOdDFTimcwK3p03Be2eqokE1N7JlylNaM8e4FiRyvKEsrvyy+mo4TEOJMd/ngVApFfmx4s04VW9iOaWesaXhI0aFgpMx8c2Daa3W+SbnQtpvP/Hbo2imsWJcLchH0KfpdYDjhdci8rn5zH+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1VDHFkD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1VDHFkD"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3811f512167so5844287a91.3
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027189; x=1787631989; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjmxRYlcS6K8pKZdReOoWwINkSByDyWzsirONrxxVnM=;
        b=L1VDHFkD9c2b/b9hFodGu338w+y04t7gpVmYguq2Votr6HbNy9PUkJhVPeirCjbgLR
         eXzYbivCRxX1FC1i63rImZccoujRfeb0Cu4tYlsn2tpDiR+Pgt2TPr4/z2oYj28JidTC
         o8CiK0uhU6HdGrY+YPyHjeMgBI1aGZuiDe0nAWtyy5q4PtBk44hCHimt+1db24cikMVX
         d1rWIXWveuJoyUAtxnjWr0n6e8c7RlnjF4YZDcFUHk1e63ivPZLS2YOGrzhoQ3qv4/bc
         CIe2K4MraYjLTVI5tOKGcp+FxIHu0f/89EHUPUAUsls52NlXK5oSvQbnV68pv97GPiwH
         dfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027189; x=1787631989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjmxRYlcS6K8pKZdReOoWwINkSByDyWzsirONrxxVnM=;
        b=eiKau7V0OzqiH2PjI3vZlA6dqBVGfjd+nFLXqRSIdiAt6JOJWWP0qFs/QAKs62OEBF
         aBHZTnaJ8K9Lplh+Q0iavxn1mxrd9XJ2SJ0QexvxQlK7GR0TXsFuhoxXf/mu9UqFXUlg
         pWsGx8sacg3Xyj6EjuWPpwrI7mM4unlmrnEhukWcpnz44WOB6cOcToudKw6e+KgllxlZ
         iy3FgVoDdDV2kqOja140KFaUhqimUTaGKCDr3hWWO4iOhVYxcr5dCJctO3ymGjZAliqQ
         cn4qdPTrqEvK8Lex/UH+6bTzp7faPoQ+krUd+EfeTA9ZRIM4ykAKMB2Ia2YrE327l2qX
         A9Yw==
X-Forwarded-Encrypted: i=1; AHgh+RrfSqToRCjIDvkktJyBrUmDhoutfHEWAwGuSTMH79uVtMeMoRV2QTX8jv/M672LeVhYX5Jnsef4pXFdw1QrKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOkBQHfwQZHTNXLbnHM5jRKXFn+0Yj4zKCWdhA0wan+dnT5FEe
	Gh9SZh2WwZDv1p/UTh05C3HMTRw9Sb7vTxr4zRy9HrX0RspclEI7L5kA
X-Gm-Gg: AR+sD12aILTUzET390wjF48QjrRP1dsK2boehuXWlVqCxZ9U4yuPeEXeaxlNPJSoHU2
	pAUqcU+9wKzWeD2XpzZOkS8d8DAm/aLITZ0wVYPyyIck+a43hV8tZ3Qz1Etdn9CQGWLULNacBIV
	TSZ9HofIyqQAHUDptqDzmnGO/3/bRnmyBuYzNDaYiswD2f8stp/kpoxgO1oNLZOCTyTv8neU2bU
	VssnvvdrnfMKNatsteV/BToMaJa2gpRznCRKE65XDxaPpQkqweEIc9C0wzw4qxk4kvZoSj1pnzz
	9XzdTbM+rDqJh5jjwMakuziRaM/KWa0wSlwUmm5L30A4BtzN6eg6MwZLpxMUvc0JkDyvMhxncUp
	J1msgUOLQGUN/fldK3cNCwJclhX9QIAIY/3QPrVJwSk++BhhRxzHKFHCWi0a0pXG7aVMcJOO1Iw
	HGQuNfe9+0gWn9BkmYI5BWtnnxjtCSnOuTggn7wXg0O5KS/oNwbgkG9fiVRf2RGOb2
X-Received: by 2002:a17:90b:1801:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-3955aa0826emr5406167a91.17.1787027189224;
        Mon, 17 Aug 2026 21:26:29 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d1b0143sm4527762a91.0.2026.08.17.21.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:26:28 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v6 0/3] vhost: fix device IOTLB feature lifecycle
Date: Tue, 18 Aug 2026 12:26:10 +0800
Message-Id: <20260818042613.281125-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both vhost-vsock and vhost-net can leave the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. They can also replace an
existing IOTLB with a new empty table when a later feature update keeps
ACCESS_PLATFORM enabled, for example when updating logging.

When the IOTLB mode changes, the vring addresses previously supplied by
userspace no longer have the same address-space meaning. Leaving those
addresses installed would allow an old IOVA to be used as a direct
userspace address after the IOTLB is detached.

This series invalidates the vring access state during IOTLB transitions,
makes IOTLB initialization idempotent, and uses a common teardown helper
for vhost-vsock and vhost-net. IOTLB mode changes are applied even while a
virtqueue backend is attached. The device-wide IOTLB is dropped first, each
virtqueue then clears its IOTLB pointer and cached ring access under its own
mutex, and the old table is freed only after every virtqueue has completed
the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses for
the new address mode before data processing can resume. When
ACCESS_PLATFORM is enabled, the usual IOTLB miss/update protocol repopulates
the new table.

Changes since v5:
- invalidate desc, avail, used, logging state, and metadata on IOTLB
  transitions;
- apply IOTLB mode changes while a backend is attached, following the
  per-virtqueue handoff suggested in review;
- apply the IOTLB teardown to vhost-net as well as vhost-vsock.

Jia Jia (3):
  vhost: invalidate vring access on IOTLB transitions
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

 drivers/vhost/net.c   |  8 ++++++--
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c | 10 ++++++---
 4 files changed, 66 insertions(+), 6 deletions(-)

