Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B8DDAB
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766973309; cv=none; b=puzZId6cTPUvxPmmf1m0rcuBCF8/M5zi7tnxInrzinjiEnQVmJl8O3BwE+S9pYvHfHrimWOilQW/TwW5r0lmF5+oSnjcAPjMC65QIVhm1iDcPyOzTK1WjTPf5oAoxfcfhz9wlmDB62d/+BSngEishrzP2VQk42mC8FLX47CgJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766973309; c=relaxed/simple;
	bh=vyEgeMf2uqW5VB4nieLxhnduvrdLalTDDvg+5iSNH2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrvAiz2uZAhggUYMxBSIh4n/ml+YjBLyajgHOZ6Ij7cmFFzfGp7mn6hbmLun8beJLA8H123dAoeR3xSlCt2wyFHPROLhsqytc+5aPnzNFvsqDIJvzGCTmn66Bv0YHYHnJhLOUT+Y1pkEPX0tx12uY6D0r4uzQfRNYkmr3DS+Elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyn9/Qip; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyn9/Qip"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso91360075ad.1
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 17:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766973306; x=1767578106; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tNbndnUAKE4QFtio3tegbJFEwnl00q7Bud+tWf5WcZY=;
        b=fyn9/QipoZjeNyLt9JM7Fhouf3XfGZwMcVCTYC3SdRLZl4I1bTiIOkFbtibc/F1zkM
         0qKt/9De9ztrF8FYFIz69UeNVyBw7dryW0H7cTV8C6gjSorsYd/j5SJE8uV4ywGzbzuJ
         kGhbrXwvBSt22DUtwnm9Dp5QJvtOWzmvQx0V+odQZRIWd6Qm6o4AseBzyB5kuZgPVNde
         vuirR/eYLTY8BE+uGEK/TVNsPnydwQhad8CxeHKPN2VbN4bGYBPeTcJKnJ6vAuCEaZB6
         fdbMpmidMflipeIgdmkd2TFj4qeYKlnnsbYiR0+TjQ9eu0oNzBE0B370dR1kg0mf+9Gi
         sn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766973306; x=1767578106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNbndnUAKE4QFtio3tegbJFEwnl00q7Bud+tWf5WcZY=;
        b=AEoacYq6UZpr+ufcGKoEF73Q4edSuSN6DR+YLeW28OVW3SDQ6PCjXzjZUQtApBqHlt
         jIoq3QpE5d2iR6x7/Zagck3Fz0LdFD8PAgwp5G2JK1UpPAI9Jgs3yqEZFYSi5sRjkv6q
         zgh5V0uuruIGSKM31efh2YET5LHGH4Di2a75eC5DUlsFZQKSIsd12Wbxy79u1Xrc9nJc
         /giIr0PjL8ZMElzwga4jW+UU2fL7RVoPruWPXqRRG43G5cgkaOj3mrkzftHdZoDeTuHF
         uGwFSja7sWhIkk2nqZPE15nJa52FLkxqwOMV64xlsjBawmTc+n6zEXL4ewLs71IBsWmr
         0UfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrvBKMH8pCHGa8NOUAYCqT8CBH8KvHIIxASeEAMIbP0FlVo6kHsMT+DXaTTSwm+cgdkQnywIFBrKrOoPJegg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpkAIrhkT0GjKpn0PDT1wIlTAP8uP1QsCkfMAxfdpw3LecCCzJ
	GNuZyXhHNdsEt8NAG3dds3EaYEHEWoOoA8mLW/wKNrZzqzTDbvL2rYvc
X-Gm-Gg: AY/fxX7bcEUrGFHbyM1eXi0s0+glK1dqg4QGfkNSso6pmhnPfT8YeftyKEil/19r7iW
	YJ4dK6xlQv6p+I4WoS2a8utrzPfkErJa/Eaa9OSWjSyCuhUY0+ENJiYR0p+aq4CeDBRy/eLyoDm
	C7z5L+eS+1/7i/EecE84cdtY2ZimirxA+3bUvaY9NU3G4YPvulcIb+d0hTKLSCaIXUOo404N7lL
	BuBe7gAN22CK58r1al4Qk6TC0sC/ecopB5Ru2gTsVAlWFTqmBFyskSVgl+99yZcYp1Yt3MQaJ/3
	T52OteviTCYFxwLvX6HJM5FmzYIZTc6K7SXBYRE0VVehoJkVBrdEoAvz9MsCMmkDCzXqU6FW/yU
	jgSMWU56lqdD3f42+9byl7AESTmT9xzbcF4a7/rKnisdPoMiplUSbzRGeDtqMD/DTETp1mw7rdF
	0i7U5X+NOucBYrE4V17d/RLA==
X-Google-Smtp-Source: AGHT+IFAqNAOcyp8GZerwdObBMUWzzrN3MMt05y3VVk/QtXfyYzfKPsqF5Z6S83WeUvHVLk6oiTyww==
X-Received: by 2002:a17:903:2cd:b0:2a0:e532:242e with SMTP id d9443c01a7336-2a2f220dd7bmr273277345ad.11.1766973306503;
        Sun, 28 Dec 2025 17:55:06 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c667cesm261043605ad.18.2025.12.28.17.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 17:55:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B27EA42A31AA; Mon, 29 Dec 2025 08:54:45 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Virtualization <virtualization@lists.linux.dev>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] virtio: Describe @map and @vmap members in virtio_device struct
Date: Mon, 29 Dec 2025 08:54:24 +0700
Message-ID: <20251229015424.16060-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718; i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject; bh=vyEgeMf2uqW5VB4nieLxhnduvrdLalTDDvg+5iSNH2M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmBd0891tU71zT1aOSXwH/yryYxa/W1tX1h3Heq9pJus oVwjYRnRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbi0cnwv2bT7SfPT2scj89y uXjJmfUv/4pqpSr71n2q+2Q85TscAxj+B/+P2XpqexNb9DX9K5xLRaYYxNwz1T/dc7w2987Mlx8 U2QE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings:

WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'

Describe these members.

Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v2 [1]:

  - Apply wording suggestions (Michael)

[1]: https://lore.kernel.org/virtualization/20251219031647.25264-1-bagasdotme@gmail.com/

 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3626eb6947282a..48b88c149eca43 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -152,11 +152,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: operations for mapping buffer for a virtio device.
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *		    device.
  * @priv: private pointer for the driver's use.
+ * @vmap: device/domain used for mapping memory.
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */

base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
-- 
An old man doll... just what I always wanted! - Clara

