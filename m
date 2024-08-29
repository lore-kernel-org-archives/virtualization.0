Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4D1B4C30
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948187; cv=none; b=hD1BKQIw5xoLG3sEbhGD/KEB1Ed36bRkcxrAYbgf2kFhoNsMOsonnvNFgM5zKEnsTcpb4ZkBKrghTxzNmZeliSJUI2YE38n1QBd/NzR1GsOUiUFcwHFVcAvL3yA/9SGhfIAC6C0DswDXqG14Lfz0XkJl4VnUmFCrTdq5VQ48Wek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948187; c=relaxed/simple;
	bh=+VNi+DOByYkEzAZn8vjWq5CutgdeqR+GOWPR+F8tm0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9FQdEnOGcfb/xr+QeiUb7YkyeX+/9BVmGNnS8/O+D882v9kqGv+fUHy64PiZvHLu4oQLScMVM1LZtigNHz14vKWhbL3/Gb/jsGnfRa4s1mwXpU2X8Iwjp5+3PCRBl/7h6UBrjtd8k/y6guhUTinTicp7qdjHH1KqYOmeLMdJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d18mHrUu; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d18mHrUu"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3df0f0b8111so169895b6e.3
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724948185; x=1725552985; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGsLcbodfB9B81VcVn79WhE4AFTPyPKZVgpM8fFHsVU=;
        b=d18mHrUu+/hXtK1y4WnOhxUV4WgG6EKPTH6sPBR8BCqn+g8gogKLkdMFF+TkSxXt92
         ViPyhiWeL24HKE7a+agdkAp5y+swgqii0u6UoZ3cW8J8oiig4QuDbTULZq2kJT2gpyYH
         kT0c+5weW4EnEKx0/qLu1mZO5LPWAx84uO5IGFxg4q5EGLBMNdrsJnPql94SpSkwlWYN
         H7CZaJ85OFqY0as3Sm/Zekk89AlVhkIoF/qUj2I0wL5FutDU1P+AdXM1MI7ukAw0qLsk
         u4NMPWN+iOs/x0TzyCFFvf36crlW5dQyNZ83REJ/LPKG71YmND6/nTDW++H7sZotHgBR
         D/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948185; x=1725552985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGsLcbodfB9B81VcVn79WhE4AFTPyPKZVgpM8fFHsVU=;
        b=NIKsOX7hgb/XA5/P9Atzl1gP5hmbXmhJCKHYMwSLAt/w8xpQtr9iokyjQ/njrSkXK9
         huVbIVJ8iGbtSQZSztGMd7lhuqkNJ/rKU30x8/db9EA3i41st3oNoyFflkB7fxovkouk
         ugLyiaYWe2XRHcg5e56MwwebIQrQJrN4UNrzEp1W0XFmiIYvfeAA3tJXRuW5SCSTmh7P
         MqxT/3QfwtHzl3m1SOTodTfpSnIZhDQ0K0DMX5ifqXO/Q4Q/bNNUEvyZSXwflwtF3t8b
         hJaPTMVwjw1xSxCW1zCw4/Zh0wTj/yeFwyWuJWN6Tl23ffKbWjtklr0sZzmw+I5B0ZWp
         k/gg==
X-Forwarded-Encrypted: i=1; AJvYcCUVaDwwk4ECs9KfBXhwSgEON5+gByTEjqVdJ9Z5fsBrXcLVTE4+jvowr2UOYntY+aPm0gjUfRA0mG7PXf/3cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwL3XxQVRUGY+1aM7sLhgXN/t0N4CLCKtzW5YYKCZ2AU1K78yX9
	FsTpRpoCcekksKwmmlfMMOHh8fQaXRbNTXcEw9GV21PKI57JqWI7
X-Google-Smtp-Source: AGHT+IHCvrh7tJ0LpEIrwxDWCSECjNtnuE5J5PZiis5vVPB69t3J9AmpgQYKFZ19ROXZ3O+OU6s8RA==
X-Received: by 2002:a05:6808:309e:b0:3db:16a3:748a with SMTP id 5614622812f47-3df05ec405bmr3343881b6e.32.1724948185075;
        Thu, 29 Aug 2024 09:16:25 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df08943854sm372296b6e.45.2024.08.29.09.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:16:24 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	cratiu@nvidia.com,
	lingshan.zhu@intel.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [PATCH 2/2] vdpa: Add support to update speed/duplex in vDPA/mlx5_vnet
Date: Thu, 29 Aug 2024 11:16:20 -0500
Message-ID: <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Include support to update the vDPA configuration fields of speed and
duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initial
values to UNKNOWN. Also add a warning message for when
mlx5_vdpa_get_config() receives offset and length out of bounds.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 ++++++++++++++++++++++++++++++-
 drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
 include/uapi/linux/vdpa.h         |  2 ++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index c47009a8b472..a44bb2072eec 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 
 	if (offset + len <= sizeof(struct virtio_net_config))
 		memcpy(buf, (u8 *)&ndev->config + offset, len);
+	else
+		mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
 }
 
 static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
 				 unsigned int len)
 {
-	/* not supported */
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+
+	if (offset + len > sizeof(struct virtio_net_config)) {
+		mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
+		return;
+	}
+
+	/*
+	 * Note that this will update the speed/duplex configuration fields
+	 * but the hardware support to actually perform this change does
+	 * not exist yet.
+	 */
+	switch (offset) {
+	case offsetof(struct virtio_net_config, speed):
+		if (len == sizeof(((struct virtio_net_config *) 0)->speed))
+			memcpy(&ndev->config.speed, buf, len);
+		else
+			mlx5_vdpa_warn(mvdev, "Invalid length for speed.\n");
+		break;
+
+	case offsetof(struct virtio_net_config, duplex):
+		if (len == sizeof(((struct virtio_net_config *)0)->duplex))
+			memcpy(&ndev->config.duplex, buf, len);
+		else
+			mlx5_vdpa_warn(mvdev, "Invalid length for duplex.\n");
+		break;
+
+	default:
+		mlx5_vdpa_warn(mvdev, "Configuration field not supported.\n");
+	}
 }
 
 static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 4dbd2e55a288..b920e4405f6d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -15,6 +15,7 @@
 #include <net/genetlink.h>
 #include <linux/mod_devicetable.h>
 #include <linux/virtio_ids.h>
+#include <uapi/linux/ethtool.h>
 
 static LIST_HEAD(mdev_head);
 /* A global mutex that protects vdpa management device and device level operations. */
@@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
 	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
 }
 
+static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
+					struct virtio_net_config *config)
+{
+	__le32 speed = cpu_to_le32(SPEED_UNKNOWN);
+
+	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
+}
+
+static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
+					struct virtio_net_config *config)
+{
+	u8 duplex = DUPLEX_UNKNOWN;
+
+	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
+}
+
 static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
 {
 	struct virtio_net_config config = {};
@@ -940,6 +957,16 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
 
 	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
+	/*
+	 * mlx5_vdpa vDPA devicess currently do not support the
+	 * VIRTIO_NET_F_SPEED_DUPLEX feature, which reports speed and
+	 * duplex; hence these are set to UNKNOWN for now.
+	 */
+	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
+	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
 
 	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
 }
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 842bf1201ac4..1c64ee0dd7b1 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -43,6 +43,8 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
 	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
 	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
+	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u32 */
+	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u8 */
 
 	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
 	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
-- 
2.34.1

