Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821093;
	b=X/mPeGp52gRM3nDJrLP0wz4lnJcEEJ2hVwSGitXMfc4fYsD+2ENe7rrlAnMNF4PUCcK9
	 cUzmN3GL+e3mGY3ChoiWApNKusmQtLNqb6AbZrNvkfNo3QUR4nNrfbrvq5SRlok4b5xWD
	 Qifm3NyV3LtBAaBMkL0014iqH1hslt123coQ24lsUJ02Znv3P/9IHUl8F0vjSMTPLtyY+
	 hOt9V01k32Z+yNw4NKgbj7oURfakS+dJgOWcwU5WtOTdP6ZZ83U4ch/PkClNk7+CZpi5A
	 6ka4IFjBU6NIghgYRSGLitRxgnFX0ZJWZM63tO/cB7QeTchkb6Rm+a+6Qn4llO8Lm7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wWFReQCNmO0chmlv4z0vEYsw9XSwzNSVOiZAm6Q6bTo=;
	b=anspV1BfL7TLJNRDaowh7EZmBtVGnCSpvCL178F5VH5rTqBAT1YiUNcukMLUkBkMzh//
	 jeKx4IJDUubSdrgH+JjK1ViDfeFaHSV3LzwG4SHxTMgMI0L4r/akUd0j8RwTFlkkju6nD
	 QsNI+aTJgFHMT7L3+/5pime1VwLyWsfJW/cDAQZnFlURqPnZ3FhQNIfN/lbu7hE1EcdJR
	 YqM4N/qCH1K9qGmBn+Yf9NdUuvRRD+ToU4cBYIpHLKkqzzXU0ba+2Ds7U/54+39Y6hF+h
	 FAD5sFzgVKT9nvAQIPpOglOUiO8CRC77iIDxzGJJl4zs/FTqYWHdWle2BMwKblSIWvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=UgeAzCe6;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC627606A33F
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC627606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=UgeAzCe6
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3704d30b84fso3733421eec.1
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 01:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794821092; x=1795425892; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWFReQCNmO0chmlv4z0vEYsw9XSwzNSVOiZAm6Q6bTo=;
        b=UgeAzCe6OSkCQkhC6iy2qTl3UTeaINQ/r2tOlfrQ3Ep5M0Js8czNF84blW9HyNVBkm
         1HFVhyi1yTYmZ8iacKkDzwcODnyNxWaH6Sd0uQURHnDgF7ntXE7vyDYY0AMyPwJiD7HQ
         VgB3XEDqf+JXvDToeIj6zejIg2tp3oH/MTa2pFCj9lNu4y4gBskkMpKK1qkhNyvo8NqZ
         GlINxuO1kXk4kpc8L69wIb3VOu2/h0ZgpumKywfXeFeZrf3ZdyrBoRvOC0u5gXGVxoi9
         k771kd+NqOBwdrXnKGO5HnQhA83jO0g0ioqEYnCp6S0DPKXzsVTfHbTanyJ/47VHGaiQ
         wYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821092; x=1795425892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWFReQCNmO0chmlv4z0vEYsw9XSwzNSVOiZAm6Q6bTo=;
        b=MGNw+W3l6U4D/9Hc72hpzmryCq4PtI0T2LpAqw2gBHrfVWjIhvXEysHun498oPW9h9
         f8qqsNaGxvbHGfajC847F9SpSjkHsGbfdlfDHR6VH3unDb14J0Q2aaMKwBswAJahID9Y
         R5975i5BpHBllyYHaRTjC/Dile6udLUDkhA1D4jI4MfnhRqkFgMdiNgIAiAYL9LELYnP
         WQ0beLZ/jVeyJ/79aJ3jhSBVNVJkhSudGdcRFKU6+8k3Jctmgw6sDi0EQPmquzbXgEGb
         Qc/JNZyvTepF63nR4JDRZLldD5YB/OvK22DYuOHwiaQQ2Kgl4duvmX4PGcKFnnu+Kh8P
         lSkA==
X-Forwarded-Encrypted: i=1; AL+hErFieWiseEzegLR2aKbbtn8CDko8p2KZw+WindHcg6qEe+ITBZ2o+z2RXYXuQ4K3yAutGDMaOS5yARgftX4CDw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9yxeTbbDvPFvPuViWJU2/4xDnwAg2phptgYkKL1R2e/oT4La9k
	T3cIIxdgRV+IzwH6QNLJFQynuuZ4v/Knclga8vIqyKE0FIOwLgrRR4tfjFpWHEhXAA==
X-Gm-Gg: AZFdTZd1+6ZJjUkv7+3ydyHInuIr2M4DVdtcCxmqUFPDSIG7C30VftcEGb6EpSwCkAa
	d78AVdLH0gqbG/V/SV9L5FXr+A62TMT3CYk00uP3JuGadGtcinFOGzy2S1ABjkhiCVGKzdUjSte
	K5m6GiTUWSgCi4bTqnNvuNRS+0cdUb99iEVomyW1PlXNGmJ2wzD2XhrsGnmvEiF0X99QIchHzdu
	p8rKoRdX3kNwe5QcpOFBlu0jaseoxtXrPEFLspNfdjTSoZ/3RRUd+1w/Cb31SmvpqVYxqSbx43D
	0WKxfSVdWVGM0GQZ2LlILgmUDCkUkCU/y5Yolyg+A5U1atlXxMTXnSr7v4h/CbAoPZTrzR+FHZZ
	hJ+OLiI+6yV1tinae4ZAZMAimSmT7vfzmsvm7PftaJKsMHkyfVXGbOaWooSf3CSEe20iTg35Ers
	MdIITGQQRPsEWPBDtLZpXM5fGdbnMCSY+hI4BwnYm65KuTRikAfepomseLTfEx3y94+T6bH1glm
	eX9Rm+q43Ixwbngkslwejf4aeCQ6IwPIXuiuwJSAZt2uBdokl+X3LpSMZAMILvfcgQRfdXrNDtJ
	H84ViSmIfbygh9jGsEt/DJ7uKGbMOR1FmbTyng==
X-Received: by 2002:a05:7300:d40b:b0:376:b957:c08 with SMTP id 5a478bee46e88-37966c489d6mr10969239eec.9.1794821091716;
        Mon, 16 Nov 2026 01:24:51 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32056314eec.26.2026.11.16.01.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:24:51 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/4] virtio_net: reject stats replies for queues outside the request
Date: Mon, 16 Nov 2026 18:24:42 +0900
Message-ID: <20261116092445.3391334-2-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__virtnet_get_hw_stats() passes the vq_index of each record in the
device's statistics reply to virtnet_fill_stats() without checking it.

For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
output array, which the ethtool core sized for curr_queue_pairs. A
record with the vq_index of a higher queue can make the driver write
past the end of the array.

For the per-queue netlink stats, the queue type also comes from
vq_index. A receive record in reply to a request for a transmit queue
makes the driver fill the struct netdev_queue_stats_tx on the stack as
if it were a struct netdev_queue_stats_rx. If the device offers
VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
bytes after the tx struct.

Fix this by rejecting the reply when the vq_index of a record lies
outside the range of queues in the request. The control vq is checked
separately, since the vqs of the queue pairs beyond curr_queue_pairs lie
between that range and the control vq.

Claude Opus 5.5 was used to audit the driver and draft this patch. To
reproduce, the virtio-net device in QEMU was modified to offer device
statistics and to answer the request of ethtool -S with a record for a
nonexistent receive queue. On an unmodified kernel, KASAN reports a
write past the ethtool -S output array:

  BUG: KASAN: vmalloc-out-of-bounds in virtnet_fill_stats+0x6c1/0xf20
  Write of size 8 at addr ffffc90000085140 by task ethtool_stats/158
  Call Trace:
   virtnet_fill_stats+0x6c1/0xf20
   virtnet_get_hw_stats+0x5d6/0x7c0
   virtnet_get_ethtool_stats+0x11b/0x920
   ethtool_get_stats+0x150/0x1f0
   dev_ethtool+0xaaa/0x1be0
  The buggy address belongs to a 1-page vmalloc region starting at 0xffffc90000085000 allocated at ethtool_get_stats+0x120/0x1f0

With this patch, the driver rejects the same reply. When ethtool -L
leaves queue pairs unused, the driver also rejects a record for the
first unused receive queue, while a well-formed reply fills the
statistics as before. The drivers/net/stats.py selftest passes when the
device answers with well-formed records.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Fixes: d888f04c09bb ("virtio-net: support queue stat")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v3:
- No functional changes.
v2: https://lore.kernel.org/all/20261102205550.4148064-1-lian@is.s.u-tokyo.ac.jp/
- Add a comment and a sentence on why the control vq is checked apart
  from the range of the other queues.
- Add the KASAN report and a test with unused queue pairs.
v1: https://lore.kernel.org/all/20261022182710.2055771-1-karin0.zst@gmail.com/

 drivers/net/virtio_net.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ed20e76fbc4c..57d7a98ecb57 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4973,7 +4973,8 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 				  struct virtnet_stats_ctx *ctx,
 				  struct virtio_net_ctrl_queue_stats *req,
-				  int req_size, void *reply, int res_size)
+				  int req_size, void *reply, int res_size,
+				  int first_vq, int last_vq, bool enable_cvq)
 {
 	struct virtio_net_stats_reply_hdr *hdr;
 	struct scatterlist sgs_in, sgs_out;
@@ -4994,6 +4995,13 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
 		qid = le16_to_cpu(hdr->vq_index);
+		/* The vqs of the queue pairs beyond curr_queue_pairs lie
+		 * between last_vq and the control vq.
+		 */
+		if ((qid < first_vq || qid > last_vq) &&
+		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
+			return -EINVAL;
+
 		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
 
@@ -5073,7 +5081,8 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (enable_cvq)
 		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
-	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
+	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply,
+				    res_size, first_vq, last_vq, enable_cvq);
 
 	kfree(req);
 	kfree(reply);
-- 
2.56.1

