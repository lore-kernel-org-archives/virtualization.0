Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABA351C20
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027227; cv=none; b=lYBhnb3F59JSZjlQlR3usFko7EFwCXZnD8MqUxPc3bjTeeyhOUHIGBlzwtwq38bbx/dRpVVK0l9d7qy6t7korC4bi1KAxsyqsUhxOpGCE1TfBcnDAGNIyxoe8gQVzrBUCwOojb+w+loiQjv5azR9UdMXrlrYD0Sy73LH9tP+gKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027227; c=relaxed/simple;
	bh=6mXttWXqP7hKPvKeC1m83ALHTC+qzKExe01Jfr/zd+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k46nkcUJWUds48unfM1uAXlXr5wu65xoFcfYM5Ml/xQqRoUDjyq9QsVQqAlSH06s2dTSb1DgcDNG1IatkDOwOJuV5AyfEIHvD3StUiQDD3jHhNniDGgWJ6NjyCwgkZ54qM8Gzh2PQF7p1FzWgVe0PrNrFi78QDxTAibGZ13Ovo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMdfqDTz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMdfqDTz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso3424135a91.1
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027225; x=1787632025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Z6WowRuMM5BuwpectVAQheGXdLd2OFjAur/zQyOeH0=;
        b=OMdfqDTzsdwwx4IEPNPWqUufZ01Ro5MwBJMWc0XeWDgNvvCxUjnlDgaM8Q/hytseN0
         wJA/mP/8yPpTtH84GqCE8AKsa6W32Xv42JcEdFfOJNSR6S8RdaUQ0QpXkjjhgFEtHDKX
         jn/yTO0wUfkZ5jgETokwsYmjjhWfBrloSycw8TnvW+U2gm5LAodMQeKuRJ7wuBnfdZCL
         C2IHu6sBDSZBH5b9JUmqkhSHtzonyysFZSmLrGGeWj/ZAOYs4bL/ZRvRqKLB5uQwIuhS
         pV7yziqgSMAP22ugfTsy4a4luAZhbfpMdhu5AChnZeFDDjFwLEiP0S48VcZcT/FnbIOE
         kytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027225; x=1787632025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Z6WowRuMM5BuwpectVAQheGXdLd2OFjAur/zQyOeH0=;
        b=WE/vq9tGfUk/pWc8Yrnk+3+rFJJ/jGkoPue4W3oQG6o1B9oPEkB2qERhTUas6nlXra
         Mu2JPK8wDD3hM7kJK18st84jt6y3ynyd9oKxq1G5XbRxwutEzlpSX25TjAQ5ZvuJ/PRU
         88rjefv0ktGC5xoCPM2R0iPKvdGbhYAfXFV3BH5dttgCRGVTuFr1kjDBUOOzf4Eu1Ysv
         GwhfjBOhuGX03QbGBNg61T0GhtzFRN5jl8UK6vAE/fZ8j2FVtfu0OpPW5z4Xd0fAxIPN
         WQzFeEiMJfvKjvD62iucHkDGyCNuaqkqU0JbxXwsxlMiPCHM4nLow9HZ49KW1opf+Xqh
         ihrQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIFyVCgGZ83TCtNdp5WLRFwZSpd9vaVTSaAM2pplr99C6sB+j00rTRzx3DVt7dVU2mYiXvx0HrGs0AXwAEMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzHOJuRm6d3lBZrW8HpXic4kvlXQ3aMpUD1r6kXCQfg++jMke1
	ikZTcjo+APNv0rnlXpqQc/cOqVelQs4ciJCTcVb1MwE9OzZ9g4Py60Vi
X-Gm-Gg: AR+sD13Dc0HNOEre/qnE2Lr7UhGnHZbZS0N7y+Z9VXUCGiC6bsFgdKYjqiq7O9nj6gv
	gH+5jB/xEPWzzmGok/o7xXW9hrjyyC+TYko3G8AdGd3vaj0fYz1wNumhvuij9FNu2a8K64KQGRD
	V/6AqsLK3Aj/EuGrIPR+zRAts8gPOL6hSploeIttFZx10W1tjgamn3oMkn/V32Vjc9CvnzOs2SZ
	94SXN1ljRIMrN3A5UYDUyL1M7XLT1cxtxWt9XnFcxlq+fChQwC5grDVKa6Z6GV1OO+vAICIwfUx
	QTeOrNnq7jF2yj8VjbCOOV9MOl4rbMONdivYsE2Nluun9vhzpqic8s+4cykIHEAyyjvwwqH4lql
	TL87Sa3oiGjbS0J0rAvPbBuCS3OJT/Kp38G1KYQsWXvhDMc2nfuN2bR5Xsr4MSfUlv91Yxz7yJg
	15XJfkrm3bWAyo++PjCz2IuV/CjU6myxCGJZ6baXDD/MOvccQwXtIUsA==
X-Received: by 2002:a17:90b:3d45:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-3933b9157eemr32102204a91.12.1787027224856;
        Mon, 17 Aug 2026 21:27:04 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531fbb41esm7011643a91.10.2026.08.17.21.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:27:04 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v6 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Tue, 18 Aug 2026 12:26:13 +0800
Message-Id: <20260818042613.281125-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818042613.281125-1-physicalmtea@gmail.com>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply the common device IOTLB teardown when userspace clears
VIRTIO_F_ACCESS_PLATFORM. This drops stale translations and avoids
rebuilding an existing IOTLB during feature updates that keep
ACCESS_PLATFORM enabled.

The transition invalidates cached vring access even with an attached
backend. The backend remains attached, but userspace must configure the
vring addresses for the new address mode after a successful live
transition.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")

Link: https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 77b59f49bddb..64671cf77a35 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1673,6 +1673,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
+	int ret = -EFAULT;
 	int i;
 
 	hdr_len = virtio_features_test_bit(features, VIRTIO_NET_F_MRG_RXBUF) ||
@@ -1701,8 +1702,11 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 		goto out_unlock;
 
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
-		if (vhost_init_device_iotlb(&n->dev))
+		ret = vhost_init_device_iotlb(&n->dev);
+		if (ret)
 			goto out_unlock;
+	} else {
+		vhost_clear_device_iotlb(&n->dev);
 	}
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
@@ -1718,7 +1722,7 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 
 out_unlock:
 	mutex_unlock(&n->dev.mutex);
-	return -EFAULT;
+	return ret;
 }
 
 static long vhost_net_set_owner(struct vhost_net *n)

