Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821098;
	b=a43nB9xDu+ozyt9GFQaDvqpkx94ZwkAAL0YLyR2skkpKBR1PJi5LSV4lG02S/zMHUUSf
	 PUqcLK6cRoYdrUKlVHrvw+Priu49IqYnGrmeqMkE2b/NajWSdRVfUbh6BSBQlycE5mdxf
	 efIbD1mvTIZAY1Ji7S8eXQ5kz63lULnvs1OqnjE7yyVVET+umMlzNoTHCP5baP1r54iJ6
	 j0rs7RUeBZSu7dgr+FruaCX5FlMaWKNFU6YuQHq0bBf6jw8Sy0sMQFCpV6IujtP6/Ifhn
	 4fYVqkNBWodhZinGrXT/wtGeE3F0EtRQy3KE56wxRh7Gz+CeMfJzPDZm0SYJ7Ugfi6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OD644D4H+a0ZXJYlgxiiTnY1kkzCbvWk1YLCk3rxbKU=;
	b=ZGL63mdU+ve5IaCrN/nl48s4+GhqiZzBbcty8RI/A3TpYPO6dAwi+exDXVuJN+Q4PcdY
	 6DqX+tRAnlKZQiGguPBYyQ47JiZLAaqbaoiybrnF0PzjiJqDiRlFBcA98L0sTKiCgNad4
	 vnQZRvTcZnMfxZSI6/BuVNtRKh39y5kQomJ7xB7/NvR2mfKP3s3XZVIMkNigI1S/C7q3S
	 4jzeNeu1dvHdB892TbNCSegUvV4QEobLADqwBdwfEzYrQSG0jT0ew/WMzcYHM0xwN1o2y
	 yGAGeBJBr6eDf3qUu58G6cD51SxjPQAHCM6Qpx2eJJnQMqYlfAH0EZxJWilZKOUFeWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b="Q/lnNllm";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0F606A881
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEE0F606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=Q/lnNllm
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a315ed211so3060057eec.0
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 01:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794821097; x=1795425897; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OD644D4H+a0ZXJYlgxiiTnY1kkzCbvWk1YLCk3rxbKU=;
        b=Q/lnNllmsfTjxelIuIm2xjiDnDs1SGPvMV206RtMvQwpULvbWM2wY1cdEALLfnss8g
         4NgsRpDHPso83Me6IurbIGso8ndt8YKFbCR8WSrFronvIBau1StZo5LzMaqTxQxGfg5N
         78I/dr+TY1m8ETyfMwtErBRDh5JrUn9/1BjIUq+P5Thlp00qogMqkbDEzXR9fyoUmB6y
         RQFtT1uZ9Ke0dFOORk81BwFWiXkJfa9GhvM/G/wiKZeyNT6dA+Mg8NCqeJynYSuxyZFD
         qcCM73fKqezRhCvWTTziC5JU13aX4KXDww7u+vQ3irfpmxsJHCyNxEQ00Qvz4ONUvXU/
         SAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821097; x=1795425897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OD644D4H+a0ZXJYlgxiiTnY1kkzCbvWk1YLCk3rxbKU=;
        b=G2UrAcSZuiEQOvFCzd4f1ok8q7MtWLCf6/O/66vD2Owj5Y1BCoEVuUhpxJYKQb+Sm9
         gTchtmrLiwJfrXi2d+FRvhNMAYmFlow1acJtRgngvUnQeYGQYzKPFO++UrVbN3tnKOoq
         AUaFBqNNLHizkwN6JMKEIz1G6CSDHjvv3ik9ZgA9iKb1+CpZC6cwb8y/ui4ywd0gDonH
         3/dDrOjqQpGqJMwjYpcbh6G663Gh/pQS2YAGzBZalwo6f7O343OflE5rAsU0HXvQmjoQ
         A1kUCuP7e/0gLKDVw5dfwU+dFNbPd7JzfCWFi93D0YLXsPLPM7K9tDF55mNS+t5tQnr2
         wNSg==
X-Forwarded-Encrypted: i=1; AL+hErEDGAUvP0QKoiZckRyUKdNvqlKlnszKZdKj+Lhp4EJ/s53wSCvVGhn5Ztcq0LW+bjMbgnZNXg/TPHldEQgS/w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8jU7E7gED/DFjHYs8buHDaQANEd2b47am3ZXQlxHloB+vwvhyK
	sDwTcJZCSl3rnws5W49MB/o32KLJ3O+kObcrT7GOAYxU8nQPVM1hHObgataVdl2T1A==
X-Gm-Gg: AZFdTZevBPDilNskWId8t9yyg+/7t7V00RaNFMlFcIi4BQpjGLtjmmdIKlkZqpm/8sI
	HsxB5Ea5rbQD9uR0Fw1r3T/dt38PQtkbny4YLhIKQbPHAKGXpmJO4QnMDNSI/Z951D5CgSqrFLm
	m/wNwe1OJqN3kCc9GovLD133lmxrUDO5koYhYsI/5n/F8y04IFTEiTnc/Z2H01MmPkCdU3UeGxD
	qvfSdaG1EsHzN7F/iArczG4ZV99nzV0ePmHEaeaAPM9uOiRugCBcxDefoeCJaulI7IxHSNZ2BA2
	uIVSogH+gkYh4idzo0YnWTC9fG+Fz6yC6Pr80cAKEWtGv3k9VVR9PhlEvuiXDMe2LuNFp/8RngD
	9Yn3Lkn1IJpRJwJ/NDU3yAKLqPJ/BE8tuDRXYHcEG1yFk+fdkjFm1Dy0qtT7iLov9i0erMWXPU2
	Bc7otY+r/CCqv+fZJvhKJFb731WPdQ+QzOyVxTc3IVymCdTTMdcSrMVMmGyB7TyD7m2m8aszh0Z
	qM5ugo50cKlieFKAdipnm6X3gI1D+187y/2JTdWvYAuuEGXfmguO798ERprNNLtZxQ/TNbMO0J/
	6Hs+GUmXBoDGcDQZvsFbXbAhuhOIZq06001cCvjS8YGPOb7l/bbcs/899fQ=
X-Received: by 2002:a05:7301:4718:b0:375:85ac:d14f with SMTP id 5a478bee46e88-377e10172d1mr11175901eec.14.1794821097026;
        Mon, 16 Nov 2026 01:24:57 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32056314eec.26.2026.11.16.01.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:24:56 -0800 (PST)
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
Subject: [PATCH net v3 3/4] virtio_net: keep reads of stats records within the reply buffer
Date: Mon, 16 Nov 2026 18:24:44 +0900
Message-ID: <20261116092445.3391334-4-lian@is.s.u-tokyo.ac.jp>
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

__virtnet_get_hw_stats() only checks that each record of the statistics
reply starts within the reply buffer, while virtnet_fill_stats() reads
the whole payload of the record's type, so a record near the end of the
buffer can make the driver read past it and report the heap bytes
through ethtool -S and the per-queue netlink statistics.

Fix this by reserving zeroed space of the largest ctx->size[] after the
reply, so the buffer can hold any type of payload.

Records of an unexpected size are still parsed, since every record
starts within the reply and cannot cause out-of-bounds reads, and
rejecting them with checks per type was judged costly to maintain [1].

Claude Opus 5.5 was used to audit the driver and draft this patch. To
reproduce, the virtio-net device in QEMU was modified to offer device
statistics and to end its reply with a truncated receive record. On an
unmodified kernel, KASAN reports:

  BUG: KASAN: slab-out-of-bounds in virtnet_fill_stats+0x66d/0xf20
  Read of size 8 at addr ffff8880036f5940 by task ethtool_stats/159
  Call Trace:
   virtnet_fill_stats+0x66d/0xf20
   virtnet_get_hw_stats+0x5d6/0x7c0
   virtnet_get_ethtool_stats+0x11b/0x920
   ethtool_get_stats+0x150/0x1f0
   dev_ethtool+0xaaa/0x1be0
  Allocated by task 159:
   __kmalloc_noprof+0x1b7/0x4a0
   virtnet_get_hw_stats+0x25e/0x7c0
  The buggy address is located 8 bytes to the right of
   allocated 56-byte region [ffff8880036f5900, ffff8880036f5938)

With this patch, the same reply triggers no KASAN report. The
drivers/net/stats.py selftest passes when the device answers with
well-formed records.

Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/all/20260711150754.2918392-1-michael.bommarito@gmail.com/ [1]
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.org/
Fixes: 941168f8b40e ("virtio_net: support device stats")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v3:
- New patch.

 drivers/net/virtio_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 498014773242..b9b6c915b6f3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5071,7 +5071,13 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (!req)
 		return -ENOMEM;
 
-	reply = kzalloc(res_size, GFP_KERNEL);
+	/* virtnet_fill_stats() parses the whole payload of a record's type,
+	 * so reserve zeroed space after the reply to hold any payload.
+	 */
+	reply = kzalloc(res_size + max3(ctx->size[VIRTNET_Q_TYPE_RX],
+					ctx->size[VIRTNET_Q_TYPE_TX],
+					ctx->size[VIRTNET_Q_TYPE_CQ]),
+			GFP_KERNEL);
 	if (!reply) {
 		kfree(req);
 		return -ENOMEM;
-- 
2.56.1

