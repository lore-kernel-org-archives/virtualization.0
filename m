Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B513362997
	for <virtualization@lists.linux.dev>; Tue,  9 Sep 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449466; cv=none; b=QYvAvcaTj7x3N0hNDNAQE5POpFAlX5c8wcLJ9I1vtFPwDreQ454PNTsP+cfFungINIjFCIkk5isVRoI6XzoviWcmyMx5L9szZCibXkcjjdVyXfIkcVrW+rKP6vDGFBVLGnmljPPEKkbHzx6S0U135mvn3OZ2cRm4t/ltW69opRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449466; c=relaxed/simple;
	bh=rGTyoDxW6dniJq2uBce02DiKwlKe6t3Nu1+QaklK9bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gf/D/QJQ+OnP5STFP8MI7SdmcwKFNPZN4tnTRmE5IKB8JiobI5H5C1VYfPNghebG1LDpRqzPdKvGnYb0IKn0PMcTciV75VQsNq3iEA+iWuEZK1qml9SLy3CnLYN89FIofivY1TnMVzi8Hkrz1caOFPwcNohtgQj/D+3bdEqJCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso7816120a12.2
        for <virtualization@lists.linux.dev>; Tue, 09 Sep 2025 13:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449463; x=1758054263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2IZLnKDaaFnjY3D1IJ8KRAITDlxiLL3yuBuxLzbLqs=;
        b=FkRHBk/2+V/vMVVdfhIiN4oWrkgv6j2XpuaDNX2dh0gevt3M/wU7MpX5jZe+Xr88ds
         fw5LnOi/lANWNVEu2Bh0MeoFiZVAKZBIZxbkXf3tkqQ+4m5D6YMlvBzw3RpZZFr8bQZv
         L4Yr1LiHguLYW4qM6SpCRCIoH7aIT2/R0fge4EufIlCaewIXoPoAJ9lBt1p07ycgNljx
         fiqBX68jhQ6Yuh5wWuT0MEFLZ6q6EPL9An3+s4/EzOqkJokMaBmrv/1wOus9uWrZRp0+
         7+KMN6f/PqgFmZtWc+Jy+IR7JpJPHwoFRXDpmm9nu+4cUj4ix28a26KLhPjbliBlSMQC
         BeWw==
X-Forwarded-Encrypted: i=1; AJvYcCXwjqAviiHlRhdDm7d34V0krDrqN14F7lp1nOEPHZlxBdhROnaQvE5+ZOgpIZfGkhxz1MMX4rU0UK2SwKOEQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoINS8uCeUptIelLlCMlAhuu60gu86xlYugoRZmPZ5xqyNDK2R
	gj+lTOwxCxVZ+ZyUlGAo3IW2EfJS1UpCnZWJM7Jfw19hn7f6aQpxgBJG
X-Gm-Gg: ASbGnctcu9CPkGuQE1S/UaWBspQvgXskzABsfkN4ttaGaPNgz721KHYG7SBCzlrE4n3
	9VifYphcooC8czkmZSk6JtAOVctUU8maa8n7vfc01sse5T7olzOmNMVswTDiCK1U8mgKM9jUN7H
	mtWw1qxSfero07iTnNEwLhoGyPUP4d0/SBZ3yBt5thLPyVnBhHKJu3mdrgFqj4X4n2csHpbicg/
	PN4eNIni5sHEKeeysl4AMRYR1QLXbHoHO+doXaWErnB3TT9DoMiFFVrCvAGsQ8YgTgOlcxvAvIW
	iRJ7RRExXHIJ7unfEBHkoPXcUnvcIjAr29Bs2NzNX9Iao4gUrbOWJ2v7B+XIejmeDc0VpLo6gv0
	QWn3HYGPSwsa5hblwmfRx4GoC
X-Google-Smtp-Source: AGHT+IH+MixYnWFpW6gFxe9vfM/NQEh+mWmrjwj4RiBDENfb8FMlO0RFTY1TtnmjZU+2Qmj2UKea2Q==
X-Received: by 2002:a05:6402:20da:b0:61c:f56e:6cc4 with SMTP id 4fb4d7f45d1cf-62378ff39e6mr8397823a12.37.1757449462440;
        Tue, 09 Sep 2025 13:24:22 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018007casm1844239a12.35.2025.09.09.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:24:02 -0700
Subject: [PATCH net-next 4/7] net: ethtool: add get_rx_ring_count callback
 to optimize RX ring queries
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-4-634282f06a54@debian.org>
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
In-Reply-To: <20250909-gxrings-v1-0-634282f06a54@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2914; i=leitao@debian.org;
 h=from:subject:message-id; bh=rGTyoDxW6dniJq2uBce02DiKwlKe6t3Nu1+QaklK9bo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzuYoiI266NQJivEzOImBy90y91SA8Qpzjtq
 o+oo9gYATSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bdZpEACNDpPB09wwGkIfB3pH5t3fLtmFhnkPo7FtOEylELfYNJClbh3gzCyJ2O+NL/Nx/+efo8N
 DZHV29CKiG2vl1z4r0kmV6FYY9wb023QRAP/3lcEdgWVF7rrQJ+dkfAuHp985u6pmu9jvJfHzoh
 lcjIFTEkFVCCDUwzfvtXDEstzB+oKtWFs9+z16EO+l+EsckiX4AcLmwViVPKQnDubosW4nAamJ8
 DkGCutDGKd7cbthzE+8EOZK9JNz4CiLFYBLm7hxo24Yx4H8AG5gUq/KN2RIO93v0buHvFsAEtX5
 nG1y0zjZlFJgT+oBtnQVh/nbAlHJcNI+iwzIWDLJ7gFsP/3B5nWzk47EAuQxKAG8yT6G09K8waj
 0TNA+5dAzKoEa0c0lgnvQ7HzUCTuBu+26CwByzV7EU4XqYSukHxRE8+kpMmXyZysaCw9HlN6ix3
 77CczJdAqa/+1aUVn9yJDspMuMJ0OjZgM/Ygy4fzZ2b2WdI66V1gBy+4pd5ZswMgnhEcmdpWUfL
 L7o1E84GVmpn58Zxz1Oqz/XFakzX/sA+KyyWTthPvRPfDynK1iE1cyUEJVS7HnTW9bUiXXMJuit
 Zl1MqeHxs9/k70Ha5fyPmBpHmV9qbRhJX8/PfuTsaO2hrIvJG8nmr3rQy3A2pbsimTadUxPyvIH
 NCQRlrbrc6rHgpA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rx_ring_count callback in ethtool_ops to allow
drivers to provide the number of RX rings directly without going through
the full get_rxnfc flow classification interface.

Modify ethtool_get_rxrings() to use get_rx_ring_count() if available,
falling back to get_rxnfc() otherwise.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/ioctl.c     | 22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

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
index 1a9ad47f60313..aba483bc9fd85 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,22 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static int get_num_rxrings(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings;
+	int ret;
+
+	if (ops->get_rx_ring_count)
+		return ops->get_rx_ring_count(dev);
+
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
@@ -1217,16 +1233,14 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rx_ring_count)
 		return -EOPNOTSUPP;
 
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
-	if (ret < 0)
-		return ret;
+	info.data = get_num_rxrings(dev);
 
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }

-- 
2.47.3

