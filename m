Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBDF6A8D2
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421575; cv=none; b=H57crd+SZaexVPbwd35+BgxFouuBWWx00GVZHt4T3EdikEnBatGQ7WMBz5p2C0EcT9rb9G5POd8vJBvASgFxOMHjLBopB6fw1Pe+VL4oFQVDTZvD6IQhEvUbIOE7MwD1IvrNeUf4vWQWWLxtrKeYgX5WsCDFasUYf8yZBPz097w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421575; c=relaxed/simple;
	bh=ohLO789sHfFgMKSOwGDlzSy99Mj1iOqRNgRJnS8QIiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZc8zmVDnWnjJ9eaa9LgvsdT2N5LSCrihuG4rzQQC7ACBm0zi00yRHV/3xY5VNB/RSWQTQMmXTZQJmS4wmNqncLyXaR834AWy0sAc4vqpqGyoMMaCPVhht0ZGKD82pld6GFG8P7TO/9wbxKvwLswjjBApbtIBX14SXOJTK8TzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eHyaK5K0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eHyaK5K0"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso314738a12.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713421573; x=1714026373; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbU6FsIuncluFPwH7VPsX/cWOPAMxIJmhU49fecmUC4=;
        b=eHyaK5K0bW8MeowFUgAFWJwwxAdKBUzonZz2jDxV7cugDtd0omRxgWGMId6yBaHHr7
         6l0YaV0vlb2Lgo7aY80LIu+eXpi9/wSfoOVhfXtSTZTEdzDk7NUBxgsQseR0diOR2ktu
         wJ6T2JRMioACtF9QuuZaKG9t/ozBUxMuArxDHA4oGd1QcXcclHS/soU9z4NUtFKHlT/0
         Rtp+V0M16ItZYAF3Gvoj/uieczIqmaPqhJV/pAixkGjqICfFAHp9ZG319raNtYI2UipB
         8GJNr0KMx/YHRNSnCjvZm+W53n8+1ftaTGax2a9EKhvZ0uZxUUSpw4FHvE9D7DSbaHgE
         VCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421573; x=1714026373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbU6FsIuncluFPwH7VPsX/cWOPAMxIJmhU49fecmUC4=;
        b=KpvZ0mockHGDqcCMJQLDAnQHAdrvPznIRis8OxdUbFI+QxAR3m7xDzM1CUpHXzFODn
         ARqtWcgC2uCpkAog2+A5BdIt5l0PrHCutAWHuiprXr+3cwrEQPpSS2rIuOlCkkgNDInp
         cElzkeE4frjxbbWmizdubGHvxFVq3nINXby6Nwy+bqJtwrCj5Lo4YvPNWMOka0Tne7nH
         fVVkjw72wxcbcJPw/u1E89JRBfoV1uvKw8WIydwfiz7FSH8P2cGnoygmwjgoS0f4GBjj
         h2kDevaKpZe65bw5rL6CsdDUdL+eQZp/39lDRz2F9t93phY+wM89rdypAzlI/o95hCf4
         HzoA==
X-Forwarded-Encrypted: i=1; AJvYcCWq9cC7osnLoYmzs77wB/lp60MrcOCig3n8CCAYJ48X9/8uV1q6K6tbP8U+VdRF6dum+qDN0wjxCH9CpEJQ/rdQkikaZ3kWvf8UdGHN2iY=
X-Gm-Message-State: AOJu0Yzr3as4U9LhpnQGK5sQHli216pinTvspXAQKDhdfzmfnU8M8bjm
	IIOF3UWVGEfcXKPvxqM5swkJBc+qUopxsh9eZkIsFhi0BFM03VO6w4S8b/vMwCg=
X-Google-Smtp-Source: AGHT+IG8KbPnW3d1OwSGwOGuRvAB4kzTNDzAERiB9f7OxYdoLKYRlUD9DImfcrUf+Wr56E8/G1LSNw==
X-Received: by 2002:a05:6a21:2709:b0:1a3:5c61:5ec2 with SMTP id rm9-20020a056a21270900b001a35c615ec2mr2398878pzb.16.1713421573195;
        Wed, 17 Apr 2024 23:26:13 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm666392pgm.23.2024.04.17.23.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:26:12 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/3] virtio_balloon: introduce oom-kill invocations
Date: Thu, 18 Apr 2024 14:26:00 +0800
Message-Id: <20240418062602.1291391-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418062602.1291391-1-pizhenwei@bytedance.com>
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the guest OS runs under critical memory pressure, the guest
starts to kill processes. A guest monitor agent may scan 'oom_kill'
from /proc/vmstat, and reports the OOM KILL event. However, the agent
may be killed and we will loss this critical event(and the later
events).

For now we can also grep for magic words in guest kernel log from host
side. Rather than this unstable way, virtio balloon reports OOM-KILL
invocations instead.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 1 +
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..fd19934a847f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -337,6 +337,7 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..b17bbe033697 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -71,7 +71,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
 #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
-#define VIRTIO_BALLOON_S_NR       10
+#define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
+#define VIRTIO_BALLOON_S_NR       11
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -83,7 +84,8 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
 	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
-	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
+	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

