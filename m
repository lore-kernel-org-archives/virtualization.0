Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145B343D9D
	for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646465; cv=none; b=ZWASoROzccD0ZvM5qqb2dBmB2lnQqipKc+B2pJpulJKePAoK0DUU3NPdtK7pDERvnTpNmF2b2X5J7I9cTFCODQUefdSybP0SRKm/YAyDyUskBOh4RoY6EVsnq+//V6SsevrNkH3GQ7epNdaDnCW8Ndse6MxkPGVxTxB1kI7vSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646465; c=relaxed/simple;
	bh=FOST2SIH8KNu5sFPdASitTj88z2weYmpfxU0ADa/Ut4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLf30CWzD7LiQQ/U2jJJV6zT9D6H3/5+LQxrGnLXypZWbBZtdRqe7WGVd7ix4sbbMFZ3nQnj13hB6BK7N9meV0ewlBCi/PRNwYmKRCuZc7Axmu3ZiBeGN7fRWcVbcSHfg7DbuwH2Wn8dtw0KkEca8KKlIfGkVaJES80rFfnbDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDf1LxIY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDf1LxIY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso8846555e9.3
        for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 05:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763646458; x=1764251258; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A948czYa/5mtbIsBZpYcXkd9XJ+jdzzvonGe4csxiCM=;
        b=YDf1LxIY5vote8/75+nVsj+aVP4HSuPbBdweSE/1nifabdc26UaoAJ2s0EVZi/8b0Y
         W0l4KVr/6o5F9oDvYtgykyrc99xkfUDKmWpusDFO51olYAC8f/M5juAiaLBHoS1bi9NH
         vv+0LFUIa/EAaUS0+KW6x6r/z/zKxFlbHNoKsNFgAu8xkSgH2FPyq0kq1BGwHCY47/uE
         NkrElza9pWx95/+yH8oO1QOh8JkqVjU4mdsWiBVuELJNLixSN2N/L84G8GvxTtn7wO5W
         Tcuie8jjYqJDKPNTCtsxAIL7saEcH1BoNRSLZxYl/YbXf9iJeiUkG+vl+Xm8Xz0Ug50p
         K79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646458; x=1764251258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A948czYa/5mtbIsBZpYcXkd9XJ+jdzzvonGe4csxiCM=;
        b=BeihFtcXbeqOd4QeyKGvsdM2F6WGCvF9tHbpCBYqYt9ko9QGj5qnF+NFvmqcc/Kptn
         zBkIIwvYVc4YAPsHTkOlFm9gOeVt1T6YFnMDFcL1gPn5GdEpfuBgd6vVGxDwkchb7fFT
         eysJJaGjewiMj/vc+0JwXs9fWVRc7Ta+t8JIqqrhhUkbzvMJkicE3FBc3+2aVkZXuGVk
         OKif1spz+GJhFg6Uqi2k2tiVBEVajMJV/4dOyANY/eXfwxEpaF5V24hWIGaGzpEGA2Mp
         xmGqf9MIjFujWpAGJoN0tv6Cc9i/wrjULwWLsMMgLp5aDo8+cJCey6hHD1GG7ZFBYiQS
         JLTw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5hvGwKriqH0sOjQ4/hfytU4qDH7CsuQg0pZZ64t0LbI9lXgjHVEHcYWG5PXa+QQoRu4kCh2S+mx41fNeAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxS8WfiK3QNF7Al6mLFGJvyVN8xHoOYyVKXE70zj0lE+Jpsl0K0
	5GAOhE/93rCZVk7g5ZKuAXa7FSBguh+PMk8eXTLlB7ZACTWvKLnByr5SthBFemYQ2akUE+sOzTp
	sNTFC
X-Gm-Gg: ASbGnct1Uf1ZvSE0/S53XX+rPxROgorUTb4RJrehRXJG5VpbWs0p5AWQ6OKVIWJ7GUI
	NhPdNrfjDI3tuxPMJACL6qltJN7o/YtDffFzZs/ByO4BYTJhu7oHtmZfiwRXRxNJ5TKqjxsD/xW
	AS60UbiyhyjHyK7XWRKPAkH53870Wy4UgOCRqHpB9dnxSqrYzec1ynZ/DnJSM8pxH1oUEQ8fqGO
	pXdb76EiOEH+OICL/PRtz9b7BF1ElOQ6sUcuiY+/jLO9mOGmO2WUY2NFRix3OmiThwBUZ02DttV
	4Zmf8sQCg3mo2LIR1UliVnjvAaxQvIlkbMIn8l40c74trCiQbUHUXa26+aTSOn3QjZwNICuEp0j
	t4S94w+4fio8ZVEiB+w722UIYRteXUS6FdEX8Hz8rdMHhC3jR+Kqqek7TSt8Kmpzkooujv/vIDN
	/kLr/0hk1hr6iwjo2rGXnqCiXivRb7zxGT9pMxBIRAbbp8RCOh+z8=
X-Google-Smtp-Source: AGHT+IHIFwwhuCDej7n/kiB10UzGUUQ69SdWa1m4LkYqLOz7xqjt7Vge2BzyTTaTh7YeRH8lFH7akg==
X-Received: by 2002:a05:600c:3b98:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-477b9e1a4a4mr30099085e9.22.1763646457798;
        Thu, 20 Nov 2025 05:47:37 -0800 (PST)
Received: from myrica.home (233.226.6.51.dyn.plus.net. [51.6.226.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a973dbabsm67690775e9.3.2025.11.20.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:47:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Cc: rafael@kernel.org,
	iommu@lists.linux.dev,
	virtualization@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jean-Philippe Brucker <jpb@kernel.org>
Subject: [PATCH] MAINTAINERS: Update my email address
Date: Thu, 20 Nov 2025 13:46:22 +0000
Message-ID: <20251120134621.277272-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use jpb@kernel.org as my main address.

Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index b5e240f78b8c2..71df089720b38 100644
--- a/.mailmap
+++ b/.mailmap
@@ -344,7 +344,8 @@ Jayachandran C <c.jayachandran@gmail.com> <jayachandranc@netlogicmicro.com>
 Jayachandran C <c.jayachandran@gmail.com> <jchandra@broadcom.com>
 Jayachandran C <c.jayachandran@gmail.com> <jchandra@digeo.com>
 Jayachandran C <c.jayachandran@gmail.com> <jnair@caviumnetworks.com>
-<jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
+Jean-Philippe Brucker <jpb@kernel.org> <jean-philippe.brucker@arm.com>
+Jean-Philippe Brucker <jpb@kernel.org> <jean-philippe@linaro.org>
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> <jeanmichel.hautbois@ideasonboard.com>
 Jean Tourrilhes <jt@hpl.hp.com>
 Jeevan Shriram <quic_jshriram@quicinc.com> <jshriram@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index ea8194ac8970d..4c398e6cfd24a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -388,7 +388,7 @@ B:	https://bugzilla.kernel.org
 F:	drivers/acpi/*thermal*
 
 ACPI VIOT DRIVER
-M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
+M:	Jean-Philippe Brucker <jpb@kernel.org>
 L:	linux-acpi@vger.kernel.org
 L:	iommu@lists.linux.dev
 S:	Maintained
@@ -2244,7 +2244,7 @@ F:	drivers/iommu/arm/
 F:	drivers/iommu/io-pgtable-arm*
 
 ARM SMMU SVA SUPPORT
-R:	Jean-Philippe Brucker <jean-philippe@linaro.org>
+R:	Jean-Philippe Brucker <jpb@kernel.org>
 F:	drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
 
 ARM SUB-ARCHITECTURES
@@ -27242,7 +27242,7 @@ F:	drivers/virtio/virtio_input.c
 F:	include/uapi/linux/virtio_input.h
 
 VIRTIO IOMMU DRIVER
-M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
+M:	Jean-Philippe Brucker <jpb@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/virtio-iommu.c

base-commit: 23cb64fb76257309e396ea4cec8396d4a1dbae68
-- 
2.51.0

