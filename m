Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7538C2A0
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756467; cv=none; b=YyxUVuWhrg2ea37777vSstuqxRic4URvR69EqkwULHRaBae+CLXcwejy5tdqzwRf4fxFdA6fL9e6d6kACHQrrQB6c0cfLqikYOkRGDyYPQl01h+Ct8CoHuMgz459bquWq9XQuMwrqAt8NoP8tLQzawjJj06lWi0ppCTNPrfKgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756467; c=relaxed/simple;
	bh=EH2ClwoL3M6yVYOwkre3mOJduO5W/XN6Vq9zM16CB5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6mSkuEacQ7rpo8C5ZIdBLyEe9bpEIvhtijhTRhSgIhMAgIeCO2cQDnNLz6H8cPZEZqK9LHgmvQL+DnrDjPY/6joUMt0JJLTjF2FZm2IXvG/DJ3DnSH/0KELhk4R4YNEQAd1uweBG6JNYOx09CKsD8f+VWlAgDdz9uezRJoPORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc75f2924abso3504531a12.1
        for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 01:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756464; x=1791361264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqdxT67lLu+zzttJbC4gppTruXTdwqprw/04FtUuWRk=;
        b=aP1HO9rvEUd4GUYvMHUkxBmcllbApQ+RwBaylhTSgdR9M3jcOrRiH6oXCbq8nBPtKW
         DHU8tOkAdIiW4KMo26XUc5w0zPRTHMXBrPHByQfjY/B0H37usKSfnNXK8YQZEP2Aib5W
         odH2Fbwb01Dt482ywzkffteHJ+Z4A5ci8q+NxO9s1UfNPl9Jzw5tIxQ7RREAAHOOCBW3
         8go6P43TPZElPNFq3I8xod+AUQj8GW0uCJn4Yy0b3l+hdIutGimKsJN3cw6Ti1v6uRf6
         afqGE/yFOSdhlemwi7HtiXTGt5u5JTMjV5pFlhGOlcaJX5xMOTTMv1Nxz3iS15TwBeeI
         ldgg==
X-Forwarded-Encrypted: i=1; AKwUvBw7rHLGCa7XYRb0jfrsPMUV4B0cXCGpxPYysyng9smvzDfzjVscKFcmMRK6Ds2Ppks+HnU8vV7oI/SWrxEfPQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nl+E74fU5K4TUIcSYTrI1JgGfm44gF0RC3n2qgwpMRMPwIavh5
	ab5KhxgMSn+IH3jFPwXX0rkMZE+KfxVp/Z6B79TMXCXT/Dd2sl6BsL+T
X-Gm-Gg: AYBFou1k07nZYpb1jYSr4Jw+o1JikFO9OWid9g+6szJM+QlQTJ6TP6hy4hdcChncw33
	jBotXOpnarK7rigm/2V9TDZs1anwr02Cg7FlZob6NDDt9et7K4XVxvXA/nhg6830w/DZf8uvonm
	/+DHpvHjqw6eTzxjvQG+CeeLUpkbtYk320koxtzXI2nSb/D79HSqjDXt+VwqACkYI9AyVc+i3O2
	i0QUhDwnRurHnUiIO2C0psGxHo8+BGDQxfeL7E5ZepLpa2ol5FEjNSOdLn0dbXyOTla2r54OaOq
	h5138b5mZsg0LRL0lB+GgoYoe9cPy689rlPR8zd1KfInuSHPytqVCVEdhSwkP7i3OrOZMPQdRow
	UGU812E8ceFrVziP+AIIFGIi9m+NEGV3K6p8+QJLW7gmsoKTYOeQy/OYLV5s+ghuw1UAmpIZIYP
	M7Qsfyd8mVXI7oUpWr2WB2AOpuGRp6KLnJ6TktlGAKyjorLYSK7SKKdeDemOMBVKbHRJuYBSUn9
	dxto4ELp1FJReEsQKY=
X-Received: by 2002:a05:6a00:2e2a:b0:886:cae0:fb69 with SMTP id d2e1a72fcca58-8874d0abc1bmr420479b3a.44.1790756464283;
        Wed, 30 Sep 2026 01:21:04 -0700 (PDT)
Received: from foxmail.com ([120.239.72.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8872643904asm419955b3a.45.2026.09.30.01.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:21:03 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: [PATCH 1/2] dim: clear irq_moder on init failure
Date: Wed, 30 Sep 2026 16:19:51 +0800
Message-ID: <8d6a637142c411f83771fda5b57bb4451651488b.1790751008.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net_dim_init_irq_moder() publishes the allocated object in
dev->irq_moder before copying the moderation profiles.  If kmemdup()
fails, the object is freed but the pointer is left dangling.
net_dim_free_irq_moder() treats a non-NULL irq_moder as live, so a
caller unwinding the failure path would use-after-free.

NULL the pointer after freeing it.  On error the device is left as if
initialization never happened.

Fixes: f750dfe825b90 ("ethtool: provide customized dim profile management")
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

