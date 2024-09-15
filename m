Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0CFDDDC
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363211; cv=none; b=hQDJ+ZpjkvVk4pBeuJ9toi1yDs1t1SZVWZ/r6mJlZsKLUOi75FArb8frSMFClAhCn2EI6S08nE1phCu1AIxyb8y0TJ86xSWk7s8h6osEZlvTFq+bPED7ZdyHrk3Z5zEUBgoc9ZHilqmNmv5ShWEpwQwY3xAL4XbqAWZh5X31RvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363211; c=relaxed/simple;
	bh=WmBSaC/QSbjobyoahXyzvbyjUk5hRznJbyxtyhVOrGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=hJ7/raNYBY5BTzHwMTki6ayhOD3HGfYYfR+4yNLBB77l4icQKSSQtwgRPx1sn+k071GbOBIMaQSMJDv+6cgvSYOxjQhy9ntj+egz4tN6SpDoc9/9jSSfimXYcPXRhAnsgJfzie6QRGPnBb14CgPdlVyr+0wc0h4Ro79bPZkrPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=fjpShsjS; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fjpShsjS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0258400F1
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fVACPzNQGhlq for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 01:20:08 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F396C40204
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F396C40204
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fjpShsjS
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F396C40204
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:20:07 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2d877dab61fso1506764a91.3
        for <virtualization@lists.linux-foundation.org>; Sat, 14 Sep 2024 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363207; x=1726968007; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYyQLQOeFQUpiZoKosJFqYZWB+Aa4MJVtAn2xVSJv2M=;
        b=fjpShsjSd8fn1hvRPuS0adpjaotisWMeiIBeNq7dJAXSgCe3vVrqmAKAHqX5O1Puzq
         dXN8GZ9aZ0fLcKKao1LWgUI/uDoowqCDTkL5r7X6KkxsTAvCIn3Lld8Qcb9dUMACbiv/
         HHl4YrTyDZufC2PxGJ6BeFJ73t7A38WNbbpKtzWKDHV2KZM+5nn61yVAF1yrCX5ArrnG
         4JLSWz0PO5baNls+jr0MEObE1uBUFhXWl+TiNqCX+/2I5u7CCG7ixSXVDkq/31dyDjIc
         RLZLBnYD/DFUBb8VNFi/AQY51LsVwqgCs2fS2SKmtIsdQaVBXDh/ioUKqcVUB9ys1D+f
         vYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363207; x=1726968007;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYyQLQOeFQUpiZoKosJFqYZWB+Aa4MJVtAn2xVSJv2M=;
        b=qwdojeYtnP+hLOLGtVa7yc6z8gRiWtObOFZsQjvv9qOIv1iNqM3Ddev6UEuW69HQCW
         oWyKlvy+q80ttuFkdaSzpX3t7zUfbkHoFNWeXwxoiz3Y5vUUTC7ncrTLdM9DQ946/HqO
         pEQHvo7GdcQ8zSObcYZRE19NtBkZSiYauP5HzxYw9Jv8RyJctw0VLh1WBwrU4H4A7IIL
         PMtHA9WYZV07KtvwLMsn+TpkjI9C2tw1d6do9RO6woRdZYTSYEaR67gIcmuhJhDRhWGK
         J2uhE9ft3M+rFt0G65OGnzBOazdEaDySbKEyYznBPeIKW2DBgHqKtrQuqPAVb7f5z7M5
         FzKw==
X-Forwarded-Encrypted: i=1; AJvYcCVcfanmu72RFAJSah4z1EbikdbysQeI0W9xL0sB2HqYCklk09e8GykQhnc+MEkCBwZLEloQijcCRyD986ZIYA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx1Tb/murLe34cxuYBypGom9dO/gcBAF6MquTouMbvUcPUKeBKo
	vTNJLxW59RJ0eS3GGX5FSXptdPYG+svcZeMRACaaYloF8sTW/tVtycwlXCHBhug=
X-Google-Smtp-Source: AGHT+IGyUfC3/ABtY9/wIl+W6Qg+BNPReG5FAyawSqjluEKUCPEWa7sstjTnvfK0g1w76208slgCjQ==
X-Received: by 2002:a17:90b:3ec1:b0:2d8:ebef:547 with SMTP id 98e67ed59e1d1-2dbb9f08b33mr9461616a91.35.1726363207168;
        Sat, 14 Sep 2024 18:20:07 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2dbcfcbadd0sm2227646a91.11.2024.09.14.18.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:20:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:46 +0900
Subject: [PATCH RFC v3 7/9] tun: Introduce virtio-net RSS
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-7-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

RSS is a receive steering algorithm that can be negotiated to use with
virtio_net. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF steering program.

Introduce the code to perform RSS to the kernel in order to overcome
thse challenges. An alternative solution is to extend the eBPF steering
program so that it will be able to report to the userspace, but I didn't
opt for it because extending the current mechanism of eBPF steering
program as is because it relies on legacy context rewriting, and
introducing kfunc-based eBPF will result in non-UAPI dependency while
the other relevant virtualization APIs such as KVM and vhost_net are
UAPIs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c           | 119 +++++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/if_tun.h |  27 ++++++++++
 2 files changed, 133 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b8fcd71becac..5a429b391144 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -175,6 +175,9 @@ struct tun_prog {
 
 struct tun_vnet_hash_container {
 	struct tun_vnet_hash common;
+	struct tun_vnet_hash_rss rss;
+	__be32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+	u16 rss_indirection_table[];
 };
 
 /* Since the socket were moved to tun_file, to preserve the behavior of persist
@@ -227,7 +230,7 @@ struct veth {
 };
 
 static const struct tun_vnet_hash tun_vnet_hash_cap = {
-	.flags = TUN_VNET_HASH_REPORT,
+	.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
 	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
 };
 
@@ -591,6 +594,36 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return ret % numqueues;
 }
 
+static u16 tun_vnet_rss_select_queue(struct tun_struct *tun,
+				     struct sk_buff *skb,
+				     const struct tun_vnet_hash_container *vnet_hash)
+{
+	struct tun_vnet_hash_ext *ext;
+	struct virtio_net_hash hash;
+	u32 numqueues = READ_ONCE(tun->numqueues);
+	u16 txq, index;
+
+	if (!numqueues)
+		return 0;
+
+	if (!virtio_net_hash_rss(skb, vnet_hash->common.types, vnet_hash->rss_key,
+				 &hash))
+		return vnet_hash->rss.unclassified_queue % numqueues;
+
+	if (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) {
+		ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
+		if (ext) {
+			ext->value = hash.value;
+			ext->report = hash.report;
+		}
+	}
+
+	index = hash.value & vnet_hash->rss.indirection_table_mask;
+	txq = READ_ONCE(vnet_hash->rss_indirection_table[index]);
+
+	return txq % numqueues;
+}
+
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev)
 {
@@ -603,7 +636,10 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	} else {
 		struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
 
-		ret = tun_automq_select_queue(tun, skb, vnet_hash);
+		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS))
+			ret = tun_vnet_rss_select_queue(tun, skb, vnet_hash);
+		else
+			ret = tun_automq_select_queue(tun, skb, vnet_hash);
 	}
 	rcu_read_unlock();
 
@@ -3085,13 +3121,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
 }
 
 static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
-			void __user *data)
+			int fd)
 {
 	struct bpf_prog *prog;
-	int fd;
-
-	if (copy_from_user(&fd, data, sizeof(fd)))
-		return -EFAULT;
 
 	if (fd == -1) {
 		prog = NULL;
@@ -3157,6 +3189,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int ifindex;
 	int sndbuf;
 	int vnet_hdr_sz;
+	int fd;
 	int le;
 	int ret;
 	bool do_notify = false;
@@ -3460,11 +3493,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case TUNSETSTEERINGEBPF:
-		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
+		if (get_user(fd, (int __user *)argp)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		vnet_hash = rtnl_dereference(tun->vnet_hash);
+		if (fd != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
+			ret = -EBUSY;
+			break;
+		}
+
+		ret = tun_set_ebpf(tun, &tun->steering_prog, fd);
 		break;
 
 	case TUNSETFILTEREBPF:
-		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
+		if (get_user(fd, (int __user *)argp)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = tun_set_ebpf(tun, &tun->filter_prog, fd);
 		break;
 
 	case TUNSETCARRIER:
@@ -3496,10 +3545,54 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 
-		vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
-		if (!vnet_hash) {
-			ret = -ENOMEM;
-			break;
+		if (vnet_hash_common.flags & TUN_VNET_HASH_RSS) {
+			struct tun_vnet_hash_rss rss;
+			size_t indirection_table_size;
+			size_t key_size;
+			size_t size;
+
+			if (tun->steering_prog) {
+				ret = -EBUSY;
+				break;
+			}
+
+			if (copy_from_user(&rss, argp, sizeof(rss))) {
+				ret = -EFAULT;
+				break;
+			}
+			argp = (struct tun_vnet_hash_rss __user *)argp + 1;
+
+			indirection_table_size = ((size_t)rss.indirection_table_mask + 1) * 2;
+			key_size = virtio_net_hash_key_length(vnet_hash_common.types);
+			size = sizeof(*vnet_hash) + indirection_table_size + key_size;
+
+			vnet_hash = kmalloc(size, GFP_KERNEL);
+			if (!vnet_hash) {
+				ret = -ENOMEM;
+				break;
+			}
+
+			if (copy_from_user(vnet_hash->rss_indirection_table,
+					   argp, indirection_table_size)) {
+				kfree(vnet_hash);
+				ret = -EFAULT;
+				break;
+			}
+			argp = (u16 __user *)argp + rss.indirection_table_mask + 1;
+
+			if (copy_from_user(vnet_hash->rss_key, argp, key_size)) {
+				kfree(vnet_hash);
+				ret = -EFAULT;
+				break;
+			}
+
+			vnet_hash->rss = rss;
+		} else {
+			vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
+			if (!vnet_hash) {
+				ret = -ENOMEM;
+				break;
+			}
 		}
 
 		vnet_hash->common = vnet_hash_common;
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 1561e8ce0a0a..1c130409db5d 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -75,6 +75,14 @@
  *
  * The argument is a pointer to &struct tun_vnet_hash.
  *
+ * The argument is a pointer to the compound of the following in order if
+ * %TUN_VNET_HASH_RSS is set:
+ *
+ * 1. &struct tun_vnet_hash
+ * 2. &struct tun_vnet_hash_rss
+ * 3. Indirection table
+ * 4. Key
+ *
  * %TUNSETVNETHDRSZ ioctl must be called with a number greater than or equal to
  * the size of &struct virtio_net_hdr_v1_hash before calling this ioctl with
  * %TUN_VNET_HASH_REPORT.
@@ -144,6 +152,13 @@ struct tun_filter {
  */
 #define TUN_VNET_HASH_REPORT	0x0001
 
+/**
+ * define TUN_VNET_HASH_RSS - Request virtio_net RSS
+ *
+ * This is mutually exclusive with eBPF steering program.
+ */
+#define TUN_VNET_HASH_RSS	0x0002
+
 /**
  * struct tun_vnet_hash - virtio_net hashing configuration
  * @flags:
@@ -159,4 +174,16 @@ struct tun_vnet_hash {
 	__u32 types;
 };
 
+/**
+ * struct tun_vnet_hash_rss - virtio_net RSS configuration
+ * @indirection_table_mask:
+ *		Bitmask to be applied to the indirection table index
+ * @unclassified_queue:
+ *		The index of the queue to place unclassified packets in
+ */
+struct tun_vnet_hash_rss {
+	__u16 indirection_table_mask;
+	__u16 unclassified_queue;
+};
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.46.0

