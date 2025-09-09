Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6634340DA3
	for <virtualization@lists.linux.dev>; Tue,  9 Sep 2025 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449461; cv=none; b=KoqX90DWeVy+Txeq4yoWOTazOHvp4rJjqH6gRvrnU++jh45VMTz6qtAnZ+A6lppC5vktzF70M0cvD6r+cN2/RzfNOxLubTeQlGVqPOzu6jfQ/NM66gXSzduBNAXLtNjGUlABtcic9smDYc7rFGVHNn3ga9DmQpFDKCIhOjU41Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449461; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNmq+fV6NwMBj4GEW/jS79KbaAvpbiseoZwtSbjuMrKZpxYbg3kJmawdYDEMwlYFNjTZi/xXfuRYivSOiAn/Ja8v3FM+cSJwT5tBmYdhLtJqX/ZvjaWHj7+leTu3ekp8uIpAUpDAcAW0douTQv5gbKZ3GQwZToyr4ztFB8W0/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b04271cfc3eso820461366b.3
        for <virtualization@lists.linux.dev>; Tue, 09 Sep 2025 13:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449458; x=1758054258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=tJX/tE862F/Ik4qjZA9fP1ySBUptbqbc2pinj+BowdKHjIokYdQVsKvkLSOHe82WI+
         qBjrESCES2QxqH2+Bv9vNduvy2jacQJDvQPUe8NCuBXi7bium/EfVF/GU7rtuW3GD+t7
         qnJ/gCxNczvhd+M0fH98XIFgln5TRC0Q+gJtUSqGaOYOSNkwzI+38sd8chOPqAw2povA
         FplvRpqwIjmw0n2vy9NqAHX+xDLbD6ssQPViY2eVuV8G+oAzHVb6yyz099GWKXit5qV7
         WV7R1JOwq1QmCp43TYFQFEOibUbOlgFAz1chplvFYAFCT7oKFVHwQEoX8tuP4J/V11yR
         nA0w==
X-Forwarded-Encrypted: i=1; AJvYcCU+zmYwXAzhSGuP97W5YgTbCb7z7dpL9wjeMZuSjxAnHSVZs01Kjcwb8Vk38KLo5bN9ZbrEmWRZX9jF6QlsRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRnKN5TzM5LzJUsPF+R/Y1Pwhs2k0re3wPiHWjAwyv1QSh7GLb
	swZeb9c9mf5+qzokupMHJ1A2wflw0RHoU42W13+l4mQIHkFfMWFgch83
X-Gm-Gg: ASbGncu45p7MOVqEh4ay0enoFfR9AKtiu3lvzzHSZqKgP+HYh8PouhIljQVmNdxewDE
	42/21b5l93WeBBSY6dAMSxW0U1Y3FojkZzEF8zpheeiWgoS2vE8tzsd4pULdJ2//WkBzxzNBSWY
	qCH6f6xMtpvPyVVKHmAMahYp73fPL1hy4ExLQQGl7SjF5q/F8JHPQ3clVwTicAZ3GfZ3joUJ3X+
	zSTraKQhRBkkCf+AXEhwpwRdYTDpIN6BCjjaTICSFAY4zUazfLDKb7NolfVaJqr6I4IQHWAE8F5
	2kge/XIB/tYbiLoQwnPWmibMYHbVqQcAC+GeihUKrvmoyEJ6sPqj/QquUE+rzbRoVum+KRFizj6
	MN36myR6ujeyr
X-Google-Smtp-Source: AGHT+IG8G0E+/fESz8FriBcET9t0B7QGifi2i0GUmg+X9kDZI1HmO3AELIQZW3TPQ93vWVnhr8dQ5Q==
X-Received: by 2002:a17:907:1c93:b0:b04:4625:2372 with SMTP id a640c23a62f3a-b04b1437fe0mr1243169366b.15.1757449458203;
        Tue, 09 Sep 2025 13:24:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ffa5fsm45923766b.94.2025.09.09.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:23:59 -0700
Subject: [PATCH net-next 1/7] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-1-634282f06a54@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzuerRDZ8RHFW+5bNt7VkK6dkH9KziDNR3xi
 Mgsq0vZQh+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bTzxD/4nKkd93VMR2pDozwJKwJndOQpHEpM58d+xsJWZnYD9TzUijQNvdUTLw9/Emywiski4vRH
 4BlBx6zvH13HyfFnMjR79zDPrXw8YFLR8YsqtHm2RNjS3OShwLjBdYeS9PKOk2OfxusYW9ScSoH
 AdpZxkcr52bpAOw/99tN05gC5VCfMOusg2PVqLILjnN6FMdz2YezC37iCMPPKNLzSHD9n/55QxH
 Qyi/n9hkZLQozFGyjC/TDa/VxCb1/gQnYf3/g/dpOA7TZDUjBTqcUxjKmTYlxGVJ1eWakI8Zadc
 f3Y9VyukA+Ys+HdZ7biEVaCOKoCMztF7hg5kshBRn2Tqo0cLId/zDXr0Ie/lbmmOVgFlTKyQmoA
 XfF3JpODkZL5+3Y6gkLGeJdmj4xjw0sVKqqtNXI+AA4/lu0ZJsIydw1DMqFeraC2q3OUVZ8DlF+
 I9+v3ZUItnz+JqxJ72ZADIId0gCG9mgEZSt1zMtjuLH341EB3K/iVWr8FHeAxnRDeP42rKYcPui
 a5MHdsm2hOIPUH5Y9ZpygkSBKlHcTkFTKVk4izeDmaLAtK0Ehv5zgN952IJ4KL8eRRw2yvkLq6t
 kj5AJ/B5+GYvVXHwNYowP17lfor4+IhTjtJdS51IHYRZshDvF1fTQn1Zdns5F+8Zv/gil8eyw29
 SjRQF+vqVT+/yQg==
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

