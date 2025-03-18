Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95E207DE7
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291827; cv=none; b=kpuhYfTiqD3JKcy76p63KjTVrVn3T5W0+k/Bhu6Lg6Y4G3OOzpC/kjWk4sGWR+h6SW+QCVsnWejbGwAs9wXT8KVBNUlMXhHrCSc1BGWWF1UWO8UAFM79BNgiTWXE2dtsm3K82aLZm8/JhyRiMolzz9JxxrXZPVP0Q2w5rqdDSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291827; c=relaxed/simple;
	bh=y7xGmXz1+joLuyF7rRKoRaRnhcPRU8zLLhDGbCzRvUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h37hghx2tt3tTBMS91G18z1IdY0Gzlh/bfVzpC9FqhuVhIhfzShm0+GRo97RKEe09aCaPLOQWAJ6wCuir5lpU5LwMHZ0kieiLa9sDbvsVSfCAZpGXs6wBw8hLoNElJuyDnGfjF3GaPbtngY3EEU+AQFTW5dYcyPWFm5Afj7Lh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=emCzVpn6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="emCzVpn6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225477548e1so92862685ad.0
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291824; x=1742896624; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFcdkuZXdG0nFv0JVqG4IlwwkUXBEREwH0bBsZlwErc=;
        b=emCzVpn6C33P+FtZwnkeKm8JIQyLp57HYKEhwruxe0RTh1zg+VnxaB1f+FwzZtxk3t
         muJGj7+gfDrolm5+Y+t2uWcFimuFToYNxZdNCmFmRzkLkUwP1d2UnjgVNho/yNKB3H7r
         ppEkqqMJFj5wVI38mO+aOkEb933r2sTDtvD/XYB35rOVClMNeja5l1pQKIY8FxNAYP/i
         aox4E3SDACNjrLsjrd5QeqA/42QY+QtYWdd36sj6XfsoHWdt9eNZCNlrGgCIcpj/tf9B
         Gb2VskX/kXTDcfYdo/jIa/okR6TWLL79xi6gu69Pri38JV68lYEKA2B/Du2HPZ4efNq9
         NMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291824; x=1742896624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFcdkuZXdG0nFv0JVqG4IlwwkUXBEREwH0bBsZlwErc=;
        b=kdDCdqlTKnC7uKvJZFQ239Y1QbWcxhIf+c9F48cTNmXxjPVNMO11ftaamhxcn/XQm5
         M1SABcngs5VEwaZDlqm2YdDaGevYF/eucIZy0UCMA+SCkMCSvW/JrugbCxgFmryhJaMJ
         QKKmbo9RbhPileCwuTmWDoKpS6Iv5GXh26mFj619s9I7QTr/38HVabVyHAdQHfNbCHs5
         DDw1Zg9KKHH9B1n5iCaoYcCILWBV9LprwaANIEVBtbtj4AhqZrXIQkHAhXXGRW1PbIxG
         HVdxawZuDH0dPJnxCAoZ+82PDzyxNEkevO50tfKWvDfTF5X10DrQ2hrWqYySLHRCODEO
         DCpw==
X-Gm-Message-State: AOJu0YzQpIdHThpau3LO0mNm0i03+0FE4lVyB9sW9JGWuzZVSjUAsE+S
	dAekOc5LMbbEmucgDYX8acWSkSM2NVIXfbcLUZVnSwNNzOWG7oPBhhBSvF8ligQ=
X-Gm-Gg: ASbGncuY3Jvxh2orktvbtyII/ZkTZTWtHhdhv7WeDWiWRdgoHytDk4o0GbV0oTREZO4
	fT0iNItwquSKwtVQBwLqXFxyaHruRlAODPYoMLgYLcVasAob0PH7q0iAQlYsGFy06WK0EGGPCRK
	mVa4/cx9Ld0X0KOxjBUH5I8mUFcewUWIOwaSqNrdgO9ojubCTnFj+PtccUrqPSdoSR0pOfTSxeW
	04hpg+e+ob5x8T1oA1XqGirhmwJPProPUjM+Zgw+pBJx0dSm5gr6S6SeAT0OQ4QvSC2YIVfF00A
	tqlq1qC92wnzNnU/cRhupdj7sRE3blboQqjXeKQIcF3C1eg1
X-Google-Smtp-Source: AGHT+IEDg7sBznXHtheXcTwTR0qQJ5XZCTzq1W3+7+Ny1lJUvohFaD6bIzC8LuHltfp6YLS3zy5cUg==
X-Received: by 2002:a05:6a00:2d95:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-7372236edfbmr23606104b3a.8.1742291824189;
        Tue, 18 Mar 2025 02:57:04 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115781f3sm9150521b3a.76.2025.03.18.02.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:51 +0900
Subject: [PATCH net-next 1/4] virtio_net: Split struct
 virtio_net_rss_config
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-1-344caf336ddd@daynix.com>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

struct virtio_net_rss_config was less useful in actual code because of a
flexible array placed in the middle. Add new structures that split it
into two to avoid having a flexible array in the middle.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index ac9174717ef1..963540deae66 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -327,6 +327,19 @@ struct virtio_net_rss_config {
 	__u8 hash_key_data[/* hash_key_length */];
 };
 
+struct virtio_net_rss_config_hdr {
+	__le32 hash_types;
+	__le16 indirection_table_mask;
+	__le16 unclassified_queue;
+	__le16 indirection_table[/* 1 + indirection_table_mask */];
+};
+
+struct virtio_net_rss_config_trailer {
+	__le16 max_tx_vq;
+	__u8 hash_key_length;
+	__u8 hash_key_data[/* hash_key_length */];
+};
+
  #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
 
 /*

-- 
2.48.1

