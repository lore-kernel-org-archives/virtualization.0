Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780CA21859A
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933263; cv=none; b=fe0Bud8zutDUemGXq/ZlSwrptARe4G8jfuoImnW5pWpTRlZfsdBteGqGXZB2kv09OGghzbsBTKAuvW9Pv3zTh/hp+jdsHNjAKVh/FN9gESSACyKkvhjADUXvQaJ5lH3BIwIytLlVodrT1cvHoaWxswKJQo3BGnbcHetDBju4VLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933263; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVXPu9cKnZNoncmcf+9X1b/4LbgtLPxxm8r+7z25bOJCLygGsvL0AWozBMMi/0reYqtrSco8vTbmcMFU/XEsOXPRdtw8nM/Cl4v6/XRLl4nYjbGWYdi28gRXgxoiSptE89W5ZLNSr8L0XJBFDFA7A7Ipjg/3dNhlSY9fpP4b9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0787fc3008so592515566b.3
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933260; x=1758538060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=pKyBoJPtYOu9PizW8LKIAMyICE/ei8VZI70fj6EcAn0d2hqGQLddwwSycRnYFMVPsO
         OfpEj5I60eDhc9Sk8hfmyLDcbpsLwKSg4ek3NZZGLIICT3B8e6UpWx5FKyyc4+I14dbM
         xEUNypcPN3WjsD5GPjFTQfMiBJzOte1bAXdzf9TrU22lBVuM4y2LYxfrERtptfiNIRpX
         lViGNOSiy7nI0I+fUDxqOMqi7uY5vmdEJHHhjp+w/8i5YgfabFF4dls5e1yMsRFHIM2g
         Psnp3fs4fxbXaOfSVr5F7oIya1d3D9uweFp3q+pzAX1BBPI4ET7QL5VyamcL/Y458tvD
         SvXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTHqdS6632nFpLILCYi6v9GKWM8v5/wydCgp2D7I5UMGIfEGQVVicT6Y7wVEFkOPoRMGKlkXtk65QQOAAlcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI84vmyPItcdA3l50cpsAwAbuOeJWqLbSMEpr5iy4LGf9e1mKq
	qKkjAitINJywSv/N09wxxAziCo4ThqTYV7VIftUkKCsHhl4E0qN/0Oz1
X-Gm-Gg: ASbGncsAHKIoO5xTF3Y9rpNcCn3jHhixl6Owb+riYgGz33LW7S4xMVDnytCE9c9qtcz
	eEpY/sBvVlRR+K8kizwsN6ayQ38u6hMmeKqTSVsZdpHjhnIBZOZDFfkdc/JlFU+7A+zepPyZ0Uw
	/bRudvGHyD+45pIvlz+AnK5ear7m3w9CxrKmgz74t0WQ1SwhDWVCBSVVJZnpPkp+2OZCIJgJOEP
	qMG0dh1I96ccSOuTd2KLw0jZP+mBvC0CFOYk3oVvZ+tl0ZTs/QgH3l7y3V8OmHqk5okjILJNI/v
	+nWFy6fOB8GY7iGCUCgGNwISOjrXOoCOHNSW9KBBaQk/Rq0a5jeTnxY3/4C8/2bF7dcfYdKblF5
	/JdkqOau5/n7fdJ55bjZNztA=
X-Google-Smtp-Source: AGHT+IEQ9CUxEeQHE3JWeIoC8BvynW9DvSy0HF5ePZmATusnxUn9fnpDDlUTtZxfE1vunib1KQd/Pg==
X-Received: by 2002:a17:907:7ba3:b0:afe:8f0b:6c64 with SMTP id a640c23a62f3a-b07c3540a7dmr1323625466b.4.1757933259662;
        Mon, 15 Sep 2025 03:47:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d6bfa591sm572756266b.15.2025.09.15.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:26 -0700
Subject: [PATCH net-next v3 1/8] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-1-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HRQadCYc9h5GkYpniPFgfnT/0CcAEMafkT
 xuCsB2YQsuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bQfjD/4lrt/Xiz2QXAq1v5Ij3l122VUYnu57K+oaAWsTIbUswubQhe9ghZG0rlB5vBcFbKB6ifg
 h4rjFqfnxwPWw1Ya9lScsGSaUuyz4R3iBUjVcYxDzH0whPHMK4u+o+XlPNrKvA/vMu/93lfVjU7
 zuPmKBhPnqiqwv7kyA75z0SY/+ygRSDqV4Y4A8LhT0CBD1bpmMko9PHjRAznUwsfFJqmrrbQTjU
 oSjq4hxms/om1T7G93kQL3qvP/eNjEFtLQ0EyKxfHfERYKVSinEhUdRRfhQmButmHxKQKOqxVmp
 fa9yGyS2O/GmxIlU0d31loo7kOmnt/JMgcAzgjOWbzG+mewUxlhIWZo3cwfl3p6NyFAI7pnkuyx
 ouF3WNW1HTPULNnjt4Zu04Z/QfbvA+WNaYsytakafDmuCel7LNMdELoBUucOaW81PGpVtj9KX6L
 cC4j0juY+QjEwzZXZdg/P/VBkIK5FFLMwNF0ek6z+MK9cVAtmiPB3NHQGKPObQrr/shtegXW3cK
 ruSuGSdZaiC6F5DUIbpUW1EVWbNDfpIfrbSYGiXytw3SivwshUFVkvziN/q4RJoya0D4Ih/dGjp
 Ndf0Zu7KJveBQNXQ6U+f4FILMV78m68phdBBwn3BynkIEpOF0e6p39nkb2VBIRaFT9/shYVlkbq
 x5DvosIngPw6T/Q==
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

