Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5A1DDC3F
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014956; cv=none; b=SahYRwxRlB8eyB41WrrOZfcaP15mxNMFXT3gLtUwD7oeeP99fgBw7/IVvkhLPFhmPLMjUxOJpEx36B26CZ9kwpzZ+pCNGoN3sZP85vPMheZTpxTQ3HIbTqJaPAPioAzhnncVJI7ak0gyImYU3AZ1mRNdYCVzWE5+5IazFPBI9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014956; c=relaxed/simple;
	bh=dlMaXnHmVF0I2Zg/+PIxqJ41UeI7IEme3DeBp0QrHII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Rr0twQSLaHitj2DHzpMPHl3Nt+G5OQAAymdOvdyqbecduua7yMmlHZIq1SJk3eta+2TZrTL9IABACEZmhPHX7Up5OfTSA6h1ND6t7j41g4SxotfsJ3dYpCLhhuPOOYoDlIjIH6CwzBjyHxyd7RWlPgW9qZMxXz0t7YPhrB/YZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=t/iKfoiW; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="t/iKfoiW"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6671984B5D
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kw5eFNNG7D_a for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 08:09:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 62F7084B5C
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62F7084B5C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=t/iKfoiW
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 62F7084B5C
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:12 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21670dce0a7so13196055ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 00:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014952; x=1737619752; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTB21hQ3QbIZ1GVa5XRt1Vyvjby7SpDJyzR3ERjrdhY=;
        b=t/iKfoiW/grq/24AMVvf4NuvmFqGbHNrF0pNIor3OMsTU4PZdb0Xty3YO+ZrkjwgVp
         LQKztENqo4Y6EjhLCkoeWtKON0qblC7fN6HCuwGgP7H8ysmsKku2nrECqJ6PY2j6zGy7
         abeYujbKbLbJwjQsb3q+De6Y4IvzurI+HbGtTALfzlp2KasGlPKHuryRsg18nM4YXBl2
         gyfFLQUlbGG7k8DVxCUhv5W+bYLxogNCZP39Y8jF5JUwxhM0LZX19RALoxwbw5HGE6LL
         vRZZ6DIzVqve49CpI3Yo7VVnEGJnG5MObHdk2Dw3Gmg6y686n6zBFNFj6fBDABg1oduZ
         nEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014952; x=1737619752;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTB21hQ3QbIZ1GVa5XRt1Vyvjby7SpDJyzR3ERjrdhY=;
        b=J77vcYWURrCYT0+wlrwJ4v4gAPpFO0VLvJ+IBRUZ9LzMbkDgD1Lo99Rx8iBcR/EsOr
         m8x2imNNJhlKOh563MSj3GwwE6gSn3R8xA0O45D++DG/xEh9ImOeDoOxrfY0Z3SQIAbZ
         FtkUHfubLeQ8TZymRX19Y4dBvLIkbHazNk0vbIqc/Ys0sd+QSPosonauJzbjT9aDof+L
         cQbUyvj0cYxDLf7DaK+FR95UsGF9AE5p/5UZKx6/jnD6ev5Lyav3cVYUxunm570k/uZ9
         sbh3n5hvTXKrkSHkPp2cph3quzAP2pLHR5AUUtME2fwgd8m6YSUZf32Mo/NXXKMmTHA2
         RIWA==
X-Forwarded-Encrypted: i=1; AJvYcCUGOi90MmLlwCqF90OSSWCqqtn8+w/9UT3o2Om6Y9dK7poiJ/BlDa+IF3LShJFtKDj0TgKlMH6JBdfye5TN9g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwvvRilRNRvzi5gVDqvGuTzIBAurSPNWjuW/IO6IzqZVSy8NnjO
	DY5JMLgJ/1j+2GKSrMUNEass4nhHl8lW4NRN9ZKLGGjAd8aX5WQnqXj2EoHs9io=
X-Gm-Gg: ASbGncsknnedxjv3Kvq70/fSstAXVu5E3VArnFmq+qWs+9nTS1i1shHScfU3QHyymuF
	3jekRdaF77rPxCRn8R3LgRB6VuwAHMmK69a8EX+j0g3FiW2NbCJFPYmeXc0WMY5Cno0ckXEPmF9
	OP9v+6KTIO1VCyZl2YXeoySJGrH/8/0Y76dg0gt+DLdLf5CaVCQNhUqQmsrELBQWkp7gViSJV3V
	EvPdT+EFr1Oqu2RDzSiS4+4xrJJyE/Cob1lKh6LmcMsDiRE646wj2k4Yrs=
X-Google-Smtp-Source: AGHT+IGyfHvFQkE+nB1o/CJ0GNwG1fqSgXmY086Vq0Qo1fUXVryET5W7oD5W9XOC903obMvquEVrHw==
X-Received: by 2002:a05:6a00:418e:b0:727:3b77:4174 with SMTP id d2e1a72fcca58-72d22032685mr46595151b3a.23.1737014951264;
        Thu, 16 Jan 2025 00:09:11 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a31d5da4f97sm10774264a12.55.2025.01.16.00.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:09:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:08 +0900
Subject: [PATCH net v3 5/9] tun: Decouple vnet handling
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-5-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
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
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

Decouple the vnet handling code so that we can reuse it for tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 229 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 133 insertions(+), 96 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index add09dfdada5..1f4a066ad2f0 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -351,6 +351,122 @@ static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
 	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
 }
 
+static long tun_vnet_ioctl(int *sz, unsigned int *flags,
+			   unsigned int cmd, int __user *sp)
+{
+	int s;
+
+	switch (cmd) {
+	case TUNGETVNETHDRSZ:
+		s = *sz;
+		if (put_user(s, sp))
+			return -EFAULT;
+		return 0;
+
+	case TUNSETVNETHDRSZ:
+		if (get_user(s, sp))
+			return -EFAULT;
+		if (s < (int)sizeof(struct virtio_net_hdr))
+			return -EINVAL;
+
+		*sz = s;
+		return 0;
+
+	case TUNGETVNETLE:
+		s = !!(*flags & TUN_VNET_LE);
+		if (put_user(s, sp))
+			return -EFAULT;
+		return 0;
+
+	case TUNSETVNETLE:
+		if (get_user(s, sp))
+			return -EFAULT;
+		if (s)
+			*flags |= TUN_VNET_LE;
+		else
+			*flags &= ~TUN_VNET_LE;
+		return 0;
+
+	case TUNGETVNETBE:
+		return tun_get_vnet_be(*flags, sp);
+
+	case TUNSETVNETBE:
+		return tun_set_vnet_be(flags, sp);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
+			    struct virtio_net_hdr *hdr)
+{
+	if (iov_iter_count(from) < sz)
+		return -EINVAL;
+
+	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
+		return -EFAULT;
+
+	if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
+	    tun16_to_cpu(flags, hdr->csum_start) + tun16_to_cpu(flags, hdr->csum_offset) + 2 > tun16_to_cpu(flags, hdr->hdr_len))
+		hdr->hdr_len = cpu_to_tun16(flags, tun16_to_cpu(flags, hdr->csum_start) + tun16_to_cpu(flags, hdr->csum_offset) + 2);
+
+	if (tun16_to_cpu(flags, hdr->hdr_len) > iov_iter_count(from))
+		return -EINVAL;
+
+	iov_iter_advance(from, sz - sizeof(*hdr));
+
+	return tun16_to_cpu(flags, hdr->hdr_len);
+}
+
+static int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
+			    const struct virtio_net_hdr *hdr)
+{
+	if (unlikely(iov_iter_count(iter) < sz))
+		return -EINVAL;
+
+	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
+		return -EFAULT;
+
+	iov_iter_advance(iter, sz - sizeof(*hdr));
+
+	return 0;
+}
+
+static int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
+			       const struct virtio_net_hdr *hdr)
+{
+	return virtio_net_hdr_to_skb(skb, hdr, tun_is_little_endian(flags));
+}
+
+static int tun_vnet_hdr_from_skb(unsigned int flags,
+				 const struct net_device *dev,
+				 const struct sk_buff *skb,
+				 struct virtio_net_hdr *hdr)
+{
+	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
+
+	if (virtio_net_hdr_from_skb(skb, hdr,
+				    tun_is_little_endian(flags), true,
+				    vlan_hlen)) {
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		if (net_ratelimit()) {
+			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+				   sinfo->gso_type, tun16_to_cpu(flags, hdr->gso_size),
+				   tun16_to_cpu(flags, hdr->hdr_len));
+			print_hex_dump(KERN_ERR, "tun: ",
+				       DUMP_PREFIX_NONE,
+				       16, 1, skb->head,
+				       min(tun16_to_cpu(flags, hdr->hdr_len), 64), true);
+		}
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static inline u32 tun_hashfn(u32 rxhash)
 {
 	return rxhash & TUN_MASK_FLOW_ENTRIES;
@@ -1763,22 +1879,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (tun->flags & IFF_VNET_HDR) {
 		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
-		int flags = tun->flags;
-
-		if (iov_iter_count(from) < vnet_hdr_sz)
-			return -EINVAL;
-
-		if (!copy_from_iter_full(&gso, sizeof(gso), from))
-			return -EFAULT;
 
-		if ((gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		    tun16_to_cpu(flags, gso.csum_start) + tun16_to_cpu(flags, gso.csum_offset) + 2 > tun16_to_cpu(flags, gso.hdr_len))
-			gso.hdr_len = cpu_to_tun16(flags, tun16_to_cpu(flags, gso.csum_start) + tun16_to_cpu(flags, gso.csum_offset) + 2);
-
-		if (tun16_to_cpu(flags, gso.hdr_len) > iov_iter_count(from))
-			return -EINVAL;
-		hdr_len = tun16_to_cpu(flags, gso.hdr_len);
-		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
+		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
+		if (hdr_len < 0)
+			return hdr_len;
 	}
 
 	len = iov_iter_count(from);
@@ -1854,7 +1958,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 	}
 
-	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun->flags))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2049,18 +2153,15 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 {
 	int vnet_hdr_sz = 0;
 	size_t size = xdp_frame->len;
-	size_t ret;
+	ssize_t ret;
 
 	if (tun->flags & IFF_VNET_HDR) {
 		struct virtio_net_hdr gso = { 0 };
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
-		if (unlikely(iov_iter_count(iter) < vnet_hdr_sz))
-			return -EINVAL;
-		if (unlikely(copy_to_iter(&gso, sizeof(gso), iter) !=
-			     sizeof(gso)))
-			return -EFAULT;
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
+		if (ret)
+			return ret;
 	}
 
 	ret = copy_to_iter(xdp_frame->data, size, iter) + vnet_hdr_sz;
@@ -2083,6 +2184,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	int vlan_offset = 0;
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
+	int ret;
 
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
@@ -2108,33 +2210,14 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
 	if (vnet_hdr_sz) {
 		struct virtio_net_hdr gso;
-		int flags = tun->flags;
-
-		if (iov_iter_count(iter) < vnet_hdr_sz)
-			return -EINVAL;
-
-		if (virtio_net_hdr_from_skb(skb, &gso,
-					    tun_is_little_endian(flags), true,
-					    vlan_hlen)) {
-			struct skb_shared_info *sinfo = skb_shinfo(skb);
-
-			if (net_ratelimit()) {
-				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-					   sinfo->gso_type, tun16_to_cpu(flags, gso.gso_size),
-					   tun16_to_cpu(flags, gso.hdr_len));
-				print_hex_dump(KERN_ERR, "tun: ",
-					       DUMP_PREFIX_NONE,
-					       16, 1, skb->head,
-					       min((int)tun16_to_cpu(flags, gso.hdr_len), 64), true);
-			}
-			WARN_ON_ONCE(1);
-			return -EINVAL;
-		}
 
-		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
-			return -EFAULT;
+		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
+		if (ret)
+			return ret;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
+		if (ret)
+			return ret;
 	}
 
 	if (vlan_hlen) {
@@ -2494,7 +2577,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
-	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun->flags))) {
+	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
@@ -3078,8 +3161,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	kgid_t group;
 	int ifindex;
 	int sndbuf;
-	int vnet_hdr_sz;
-	int le;
 	int ret;
 	bool do_notify = false;
 
@@ -3286,50 +3367,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		tun_set_sndbuf(tun);
 		break;
 
-	case TUNGETVNETHDRSZ:
-		vnet_hdr_sz = tun->vnet_hdr_sz;
-		if (copy_to_user(argp, &vnet_hdr_sz, sizeof(vnet_hdr_sz)))
-			ret = -EFAULT;
-		break;
-
-	case TUNSETVNETHDRSZ:
-		if (copy_from_user(&vnet_hdr_sz, argp, sizeof(vnet_hdr_sz))) {
-			ret = -EFAULT;
-			break;
-		}
-		if (vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		tun->vnet_hdr_sz = vnet_hdr_sz;
-		break;
-
-	case TUNGETVNETLE:
-		le = !!(tun->flags & TUN_VNET_LE);
-		if (put_user(le, (int __user *)argp))
-			ret = -EFAULT;
-		break;
-
-	case TUNSETVNETLE:
-		if (get_user(le, (int __user *)argp)) {
-			ret = -EFAULT;
-			break;
-		}
-		if (le)
-			tun->flags |= TUN_VNET_LE;
-		else
-			tun->flags &= ~TUN_VNET_LE;
-		break;
-
-	case TUNGETVNETBE:
-		ret = tun_get_vnet_be(tun->flags, argp);
-		break;
-
-	case TUNSETVNETBE:
-		ret = tun_set_vnet_be(&tun->flags, argp);
-		break;
-
 	case TUNATTACHFILTER:
 		/* Can be set only for TAPs */
 		ret = -EINVAL;
@@ -3385,7 +3422,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	default:
-		ret = -EINVAL;
+		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
 		break;
 	}
 

-- 
2.47.1

