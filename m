Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F612D76F
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466365; cv=none; b=dDPZudAGRajLNWDqVSXfBL+kw699ULJXK+uHXzaIdw0VRXTPsbvCTOnpSlHes1ZiG9esdwTvKi+K3B19V4tOa/FiDPw1WqgSr2h6IwvAImoMd7VyVpcyyHcMrK/QrSYyRAqPqJZ/s8E6CIYeKUq19NvU6rpFW45fFdMXJucDUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466365; c=relaxed/simple;
	bh=t/j9B4d1DAJG+x0WZEKX9sM5rtk+d1CT8qkjyuhY0Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUsz0VRfW6/i9mZ1eELy+X4mX1nFRuLjwy83xEnCedgadrw3Q5pL2KwgitEnpx4JyWCqC5JKFNNM9q7HmzWGwnuFBcNqgFFGXdiqQgFrhdZHeu4x9PsahAiV2B2icjRcvrpintPd3mTW6DZNjJTzWBHL5PYERLpOE2JbCTlBT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bc8cfc19fso6260826a12.1
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 08:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466361; x=1712071161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tswsOTneScV35e8ze8rWgk0pT/EhtrIbNgyGirLZBUU=;
        b=RTq2tM7w3ZdCGnWfLqdyow2hbLDxfrx0P+1TCvAI2WRpz0B0Em4LFsJyYYw73/49A3
         z6k/QaM5mHM2SzoddOYxiuSTphAoq1PtBkISXhrHjlvnFhs2n1IUOdU8hD+dMnJxfS+B
         XNNRzC5qLAdfLO7ixSLL/VKxUzo5QfUyqChzkg2V/Z5yc5n1eoKaWcDIpLokyuGk6lJI
         UK5VOuoARkUf3rcSASTj1Bpv77mgXOL9JKu7WZ9daeAntib+8o5J7nrsOdE2Y5mb9kEr
         U+K5Di/cwSTgCg2zCx5XWiiHWudpFLQaSwaUIYNgBSR9VrD+oyqPpnaMyZ7+Jo0am/Zh
         jKpA==
X-Forwarded-Encrypted: i=1; AJvYcCVb6SfVEX2Tla38rdrXYMrg/tY3hmMNmCtiXCPg1yYT+tq+gp8avkUoGNLlaZBwX34FupLNywkffz0iTZ+AXEb5C+tkBNz3ljv96tQE4fY=
X-Gm-Message-State: AOJu0YwyR2bVib4Dh9r4tcW08wmZXXyeKitiug+aCAAkmLRNTV2M3MQW
	su7Xk3gANMAdsk1/njcfK3+5UHEeh4urGJ9kJ3KlqVVNWh1kYyRX
X-Google-Smtp-Source: AGHT+IGDFkOEbOFg6NKy2/q2daPeK0G7VvTQ5PUqeGY5wLXijc72wcmqCJ4IBXYbih5UcuyivJHFvw==
X-Received: by 2002:aa7:ccd5:0:b0:56b:8d0e:1a08 with SMTP id y21-20020aa7ccd5000000b0056b8d0e1a08mr1222540edt.26.1711466361233;
        Tue, 26 Mar 2024 08:19:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id i23-20020a056402055700b00569731a1eb2sm4254328edx.46.2024.03.26.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:19:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: rbc@meta.com,
	riel@surriel.com,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 1/2] virtio_net: Do not set rss_indir if RSS is not supported
Date: Tue, 26 Mar 2024 08:19:08 -0700
Message-ID: <20240326151911.2155689-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not set virtnet_info->rss_indir_table_size if RSS is not available
for the device.

Currently, rss_indir_table_size is set if either has_rss or
has_rss_hash_report is available, but, it should only be set if has_rss
is set.

On the virtnet_set_rxfh(), return an invalid command if the request has
indirection table set, but virtnet does not support RSS.

Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..c640fdf28fc5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
+	if (rxfh->indir && !vi->has_rss)
+		return -EINVAL;
+
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
@@ -4729,13 +4732,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
-	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+	}
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 
-- 
2.43.0

