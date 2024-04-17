Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A413AD15
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344092; cv=none; b=XyMG+EC96GVnW8ce+IELNtTByLhpZPr9869oenyFxDrY3WkAM8DdhvcsnMEHO7K5A3sd4rZ1IwEpY+hMn7QL0d/LZ0bEBFdawSkyzmS5laNTtD7oKSk58na2Ds+gyZkr2JbXcF3rp6cCw2js2EPy927/NLF0fiQv+DRkJg34kOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344092; c=relaxed/simple;
	bh=N7A3jGE8bdkzDk1G6rtaXPVEo6AX7ewmylEEts1blXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgcnrHAnOYBsIfH/g8o/Wg4MpUjedDjQt+vwz7pGnTYtNoCVI7hSpSfVXSVS1DGIkYgH9OvfwIjwpWORKgPuQW9rMDdSHcnKLs+udCdBLjOcAm4+fo8QR0mjYXWZ5lAB9D72DVN2MWmOHLpJEsY+9quMaSXU0k6PrRQRjFk7Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nzq7uHSm; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nzq7uHSm"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB0D9405B1
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2lgmdiHxYEO for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Apr 2024 08:54:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D0B1F40595
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0B1F40595
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Nzq7uHSm
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D0B1F40595
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:54:49 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3c730f599abso138142b6e.0
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713344088; x=1713948888; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFkwjonhIvXxYdQf8hNNoSZ38i5oFeLHVaeXNjGQb1s=;
        b=Nzq7uHSmK66UfFu2NQ6zNqDZN9o5rERwAcwaJhfkARlf6VpL3vN7H5LXAEpwBjUR//
         8Ld0687oVNV+aBd55t0Jh99TUjwXCWyonl5G1+IsSdW1U9yNdM+nb7KMBOeC+bf4I/5F
         m1dEWl7L667V3ZGEiD5kBQ1M2wZYL4Oh8m8VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344088; x=1713948888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFkwjonhIvXxYdQf8hNNoSZ38i5oFeLHVaeXNjGQb1s=;
        b=uzPfvbucjoC5A1qO9+y5VyMIIpXjxXK510f5nq8KqEPeo0eTuvyXxiXLeMci6krZJc
         NHwHPxaOjJODeRn2xAlcWxOXgw06H2KQVZdtxi8Akr8BeaxBYip7wo0q6u/rjoyciEJh
         19OvtDu8mYiPRQ/la+2K5FSl/FFIh85i8vsuU6MxRWzp/6EXA2SO/ZYrSYVPh0KGNx4p
         KyXTl4of6enI/lPlcJX7P43vTx2AmlFT0sTN1PSF5732CRx1QLoP811QPCTrcV0vxbMI
         HTfbP1QKI3WXtpeAe+GGi8133juPX6TlIWR+NVFWs6k7MzJisQFZfq8sLDbMI0x7Zrxm
         bc5A==
X-Forwarded-Encrypted: i=1; AJvYcCVbBajMVWTghMqVhmG/H+zFtykV71zzEYoDIx2Et/MTITWIWVayB5kVrd+/xYuIAYs5FoZxp9deJQYBboGKRvhVm0GvDUyiZf6uqi9WNu4zZ+HhAAL21ATWYQ==
X-Gm-Message-State: AOJu0YxvX4MVu5uxoNOWUejZzL8jBpnvRwj4JhevYOGgqz6ibZ/92/0W
	zEqlwxrWzPzR9H81TuKid/ji84qwYRVC/F0wvZeYk8xjt/d6+Mpy61eXGdh3BA==
X-Google-Smtp-Source: AGHT+IH/skKeDI2AaMFIPP2N6QCzxY8s6CJN0kGimah7GiAF0hypemY2faExIQIZPSQ6HyUknuYxUw==
X-Received: by 2002:a05:6808:10d3:b0:3c6:62f:4fd4 with SMTP id s19-20020a05680810d300b003c6062f4fd4mr20829154ois.4.1713344087913;
        Wed, 17 Apr 2024 01:54:47 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:c7f8:50e7:e1ff:743b])
        by smtp.gmail.com with UTF8SMTPSA id u21-20020aa78395000000b006edda81101esm2462698pfm.80.2024.04.17.01.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 01:54:47 -0700 (PDT)
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
Subject: [PATCH 0/1] virtio: Add suspend support
Date: Wed, 17 Apr 2024 17:54:38 +0900
Message-ID: <20240417085440.4036535-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
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

David Stevens (1):
  virtio: Add support for the virtio suspend feature

 drivers/virtio/virtio.c            | 32 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 29 +++++++++++----------------
 drivers/virtio/virtio_pci_modern.c | 19 ++++++++++++++++++
 include/linux/virtio.h             |  2 ++
 include/uapi/linux/virtio_config.h | 10 +++++++++-
 5 files changed, 74 insertions(+), 18 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.683.g7961c838ac-goog

