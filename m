Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634729;
	b=MtoUupxc2RBSlUv5vV6FM/VjYlbmz23rbdXYVvy/eCZatz11uzAi97D+79KQjKVd4H9r
	 8IGTc3H+vTCAA4yv/XQnS/lJ1fiaY8RVprk1/QGE4kmoqz+nuVfMc8iYokYw4ZHwt+mKL
	 vIYQGgMky4JHDD/Zl1B/49ldty+UdGSOgUc6y1FerUfcu515SiSKIbdBqNtZLEQxup5AR
	 dGzznbpWxUZEOtA4n6v98/2vZuadps3ZcmTuPU2twtZsH0sN3IGNBN5azgwpO6yg/wIF6
	 eUC14wTxwydgXGbGOjZ2cTCv0Bbk0NYayBM8Cqo7BBP2HhHTLQL1tt4H0gIOyXMl9GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634729;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=poLpXaD2cnjCIvUqVuMOp8pFOOer5fR1DGYJw/icaNI=;
	b=XKCJHiWvWbNQbKC1+SRJ44tEV7nPPijB96pyZ48W0MxvUQZFn0PplMsp2DIBjNdPAgzP
	 0shZKbY/ksf/b0RAHqU9HqQCYhO9WQse1xxw7VwSlVa5O3fOx5EF1/mYBuCSeeK5jOWw8
	 LlxQktZAUWJfBAAjJWW5Z2LlR1pgYC21GG5f+kVjPYJ1kPPODgBLomTPh4VJSL7YzqG8m
	 IQb2h3gDoqWkQ520l0Ebk+HpJDPd5okBnj1N9V1QRWYt/7fAzKGA0J19lbMnzgTe9WCwu
	 N92D1uF+rZ5jOsxEpkR6B+WWKMoamEB0x8gojkhMQVohnkatDp+bnD30LrF+Jch2fpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=foxmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80723607990B
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 15:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80723607990B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad41dad3faso2175353a91.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 07:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634727; x=1794239527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=poLpXaD2cnjCIvUqVuMOp8pFOOer5fR1DGYJw/icaNI=;
        b=HUQ4dTdqtDqcfW1IGdDoM4+gotgZdwqW3+MzmeDKx8+v46fLuITR64Itv1muNKq0WF
         Fio/A5YnWICn1umaQqk56Q8CNdqjXYzsp8kwjs/rXkWbYxp7ImfgV8B4xutrDyWwCm+z
         APRYg5GrB3qqgQ1hjoUcDvmUIUau7a2xAD6l3zhbK0c7DE0gMcvEBw6ifNdEwypCU9w4
         6gJ9A8qXYSRe8FftTRK3HweVuTiJkCdrQJbjuuiROL8utK+AqT2ZR+zzRWrzP5SNwcSa
         3EgxIP6jNTiqYno3nAujWzMwbeFN8uzUEHHvyhizQ4gaZeExMnRC3heS3Mkv9S6Q4Pox
         6vwg==
X-Forwarded-Encrypted: i=1; AKwUvBwPD15PtQALkwMrBm7+ve9ndTFIxSS6ikL+irz1yIDH2fWdPZuqWye60Sj/XnfydGcQ9JqUvXBa9xAqXshp8g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/BWWzlMnIeFTLDaGf/oBw/zDUIphghN38wRL40rUTMu3gPIGS+
	HsLUj0cn8R/l0lJCNXvzasKMygp8CLU1/isRM/G1wyPzNhRmZ85axO6G
X-Gm-Gg: AYBFou1nNJ7BXE57MTuAqPCupps9U1dy4JoM+cHxgDE2h/M9MqsdPce/COUGzwbVRzt
	U5zGzKCgQfO8PXCcbyPedfBE5AS0TLX6+59yaAUasAJ3A0eoqHedpgofxzFN0oMDTU+yf2QwNg4
	d1bW3UVYQbDzf34qL4fq58L7zVHoPke7MaVLIhzuWuWszs2sAdx11LFpi63Eb4t71HMJlTdDCGK
	60oVInGTFgTqOi3onFOVlpJfwX5xAfBWNvWxrYftX2Ifa8hl8uYwy3Bxn4zeBOTxkKWIfFIkgGV
	5IM8c4WRdBjXigynnqAjjRHV4+E5k44Yiv3+f3EQVEqy+cde9E8yOium5+ATIRTnNIfQjZhqshG
	l4mlikufDNqF07YpFsb5iv/9d9G2RTSHx9QexM6HcZC8CZO/CZbqmRasA6jz8GgegZgLHSMDsTf
	A7vG+0HVqRhTGnfJDWZ+ak6Vl60vdFmdDJNDUi77fUtfLiWnYyWdxkJVbq8D5QDWJFgghYri6n1
	c6KjM/H53jb0vdbRmv2mqIrHfW++gCB2SOyAuvTxAxhEBj/XPMh7GJFhgKsAflR6Ozn+621mLmt
	EKkrhn8+/6Pc5noHv4RwhWCWc7q+msI9BINgJAt9eqoJbQ==
X-Received: by 2002:a17:90b:2246:b0:3ad:870b:b6d4 with SMTP id 98e67ed59e1d1-3ae895a561emr9105964a91.1.1793634726810;
        Mon, 02 Nov 2026 07:52:06 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm14267953a91.11.2026.11.02.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:52:06 -0800 (PST)
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
Subject: [PATCH v2 1/2] dim: clear irq_moder on init failure
Date: Mon,  2 Nov 2026 23:51:44 +0800
Message-ID: <20261102155145.23144-2-shijianlin11@foxmail.com>
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

net_dim_init_irq_moder() publishes the allocated struct via
dev->irq_moder before copying the moderation profiles.  If a
kmemdup() fails, the error path frees the object but leaves
dev->irq_moder dangling.  net_dim_free_irq_moder() treats a
non-NULL irq_moder as live: it dereferences
dev->irq_moder->rx_profile / tx_profile under RTNL and frees the
object a second time.

On current mainline the only in-tree caller of
net_dim_init_irq_moder() is virtnet_probe(), and its failure path
today does "goto free", which only reaches free_netdev(); nothing
calls net_dim_free_irq_moder() there, so the dangling pointer is
never dereferenced.  The bug becomes reachable once the caller
unwinds through the existing free_irq_moder label, as virtio-net
starts doing in the follow-up fix:

    virtnet_probe()
      virtnet_init_irq_moder()
        net_dim_init_irq_moder()    /* kmemdup fails:
                                       kfree(moder),
                                       dev->irq_moder stale */
      goto free_irq_moder
      virtnet_free_irq_moder()
        net_dim_free_irq_moder()    /* non-NULL irq_moder =>
                                       rtnl_dereference(
                                         dev->irq_moder->rx_profile)
                                       use-after-free,
                                       kfree() a second time */

This patch is the prerequisite that makes such an unwind safe;
without it the follow-up would trade the virtqueue leak for a
use-after-free and a double kfree on this error path.

NULL the pointer after freeing it, so a later
net_dim_free_irq_moder() is a no-op and the device is left as if
initialization never happened.

Fixes: f750dfe825b90 ("ethtool: provide customized dim profile management")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 lib/dim/net_dim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index d8d4f6553559..bf59deae6a29 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -141,6 +141,7 @@ int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
 	kfree(rxp);
 free_moder:
 	kfree(moder);
+	dev->irq_moder = NULL;
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(net_dim_init_irq_moder);
-- 
2.43.0

