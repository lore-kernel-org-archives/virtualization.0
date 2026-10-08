Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63944D7D3B
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474250; cv=none; b=ARlqsRVMI8e3mThOH7yTEgxB4VxlGQdTptXuPYr+rQBMmB6Q4aZWYG44xGZKVFsKzo9Tf4gbKs4Q/uKEa3fH/bFuzrT/ybklLzi2IEc8AYlCAwxTDk9kYCwpd0VYtdpiJF33FNNcegPK4FswR2lTBXhEjZgF8QuJPA6BnzwLylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474250; c=relaxed/simple;
	bh=Q6PFR6LWngt7oO1hw+7z9E0HVKsg7+Hw7FqbuBdwgOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFeWHNM885hIR/iOiqCbHAXHq2uKmc+rwKXK7z6RaJ39IH1BRTJ+d+KFFTrz70d1KQ7VlJBY+7i0bpayNIw/zLT4DqrR8owuMtq4il6SZdv9WKsT1dZwbYzoPIBn5c1sgwNIQUerzAKYm6NV5KVthGddtpznx8zhGvlt4QR+aaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd9bce707bso18263205ad.1
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 08:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474248; x=1792079048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6SvLzTjNzSdiMNylsVe/w8AxhahIiHxW+GTteqlNxbM=;
        b=fkk6pH8z/8bhc4dCImMEOWeKmnagvT3DpqmJMplq5a+ZGTWZwDrePgE3hQtcEEj+1F
         thTaLPWoTYDudBVP6o1qKv3c5v0t0nvqdi4af5ECCOG+iWtN1nsQjEKa9o9DSAXddEqf
         ryVUBTXlBmnITzT38P8eGfTIYK9Bj2NM/UpDnuR6ZAyY75PDX7qudTRD+6kc8hfcGvFl
         k8P9NeU168xtQChc8cAM5VqfDz0gsKd4DOl8RLG5rXR/vpBqXeI0L6yRy/I1HZBDkANP
         ZutC4wWr2lDT2ZTs0UmmuDYo4XcuR6CrpGL5HTkpRQOP5azjX2r9qDVkq5hMK6852E4Z
         Hnrg==
X-Forwarded-Encrypted: i=1; AKwUvBzN0IjPRWViWyPxPDqe2vFdYrC6NMet5kJOl/dvx8Q/GA55tMrn9nDbXdbhCqf6DBNqyBVI/4O9yQ+GiMM3oA==@lists.linux.dev
X-Gm-Message-State: AFq9FYL0YgpksfaKLVHGknOiam0W/1k+1v0ZtL6pXBco9UXx24DPNIZB
	hA7zHelcbGq5Xh8eVYx8RfzI+qRKcmOhGwtyEIpkaBY7tnFOxqTVizDN
X-Gm-Gg: AYBFou3ZXdwMLkPe/lx6/g+A3sSZ1cj6rcRJiGc9zrqahZJmVF5p9SnhCSl0s6UlqF8
	Fydy7ruHNFcnl4QGD0F9iq5pdaK3CPuSK28vjt70ecFJkx8aHDUemfgxUOMlnFkeEluGoPIxrYT
	m6Kln5hYS2VCoa5n1CVlGUhzGck2fSkYgM/UYCl3a6JP9b9MokGSzxKeS6d0RFXD9rVFoALVbZB
	SPeA7DZeCCl/ksF5gYFSoR7UcmWbhPSWF7i9w/lb7vhmoPpFfMdi9NStHVqyekgsAlbGUJ9ZOw+
	EycuDv6kv36AunjJtuYsYltOrs4LzQ2fbBZCNMKK/U6e/8q3r1qWOi3/eGBVV7j5MdCmch7y8M4
	xhRG08cz8r5XgYvaW2/XlftgVVNgZuGM3MjNHarNFIpuqXWTNINBT2jkxkAWTpYpAyiGGFJzyKN
	6hnpyEh6efzcypnq54ZASO8JRmyakW/OxZu8UKRBwpAv996tc1/66Q3ptbyt9CPnnj5Bo3HLq/7
	w==
X-Received: by 2002:a17:903:380b:b0:2e2:b00f:564f with SMTP id d9443c01a7336-2e600388f4dmr49211465ad.18.1791474247996;
        Thu, 08 Oct 2026 08:44:07 -0700 (PDT)
Received: from foxmail.com ([138.199.21.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604852563sm27443785ad.62.2026.10.08.08.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:44:07 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: kuba@kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: Re: [PATCH 1/2] dim: clear irq_moder on init failure
Date: Thu,  8 Oct 2026 23:42:27 +0800
Message-ID: <20261008154227.10902-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005185335.2f8e8b42@kernel.org>
References: <cover.1790751008.git.shijianlin11@foxmail.com> <8d6a637142c411f83771fda5b57bb4451651488b.1790751008.git.shijianlin11@foxmail.com> <20261005185335.2f8e8b42@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You're right - there is no such sequence on current mainline.

net_dim_init_irq_moder() has a single in-tree caller (virtio-net). If it
fails, virtnet_probe() still does "goto free", which only ends in
free_netdev(). Nothing calls net_dim_free_irq_moder() on that path, so
the stale dev->irq_moder value is never dereferenced; it disappears when
the net_device is freed.

The dereference becomes reachable with the unwind change in patch 2:

  virtnet_init_irq_moder()
    -> net_dim_init_irq_moder()  /* fails after kfree(moder); irq_moder stale */
  goto free_irq_moder;            /* patch 2 */
    virtnet_free_irq_moder()
      net_dim_free_irq_moder()
        /* non-NULL irq_moder => */
        rtnl_dereference(dev->irq_moder->rx_profile)  /* UAF */
        kfree(dev->irq_moder)                         /* freed again */

So patch 1 is not fixing a reachable bug on today's tree by itself; it is
a hard prerequisite for patch 2. Without patch 1, patch 2 would trade the
virtqueue leak for UAF (and a second kfree of moder) on this error path.

I can add this call chain to the patch 1 commit message in v2 if you prefer.

Jianlin
