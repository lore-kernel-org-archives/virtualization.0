Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8F1EF0B2
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539759; cv=none; b=TjpqO79xbjjYd4H7DohkmhUXG3/2zjIctXWfYtfdEXlXw7esxvXIS55YtKXExfIDwEStMKOjzyjeuxr6ILaBqXe9ELGs3AjseLL/qxE6Gcf3dsPgio3WMqOqQMOxqPI1K+bvANEhBYmf6c7XkGKST4ItJqp5evVoUONa5PzBYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539759; c=relaxed/simple;
	bh=9CUrz9dhvu15FJYjSA2vyaWutvF8gNFVLxLx3NxqRDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1/WF2JhXy9K5E/HeRrDpXqrcbbmi5eWkYiwco+WOcUEY1avDs2mpWLfXprArWeeOZadVDz6mMmxtrE1OxQMVQnr2xKzOUZp4Mc9FasyNjkHyoNYUWQKf9p8qx2VIe8j+U/qUL5t7sVtiPkDGa4xQ6D9msKVoQH9qWMwtpvD0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=d5+pc0Zz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="d5+pc0Zz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2243803b776so3191175ad.0
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539757; x=1743144557; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50SxeWFRe74DdNLvKUCrTVWbecxWk/tvvWU0un1oLD8=;
        b=d5+pc0ZzxxXZE2w+Weh4kpFI2rr0GN0IZRYlryQb7spesR0zPtRmL+b3Ld53nyTA8t
         azkxMVFJY0SFeEHDsXwICRk4jXN1Nm/3okrwjLmhdMasxTFwz79aZTwB02BLVu8CAw2Q
         E3xWJcLt5ZRwI+SkJy09EPVNksIY1fzaG2zQQUQSU/lG4XcJ2CBTluNanIxil2NMN93K
         VX64Ug8fzjdOULAJb1rQSy/rsllwKTI0uW1LRlk5nvd+kLXqRhyQmKyxD/EUHtOV+ww+
         nPcmXVjqjc7kmV8QDh5oAFW4g/C8dJBms+QfJ6rM03TSzw9GYq403nvSmS8GiMGAU1Oe
         zQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539757; x=1743144557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50SxeWFRe74DdNLvKUCrTVWbecxWk/tvvWU0un1oLD8=;
        b=ZUMfIcNKbdAO4ZVUYm9WNGEbbSnFbAD07fNJSLrZhyOFRastxC4Jjf8HfkDzLoEHb/
         orxslibQvMm5vv/diIpIo+h+29nekCAlupFgc/1220p59ZIAfg325mJyL6fij6AJjUoZ
         1sY4aQSV0ct/Zv2Ky1RubFqayuJkiQkK6M1CjknMPqXepI9Ai6KwhVH8uNyyE1aKWRXm
         xIqEtEDWI9wTC/KyiQhcWZEma4MsVJsreqbNiYoX1lnbdPwyVD0HTR7mYIbRB0FQYpjm
         XQeqdVM3l2dj++Ewzp9qa9fcFdjzJfYphkBQ3hA3Fbxr95rk5rrq24es6PVjeXFJT3Lw
         HW7w==
X-Gm-Message-State: AOJu0Yz4X5/9vOvt4tFJV9l7Oo1qVcHYp9PIPGJtfyHycFx0/hn7djsi
	HJtF5dTftEd/XfYPuWPkhYbl/DTsesVLNYbDCs1B7N+qC9tfMNnrQGL82n0M8Gg=
X-Gm-Gg: ASbGnctKXXd5I9sFWtU0wdMV8jckAG/CyY3DGZ9fD/jvQLCVM0mDidSa+PN43vwC99g
	kaRLbi0GT34cwimy1Zim5kcyRHzNO/1TydF5lCfvKQt5980KMJa+ijrcqZZldvNqqmgnPm+iFd4
	7OBxglu272tP7AoNcji5qOQaQ74XRJtBxaXOawGYeE8ga2/mt8uL9x7R9I6S5+rIJVNz/EI51cV
	DCm/iyV6r27HPaGyEXQwfAzhUTXC5keuW6siMX0BM+sN+Ax+TOnhG2fIsQdHKD52HSbPqul/j1c
	GZHEZx4l7vl2OP6pbUbvVkDoBvu4xq9ecKLQbQMB/2GvJvos
X-Google-Smtp-Source: AGHT+IF0uHlKSVlfre+IRVuMyIVROaUprT3kAYWQuGSmWoRdQtDg0pKD8EXS5S828nJMT0659WKQDA==
X-Received: by 2002:a17:903:19e6:b0:223:397f:46be with SMTP id d9443c01a7336-22780e19bbfmr36357865ad.47.1742539757618;
        Thu, 20 Mar 2025 23:49:17 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3030f807533sm1080930a91.49.2025.03.20.23.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:49:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:35 +0900
Subject: [PATCH net-next v2 4/4] virtio_net: Allocate rss_hdr with devres
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-virtio-v2-4-33afb8f4640b@daynix.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

virtnet_probe() lacks the code to free rss_hdr in its error path.
Allocate rss_hdr with devres so that it will be automatically freed.

Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table size")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 570f77534dfb..6efec9c50b25 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3580,7 +3580,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
 		old_rss_hdr = vi->rss_hdr;
 		old_rss_trailer = vi->rss_trailer;
-		vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		vi->rss_hdr = devm_kzalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
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
-	vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
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

