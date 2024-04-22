Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C1487B0
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769305; cv=none; b=BUuQo1J8+ougrCQTxO5aUuQFItaIhgmDm2gTS0RywvlCIVgOz3e2UOUxDgQi4P3H0ZT/3Xczbs2FGEPTzGKUvgYUsmpjYx+03JAWBoc8SBMJipA4USoXFPf3Juc/SJ7r/IvQtwMCC9Tp/QH/KjXmm71ulgNPYMyHg4Bj2n9ZeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769305; c=relaxed/simple;
	bh=EocOFi6jpL3NawVx7Uyo1nJQzARyB+e3oj4NB4mpF80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrHEZrvvg8OV3ym9u8ae2jeKESVvCDcWkfZNkIbi1zw9VqUHC8XFdXVtECOYtpTHBroFIkFIcLzju/paHyM7KQUN/x5mrkVARTZG5PrILmKbTCAyMBZAvwZ7SEpK6xAgwJWMGjmT8j6uoltkDdZ3pC3Et+7L5WALrEsrbb5ljHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CXzAUe/t; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CXzAUe/t"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD4DE4069D
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 07:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r7eRdfQ0JEiK for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Apr 2024 07:01:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D3FFD40695
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3FFD40695
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CXzAUe/t
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D3FFD40695
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 07:01:37 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ecec796323so4153214b3a.3
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713769297; x=1714374097; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCSO3DBXAP020biPDVOFMShhruKddjro8yUAaqTBNH0=;
        b=CXzAUe/t131nu9Ulw+DlRjg/UgBJd5PmEfypFsd0v/jexuPUWELcgBr8DXWEjW9Xf5
         zjPyNsQEPPR9GOD72CzLnwVwhxpv0bKZzMW3x/wwxduvqstjTv2bgDPv+/CybtIDijLM
         251r4dPEwcfkDpeD9Yx8prY6eJJ4q1CHJe0pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713769297; x=1714374097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCSO3DBXAP020biPDVOFMShhruKddjro8yUAaqTBNH0=;
        b=nL63uW0Q4Jw27O8rgOCdejXPKrNHUGv0+LQfE06eaGFY6TlWQyZlO8w2SdpDaY6AsB
         q/F+e2cr53Z6Eu+RVDmBpQcGqeMSqauJmuxQC2TZ8sQmVvT74ZxDiHMArU8FWYqiKDf+
         23ESRhkzGVTXUZu7CwqFjwRxSsJwMDCaudAlvY6VCv5/nUrWDOby957e6GFwWcpM5xsv
         6ZI9N0khecg6Noc8eqDIgVueyE2xUDdTQoKx/KneIxxs57k5bHoJQiq8POiAW/gi503o
         klCJbqiH94gi3wuzIfcXsLjWzx9fcFbGtwKDeF+xSp3fnsspbi1S52o64oyJ8jQ0lhz7
         D8eg==
X-Forwarded-Encrypted: i=1; AJvYcCWwSlYqCVBBRMe37p5E36w+YfAlaLQqIsRk0CJLY+xbcRmU7ETOPw41bB6jU38ucv/oFAzR21IdG8SQTj5Po1pK/pTAVpOxpjQXl0NS5NdaoXGRN4oJZlb0rg==
X-Gm-Message-State: AOJu0YyD1ynEFiIpASQaoJbCDQ7jlMRGXkqheCw7pkDgzNCzolAOCd2i
	VWau7YCD2E/eFRaP//J2n6a86ZO/u73/WubQj/JROlZmeePxdWQBA6RZ+KfWaQ==
X-Google-Smtp-Source: AGHT+IE9ipOcgG52IC1TkXYf/uOIFgKc4zPGU8336WExD6rgd2fXIg7a0e2ELUT5f+/LCjxl0E6R+Q==
X-Received: by 2002:a05:6a00:2181:b0:6e8:f66f:6b33 with SMTP id h1-20020a056a00218100b006e8f66f6b33mr11716708pfi.4.1713769296972;
        Mon, 22 Apr 2024 00:01:36 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:abfb:1876:7a20:8e16])
        by smtp.gmail.com with UTF8SMTPSA id km18-20020a056a003c5200b006efbc365de9sm7145191pfb.121.2024.04.22.00.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:01:35 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eugenio Perez <eperezma@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-dev@lists.oasis-open.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 0/1] virtio: Add suspend support
Date: Mon, 22 Apr 2024 16:01:27 +0900
Message-ID: <20240422070128.1980027-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements support for the virtio device suspend feature
that is under discussion. Unfortunately, the virtio mailing list is
currently being migrated, so recent discussion of the proposal is not
archived anywhere. There current version of the proposal is a
combination of [1] and [2].

[1] https://lore.kernel.org/all/20230906081637.32185-3-lingshan.zhu@intel.com/
[2] https://lists.oasis-open.org/archives/virtio-comment/202402/msg00088.html

v1 -> v2:
 - Check for device removal while waiting for suspend bit.
 - Don't try to suspend uninitialized deivces.
 - Use msleep instead of mdelay.

David Stevens (1):
  virtio: Add support for the virtio suspend feature

 drivers/virtio/virtio.c            | 60 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 34 ++++++++---------
 drivers/virtio/virtio_pci_modern.c | 19 ++++++++++
 include/linux/virtio.h             |  8 ++++
 include/uapi/linux/virtio_config.h | 10 ++++-
 5 files changed, 112 insertions(+), 19 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.769.g3c40516874-goog

