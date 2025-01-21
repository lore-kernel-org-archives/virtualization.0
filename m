Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0C1F75AB
	for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486673; cv=none; b=sFxKMboOhHeHnvafUOO2A5GmYov2ztubuQGyzlo3vzOVrzINI8exM3zQTlxTdjRzW21TGyuVR1VBLztSuReupyn6ESX16huGoWnSQf5d4GM7PbOzY67/Gsa+k8CqryEQXYcJ8uSojSnR/qv/GkquCi4i0muk7K4EPR+t2CYZS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486673; c=relaxed/simple;
	bh=QoUuXeDBulZSbVMdrI5zM6Eg9lCr5hgBtBOzJbP8zEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxjbpxDjkofaXxthyGv4uVVTDUNrXqpi7I15rA5ZYfOZhamKoZfrnxSCHwUtC2t/iPJskHMolQlAzshAweWb5LqIu8yqzD0EnhalNBTNr72qSO2Nh5XhBhEGsqcF8s/QmcIl0gSl1vBjxjlmo5fgOAndk6hbyfyATco1Zh26Rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=O7uRIf7m; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="O7uRIf7m"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so10396036a91.2
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486670; x=1738091470; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sIKGTHIeBOioZLiUeQpKiV7N2jyLH+xFiew0830fKc=;
        b=O7uRIf7myQSdKki9WMjCpoyT+m82l2pnd676cLCg3SmmSbipPoI83NGM5ZUaak01ig
         VPmImu8PDL/pxhpVg1oR19PmxD+KFohIV46LJP0gDugH2SQ9bVjh6ZuQ1S1xGJWGRRRu
         pN/FQN+nv0nVB3et0Lon2EM1/RWZ4JClHz0vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486670; x=1738091470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sIKGTHIeBOioZLiUeQpKiV7N2jyLH+xFiew0830fKc=;
        b=HoCa9LIIoXzUT2/yEXMyPckxZurPGMl0ASz94L/tXO3MsNKhHAuKiQ1if/JmPWBNCe
         MBMfL0UEamxnoVndNC4hJXPEpSip6wffgNow9oUAwCUM58aok3Zxz2Z/c3/FagjwbXeN
         l5wJE2SOO4WoZHwPL7LLQKZzrE3FcD+IZzAvC1ngE/S5hy8r9GN/+po5sCw6TkNlX6GR
         80GUooN8oWJn9016t1zHdrbjQvYlhKOULvPEla4Hg91wUwJ1WOraKDSAWmcrURC1SvL7
         Sjs7o6O3QIUMGghxqiUM5ZT6JpGktu5bbiFOdd2CM+9E7xLRXiN8Fn/eUuHDIE1awgwT
         jKRA==
X-Forwarded-Encrypted: i=1; AJvYcCXs1cETabYxx5r+OUXNYM8qwReVV5R8busKcTfwzQklIESN+K5jNbfLXah5Ia9X0EY6gjvy50LGxTT+3y4OEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLKOUCKOz+K2w3PnGuDassJmNkuFHxa4IfgkpoYBqKBTwTdNCg
	NRgbK9z/o91RkzGexyIN7OufXZOlkdFkPE1YsxS2XVJGumJ4ng9Uziqqns5NQc8=
X-Gm-Gg: ASbGncsIJvjxs99XkjpC7bK68QNefm5km8H5CLALvPu6kCvD3Wdm9eAluMgQdTQWSyi
	VgtZze1LJAR3ZdIuTDxkswf+kRJxc4BFamBt0LmRmNGbRbno6k/Qs+//Q4Q+tEgOp/EbaL+2jxD
	hrL2rhcYagPPZnT5+vPgKY3XZFs2oYgFMs1PgGrJeNI4lnnN/8VcVftCiRq4TPIWtz7nucqLFTV
	xtwS3Q8aecQueI1j7XFoPFIyLa7rPOkTgEt8dmxg3RDxQAoY3zQAbiinOaw+XeVv7soPWTAxKRC
	lw==
X-Google-Smtp-Source: AGHT+IE4irALDUjtpmu8CkVPCmQyuHgMI1XADWpZWozR+u77nlArMTYTrKbNpUm0btjkrguF/oTbgg==
X-Received: by 2002:a17:90b:4c06:b0:2ee:7862:1b10 with SMTP id 98e67ed59e1d1-2f782c701f7mr28198326a91.11.1737486670370;
        Tue, 21 Jan 2025 11:11:10 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue mapping
Date: Tue, 21 Jan 2025 19:10:42 +0000
Message-Id: <20250121191047.269844-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121191047.269844-1-jdamato@fastly.com>
References: <20250121191047.269844-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Slight refactor to prepare the code for NAPI to queue mapping. No
functional changes.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 v2:
   - Previously patch 1 in the v1.
   - Added Reviewed-by and Tested-by tags to commit message. No
     functional changes.

 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..cff18c66b54a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_do_enable(struct virtqueue *vq,
+				   struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -2802,6 +2803,11 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	local_bh_enable();
 }
 
+static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+{
+	virtnet_napi_do_enable(vq, napi);
+}
+
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 				   struct virtqueue *vq,
 				   struct napi_struct *napi)
@@ -2817,7 +2823,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 		return;
 	}
 
-	return virtnet_napi_enable(vq, napi);
+	virtnet_napi_do_enable(vq, napi);
 }
 
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
-- 
2.25.1

