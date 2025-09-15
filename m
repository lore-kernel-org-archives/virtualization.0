Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB62FB984
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933261; cv=none; b=UpkAtv9OeaTHVGhUveIWKyebJbQFoQyOmldjO4+OZodFebHbZLW7vEXF3LlHiTnVqMpGU5e7ylZShnqSt34psSAxICLd8IpRfhxPu+yeCKaBWqr4f6t2qyu2UGW0XwXIaoYhnD+dPhQ8TrVppxIwMJNxKHpDZOzXsc2CPdyYuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933261; c=relaxed/simple;
	bh=FtZR8dFldPy1RuaNntESwgcsBNyTo98zgEi4p5KB27w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M6fwsJU3hR55H5kUZ+OBM59BA9naUwGfzjK4AaLGqjNURI7RISZm2H+/aNr9kxymBiQpGLdditwnBTYtpC03IHrw/NuXvS9exJ+dy4Iq61MewkKlowcrW7nsPNLBjSwRE2Jrf1DfaYT8vWF3Q1vYJw+18nPVFV9QVaKDi8U6e+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso8120617a12.3
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 03:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933258; x=1758538058;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i+aeXUTUwkFP24pZXIgtLwZ4MmQQUiLZKdFo7RuhVE=;
        b=EXXVf8Zi+5aoLHiEeXa5SHZ8+osIOOp1xnvMOlIr5ZgIMn9Fink/HoXusGt7PmWoRd
         NyROCwDJeC5hrBBWF1eccvRmre8yrrXVqmOscDql3rx+EGuEYtBvtuL5t9s+HpfMmqPe
         R749YwUovFFSu1nmxAYqpls3t5Un2T/4lOtNzHJKE2Gt9qSE9Byic2by1nkL+XCjB3xS
         0ffH4zrvMxVd3okeXwogW253hAYf54tta1KBApU8XCKhP2d++2Gogvl88tXCtX4xm477
         a+HWRyesH8M7H5Ri7u7YJ3fdgWO42cAZEhL3t0HSC/5BM3jRf5l/GqTQvpkTxxpRl9PG
         qcSg==
X-Forwarded-Encrypted: i=1; AJvYcCXOTgQFotqXItt+/KGEh/WWwOmWQoW+/F2HeegKVtAhsGuA5zGB6po/NRDCVbkpmR0+tS3Cfk3gFChYTx6xCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2LjJ01ubUSeQaHYmmWS/LOojCQqQzZUnq8a3N4lf8Z+e9CyNK
	zy2YM/TDeXIA9dQU51ct0sWouXOfY1Ek8shvzQWgNH7WeB0kd3wUha7u
X-Gm-Gg: ASbGncuWg5dC9Z76o7MaDxo0s7ocjaofJP9nlBMpPI1ZCP6p11JB7dQwuyrZdHRNyHH
	cLw4KEH8CFHvS8mVO6rgSD3UiVjB55kUUTg08Qa0sfwXbjOx7wC64ZY2PMry0DeCgBUfWb865+B
	WkUO92yS+xowAT+R4JqBTc2KZamkxo7dQlHTj9KkIGxES22yfj52aHch4rKNL6LqStn8O6A72Rn
	473d90e7BAPSH2Xd5gzlg5bw2t0mbtDEeSYtbbgiuglsV06BI14EcFhXtoCrs3LOlVxJF0hfu47
	A1jEQXDhbGMzOJGfH2BMsQxmhJq3vI1DJ8PcDKIBt3s7pEMeHwLW+yqTVCLwM6CsgfhOhiq3QJb
	Ewk3E/vApwknyRQ==
X-Google-Smtp-Source: AGHT+IHZw351OahB9qpqYDiJ9xfQky2jTs5UL8nDOi+G7moUMafcJPtFqs78cPQMSXYcowTOaURa/w==
X-Received: by 2002:a05:6402:1ec7:b0:62c:26cd:c919 with SMTP id 4fb4d7f45d1cf-62ed82b9655mr14152868a12.22.1757933258217;
        Mon, 15 Sep 2025 03:47:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f38abc083sm2123233a12.50.2025.09.15.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/8] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Date: Mon, 15 Sep 2025 03:47:25 -0700
Message-Id: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3ux2gC/1XNywqDMBCF4VcJs3ZKHC+trvoepYskjjqbWBIJF
 vHdC6H0sj7839khchCO0KsdAieJsnjoVVUocLPxE6MM0CsgTY3udIPTFsRPEQ2xI2Imww4KBY/
 Ao2xZuoHnFT1vK9wLBbPEdQnPfJHKvL+17qOlEjW2VU0XGnVrmvo6sBXjT0uYMpLoJyzpGxJqr
 NzZtNpaZjv+hcdxvAD6XSfH4gAAAA==
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
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; i=leitao@debian.org;
 h=from:subject:message-id; bh=FtZR8dFldPy1RuaNntESwgcsBNyTo98zgEi4p5KB27w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HirfQaeDf5m28Ma+aXf52p+Qtm5IBGtD8z
 pKG7Y2FNT+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bZpTD/0THZuj7I15KmgVCbSxEZI6L3IvZudFf69KcoButC9jDJUT2rq5B2tEpzA5KmXQupu/OTV
 puF4/TxOLCIpQz1YTFWKfTGkIvLLI/W+PKj/WuTr0jZLaOyeIMQUD/MWgkfqFI4SnwOCVxwL0E9
 Oebpl+3E8VYL80bn/qbD/PLyReL570i7hr4aR8+EVQLdXTDKx8P8mgR5wf3lD3HKIIfxuOiA824
 /3n4nAJQQ0DgUp/8uzpdp2Smn1Xo9Ff+4aAnQHeM5gjE3xwWtK8976c3phPmjyOM3X2haMdzd0X
 Wyc/9GxREn4/xZxAzR6waHQaxXksfUKgyO2wyuUa37v6Cig8P62MaX1nH4up7DvuAwRSYtcKgWK
 pNm5y0tbKHNckbT6HPKwq+csPshCm+fAwmHj0SNAjoBTYVbGZxj6Cuc/WXyX0CejGbu3UGBh8nK
 Slx87562CA1Hazm9fXjEsOE331nAEY6sXdn9Lc1q0Wvb5TpF9wUusMDR8IvNt/3NS5Aqa64hjac
 NfjXrmWTZYKLJvBRvi3XPrIOCBEqK2MH3LTNw/O0XSBDKy6YE7yI5Nw7O1B/cWItxQkgnkGf5T1
 BMOroaUdXtqE32pJvw7F0kk0AO12akrEGXG8Z6O1J1xMJggBT5e4ycF7aUGb8O66a2C8y8mDuUZ
 y+tWuPLSlIV0fzA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces a new dedicated ethtool_ops callback,
.get_rx_ring_count, which enables drivers to provide the number of RX
rings directly, improving efficiency and clarity in RX ring queries and
RSS configuration.

Number of drivers implements .get_rxnfc callback just to report the ring
count, so, having a proper callback makes sense and simplify .get_rxnfc
(in some cases remove it completely).

This has been suggested by Jakub, and follow the same idea as RXFH
driver callbacks [1].

This also port virtio_net to this new callback. Once there is consensus
on this approach, I can start moving the drivers to this new callback.

Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.org/ [1]

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Lei Yang <leiyang@redhat.com>
---
Changes in v3:
- Make ethtool_get_rx_ring_count() non static and use it in rss_set_prep_indir()
- Check return function of ethtool_get_rx_ring_count() in
  ethtool_get_rx_ring_count() (Jakub)
- Link to v2: https://lore.kernel.org/r/20250912-gxrings-v2-0-3c7a60bbeebf@debian.org

Changes in v2:
- rename get_num_rxrings() to ethtool_get_rx_ring_count() (Jakub)
- initialize struct ethtool_rxnfc() (Jakub)
- Link to v1: https://lore.kernel.org/r/20250909-gxrings-v1-0-634282f06a54@debian.org
---
Changes v1 from RFC:
- Renaming and changing the return type of .get_rxrings() callback (Jakub)
- Add the docstring format for the new callback (Simon)
- Remove the unecessary WARN_ONCE() (Jakub)
- Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f28f@debian.org

---
Breno Leitao (8):
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count helper
      net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_count helper
      net: ethtool: use the new helper in rss_set_prep_indir()
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries

 drivers/net/virtio_net.c | 15 ++-------
 include/linux/ethtool.h  |  2 ++
 net/ethtool/common.h     |  2 ++
 net/ethtool/ioctl.c      | 88 ++++++++++++++++++++++++++++++++++++++----------
 net/ethtool/rss.c        | 15 ++++-----
 5 files changed, 84 insertions(+), 38 deletions(-)
---
base-commit: 5b5ba63a54cc7cb050fa734dbf495ffd63f9cbf7
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>

