Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BF1AED5C
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491791; cv=none; b=oi3IHNqWoEUlPHwdWXqwAvV8MD07g5Pwyx/3d6Cgf2PsGtvMtj9HcmQM5GOtAPRlPx7XsI/I74ljMhG6y5fF1OouDOvw8krmdWtWvv94IEz8VpmK7rZHRJcOLi4RQMI89kumqu5bFme/CYElN4pGlsDZaLWHZyLa6vSbkvJRon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491791; c=relaxed/simple;
	bh=y5UC+0QaHNVuSZ7b7lcARL6lAthFtXPgUV/0j6xkD/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClXe2lvKB8QL/QUct5PU3gR0kfy6CmshKV4bbGE3gs1SzV7orYmJvD8tROdyEu2f8GeWso3x+zRUNn8M5iQIqvgkQQnOGtzLpWQNU7oCUobxHqvhAmE5TLKAJsTUR+fOUWEz6wv79xOeN/iyxbBfzBQJQD5dxfMDmVw5ZIzcTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl3SdoU7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl3SdoU7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7398d65476eso657217b3a.1
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491788; x=1746096588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+02iLfKsjMgHXk7NErynQYY2k7PwcNHBpBTjscdThQ=;
        b=Nl3SdoU7UAhFn7qZ+oTEpPJBbuYENqaA+B1h5pCNn+gGvw9O0C8y6MxZ1suFRHIUvR
         3rh9tTnOlEMZhGSUSVUCsZf/n+xzo3yp8jLpi04+EqI4wTmcjae6w0gs0h44BVTYYdnV
         rCsHZGm1Ali3MpvXMtTPtPYzOKCGjK+TDyHxN2GaGND+l54ERawyIzEyMmn+uekRv1Zu
         4ELQnc0abFSz++ROSo8pTujFK/AJybOKrhHvB0vFIL0VS1HuscorYLJ1TmdM2ugH2EsL
         pWPDjXYunPG9zy+6+sORyRw7fulGzv0hd1tn9M6uRmaYQNC3IzpV3sfuYYgbhMHY6A5Z
         eBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491788; x=1746096588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+02iLfKsjMgHXk7NErynQYY2k7PwcNHBpBTjscdThQ=;
        b=aftH/5ApKGOfjUJrBSxshaB65iiffj/7djLzWVhdLarJd+W2+lF4Fs9OXt3Cyon5bJ
         CFpOPAqbwXyPstmpHn4NFMpWb2dqhypY7XXeBaLGiTDFnr7uANNsAqrpuUv27OemwC+s
         TVOsD6ESOdTyhfItKODb3+9L0gNSxCRQ7PezcRuMIU+1R+6r6n4CPFVx7Ro3NP6nHpSo
         Uq9FgbOQBHQsh8RA4EL90aNUfBSMM0sBsmyyuDBEOpi1OQVbuuVKksOMIC12AIkZfmSb
         MFOS5vewMw253uNB9EHhEsYdlQiHTJFR8LJxGVnYASbbixflhm5J4fuaE1XOK++5P/Fq
         5wSA==
X-Gm-Message-State: AOJu0Yzeb/oGtP0PWtKxg8mVdIy+JoPM1+FsLF8pX7iET1uJ++IRxmPn
	Qww7mRZ+BlW+d0uiu+4eAZGRY7PFOZh2IrlU+oq1iv/wP6fvnlUtD/vcsXemKTs=
X-Gm-Gg: ASbGncusKdGqxqDG2Np3FKQ5zsKZc67jnTQwUOz17sBH2cLpcPWHeMIJy0ZSeqXr5Sn
	BsX0QSxxykYwOkQvtz7X6L/gWOAKFlfrjIZoXy93mC2nQPFkRra+fvjM0ISydaekJV8Qa4WG44f
	b/Um/e+Hm9fcfI+rwpOzmhrRY1RbBbDMrfRDU2/HsvbAy76bbWXTW9IZuYLbg2cdPPX2Rq9l/4o
	4bBf40MSGH2McLm20DhdTrcWUDtI9808b1O4Z/b8FPBNtK3p3PzVGCDgJj7tpaGVpNf2KkU1739
	1ww+nWSKG9uxJBOm2+vtSSl+cD69MLdTKPClHRbmMyasU4aoDFxSTuYS
X-Google-Smtp-Source: AGHT+IGZl/Ps7N6nQdKZ4AknXdjfnXgB0PEOrC9xf1nO1gV083gjQZJge/dA5JrgWqsmo/D7YV3B/Q==
X-Received: by 2002:a05:6a00:6c98:b0:737:cd8:2484 with SMTP id d2e1a72fcca58-73e267e25dfmr3221332b3a.6.1745491788482;
        Thu, 24 Apr 2025 03:49:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm1120138b3a.65.2025.04.24.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:49:48 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v5 0/3] virtio-net: disable delayed refill when pausing rx
Date: Thu, 24 Apr 2025 17:47:13 +0700
Message-ID: <20250424104716.40453-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This only includes the selftest for virtio-net deadlock bug. The fix
commit has been applied already.

Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Version 5 changes:
- Refactor the selftest

Version 4 changes:
- Add force zerocopy mode to xdp_helper
- Make virtio_net selftest use force zerocopy mode
- Move virtio_net selftest to drivers/net/hw

Version 3 changes:
- Patch 1: refactor to avoid code duplication

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (3):
  selftests: net: move xdp_helper to net/lib
  selftests: net: add flag to force zerocopy mode in xdp_helper
  selftests: net: add a virtio_net deadlock selftest

 tools/testing/selftests/drivers/net/Makefile  |  2 -
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/xsk_reconfig.py  | 68 +++++++++++++++++++
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../{drivers/net => net/lib}/xdp_helper.c     | 19 +++++-
 7 files changed, 90 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (90%)

-- 
2.43.0

