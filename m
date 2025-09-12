Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7633191B1
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692772; cv=none; b=uYPBsaRRVDSTnEZyNtHl/EJ351sK0mgQVvMZAots5NxC/thzLavMg3i8UwJpoAx8rNnHbuYCCVwHMLSA58czoP3VS6Kx9oGaLzHycFJ1CWIbrJ+qd0UdfruSjL/vrRD0E0LwFFf6SIdNA7oFgY53nGbiHm+VFZ+Cq+oLmP9Qwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692772; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FL9QCrRwz/Bgr21uHrJ4FMUrPChg1YW18onH/wPkAPVPkkA+At4J/1M2s/lmK2cSj0ZEYsVZCvjZBU92eCmEXczdq+OVHh0n2B3ywQdSZHr8f3tdfQDst6WcDrwJXagXHdEc1KVqkXMzSVwtYkm6VFih4m9v9bsSSiUoTUsZPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0787fa12e2so305372266b.2
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692769; x=1758297569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=IbdpWr4D0c4wQCu1wwO+IcCqtYKNNfJ+3khqjsMItJnp6XOusEmPR30Zkhsi3yzBB/
         mEhU/BE9Jcysq2b2Qry0AHJVD+XXKIcNuxY5YJNNEha0bHPu/tpbAd61SUPx7ASD5iM3
         MjNiFvhXDtFqfthwaGLxsB7lB/+Y4PakSR83Z+3q4TtpSZeXhqIDQy228c93/lFFruDv
         cgEng7IaBUyyrvfyhHT6p2Lpo+dzJQ0nrXOkuhZmdMbXZHE4Jrc3oqZiD5pxDyOyjCca
         AjC2Myl33Hg9mo6i+k/zUGrox51Ih9QuBNdSAcBYwfsiHYC4JQbeWr5E4DXTZOiCw+h4
         WScg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Pq4icrHj0OpMfPBpHMBIoYmo6f9Hjj8zEruGQpeRz2sqRhAJWcZ5iwhURRqb5xuvAWYq4IUZJTxUC2idYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywus1u/KiuJK5TUhBAFtHY3P3S78dwVuGX90IaPaUslT0z0fCTJ
	tc0Bh4nxmfBJb35lfN9LWm4swRvvbBul1D5pFKLbOwRZOBKm+Ku9R9Te
X-Gm-Gg: ASbGnctdTlbHLyYV2w4IdBgW/2I490lsnNG4piT2N18qQdGMsh6woYpC4+MIr+scUAZ
	U7y9uiH2hw/OG6ru8lr6DucvdW+YzZCuFRglBpnFXD5WgIGdh3GEqmuQ4UTmCYsRJVRIA5A+9uy
	mXPBOpyxC0smtLLg3u7AVmwH3wDxEZuDs+cJGan9KO6Yoj8HJ583A0ybShp6GO6F8pQWRmpuUtl
	Qmemvebscih/Gcg/AnGE/Yy/Wt8p94wAejwJq2F/rzFRHDzsMubQiBWyo6Rp5vKbqPsQSlw8ct1
	HjUmrfONZ634+7NTvdF/vrXUOw5cSD7qmf/XVH2qta3dztzIxh3hK4hu3RfPdRoyDF2QTcMM3SE
	+eVQi3QbdatzyK1EKoIqbghs=
X-Google-Smtp-Source: AGHT+IGwXf3cEKsabQt7Cpv//i35Dk3tdl2J8AgqN2uAsDXsRwu0qjGwDDuOq0Zb8pJ6XlFCPXpkVg==
X-Received: by 2002:a17:907:970b:b0:afe:85d5:a318 with SMTP id a640c23a62f3a-b07c37fb563mr287369966b.36.1757692769279;
        Fri, 12 Sep 2025 08:59:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da310sm391317766b.20.2025.09.12.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:10 -0700
Subject: [PATCH net-next v2 1/7] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-1-3c7a60bbeebf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENdgqKr9Fqt+M3KsL86YnjoIRFj5P6h9BlZB
 uvzTHP8ZW6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXQAKCRA1o5Of/Hh3
 bZWsD/9ifi1mU7JfHUYLeM/FBblDRGtwn1dshElRb3dsckyN4Do12PHTEBk+mROTkHyOiYxqG73
 jiVB3pO0P6M1TGvZqfrwN4AZoCWsD1/U66QJDwQbVBumxJthXRVJfWlrbhqgChCWw2/+cjEaY+H
 KbaZtTHHNrYlCnhExil8uKsHkQnVpKiWPe2yTwAfvq1tCOzyAPNqskm59VHesdt2uVirAFeWyhn
 zr/1rHRRWH+NoEZUxOEpuMG4OFgjMSdtt6yOQlABdsbDP5aigu8eMGCXoA2PrTPDjvaFuFwxKLn
 5luWHIVPRD5F7zOu61nWpEjzC3sRbW1iEpFpt5Xwhs7MF8R3Tr+mNnN0dIdvjYXMK9XYGOl9ghX
 aZk0NpO5ZFq1IVwfFdovmudMo/iWo9DLzG9Hlyriyk45UR3Pp9wzZsjh9s0lCJjRhTsgaRSPqdW
 b3dEyQMf2TgMuoKBEZ43ghrlFVN0l+HA/3TZvsAO1zdphnET2omx04CFVxAV497gcanQNjXnk+0
 Wdh8BZTfE3X8mZvGe4PID3f4aUwUWH/bfkZMtULEMKx5c+b+UCSRtL3vlR6wFlAaKn7fPuI98Jq
 LILPXp8tedMFLh3xUIZEzsDp6tNVydkX/R28E2bVGTbyPE4WfWbUfZ4ln9xEZHnrGKyN0MEHhrg
 CcUQMWg52gv4n+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_copy_validate_indir() and callers to validate indirection
table entries against the number of RX rings as an integer instead of
accessing rx_rings->data.

This will be useful in the future, given that struct ethtool_rxnfc might
not exist for native GRXRINGS call.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b2a4d0573b38..15627afa4424f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1246,8 +1246,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 }
 
 static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
-					struct ethtool_rxnfc *rx_rings,
-					u32 size)
+				       int num_rx_rings,
+				       u32 size)
 {
 	int i;
 
@@ -1256,7 +1256,7 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 
 	/* Validate ring indices */
 	for (i = 0; i < size; i++)
-		if (indir[i] >= rx_rings->data)
+		if (indir[i] >= num_rx_rings)
 			return -EINVAL;
 
 	return 0;
@@ -1366,7 +1366,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;
@@ -1587,7 +1587,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;

-- 
2.47.3

