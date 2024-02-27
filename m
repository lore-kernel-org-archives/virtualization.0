Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88C5A7BB
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046336; cv=none; b=FfLvOxeGI4YvKiFFUG1lJVkMLJNMEvCymp8FIh6/wdKCfF/mkXOwJZOLUaDiut59ojuh7XdJwP6Fdc5JzNhEbHggPfc6rX4XjBxuSg//Mk1yWEPm+dXXg6qwSC+idl/f7f5HPbKkadi9SMdcwvKqz9pbDsi1PhImrbj1jNZcafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046336; c=relaxed/simple;
	bh=Bxh4I3k1tTosu/vzjpkK41ZDd73fjAHDMGMG0CR6k9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K77lb+Npb8ngqqdVQaqCjRv4tZOh15PyRmMwLbcIeA42R4euu7zZ/sq8W2fYHgV7HA9WF4dbDEvo2mHa7uz3V8FfSbLK49uhUtSVHcMpfdM846cnONKuiFUjEEQR+s6TD72gquctQYIByrIlbJ12f5zJ1piVXC10lmmTByFUaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SKRAR3CO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SKRAR3CO"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d61e39912so2456605f8f.3
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709046332; x=1709651132; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ragIw9Z0w9g84mdlLgLmMfrYwcqj41maxTbDqaz6opw=;
        b=SKRAR3COrjshsDKZfJILBCXYHH82iSzFZoAWLo9pXnRgfDjAGx45Ls8TlC6x7HRWUv
         hUm1MAQ559LTwiJTTd7/4qAEhwVr1Mv4aNRBobJZDsdmG/63ceDra54CNdAcvj8V/w50
         o4Fc2FkEnY69bOXOO1tQR2bu8devxfunqkB6JPLMdetzu4a3Y5/uLRuVZTI7r80BsoIu
         HOVk5Q/sywCmrgXNdPTlq/c5uSJKsz2K9qjZO3A9lzaQQ+m2FLZXVh6fEMVu7UvOParc
         d4UVHrc2IZeLDin6EwjdJPKRJYxofrCAgmg/+JE1iAFYmxmJw90wy1QZ0VWnwVpHUZl9
         7Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046332; x=1709651132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ragIw9Z0w9g84mdlLgLmMfrYwcqj41maxTbDqaz6opw=;
        b=ln45wcph3So8V1ADiU9a8sqwXi7++00X90wvRPyQ3aEI3K2azNEObcqs3ZWV+iqYxI
         34HKJhnTB8l5s90m3rd7/59KcauNt6o3AnJrkHy2HF6Ke75GK1H9KJVaGY0qhIDg11mQ
         YqrHxcFt4BRIZezFU7l3WjgoYSIF768FozQVKWwyfpSnfacgxVU4jCyB6FzXE+qJv4Gs
         klTMHHdTOS5fEgDN/6QZINKfh9xsZlh5OXUDSDSkNfe39/aCLiBym81RTcSLGm4vHg0N
         6d0sdd8/kaC721gpE553c+KBUG7ho4HuVwsW6a+pfqZz4yyct98N0jz8DMKZ11z1Xe/n
         qsRw==
X-Forwarded-Encrypted: i=1; AJvYcCU+c5Hd6kbcwSTFA9eXXBQuN30pePfE7C2nP4IwNHDQJbz8dXsFpuQFEEF27nKr7plaqsP6seCt17aHQkNxt6EcGk4A8WV2CXiKJJCUxP8=
X-Gm-Message-State: AOJu0Yxb0Q6aG1U3IrMCkJ3ggz7eqlX6TUd59YZoT2EfCZOBMrfPToV+
	vS7lKvzx7QLPm651zdbvdGMS/+h+4FB0W70W1f0070n/qIWHuA78AnjDt8euNiSB/7Elw7LQNRA
	7
X-Google-Smtp-Source: AGHT+IEQZM/2N2YVObowHQKC0jqFtdmUvTNSgaktYRQlf09cZdaEZm9ArxJ5WHQCBWgPE3Soixxfgw==
X-Received: by 2002:a05:6000:186d:b0:33d:e908:3673 with SMTP id d13-20020a056000186d00b0033de9083673mr2850882wri.8.1709046332409;
        Tue, 27 Feb 2024 07:05:32 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bp19-20020a5d5a93000000b0033d4c3b0beesm12101181wrb.19.2024.02.27.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:05:31 -0800 (PST)
Date: Tue, 27 Feb 2024 16:05:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 4/6] virtio_net: stats map include driver
 stats
Message-ID: <Zd36OIk8eS-SE8Ra@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-5-xuanzhuo@linux.alibaba.com>

Tue, Feb 27, 2024 at 09:03:01AM CET, xuanzhuo@linux.alibaba.com wrote:
>In the last commit, we use the stats map to manage the device stats.

Who's "we"?

>
>For the consistency, we let the stats map includes the driver stats.

Again, be imperative to the codebase. Tell is exactly what to change and
how.


>
>Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>---
> drivers/net/virtio_net.c | 195 ++++++++++++++++++++-------------------

Could this be split? Quite hard to follow.


> 1 file changed, 100 insertions(+), 95 deletions(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 5549fc8508bd..95cbfb159a03 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -125,9 +125,6 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
> 	{ "kicks",		VIRTNET_RQ_STAT(kicks) },
> };
> 
>-#define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
>-#define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)

Why you don't leave this and rather open-code it?


>-
> #define VIRTNET_STATS_DESC(qtype, class, name) \
> 	{#name, offsetof(struct virtio_net_stats_ ## qtype ## _ ## class, qtype ## _ ## name)}
> 
>@@ -198,10 +195,10 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
> };
> 
> struct virtnet_stats_map {
>-	/* the stat type in bitmap */
>+	/* the stat type in bitmap. just for device stats */

Sentence starts with capital letter, and ends with dot. Applies to the
rest of the code.


> 	u64 stat_type;
> 
>-	/* the bytes of the response for the stat */
>+	/* the bytes of the response for the stat. just for device stats */
> 	u32 len;
> 
> 	/* the num of the response fields for the stat */
>@@ -212,9 +209,11 @@ struct virtnet_stats_map {
> #define VIRTNET_STATS_Q_TYPE_CQ 2
> 	u32 queue_type;
> 
>-	/* the reply type of the stat */
>+	/* the reply type of the stat. just for device stats */
> 	u8 reply_type;
> 
>+	u8 from_driver;
>+
> 	/* describe the name and the offset in the response */
> 	const struct virtnet_stat_desc *desc;
> };
>@@ -226,10 +225,24 @@ struct virtnet_stats_map {
> 		ARRAY_SIZE(virtnet_stats_ ## type ##_desc),	\
> 		VIRTNET_STATS_Q_TYPE_##queue_type,		\
> 		VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,		\
>+		false, \
> 		&virtnet_stats_##type##_desc[0]			\
> 	}
> 
>+#define VIRTNET_DRIVER_STATS_MAP_ITEM(type, queue_type)	\
>+	{							\
>+		0, 0,	\
>+		ARRAY_SIZE(virtnet_ ## type ## _stats_desc),	\
>+		VIRTNET_STATS_Q_TYPE_##queue_type,		\
>+		0, true, \
>+		&virtnet_##type##_stats_desc[0]			\
>+	}
>+
> static struct virtnet_stats_map virtio_net_stats_map[] = {
>+	/* driver stats should on the start. */
>+	VIRTNET_DRIVER_STATS_MAP_ITEM(rq, RX),
>+	VIRTNET_DRIVER_STATS_MAP_ITEM(sq, TX),
>+
> 	VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
> 
> 	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
>@@ -243,6 +256,11 @@ static struct virtnet_stats_map virtio_net_stats_map[] = {
> 	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
> };
> 
>+#define virtnet_stats_supported(vi, m) ({				\

Could you have this as a function please?


>+	typeof(m) _m = (m);						\
>+	(((vi)->device_stats_cap & _m->stat_type) || _m->from_driver);	\
>+})
>+
> struct virtnet_interrupt_coalesce {
> 	u32 max_packets;
> 	u32 max_usecs;
>@@ -2247,7 +2265,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> 
> 	u64_stats_set(&stats.packets, packets);
> 	u64_stats_update_begin(&rq->stats.syncp);
>-	for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
>+	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
> 		size_t offset = virtnet_rq_stats_desc[i].offset;
> 		u64_stats_t *item, *src;
> 
>@@ -3381,33 +3399,36 @@ static int virtnet_set_channels(struct net_device *dev,
> 	return err;
> }
> 
>-static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
>+static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
> {
> 	struct virtnet_stats_map *m;
>+	const char *tp;
> 	int i, j;
> 	u8 *p = *data;
> 
>-	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
>-		return;

It is odd you added this in the previous patch and you remove it right
away. I think the ordering of the patches could be different, you do
this patch first and only after that introduce device stats feature
implementation. Makes sense?


>-
> 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> 		m = &virtio_net_stats_map[i];
> 
> 		if (m->queue_type != type)
> 			continue;
> 
>-		if (!(vi->device_stats_cap & m->stat_type))
>+		if (!virtnet_stats_supported(vi, m))
> 			continue;
> 
> 		for (j = 0; j < m->num; ++j) {
>+			if (m->from_driver)
>+				tp = "";
>+			else
>+				tp = "_hw";
>+
> 			if (type == VIRTNET_STATS_Q_TYPE_RX)
>-				ethtool_sprintf(&p, "rx_queue_hw_%u_%s", qid, m->desc[j].desc);
>+				ethtool_sprintf(&p, "rx_queue%s_%u_%s", tp, qid, m->desc[j].desc);
> 
> 			else if (type == VIRTNET_STATS_Q_TYPE_TX)
>-				ethtool_sprintf(&p, "tx_queue_hw_%u_%s", qid, m->desc[j].desc);
>+				ethtool_sprintf(&p, "tx_queue%s_%u_%s", tp, qid, m->desc[j].desc);
> 
> 			else if (type == VIRTNET_STATS_Q_TYPE_CQ)
>-				ethtool_sprintf(&p, "cq_hw_%s", m->desc[j].desc);
>+				ethtool_sprintf(&p, "cq%s_%s", tp, m->desc[j].desc);
> 		}
> 	}
> 
>@@ -3442,7 +3463,7 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
> 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> 		m = &virtio_net_stats_map[i];
> 
>-		if (vi->device_stats_cap & m->stat_type) {
>+		if (virtnet_stats_supported(vi, m)) {
> 			if (m->queue_type == VIRTNET_STATS_Q_TYPE_CQ) {
> 				ctx->bitmap_cq |= m->stat_type;
> 				ctx->num_cq += m->num;
>@@ -3464,19 +3485,66 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
> 	}
> }
> 
>+static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
>+			       struct virtnet_stats_ctx *ctx,
>+			       const u8 *base, bool from_driver, u8 type)
>+{
>+	struct virtnet_stats_map *m;
>+	const u64_stats_t *v_stat;
>+	u32 queue_type;
>+	const u64 *v;
>+	u64 offset;
>+	int i, j;
>+
>+	if (qid == vi->max_queue_pairs * 2) {
>+		offset = 0;
>+		queue_type = VIRTNET_STATS_Q_TYPE_CQ;
>+	} else if (qid % 2) {
>+		offset = ctx->num_cq + ctx->num_rx * vi->curr_queue_pairs + ctx->num_tx * (qid / 2);
>+		queue_type = VIRTNET_STATS_Q_TYPE_TX;
>+	} else {
>+		offset = ctx->num_cq + ctx->num_rx * (qid / 2);
>+		queue_type = VIRTNET_STATS_Q_TYPE_RX;
>+	}
>+
>+	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
>+		m = &virtio_net_stats_map[i];
>+
>+		if (m->queue_type != queue_type)
>+			continue;
>+
>+		if (from_driver != m->from_driver)
>+			goto skip;
>+
>+		if (type != m->reply_type)
>+			goto skip;
>+
>+		for (j = 0; j < m->num; ++j) {
>+			if (!from_driver) {
>+				v = (const u64 *)(base + m->desc[j].offset);

const le64?


>+				ctx->data[offset + j] = le64_to_cpu(*v);
>+			} else {
>+				v_stat = (const u64_stats_t *)(base + m->desc[j].offset);
>+				ctx->data[offset + j] = u64_stats_read(v_stat);
>+			}
>+		}
>+
>+		break;
>+skip:
>+		if (virtnet_stats_supported(vi, m))
>+			offset += m->num;
>+	}
>+}
>+
> static int virtnet_get_hw_stats(struct virtnet_info *vi,
> 				struct virtnet_stats_ctx *ctx)
> {
> 	struct virtio_net_ctrl_queue_stats *req;
> 	struct virtio_net_stats_reply_hdr *hdr;
> 	struct scatterlist sgs_in, sgs_out;
>-	u32 num_rx, num_tx, num_cq, offset;
> 	int qnum, i, j,  qid, res_size;
>-	struct virtnet_stats_map *m;
> 	void *reply, *p;
>-	u64 bitmap;
> 	int ok;
>-	u64 *v;
> 
> 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
> 		return 0;
>@@ -3536,43 +3604,10 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
> 		return ok;
> 	}
> 
>-	num_rx = VIRTNET_RQ_STATS_LEN + ctx->num_rx;
>-	num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
>-	num_cq = ctx->num_tx;
>-
> 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> 		hdr = p;
>-
> 		qid = le16_to_cpu(hdr->vq_index);
>-
>-		if (qid == vi->max_queue_pairs * 2) {
>-			offset = 0;
>-			bitmap = ctx->bitmap_cq;
>-		} else if (qid % 2) {
>-			offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
>-			offset += VIRTNET_SQ_STATS_LEN;
>-			bitmap = ctx->bitmap_tx;
>-		} else {
>-			offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
>-			bitmap = ctx->bitmap_rx;
>-		}
>-
>-		for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
>-			m = &virtio_net_stats_map[i];
>-
>-			if (m->stat_type & bitmap)
>-				offset += m->num;
>-
>-			if (hdr->type != m->reply_type)
>-				continue;
>-
>-			for (j = 0; j < m->num; ++j) {
>-				v = p + m->desc[j].offset;
>-				ctx->data[offset + j] = le64_to_cpu(*v);
>-			}
>-
>-			break;
>-		}
>+		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
> 	}
> 
> 	kfree(reply);
>@@ -3582,28 +3617,18 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
> static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> {
> 	struct virtnet_info *vi = netdev_priv(dev);
>-	unsigned int i, j;
>+	unsigned int i;
> 	u8 *p = data;
> 
> 	switch (stringset) {
> 	case ETH_SS_STATS:
>-		virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
>+		virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
> 
>-		for (i = 0; i < vi->curr_queue_pairs; i++) {
>-			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
>-				ethtool_sprintf(&p, "rx_queue_%u_%s", i,
>-						virtnet_rq_stats_desc[j].desc);
>+		for (i = 0; i < vi->curr_queue_pairs; ++i)
>+			virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, i, &p);
> 
>-			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, i, &p);
>-		}
>-
>-		for (i = 0; i < vi->curr_queue_pairs; i++) {
>-			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
>-				ethtool_sprintf(&p, "tx_queue_%u_%s", i,
>-						virtnet_sq_stats_desc[j].desc);
>-
>-			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, i, &p);
>-		}
>+		for (i = 0; i < vi->curr_queue_pairs; ++i)
>+			virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, i, &p);
> 		break;
> 	}
> }
>@@ -3636,8 +3661,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
> 
> 		virtnet_stats_ctx_init(vi, &ctx, NULL);
> 
>-		pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
>-		pair_count += ctx.num_rx + ctx.num_tx;
>+		pair_count = ctx.num_rx + ctx.num_tx;
> 
> 		return ctx.num_cq + vi->curr_queue_pairs * pair_count;
> 	default:
>@@ -3650,46 +3674,27 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
> {
> 	struct virtnet_info *vi = netdev_priv(dev);
> 	struct virtnet_stats_ctx ctx = {0};
>-	unsigned int idx, start, i, j;
>+	unsigned int start, i;
> 	const u8 *stats_base;
>-	const u64_stats_t *p;
>-	size_t offset;
> 
> 	virtnet_stats_ctx_init(vi, &ctx, data);
> 	virtnet_get_hw_stats(vi, &ctx);
> 
>-	idx = ctx.num_cq;
>-
> 	for (i = 0; i < vi->curr_queue_pairs; i++) {
> 		struct receive_queue *rq = &vi->rq[i];
>+		struct send_queue *sq = &vi->sq[i];
> 
> 		stats_base = (const u8 *)&rq->stats;
> 		do {
> 			start = u64_stats_fetch_begin(&rq->stats.syncp);
>-			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
>-				offset = virtnet_rq_stats_desc[j].offset;
>-				p = (const u64_stats_t *)(stats_base + offset);
>-				data[idx + j] = u64_stats_read(p);
>-			}
>+			virtnet_fill_stats(vi, i * 2, &ctx, stats_base, true, 0);
> 		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
>-		idx += VIRTNET_RQ_STATS_LEN;
>-		idx += ctx.num_rx;
>-	}
>-
>-	for (i = 0; i < vi->curr_queue_pairs; i++) {
>-		struct send_queue *sq = &vi->sq[i];
> 
> 		stats_base = (const u8 *)&sq->stats;
> 		do {
> 			start = u64_stats_fetch_begin(&sq->stats.syncp);
>-			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++) {
>-				offset = virtnet_sq_stats_desc[j].offset;
>-				p = (const u64_stats_t *)(stats_base + offset);
>-				data[idx + j] = u64_stats_read(p);
>-			}
>+			virtnet_fill_stats(vi, i * 2 + 1, &ctx, stats_base, true, 0);
> 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
>-		idx += VIRTNET_SQ_STATS_LEN;
>-		idx += ctx.num_tx;
> 	}
> }
> 
>-- 
>2.32.0.3.g01195cf9f
>
>
