Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634716;
	b=HvuYVJe92Z1gwM7fXc9L4fDvb6gDSuG6syaHNM/tV55zZkzTImwxmpo7ONiEIgyA1V3g
	 EGKivSA5oPJPK9i2NDThuIW8rBtfZA1dxPulCxfZkKWtj9Ets3B1WYNCSe4hHk3omJfKY
	 P9V9lMgWjGXgkehd8Zy/eVIKErkFimG7IpIOIAfohqLMis57MFFB39BL4ESidRoEBBHAS
	 PYp9FWWkSnSJw5USh+i9Zsq0NruxzE3f/UIT4Q9j3PR7VofjrIjdqVcfBm2H3GLnSxM6q
	 7tiZ5tZxa6KPFJmMCoAJleYmUQXGyb2Glyla2EveXrXpJ8tpzkVqLOzm2INeYCvzuRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634716;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=937nX/PE+DRlwUCkxy3kWZwRIlE+7A+DNKEqcWb94TY=;
	b=n5kKZ4FlcxHGUaqawbd3BwRHC4P8l4n33z0Xx/3R2mDfsQdqjuCqfhLFa6/quAsYLB4u
	 kAjyIIAcmCOqQme4HGst7dTt3qMR9AGzjld1GAOGUjQzhOvr3u9LUrugBahZctWFRdFAj
	 0s0XFr7BlZpNUQLBeWPVkJTVeE0mdART88uXudhVEWve0m+cf9eE5+5+6dME8cPJaI0QC
	 +4Sm1Ucg1yVcAtyjWPhftCtF9ML3eyYh8R5DRh/6jWFTQ8uOZP9DPM8E3nir1zQrvb5uF
	 gHqDAMxXggFcTQqarjVw+5ZFLg7uwFd4eeyl9DPe6RrS1bKwBiLlsTKLBCLQiT6bMdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=foxmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333B607A88B
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B333B607A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad211ad92bso865338a91.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 07:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634715; x=1794239515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=937nX/PE+DRlwUCkxy3kWZwRIlE+7A+DNKEqcWb94TY=;
        b=DzFrxZfT+CEGjooW377XYZgKVcVlleCovFwLBowR6zUxRqZz2FD/nGuy6x9jHz3nZ9
         EuLJhL0REN2XAg1TkSYgZm1AD2bf1A+LmRWrSFyCR0vNc8RuXINnPu3FPjYs47H4t5Sd
         jTMwHMwl/1TtJeJYgvWhUEqJpVHzvocurgLlTEOioy1fwvoZe3xcv3duzilVtJGJt2Dz
         lPh8ei79QcjyFLtUIa0waezBonbgHq0XIy77J/FFVB0i80crWQmdq67UidPt1Qof4vjG
         xLifYB46sHNmm1hVO9whja1XNoZLg7R46Rgmo7ZOE1rZ0AHzICY/VxHiOOAfPcKSs4fa
         OQkA==
X-Forwarded-Encrypted: i=1; AKwUvBx+IbWR6IjpiVGim9uD9nxA7OBLbSWbDV/Wqs5jmpAVMpt/cueSf6P8ZCohV57EkWb4X50QxQw0xEgplBr11w==@lists.linux.dev
X-Gm-Message-State: APuU4Z+deZoqk4jmvT+2SsD0lc6hFyfQZSx8UclFd3CMaXjzRtrPJ56N
	4l8JRhBdAsMxhhkgXrAEug3Hd72CZYzPzU2dU7Ybz6wGwgqsN0hd8x9M
X-Gm-Gg: AYBFou37BLM+99OVOBszEZML7gk1W2atYxASSvhoPy4nmO/H7rFKtOPCw3kNwMyw2Y9
	c7FJ9/DIrL2Cn0hohozPpmL32fRHlDxuVHrf0XwWJaK3sjTu+XFqzpsiWvvaYw8Qu0IsA+aELbX
	0wRpOH/ApUzWKwcbnmlcuwr9zbXUzHtpn1earX8DH2qPh9MlxCwt23M5XnfDs3wV78LRrFFhZCI
	w/BD9PS55awVIT8Tw3TQWt7zfk5H069b9aT2WNCuU/raAMGY/m/wdQ8+MU9vBFWlTbHPooBc5C8
	I+GQecqUkrHN0SXqgeQDb7i10GrR2ITu8o7DngjPqou9sZtbtup1B1hVIN0DKgn+Z0B7KCg/n1n
	2uetqGWHidQ4OggN1Ph69ewIv5Tvp1+wGavFa+hGdztlfRyIHwVKeDXrhhUj10CEzzB35hVWE45
	n69JclZ4Bgv04/Os6LRr+T5W49WzRSmfGEWRZV5cIZSyXxlNlyJXQaqQccNpZqAUBhL6nXff4t+
	SnQng8llWOy6Fj99QySoH+wCqzMOOPsRHmp9FbrlwVj1XpcBxa/ek5mHVaLVynQ7xDqdmGXLp2v
	4UtLRaon0qljOEs1dJOmY2dkiHKLVmVhG3UqXkWnPnVAgw==
X-Received: by 2002:a17:90b:4483:b0:3ac:9259:1234 with SMTP id 98e67ed59e1d1-3ae8979ba8emr8642033a91.39.1793634715031;
        Mon, 02 Nov 2026 07:51:55 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm14267953a91.11.2026.11.02.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:51:54 -0800 (PST)
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
Subject: [PATCH v2 0/2] virtio-net/dim: fix irq moderation init failure unwind
Date: Mon,  2 Nov 2026 23:51:43 +0800
Message-ID: <20261102155145.23144-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
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

net_dim_init_irq_moder() leaves dev->irq_moder dangling when
profile allocation fails.  virtio-net probe then skips the
virtqueue teardown if that init fails after init_vqs(), leaking
the virtqueues and their DMA mappings.

Patch 1 makes the dim init failure path clear dev->irq_moder, so
net_dim_free_irq_moder() is a no-op afterwards.  Patch 2 sends the
virtio-net failure through the existing free_irq_moder unwind
(reset + del_vqs), matching the page-pool failure path.  Patch 2
depends on patch 1.

Changes since v1 [1]:

- Patch 1's commit message now documents the call sequence the
  maintainer asked for: on current mainline the dangling pointer
  is never dereferenced by the only in-tree caller (virtio-net
  probe does "goto free", which only reaches free_netdev()).  It
  becomes reachable once the caller unwinds through
  free_irq_moder as patch 2 does, which makes patch 1 a hard
  prerequisite rather than a standalone bug fix.

- No functional changes; both patches are identical to v1.

[1] https://lore.kernel.org/netdev/cover.1790751008.git.shijianlin11@foxmail.com/

Jianlin Shi (2):
  dim: clear irq_moder on init failure
  virtio-net: unwind VQs when irq moderation init fails

 drivers/net/virtio_net.c | 2 +-
 lib/dim/net_dim.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>

--
2.43.0

