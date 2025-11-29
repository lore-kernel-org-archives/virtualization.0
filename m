Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97927F75C
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406916; cv=none; b=KpD8aYu9yxqTjSywFACldhiSvbRo3dMLPwebeF0EijXJ7dPfSe7FAwwPZWhdOM/okGqaSLO10LyfQ8nyq9pEf7YwfBeByboc+2cVHvcAUYr7kgkfRjFOx5xt2U0dXezHe/RJdGx1gI/JQnsOD9a0z70TGgBuVCmbJwAk/QRQgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406916; c=relaxed/simple;
	bh=pDPxpgP4y7Y34S846UZ5pdageZyT3VDirSvStDnHRd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPlVDdiVJzI0lVxujps1ZC2Zc2c/63548aYvH4emtNZAMQ2TVuTrDYNYdCnhvgunQXO1/jsXiOhfPcVE9mIUHFGwGh8JaBq5/93Y11zXLLB8KmvNB0CUP58AnWlDeJqzezS1Capg3XiNed6G3s7PWtVZMQtFCkuEYhCdeBkqxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2YqC761; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2YqC761"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so2490430b3a.1
        for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406914; x=1765011714; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8NoibJSiNHVArlLUK5xHvDn/GmQ96N4NjNkgGx3wcU=;
        b=C2YqC761RRTtyWTafyi0fvX+mfVMRgUn1MtR+FG4FixD/fh5+R6Ni9FwZYRtEX4cjg
         z7dVEjRJhj1mHe2ky2gztcsKF5nBdhDjRDRanFQPe+LyMKnu/pPx1Vm0N+jCXm3QD0+5
         gYxIBcBsyn50pAx43SLabSp3hty5DNrWfi9DnGXy5O+UrCDi9s9OlGVgcJedsFWHHkMm
         d2R8G6w+w+97luYXy1Mgpp5+BaUYpJ6rjf6x/ulqReFNpqdwaHruFWWwyr7A3HTpxkPs
         1b0h2stj/O/03OT+KWq7ATTGyy8CAm9eiyaiukk24rSckIpbS301Y2PYIj292legny9q
         03VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406914; x=1765011714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8NoibJSiNHVArlLUK5xHvDn/GmQ96N4NjNkgGx3wcU=;
        b=YohTUQN0kOo0oa0W6BDb7zfWKkA1nVdTT42hpQhyrRnazqEhjyvfmZqlXNC1nuuO97
         AB/EPMrrvXn+QrV0zkGsDSe6K+xgVYFWxh6nWjszS//GbPldKXv2VBlcpckv6abrNPW0
         EtUAW+LC4sIrVwj2Kq9ez8yax6NAzzyH4B+Zj7fquYwYOAWx3E+MZgNt2zhsGMGUcxEt
         1Yox6TNl8+i7K7PGnHC2F7XgKmi6gtLCvhFS+xhDS2P2HLHnESjz1xQScolbCzQyHGGe
         99EAeSwuXxiZl2lc70R9T8sfbQgYP7toUKJUswFJKzfCbndZvW2PNSyWrlbszhpB+ZpZ
         kySA==
X-Forwarded-Encrypted: i=1; AJvYcCXMixVQikP7CdLb8y50lr/GjmLn9XUkoHexuLu/VN2PfAtarcaxGbUF9AwB8+x5rfcCeKPiwDirWrp7vGCGhw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywhn2+v+tWmzK+Wh2YwPBwwRx74ZYN0DrRCKEQNJtN8v7YWZQR2
	OQ3YYEmLiYM2Ieg0OFfDgXBKiDhEIPKdvk5YMhDdBoBhjAkQceuEHDPi
X-Gm-Gg: ASbGncuZvo48v/A34WGzq1WMTWkSJLoqSbX+Yv2CisiXvWEYfApX0IOh+WnyJy4zWCR
	+GnGbVzXQzda/7TDPIwlAaLjK9kUNYWgPqjsKUvERn/flTSgDtDRdTt9v3Vh2LxEqUnkKFfQikD
	xCvHwZZy5X/VDaSsly5hPqtj9Q2+LAaHJi0w80yFIV7Dz7TwmzfO/2DFDrQolByY6xVckXR3S9l
	yAGFPAf3HUow4GPmHtwqFKZVDbRxAfVygsY00OwHXpJYgMuFilBzRlPghWzxEHbtbFM7dHqz2xC
	wr21FOBspw/YAtaHDMiG7wMzZhVfCeATqlNwU887NJqFd1/Lm1F7O4SVO2kccCh0KG4ClRRk6MA
	+nsNBvjcC7A3V59bYhXxO9n9ASsttuNMw/uLCVI/v9xkEsaeUEPxNXPXSpc4UFw51FBv5D5Bl9X
	lfjCRbOBKyy8/As6HdkZ04mg184q3Jv/NwGcTw
X-Google-Smtp-Source: AGHT+IG2wahiB2PBWVfrDNRf7p52lLBDrzQQGimm/4V6gX8Dcmjw91342gxhdzWR3iErnl9Stx9Lzw==
X-Received: by 2002:a05:7022:3c84:b0:119:e569:f277 with SMTP id a92af1059eb24-11c9d864eddmr16724097c88.32.1764406914041;
        Sat, 29 Nov 2025 01:01:54 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:53 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 4/9] block: export bio_chain_and_submit
Date: Sat, 29 Nov 2025 17:01:17 +0800
Message-Id: <20251129090122.2457896-5-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251129090122.2457896-1-zhangshida@kylinos.cn>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Export the bio_chain_and_submit function to make it available as a
common utility. This will allow replacing repetitive bio chaining
patterns found in multiple locations throughout the codebase.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 097c1cd2054..7aa4a1d3672 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -368,6 +368,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1

