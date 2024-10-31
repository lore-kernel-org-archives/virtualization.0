Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410302BB09
	for <virtualization@lists.linux.dev>; Thu, 31 Oct 2024 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334227; cv=none; b=FlcaI4Djqwm1rMtmWr0ZUNGIMC6I5zhsVvYefKtApvVf67vkttbOOhzeNZzMzlaGoQVRwlQOK/Tzb+QPd5wMiXN+vkCF46b5USk1h1hDRChps6FYk8U3pU4wPyDvwbvxbk+PIsPVgf8knmZdyisbCNPywfHC1L9puFZNZndrK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334227; c=relaxed/simple;
	bh=z3nAQNKQ8EPpdG3q4GCW/62oF7r6Z6P5c1Z3MZCXaUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYnfKcErhRFzzfzO6K0SsxBc/88u1Uhw0hlBhofEro+sN+OyrfEt+uieep87Wc6cuKkK+vEekcwQwIkEJppWN0hG/Jb0OgKvXnAGyDUXWp/4kw9LqdGo5FAPlWNSyIExImw5UnS3pTdpLIkjNd5T6YjvUa4MfJKkHIMtSxP01MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YnhJsdPE; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YnhJsdPE"
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3a4e5acc542so220975ab.3
        for <virtualization@lists.linux.dev>; Wed, 30 Oct 2024 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730334224; x=1730939024; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tf88+MjxuRscGCJUWSV+JgU09beZteKvue7KtOwrEjg=;
        b=YnhJsdPEwIVorbMC3W0HsJWhdOAiR+BwV8/uPwALZG6FdyVhAGgTs3doQly7yqByt4
         Hp+sDHRWucas3VTCWMmUGS+RADz3imLHsc2LevYQe1ieunwhRAFy7QEYXk+g5McUUnNO
         5Puz/v5WkAssbQut12KEEiyXKZUtQ22kZpHqfZJA6sOh3KdhGKp4WK5jJogTkJk7/z3k
         Eq/D9n0/d1i0FZ74JTnYFjsESBTXDusRC2hq9SykHhFyjdMC2kg/PXIXmiMoVNZ5EutE
         uUaOw4ECLs+/qefAauBCGUkaUinRnuMTZcmTnaJEtSAMOzrvOwjE9QSuUPxv7FWW/YIu
         A/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730334224; x=1730939024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tf88+MjxuRscGCJUWSV+JgU09beZteKvue7KtOwrEjg=;
        b=m0JVEFBhufoWN9TOBwXjYUHh7wR2Px2ZivSzCKRAZ1FjB1iyB1+8m273QSSFczTVBl
         LhJ+xEfftG4qM4Div0l0CIBK4PlTGHKg/IoOJ74m97pbOew/qf7QhWlZiSiHla0+uEa8
         11Xwtn3J6159a20N1buJ2t6Jv0bNXxmRjW9T8Qm4ynZUem1ZOIQ84jcpayNNyXJFNVrb
         1n80l9a7onsNWsGNKT6zZfJc/M1stVPmPLYp8SzoSOT2Lkd3SH0r0ya8+Y94h4+r4DdD
         sOQGYCIZl9Gz2cc+0+sgwkOcAbT9NXh7XWQdkOXbazy+fQluTFxOj+ITJodO0G/R9NW/
         jrvg==
X-Forwarded-Encrypted: i=1; AJvYcCXxyVVdUvsHJ0jR83awAhNYgCbUSMXD21rdVVzJtSsy6todANrmmiZQ7rsW0kzCB0dRLOGkUizwT0V231BNnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh7EM3xSsjxPjPcDZFuPpNfCrRfCAxNlznUb4/bfCfCWCEGAp6
	gH2JtlbzREKsxbMxH20IL74ugB8hcZnB3OMBnZxKwi0/gQBL9CbTaVZ3a/454Qkf+cCwQuzYy09
	enqmb95wvDs42iMHdELZwd0i/V76qJWsXfreV0eUGkWPT+bRW
X-Google-Smtp-Source: AGHT+IFctfwfFkMLSXWKissVysXhbwAhZuukj/l7GUQRUQP8VHt+M3bWpakPEOY0QFlU+31rWrfy/nfQ3PTS
X-Received: by 2002:a92:ca47:0:b0:3a0:a1ab:7ce6 with SMTP id e9e14a558f8ab-3a4ed26cc3amr47563395ab.1.1730334224191;
        Wed, 30 Oct 2024 17:23:44 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3a6a99c9259sm108935ab.46.2024.10.30.17.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 17:23:44 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DC5C734039C;
	Wed, 30 Oct 2024 18:23:42 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D5083E40A10; Wed, 30 Oct 2024 18:23:42 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	David Arinzon <darinzon@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Felix Fietkau <nbd@nbd.name>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Noam Dagan <ndagan@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Roy Pledge <Roy.Pledge@nxp.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com,
	virtualization@lists.linux.dev
Subject: [resend PATCH 1/2] dim: make dim_calc_stats() inputs const pointers
Date: Wed, 30 Oct 2024 18:23:25 -0600
Message-ID: <20241031002326.3426181-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the start and end arguments to dim_calc_stats() const pointers
to clarify that the function does not modify their values.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/dim.h | 3 ++-
 lib/dim/dim.c       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index 1b581ff25a15..84579a50ae7f 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -349,11 +349,12 @@ void dim_park_tired(struct dim *dim);
  *
  * Calculate the delta between two samples (in data rates).
  * Takes into consideration counter wrap-around.
  * Returned boolean indicates whether curr_stats are reliable.
  */
-bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(const struct dim_sample *start,
+		    const struct dim_sample *end,
 		    struct dim_stats *curr_stats);
 
 /**
  *	dim_update_sample - set a sample's fields with given values
  *	@event_ctr: number of events to set
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index 83b65ac74d73..97c3d084ebf0 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -52,11 +52,12 @@ void dim_park_tired(struct dim *dim)
 	dim->steps_left   = 0;
 	dim->tune_state   = DIM_PARKING_TIRED;
 }
 EXPORT_SYMBOL(dim_park_tired);
 
-bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(const struct dim_sample *start,
+		    const struct dim_sample *end,
 		    struct dim_stats *curr_stats)
 {
 	/* u32 holds up to 71 minutes, should be enough */
 	u32 delta_us = ktime_us_delta(end->time, start->time);
 	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
-- 
2.45.2

