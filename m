Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA583CDA
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868990; cv=none; b=p6Khrvo4IpuSLsenIpOIBtbnNZSMDpM0YE35W4r0WdvVllMZuiTM/QzCIOv4S2IS1TIpcx6rI/qEUGU9+8srzUkbS7e0G/6c2Qn9832rnyLO4LxFlgq+uaefegfI50dqymCh7EF3HDxBYQqMIuufHuAe492RcUf9REyse4WFu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868990; c=relaxed/simple;
	bh=Q2d/0twMVi+6hXDTnHDjJ5wn1S3dmbaButW3eHNIbL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0Okg3tO7H+gsuCS8wVcmb5CQibfrtKaftZPN0vNjcddOLr5W3EFNU0W1edkiniRGQLQQhfbLSoEK90Y5daI7KI4aT/6Km4NiNx1vafhyGHuPAfdl9I5Nxg4KSzoaRlCJ4XN0jta870XuiVNee9ZfKL+GYXUa00VF5Ohb1UxoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai0DYG1D; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai0DYG1D"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093b53f315so4155335a34.2
        for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868988; x=1725473788; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie3C6w+Q51NXLAK9okmiUNEZZtMDP+Q0GvIW3y+N5tU=;
        b=Ai0DYG1DPcnvDIg+jpA/FJvYRWg43nudaiDouNYLP13rBE/zHnlP8z5CSJmQpHR3RY
         2cTKLxN5PiHm9glrsO5ntrG6oFlqBxpO78d5GwXyfUX/1A1/C8N+FGm54nAAXfugeOGu
         YH+YtnUFUOia3mv5OjJxbI6v9gZmXYJkJg2xatZra1ZhnRZtKxZZG2UzoIPRcs/jsv1P
         oH5A7VG15x/XVFhY5UpPiI1G5BugOjQNY+Y1Jd5c4tsX4aRm8sMzmYQnoPAQcTqKs8l6
         Ec/w5+4O7yDAGh2d30XE+styjyoLgXDbuTTTxezy7iQZ4yI+2u/bcpckRt86Dq3/MUfz
         jx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868988; x=1725473788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie3C6w+Q51NXLAK9okmiUNEZZtMDP+Q0GvIW3y+N5tU=;
        b=P8OypR3vRbkM4tIclLj1FvnGyhcRYhDU+lx6dRqpcLT09wpFtEej30+K+NbS2Ztv9n
         qcv8DbD2vmMZX4Y8+XK6TZcTINJe8fbmJOq4pjRQR3BG5h7iduL/zafIVSXkAu/P7y8Q
         Zt31AV6v14EAYka3o7I7oRu0+O7q81KoviqU0oTVPfTAKAhI4Qict3iGFYkE4OHGhxAU
         X/aezbrr00CNk8sXATYM1CrJEYvQP2M6p3b+s93A9PxYmFNoO7j8pUw2Rp46ypYQlPn0
         Qml5WB23jOZn72LQJejYSTeKV9OtGHq3QNWxYj6j1YVR8pocdTZ+x5GqwTzhjjpCTZQL
         bBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRCgRI9Ij1aoNsh8GW5gsGJAawZfnKzWh0UtcItrOCwn4jqLxpR6kcBFUzhitOaPz/ojN35rA4HYrdHIHmIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXy7DSit9HKcncEyYMarRXJc0zfMNVB3eFf2NcfsXswSFhlw+b
	K4gCny5Me0DgvjmIq0c7cdv3B2U684tD05by70E/iZUbJnSq22i1
X-Google-Smtp-Source: AGHT+IEFJEhZXQy4V/sd4/Xh0ag9Z4Tn+CasH+w6KcdsTImAxV876emN4Ud8Cb4Sihp5uXIQPNv4Tg==
X-Received: by 2002:a05:6830:2702:b0:703:5c3d:e3f3 with SMTP id 46e09a7af769-70f5c3deac3mr426517a34.14.1724868988527;
        Wed, 28 Aug 2024 11:16:28 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03b882f5sm2996345a34.67.2024.08.28.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:16:27 -0700 (PDT)
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
Subject: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
Date: Wed, 28 Aug 2024 13:16:25 -0500
Message-ID: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

mlx5_vdpa vDPA devices currently don't support reporting or setting the
speed and duplex and hence should be UNKNOWN instead of zero.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
 drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
 include/uapi/linux/vdpa.h         |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index fa78e8288ebb..319f5c6121de 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	init_rwsem(&ndev->reslock);
 	config = &ndev->config;
 
+	/*
+	 * mlx5_vdpa vDPA devices currently don't support reporting or
+	 * setting the speed or duplex.
+	 */
+	config->speed  = SPEED_UNKNOWN;
+	config->duplex = DUPLEX_UNKNOWN;
+
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
 		err = config_func_mtu(mdev, add_config->net.mtu);
 		if (err)
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 4dbd2e55a288..abde23e0041d 100644
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
@@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
 	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
+	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
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

