Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C871D88DF
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463101; cv=none; b=DmbfqrL97cav5pYgnODgxbxrfxqzdGsTv/pv466pB2ZkdUgos0wly5CqC9jcsSW0V+e3kTeKCT8DN7BIo4TI6O4h+/WKf3Hs4tje/WhFKI9kYRoFaCvH/rAWXRWhnXa9HNlLjG3+j7Jx21MJtL+idkO1LNTW3zBVpPIDNweE3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463101; c=relaxed/simple;
	bh=dUb9az/c6+CPl0K5M+I7pQpZWwwdg0pC+LKQqrwHU9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKXJyB6XAS5yhpHLvHT4M3iBDb0R+ek/eZ0xKuqfyuODQXxLGvMDnN+Gk9wRUg8dg8BzRbbmeoTxAe6wjaTXJNnOP24gKZwRcd4iqOyx4LS6cxKDZOsfqc09kdHNSDFjV30GSu6xX4L2gq3VMGwjy/0znmBNXO1T0SXRnYKpw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFSGX+QN; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFSGX+QN"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093997dffdso2332043a34.2
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463099; x=1726067899; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KySHgeOXTK92gdEN8sIJW9iIIS87z7XEvOVn+fuIfuw=;
        b=lFSGX+QNNSbCVPvNZarJM1g6T2ED7cEAjqxOYQHpMa0wCNYTXPR3+bNLSpP6HwmnPV
         kooWuCwVI4hzkWAUNx5zn/lkjkhvMgkW8aSzeNFZGSDOrAJbPqQLgR7bhLIGtcna7Ye/
         68npUZIiJ1P+nXDURau5eA46D1PkD4Q8kRUsWpCDh0b54Ba9XNLLX+k2+SwK3kCwjC8H
         oa0Wbxjy+hTm08uEMlNvA7CiHD2qA5YI7+YakcluWt0NSOrK/gyetaVLcAlk3WQsdmQO
         ExhwCg9HPmRsYNzArL+CADy8KuR9AaHs/zrFGl0JjtjTl+s0fEsPg4Ih4QOJV+5ZzS5d
         nh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463099; x=1726067899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KySHgeOXTK92gdEN8sIJW9iIIS87z7XEvOVn+fuIfuw=;
        b=Q6xKq71cd80HDZbAd+rakL2iDLDJLDZhd0e+nwlh7XVfzwizdeEq+BvEOTlATnKch6
         ZvWSRU+rjVIdCNAMd5zZxKxT+DGhT98vzWzIpC23mj08ChyjAlSFFezCriPFd20V9GfU
         io32RFLN01Bgp1+7Cdio0ixJwJlMMR2cFZqZE8oeq4LxAhvobnpeeAxHjFdo0mxG6NGa
         SbBlxyc2Adp+O0X8dnkK5KP7e4rMdOuP11NtLDWJ/Oh91SDGC6iemRcGlTk//RF4yHZv
         mgPLp2zy62swcg9otTpn2qpAobn7wQCGFRvnx86Vul8xi4Iji94iNQCaWHoxpXZQvzSF
         z7ng==
X-Forwarded-Encrypted: i=1; AJvYcCX2Tv3atTTbJ0SYUpFuDu+KEw/tJ0JXRTOrHrmyREq3S6d0M2ibcWy24izYyHxKzwAg2+J90qIws9w4AC6gvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAhqA7ggd0P0PsfKNfp8nWMpEy66pk2twzImTW5HkYBZ9M1OHD
	roOib/8wb4354U5jNbb94z0WEX7PABy/3bkZbc3iQyy4gR9cVi15
X-Google-Smtp-Source: AGHT+IEruZWEvt+Qyt+sCbAsEFb6gFwBCtXsHstZp4YcWIu3csV/K7WrCtutgzoM68O4FNDcf+wAvA==
X-Received: by 2002:a05:6808:180a:b0:3df:144f:9ef9 with SMTP id 5614622812f47-3e00cbcfbbamr7079390b6e.41.1725463099185;
        Wed, 04 Sep 2024 08:18:19 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117db1f2sm2831040b6e.32.2024.09.04.08.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:18:18 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA config updates
Date: Wed,  4 Sep 2024 10:11:13 -0500
Message-ID: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remove
ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supported;
see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html

Carlos:
  vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
  vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance

---

Changes since v1:
 Link: https://lkml.org/lkml/2024/8/29/1368
 - Fix prefix of the first commit and add Reviewed-By tag.
 - Redo second commit completely: instead of attempting to add support to
   set configuration fields, remove ioctl and support entirely from vDPA
   implementations -- because it's not allowed by spec.

Changes since v2:
 Link: https://lkml.org/lkml/2024/9/3/1407
 - Fix first commit by changing 4 spaces for a tab.
 - In second commit, ENI is legacy and should keep set_config(). Change it
   to set_config_legacy() to avoid future confusion and erroneous
   implementations.

---
 drivers/vdpa/alibaba/eni_vdpa.c    |  2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c    | 10 ----------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 19 ++++++++++++-------
 drivers/vdpa/pds/vdpa_dev.c        | 16 ----------------
 drivers/vdpa/solidrun/snet_main.c  | 18 ------------------
 drivers/vdpa/vdpa.c                | 16 ----------------
 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 16 ----------------
 drivers/vdpa/vdpa_sim/vdpa_sim.h   |  1 -
 drivers/vdpa/vdpa_user/vduse_dev.c |  7 -------
 drivers/vdpa/virtio_pci/vp_vdpa.c  | 14 --------------
 drivers/vhost/vdpa.c               | 26 --------------------------
 drivers/virtio/virtio_vdpa.c       |  9 ---------
 include/linux/vdpa.h               |  7 ++++---
 include/uapi/linux/vhost.h         |  8 ++++----
 14 files changed, 21 insertions(+), 148 deletions(-)

