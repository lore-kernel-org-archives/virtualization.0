Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5333F37C
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873993; cv=none; b=QMFR1bH3NsNv2dAyDcSJbbIlKhIPokAeMTo/0p++fjqlEsZdKo0uzxqD1xtsfXOjTRPeP1Joea+YCvTCji+7i6rabPKPRDhhe++wOdS5vKJN1aHCMVt0LOLRo38yuEUl7dWj5N8xfZxf8csY79TdsfClxO+yOpBwCC8YS+ft8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873993; c=relaxed/simple;
	bh=6qSPIQNvDSN9byLvC1hB5tTrrcXcXB4AZ7/2aqOOQcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qMUganwH/aepHFMBwIpc8GNIXR/Nq23VOMjFWGNxbHW8A+HmA0m4ItszqrD2OuuSqY2BsanUeNS030iQGOpdsR9LrYzLoUkTM1FF1m3VPb3p09T7keL3oPiQeE4Po69K3oAk+8NPbLrs9BYk3MhT0nQE4mdw4JT0m++inVOectA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEyCHRqZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEyCHRqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bES/x3uRbK5GEMVnke1YpYjyE02M84Cb/sOR55KODgI=;
	b=QEyCHRqZdSUUkjvyPUKty3yJIuC99ABVP9mHcVKWhG1G6PDEuLlOuocPWrR7t82ONciKKb
	contz43gv7Oa3ILiyB3onkz1U27ZGxaRA/+6/EcdVHcadK/0p/2OOFm4gXpRDStHBCZTr3
	l5PyeTf9ikBnzOWvc9Nw/IHREc2aheY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-p1FjZVtbNvmvjyeh_styhw-1; Thu, 04 Dec 2025 13:46:29 -0500
X-MC-Unique: p1FjZVtbNvmvjyeh_styhw-1
X-Mimecast-MFC-AGG-ID: p1FjZVtbNvmvjyeh_styhw_1764873988
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477c49f273fso12485185e9.3
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873988; x=1765478788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bES/x3uRbK5GEMVnke1YpYjyE02M84Cb/sOR55KODgI=;
        b=OdtcRUy8LSAdlCqBxQ6rh2xyuuXvqgqbdwqzT2XKI3A4PMnjLo/dXTsUAbyPhVZXTx
         GbCZhrS8VG7ElsZ739O5z6YTDLPdDPlqtEvbiUhNGtwaVuebURw5Ef+/lsVq9RHFa/Hj
         J/ydPMY7u6gPynVf20KjP9DbvSycL+AUj+s0i0VEmdCp3xSgcldLl6KiupHMlxwElIph
         qRVUGIXCdMhA8khB78bZRUkAWQz/tP9Ucte8+Mc+T93rHN0H6SJ4adQ1m8pe6fbcN5SP
         TojEM0A5xeJe0kjcmB0Mu3DIFx2/1jFrZbaVLLkxqp/bs+tlFra5v7NRdbyM/afpt92T
         TZkw==
X-Forwarded-Encrypted: i=1; AJvYcCU/IkrtBcNLZHdBfexc4eihu/KGv6raBWjavAoY6402gokRK4w8FSuL07wmiEmm8oNkkLxPBEhlplgYK3Qhww==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZbmACg6qmen5efpccxE/14RfvRhpgJBiWsRdIPVhQxm6F5Ujb
	4W85StTQ+FbRBQogm9ft3zNJ4dfSqNBHyTFYEgsPvktR4lVDz9+m4gl6mCGOIVzmahnnfaJFqMq
	P77+2t+o+0MzYhsjVGQZJnuHtQCs/IVSbVJbY9DjZQ/Xuas6I0W/Mg6boRwubYkMpTiae+o0hHS
	M2
X-Gm-Gg: ASbGncsrJgg2eUJmBIzuo7acwjTnumG69aFKJDfgaEDu9IcGUgaOViukF5GFNswYFH8
	DHsidGQPFX/14g+ESGNE0sJbAPUL870eJTejfnkdG92i9WwzGiBdBU6eG6arMvh8tXIn35Nlpfg
	TBn6n6oN6piVcn6JOtETwwmrQLqnkGV0ybgxR1HnC6EeXdI2smVPOQ58w8JP00bQ8bTM56d619K
	KyhHrsDoaNbQHumkWrvl8WNxOfVNViYzXfX4rscuu+y0DQubdLkRZLu8fg09Ea6qQbX4zkdZVOZ
	1ZfT6fuWMSfwzQ5pylrZ8i/AXM4RzjCJApgg+XBdLSrVt5lDKWnlqLacyFwt1gU8/ZB1AW/vnrY
	=
X-Received: by 2002:a05:600c:3ba8:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-4792aeeb522mr73371365e9.8.1764873988145;
        Thu, 04 Dec 2025 10:46:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5VYL8/Jo7qxIJUuIOY0+ZbRuBK1Fcetv9Z2YtYqoi0233HhToF14XrdWEChAqY58zSszdGA==
X-Received: by 2002:a05:600c:3ba8:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-4792aeeb522mr73371105e9.8.1764873987679;
        Thu, 04 Dec 2025 10:46:27 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930ca15adsm46541205e9.13.2025.12.04.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:27 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 11/14] tools/virtio: switch to kernel's virtio_config.h
Message-ID: <8e5c85dc8aad001f161f7e2d8799ffbccfc31381.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PG_OEpXi2c9GSCltJDBqCc9y7kEMZSH2j6gpEp4cwbY_1764873988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Drops stubs in virtio_config.h, use the kernel's version instead - we
are now activly developing it, so the stub became too hard to maintain.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/virtio_config.h | 102 +----------------------------
 1 file changed, 1 insertion(+), 101 deletions(-)

diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
index 42a564f22f2d..a0cd3f9a3111 100644
--- a/tools/virtio/linux/virtio_config.h
+++ b/tools/virtio/linux/virtio_config.h
@@ -1,101 +1 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef LINUX_VIRTIO_CONFIG_H
-#define LINUX_VIRTIO_CONFIG_H
-#include <linux/virtio_byteorder.h>
-#include <linux/virtio.h>
-#include <uapi/linux/virtio_config.h>
-
-struct virtio_config_ops {
-	int (*disable_vq_and_reset)(struct virtqueue *vq);
-	int (*enable_vq_after_reset)(struct virtqueue *vq);
-};
-
-/*
- * __virtio_test_bit - helper to test feature bits. For use by transports.
- *                     Devices should normally use virtio_has_feature,
- *                     which includes more checks.
- * @vdev: the device
- * @fbit: the feature bit
- */
-static inline bool __virtio_test_bit(const struct virtio_device *vdev,
-				     unsigned int fbit)
-{
-	return vdev->features & (1ULL << fbit);
-}
-
-/**
- * __virtio_set_bit - helper to set feature bits. For use by transports.
- * @vdev: the device
- * @fbit: the feature bit
- */
-static inline void __virtio_set_bit(struct virtio_device *vdev,
-				    unsigned int fbit)
-{
-	vdev->features |= (1ULL << fbit);
-}
-
-/**
- * __virtio_clear_bit - helper to clear feature bits. For use by transports.
- * @vdev: the device
- * @fbit: the feature bit
- */
-static inline void __virtio_clear_bit(struct virtio_device *vdev,
-				      unsigned int fbit)
-{
-	vdev->features &= ~(1ULL << fbit);
-}
-
-#define virtio_has_feature(dev, feature) \
-	(__virtio_test_bit((dev), feature))
-
-/**
- * virtio_has_dma_quirk - determine whether this device has the DMA quirk
- * @vdev: the device
- */
-static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
-{
-	/*
-	 * Note the reverse polarity of the quirk feature (compared to most
-	 * other features), this is for compatibility with legacy systems.
-	 */
-	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
-}
-
-static inline bool virtio_is_little_endian(struct virtio_device *vdev)
-{
-	return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
-		virtio_legacy_is_little_endian();
-}
-
-/* Memory accessors */
-static inline u16 virtio16_to_cpu(struct virtio_device *vdev, __virtio16 val)
-{
-	return __virtio16_to_cpu(virtio_is_little_endian(vdev), val);
-}
-
-static inline __virtio16 cpu_to_virtio16(struct virtio_device *vdev, u16 val)
-{
-	return __cpu_to_virtio16(virtio_is_little_endian(vdev), val);
-}
-
-static inline u32 virtio32_to_cpu(struct virtio_device *vdev, __virtio32 val)
-{
-	return __virtio32_to_cpu(virtio_is_little_endian(vdev), val);
-}
-
-static inline __virtio32 cpu_to_virtio32(struct virtio_device *vdev, u32 val)
-{
-	return __cpu_to_virtio32(virtio_is_little_endian(vdev), val);
-}
-
-static inline u64 virtio64_to_cpu(struct virtio_device *vdev, __virtio64 val)
-{
-	return __virtio64_to_cpu(virtio_is_little_endian(vdev), val);
-}
-
-static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
-{
-	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
-}
-
-#endif
+#include "../../include/linux/virtio_config.h"
-- 
MST

