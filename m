Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2F524CA
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VAfw9jib"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-427941528d8so40247751cf.2
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703615310; x=1704220110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVG9ArmoQ15xyAc+yxUrO+uyL/lDfCQ7yjtpIzOf96k=;
        b=VAfw9jibuDJ/CTmMojtdFfSghPTOK0pxurrZRNg0lmFJrDNC8WH89mLmAXk5u8vVGy
         qYUrswU7ANlo8gnxCyOEp6XnOkk5TWi7/RqAcQVqp0dHD/5uF2oSYyvmOWwtFkf5lnz7
         9ZUXlgbAmSZwtgJC0m7R1sXiSPNvFi5XKX9IXUEmg+pZd97EZhdllryA9FmaCFEMYJZR
         K9FOBl/DkoTlyOY/IXHp4dkZ8jfeyn0M8kL58VicxcWigNYj8tqAYVFDkZm9hPXL1L7a
         wAvVfW98PGg4NIHGE9Uh5wqOuntoGQBkWiLEq87b1zvZXvfZP1Dj4m+HXC0xz92l97uM
         K4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703615310; x=1704220110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVG9ArmoQ15xyAc+yxUrO+uyL/lDfCQ7yjtpIzOf96k=;
        b=D3iiF/kDLt6nwfONzNzp2Q7L1gNuDbzCBiKEkIEUS5wHW8lDILYtZkhn1p+C25C5ZO
         51TLxRBCIG3yzxSPYn6rNhwRUiBqjQe5cwnD/Hnp3nng9X2om6ZNF3/ocrAeeqvIV5Ta
         kW0uFcllIhleU6+Ktw3P7L/WFXi0MZ6hjGxSaSGGI5NWfYhekN7aqJ0Sn9/+NrFVwh9Z
         20bSI8bS5/mKD2tWs9UqzTGViBxFSGMFXUsUih1RfOciotk6EznfyZe8Kwpwy2G8QWQY
         1Eu9aqpS/7lHPXG98XJHUooHAox5HufP0eDd+s8pNu4vyMRZ6TVIo3wMnX54jGBkgxUZ
         NqzQ==
X-Gm-Message-State: AOJu0YyhBL+ibK6q4sVmJIi9jNTqn3PpIVkbs532hBm3GdeAMfc5FRYM
	nqkdGz9o+egohA0wehlqHKLnKnhIxL+pRw==
X-Google-Smtp-Source: AGHT+IH95QHCHc+3GftDlCRw6iuKFmHCYQ8XAfaQiziiu2P452x5R8wFRpdo00E2wU0m4vpqb5AUoA==
X-Received: by 2002:a05:622a:1817:b0:427:8376:a2f with SMTP id t23-20020a05622a181700b0042783760a2fmr9360806qtc.99.1703615310169;
        Tue, 26 Dec 2023 10:28:30 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id cf23-20020a05622a401700b004276963b28asm6274675qtb.15.2023.12.26.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 10:28:29 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rientjes@google.com
Subject: [PATCH v2] vhost-vdpa: account iommu allocations
Date: Tue, 26 Dec 2023 18:28:27 +0000
Message-ID: <20231226182827.294158-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changelog:

v1:
This patch is spinned of from the series:
https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com

v2:
- Synced with v6.7-rc7
- Added Acked-by Michael S. Tsirkin.

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
2.43.0.472.g3155946c3a-goog

