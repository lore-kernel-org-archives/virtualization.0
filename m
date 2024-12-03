Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A331B85EB
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211077; cv=none; b=gTR7ZBtAgHYu4mfJhQNr7RZslT06IWijqG+zGdG6RoojSCL4ZCI6Hzjf/5c7PoxIVgWo2mnoucUACHV0LdtCm/cYywt39N48wnQda8jbVR/mbtlerJRhBs6pBsn/X3Pgbz28VOd4bUfnvQCKaMAw8gOa1Z4xRKZpjqd6B3hwDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211077; c=relaxed/simple;
	bh=Hk5ke9nzypkJaxk8bCoKEHSofdwMIA0X2l10CVp/tS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8/ZyxvIppFPKDw65aqwrHRc1OdYa9Gkn2UD701aw3RoViJlEMvEdlpsRRuG6LzRgT01vfeucvm2O10doytKWL//ODBRTWY+F14+JFTEjRnDEbSaCWvwuBYDiC9SxIhS/SbuSDe1yVGQNdYkP81ARsXE8q+AY+Jo9qcCPxw8r7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Sual1XW9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Sual1XW9"
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4965340B01
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211072;
	bh=pP1rcV8yFT6KeAKHqqLHhUue0tX/F8YDnxUvKh8M2mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Sual1XW9VZaDPoADr+Z59NUqD4MCuqrdgobTZKXtFq+pRw34V1JGkKTa+cOrSWEzH
	 3yp81bDvCrYb0d8mRXBsAPzF+ZXsqRBlc/m54xOsgTQrSrYIuUCeZ1ew9eyQGtOlR1
	 f7ro3cRfW79HrkK3uD0KyvX+bZonYMvUqRd+ia6wjfNAaWUC8JBwSwteudwXFGHJYO
	 7OwxxHxmdRd5nUGHpHzuJw/G8Xim+N/61l9OP4cSjLpg7adrt7XilXNq33AP8pQIEk
	 2/lfwOK/ZAwhhl6cD993XEV0h9WMNRhnt2QrbAusc53bMMY8awze1z77i1l8E4iN/f
	 4u8WFP6i1l+Qg==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-724e2c587b1so4871277b3a.3
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 23:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211070; x=1733815870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP1rcV8yFT6KeAKHqqLHhUue0tX/F8YDnxUvKh8M2mo=;
        b=qhkOIdcr2QDiLV43zoxaVbJXa2TmJ977iEAQlmCGolQ5ndfrDy9tKVIQMk4rZeMZNy
         GcGMBuVIz2XR5d1n1lcR94dGe1sMYhPuY0rQEnY59ZG7is+4ziC/wU1uRmGNLxkpCLcb
         3T1tmgvKoRu6z36OEEQu3AEUZksetp6iVX6Ats0VF4gCckf8fwOGqR6ho2gLZRu1gz7U
         bap9OKmVesrIaSy+LNThfAGgrETloEIm8poQ1RC/cTvjwsZy09kx8CDjpCPHCbNQrcYC
         Nxcwtggm/mI71psf3Vpax7HcX71rwgId12HGHxCpBdbD769MJdSnwqUIGCYfbFY3jk2U
         8CXw==
X-Gm-Message-State: AOJu0YwwTr/aYXhB/Q/d+lxXMiVyVe1wj1HX34biFMMAY86+Od0bzANx
	81sFgTVtzXARY0oYml7lRiM2t1nblEg7GSCQzaLzhQaMnurpIQYYmiA7Cs1CbwcR0YId4urhXET
	D4ETm+GjYnVd8jAEZTLlb8D8duCYq7O5GdOfqLp0RGO/aUq88P0hXtV0/Kr2b88CcVjwc8WlcDp
	C7bkGutG0Kx1rI
X-Gm-Gg: ASbGncu1NyETjL37Gcc3Cy0mjvOqlTDbwS8NRDKncN07e3ORlIOoSMgjVqvrdxkGNNN
	FZPpb4M9oXasm1q9d11dgeoHd/Eps5AvJTo2Ub+aO4+W19Yzks+Bfiyr6fmQE6PuRktQbTkTka3
	BCj5VasaekkgHo6ouZ2hPC4IsTbzM8YofP/0pj9Iuz/khAbgQjYjw+jx0wX8uU/oehpYP1ItGgP
	9rNJzTqTnNOqhQxRlgDgjjALxdrhrk/iM5/MP0d5UwyES4d8EuSKUV44qzGG7gNx4D/
X-Received: by 2002:a17:902:e88b:b0:215:6816:6333 with SMTP id d9443c01a7336-215bd1c4a4cmr18393825ad.15.1733211070587;
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEND0UzhbAQRYul9CwlhlE8NsG8OZop+RaB8RyNyzhSiQjfU17kWK9qXqZeOdr2+snjte5ZcQ==
X-Received: by 2002:a17:902:e88b:b0:215:6816:6333 with SMTP id d9443c01a7336-215bd1c4a4cmr18393625ad.15.1733211070289;
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 5/5] virtio_net: add missing netdev_tx_reset_queue to virtnet_sq_bind_xsk_pool()
Date: Tue,  3 Dec 2024 16:30:25 +0900
Message-ID: <20241203073025.67065-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d5240a03b7d6..27d58fb47b07 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5749,6 +5749,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
 	}
+	if (flushed)
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qindex));
 
 	sq->xsk_pool = pool;
 
-- 
2.43.0

