Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577961C701F
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545277; cv=none; b=UQRcL5LTor0XSF3/j4BC1DNlrY/nwQZX2cZzgreK9q16Em3vu4NIvdwMcNgCqZ6EbB1SkyPnNwXSzZpAckmGECPf99EQmRX6RDf9V81QmasTNeALY6A5UuYwuXmOGi1aOv4kwJklb/rbpFm5k3OI/JqROaqh4aD738ter5wH9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545277; c=relaxed/simple;
	bh=2r27UqdYRY/th9NT3KvLaQBAFAv+vHzCvNeRmfAsipQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dy6gcxlwWY6/ZfIslGatQ0dthj5LOvpWINCMa39OWR+BQqWwLmORDFo2yRL8jQzqH/Ia6OPXgRAoLdP14okpmx2eH/PPvXCWhSe1bf9MR9AHj+wIH0iwiKbR9mDMKJyMsSDzZ0BRbFJxt85cPoukgahgDEFr/AGhJqQY7jgPxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xrq2uj3k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xrq2uj3k"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26d0fbe238bso30265875ad.3
        for <virtualization@lists.linux.dev>; Sun, 26 Oct 2025 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761545276; x=1762150076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FyP7h5NR2Q1a8ZGF1Za3mDWy2+W/UZG/poMuoDyAsA=;
        b=Xrq2uj3kyAKylzv9EtxAhwEAde5rpNCZJZ6ezc+DWxxnM/guVQvbHeDVwgDanClrE8
         WWoYSc+ZS139f4ATgntifj/bWW8W+dVqg1RItl28CsmrXVaFcM9sjkLBEjWP1n85P3NV
         e/LcXvHaWHKNRe9KKqD/QYG+zcjzFQwT2F2qU5K176JMWU7IschB89uEta8rpeWReMgh
         uyZqLjiUOMnX2UGbLc8+zS0XTw9pr7JtPfWkC4s5mry0GlgJz3N3jNpOQ2ZLr7EPDrd3
         hVNBNLqr3cYkVKB56QnO4WHiM+o6kqSX/JEJEvdalILei9KoiM6SJMldL0KGnuMFpTFK
         dtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761545276; x=1762150076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FyP7h5NR2Q1a8ZGF1Za3mDWy2+W/UZG/poMuoDyAsA=;
        b=f8zYl81+8HCW+DIC9dVeydc7VbTH9DNFqoFgH58kHlXyfNc0wYvlRdwNwY2AU3Njr/
         IvS2QJ7r24xQUC4ElBB38m3AU2ForJeIc2MDVajY6FSJYlk2BbdzufDn8nFyKM7xQsvD
         2H9wjfVSjifqisEwtwFlhVPHLwDuauh1KdNk1AOzENMkNzL9Fp77G2xU/lAj8lm6urcY
         61cX73OSZoO3QEW9dz5xr/QpwhAC0h2LlPkmOj5ve1rupJ3ALyOkTFIUBIW3RAO2noic
         tiO8jf891+KmfHBp+N/Pc9aHQ+pfaOMGZC3qk/33R9e+o+xG2DgRVUQxNpg6RvtldWd2
         woCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyKesLyKM9T3KQ/GAp83bYnSu4+lqGMzjKtUYoDx9K8lK2pU2yWjMZ9C2K4HBo0eCAzmb9qilMIexOmJhG3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4H391E2pbNbYPf0lZLtUzV3DXQ6g6WC3XFI/oJMW1tVpyK9AP
	EyWF+pm/6dNKJU333nBNJEMOn/U2L5jPhmN9NHjY6c1QvGknDIo5unOK
X-Gm-Gg: ASbGncua27WqQ0cgtNr57Lr2lDjrHWK6okMJwfZo5JCGuV+wyc2kUE5367ZU4/oPM5f
	4DiuJZoxtTAx05xX9W+MqSysm2otizO0TuQuNe2UA+OZwx6kv94xoagnMiJnrz8iDqVI0Vn1iqU
	0nYkuJjMDTjEViCQm0Yw3OsMjeRdyKzf4pJgDkuxPgBfE+s/FlSMPxviF3wP70mYu32vto+zygr
	1xH6B/W4d9fM/Dgxngb+5vxKSVnbMz/+hXwrNoTWyWLnzYHh91d0jDBs/AewBLquRUgrqlXjGxA
	xuTCaiin7d3rrg9aNuE9Tm5i2/pF18d7OwZsfgh8znf1Fx0rFFA8ImZGxsTZv14kCAOhR6cm16I
	k1IQ2jeVxN5rrDlqTzCBMSDjl923Jh2bqP1CIenq5aW0GlCv5ySZzWYK91lsqjfejAzfi18aR9I
	ltvi4D3M/OYXgT/utPJuUUeA==
X-Google-Smtp-Source: AGHT+IHkRBw9AN+xBRZdDNVj+3VWLhXLMgjUZyYBAk3neP09j59Fxp6vlIptXFrwVCD5MHrWoavEVA==
X-Received: by 2002:a17:902:dad1:b0:26c:87f9:9ea7 with SMTP id d9443c01a7336-2948ba78fd1mr155483155ad.59.1761545275616;
        Sun, 26 Oct 2025 23:07:55 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d40a73sm69674695ad.74.2025.10.26.23.07.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 23:07:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: schalla@marvell.com,
	vattunuru@marvell.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shijith Thotton <sthotton@marvell.com>,
	Satha Rao <skoteshwar@marvell.com>,
	Philipp Stanner <phasta@kernel.org>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] virtio: vdpa: Fix reference count leak in octep_sriov_enable()
Date: Mon, 27 Oct 2025 14:07:35 +0800
Message-Id: <20251027060737.33815-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_get_device() will increase the reference count for the returned
pci_dev, and also decrease the reference count for the input parameter
from if it is not NULL.

If we break the loop in  with 'vf_pdev' not NULL. We
need to call pci_dev_put() to decrease the reference count.

Found via static anlaysis and this is similar to commit c508eb042d97
("perf/x86/intel/uncore: Fix reference count leak in sad_cfg_iio_topology()")

Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 9e8d07078606..31a02e7fd7f2 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -736,6 +736,7 @@ static int octep_sriov_enable(struct pci_dev *pdev, int num_vfs)
 		octep_vdpa_assign_barspace(vf_pdev, pdev, index);
 		if (++index == num_vfs) {
 			done = true;
+			pci_dev_put(vf_pdev);
 			break;
 		}
 	}
-- 
2.39.5 (Apple Git-154)

