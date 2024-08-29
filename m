Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F91B29AD
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948186; cv=none; b=gUhlpexe7x2oXHtdhnrlZvC4jsyv4LKc+fUTQPs8lWkVaUIOPkXwgqhwwtDc6Qb9ZzdHK0/GIuc8uQdbDhdbFpP0Ggj8ldPmfZNWuufjjH98Mep09eP+7MkmbkDP3+2Uhc+3j7Baiq2qMlmWaqLn/VCc6bkByfrElxUm3ENHDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948186; c=relaxed/simple;
	bh=Lexdeul/O21z3fM/QRb/FUqhuhZQBzxTTZt6LiYYdek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGqG9Uw2gptUqK2RQ5CY1JVbI9nBJz6GRfGX6ecyZntz9Wp5XcpNoxatFY77tnE2qZleQaEqiJK9lGNPq0kZ0Jj1QAKZDj5BSGc4r73AHhajjGwFv/SvqnkTL2UF/Kct6pATZgtw82pQOA6vbYKhynnv5HMr3t3dysDC1PvkinE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBGtl79J; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBGtl79J"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70f657cc420so122245a34.0
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724948184; x=1725552984; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGdViJ5BehvH8g12Et4D3WrvoKpcdTG3o5SIaYUp3Vc=;
        b=XBGtl79JUncUHP436swcG/aAZoP+V/GRF5KStmdCnoZnS6LPga5Vdc5BDRV6rYROq9
         KytaKN9T3+HqXqhkl8cZlJ5tBzTyGFvq8WYIvi8jIfU5IAuwEjw6436JAp4BsRH82tEU
         bU+VRwAh6HzWXf/cveC6bBLgoBrsqglPO9Lsnr+fJIO2oOpxj1J4i0NXVHth7h6+ckLc
         mbuvNFAeAvyjt08x0CjKC8j/GJKqvKfdmLGAqW1t93r9tP7KndIOViQJdWb6+s6C+94y
         M7o0LGm9qA2suu14pq31Oxeu+spEEEVlTLD75Gu+g3R+GdW8RJTZd9AWW3CSX65s9Vhk
         JZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948184; x=1725552984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGdViJ5BehvH8g12Et4D3WrvoKpcdTG3o5SIaYUp3Vc=;
        b=YyU8KOnR+v4e/628bXBxuATauay2ZfTQPOGhSHAynvFkfW5LMRVOOOE5/hNFgKM72N
         CwrBODKS1fSsdv9useOB41Fr7ppnmSaB8xynM3GVxENtAZXQv701bHbghU+YJPus6Wpr
         Jxh3zfslmbcQWk0GqL3HsfbhC2ms/UnRBqx358YiRVW0lDdhNbdbXCxzaMlLWGzBXFmi
         q225zaTMtaUM3zWc6Wn0twtMjzrjWSZ3xmb6Gmu4j+8RCRualpJALsmS1GCoPLtdr/mn
         Ug18afXEPw+3ZHOxMaQHFzqnPmcwkNcULcSxOMvhf0EXItqLXGkavYNArtCo9Pq8YrXT
         VtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1EXLHM3Dl9W+cmrklDS4/PBU35bf2nfwJxWwZ9JsDqIf7r5zbLhM8Brd1icwSCCrlmOer3hjJOHUFE5IUYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5JEY6A0RuIrLvK+hiBzIkf+i8bCiqpZFBBPWo9TNR8xm7p4rM
	7diSRsRPiIyP9tSvpR4LJ8kpum3QqsGcinEwWt9DUVFS4SNFKOdj
X-Google-Smtp-Source: AGHT+IHRef4RQmQH41SA0rzNU2CJO5fOMQsqOnIHEpMiUJo2Ry4PdkOvs3cvLm1yN9c4/3r5JgYipg==
X-Received: by 2002:a05:6808:1644:b0:3db:1cd1:cadd with SMTP id 5614622812f47-3df05d69f04mr3091164b6e.18.1724948183983;
        Thu, 29 Aug 2024 09:16:23 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df08943854sm372296b6e.45.2024.08.29.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:16:23 -0700 (PDT)
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
Subject: [PATCH 1/2] mlx5_vnet: Set speed and duplex of vDPA devices to UNKNOWN
Date: Thu, 29 Aug 2024 11:16:19 -0500
Message-ID: <20240829161620.38679-2-carlos.bilbao.osdev@gmail.com>
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

Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
This is needed because mlx5_vdpa vDPA devicess currently do not support the
VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index fa78e8288ebb..c47009a8b472 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -193,6 +193,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
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
@@ -3795,6 +3800,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
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

