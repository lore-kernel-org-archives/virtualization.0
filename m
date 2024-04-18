Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9C7867D
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421582; cv=none; b=E7QD97GtyADUB583xSg8jR+fCf4fqB/hZR6pZS9JbsesS3tS0IKigguMK6aOP/fzXBNZlur+4+txCAH1kxwZBItRqD1QxNRPclX7EAfRffQH3qtfzCrplPNPChR356bjiSzuurIThttoETD0uJNKz0r0BjR+wGc7HT/PX1jM7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421582; c=relaxed/simple;
	bh=iQYgmz5Gef1EaE1UJeXMcgsfVqRfmIwziXDAGoA5Vos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtWdwNPfomOHuFRUHgTmVkJWnSdXC+QQtQbLA4EnQ1JuKzUDVa8xUykd3/it4lsnV7yoHkgboQLzMo3N4qJgqpNPKKj5DcLpUbuPJ1Wc4rkg7W517777EWMhQQTZ4llUxgyikRxEyeSJ7da9E+WijCvApj81MHr+dnMrF1t7igI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Bu9pvVKu; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bu9pvVKu"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea0db2727bso266589a34.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713421580; x=1714026380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0vNJuhAwUKc+UYf59Hf5S0kNxOXWBcwSUDB4ktR3Zw=;
        b=Bu9pvVKunrhvaSoCEU7GaieC2wYRkWJqlawUNjdgOD8BiyjHKZBU7IMWaXwqqAQlVx
         xs/Eog5q+LAk08qkYYspV1UekGW0tqNsGt5a50romLFHggmiHdGF0xQ5HRyuykUggZrE
         OQHC+Y3lspphLDfrMHKvfjFSDSSnhy36difebIE1/2HSgheKLKqWFMzhFWgxkwT0JWxp
         pcxi9UJUZEaBTVgMEFw3ThgNSxJqZPb53czP9+glo92m+cHgiLkTb+AqyrhntGSeWYhz
         CcePQJxGN1N9/osMGDo/gidTTeageVdxPXTMjD2QXYDv/JiAMpWnRiVaZkmOMRGtMAnz
         aNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421580; x=1714026380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0vNJuhAwUKc+UYf59Hf5S0kNxOXWBcwSUDB4ktR3Zw=;
        b=O3EUGKq/olCKoX1cg3exsJuR/cZS9PuwQwyy/+w6YNlNDldsoa9ZEX96E40glXNYUx
         lQyh2Qao7hYepq1OnJWajZQLmfn1k3DreEB/N+dgn/jRM+RvAyEO0PNTRndLeCf50Bjc
         ph5GKiwitH34ZWNWRLzcyI6bS7bksWA/rUHsk8mQ3Uml8x9D8Qie0HaPXzKc1JT8X8zh
         NzrHE5/d6lxhrYVzyE3sUKW76CCsOtRfmXbEE44XVsO9cIzMQBhw7bSXveteL9MKlScF
         6xplUunhn9o0NaERWyJSytm0MmI6/ycmvV//9zYpgXFn5071X6hd3gRyxTM1eZdLP0Ca
         X/hA==
X-Forwarded-Encrypted: i=1; AJvYcCWFkfZIZOab1+vsZ+/VxfVWwV5qLpdvE+k1zbUEYYC4/ROLzHxvc/I1dWuC9psNN+FK7SheD6cPQPRXANpZC6XFXe7IaM+YSrTunSr0TDo=
X-Gm-Message-State: AOJu0YwuB/r+IAp9hXg3aTr992rx6c7ksCMRi/cMtcIf7/eF8xaewSND
	nLWqwnM/AMyt/SME1RqSF0E4rmtKgpSJ1XpJ1FNBCuBLyBU4fOB9ohlsb0WORVk=
X-Google-Smtp-Source: AGHT+IHHR6Htepai94lycGDse6wf1IdRutz/3r1ea6ZF/gP/tH+hAUh/tHbzPsYdqQF4kLBlWMl4TA==
X-Received: by 2002:a9d:6a90:0:b0:6eb:bbc6:9af0 with SMTP id l16-20020a9d6a90000000b006ebbbc69af0mr2171391otq.12.1713421579905;
        Wed, 17 Apr 2024 23:26:19 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm666392pgm.23.2024.04.17.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:26:19 -0700 (PDT)
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
Subject: [PATCH 3/3] virtio_balloon: introduce memory scan/reclaim info
Date: Thu, 18 Apr 2024 14:26:02 +0800
Message-Id: <20240418062602.1291391-4-pizhenwei@bytedance.com>
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

Expose memory scan/reclaim information to the host side via virtio
balloon device.

Now we have a metric to analyze the memory performance:

y: counter increases
n: counter does not changes
h: the rate of counter change is high
l: the rate of counter change is low

OOM: VIRTIO_BALLOON_S_OOM_KILL
STALL: VIRTIO_BALLOON_S_ALLOC_STALL
ASCAN: VIRTIO_BALLOON_S_SCAN_ASYNC
DSCAN: VIRTIO_BALLOON_S_SCAN_DIRECT
ARCLM: VIRTIO_BALLOON_S_RECLAIM_ASYNC
DRCLM: VIRTIO_BALLOON_S_RECLAIM_DIRECT

- OOM[y], STALL[*], ASCAN[*], DSCAN[*], ARCLM[*], DRCLM[*]:
  the guest runs under really critial memory pressure

- OOM[n], STALL[h], ASCAN[*], DSCAN[l], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to cgroup, not the global memory
  pressure.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[h]:
  the memory allocation stalls due to global memory pressure. The
  performance gets hurt a lot. A high ratio between DRCLM/DSCAN shows
  quite effective memory reclaiming.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to global memory pressure.
  the ratio between DRCLM/DSCAN gets low, the guest OS is thrashing
  heavily, the serious case leads poor performance and difficult
  trouble shooting. Ex, sshd may block on memory allocation when
  accepting new connections, a user can't login a VM by ssh command.

- OOM[n], STALL[n], ASCAN[h], DSCAN[n], ARCLM[l], DRCLM[n]:
  the low ratio between ARCLM/ASCAN shows that the guest tries to
  reclaim more memory, but it can't. Once more memory is required in
  future, it will struggle to reclaim memory.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     |  9 +++++++++
 include/uapi/linux/virtio_balloon.h | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e88e6573afa5..bc9332c1ae85 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -356,6 +356,15 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	stall += events[ALLOCSTALL_MOVABLE];
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
 
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
+			pages_to_bytes(events[PGSCAN_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
+			pages_to_bytes(events[PGSCAN_DIRECT]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
+			pages_to_bytes(events[PGSTEAL_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
+			pages_to_bytes(events[PGSTEAL_DIRECT]));
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 487b893a160e..ee35a372805d 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -73,7 +73,11 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
 #define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
-#define VIRTIO_BALLOON_S_NR       12
+#define VIRTIO_BALLOON_S_ASYNC_SCAN    12 /* Amount of memory scanned asynchronously */
+#define VIRTIO_BALLOON_S_DIRECT_SCAN   13 /* Amount of memory scanned directly */
+#define VIRTIO_BALLOON_S_ASYNC_RECLAIM 14 /* Amount of memory reclaimed asynchronously */
+#define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15 /* Amount of memory reclaimed directly */
+#define VIRTIO_BALLOON_S_NR       16
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -87,7 +91,11 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
 	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
-	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls", \
+	VIRTIO_BALLOON_S_NAMES_prefix "async-scans", \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-scans", \
+	VIRTIO_BALLOON_S_NAMES_prefix "async-reclaims", \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

