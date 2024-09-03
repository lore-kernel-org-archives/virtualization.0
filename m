Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319B18E03D
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383720; cv=none; b=enf6rf44jdhu5fQshjxnC2+6Df9ED7CqyKcMWTmVqLixoqrRsgtc0Gu02Je750WiF5lC+CPznioLtQuQQE7XIeChp0mjLQy1PGZnrpJleSj0bSjExjrkTzRJqfBVZ+MonheihFSspkj81JxCh2FtGZxjqqZn0h4JuzGUfDjEi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383720; c=relaxed/simple;
	bh=kLNPtRx11hsfJ+9TPaWWJn6lMwA7D38MMP9cWpDIIlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTwPLSf3JAmVOCfD2mPfFGpYm2VbhLQ89t9QpOodZiUq41xbcqfKpsuM1r4aGg6Up9spRHNz9u6trpv3CIYSwqHpnlI8vdPqr4a6EkqOwg56kOPxMOHKBSEp7ZT3pACJt4y3GNhoNzXurHRnrW0NZme9hCoxBxCxHGWU9MEa9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvT4c8q/; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvT4c8q/"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5df96759e37so3686546eaf.2
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725383717; x=1725988517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLZ2qy4nIG4Jhx7z3LE1rlOsOATUkEObwLNmcXIs87M=;
        b=XvT4c8q/J6no8ScXrpy6rOS8spy1y0x5P0GudriYqyS9njcZsbJSa9SXgLGNBp8D8l
         OS4t6+TC/tXVDaJYq1EfNGPWbMkCt7YXLyOwHaJRcTwz4O+OxODMoKF5NBkaJ9bV2urT
         vWyuOVx1yHVDm7iackWbbYDYe2aZvkijv3/aX6nJXN34Cg3PKq4p0bWHIBORBePSqORB
         TfA/wYqkQGaVFIUe6hv7uM+bYIpenH0nZJXYLW5abR2PmSb4kL4+uk7w+AJLvMOM0ac4
         xvU90FqkegeQJdW05fQsmTH9m2OykZ4hx8o2Vh/YAlQNUc4fUpNmgpItnJeEXJgPh5Aa
         vLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383717; x=1725988517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLZ2qy4nIG4Jhx7z3LE1rlOsOATUkEObwLNmcXIs87M=;
        b=dAmWCBUZBQykB9szXven1K7PvpgmuvnPs0HulzUmYbFavBafcOFsv7fic//gjEgva7
         GX4qtKOn/HzatjvziQn6nNH4bGreVPrBlAGD32jFjM/Lm7HNA9aLvqNsSb0MLWCKFeu1
         L4FWdIGRHQdOSvNAkmRgMKI56ngj7Haaul9Q3slpXd7AmBB5JqGOqaRWn/tTUDIvboz1
         xDr3Oo1xH59jvczBGQCE/mScwT+Mlhe63zVuHGgGSMXTbbUiLjQrgTfM24MGnwduTmZG
         OYNIpiRtt0zf7X6RCv3a6jplhbvCNutkBE/5aa0mZPV25572jUD63Gz24NUgqifk2X2v
         H6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWtC02JE8NVwAU9lxv5ZAVVs0YpLSbhfe/LMmVw3G1LCQP5n2S0HeLji7HDWrDbScEwPUq1+CuPq/cOaU5/ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgCT6A79iZZr9/07J+qWN0oJTltrH9vBt+c5ZFRZQbRncBBLkZ
	JX+8PnSC0oFPIBsovQaI0caJ+zpb+A3mCNHrWSDb3j0m58zT2a0Q
X-Google-Smtp-Source: AGHT+IE6BIq7Z9DSjqx25ixqdMPN/+sENLE9DRYHmtWnc/QOGbu69+yK7YfN4avZLU6r2N3y7G2Cmg==
X-Received: by 2002:a05:6808:3999:b0:3d9:9e78:420c with SMTP id 5614622812f47-3df1c260619mr16918658b6e.38.1725383717562;
        Tue, 03 Sep 2024 10:15:17 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117a5f91sm2398059b6e.2.2024.09.03.10.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:15:17 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Properly initialize speed/duplex and remove vDPA config updates
Date: Tue,  3 Sep 2024 12:15:12 -0500
Message-ID: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
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

---
 drivers/vdpa/alibaba/eni_vdpa.c    | 17 -----------------
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
 include/linux/vdpa.h               |  9 ---------
 include/uapi/linux/vhost.h         |  8 ++++----
 14 files changed, 16 insertions(+), 170 deletions(-)
