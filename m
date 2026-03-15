Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182436F40D
	for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773586685; cv=none; b=i/Nc6tGyRYIOP7JOWUf6O0X2sDnJPpNkyzWK+CyK6cCmIbXs17hPeAFxooPxY11AwRxAVRy8uOwkDkp9N9S/taK2ERQ8g7HiY3R6HCzZVvAy9MBPcLV2Iy+jKXbiRSLSMSTb8AKdCc7CkaoQScmrgKWCKapGFkYHNfOWZGkzC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773586685; c=relaxed/simple;
	bh=6XBb7rY5v/D8iEe6FdfdfhQMslWqkKqoPUVYE+ifrOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0x2je/ZTM/ESJmaIQEDGerTIqSW/LnhGpucXfmopJwWFjQq+Ne5BWmExNiUgxQ9tcmwkyYVPoX/Bbz9UVss+XurbdIZlLQppDR1eiyrl1wsbFVNojSlfJgvkdQZWUb1V3VnjuriesnPcNBkp29Pjls8+vdee2ZCDmP9jltxUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMloBRRd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMloBRRd"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so4234835f8f.1
        for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773586683; x=1774191483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx2lgIFyoSQcCE8kSLnBi2FG9n8u4IajfVtQk46hBEY=;
        b=RMloBRRd2QLg8e3nyM3NxfgKXCkoPcZ6BHmI5/jsyS/7gimC2DXPMAqcD/WEW5glXf
         Xcg/U7R0CjdaHCMO78Ju+bQYdmnyAwoNd0oStGVgGpzcmU6Tg+DSpAK6rsNDcd61FIJd
         N/xgWRKOnxa5Uq3N/8jL/gaMyO+7uRK48IwzIR+cvQPbZMopwXBPvDVyogAyfDgeaQLs
         giue8oO82xm7hqyaVxXgSO3b1FGhLT/NgElWq5P4wZjNMGP5SwDM++mPKomx0yD3JAKF
         XvX0axF+gaa5pMzYoroQtUM2gRjAbBYPJZgYaQ0HkAh8DCBUofXOir28ySg0+RePpegy
         LWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773586683; x=1774191483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx2lgIFyoSQcCE8kSLnBi2FG9n8u4IajfVtQk46hBEY=;
        b=RxEVWMEoNkHpgaRXET24GyFoPJUQVBG5d7buEAoeDgBn+7rjIPQ2tFvfuK482YvP6f
         GUxsSAYacvBeHyXqwahzeepJMFMtVMfXQ66vDcEIgjVf53DGkd97nr1c8CjQ3aBvdWqU
         D31d7XrYAxVlnpGEUdoiHEE7c/SI8GZ2J6V+v6oUCQeXmtMhWwqUm5PBtvqUp1LN7Snp
         +cSs0FhC1uixMPIwXb6NrpDczvxZw45Ravdtelcq2tUYlPAYYV1W0IJzzW/CeIr92R0U
         Rqk6p4bADssuwQ25c02d25yN7ttTvDvEVdFp4jb+PQGPEsoqHcY/X1OeHB275dEXVRxO
         NZUA==
X-Forwarded-Encrypted: i=1; AJvYcCV0m9dQ9FLexQFM4jGUeta19jUCvFx6eew0O40AOKBVyN0PqJA006wbULVQG0++YyGq7KyjfyN1/hIrYgNZsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZe3hmShDJJQg/eEumrxwcSzSPd818KdYnat+K9PcDbUsxE2Fx
	IxoFlgi4oEqForwBBsMUGGVDJR2XEI7P9wReFGrrAWxMg5jdeEt26crC
X-Gm-Gg: ATEYQzy7NxPk0yQ+NWtGpsxi6/k+I7hjHswor3HnmGhShZ4UL873B/ly/xm7o+1QikN
	jHEp5d6xrDEEwbK5rxcQ1cvTJ6Ay34Cqk97gzAKuYoyIW4v9P1soD9XOHeeGqI6d0O0fcHKR/iE
	9BT5JdLsFckAzZ0eCsFNAU/ZgCLnV/dPMw5KlPg6eaQZlYPngBCCymoLVWfOrQbJ38zT3mUVoCf
	W5ahwFjUVmB6E3QR/FtB+je2vV0/cxAKxxeKA3sGwEqa144eGFoLt0kNtuDZ4LD17ibxR9RXt7d
	k4Sty6Ij5CcGR0XMOyZ0UmdYMUJBPqsR9E8JuaQfNqSEpsDNXgooo5JzJYrSq8Uf4RlewAQIE35
	lMqTUehd8psrwZlXnSLR1VxEFYqRSmwJr0pXh/Ngvj8sztxyu+yxAaLWL2Y2E8YP/Am1dwOlFKD
	FK6v210JQylvhzlump85oz5qe85anGzV3y33NDkVjpP/ajf0pn+KmmN8aq055Z3xD/sJztgGoqt
	gievaKHDBybelQw+rvdVyaTfJ2GqA==
X-Received: by 2002:a05:6000:4305:b0:439:fd13:5c4a with SMTP id ffacd0b85a97d-43a04d83e7dmr18498287f8f.6.1773586682521;
        Sun, 15 Mar 2026 07:58:02 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273e8sm35958172f8f.33.2026.03.15.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:58:02 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>
Subject: [PATCH 3/5] virtio: add kernel-doc for map and vmap members
Date: Sun, 15 Mar 2026 15:57:52 +0100
Message-ID: <20260315145752.24177-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the map and vmap members of struct virtio_device that were
added without kernel-doc descriptions.

This fixes the following warnings when building with W=1:

  include/linux/virtio.h: struct member 'map' not described in 'virtio_device'
  include/linux/virtio.h: struct member 'vmap' not described in 'virtio_device'

Signed-off-by: Kit Dallege <xaum.io@gmail.com>
Signed-off-by: kovan <xaum.io@gmail.com>
---
 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3bbc4cb6a672..287ec7cdec55 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -157,11 +157,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: the mapping ops for this device.
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *		    device.
  * @priv: private pointer for the driver's use.
+ * @vmap: mapping token passed to the mapping operations.
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */
-- 
2.53.0

