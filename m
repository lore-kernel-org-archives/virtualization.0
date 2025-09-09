Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93A26E179
	for <virtualization@lists.linux.dev>; Tue,  9 Sep 2025 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449460; cv=none; b=sUWdOfVxI2Bma+uldF5mZ073PwcOPiRNc5f5fXRW0jui4muFWzfGAEeFQBtmFNkKmnUXO3mYfaYibx6GdEr9L8u0lgSuL1LsL4RW8/CEq8lc2RK1m6hdHn4IfeuKBDCGr4BOZx0Xgl6WDFx+Q5eFpnrCX6S4eOdry8vef4icTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449460; c=relaxed/simple;
	bh=U7uQ3M/wk0x/K9SdYlwbpROJ9Tb5bfuBtL7LlHvUIU4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fUUMzr4rxtgTq+GYrRIpP2akUmlqX6cmyv6kDBYrn8i2mraqswcfdbUIxZlAzNVUvG/QxyUDWZo7oht/3osti4lc9QASAaSRE7RL0awNPmVClE3kjQajzhjBy6zy2QOsR2lSUxRKsffVNbFuFWsx3/Z+KWR/Tt9U+SzTB102RPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so7369234a12.0
        for <virtualization@lists.linux.dev>; Tue, 09 Sep 2025 13:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449456; x=1758054256;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLQXAqMP0V1z5whiIVOGJCAsYGy2pj22YY3h3stm+Io=;
        b=k0sE7D93DAvcEKe9cI3u4iFoyb2a3L+DldTDQ++rLhwabcnyok3RsCtUyawIrnHTii
         EcfynvegO38j8g5ELlcxx9r4/EjHg155yzMcC7wMWHem5zMLHWyLPVbmdMHcJUulbmUo
         VH9ezSa5BWlAontJvCHpx1dC3mzWpdI1AjfY0nKJrOIj7c9/aZXw/zfdgHBVSLll57hF
         SgbaGmGmvYEXibBS0blT8ySG/27G9hbIcE96hB3AtdLi0pC0NLDlAuZJbl1VcJUFdRmn
         KOAKvhd5ZMDI7IbEE20Knd29D/QxtnQ7YLBofMpr2cQDsM/kAdFqd72Olzw/4wr/mVqx
         egqg==
X-Forwarded-Encrypted: i=1; AJvYcCV3d8YdO5eQroLhuUCQMTFFkK6M5YSBZL0Yw9M/ZXR/vK/AnPfE9u2iQScph4KQOAiQRkQmeWVphp4vSFIvNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyoE+ijkk2auUjgRkybNB70GuWbnla/RXe8pCjzND7JmAWfAsg
	vQ3df91Z6bYvjeN+JnLeGx8sWoNCgeHY6iDl5HQfyaAkcKquo/usffiV
X-Gm-Gg: ASbGncscBSdroQkQw4GRHQHvCKKeNCfoO0OKsiidFD7+OiQoixHy9YY93T5NIQLhP//
	KcOEGEOlGJHmhs1WjupDQZO52RlboEcvftpfHWfhOXMVxgfpT4UpbQ6YS5kWyt5cWwGQUXXJIpK
	s+OBf93Uv/SdoxjwVaJKjCHtNMmx4Uh05/cSC93dBuOrKxkwa3l0LSeEz06AHwtdq/WipJZltuw
	VD0Wr9HvbSUp2zLJpDRs2ULT9bnEet8eDOqTRyC1WxcWTTJFh5MT/n4+1hj0hiSf/pujNLitoq3
	oU0HhLEEd4JtBglzzs0fjyLxH96GNiuUF/iahSw7IR3HZyVn3FoE4BfUcC5udAvqkb03KzCQi6m
	zis1D+Wa3R1IPaoTuhvKhnZIIP27+SA1fc7Y=
X-Google-Smtp-Source: AGHT+IHlD/yr1obfRyLpvmIL7BkRHXyPdQwZMdWFvaYgFTS26hcoDre+D70ABR+jj0233W/jSzBFng==
X-Received: by 2002:a05:6402:d0d:b0:61d:13b:3c6d with SMTP id 4fb4d7f45d1cf-6237710906fmr11020686a12.24.1757449455995;
        Tue, 09 Sep 2025 13:24:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfef689a5sm1920517a12.20.2025.09.09.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/7] net: ethtool: add dedicated GRXRINGS driver
 callbacks
Date: Tue, 09 Sep 2025 13:23:58 -0700
Message-Id: <20250909-gxrings-v1-0-634282f06a54@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+MwGgC/2XNQQqDMBBG4auEf21KMihVV72HuEjjJM4mlkSCR
 bx7wW3XD753onAWLhjVicxVimwJo7KNgl9diqxlwahAhjozmE7HI0uKRTtiT8RMjj0ahU/mIMc
 tTUi868THjrlRWKXsW/7ei2rv/qdVq40e+jb49mkD9eG18Ftcemw5Yr6u6wcIbVGhqQAAAA==
X-Change-ID: 20250905-gxrings-a2ec22ee2aec
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=leitao@debian.org;
 h=from:subject:message-id; bh=U7uQ3M/wk0x/K9SdYlwbpROJ9Tb5bfuBtL7LlHvUIU4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzu2Lv4O3C3dOR/tildGUR+duc21IRjAWtto
 z5+eAzojAyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bZ81D/9JUOfoWyooW2S+Sg+J5IHycs8nUmo/aPe0S07yKDJMbxngNcarm65eXCmLfrmpHCZQ6qm
 Sq06AOBP0bK/B/TMMy+mhG+F06Xq4kMa+19NOJHUiYVkGRpJFAK+u9rlwK6JZIldPUiJJY8ekWq
 wAGw26xtL3HsQQrBwfy3UN6HDZsnI5gYl0qIiFM2Bro0KCZP6rrqtgCg54v7iFyUS3m7a2w3d2J
 KX09/LrobZta8Q5IptYINlKwwFEb1s9NF1kDYPrIpQmO6qCYV8R6O8BVLi2dh2YpIpgWKZVr8Je
 zV2k196XHQOu7gKlz4dSJj1QpgfVimsF+StXcncPhXmW7xWR6aSN9LZAnATPYcVeGim78gk/tj4
 oz7ClRdVRQ7Q9uNlKvoR34n9MTbhnC/djZ4mr7jgLHTla0hYNmgxYmDT92QlBiNN3dMOg/UUxe3
 0S/pDw6h1dXMKoZZutrvZX2JH/TOiehoTp5bGvuVLsXDf/cjv/pfxztrgmSyOQfIjXlXieZXwf1
 jYqQPfWSRTNZHfjRjDDVcNV468495WBPNVD/TdaLcBdZ9mkXHkYW6FYXHi34962rPIa9H8Vf40X
 BkT7HUF1GoAvGM8vyVZZ9o23QHN0mCclHbkm9rWZof9izD1J5KTDnloMTqPrgpbDv9u26gH9wPT
 eo9AfUsKcBxI1Xg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces a new dedicated ethtool_ops callback,
.get_rx_ring_count, which enables drivers to provide the number of RX
rings directly, improving efficiency and clarity in RX ring queries and
RSS configuration.

Number of drivers no implement .get_rxnfc just to report the ring count,
so, having a proper callback makes sense and simplify .get_rxnfc.

This has been suggested by Jakub, and follow the same idea as RXFH
driver callbacks [1].

This also port virtio_net to this new callback. Once there is consensus
on this approach, I can start moving the drivers to this new callback.

Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.org/ [1]

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes from RFC:
- Renaming and changing the return type of .get_rxrings() callback (Jakub)
- Add the docstring format for the new callback (Simon)
- Remove the unecessary WARN_ONCE() (Jakub)
- Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f28f@debian.org

---
Breno Leitao (7):
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use get_num_rxrings helper
      net: ethtool: update set_rxfh_indir to use get_num_rxrings helper
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries

 drivers/net/virtio_net.c | 15 ++--------
 include/linux/ethtool.h  |  2 ++
 net/ethtool/ioctl.c      | 72 ++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 62 insertions(+), 27 deletions(-)
---
base-commit: 9f0730b063b436938ebb6371aecb12ec6ed896e9
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>

