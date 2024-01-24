Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241717BCA
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086718; cv=none; b=d2nDHkMZX9zzQQucjypMoPVu1GNrsSvIlXYhBOu7oOZgg6DkXx1gxNYfP4zx4ibRcBqVl3rRUQ32yR82/KWG9YyFTM2Rp1C2IlbPb9hFcvtrYrg6qK2pGItp4dTo1KEQ879iMCRS2yjNoAENZ05aa50UA3g7nksZzMl5EHF+giM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086718; c=relaxed/simple;
	bh=jdwIaRyZVHawgxFCTMPT6W5hewQswlcHCPCVXYR0TrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hNV+uY4ZGgdLJaGC0VTiYAFIeJbNxVcmQd5FVKcDN7yH0fv69HOWqdET+yoMCGvDhKYFL+OPKMxsauk0/L0fN6HBU/2xW5+KQAKRmxv8Se2rzhjo0hl8ln7PbNMwqbSPVMnLcO3WaRlOX6T4xobAt2XE88juxA0OfWK0/cvMRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y19hNYvJ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y19hNYvJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B91A40148
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B91A40148
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Y19hNYvJ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sql-MqwMuzrk
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 08:58:35 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C52EA4026F
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C52EA4026F
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-29051f5d5e8so2463832a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 00:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086715; x=1706691515; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V18ahqDfUiTzj8CjlF4Nthz8ScQc5lT8Pof7p8dY6zs=;
        b=Y19hNYvJbXnbxA919ClOBWwTAx7TmECYE1cdur4KRjg8cRQjPkERZBmflh8GB1h62F
         YIlZJuXg3/FF+jkuH17N/nOdHK7vXXJ6rXBNh+W8wan0b6Dboqdz03YWscPKnt0bg2qz
         I9FGMCs5YjInvH73k5mfM6KBQMP8NI3k/ghHFUVqXE7fpgoCScU4YsEwH2OA5IbzOPPj
         Rya4kKUcXju0tbhu6xSLVKQXhcBR+21ZFW2Zrd0csWqeJn0SA/NDYI5EQMvP2Df8QXIL
         VAQOp0oPrpoxlL1J5fvRlsyyvKqiEqPTAK+NPn/rmAmoe5epBUE2A3M6RNIvcO0cNVT9
         +84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086715; x=1706691515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V18ahqDfUiTzj8CjlF4Nthz8ScQc5lT8Pof7p8dY6zs=;
        b=pWvaBWM3Z+Yu4cutMEYOtomG2L0BXr3KyEV6habvFXOm+zFM+GCpX6egRLNsq8GiJw
         zY3N0iQ5CRuJyFor3iegcTxprddwxRU8PUiXkGUGLAqRi/UEyu4XPuFwFD5Gco2cuyUv
         BOLb0PGW3o5OHINX9/nTXyFnH4sLnYo8I/mKO1c8+rCqTglQJkdym/tsJhy1rODNkXnZ
         Y0JYNCjPWiJmb/b30y1TUC+DFBKxTMZ3hyfLdewS3A0gPKedBCla6da4OTdZ4x0D07t9
         yHwRKuEUQ9bs3MJmV76CWecH5d6siUgs3gsiJcFo+yszMzP3r3l7dptiQlVtqDzFXrcS
         rHhQ==
X-Gm-Message-State: AOJu0YzbTUgyCC/IZbSjFJZ9KUNvHBxtWJMbh7PT+fI1p3FU/12qeXz8
	AvpffA1b1+DajbsuGeCGKpF7RD7MhEWOeCuFoismzW1wLJ0yEC0u
X-Google-Smtp-Source: AGHT+IFZ9JMGmH1Dag84QO2WjpeT/Tb5T0tareAvTBTF3VGyKmBnI9dbGMIzAd/2ZzNw9YeZz5O6HA==
X-Received: by 2002:a17:90a:1217:b0:290:8d35:f467 with SMTP id f23-20020a17090a121700b002908d35f467mr2948933pja.32.1706086714960;
        Wed, 24 Jan 2024 00:58:34 -0800 (PST)
Received: from localhost.localdomain ([107.167.25.130])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a17090b50c300b0028ffc524085sm13192233pjb.56.2024.01.24.00.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:33 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v2 0/3] virtio_net: Support the RX hash XDP hint
Date: Wed, 24 Jan 2024 16:57:18 +0800
Message-Id: <20240124085721.54442-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSS hash report is a feature that's part of the virtio specification.
Currently, virtio backends like qemu and vdpa (mlx5) support it(potentially
vhost). While the capability to obtain the RSS hash has been enabled in the
normal path, it's currently missing in the XDP path. 

Changes from v1:
- introduce a wrapper structure to preserve virtio header

Liang Chen (3):
  virtio_net: Preserve virtio header before XDP program execution
  virtio_net: Add missing virtio header in skb for XDP_PASS
  virtio_net: Support RX hash XDP hint

 drivers/net/virtio_net.c | 102 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 12 deletions(-)

-- 
2.40.1

