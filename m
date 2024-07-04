Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300F1A08A6
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075439; cv=none; b=PO85u4BkUpyC8bySUY5H1zaP28zOIeaEXS8MfSb9LkFDnJys3y6bURFz19jRtIV0kNUUGKhAFKpah+69qFQAI2/EIMJNP/dCIxa0ecggR1jSJEk+I23z8XgiqJPNr72EjMkhCcjATrbAvTXYSR2/UaLP91RyvgbaQqpNnTRfrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075439; c=relaxed/simple;
	bh=7XOPLSoeUCMBrLUDBatTfCcj6RIpLM8/52ujc7LXvHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCCUiNGsLZj0UWPdUMXNjeaFzLCslRR6lAwXXenz1FSbrZxjQBbsEaMqXYl68wL3YuTPIEa7wQADfas+KXaM+xyMN/dzNTpfNDO3Rb9gOWuCqSU1lq2BI1zT8bmEPxfK0tBirjeWXgb62rkhIzh1Fm/iaHimob+mf6DudVtw45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZsctNEmc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZsctNEmc"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso251388e87.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075435; x=1720680235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjvVaTKB+IhNdleV7FiBAC7Q7evTCKPLyyvmEihGxoQ=;
        b=ZsctNEmcGUKVFSws3KsoR9oHstMEOu7wIETvG6AES5IsUv7au3u4k84qS9xvZxUklU
         8MoRU6UPa7keIqevi61HNzoyZHuEZNwsCuHigGXwwYUwHGqZpIhUNWPgVL9WksatVw6K
         kTiORRxTVyC5PZL5uD8sF+Eq3eoMBa0FWT+lqcI64JNsF19N1hCv/x6Df+Xc62kYfuuH
         x9PBaHiZBIaf4X5QNAyST87iTW3hq8jCb/KP8LUUQkPBQUuM4nDitKHasRRRGYeDXApD
         4Sr1vykExe3xGfhBt+5eXBnKiXlEohDMjWOI2CrGm/owxlQzgx+Hk1PE/nTyvxg9KBOZ
         rmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075435; x=1720680235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjvVaTKB+IhNdleV7FiBAC7Q7evTCKPLyyvmEihGxoQ=;
        b=j2jaJKY1TeosnULcvDIpCPIhfQG9LdynH6D8rPNzcHj+Y6HgWFnv6UW0wfM4dNqnCl
         54sR4bRfNzHMiQdXiOJUzc466MPTIXSP+AMe3KE1yrqbtqBQslIp/8omrBzYQ+cNeHW9
         YUXq/ZhLmRugPsYHhKxxBGuM7A0s0T70yj/jzaCJsPdLoE/rrC46mfkjE8LVTd7xeWkZ
         90FGg+y3y2fN7tyOKQ62DN1FY44l6hCR3Qnat4ap5wnhnwS0CmnEP4PcWhuVjjmhb5bF
         CgDXyRFGE2RF1IDtRH+9TkbsUCNSn5tnVhLhdCd+Maj8IiZAjauMziYpebZjo/RfjkeH
         qwcg==
X-Gm-Message-State: AOJu0YyEhNXeKGooMzXUHqbZHCHAv0c3NCxyRqML8RhAroMfuDhSdTSv
	10DBPrPO0CBEBETyyDl/WL8Od5EDXE8FOqDEJTRSaA1Rfga1sdTmTwjvMlAZHmomVTITdnC9M6C
	V
X-Google-Smtp-Source: AGHT+IFQnoY22bOdxlp56axrQV0v3kZwkcz0IT+bfNKFhX3qOU7KOlTtgM6KU5J6baWrIVpV2xq5tA==
X-Received: by 2002:ac2:598e:0:b0:52e:9c63:5fe8 with SMTP id 2adb3069b0e04-52ea06b77camr407809e87.54.1720075435044;
        Wed, 03 Jul 2024 23:43:55 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d6435sm11000005e9.15.2024.07.03.23.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:43:54 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 01/19] caif_virtio: use virtio_find_single_vq() for single virtqueue finding
Date: Thu,  4 Jul 2024 08:43:32 +0200
Message-ID: <20240704064350.1097716-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704064350.1097716-1-jiri@resnulli.us>
References: <20240704064350.1097716-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since caif uses only one queue, convert to virtio_find_single_vq()
helper which is made for this purpose.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/caif/caif_virtio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 99d984851fef..7fea00c7ca8a 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -646,9 +646,7 @@ static inline void debugfs_init(struct cfv_info *cfv)
 /* Setup CAIF for the a virtio device */
 static int cfv_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *vq_cbs = cfv_release_cb;
 	vrh_callback_t *vrh_cbs = cfv_recv;
-	const char *names =  "output";
 	const char *cfv_netdev_name = "cfvrt";
 	struct net_device *netdev;
 	struct cfv_info *cfv;
@@ -675,9 +673,11 @@ static int cfv_probe(struct virtio_device *vdev)
 		goto err;
 
 	/* Get the TX virtio ring. This is a "guest side vring". */
-	err = virtio_find_vqs(vdev, 1, &cfv->vq_tx, &vq_cbs, &names, NULL);
-	if (err)
+	cfv->vq_tx = virtio_find_single_vq(vdev, cfv_release_cb, "output");
+	if (IS_ERR(cfv->vq_tx)) {
+		err = PTR_ERR(cfv->vq_tx);
 		goto err;
+	}
 
 	/* Get the CAIF configuration from virtio config space, if available */
 	if (vdev->config->get) {
-- 
2.45.2

