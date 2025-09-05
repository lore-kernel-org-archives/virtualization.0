Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B92374290
	for <virtualization@lists.linux.dev>; Fri,  5 Sep 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092067; cv=none; b=h9MOoM20KoO2gSrMCjgRL4Ko/1Vsz0HQwCJRuYDpKRGMgOrCNYR1G4tupmVU5JalGVL2srnqFv4qxnTKEjkKIn0zAMDqc91tivzbY8RbYYBsfNWdXlKfMJhTp4SXnWWcaMOlIy7EQGfcd978j6GjqD7x0DpkzbTF3HN07vqgLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092067; c=relaxed/simple;
	bh=3aXidoCnjwjLlFAFt83SYhSNY9u5/DbQjFuEPX/ClMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUhQziS7Hx7EI7TwfbOcaOlmM3bbNnppdLYZq4Xb5mU6YsgqHiIqa0y8I5U+Z62zZ0Z5/hdNKPpP68b5WVnIx1pmYC5D+nLrhath+/xO+m6LFuv1iXFG2BUN4mVCcUp+y7u4UAgYZtXuWor8A6HSZZk2P2qwdxPfA8tgUPs2mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-622fbed96dfso429508a12.1
        for <virtualization@lists.linux.dev>; Fri, 05 Sep 2025 10:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092064; x=1757696864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPOh83BwsxUoqeI+xJ5O/OzWhrMRpIrMTjO1JPoh9E0=;
        b=TurMPkanlj8IWz6pbURjauD2rsjEldVv4jYfmx3Uk/PtKNwys+8kbUjJ0m5gnmAmN3
         X9EbHxPQX6/RWlbUB7/Mp9mPWrBIERyGSMcwsAqicWtX8vL6UcgbFNidUj25pdzOmUD9
         RuLMVkXsulWTYXkF25DRPMXdoUb81wqsQSKHWnjmK2Vamo87v48csmwvTOKwLiKyVAVl
         0yBDrphnLBypCXU2N0VJpDwa8MdNnjvTrulYnlo9WQ5GUr+H2vXRh0JFmO9ZPZPo2X5L
         yHoVF6rT8XtjzoSWexoV+oiCGL7NpQrQpveNuXi4JFeX7BADveizearav55qsAvvkDeg
         RoJg==
X-Forwarded-Encrypted: i=1; AJvYcCX++6jWJYnwc5NoWSyeprNBrNf/C22rusI3tSm+jxD7CaSKUITg+B+CG3aPErzK+2d/qj2imt4NtkwC79LPhg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0rYbXtInW3Tt70xREeJSPjNAh/4F5EgxpGoeDGICHrzDkayKU
	gFG3N97RuEABc2fAlXf9eDXzPoPmQ/abN4JDYrmG7zslZn57RVxkXZuA
X-Gm-Gg: ASbGncv7XrJYCqUGFuV0tvUeZs5avrm5XIWTwJcSvHwzGNK8G7fDYWcba8a6Jvi6DqD
	YHvuFb03GUADG/TQIgQ20LfdTa5Axtb3vTkpM5eDnkajhKESaDT9NEbMhiyEjj8tU95l7rjay6U
	y68SFL0tKquFkIcp0kWpdKMPXnzeCiBaU3d1EBOlwx0xDzOpDwRtkuxKIEsZr9gGSVvPzqgO3tu
	Mjec3MpuIrdPD/MWvdVvaVAr56nIwxaIGyVFZ7nxedSfDJyKsYrf+9PmrtmDJt6S11bWYZrQaUv
	SShi5V4JvhLi2clPeZPp9A1fXlHtW5XC9GzaaoKi3O2Lm83gSrH+0tiVz3+j0VTygbm+N9tIym1
	AXADkowsXU13E0+k+9Tn3K7OC
X-Google-Smtp-Source: AGHT+IFHB/021clnQGQ9l2V/ebhPpnhyDNv4aANIU9IER24mAVYd7lakHWEK5C+0sF2ladD2UZSv7Q==
X-Received: by 2002:a05:6402:210c:b0:61e:a5c8:e830 with SMTP id 4fb4d7f45d1cf-61ea5c8e868mr16151197a12.1.1757092063706;
        Fri, 05 Sep 2025 10:07:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77d0sm17028678a12.11.2025.09.05.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:43 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:26 -0700
Subject: [PATCH RFC net-next 7/7] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-7-984fc471f28f@debian.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
In-Reply-To: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 jdamato@fastly.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=leitao@debian.org;
 h=from:subject:message-id; bh=3aXidoCnjwjLlFAFt83SYhSNY9u5/DbQjFuEPX/ClMk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjSrAs1Sm+xxMdVGyejtHHGgv9lU+1AEZcr8
 HRgIm5+yvKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 bSzdD/9VZrqjup5ByMvV1ARdrXaNOQAT0EzCwe6eGJSqbeLxU6C5ECSqaD2RYn6tKOwqGGwr0aK
 KNWlZc7acHG7tdwqHvzcctsE6HsC5bFDsVO7N4AdhNiZtz0b/U0FLDYas4mtVQyw68PRhffmMBX
 boWG8bfFtjAj4MvMwVbFlWNYsIbL/FNHgMx/7zj5pLzAWB4HFASzWEkpq2dgQdittZ05EpETn1u
 UMRVxB5cG7Gebm0jD0L86pan6rSQlaLr6VZDUN+zQkUsP9aO9YY99Zux7c+u16ZWaVS9AskwOze
 ce80xTgM9pgAz9S1WQyDCC0w1xLbw/zfZI2Y3xTUpD3oRC+QmRBzezdCnD3+6inNbf/QyNGqwpL
 30d8WBTuEcCMXqKPYwmWgaEL30ljXdjT89l4Q4xyzMgGLc3WMBxLXUlFVq4AfW8JeSeIpITb/lj
 9RX94ORn0vcc4wgenLBxht/1Y0JIRyWYr7JIz/CIfhlnbEl0VSaCNK0gFCMKf6u7DYpd29s5tZV
 l1WXHx3tdLMBIFtlbM2dAzS9eBBb8fbeh4QOju85Y4GOs5qozuuFsLZETAq1ZkJF1PdzeTWg+sP
 /1ig8EsSB8pIvbnuafh054c5DHfMc2I1IFr1eeVvrnu2Z3LzDJroipiBciPKHFPubblQW/PfxGa
 UOYSQ23i/cdj7GQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace the existing virtnet_get_rxnfc callback with a dedicated
virtnet_get_rxrings implementation to provide the number of RX rings
directly via the new ethtool_ops get_rxrings pointer.

This simplifies the RX ring count retrieval and aligns virtio_net with
the new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84b..942ae55e8897d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5610,20 +5610,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+static int virtnet_get_rxrings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int rc = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = vi->curr_queue_pairs;
-		break;
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
+	return vi->curr_queue_pairs;
 }
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
@@ -5651,7 +5642,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rxnfc = virtnet_get_rxnfc,
+	.get_rxrings = virtnet_get_rxrings,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3

