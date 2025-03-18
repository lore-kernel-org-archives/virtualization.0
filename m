Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B9209695
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291846; cv=none; b=ogD7JJen2iqxWLn/2PrPSFtKYfgb6rK+F13nqTlBLGR0m1a7DJidexGGS2FIb+p+CaLiNT8Ic6xpEEHqclego6EAjlaRfQUvmGiFMai9yTzo1LRndlfjdl29VJSHSGnVlNq4l82KIijnDJQTak83OPId4Z3esX5WUs2vhjCVLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291846; c=relaxed/simple;
	bh=PTPRleizS1Yo/Zj2lCHknRUrDScXS7LpuAGSZt5GrG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nG32m1IPdXEWIMRGpMGFcugP+CreRZDveyS/EgX/LNjpoxTobGHcOZE3cT/wp1Fgvlt9GzeK5cmK1tmOv9OcpjutJPRvbFiyTfki15JiV+ShWHlD0D1EFBfGdme8XyPpQQsEn7C+bKla41pDn1UixL7+pwjNpNEW3PrNL+E5pwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=o3etnJ1E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="o3etnJ1E"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso2756295ad.2
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291840; x=1742896640; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp+TkaR3KA/C/LJhQd39jSgt/1NvtxrTDAfmjY+x69o=;
        b=o3etnJ1E1ZjuYhCsyMFa+VMunmbKGyHRKMSUZerh9Fyi2Bgh6NWNLZB9ZV4YSCSsQZ
         7NUkd/+w/AWM/6kPU7k5QCZuxJNaysOFE9xgN6GWul75pleY2CF5Ji3L4SDUnsWUDdhr
         k9IFSpEHFUgiGR32oJc8V/Cci/flWTsolQg0hXFcKcLb6ysojiJ1FXy7YDtuJyzOnrVA
         6VM8FkAeY2OCr/vJoS2AH92+j0s2Pu/tm5F5gwhWEhRu8EeZWvYeuFgArXE9yoLlWVQJ
         BojLH8lcwudC4EnhlAg1zXCMAetby1Dw6xT3zr8dvmreDKBtZO0GNUMSEt/s1288Nv8O
         Qwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291840; x=1742896640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp+TkaR3KA/C/LJhQd39jSgt/1NvtxrTDAfmjY+x69o=;
        b=GAtc3dd6McKKjoWPXfNL2k3Yxaqa6qGQpGU4iPujvezos2UiobN7ZbK/RiTX6DvvOt
         +SoeBrmZ4l3R9oRCqkgBZZulZmxb5YRdguLs+ibpY5kdTdQEFM/peSR2Yqnt20ncDTQZ
         yACrvV8sAH9CY3WhhbGGClDBdmt8FDj0dMbcfX5esLrLmv4sFSrmyOuqR59OxGJrEZ8i
         yaLlFe8M0Fg2sRzSrMO5g2i1uDUiY6WoAMQXdqzcrVExkUk/Sw9HHoD90uxhJFclSAqk
         OKdxqKEsO7MNPj/16dCPrHZHJXE8xxVK1x5BMzI0YNdU3Qg0kJi9FpXsm0QUkPCJ+5G9
         Z7Wg==
X-Gm-Message-State: AOJu0YwAfnz9Zl6jM3/Wr6h/qNm6TYaMymZ53iEBBwjQHMtsWBAqcKRZ
	hNIWyKPXq1vsw+uMP4QLoKO0o3CM0LxMNVVs6N5WapFeRCQI/MlKSSNDw99jNajH9UC9pFe3Ttg
	4NXE=
X-Gm-Gg: ASbGnctssA6qLb5noi6CscGiL/lMB8jhjmhVRaGTIkrLkdqEjGVLgNoT53/bw7iHbVD
	zPa81AlZw+r8SPV//0kloZjRWeQSWlDg813lvTVAoGNl0ENt9yCjooHTctfxyBn1Z0vibzH57lC
	KDHGI05cxcraQ4+juupJxdPG18iizgARr6X5Z23EYZEFPe652w8ke7PBz+EsFJ4uX3yChIBXqF+
	1/phulatWxUP6mzf3iKjOUWUJuFxreEI51m0CoXVtSf+0tZhrkv8l8ncfJKudeId5ADbp4gA64Z
	SUABTYfYoU0Aj8z/ja5RKVUEGE9Q5yIRkWa5mSwEThD8GSUa
X-Google-Smtp-Source: AGHT+IEau+wjrdRHJMlS5nyOT1rvXp0wuHKf/Prbu5sQ6Jh/4b7CF8c7TS8qmvF6EWe5N8kKungcAQ==
X-Received: by 2002:a05:6a00:b91:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-737223b9098mr15931032b3a.11.1742291840607;
        Tue, 18 Mar 2025 02:57:20 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737116b0ec4sm9074760b3a.159.2025.03.18.02.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:54 +0900
Subject: [PATCH net-next 4/4] virtio_net: Allocate rss_hdr with devres
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-4-344caf336ddd@daynix.com>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

virtnet_probe() lacks the code to free rss_hdr in its error path.
Allocate rss_hdr with devres so that it will be automatically freed.

Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table size")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/virtio_net.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4153a0a5f278..6cbeba65a4a4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3580,7 +3580,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
 		old_rss_hdr = vi->rss_hdr;
 		old_rss_trailer = vi->rss_trailer;
-		vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		vi->rss_hdr = devm_kmalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 		if (!vi->rss_hdr) {
 			vi->rss_hdr = old_rss_hdr;
 			return -ENOMEM;
@@ -3591,7 +3591,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 		if (!virtnet_commit_rss_command(vi)) {
 			/* restore ctrl_rss if commit_rss_command failed */
-			kfree(vi->rss_hdr);
+			devm_kfree(&dev->dev, vi->rss_hdr);
 			vi->rss_hdr = old_rss_hdr;
 			vi->rss_trailer = old_rss_trailer;
 
@@ -3599,7 +3599,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 				 queue_pairs);
 			return -EINVAL;
 		}
-		kfree(old_rss_hdr);
+		devm_kfree(&dev->dev, old_rss_hdr);
 		goto succ;
 	}
 
@@ -6702,7 +6702,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
 	}
-	vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	vi->rss_hdr = devm_kmalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 	if (!vi->rss_hdr) {
 		err = -ENOMEM;
 		goto free;
@@ -6985,8 +6985,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	kfree(vi->rss_hdr);
-
 	free_netdev(vi->dev);
 }
 

-- 
2.48.1

