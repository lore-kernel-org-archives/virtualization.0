Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69718EFDB
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383722; cv=none; b=Kxb9omKE4pQK8cyFXRzlOZNVsxqjgdKbSeAMYP7TqeRGwYY0fnuMnnafZdVuL0PEdLNHpAI+7zwLSyvTZmdAqffHXUCqzxCayur29OgRYzoCALQxPOJodZ7lV1aQ4PUwDtT6dtgBiekOFRXhiGhDxzpgChY1nJSLDiDIHx67n64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383722; c=relaxed/simple;
	bh=UBXaEzD6NsiHqvODjvX31vkv3EiWvvL8bQ23FaxJHds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip64LEMERYAwRta++gZ1NuHpb4XsMrbSMP9k3H2k4BuEdl/HNVbVBCCbLdDE0Yg+8F2cZeGrCs/DoSm7KRJTwRex/KS3u3LKRmo5aukv/1xBXFRCYCcDZcFAlVyE6X31yGx7i0FYgcsx6cbZljtAmmOk2zVYxSxAvMOp6GTHJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGrKPkKG; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGrKPkKG"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3df121f7088so2758736b6e.2
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725383720; x=1725988520; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3qsiMSfNmjbkX2eCu5p1cSwOlsmlaRHY+Cyc4oyQRM=;
        b=FGrKPkKGyxXaWzxQc5VhDQbQ9KJd7C2fzgR51Ioh2YJhx1Uvwuz/HYHKyj11yWO5Yl
         VU0c0V+BYE6isA5/V+jHzFPwxvVrEgkDkesbCshH63egJiQuJjx7yRFV66meXA7Kf2oz
         fvNuFN/W5JkA8LYm+cnlEix+s28slzqiMEau0n4j3XWf9MSwZSbG5MDbF9b8Gvsu9l13
         nKP+BchviubQv11Rh9brlbvBWq7rR3arnPIQy97yuctidiGtcaL7Vn3NOkqUEUnJtzwd
         kkbXq/3MOEs96XYJ3vsP9TnU3DRDVVsziBkHknLCgEa66TeTdvBSlJZLjewe+BhW0PXE
         OAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383720; x=1725988520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3qsiMSfNmjbkX2eCu5p1cSwOlsmlaRHY+Cyc4oyQRM=;
        b=C/2lKVXBYlKgKDXgndcnAOyoKYGDH5pXJxaLLAgF2R6IC7Xe6+x+HsYq0fLxD5VnSj
         VIwcoib9OC7m9FkaM8zZZ3z8nguBYJvgxnuG9+p46E2A8xyqpBfFnCaasKFjvgiXxLsc
         7W1MRBjZ2gmGozbmS8PP1PDJ3yx3xxUw9UFi8Uou6UF8RO2987V89utJa8j+uF6W0zA0
         ktM3+lsdOaN2KTNQiggrTE5Ka3UfbnasTQ+1I1k2Kc6rNLx3MGo4nBANSocvwdC+B9EJ
         nLIcwAf7TZYLOSFK8R028j9VWYBQ5EXzWfbfQRL/3Qx22xp+DEM91Pb83WhXFn1cRwAT
         y+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUkf49a1k7Ks2fuDfPGiDUHELc2aOmxVS9s9fmWYfyGAjCuRW/H2OfjAI9teEuF3yEmnF7JCf9P6NdJdKekLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzN2liofhhOhgNzSm3tG8cDS96ZHcksgEzIoLtVmRlWmsDVjgo
	/E6qIKafwC2DwG2tG8okKC1Rs/Svpz5SODQUyl7V2ek16d0r7g7E
X-Google-Smtp-Source: AGHT+IGV3rZD7KoP/5wlhFh2OPfdnNraXwEmrcwJLNm4tP3Ng+C7cF2gR3/JZeN6QHjpyybEFYbohQ==
X-Received: by 2002:a05:6808:2f0f:b0:3df:3bf8:277d with SMTP id 5614622812f47-3df3bf828d7mr11854811b6e.44.1725383719560;
        Tue, 03 Sep 2024 10:15:19 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117a5f91sm2398059b6e.2.2024.09.03.10.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:15:19 -0700 (PDT)
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
Subject: [PATCH v2 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
Date: Tue,  3 Sep 2024 12:15:13 -0500
Message-ID: <20240903171514.201569-2-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
This is needed because mlx5_vdpa vDPA devicess currently do not support the
VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b56aae3f7be3..5fce6d62af4f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
 	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
 }
 
+static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
+{
+    return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
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

