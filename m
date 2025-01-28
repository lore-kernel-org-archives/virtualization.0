Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE81DE3C9
	for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082817; cv=none; b=Un8Z+tlh4vpqo8b6dwL2LTJ1ACHQ5pS9PrHZxMLgDKSP/DPJlRCKr5ucAfO+cV9bY3XV3O7sHGxfruxOZ/0ZCrcT40XVLbWDbdSNLAPcdgDHdwITq86i7AoAipJyNSKTiUl5Ob/3pTi2qfo6rS3jWmImmTO9cVgwuVYgOdlCJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082817; c=relaxed/simple;
	bh=fY1Ht0lNOAKw8K5OedtmKPz5PbDJBPdWABo+iz3tz/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuUnxtnD0fcjli0r5zrSiFmKh8mYE7HCxPSbCwqPJU8TOhacHSnzSkFl+EDkq0f6pQoaZ42vFHF/lC6ZivfAJvwc8HWYeKalUCAWh2ck7T6NtHQ7vyhfFLJCYaGkXWQs0HIWUPmnyF1pwFDNP+HmYd2/Ygje9Raj7hLdwlFZPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAsdejvN; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAsdejvN"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e549be93d5eso10374617276.1
        for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082815; x=1738687615; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izBUo6HsqfmU6F4r4wLj8SjU7ULP/X7gCkrYK1n4Pjw=;
        b=nAsdejvNDgJnMXDBpQXqeHhvYJR2DiYC6L4X9NNgsQQGazKC1P5V2bxT5f6s5pSI0u
         J87Zwv6A6OsU7rHGTnilAwnrb9eqaEkXvqD+q4808xHmRmlXZ8rYieqJGVA8Ns82+Ese
         QKo5W4h8xVStQrGj+2ks4yUDGareC/ogdzdJe4FnKetGl4ZpL/6tQXtG0AvEXOAHkP75
         34/rvdlkorRIkpqb0NZiEEbLcjUNOPZ8PMiIvoKANCsMMcEhlkbZQhmnPnQTvjJ+VulM
         69EN3DeJo0H65u63RY3/eSPUriayXf0dSDaZGMPi/WcKqwisueSi0z4aMIIayKneMXmg
         Ophw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082815; x=1738687615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izBUo6HsqfmU6F4r4wLj8SjU7ULP/X7gCkrYK1n4Pjw=;
        b=oLUyKIYrrWAnQ4RVI8JdnfI6ywQBsiFjxQmFMAJc36CDs/r8NJTC49ZPESEMcrEs3m
         QtPeVIR0FGJChTekl5hn37RlN1yAkaxRz+ez4kLGxx7luY8OMV4E6oxaWzjJq8URwoQk
         hQZBJp5DDOoEWv4rNWeU5ipfAA4EYpHAUS/QYFqzkdaxvw47Uc86kpgFFOZa4kuKYILP
         Z7oTjzs0+C4j+/ZMaGFxrgarrDhzHQazBqM+iiDW0dPWpJnffK6U2KKknuuZieN8dVAG
         XOA6RcRKLNz3jN5QGu1+QrXxASWBILHiPq2nyTWdCamP5qWXjKE29lTpPJL0nxvjVUiQ
         010g==
X-Forwarded-Encrypted: i=1; AJvYcCXIiHoA44506y2P4P2fNz64jppIUhxw9UnwewAv8CdGMzwR4FlZaRrgmpPrtdTo7uRCDsTbNnum6KsO00F1aw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxy93PIrDNX6CGRLUPZbY4My44+h1GT9IDSqJF7q0deIQpmZ016
	eHyUgMRDdVkyAgiUDPkvso8cTA1KVBCdx48/ZRE7YWKySFUP37mR
X-Gm-Gg: ASbGnct5i5fAKR9+RRvp4JRKMqk6PQOrx+qxYF0q7CKlOFX3Hy1xDY+QQIqtqLInThP
	oUWQ8rayFO1eiLA54MAqQ1X1bs3KLE32RGoc9c5KHUklixYtbYn4bZSpyOoQiGSzc1rK3sa94fA
	aPe/lMLt95tSFhXQHg2gwZMPZdYR/0bSo6cjpBKRheKa68QCUw+pVlQ6I17W59XKKY2ucvdof/2
	I/vO3TwqUJF5jfALEIe6Deaz/8tkSgE0sDnWvCxi17pwwZHgRakzyO/RdEgIl5lTGzIOscSSD3z
	QabBmlgDWkYBVZGWn8kk9SLlv7PO/83uUqqXFREaKBr4wQzsYwo=
X-Google-Smtp-Source: AGHT+IHc113oUWa4lQB5S7fsBtzpiuhJaSRgwEzNaVPqu/U+wdu2NqhKKZn6+Jf4YhXOVOV+JKbd/g==
X-Received: by 2002:a05:690c:9681:b0:6f5:393f:cf48 with SMTP id 00721157ae682-6f6eb684324mr340143727b3.21.1738082814734;
        Tue, 28 Jan 2025 08:46:54 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a00e4asm19752577b3.73.2025.01.28.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:46:54 -0800 (PST)
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
	Paolo Abeni <pabeni@redhat.com>,
	Nick Child <nnac123@linux.ibm.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 02/13] virtio_net: simplify virtnet_set_affinity()
Date: Tue, 28 Jan 2025 11:46:31 -0500
Message-ID: <20250128164646.4009-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
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

CC: Nick Child <nnac123@linux.ibm.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/virtio_net.c | 12 +++++++-----
 include/linux/cpumask.h  |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..9d7c37e968b5 100644
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
+			if (!group_size--) {
+				start = cpu;
+				break;
+			}
 			cpumask_set_cpu(cpu, mask);
-			cpu = cpumask_next_wrap(cpu, cpu_online_mask,
-						nr_cpu_ids, false);
 		}
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

