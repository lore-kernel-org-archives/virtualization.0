Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD2176ADB
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010362; cv=none; b=EcFX3qCuvDc+hg4Zv4XKCH2LmYm2AJAyQ35S2TVREZi5KpSC84H/p8D+ZR22dFF/3IMi9FjjVmJihgog2RQ+6NsKlF/R9o8QBw0NAUmPxWSQIUJDtk1AaranltPof/t8LowvMuIJLJ80OqlUB5P8OixEEJYtCxvnpdZzEqFJRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010362; c=relaxed/simple;
	bh=7XOPLSoeUCMBrLUDBatTfCcj6RIpLM8/52ujc7LXvHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnZ+dzZr1ZF3lSZp2srAtEZUBqx2Wi4/DCwe+m/1Hr5sQ2FrBILzI1kYjYQm9JFn4XjWVfV8BguldhOFS10qaoEwwQrl+/1xBChGb1UBTJ5EIpOfeM0xpmovGvTg3VKRBQxu8l50ZJNVl6H4Pj3Vxw2Cp9AZEWqavZsvGjIpZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OF9xxJ0D; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OF9xxJ0D"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so8139555e87.2
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010358; x=1720615158; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjvVaTKB+IhNdleV7FiBAC7Q7evTCKPLyyvmEihGxoQ=;
        b=OF9xxJ0DcptWohzzZYCnDCOs+SdVgMtyHJ/sj9GTAiddWw2cHeoIrk42t9mIJ5Hk1N
         /aSFVXw+cxZ87xGM0E9lKNziCl3KKwQymmuTCIXEBieNXykVF3u2NFYVx5L4rPp+7Ctf
         BYy9TXgJnK/r8Er6NklsTifU5s6rfAcBvJM8uylYYi7x5hO47n0+nGGv4NPyjJbEMsa2
         h5sLCAl/lG7PYRBXZjoBs18wS4DIIowtR+p4LOCHZdZYVo3wD+Hx4oWZTb4OYX7/TcMo
         4TSO+4RJtQpdf3FjxAoyDwW85o4cQJVexLZEtvLjNv6JzDFxDPPB3/p7hurVapJ9VOF0
         xNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010358; x=1720615158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjvVaTKB+IhNdleV7FiBAC7Q7evTCKPLyyvmEihGxoQ=;
        b=f2L2KoekoAc7pL2xbmdT9PVI/Pyp4mF+50JWQDMgXRA2eesBWv0TGVNHQm65lOAmat
         gyblLVuLaL2Bpubav+p8s6/xNu/oeSwuXR41hLqniNXDMJ6drHx2OF++aIUxNlf9siAT
         zPx1oEMDNfLGdLsH0hAHrSPtcnTVGNos1XUY+IPvZs7sMuPQovC8uvz4sqE48Rl4KpL6
         yGfthywyyvmEkLOG0b+gftUBTFZ/xXVVLz+QQELeWn+4ShwFy1SoBiPMoUeyzFLxMrX8
         Js5nByTbH68p2cya3QUL2CEx2P6i3vmGlPlrvXAOXzaSebPsDtntjuWm92ec6uAsE/4P
         3NMQ==
X-Gm-Message-State: AOJu0Yw70+rR6uv5ibOYdyh9OXSByz1SPwXLoM/qG+XYRoY4l82c7Fwq
	ZbcypYkZ++1TPM5PFp7r3ulslFJZUDDy29eS7sZ0XHxhTV88bSm2+fOKD+3oGr+q9boooulFyDF
	C
X-Google-Smtp-Source: AGHT+IF31NfH7PAkOCgU5Ui3EZ0OsWAf9OqI3ygo64yOSbrXkobW+kXexbdpzOkDtOTXJv28l3TWhA==
X-Received: by 2002:a05:6512:3082:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-52e826f12c6mr8769211e87.42.1720010358293;
        Wed, 03 Jul 2024 05:39:18 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097bd6sm241402845e9.30.2024.07.03.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:17 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 01/19] caif_virtio: use virtio_find_single_vq() for single virtqueue finding
Date: Wed,  3 Jul 2024 14:38:55 +0200
Message-ID: <20240703123913.969202-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703123913.969202-1-jiri@resnulli.us>
References: <20240703123913.969202-1-jiri@resnulli.us>
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

