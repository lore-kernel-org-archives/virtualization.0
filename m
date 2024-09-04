Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473D433BC
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463103; cv=none; b=JFe+3+Uo+yHTsM7rDvXGW3DsQJvioE9ljXBqTsDOssGnF0Mt3yWi8SRXOhWSGCxkitSmY10R4XfVa4lHFffpcj4alELCMY1/V3CXpqmsdbWstNvisveKiwJvOZhYNu/Pg6MQq8IWSz28xlnxvle/aYq3KAEPllj4563Iq2ddwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463103; c=relaxed/simple;
	bh=hfy/rgIIPDC5YMhAasDnsWW4tqAqTW97g74OJxZy/NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdakA6xkBBUMUdLIGLWwrYYw6FUABrLGYzE4y6z6UclNzET2RZMDlJRHRHkgzD29kvlZhmkdLNUzOxq2NN3YJuUhR+rhuBkpeZKJA067miUvsVkM/EqJimzyNzOhwzq2WIHK+jbjp8v8qs4zxzHzZwukU4ewN3njjIdKV5Wlv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PndeA1Kt; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PndeA1Kt"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3df0d9c0fbfso3576215b6e.2
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463100; x=1726067900; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1PEqwqIKP4NM5bMSR2b34sKqyNHaAPvN22LwlO+2ok=;
        b=PndeA1KtbSeB+pMIIhnu5sXhO+6KOLHcV+VnIMPxrSVrbkmd4g/L3F3LpY0zFolnMc
         es7smYQknKHN5lX9ErnGq6YLl/xkwCeSMLOqs4M9DZU3o0BTiPvsTeL2zsqSgGwDmIJg
         PFHvt3b1h/uFjrHzFgApKi2rC2iShT1ItR1RxlryNrfb2sRfl5ePHRNW3nUQsgMzlxS/
         5Gq+2bifk9u82QvlsaegikKDE5SvJ5SfqO7Cl6koQPtrD3clUjeJuR3SLEJwggCx+vm4
         GBnMF/CQe78OKcybhy3LYU4o/JaHV+ucDIQJGd6/pU71WDv0nEKL7iOvPaTKjEmFlnD+
         rPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463100; x=1726067900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1PEqwqIKP4NM5bMSR2b34sKqyNHaAPvN22LwlO+2ok=;
        b=Vpj+OQVQMINj4MMcaH53dmJxrazaqA3ZYPscin3Nink+i8cJNY8wvR29Mqu4YevZmm
         P6uTOl3gsWldRO6EyVb+EJpEizD1yyYA17gcqm4Ayj6QikHX+LUMQ/lf2DkDEOXGVSl8
         kDeGmdCsDKEktChksQ89UUwX1n5kKPcEMQumtOjgtdMIG4BkPkzy/4+6B5PQBMTWxgfA
         v2gpN8SxqQWbST0BB4/WKKQwKOP3UuvgPzm5c2v6DV3FZvLJsrvgYcUPHFXTuOErMCmQ
         7ymTooy/SxzPTP8U5K9/2Ci4Ag1XykFBsIhZFLz1GcP/9HdwRZFoM8NKA8nRcOffHdg1
         1siw==
X-Forwarded-Encrypted: i=1; AJvYcCWEh1ctbYymbKoFT2+FRKCsj7QdDhuew+saaTWX923hDmN9QrTZbDBj1OgtE3RBWNichdhtpdKRk0cpvlRRWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyazxFyuT97ODqu3uUyCvjRoSU540F2JSECW3Pg2OWg6Ej4r8WH
	4ulhlab26cc5Trlln3oRft+9U1okAUnQD3KoP4GQI1Ctd1THkXi8
X-Google-Smtp-Source: AGHT+IEJpXAOYwS2mKFK6HgoKBqnJHyNpR9had8i5M1YX72q29HtYb9hQQZPQRA7BfYu1Z/3OrUajg==
X-Received: by 2002:a05:6808:4492:b0:3d9:30a2:f8f1 with SMTP id 5614622812f47-3df1d5b90d2mr14894855b6e.8.1725463100702;
        Wed, 04 Sep 2024 08:18:20 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117db1f2sm2831040b6e.32.2024.09.04.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:18:20 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	shannon.nelson@amd.com,
	sashal@kernel.org,
	alvaro.karsz@solid-run.com,
	christophe.jaillet@wanadoo.fr,
	steven.sistare@oracle.com
Cc: bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com,
	johnah.palmer@oracle.com,
	eperezma@redhat.com,
	cratiu@nvidia.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
Date: Wed,  4 Sep 2024 10:11:14 -0500
Message-ID: <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
This is needed because mlx5_vdpa vDPA devices currently do not support the
VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b56aae3f7be3..41ca268d43ff 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
 	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
 }
 
+static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
+{
+	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
+}
+
 static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
 {
 	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
@@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	init_rwsem(&ndev->reslock);
 	config = &ndev->config;
 
+	/*
+	 * mlx5_vdpa vDPA devices currently don't support reporting or
+	 * setting the speed or duplex.
+	 */
+	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
+	config->duplex = DUPLEX_UNKNOWN;
+
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
 		err = config_func_mtu(mdev, add_config->net.mtu);
 		if (err)
-- 
2.34.1

