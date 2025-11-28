Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897A2FBE00
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318796; cv=none; b=cz6pP8GQinBKvaH9neWz+zP6Qpn61C8F9hchhmGTjfjMqVMhuo460d/cVxDHSqJDmnLqiso58N3LjISdaRqVCPHiNOcp29lTaT57gyzwTPL2odXSkVGg5F57RKIUoT/RHN2QK4oUiF2Brxe8BpQXb8Kpgx/xnc2kqyDisIgc4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318796; c=relaxed/simple;
	bh=rZqecGhzp3NmtFjaYLSNOTM+/xsMiNIYX8VY+Bn+fL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXIebt30746wvv85gxT1QYcI2ewYmiHZibov7RsDkxc6xAwTamaK/9DL+1Nm3OVNuhuXm6XHPAvrmnB+TzyE1lbPvgZiGxcyBET6KrcLXv1MU3Imvps+Ouyh4wFYLmVktZjzCKXnKfJV1e+O9MJxHA9g4MNLW3XPAO8xnqfQCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXY2A42u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXY2A42u"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298287a26c3so19082755ad.0
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318794; x=1764923594; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7vHs8yXaPj8mv/GRmviioQ8omsZI2Wqns1LW2Ikl6c=;
        b=bXY2A42ud7FBQH3qIL8mEKigYEUsXDv08OcpyyfwlHCN+WwgpxwGjpFCzMGygZe/ci
         6WtbWfx7bw4V/CdvNKygCmnFmW0uDUSwWHiQCVnZO99G8gEfp/PwYDPCYh4nqhgkLJLF
         kptmi/fYwt8iswP3QtE1XQxlQ5PDBjH48rWXV0eFNbYz0tA3pBDzcfp26T8xkQEShzch
         LkCiokuVM7/ALhx2yhf7X6L3h4aveM9abHomprowb4yGsyi18IUKj8pCPUjM2r9bEQ1n
         dixORu8Gk7KfZjI8ovxCHWTEjZB94/q5Co7YowrrFktI93tFPni84ZaT8tO/pmzLTq8l
         dF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318794; x=1764923594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7vHs8yXaPj8mv/GRmviioQ8omsZI2Wqns1LW2Ikl6c=;
        b=CUV1xo8dRGFooX+xhWbUaofKsY4llBfOS1ZJbnu1fMrlOcRku6bdAiCPiGNM+x2BZi
         eYs5+gfNY63zz4dvBpSppEPROXTXOqa51yGAPMzSx/VX6T3ODPv1/LKCXUDLuQzeWjlj
         IZDjtidff+BiiCmCcK3SPVTD/T5VVl0Bzf7cRcmKmFxCtDru+ylPXB4aGfZuWgp8OeVJ
         J6TqHnhkr01QRUrCBt5BeV/yikmGj4PmB5g7CcYU3wtV1WSN3gQ7fUUbF1FRcKteZTWE
         Gxq2VSb53F1qJzgoBLEdkzcKUlZY8Aq3T5VnCPwuY3Pj2Xp6ijuyIKU1fvY6fQDqLKk3
         cP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqID+p5CZziphckw9oK+CzLK2fCvgtQJ+j2S50PEaG9szeRYObZvDDmuKZj47nk6Zom/GuFltr9yQASQyaSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMFo6pmwOaHdyxiMxsQtVVy8YJoab/NZ2HSJpzLD5Yx5W+jclH
	RTWvT8daOCW3pXWKffnNaE5S+n11s7smTrgv/r+rkfPp9epUfHY1mFmQ
X-Gm-Gg: ASbGncs9989ZAX5QjWv7xhjM1e1+UEpbE/pW5xL2PP1ViPKI/h4Zuz071ooXwc4SMTv
	e6CsTt5DFQEzkAloIJUEbXDv23MS0BYJpYXN3Gcbc8WboXuanrDSeIC6pVRev3rb2G2tnjVq53D
	sIXkX76UvpFJ0X/m0nhOrvGc6MwwMWTKYjK039GdT0Kjyp1ODnMwxasI0y+KAgSr8LWdlZJSNU1
	e2+99clZT515/np30XtmAtIPVi+/ZFfaJcdtiCI1vOlaOYktzOPPFeRjB6oL7zmnPE/3FVFlOuy
	nbVrkjrhMnZFrnxCSWRJNsu1Li7Lww9/laoU7ohkcTHBUMcdDWtfnLMtFhvMu8zGIkUvP0k3pyL
	lR0CK8EIZQ4hYRq5tXXeuh81BkuK55Gcc/5vK+t+bwF7XXJoD4WRUlDfC7NaLVuY8/giogdjdRv
	3miRd4cEJBOzEp5wC18ww7uL9VJA==
X-Google-Smtp-Source: AGHT+IGKjtGYvF0Bq9aksrL28VuK/U2PkCtZPwPR3BXXqxprAsbvk/b9CT8/yxSPTU2xDb2fwzHbRg==
X-Received: by 2002:a05:7022:41:b0:11b:b1ce:277a with SMTP id a92af1059eb24-11c9d8482b1mr15434117c88.28.1764318793604;
        Fri, 28 Nov 2025 00:33:13 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:13 -0800 (PST)
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
	starzhangzsd@gmail.com
Subject: [PATCH v2 07/12] xfs: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:14 +0800
Message-Id: <20251128083219.2332407-8-zhangshida@kylinos.cn>
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

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/xfs/xfs_bio_io.c | 3 +--
 fs/xfs/xfs_buf.c    | 3 +--
 fs/xfs/xfs_log.c    | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index 2a736d10eaf..4a6577b0789 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -38,8 +38,7 @@ xfs_rw_bdev(
 					bio_max_vecs(count - done),
 					prev->bi_opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
-			bio_chain(prev, bio);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 		done += added;
 	} while (done < count);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 773d959965d..c26bd28edb4 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1357,8 +1357,7 @@ xfs_buf_submit_bio(
 		split = bio_split(bio, bp->b_maps[map].bm_len, GFP_NOFS,
 				&fs_bio_set);
 		split->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
-		bio_chain(split, bio);
-		submit_bio(split);
+		bio_chain_and_submit(split, bio);
 	}
 	bio->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
 	submit_bio(bio);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 603e85c1ab4..f4c9ad1d148 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1687,8 +1687,7 @@ xlog_write_iclog(
 
 		split = bio_split(&iclog->ic_bio, log->l_logBBsize - bno,
 				  GFP_NOIO, &fs_bio_set);
-		bio_chain(split, &iclog->ic_bio);
-		submit_bio(split);
+		bio_chain_and_submit(split, &iclog->ic_bio);
 
 		/* restart at logical offset zero for the remainder */
 		iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart;
-- 
2.34.1

