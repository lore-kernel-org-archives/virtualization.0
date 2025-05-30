Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921C1EC01B
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580655; cv=none; b=t6Y8VZOkifKPaihjw3E9Y6FrerLPMcNyAtkQ65euoRMDA0qJ56WYS+o5NozfXbAiDTQUkAYlUcg+Lg/8WlJxSiSnyQlHTt1j/BOENT4EgUH8BknwdieH9pRvN2KN8F4/7kVQt8a7PgVT0cx+x3Nzp2duLfAHG4iEcWGl64yAtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580655; c=relaxed/simple;
	bh=A8mykslZWwIG4FNXV3Lm1NuXd/xH3TVuhPhWYtSjv/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Ybmxfj1Yrs84HfOeJyGVB5F38OR5rYwsoO7VTgjc+N1xYys7dC5nwJp2OD6trmWSvZslp5V7pUrP/Lhp5lQ1ueDY255/ZaCB0fap2rUfujP4l1wgxvXpoUDB8TEY9sTtgnJN11kbFp/IbtaWiWuzI6Ta1CuwCVuMSEzGuoiAq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=V7hbcXA/; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="V7hbcXA/"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE5CF60EC4
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xDwzp2Jg5q8B for <virtualization@lists.linux-foundation.org>;
 Fri, 30 May 2025 04:50:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E1B216066C
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1B216066C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=V7hbcXA/
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1B216066C
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:52 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2352e3db62cso3706405ad.2
        for <virtualization@lists.linux-foundation.org>; Thu, 29 May 2025 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580652; x=1749185452; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G36+4ZP77wTYjNEOu/qcKvp0kJ+h6b0T8zIdMEmaFXg=;
        b=V7hbcXA/kp1OlmdfPouIJUeFGxv3/X+HWY8IinKptE6JFiX8tJFNyxBSIO+hKofbuo
         elEX4duOJdVSuSoZTXgG+DJf72qJ79WQb+146a1q7AkUzGFiojbN/MhzE4LecNMtO7Do
         aRvTGlSTk5QOKKOSj6dxDzooGnM0CJMGXfUkPBcv6VL/7RiJT7zOct3bBRSm5MASVHbj
         vX7KcSqIYtMzv6guamHpbret8EWS67eIabUsCVisYO+Y4XCv8LprBM6u4X7LzKhhjqwi
         97Nm+nXO1eUsRgdMcAojeoYt8wxR++7fqqqojbecZh9WLD39zK2FdEwFyOmFbSnLUndd
         CgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580652; x=1749185452;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G36+4ZP77wTYjNEOu/qcKvp0kJ+h6b0T8zIdMEmaFXg=;
        b=edQocai46RBFu9DAmC04HsLJc4aV/oYRwxWeUH6d+xa1ao/lXLxm3EsN/w2yFexC/G
         VirbqpQjBXBJhj/Eo850LmZtkkPRKiCV4+bgleXpSEhXXpWiAObO1jRnH8Itw9uadYrd
         3tPm5JCh/0o1RS1tRl+YukU4FTZ2uSY/CJl8X2ruvHegR4ez6qcnyAMqmfFy/uwySC2k
         fxEqG04ONLxJ90gg3SzaR3zfv37VhZ4Q+1JewTuamLaXgk1fB5lUj1B0h+fnCxQ2jmuR
         SvTmIzdBU0feezU0wzcX6uggxbSfvAu6Cau6FS+cCcQ+7uobEcszBXdmxi8QiFXv/Nlf
         tSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLqTy7IdfP3GXY+TrBA2GBo/of6ON0ZYjND6kJlMxOhVlwzsz4V5wk5x71wIrsqeRGD9AiP8J2T+sIvKpTMg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyTykGoqHtG6p7HpqP0Ub0Q1dt5z7wG2NzCMsuUMIrGvAg1gafq
	b852FuTM+4phCV24jNJ6CbmlACTpHWf8ZYVEZLogc9RGJtGYfent2vU1Kz/QlvMOdyg=
X-Gm-Gg: ASbGncsvyGiRIJBkBGb5OnTwbXhXaK0o2DiKmYwlDVQvbz6OoDP5/zXwiDyguAoKqw6
	N+3ueIxIsC/RaUh2Ydfq64P/tbOAEM6M+ljvijpI4wpkJNNgjYiFQeXH8zidxgg1FptGN/RELsG
	k8uunqR6WWxmUhUeBDNpMSjJkpVMDPu1qJYiugoHiKtpgWTnuwMoSOEd94KDEGdcvHzNZZuwAIX
	KHyB0b4Lt3tNpYGTCNR+Esboo77MN/zU5arsI6jtpVB/xk6ZnvCApy5J2WccBXawYznE8yRxP9q
	bntzyEqVck/MpSYDsAgdgqexcmrP17JAv9WCukhphloK9t7Wl3vWSPYAC3XB7KI=
X-Google-Smtp-Source: AGHT+IGEoKVWjQvlEBQztN2LsXcTxfvwZkaCujBOiYLFoWDDJ4OZ1o9Irvn0v8iXfsBShaZWmZtyaw==
X-Received: by 2002:a17:902:d4cd:b0:234:f580:9f5 with SMTP id d9443c01a7336-235289c818bmr28919365ad.9.1748580652210;
        Thu, 29 May 2025 21:50:52 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cd342dsm20124795ad.148.2025.05.29.21.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:10 +0900
Subject: [PATCH net-next v12 06/10] tap: Introduce virtio-net hash feature
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-6-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
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
 drivers/net/ipvlan/ipvtap.c |  2 +-
 drivers/net/macvtap.c       |  2 +-
 drivers/net/tap.c           | 72 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/if_tap.h      |  4 ++-
 4 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 1afc4c47be73..305438abf7ae 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -114,7 +114,7 @@ static void ipvtap_dellink(struct net_device *dev,
 	struct ipvtap_dev *vlan = netdev_priv(dev);
 
 	netdev_rx_handler_unregister(dev);
-	tap_del_queues(&vlan->tap);
+	tap_del(&vlan->tap);
 	ipvlan_link_delete(dev, head);
 }
 
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 29a5929d48e5..e72144d05ef4 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -122,7 +122,7 @@ static void macvtap_dellink(struct net_device *dev,
 	struct macvtap_dev *vlantap = netdev_priv(dev);
 
 	netdev_rx_handler_unregister(dev);
-	tap_del_queues(&vlantap->tap);
+	tap_del(&vlantap->tap);
 	macvlan_dellink(dev, head);
 }
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 25c60ff2d3f2..15f056d7f632 100644
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
+	struct tun_vnet_hash *vnet_hash = rcu_dereference(tap->vnet_hash);
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
+		if (vnet_hash->rss) {
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
@@ -234,10 +280,10 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
 
 /*
  * The net_device is going away, give up the reference
- * that it holds on all queues and safely set the pointer
- * from the queues to NULL.
+ * that it holds on all queues, safely set the pointer
+ * from the queues to NULL, and free vnet_hash.
  */
-void tap_del_queues(struct tap_dev *tap)
+void tap_del(struct tap_dev *tap)
 {
 	struct tap_queue *q, *tmp;
 
@@ -254,8 +300,10 @@ void tap_del_queues(struct tap_dev *tap)
 	BUG_ON(tap->numqueues);
 	/* guarantee that any future tap_set_queue will fail */
 	tap->numvtaps = MAX_TAP_QUEUES;
+
+	kfree_rcu_mightsleep(rtnl_dereference(tap->vnet_hash));
 }
-EXPORT_SYMBOL_GPL(tap_del_queues);
+EXPORT_SYMBOL_GPL(tap_del);
 
 rx_handler_result_t tap_handle_frame(struct sk_buff **pskb)
 {
@@ -998,6 +1046,18 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		rtnl_unlock();
 		return ret;
 
+	case TUNGETVNETHASHTYPES:
+		return tun_vnet_ioctl_gethashtypes(argp);
+
+	case TUNSETVNETREPORTINGAUTOMQ:
+	case TUNSETVNETREPORTINGRSS:
+	case TUNSETVNETRSS:
+		rtnl_lock();
+		tap = rtnl_dereference(q->tap);
+		ret = tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, cmd, argp) : -EBADFD;
+		rtnl_unlock();
+		return ret;
+
 	case SIOCGIFHWADDR:
 		rtnl_lock();
 		tap = tap_get_tap_dev(q);
diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
index 553552fa635c..6647a7a9e956 100644
--- a/include/linux/if_tap.h
+++ b/include/linux/if_tap.h
@@ -31,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
 #define MAX_TAP_QUEUES 256
 
 struct tap_queue;
+struct tun_vnet_hash;
 
 struct tap_dev {
 	struct net_device	*dev;
@@ -43,6 +44,7 @@ struct tap_dev {
 	int			numqueues;
 	netdev_features_t	tap_features;
 	int			minor;
+	struct tun_vnet_hash __rcu *vnet_hash;
 
 	void (*update_features)(struct tap_dev *tap, netdev_features_t features);
 	void (*count_tx_dropped)(struct tap_dev *tap);
@@ -74,7 +76,7 @@ struct tap_queue {
 };
 
 rx_handler_result_t tap_handle_frame(struct sk_buff **pskb);
-void tap_del_queues(struct tap_dev *tap);
+void tap_del(struct tap_dev *tap);
 int tap_get_minor(dev_t major, struct tap_dev *tap);
 void tap_free_minor(dev_t major, struct tap_dev *tap);
 int tap_queue_resize(struct tap_dev *tap);

-- 
2.49.0

