Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79023203B9
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692777; cv=none; b=BpPeJVVQGvzjohEoMobni82qEFiLtZWZqokPUsbG4fqZGF/mViSZc5zvO+xaR7+nW0kWql79DL0YeRjCGiRZKH6MwE6qQYZi6bgpBZztuNfSrSXCcEYNC6hDWIB9xffJBqrw8I+/H+zfkr214hXc/t3RCHxF6bXwtTpI3usPxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692777; c=relaxed/simple;
	bh=E3RmOwFPZbM9DLJp1tUiPCsma8q5lL1T0OFqGO2M+Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XaTtVsJC2s530vCw7aBpJD7NTR7LUN0dR2kpKgAdEK1TiYakHgyeinw+DtwPMiKcbSAskDQ8pGVjpeAKWnvHxJqSZXjxUxsi020oIZHBWH9r4ON82XE5Uhs96M4Mwvjb1pVucUZqi59TqBKza0vGyuAqegKLBQksg8zY5oEY0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0787fc3008so295938166b.3
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692774; x=1758297574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMV1Ua6hIXmpXxqV2akAPJgG5/fWAzzyW2yIh1KAAI8=;
        b=D97dQItsNPtIe06qp96Gi1L8E1rEiB6mGbzc+sRp2kNyGwfkq6JwjUZ3djKYJ9m6Vr
         aNLSs0fSHBGFmUVR+OvmN+XlCmK3+QPYk4xo6BIympqMSabSiW+oK69gji6XIqoRjjrN
         P98BiVe13XOgCl9eZrSYg0CRo89PeeDUD7Pi+aA0Je8Z4r6zqR+LYkMG+iYvO1ls3HZw
         2nFuo5pJyGRHwCb+yR2+gexlMNN7MDs6tv217CuzldRsTHFnawh9u26WiI3U6r0NkZnp
         9AU+s7OCgzt9ylZ+R5RV9KzUeAbXHJMWKOMuDKsYooGckr80lUcxNPzDlYkks/S6DVkh
         S+6w==
X-Forwarded-Encrypted: i=1; AJvYcCXaHtT6AbzAJHcCT2d4cUQcR8csor2TpKDAt09I0/XsbdlCZKuZo2j+coBStuQVrzDR5xsJFSLSO8KpEy51Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq8nHFKR7YhVUkca9qG2rvmTM8xh8axHeQqTNpct1uQmnyTop7
	R7LqVC8D0rSY7OsnCDtLHz3AxEb+hDZMUcLp2Ddp67KLEHkdbUd9AB4H
X-Gm-Gg: ASbGncs5Lic5ZpS/ujtSitlHaQXYdLQo1Z0S3ot/1mW2EktxEKQQE9EvxRCyCKaDOEm
	ffPecQMNnoTrAJifhB09pi3fS2ZNxObhkB7aLlONOHlMM3FjFc9blnrvw3+tQf5Pn/+NnsGWW1g
	9oDt5H68XSl6VnwgvT1DPmTlbJlyMBwcB+L7y5wx/dMuJ8Alh/evIkmhT1bgHnRC9bh3uXtPJh8
	/SWvCbePHSvbGIpvjGbeuXhzTYE2/jjg+0eXCXGeXBT5Aa6x27twAKb2DdPStOzYWeUfONKe1hV
	csGcOCcPvpwcjmucdtGLke3aP4ZHvTL8n9ZHUBTSCD+ZflEpL05nDQnQ1PBTVqHVZwHcxnBso1O
	wYOxQN/vh+sa5Ceye+kFxWrg=
X-Google-Smtp-Source: AGHT+IHLENQM4ctxSWaRHzD35CXELlPF0xQ2QZDOg0GBNnfAUv8Rvir1NFkO+Ytu+hJ1BwFvMGZuOg==
X-Received: by 2002:a17:907:1c11:b0:b04:8420:b6ef with SMTP id a640c23a62f3a-b07c3a8c69cmr301778166b.61.1757692773973;
        Fri, 12 Sep 2025 08:59:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07ce4dbedbsm110856066b.9.2025.09.12.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:13 -0700
Subject: [PATCH net-next v2 4/7] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-4-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=leitao@debian.org;
 h=from:subject:message-id; bh=E3RmOwFPZbM9DLJp1tUiPCsma8q5lL1T0OFqGO2M+Xs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeWuZjr3Kfzb3cEIXrILv6NIOCvh1c54Fki
 o8uxIbHQhSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 bQraEACMjw2Is/lUdk7WXdz+Ghv59nuekcPDu3MUyW75gBMnC+0hByeAQz30gHvrfK0GUEqQbDn
 HWkVbyHfBFGvj752fpL+4mGnHXEqhVel4OlLMf+wGibcbV0EpsNEinN6+9lbwoX/85lTuhu8YIw
 nmER8s1WD4hddyrcio9zDZmN3auCNdunML5oOSdTd3Epqj+JaoGHV50/qHJGNi3xeGtkDvYfxOn
 93a8Ycez5vsA48m56NdP8o+2P4p3h4HwsW8cgQFBw2Wm6W3uXe/Yy3cyw2PmeqASJPtmcdHj+cV
 wTTMLS2AsfUiATRWuKrBybz8An7DXgQhgsVZ1VbRwiV3BZAYm19ltguTzrlj1SdLKD8dlNWONvE
 G013122HTafoyKx2lB6wPCjorB0ApAQFlBHo5s4uUE+BHuCS4tHG0KM8pORww3WAPt/jDZDAq6a
 h5bjZ0dJcTLSyUTNNACWvKFIKj4sQQjTO3C2H5HlnjaeiH5IEteC/T6gxEgjS2mYJf4wa/rrxEi
 sKM+CpN+B+nNWymHNsUDQxD97ahLq/m+U88Fgqs1A7RQH5ecC9kqa+WlZKaDnVxQiOcV7IZhJVZ
 BEM76fV/e81l9aDelB/2QFZJ/Ge5Pd3wghTs0ZAXm6HEh3+I12poDG5qjftSXRQWXB7iZdQv3sm
 T0+5CwRqBFEGDVw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rx_ring_count callback in ethtool_ops to allow
drivers to provide the number of RX rings directly without going through
the full get_rxnfc flow classification interface.

Modify ethtool_get_rxrings() to use .get_rx_ring_count if available,
falling back to get_rxnfc() otherwise.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/ioctl.c     | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index de5bd76a400ca..2d91fd3102c14 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -968,6 +968,7 @@ struct kernel_ethtool_ts_info {
  * @reset: Reset (part of) the device, as specified by a bitmask of
  *	flags from &enum ethtool_reset_flags.  Returns a negative
  *	error code or zero.
+ * @get_rx_ring_count: Return the number of RX rings
  * @get_rxfh_key_size: Get the size of the RX flow hash key.
  *	Returns zero if not supported for this specific device.
  * @get_rxfh_indir_size: Get the size of the RX flow hash indirection table.
@@ -1162,6 +1163,7 @@ struct ethtool_ops {
 	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
 	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
 	int	(*reset)(struct net_device *, u32 *);
+	u32	(*get_rx_ring_count)(struct net_device *dev);
 	u32	(*get_rxfh_key_size)(struct net_device *);
 	u32	(*get_rxfh_indir_size)(struct net_device *);
 	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a0f3de76cea03..4981db3e285d8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,23 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static int ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings = {};
+	int ret;
+
+	if (ops->get_rx_ring_count)
+		return ops->get_rx_ring_count(dev);
+
+	rx_rings.cmd = ETHTOOL_GRXRINGS;
+	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
+	if (ret < 0)
+		return ret;
+
+	return rx_rings.data;
+}
+
 static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
@@ -1217,7 +1234,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	size_t info_size;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rx_ring_count)
 		return -EOPNOTSUPP;
 
 	info_size = sizeof(info);
@@ -1225,9 +1242,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
-	if (ret < 0)
-		return ret;
+	info.data = ethtool_get_rx_ring_count(dev);
 
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }

-- 
2.47.3

