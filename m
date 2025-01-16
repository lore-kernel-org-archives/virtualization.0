Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB521D63C2
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014968; cv=none; b=hvFsuZlIMUnRWOtYoPaj4S8aO1KiZVb2AontGNxHW8eJPwUKP2nUCmonMpH13FSgQbuEMM51pBwg6vHTlkW/gbonkKfofglaA65XtkyWtjRzU52m9UFq2fkX5lLNDX3MFMRXPCkqqW7332OxEbOzD4+V/SMCOJ9uBdYyr2pJpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014968; c=relaxed/simple;
	bh=jRpYSf9eaW+ho0lzpltGMAxASRyw0CEV/6XfYdKY0IY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Ckf5IZ6btnslWko/jTAmP9bXdeUZJtnwlTcJL/NNH8Zkkf0E7Hxo2slnFn1iAt5SYWYSCJgnnEnkR+Pmj2Cp7UluxNEiLRfqwURKlt/bWUuyi6ijO1Rnc/RYnk2Awzo5WaEC2rw2ET9ESigXRyl0tNVlxTvdIsOYOIEm69Y/BKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=AZVx554H; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="AZVx554H"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3424184B60
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kG1J_aW_E24C for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 08:09:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7F38184B5C
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F38184B5C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=AZVx554H
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F38184B5C
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:26 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2166651f752so13308775ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 00:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014966; x=1737619766; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6XeS8X9JmzzO8cEu3bDg1COvcoMcAqw6E54ck6GWVA=;
        b=AZVx554Hf/LQyqrD++k6wG/P4CS4Y7wBFq2+XBh7iuAJ5ufuoS5o1f4pMA7EnRLzgZ
         0Yy/6dTZDx1vNW1i/Hir1y9tNV8/x/BeEKD+IazoLFBqR+q9ByjBMRk4NQ8EgpXA2Lnu
         IkDgpC6ppR37WgEmz7iT3CN4w8xOwcf9P+5AWLDtYjlmKYkB7hMF+8Fn4DONQTukE7Kf
         VqvQKLMx55CqlKuaTkwnVGnjbShADX37CAc3mh7piablL24OBf7FHeyeQR3MVWLj9Q+s
         Ggi/Q3qZCDrvVZoKZA29adr2fvY1T200iHadndDT2N91lIyUCZH/EEZxBeg3OSB/r0BR
         Y7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014966; x=1737619766;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6XeS8X9JmzzO8cEu3bDg1COvcoMcAqw6E54ck6GWVA=;
        b=SlnbYVWxb5uzJ9W1flDt/NHNGS4YZ5ivLcAt7SF4Fd+RfdE94FvwoGA+oz583cbLfG
         mtWxaHnvzBtxWgpXPqOj2KdPaGjuX+G+6+jS/MpFV6y+kjk/fUTHSrie62Kxbd16Xjhq
         yDzd2B2H1yCl0+lt7E4wG865lIhYPS77Z/62M6sDlJhBULjCBNdRPLDX2071UMw39O90
         3HwxAHxDPL1o1x0o1vKTT0+x8m57z0VOUDhGQ2422Pg5vjQwyei9P2p+qltH9UO2P7Xb
         ZWbspvA5JTayLcN0gwqXUtafOy0s5J+Rlyjc6pUlg6YE4atnEN21P7pF4KycFC3ZcBx8
         8mlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuJhbbQ5aojvX0n6LODZoSRE/4VBFIyDm4hvW92eYsB+Cuu8h9yN9mNoWzZzZd7gndAPP5f/M+lOKud+IXsw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxIHZdGTTHsPe+60I+3V+q4jw33GeRZT4GNpmB6IJqly3yH1mcH
	RGEfc8m/jJJuVEU6N6g3mTzyawAYu7iqgvSFHgz5jB1kbtu3F6dbrV2u2OENRZY=
X-Gm-Gg: ASbGncvCYERbgTj7E813J3iv0+zjKDQSgp26qCiCs3uBvhlAWHwOAJNWGy7z/TGLCT1
	+B5U2RhuZXXE6jny7ii9/Tk8SShKfVw7KK9Ujttly1lqi4oK5Sd12x/2WCBKI+TpEhVumCRfYBU
	UokpSPnZ0rg1yyKfmDItoZAaz0iDi/ohS/tUG5eP++tQJudi7A5QNNyeDL8WwIldrPqAz2wQ1ee
	6XDyZkhE5MdZriUHWkZ6vDpQ600as1ldEzjkB71ymsTUOcOYfOjm/fVmaA=
X-Google-Smtp-Source: AGHT+IHnr5s5lbwKZ8hVxzCBLTjyfZY+984W/EhLpkGsedZ1ouritoL5gtdrAjRGaaFIzstL0hHTgA==
X-Received: by 2002:a05:6a20:3d86:b0:1e0:c5d2:f215 with SMTP id adf61e73a8af0-1e88d18b424mr16255509637.12.1737014965864;
        Thu, 16 Jan 2025 00:09:25 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d406a4dddsm10309766b3a.155.2025.01.16.00.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:09:25 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:10 +0900
Subject: [PATCH net v3 7/9] tap: Avoid double-tracking iov_iter length
 changes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-7-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

tap_get_user() used to track the length of iov_iter with another
variable. We can use iov_iter_count() to determine the current length
to avoid such chores.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5aa41d5f7765..061c2f27dfc8 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -641,7 +641,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	struct sk_buff *skb;
 	struct tap_dev *tap;
 	unsigned long total_len = iov_iter_count(from);
-	unsigned long len = total_len;
+	unsigned long len;
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
@@ -655,9 +655,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
 		err = -EINVAL;
-		if (len < vnet_hdr_len)
+		if (iov_iter_count(from) < vnet_hdr_len)
 			goto err;
-		len -= vnet_hdr_len;
 
 		err = -EFAULT;
 		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
@@ -671,10 +670,12 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 				 tap16_to_cpu(q, vnet_hdr.csum_start) +
 				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
 		err = -EINVAL;
-		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
+		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
 			goto err;
 	}
 
+	len = iov_iter_count(from);
+
 	err = -EINVAL;
 	if (unlikely(len < ETH_HLEN))
 		goto err;

-- 
2.47.1

