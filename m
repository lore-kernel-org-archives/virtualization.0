Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C6236A70
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908703; cv=none; b=tEpW94RmlZ3RRvspRXyvRP9tvHhs+W43tpQ8oNzmRUu/bTL8X0Cv6cg78jJS4AHT8oU5F1BLTL/bsIkcLNJqL32hlcOzppFzRzrgrO3Xwccb8uLEfICStqCWtgw66/WJlLlUKNhO6nY47SzzjKGr5UMh3ZE31tVupNZSXCi+D5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908703; c=relaxed/simple;
	bh=2sT9p7Tdhv7mEmV/c7UEOWKJMAqlEDsJXf98KzxVhec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=VpSYe05iVIqHTcUrtEa/jd29eUqu1VmKdEJO3OPi1YLgiqZigqmugH6YrAXG4a6q61vLLD6zP3dylB2kZRNHQ+0meN7ZPw/NSewtcYuqqpopdSBwlBVCoy0or2rKK1X93mGjzCuCtJKLqXIliGRJTF3EXkMio8ollWATlODxX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=HhImtMf5; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="HhImtMf5"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5EC240126
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPxD9ndlZjF1 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Feb 2025 06:11:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 23113400C1
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23113400C1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HhImtMf5
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23113400C1
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:40 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2166651f752so37291295ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Feb 2025 22:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908699; x=1739513499; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmnHaYspPDyJkcOuZzaS2LCZdNKiS5G61RIu4vxwt0s=;
        b=HhImtMf5DavtLPwRc+A+yZW4GNyYDhbAKZbOPksLMEGXu33H1tVUvupcFdXfESvVzJ
         5RmRjdtXfrMxqPYbBPv6c3JUWHMg4HqTJJN4Q8W6+Fj0RYXlZcwjcQQs0p7POw0xOFVi
         Dpr4ZQgH/l3z+mRO2kWQss3slGx3K9O5T77gI9gVjZJZ1cufDZ4pDGY6EA4UNG49niMx
         ixMbc+Lero1aZaVGstaT44nGFo4qXn/X6d0IvvZQquksHPGzSROX0c3A0E485XqjGc9G
         MTrm/0JJyKvR/BuzbunWRawDJE5JKkGXzsOlssSjh0yA3MzSGx4tWc49TrtVakDbIyRT
         yQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908699; x=1739513499;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmnHaYspPDyJkcOuZzaS2LCZdNKiS5G61RIu4vxwt0s=;
        b=bq5frX86DYaFdzwr3xAQI+fxjsoGoqQemmLC9lAEjFBOOaF/nXV9Ji5a+ZARCmpRI5
         eG/UXCAPzmcPoc/AtafE7baAEBh01V84WCVj7UCNRQw2H6OdX+l7pSBYOhr/9FzdiDBL
         R28SHXfVCPX2BxuVfn5Sl9t61fdBpJP6tvb8GOCM5uGoGqOiKK9ehksJjvyafJOU10KR
         btsGAkmYg1QEhstuqeugAEBZJf50bAv8cnGAPQB3fHZuC4EYIqqBV50mV2oVXkm5+Qmr
         mpZhf1+AXn45H0Sbg8HnsDMlWFPfvgVshKmyYN3OXQ3E4NCLUClF5/yCJdy8ORQMJBHe
         JN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuZob6S5OMSMvvRnYTimrgN4egClt+1khrYEHEKwhObv7u1WzyJpLClOs0KWTkzVv5TpZQtXekgq9YfUT/OA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwW6IkKR439eaEOqVCjwWSOe98jnca0IvQFRyIf8+E204jWkJkL
	3Svmoj2fthQV1KPzyq7SrQuXQHMdzjhnYgB5+i0Q4upqwP0mtlPCIM3hujfA0/A=
X-Gm-Gg: ASbGncsBTU1roaBV3fqNyJV8494HPqU1aXMM8FVaDeD1uYY3lfrWYtezHZ+YQA1zbRM
	+18eZ8wXi4sTSiRpX4pF1UPHeCm0tG/oZBWL/RNnh+w1YGJp69TKL2/Xov+r2qTRLecokUa1uqU
	CAHupeIGuQ9uqAEA8gOpDLWkdl9E/t09DXk/clHLNNnr9uKGOXgWu83F++xI44prWkKtRvGigZw
	Y7DetXpT1oElJmXR5neUPZoUx3gUb49WguWcN6NsAgPWtjtPgZwe5tNe5RLWLdw8osSRB5yOVru
	/MruPFJfu0dY2HNqIsU=
X-Google-Smtp-Source: AGHT+IGDh54iXLRiJ4OMG7YrYR+1P1l3EmrGDIxypvzlptE9odP3bP3T6YgsEKO8xT2k1RC3iKNu2g==
X-Received: by 2002:a17:903:41c9:b0:215:5625:885b with SMTP id d9443c01a7336-21f4e7e5f2dmr29039275ad.52.1738908699417;
        Thu, 06 Feb 2025 22:11:39 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fa184ac945sm1755361a91.46.2025.02.06.22.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:55 +0900
Subject: [PATCH net-next v6 5/7] tun: Extract the vnet handling code
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-5-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
In-Reply-To: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
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
X-Mailer: b4 0.14.2

The vnet handling code will be reused by tap.

Functions are renamed to ensure that their names contain "vnet" to
clarify that they are part of the decoupled vnet handling code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS            |   2 +-
 drivers/net/tun.c      | 180 +----------------------------------------------
 drivers/net/tun_vnet.h | 185 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 179 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 910305c11e8a882da5b49ce5bd55011b93f28c32..bc32b7e23c79ab80b19c8207f14c5e51a47ec89f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23902,7 +23902,7 @@ W:	http://vtun.sourceforge.net/tun
 F:	Documentation/networking/tuntap.rst
 F:	arch/um/os-Linux/drivers/
 F:	drivers/net/tap.c
-F:	drivers/net/tun.c
+F:	drivers/net/tun*
 
 TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a52c5d00e75c28bb1574f07f59be9f96702a6f0a..b14231a743915c2851eaae49d757b763ec4a8841 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -83,6 +83,8 @@
 #include <linux/uaccess.h>
 #include <linux/proc_fs.h>
 
+#include "tun_vnet.h"
+
 static void tun_default_link_ksettings(struct net_device *dev,
 				       struct ethtool_link_ksettings *cmd);
 
@@ -94,9 +96,6 @@ static void tun_default_link_ksettings(struct net_device *dev,
  * overload it to mean fasync when stored there.
  */
 #define TUN_FASYNC	IFF_ATTACH_QUEUE
-/* High bits in flags field are unused. */
-#define TUN_VNET_LE     0x80000000
-#define TUN_VNET_BE     0x40000000
 
 #define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
 		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
@@ -298,181 +297,6 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-static inline bool tun_legacy_is_little_endian(unsigned int flags)
-{
-	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
-		  (flags & TUN_VNET_BE);
-
-	return !be && virtio_legacy_is_little_endian();
-}
-
-static long tun_get_vnet_be(unsigned int flags, int __user *argp)
-{
-	int be = !!(flags & TUN_VNET_BE);
-
-	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
-		return -EINVAL;
-
-	if (put_user(be, argp))
-		return -EFAULT;
-
-	return 0;
-}
-
-static long tun_set_vnet_be(unsigned int *flags, int __user *argp)
-{
-	int be;
-
-	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
-		return -EINVAL;
-
-	if (get_user(be, argp))
-		return -EFAULT;
-
-	if (be)
-		*flags |= TUN_VNET_BE;
-	else
-		*flags &= ~TUN_VNET_BE;
-
-	return 0;
-}
-
-static inline bool tun_is_little_endian(unsigned int flags)
-{
-	return flags & TUN_VNET_LE || tun_legacy_is_little_endian(flags);
-}
-
-static inline u16 tun16_to_cpu(unsigned int flags, __virtio16 val)
-{
-	return __virtio16_to_cpu(tun_is_little_endian(flags), val);
-}
-
-static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
-{
-	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
-}
-
-static long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
-			   unsigned int cmd, int __user *sp)
-{
-	int s;
-
-	switch (cmd) {
-	case TUNGETVNETHDRSZ:
-		s = *vnet_hdr_sz;
-		if (put_user(s, sp))
-			return -EFAULT;
-		return 0;
-
-	case TUNSETVNETHDRSZ:
-		if (get_user(s, sp))
-			return -EFAULT;
-		if (s < (int)sizeof(struct virtio_net_hdr))
-			return -EINVAL;
-
-		*vnet_hdr_sz = s;
-		return 0;
-
-	case TUNGETVNETLE:
-		s = !!(*flags & TUN_VNET_LE);
-		if (put_user(s, sp))
-			return -EFAULT;
-		return 0;
-
-	case TUNSETVNETLE:
-		if (get_user(s, sp))
-			return -EFAULT;
-		if (s)
-			*flags |= TUN_VNET_LE;
-		else
-			*flags &= ~TUN_VNET_LE;
-		return 0;
-
-	case TUNGETVNETBE:
-		return tun_get_vnet_be(*flags, sp);
-
-	case TUNSETVNETBE:
-		return tun_set_vnet_be(flags, sp);
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
-			    struct virtio_net_hdr *hdr)
-{
-	u16 hdr_len;
-
-	if (iov_iter_count(from) < sz)
-		return -EINVAL;
-
-	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
-		return -EFAULT;
-
-	hdr_len = tun16_to_cpu(flags, hdr->hdr_len);
-
-	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
-		hdr_len = max(tun16_to_cpu(flags, hdr->csum_start) + tun16_to_cpu(flags, hdr->csum_offset) + 2, hdr_len);
-		hdr->hdr_len = cpu_to_tun16(flags, hdr_len);
-	}
-
-	if (hdr_len > iov_iter_count(from))
-		return -EINVAL;
-
-	iov_iter_advance(from, sz - sizeof(*hdr));
-
-	return hdr_len;
-}
-
-static int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-			    const struct virtio_net_hdr *hdr)
-{
-	if (unlikely(iov_iter_count(iter) < sz))
-		return -EINVAL;
-
-	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
-		return -EFAULT;
-
-	iov_iter_advance(iter, sz - sizeof(*hdr));
-
-	return 0;
-}
-
-static int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
-			       const struct virtio_net_hdr *hdr)
-{
-	return virtio_net_hdr_to_skb(skb, hdr, tun_is_little_endian(flags));
-}
-
-static int tun_vnet_hdr_from_skb(unsigned int flags,
-				 const struct net_device *dev,
-				 const struct sk_buff *skb,
-				 struct virtio_net_hdr *hdr)
-{
-	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
-
-	if (virtio_net_hdr_from_skb(skb, hdr,
-				    tun_is_little_endian(flags), true,
-				    vlan_hlen)) {
-		struct skb_shared_info *sinfo = skb_shinfo(skb);
-
-		if (net_ratelimit()) {
-			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
-				   sinfo->gso_type, tun16_to_cpu(flags, hdr->gso_size),
-				   tun16_to_cpu(flags, hdr->hdr_len));
-			print_hex_dump(KERN_ERR, "tun: ",
-				       DUMP_PREFIX_NONE,
-				       16, 1, skb->head,
-				       min(tun16_to_cpu(flags, hdr->hdr_len), 64), true);
-		}
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static inline u32 tun_hashfn(u32 rxhash)
 {
 	return rxhash & TUN_MASK_FLOW_ENTRIES;
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
new file mode 100644
index 0000000000000000000000000000000000000000..fd7411c4447ffb180e032fe3e22f6709c30da8e9
--- /dev/null
+++ b/drivers/net/tun_vnet.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef TUN_VNET_H
+#define TUN_VNET_H
+
+/* High bits in flags field are unused. */
+#define TUN_VNET_LE     0x80000000
+#define TUN_VNET_BE     0x40000000
+
+static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
+{
+	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
+		  (flags & TUN_VNET_BE);
+
+	return !be && virtio_legacy_is_little_endian();
+}
+
+static inline long tun_get_vnet_be(unsigned int flags, int __user *argp)
+{
+	int be = !!(flags & TUN_VNET_BE);
+
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
+	if (put_user(be, argp))
+		return -EFAULT;
+
+	return 0;
+}
+
+static inline long tun_set_vnet_be(unsigned int *flags, int __user *argp)
+{
+	int be;
+
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
+	if (get_user(be, argp))
+		return -EFAULT;
+
+	if (be)
+		*flags |= TUN_VNET_BE;
+	else
+		*flags &= ~TUN_VNET_BE;
+
+	return 0;
+}
+
+static inline bool tun_vnet_is_little_endian(unsigned int flags)
+{
+	return flags & TUN_VNET_LE || tun_vnet_legacy_is_little_endian(flags);
+}
+
+static inline u16 tun_vnet16_to_cpu(unsigned int flags, __virtio16 val)
+{
+	return __virtio16_to_cpu(tun_vnet_is_little_endian(flags), val);
+}
+
+static inline __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
+{
+	return __cpu_to_virtio16(tun_vnet_is_little_endian(flags), val);
+}
+
+static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
+				  unsigned int cmd, int __user *sp)
+{
+	int s;
+
+	switch (cmd) {
+	case TUNGETVNETHDRSZ:
+		s = *vnet_hdr_sz;
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
+		*vnet_hdr_sz = s;
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
+static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
+				   struct iov_iter *from,
+				   struct virtio_net_hdr *hdr)
+{
+	u16 hdr_len;
+
+	if (iov_iter_count(from) < sz)
+		return -EINVAL;
+
+	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
+		return -EFAULT;
+
+	hdr_len = tun_vnet16_to_cpu(flags, hdr->hdr_len);
+
+	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+		hdr_len = max(tun_vnet16_to_cpu(flags, hdr->csum_start) + tun_vnet16_to_cpu(flags, hdr->csum_offset) + 2, hdr_len);
+		hdr->hdr_len = cpu_to_tun_vnet16(flags, hdr_len);
+	}
+
+	if (hdr_len > iov_iter_count(from))
+		return -EINVAL;
+
+	iov_iter_advance(from, sz - sizeof(*hdr));
+
+	return hdr_len;
+}
+
+static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
+				   const struct virtio_net_hdr *hdr)
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
+static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
+				      const struct virtio_net_hdr *hdr)
+{
+	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
+}
+
+static inline int tun_vnet_hdr_from_skb(unsigned int flags,
+					const struct net_device *dev,
+					const struct sk_buff *skb,
+					struct virtio_net_hdr *hdr)
+{
+	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
+
+	if (virtio_net_hdr_from_skb(skb, hdr,
+				    tun_vnet_is_little_endian(flags), true,
+				    vlan_hlen)) {
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		if (net_ratelimit()) {
+			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+				   sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->gso_size),
+				   tun_vnet16_to_cpu(flags, hdr->hdr_len));
+			print_hex_dump(KERN_ERR, "tun: ",
+				       DUMP_PREFIX_NONE,
+				       16, 1, skb->head,
+				       min(tun_vnet16_to_cpu(flags, hdr->hdr_len), 64), true);
+		}
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#endif /* TUN_VNET_H */

-- 
2.48.1

