Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3221B0132
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948185; cv=none; b=aGiRGihIuk+TbHEILhvckTo7ZpB8iBWgTb3jMZSidkxaw5kdEGCbwHE6gQ4ZGjv53WOiajoOrUAu6N8G0AALUTcXhP/X1VgUU2m7f5dL64Ok+uSS44nyaS82q/WoTy4DIPEohZBQk5Qd9fIEmYhRlqBlHmns49P0eolZwXRf2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948185; c=relaxed/simple;
	bh=MViJWjSfHsJqaLlei01V1CNwpxAGQHBmr8mJNmgGnwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjqmHsCT5jkZ6JegUva28qaNnk/xU6KArHvynG0NVwz+I4wmcEuqWBdyuUUym/W0A2t88fuhGat6CMnu9ovMVArvLEiGMIYDj7aahZN5X0hqlDsjq+T9xrHt5WENS+oDbdUcLuXS8/PUA5g3nSJz94LBdaACBGn5h7OO4VwQJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja/wGCQv; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja/wGCQv"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-709485aca4bso491749a34.1
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724948183; x=1725552983; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6zbcqyBIlUP/XnZ5rNs71IcJLBzOMtfuT2/Qd8j9UY=;
        b=Ja/wGCQvxyP7KWbjt7C9r7+wa657sO2um7kJmcH0mayk+nUj1tsSz0/U764+u+0KOk
         QaKrOadLgDN7w5d5iszdvGunPQYuZ97tZKFnB5/MTk981v8Rob/O4XrGjSNHqBU1JtCa
         Oehw6+s6SMkv6JIqK5ydIIKo/rDOpVFRrLOdu1ByxFGlyR2R5KSoAkpV6N5beYorqUO9
         2OqXIP234QNujE0OoNXy5qd1yc4TXyhRLI6IRkLaXh92V7nRn7PpzKmToCykiTBAIFYH
         lReRtzEacOunG5iqtQpVx2+BTtms+DAk7ZS7OegRzd+sQ8c+IlbqiI0ivoLO0/i3O6kF
         CwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948183; x=1725552983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6zbcqyBIlUP/XnZ5rNs71IcJLBzOMtfuT2/Qd8j9UY=;
        b=m8nY0T8ilkg2pYclA4ciYKvWMHXsRjcoXI3LfHacdM18qLZ4BfkLs2CynfDokwKW50
         kPuuv7nZnEzNVMyKkKnVjj+A+6AB2sNG4C3EeHg4qTRpNnwsk/4CcKaD95w66ZGB8C32
         QMqPu9rdX66DNMMq1d57rOD/llh6Xp6a/sTOLyHsgUZgog7fik69eF07HgD1Sk/ohkyI
         uazlapsJc84dLuLSgVueZBYka9Fu43cKMcXM+EBn5tq+sybELuRWwXejBizmIXDjy83i
         Rt+37/w5cgqPrweYbxuLdNznO8J29y2jUdgh/uDrDFtPwiA1ea6xeXd7Z5ipc9AUrjp2
         iulg==
X-Forwarded-Encrypted: i=1; AJvYcCWj0f21ScKcjZdGh8wnKgem9JiUIvTGgJT0PNc+p3fZLntFTn2znEBqcPrMOftnW54CsjtkT8rueLVUjcO3mg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYrHZuTbjer+69S4PVGcVLAREe26vyrTb/J4jWihlIbsjnp/p3
	75oWEF3Nr6BLb2Zw0Uokz/GBguJRUMPUpu9hB2izy7J3zuA5rrRB
X-Google-Smtp-Source: AGHT+IGT7RHkuPcE1EA+8NmGKrBLu805FthVMb9kuQ3jIGS8N3mNyXQD6Yd0H3MdVk5p7pYpDIW51w==
X-Received: by 2002:a05:6808:1a05:b0:3db:153d:5552 with SMTP id 5614622812f47-3df05dc09cdmr3292554b6e.30.1724948182948;
        Thu, 29 Aug 2024 09:16:22 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df08943854sm372296b6e.45.2024.08.29.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:16:22 -0700 (PDT)
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
Subject: [PATCH 0/2] Initialize vDPA speed/duplex and support their updates
Date: Thu, 29 Aug 2024 11:16:18 -0500
Message-ID: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
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
vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Include
logic to update these fields (for VHOST_VDPA_SET_CONFIG) -- even if
hardware support is not capable yet (Make a note of that). Also add warning
messages for out of bounds errors in mlx5_vnet get/set_config logic.

Note: You can test these changes from user space passing a fd of your
file "/dev/vhost-vdpa-%d" to:

void check_config_speed_duplex(int fd) {

    uint8_t *buf;
    uint32_t size;
    struct vhost_vdpa_config *config;
    struct virtio_net_config *net_config;

    if (ioctl(fd, VHOST_VDPA_GET_CONFIG_SIZE, &size) < 0) {
        perror("ioctl failed");
        return;
    }

    config = malloc(sizeof(struct vhost_vdpa_config) + size);

    if (!config) {
        perror("malloc failed");
        return;
    }

    memset(config, 0, sizeof(struct vhost_vdpa_config) + size);
    config->len = size;
    config->off = 0;

    buf = config->buf;

    if (ioctl(fd, VHOST_VDPA_GET_CONFIG, config) < 0) {
        perror("ioctl failed");
    }
    else {
        net_config = (struct virtio_net_config *)buf;

        printf("  Speed: %u Mb\n", net_config->speed);

	if (net_config->duplex == 0)
        	printf("  Half Duplex\n);
	else if (net_config->duplex == 1)
		printf("  Full Duplex\n");
	else
		printf("  Unknown Duplex\n");
    }

    free(config);
}

Carlos Bilbao:
  mlx5_vnet: Set speed and duplex of vDPA devices to UNKNOWN
  vdpa: Add support to update speed/duplex in vDPA/mlx5_vnet

---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 46 ++++++++++++++++++++++++++++++-
 drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++
 include/uapi/linux/vdpa.h         |  2 ++
 3 files changed, 74 insertions(+), 1 deletion(-)

