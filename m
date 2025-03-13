Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF81FDE02
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849325; cv=none; b=qe73iqkbvflWgDWhX6gcWYmHQAc5xqVbFINwatrFbfBxaO5sfOy2UhIrdPJZfZ6RIPph8qrym22vwuo7ZCZaq8CgcVf4aoVzZI7WuYkeU8A9tBboOWE0DLPH/LpHjfQSwdyxyFD65B0zgjGsK/Tli2V860FjopMX3TSPC5Y56Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849325; c=relaxed/simple;
	bh=HCjJw4xyhEzQ6zT8qCsmgUzt1olFBpZX2ZwL4amUYp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=pYSqpJmarWOp0x1xxy0QBFVF7Prae6eFT/uSNZPQYefyB8npVqy41T6kV6ui5EwS3GSSa9BGwDtKiuPjyKKAQOg1SNEcwiKwHBDTif6ycfhvOXzRQVDC73XXW82H1pPPxONYt8qgw1kjaBJPAC5Z7vzD5L0VCvd6SJhGI+Eo+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=mI6rotZO; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="mI6rotZO"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F20160EAD
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5lCKa-uy-ZK for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Mar 2025 07:02:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A31EE60D7B
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A31EE60D7B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=mI6rotZO
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A31EE60D7B
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:02 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so1113939a91.2
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849322; x=1742454122; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkGikd/Ad/tPfmKfWOKmNpfe6xZfSLW8Y3eIuF8D5nY=;
        b=mI6rotZOp1M5clbSUtyNF4oHCM0CC/B6oZGXCiEpjDG/5ftRhv4ognSLmiqXdd5FBO
         c2yGDqrmBVvH0vUX8YC/gGWlPJgERI0/A9zSAVNMfDARXuO9pOT54QF/KCPhZlILNs+W
         DHuRVsZ2Or6AXKoqfLsF8pSOuws7ZJ/Mdc4kwDzve9GjEd27xYzuR4qSKP9x9naF366Y
         bUguqovsiFlCUxmQioE4ujdXzZmLVr8apPNuJN45rNwONvtdPZBUdg5CmPnxmQ3jaR5b
         e/NjVoIc1NrJf4xTD3SKm/Mzovir907FWV5Ln7a0ONqhENrT1JmLm+WHz1mNtfddPh/m
         2xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849322; x=1742454122;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkGikd/Ad/tPfmKfWOKmNpfe6xZfSLW8Y3eIuF8D5nY=;
        b=mVKClixoHR+SaRo+4MjGOFnFTPLfI4SW9UACEqF8TEwT9Q06vxT28sKWb2fnIFVWHm
         pS+O+M5R9wXbZAnD1aVoql9OHSXMu0kcchb8dG9ZqEnh1yezFH+oUZDCzuQtkseCmBXu
         qKCo/n+xI4ZMda9bzrk6zgYOz2lql6a6zkQADLm4nJXqAbbu2bdMuc4Ow65rjtomExbu
         G9y5cdLDSP2wm0nmdYGbB9e6eXRUl+GFlxVPFmYOIeklROorfK/mTIduj7sesYvGV8Ql
         Rf71OaMOGpOHr+F7Hi0aSWFf+IQAI2Nz4sRljwvZpQqAGwCAa7zDyXIkGwsSBso4tZ0u
         REkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTc4PIyL/vBtmKOuTFvspaCRMZWaOoXcYNjhIdrF4kw88aER5aYc+dpy43xdkone0mupk+GpS4oJ8D8fBRYA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy9blxlbY+2tGmNg33eB5uXz/tPh3q6bKWe/vqRQn8drHqHO2k+
	uo+UAf5SsT2ZsCtD1P0e50JJNpmPf1U5rL3CWQbZYMNhNQr1VaJ2PQ+vfHcVmPI=
X-Gm-Gg: ASbGncu9kKVzBYyH4OhoUeiRfrSFw1MXDBmu5WT+7/0aJ2G9Ut7I4pMFffzs5XfpLCS
	f+fSj08cD4Z1VlMFij4aEDxMLQ03pU6PtphqxhO2GUEM4W5LOwJrkjGo5nAdZjMuw1N92QEiYzh
	RrHSygy7NeKuE8jJgUKy6Xgb+YmtjND6T4z2qOVIpIZlV/g2ehAFdWWy1w4gW+UyWOmSAwtXqT/
	raEyrazoCFHFsexcdDdPVI1OKNEWIyU3ixsaSuKcqGcDPOe0HnYpFi6ejcCxUsc6DD7Zo0EslKG
	wNccfF0LAuWaflrPOxlTZA1cZMOyo5j0pkl3M3ISavM5woUG
X-Google-Smtp-Source: AGHT+IHTpYDPSLT5yc7d72SDsCx1rUk7tGT6u0RLi/zmklDJcrhUC3W1KPTvb1y0wV1IhmZnoguH1A==
X-Received: by 2002:a17:90b:1c83:b0:2fe:a77b:d97e with SMTP id 98e67ed59e1d1-300ff0cadb2mr14806388a91.11.1741849321996;
        Thu, 13 Mar 2025 00:02:01 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3010342f135sm3173081a91.1.2025.03.13.00.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:02:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:09 +0900
Subject: [PATCH net-next v10 06/10] tap: Introduce virtio-net hash feature
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-6-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Add ioctls and storage required for the virtio-net hash feature to TAP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/if_tap.h |  2 ++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 25c60ff2d3f2..86b5e7b88614 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -49,6 +49,10 @@ struct major_info {
 	struct list_head next;
 };
 
+struct tap_skb_cb {
+	struct virtio_net_hash hash;
+};
+
 #define GOODCOPY_LEN 128
 
 static const struct proto_ops tap_socket_ops;
@@ -179,9 +183,20 @@ static void tap_put_queue(struct tap_queue *q)
 	sock_put(&q->sk);
 }
 
+static struct tap_skb_cb *tap_skb_cb(const struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct tap_skb_cb));
+	return (struct tap_skb_cb *)skb->cb;
+}
+
+static struct virtio_net_hash *tap_add_hash(struct sk_buff *skb)
+{
+	return &tap_skb_cb(skb)->hash;
+}
+
 static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
 {
-	return NULL;
+	return &tap_skb_cb(skb)->hash;
 }
 
 /*
@@ -194,6 +209,7 @@ static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
 static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 				       struct sk_buff *skb)
 {
+	struct flow_keys_basic keys_basic;
 	struct tap_queue *queue = NULL;
 	/* Access to taps array is protected by rcu, but access to numvtaps
 	 * isn't. Below we use it to lookup a queue, but treat it as a hint
@@ -201,17 +217,47 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 	 * racing against queue removal.
 	 */
 	int numvtaps = READ_ONCE(tap->numvtaps);
+	struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tap->vnet_hash);
 	__u32 rxq;
 
+	*tap_skb_cb(skb) = (struct tap_skb_cb) {
+		.hash = { .report = VIRTIO_NET_HASH_REPORT_NONE }
+	};
+
 	if (!numvtaps)
 		goto out;
 
 	if (numvtaps == 1)
 		goto single;
 
+	if (vnet_hash) {
+		if ((vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
+			rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
+			queue = rcu_dereference(tap->taps[rxq]);
+			goto out;
+		}
+
+		if (!skb->l4_hash && !skb->sw_hash) {
+			struct flow_keys keys;
+
+			skb_flow_dissect_flow_keys(skb, &keys, FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+			rxq = flow_hash_from_keys(&keys);
+			keys_basic = (struct flow_keys_basic) {
+				.control = keys.control,
+				.basic = keys.basic
+			};
+		} else {
+			skb_flow_dissect_flow_keys_basic(NULL, skb, &keys_basic, NULL, 0, 0, 0,
+							 FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+			rxq = skb->hash;
+		}
+	} else {
+		rxq = skb_get_hash(skb);
+	}
+
 	/* Check if we can use flow to select a queue */
-	rxq = skb_get_hash(skb);
 	if (rxq) {
+		tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
 		queue = rcu_dereference(tap->taps[rxq % numvtaps]);
 		goto out;
 	}
@@ -998,6 +1044,16 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		rtnl_unlock();
 		return ret;
 
+	case TUNGETVNETHASHCAP:
+		return tun_vnet_ioctl_gethashcap(argp);
+
+	case TUNSETVNETHASH:
+		rtnl_lock();
+		tap = rtnl_dereference(q->tap);
+		ret = tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, argp) : -EBADFD;
+		rtnl_unlock();
+		return ret;
+
 	case SIOCGIFHWADDR:
 		rtnl_lock();
 		tap = tap_get_tap_dev(q);
diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
index 553552fa635c..7334c46a3f10 100644
--- a/include/linux/if_tap.h
+++ b/include/linux/if_tap.h
@@ -31,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
 #define MAX_TAP_QUEUES 256
 
 struct tap_queue;
+struct tun_vnet_hash_container;
 
 struct tap_dev {
 	struct net_device	*dev;
@@ -43,6 +44,7 @@ struct tap_dev {
 	int			numqueues;
 	netdev_features_t	tap_features;
 	int			minor;
+	struct tun_vnet_hash_container __rcu *vnet_hash;
 
 	void (*update_features)(struct tap_dev *tap, netdev_features_t features);
 	void (*count_tx_dropped)(struct tap_dev *tap);

-- 
2.48.1

