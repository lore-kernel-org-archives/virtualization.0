Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AF198E92
	for <virtualization@lists.linux.dev>; Sat, 28 Dec 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411800; cv=none; b=j04YmyHSvyjUV436CDaYDOzag2NdcK14DD60ju+uxmtt2Dvg+E4f7Mm9ti3j6pa1OraA+94uXqDgNo1lLuSKB1+6J8EKna1/WFvRKXT8hAR/Q4ohu/zrCB1C8ic9YtF9WtCuoMBjaQJhOG3GMVYCw56NFqXchO2Qt0+rwFmT5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411800; c=relaxed/simple;
	bh=rjLiHSvKUq/eF1loio7Yr9yGD09W83hpAJm71ZhEPPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adjKImLt9iZkFIEC7asea1zInp5AJTFzWyp+/wi1GYZ7MRzmNWreTZ5GBCC/psxEV/98r03ELCHt2ut1sVacV6142nxg5nAnZkMJdB16+rUiigR+M8Jz8q5QRqlTTJeeWhtUAXuD2MAhiVLqZqwOQOdVZIuAd0eFbfsZEFL/HYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS2BV4QZ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS2BV4QZ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso8289010276.2
        for <virtualization@lists.linux.dev>; Sat, 28 Dec 2024 10:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411798; x=1736016598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyD/SfnxslLrliyoyVIe5C8rt51G8jW8D1jt5/B6HkA=;
        b=BS2BV4QZBtFr8FI8ZxpVUo9qbt2EKdzCEo/ZFzn8J9mcFzjgYmWKsop664xrA7e1IP
         fcsIqCQZ5Vbats++Zld8uATCrbasCzaG0+sDTVhVc6bgmM/oMN53H4azd0D9j/uwpPn/
         Ri58JxXrrGfrQMmR0HeBbgei/zuVAd09WQuI/39Cg4+eDcRxrB9tPxoTHYJRqqFaAzGS
         t1jalUsAinW0w5QcG7/iCs7N1le906Zkq9kwyirYzioqJnziD2cysnF35fzAiYqn5PpD
         DOpFect21O+qBfPuqEthEiaCufCPA2HVd8HPR5CkE44cBFDS7Sak60XA1XJY11BxHBiq
         XTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411798; x=1736016598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyD/SfnxslLrliyoyVIe5C8rt51G8jW8D1jt5/B6HkA=;
        b=Dd2x5+K8Pu6ZZey/PWpDB9f3qJDHRkQnMxNBpNj8SrJ6LoEscz4riCUC3tmJ1nsGbQ
         hds5td8yohCOaoSxuFY4+VSPl8C3N0r2hw5g/lHBRYt7WG9T2Nd0GZRdXgxegI3NTsP6
         qQrR92uVGaBgY2L63IDIZoBwPwJOoIVJQF+ejPR0jA+4DqbQgc3Vk5vtmYf3G+xdQNMh
         bu+JJghXlZCIRtmDCzOhBXK0ZCwIYsI8agiqZBH7hJZBcw1PBdAMnuFZjdl9fKgp4C/l
         PwACftScYxJOdX6g6q5XhZ5CrmMnUrgEaMt2T8hJ3+tgNSzZOdcYjO6k4kreJu+V1BB5
         XUTg==
X-Forwarded-Encrypted: i=1; AJvYcCWC5ISvEV4f+aDtsINcQlncsJehLZbozG55it1Y27BkoILtsjVUH9htNr1ettRkBIOjM4kk3XeLH1TW1aSrZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNeAAcMSY/kHFaWPy1p+VyUMBhj6PPWAGiNnIGEv8sznb0YLgX
	Rg38KxICuJTt6w1klVq8XaqiquCgu/cGHtQ7PX+jKG1Qe3/7vVk6
X-Gm-Gg: ASbGnct18F1iO/LkUwVF00Yuz2D8wSZw2v/b7yYFyM69tipHUPXVNoHuoTpRzvVuJgR
	nAmwDuTe0rC6+I+mrMBSZD5zu4Y4vWbdBO7RTsNBqxfBHFpQf820QUOmi42QR7pYCCpWSYgthQ1
	Uc0kbjSMWLxd6PmMVLW8xkUvlwzxBQVZ6i2mcUbqZD8DwqduoxRipcdaRy4mkYcybJDQ1M1aK63
	iqo2qOZlQPpQXc21UaytQ0RYpr8Arn4TuzBt3/ZO/nZ1wXfv5tKWJ4EkY8PJ9yZfl1ayg607d2g
	R2x4Ro1J7shyavKo
X-Google-Smtp-Source: AGHT+IGiqvJf1RliBJCBp61gtA5mmGJsJtIiqDmDHZDVegn/DpktFuOcGR3eHMQYzJgC1Tq1ntdg3A==
X-Received: by 2002:a05:690c:6c08:b0:6ef:4a57:fc7c with SMTP id 00721157ae682-6f3f8115430mr229828487b3.16.1735411797858;
        Sat, 28 Dec 2024 10:49:57 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ed1fdsm48567247b3.84.2024.12.28.10.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:49:57 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 02/14] virtio_net: simplify virtnet_set_affinity()
Date: Sat, 28 Dec 2024 10:49:34 -0800
Message-ID: <20241228184949.31582-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inner loop may be replaced with the dedicated for_each_online_cpu_wrap.
It helps to avoid setting the same bits in the @mask more than once, in
case of group_size is greater than number of online CPUs.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/virtio_net.c | 12 +++++++-----
 include/linux/cpumask.h  |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..5e266486de1f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3826,7 +3826,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
 	cpumask_var_t mask;
 	int stragglers;
 	int group_size;
-	int i, j, cpu;
+	int i, start = 0, cpu;
 	int num_cpu;
 	int stride;
 
@@ -3840,16 +3840,18 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
 	stragglers = num_cpu >= vi->curr_queue_pairs ?
 			num_cpu % vi->curr_queue_pairs :
 			0;
-	cpu = cpumask_first(cpu_online_mask);
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		group_size = stride + (i < stragglers ? 1 : 0);
 
-		for (j = 0; j < group_size; j++) {
+		for_each_online_cpu_wrap(cpu, start) {
+			if (!group_size--)
+				break;
 			cpumask_set_cpu(cpu, mask);
-			cpu = cpumask_next_wrap(cpu, cpu_online_mask,
-						nr_cpu_ids, false);
 		}
+
+		start = cpu < nr_cpu_ids ? cpu + 1 : start;
+
 		virtqueue_set_affinity(vi->rq[i].vq, mask);
 		virtqueue_set_affinity(vi->sq[i].vq, mask);
 		__netif_set_xps_queue(vi->dev, cpumask_bits(mask), i, XPS_CPUS);
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 5cf69a110c1c..30042351f15f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1036,6 +1036,8 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
 
 #define for_each_possible_cpu_wrap(cpu, start)	\
 	for ((void)(start), (cpu) = 0; (cpu) < 1; (cpu)++)
+#define for_each_online_cpu_wrap(cpu, start)	\
+	for ((void)(start), (cpu) = 0; (cpu) < 1; (cpu)++)
 #else
 #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
 #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
@@ -1044,6 +1046,8 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
 
 #define for_each_possible_cpu_wrap(cpu, start)	\
 	for_each_cpu_wrap((cpu), cpu_possible_mask, (start))
+#define for_each_online_cpu_wrap(cpu, start)	\
+	for_each_cpu_wrap((cpu), cpu_online_mask, (start))
 #endif
 
 /* Wrappers for arch boot code to manipulate normally-constant masks */
-- 
2.43.0

