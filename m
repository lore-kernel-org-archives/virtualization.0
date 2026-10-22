Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693727;
	b=tH8z/XdC9+TBhMkeA4FlQRNas7Awt6O+gQg0iDvwGDmL9GOKaJPusfkh4ioePIMsCN01
	 OxD5Qg42aee7HlhwkLbCw2lWuEloMw2pev38OTCJYXPXAUB3qECi8d3Hh+5z8lzzKqzHb
	 pF2i0ahLzauwu3LCDlpk0u7L9uvT/kcmC+wsM95EJbhFh+g/SixHgpIKNusJTvNhlE6tb
	 7nKz5eG983r4Fs9KmHO1Hog71rgbE8r9JlUTQ8Vh559CiU9k0MescpR1hwDbkzemDVayQ
	 WlWBJ4fCVVm5H3b02SQguQ4BXi/KPpq7LKO/GglqZlWPaq+wzgfNc0uR6NaQqFOKvoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
	b=Obnpd8KPEX2t16GM4YG4xNKTHo12Vo/AEPV+RAad7uHZHV5zd24aNeQD1gsRv0XkqYfd
	 fV2JaB+ngw/RCLDvaQ66oeCsUi04tuac4q5VoAX5qltYpWE5frD2rcXeKDkoJZ9GpOz4s
	 1CyoLOIk5Gjm7qIUsWsOAjNJpxJscTvLo6cCXkFWaCAk4XVT+oFcUoAhxtsBCUWcohgWu
	 iv0jomlIHyGjspde9luELuzmvSSU+Hv7VJz4IVsUekN2Sq5DiaeZ6YZze1BvvzTY/gGvb
	 /9gSLNWRMniPj4jbipr6mAnkBHNEIfXKGLQIvWADxqNsPa1gC7kX7iBqinDyrMzxDDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Ew457/RX";
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85431606A31B
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 18:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85431606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ew457/RX
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ada2f39f30so31625a91.0
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792693726; x=1793298526; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
        b=Ew457/RX6fj3Z60ms1yn9taAkHvgy109xMvDq+NUuPvgtomsaUuSuHctKdrWhFEqQG
         g+3nIQpYxgoiA1iBsTCdCyngzCPqg+XQ4nuJk7EptU5kB/fpgYMrIcR+nDLqqa+3duQu
         bgeIYSS+w3D9v9DG0wUXU2AxPcbxYRsDYvOSICvBYC8eUXxVNs4xDTsN9rSBpRnRKKsE
         zkYxR8tDNgxs1+tsZ6QHNciak2xfF6SE5Xi5t0upWWChTpnEMIq2gPHFtBouUuE6ORki
         AfkVe77S0pZdY+tI+NCutNt9FnQh04bzZyqQ89IQtx3x73hNszHxDFBkKVizqWaifnbS
         sPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693726; x=1793298526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
        b=YcmxwA3ncwESpK8RHCfoBFh8lyiNSoe9aoMdNL2hxqIcW6rW8McJXHnwTrJ36AGbTv
         gHhCDgV+vZELO5tvf0JVUryUl8MpTo0KOTbr+mOEwZkEaNf6i6ukfny8mBoiCNhv2eQu
         JXAs74RFPMN8Hd7w20AeV2qOf3W3uJyYur0vK5wCTSvFD6e157mi7unN0KKc7VD3Wil7
         7EkfzXuX8XaIEyyOmc8PiIqG8Gj2Lack9UBuRvWj9WxMrh1paA7AJRhp4DKZTO+nPoPa
         vjU+8vHcMSM+0WtEFdibdwu9Ba/dPV7g3YbDirkr0X9GAgxtjtf2oS+L+9rxjZBGEi92
         6OaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw34tX8fEofTorZEtuT08XoOrcjlUl9tOVJ2SvoDEF6UVPqvFWcqD8INywp7xsawbVBetALzkhDKMrR5eteQg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLpasQf4VoqCvDSuR7dANUMqMfZADxvVsE0Xq7+FDX1HC5lOQb7
	EYLDPG+iF/l5W/p+s2n9kPc5IGHB6pvfmHYvoz6tIbNaPTQ/O1TYHns6
X-Gm-Gg: AYBFou08KshIjZ7WxqGBi6p4DGheE2lu8LqU766Df+vZgaLMZdoaV4IMro3XhT4queT
	3cTr2ZOvLe4ouCEoyLnEu3ETH1zh5yHbnaz5LxapT8WFHW2pnQCStqprtYlQv2Qv9Tz2JVcfcJg
	dOviN3epTDTppFXG3FTLZ/+T3VQEcGj6YDJHCjbzQktkYMR//XdJcBQfiiIMiSSeU5lKc54ctyn
	Drtvn6qPgPGjZplzOw76P3r/R+E1o0jgIRiMJhhiBxkOHTscsq+DafLiCdfgg33Sm/94/gAYKp/
	OLfs0vDTDwNa58CmvD3z4wyghlhmnDEgO34nC490QZZHKVjAG/kK5/BbyOpu1GIe0CKakkv1K8b
	nCt301xTvH0AkiWhdBAX396O/BT0+nACRax/rc2EWcsrDydwy5vmgwJGRbfOUITRA2AoeMtwU0E
	nZXthE1/0vdBgBd3qE8SfbkFl1CYsYIDmQqJF/Hp7C6fz87+ZgSXZw1aCWJ1b5ZjeYbX9wJ4eH1
	X6eVyOSmywJ7suqvstXe9QV5OukM9GuqJ2IwRenTR1Ok1bhhgBiucBejmKFxM4poaBDNfDrNIYq
	Gzr4R6aqnwPO/EvByT6VLh2jsuhmJKRwc8KgjZERni+uI6zOvrJBPGzfMorUVQqiLxzRmFfQbgr
	wQFmhimABZndMvrbioStOvuK8FB8kMyzWyfKPmvLPpqDQX6HuhWNiRq2Baw==
X-Received: by 2002:a17:90b:164c:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3ad86cc64d2mr5437501a91.60.1792693725903;
        Thu, 22 Oct 2026 11:28:45 -0700 (PDT)
Received: from wang0.shina-lab.internal ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490d4bfsm6115262a91.10.2026.10.22.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:28:45 -0700 (PDT)
From: Lianjie Wang <karin0.zst@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <karin0.zst@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] virtio_net: reject stats replies for queues outside the request
Date: Fri, 23 Oct 2026 03:26:58 +0900
Message-ID: <20261022182710.2055771-1-karin0.zst@gmail.com>
X-Mailer: git-send-email 2.56.0
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
device's statistics reply to virtnet_fill_stats() without checking it,
so the device decides where the driver writes the counters.

For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
output array, which the ethtool core sized for curr_queue_pairs. A
record with the vq_index of a higher queue makes the driver write past
the end of the array.

For the per-queue netlink stats, the queue type also comes from
vq_index. A receive record in reply to a request for a transmit queue
makes the driver fill the struct netdev_queue_stats_tx on the stack as
if it were a struct netdev_queue_stats_rx. If the device offers
VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
bytes after the tx struct.

Fix this by rejecting the reply when the vq_index of a record lies
outside the range of queues the request asked about.

Claude Opus 5.5 was used to review the driver code and draft this patch.
To reproduce, the virtio-net device in QEMU was modified to answer an
ethtool -S request on a one-pair device with a record for a receive
queue the device does not have. On an unmodified kernel, KASAN then
reports a write past the ethtool -S output array. With this patch, the
driver rejects the same reply with "Failed to get hw stats.", a
well-formed reply fills the statistics as before, and the
drivers/net/stats.py selftest passes.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Fixes: d888f04c09bb ("virtio-net: support queue stat")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <karin0.zst@gmail.com>
---
 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce4..0473fa9947858 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4955,7 +4955,8 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 				  struct virtnet_stats_ctx *ctx,
 				  struct virtio_net_ctrl_queue_stats *req,
-				  int req_size, void *reply, int res_size)
+				  int req_size, void *reply, int res_size,
+				  int first_vq, int last_vq, bool enable_cvq)
 {
 	struct virtio_net_stats_reply_hdr *hdr;
 	struct scatterlist sgs_in, sgs_out;
@@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
 		qid = le16_to_cpu(hdr->vq_index);
+		if ((qid < first_vq || qid > last_vq) &&
+		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
+			return -EINVAL;
+
 		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
 
@@ -5055,7 +5060,8 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (enable_cvq)
 		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
-	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
+	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size,
+				    first_vq, last_vq, enable_cvq);
 
 	kfree(req);
 	kfree(reply);

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.56.0

