Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634733;
	b=TKBB2U6TeqsT+PxSSzdpATAUtjntITsgHllnEaSARcVs+mbix1n6frbU7pZU/H/6HKgJ
	 840zh+6deRtmVBDA/89bYLScvNhg/s7ot3YYUMKejrCBIrRRMFHQaQu30UnKNv2ffzdSX
	 4TFb1bZf7qvGd2tN7D7Je0LRtdaEBObtCE3nlFOVdiP30ebwx7lFBAqnl+Z2CsCmjhPhJ
	 TYcgVT0hVz2dmK3gZGeRJbCSU7+GI+pgmZYVhi9zneaPyt810d78eF4QPgQqwDc+Xa8ZJ
	 LvEMvFoJpj9zUGioDSvbMkytU7M/c5FaCnL2LIKxOj2UOKzT575gysUIl7yUlcNu14A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634733;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wKLrw167uz5vnqL4s9bXN12DEPMpo4oId8hlYp1KDSc=;
	b=Js365hNR6wfC9lkuQ39Yal/MEseP8w18aOqZPEQnrMao0b4YjRB+uapIjE3OseR/nGau
	 Yoka09fhvApsLsfT6rJtcU3SyG1VhL1TXZV5GxQ6JKBWi8su1WSjzifAVsCp2MmvKaf98
	 8vcgukLDUc2aiI1IpcM96uJhDc/Fl+iL8/h5HuOLmlKXc/BpyRIbylSgviDy9nts0WHKl
	 +G9CnUp9qcIvVWyvy+pyHfkxAE/jUXtpjh39rigg2c37eJSMSKyS0lvIMZTSlS4JCT000
	 lrthylZwquZW5WuuQvhp6symA65p+SNlI89TxEKXt/0Dc9igEWbmo7JWK66ts85LVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=foxmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AE606E039
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 15:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 873AE606E039
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso855116a91.0
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 07:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634732; x=1794239532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKLrw167uz5vnqL4s9bXN12DEPMpo4oId8hlYp1KDSc=;
        b=RfchRCbd7JX3tJCW0y3h3Uor+Mg+58wfYKDMUpH+mGyJS7ysnea2yrbPFUgG2jxAfX
         t9n334a+adET7YT9oNkhZ9gb0amCew7StCRi8i4Nro4L34H4ArVLkWvrg3Dt1htx86jl
         X+fB9IO+03lcetPez0nQPK6Y7Bn59L1x4Lv7FbQUGUNQE7lQRtYJr4iuMh5DSTQsy18O
         t6Co3RyerGUfy7ocPEAMPtHLmjLC3CAVg1aq6zTDrwmyZUAIPSr6mvM0HPitoFLytAyo
         0RWRjn3MSWBUQ3cp6tJLYyKA7BmUsxNg5nDDX50S/FiQsriASmi33Vj4PVg88abC4NuI
         6VWw==
X-Forwarded-Encrypted: i=1; AKwUvBwpWXsSEqMzY/K6vjw7ioGoqIEVXLvNomoHaXAzt87PnOeYlmfpJixsWWT4e4rg0o/Du4GihP5Wb9B7UX8ZmA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/iuiyyZmVGQWNhSnTd9BHzxnDUi/pbAdhOWFwzrCvIH68iZF/a
	AcE9Cig1mE6Pqgra/fQR58CCWZUpd+nR9UsCgyDKahc9Aj9GHr/bfALJ
X-Gm-Gg: AYBFou1iO7F8KLwegCms30q0BwLgEyUwD5uBWwnsGxmUaSudFGpAwdS94dEZfLr//2B
	SZRWDrRck+LR2uzPbOYP0JjkRNgq4n8NerwAilPGrtdxGGbiUaH94CZKW9712GTJCQviL1ljnSX
	WUMlw005BrjMgEKgmCqJj6AY9iWZMKf99HoJXhoNDK+Hn4UW370UKvm6eKV6TC6RjbAS6Dm4WLR
	NoZ1qflq58cs1gxyFZjQccrkzbhkoQdTazMwlrrXZnojTkgUGP6zELzQ5/PdWthEjcNW5+d/iHI
	4ZaBz2dsZKHD6/V0eTgsNpR3GxxiTsZF+yBlRLohvIhjc6EiDBQk0ZFsbJM1QKNGA1QtN5/Cz5+
	a9Vhfs+uEpGJs51q2ahvO4/4vn/gwWFrw+U4zQTdo0RaIwAiacekoz40R4nTV1jDUFA0q6Pqbcd
	qrYOvv0fa2TXlndSSFzCRcpCBGXhVu75DmvLXqGoM8fE1ZP9E9qMQQRKp7EbKHcV1lqL1meRofp
	w/a+Z9X3u9akI+TNPTNzYRbzA0UI/NLnaj0tLlUb7+ir9Mkvg7hHaEinQWINbBvh71pp0eLDyTu
	SmR1jJ6iXAMWQkaiORqsC6CGrcL5o1BP9DptHpvvwCgXX4UrOs7FiwpGQ3S6OUhYSZM=
X-Received: by 2002:a17:90a:e7cd:b0:3ac:85be:cd56 with SMTP id 98e67ed59e1d1-3ae897ce1famr8769905a91.12.1793634731895;
        Mon, 02 Nov 2026 07:52:11 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm14267953a91.11.2026.11.02.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:52:11 -0800 (PST)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: [PATCH v2 2/2] virtio-net: unwind VQs when irq moderation init fails
Date: Mon,  2 Nov 2026 23:51:45 +0800
Message-ID: <20261102155145.23144-3-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102155145.23144-1-shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <20261102155145.23144-1-shijianlin11@foxmail.com>
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

virtnet_probe() calls init_vqs() before virtnet_init_irq_moder().
When the irq moderation init fails, the error path does "goto
free", which only reaches free_netdev(): virtio_reset_device() and
virtnet_del_vqs() are skipped, leaking the virtqueues and their
DMA mappings.

Use the existing free_irq_moder label instead, as
virtnet_create_page_pools() already does on failure.  This is safe
only after net_dim_init_irq_moder() clears dev->irq_moder on its
own failure (previous patch); otherwise virtnet_free_irq_moder()
would net_dim_free_irq_moder() a dangling pointer, dereferencing
freed memory and freeing it a second time.

Fixes: dcb67f6a9ead6 ("virtio-net: support dim profile fine-tuning")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe..d3ad1f1334bb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -7027,7 +7027,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		err = virtnet_init_irq_moder(vi);
 		if (err)
-			goto free;
+			goto free_irq_moder;
 	}
 
 	/* Create page pools for receive queues.
-- 
2.43.0

