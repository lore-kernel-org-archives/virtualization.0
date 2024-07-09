Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C913E40D
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511466; cv=none; b=r1P2Mo2yZrG3rQJEeMhKPSDFgX2zm2G5vsNMMrIm0VGCo+C37UAnvnYZOHYtgsoVm51g+aRT/IsaMO8SCEBuM7qEsg6OXaOLbuAM82kjy64Tx75W6qUQXJ9EUuc3MiRr3CJZ2SV3r+3s5CsLyAwyJpAUSwFwf8dVRlr4hpRrZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511466; c=relaxed/simple;
	bh=GW+EbPAm4hHbTsC2x/kPcfW/1ojBg+BpcgL47NVHa7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ekjmkyN6wt4Z/A6pSRPWKRJTSdnKNb2qLPR9+DKpn0pdRmup9oPVBuYhdBUVKOwTVBfl7ezwvAn3Sz4ob2mQD/P1gUqZIEUYyxN9sKrxClFRfx+OAuj5yrIfTBuHXLYEetavSdEkF5lVvUSB4ddRPjFZFwWmw8BGd8sMMAAjykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eNxoPXkt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eNxoPXkt"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-754d2b05db5so2560868a12.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720511461; x=1721116261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rH2LKJ5HJHgLjNSyzU2sfO5c0h5HphrNELJ/X033wjI=;
        b=eNxoPXktCPDPz5xlRq7r6fEu+yh2GCypTTa1joBJ99QP1L2Wus2nM7Bg/yx8LZjAN3
         fZmGWguHz93eZOeU7CopB0ttbeyMcxF/9tLqftrtX/c2+HhqcJslf46nejqHVtYHfOdj
         hzR4TaJBqrq6PfFdYbLKxVqdBPJCs45f19bMNpK3Rt0upHQMqvMUIu/Jvi2LknKQcosn
         JATzxBlDyR1dywzcCOlmbMdFayuAh26R0MGz9+772G0EJDyLAx2RGbIOgQG19tB8rrMY
         sfzZUs2/fDfBb94xyYleyPnf+Qc8X4RJQudCNywNqTX87xpoD5OU2R1JrgS97+3OzuHx
         ypiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511461; x=1721116261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH2LKJ5HJHgLjNSyzU2sfO5c0h5HphrNELJ/X033wjI=;
        b=VSvf2NDsPqprdTqKyYKtR0JyO/goMTIH9J3ho/gQb7/srr40LFvQAyN9AQXzNdr56T
         GYcuE+3ylYg1tgDdkpVh4kV+ulEIsQFWSPq9Ph+M9rBUFi2oIxDw6OMqlP2ARzhJ+Ktd
         2XtCeZHtWqvzky4tvjHpY2W4+NcDtA0QRBLEUtcjKhvztqpx7x4zaqLtqLnrciyvB3ZV
         MT4TNQf0vOnWUJFSAni+FngyCzlZTSCqMP1P4MEHtsLUfx6x51P1qGk33JNUPUN5JF/b
         t0autYkYd0zgEG2vKAHDaDi6LVWWYC00CrHlG+lbb7v+gBmMXA0Krkp62xEhP3bqqMwr
         ArjA==
X-Gm-Message-State: AOJu0Yzdo+araigXM+V2GajCQoGaU64AbCLDo1Px/cMrmWF8NUcwVD1A
	vj7C9huk6UxH65Erkkywf/udyvFEaBczriDIeyRdnPgeLDFliwg4toGkC84M5Xs=
X-Google-Smtp-Source: AGHT+IEtzhNLYwdsLUEB3IkPaB9LK4j2KJqmSU8T6ZSrbB0fgnQxWDy4bJlJajo85/AGEYmPcUSvTA==
X-Received: by 2002:a05:6a20:72a5:b0:1c2:1ed4:4f90 with SMTP id adf61e73a8af0-1c29822de17mr2198873637.19.1720511461277;
        Tue, 09 Jul 2024 00:51:01 -0700 (PDT)
Received: from PF2NG7DJ-CGA.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa621e7sm9369708a91.41.2024.07.09.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:51:00 -0700 (PDT)
From: "lixianming.19951001" <lixianming.19951001@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	pbonzini@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lixianming <lixianming.19951001@bytedance.com>
Subject: [PATCH] virtio_blk: stop all virtqueues when 'virtblk_probe' fails
Date: Tue,  9 Jul 2024 15:50:53 +0800
Message-Id: <20240709075053.811-1-lixianming.19951001@bytedance.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lixianming <lixianming.19951001@bytedance.com>

We have already enabled the queue in 'init_vq',
so we should stop all the virtqueues, just as
we do in 'virtblk_remove', when 'virtblk_probe'
fails

Signed-off-by: lixianming <lixianming.19951001@bytedance.com>
---
 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2351f411fa46..fb702be291c2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1559,6 +1559,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_free_vq:
+	virtio_reset_device(vdev);
+	vblk->vdev = NULL;
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 out_free_vblk:
-- 
2.20.1

