Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D538FB2
	for <virtualization@lists.linux.dev>; Thu, 30 Nov 2023 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CwhFwfY4"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-423e8145018so7840071cf.1
        for <virtualization@lists.linux.dev>; Thu, 30 Nov 2023 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701374690; x=1701979490; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ0QwjQQA2sBtrYbspl5aVVUOMzblP9BjaUBDTeLH4Y=;
        b=CwhFwfY4Ce+ohwaNsHxliXoiXimcX3u/G7lakwjBTWpZz4KTGzwTTGdvVmVrowQ1E+
         Q6E72A18HOkJb5f4my0zTRUd2ZsGTL3Ef13eSpjI401tgKnTgZa8KygDbU6o0MMXqWCj
         Y3/thYF2kbgBqXLYbeZHMKL/yqNrFO8f4QqRXFSDZdrg5jaCcQHATMvBdTFj+F0fLfbY
         DjqiEMfbpdkV6c6jAfGXHKSiWOACV2D2EzP0hOgSLkr5SCsYCMTwoubm92rmt4RYRpvb
         n/c3PIhya0hKuNGdxaKums0PahbbR8ihUqA1tCBd8trQgapnxcRnWr+32b/GBu781/Su
         Tb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374690; x=1701979490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ0QwjQQA2sBtrYbspl5aVVUOMzblP9BjaUBDTeLH4Y=;
        b=noZlh+BW5IkHZ02wemGye/D+ndvSjWzFGPQT1ZMzgFFFT6dSe+WIT3BTg4CaLRpuqe
         6W5k4jGEHnX+GqJ9Avt/Fh+DTWCDFDder53csdIPWySVfQwoBlFkiwJ2G416hrXP9CKG
         2Tn8eG6ZycQWLcWXbD1VEuLjD56mjVlDK9EdgTtyNRtsAOy3gxidj8V8c9qqplyd+XFx
         fFX72vM6H99ZR0uPfybHncW2iSq23YL3jvpBFitQB/klkgbAZa4sIMZQxCx6aPxpIB9P
         bTkMNGJ2aPMH3NBw8ZNrvN6nrdCB1y1v1q/xCytkrnGBKlEju0ulpV65zab53Yem33qY
         zsXg==
X-Gm-Message-State: AOJu0Yw04Q8mKMc62mvtXRk0/6Stlk1ekUoOkOzymAm3kBHFjdRr5doE
	Yf1aZJy2aZjo8VOPICy0cyx8Zg==
X-Google-Smtp-Source: AGHT+IFTod/Py9hcH5oQn6ff5l7Gu58O8B3tXKspAhOROVnCb0qH7k4XfRrSgp2nr3dD/2mySscuWA==
X-Received: by 2002:ac8:7c46:0:b0:423:8e6a:f7a with SMTP id o6-20020ac87c46000000b004238e6a0f7amr26732427qtv.64.1701374690104;
        Thu, 30 Nov 2023 12:04:50 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id f27-20020ac86edb000000b0041ea59e639bsm787447qtv.70.2023.11.30.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:04:49 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-vdpa: account iommu allocations
Date: Thu, 30 Nov 2023 20:04:47 +0000
Message-ID: <20231130200447.2319543-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

This patch is spinned of from the series:
https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index da7ec77cdaff..a51c69c078d9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -968,7 +968,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			r = ops->set_map(vdpa, asid, iotlb);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
-			      perm_to_iommu_flags(perm), GFP_KERNEL);
+			      perm_to_iommu_flags(perm),
+			      GFP_KERNEL_ACCOUNT);
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
-- 
2.43.0.rc2.451.g8631bc7472-goog

