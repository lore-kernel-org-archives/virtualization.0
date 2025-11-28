Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06862EA493
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318770; cv=none; b=li0m8vjvLa9AW8IcUbzuSHvVRRgUesGa+jzN7HaVkcrvC+7Yk85mBRrBqYPgsq+by+/r6fG5DVOn24HvlPntMWVuAdw4x70gS3DNsGOwOcfn2vGXQ8efinra2I2NS2pzSHrd7y5RI4Yq5MbTsjHB0+2y4x25+NCzty90PiZrOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318770; c=relaxed/simple;
	bh=vDTdwwqFiUx+YnWL6sZwmz4ttt9jO7ABRme3mV3jkpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qk/ch2UdJ5bVRo1MSydmmC2nxf3hBwkHeio5cS2iLrWuQmf9h4HlBbp4VU87Ac3ORF3HfXpNyfcpsTLPbPto5LOVF//BzF+Bck+BpAS5jakzcjF8vYRsRGyQA6jBwCI10wyGrImypLi4roArj0cPHEWAyYHECYxJu0Iq1WSIgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEsHa1R/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEsHa1R/"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso2505830b3a.1
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318768; x=1764923568; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYdGxu8+S3la90e5ilLAk2WHMl9XT2MOPAJKSPmhLP4=;
        b=LEsHa1R/XXIrtn1JAd/GYr5JDdMiSEpIYHl83J8f31uEPzdORmDz/+OmZ2KvgUAkEy
         XOsx84uJXHmWZ33EUI/I5z/jEsaFhuBKVf5HtdjPn0cU0WHqePFqyABlb97zG1ESOWTZ
         X+gg8rqELMeOqXWhGFDew7jk3LmIJAIHN3yuEE3KagJWVz5kaluF5WwWe7u9VXteuJZr
         Ug+r1U7uHaj8Af+EEmyXEtgWQ1J31VdDmOcZYQ2vL4x19R9BggF9eUEZKSRAF1hgZhBn
         AmMxeu4yVF7drncWJxayzGUgt1kCfYTLWksh4zR0Lpzzag11BUtodZfeWLiMdiPVAp+M
         hJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318768; x=1764923568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYdGxu8+S3la90e5ilLAk2WHMl9XT2MOPAJKSPmhLP4=;
        b=W+A6gjYsBXH6w4llBiVQ2YbLx9AhlBcLFs1dnDyZbz2ZFGpbIfSLIi3J7xVBN5uJzy
         cDaiLt4PdzGnOZfyeX8+Rgb5nySqgl1h1LYT6gVTRJAkb3MR1hBoBrXC7BuVorS+IidV
         FdgIkr6FZBQY1hCn6V/WIH1zJ43EWPkkoiivvtY2HD6FrEWeSf6zaI8LN0FAyYl2TCbU
         HnTeRFqe8XbqC4mFMVEPVypGkLWW2UwdNy427qrjYNvKjpgW7RQS+yiEVVlvJOBwdLAd
         gimXlV2HfI9qAy0LdCYK2N8NANideBDipNZxerOrWroBt6yzpldF2QBvYBGz87a8D6as
         pIcw==
X-Forwarded-Encrypted: i=1; AJvYcCWMRPSUSxw/ZxyLiJKmiXeDe9ZIO1dBE8smOaCDFoiKG/mUVSsTbuq1jU/iNfwiPF6BO+eV7KkgjR9RdzHIgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBqecr7GYHk7+vis+KKq+A1mASIUjyw3IsqGwfX+TJvxWnjFmV
	hUHPsnnOjdXDrwTSzDlb2ThQbAmJEDHwN0TYynALRXraXHSN3sdRiZOM
X-Gm-Gg: ASbGncvT/lsLG2Td8TR0iKPQHSB/f8E/tXhlrPWWp103e3d1iFdwjVhf1e6+PNW6XZd
	DNAV3hevBgenuCVSxZbnp+YbNlzjiQC/nZaRVgALYF53xo/0p9gIS3xZva9yEPXQmCpgjPX/L3v
	yJ2DV/m5IU1bhV52VRf4MySVL7P37vpFMZwLHHjv8kpgISFNxtyiE7YFrIQkDSNwDtQWxxr5+fg
	sYwZIiIP6qQUPm/hTCXCLbII7rynShPtN/EMsrFnaDASSWFJ1vHogTdFEcTGxP0ZFsO2Icd09wq
	y5Q+FGTuRLL3GDPeVGIutw4pTJoxXoLt0t7wThxSYlgO9J0EsyyahhJoqtr/QnZ7Ttq9DuFTs15
	4dv6W84hO3U6x5xxJrtvyEb97jDDvwILtZ5N/JzySI4PDvAnd8BtKa+WQV2l7S9I95dtYdrMX5g
	2TSRmSxp65ZYH7nMpMo8eHsfT5jA==
X-Google-Smtp-Source: AGHT+IExXZt7YE3nF+952Md7MiVvxMbDW7G+yswwYtoDXLwvootnd7yuttY35MGv7RVbIjqP5duRMQ==
X-Received: by 2002:a05:7022:670e:b0:11b:a73b:233b with SMTP id a92af1059eb24-11cb68354b6mr8088695c88.28.1764318767897;
        Fri, 28 Nov 2025 00:32:47 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:47 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:09 +0800
Message-Id: <20251128083219.2332407-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Andreas point out that multiple completions can race setting
bi_status.

The check (parent->bi_status) and the subsequent write are not an
atomic operation. The value of parent->bi_status could have changed
between the time you read it for the if check and the time you write
to it. So we use cmpxchg to fix the race, as suggested by Christoph.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 55c2c1a0020..aa43435c15f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
 static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
+	blk_status_t *status = &parent->bi_status;
+	blk_status_t new_status = bio->bi_status;
+
+	if (new_status != BLK_STS_OK)
+		cmpxchg(status, BLK_STS_OK, new_status);
 
-	if (bio->bi_status && !parent->bi_status)
-		parent->bi_status = bio->bi_status;
 	bio_put(bio);
 	return parent;
 }
-- 
2.34.1

