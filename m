Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5B33F8A0
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713113; cv=none; b=j7OVekdGKfYd+LzJSLFC1nl7vSxZreLYhfTQAK/nEHbr/LQ7cM2NGo7hkGKtHzggqwkE/jLhsxarhU67R+EdqyeBrw3/nFbffTk5gEGxzd/lzI7boeNh1jicdzE1CuD4593F8Xxtafyk6vLhVSRNZZKCNnO+k1T2YOguhAyEHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713113; c=relaxed/simple;
	bh=a7LSL2iwilO1NB088738btanTUaCE2U990irg/c2KQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTEK8MoIsD3Hm2ITOlICIWZ27XMWCfMeadWhRYEykslN9G5y1YIKHxvt9c08+7COOcE2fjAUGwM8SIxkUuQVMD3jH0VExM5uMAcfoloe01V7xb5zBdHK+UW8eUDUnp3xlNStX3KHsLy1KSqaHntpExWvOGcVL9dMoWSWQbD/PvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG1khWBk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG1khWBk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso1066710a12.2
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713111; x=1764317911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=;
        b=HG1khWBk5LXl53K5NDYrTW8VCTVBPEir7KvA5lKQ7Ee7yU4g1MAsQYyXZ9OcjuxEIa
         73z08097waazSMlgyDUpPNvt3u+aCJAOhutIDFm1Ltv82Dt7DH8Gf6YIS1KyojmqTiag
         Nw7uRMOgZXXg759DKRL1izLmL64IIAO8Q3cVFHStJn18Jbe1hAYE7QHTix8BcKlr8UP3
         zyII4M+5GmKkEwqrbdu0aUF2YfTzaNlVuXXNF5zBMj/TPavDaHU41gaQJsu4YT6ekXp2
         H542hg/KeRt1OWU9ACiGazw9/sbhnJ3wcqJxYWiYJhnfELIyKZ8tIV4SPQKUvMlmYLIq
         k01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713111; x=1764317911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=;
        b=MvdKhjvkLfje+8owjputSzxeGdBm1ENH87EUKDmqc7A3JEEeWgsxVn3oN5048HIlPT
         vgPiyrajqr2N+AP2+IUGfJKlUN/+0VD5BpBJUUx5Sw4hPqHXt1UGSZUlf2qO6wzeYsJk
         TR9/H0q2fnXTu/VO92upznbWJhVYiLusnLuaG3ychRyr3+WnyZwdTD2kf3xoclIkJIdP
         J1qBi2z95VMSmc4RDDytRSKEBZmHdX0FZbISCMTQbTZAmPfztSmimif76k6l15Ry4qxC
         AxYWoCa1zvJrKNh8OGzglQAYA5zSrz4mEVR5Wzrg3JiuAZOIVwdu7sXMaEP230lBA/7K
         SoAg==
X-Forwarded-Encrypted: i=1; AJvYcCUUWEutKuNah8lxWlaaNT4I4C0ndMZBpTC/dkfkLInWtiolQZ/DEtnELToBX+VTTjk//UppJLgeL/R9+frImQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgexqDPONywxtIwgKByrwwbV2xrNk8//ThcAnBvL/fO53ZWwW9
	2Vxzkgxh6Zh+zvsnAQUoPoZOAoJ3CRwsWJxv+9xoSUdS72KnksOL1rZQ
X-Gm-Gg: ASbGnctFNdb3jc34uZRNpcPIDbPsKOnd4i3eTh1/a8VEUYcYSSLAenWMJAGz7RwYp7X
	NAMM3SMhwee/xxYHs7kpuBRTVvomX4LJwTXdpCTixZa16+CQSpB35/DMWElydplQzebt73F7GnD
	rDRQIb4IPpmtuN4/Bo0hsJTyTWMtk5vpCu/7YohDrMEUkCNaSuBGF1rZcWYSMPK/K3+nevqiAtZ
	elbzLomJgAqFswaUKJHJC/aVBLbEMYZyyzKBWiQfjGvHa3MV2vfCsp3cMGPtl6fTXgk7Ebbje5V
	604qdO7ldTwvWLQaIxslslC8Q6IdyzVQu0DR1kZD8tpylJPF3BVSiJq8dsWlDHpZPn1phpAYGUQ
	QYpv2P/DF55c0ChsK5GOr8CgrsUyffCdfT1kIewcV43xnB5c+Xxjl6jcCfmIUBVb6/37fYs2ecd
	BBgGAaRLPqlBea1I5c6Yt59d7Syg==
X-Google-Smtp-Source: AGHT+IFWgtWuJbeRkMQREJ+GB1+CIl1owO0q1AKLfdba/kSV5Dme/s+uE/AHBWMGMV79yRIBfle0AA==
X-Received: by 2002:a05:7022:628d:b0:11b:9386:8257 with SMTP id a92af1059eb24-11c9d87a334mr448835c88.44.1763713110905;
        Fri, 21 Nov 2025 00:18:30 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:30 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 8/9] nvmet: fix the potential bug and use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:47 +0800
Message-Id: <20251121081748.1443507-9-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

the prev and new may be in the wrong position...

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca60..4af45659bd2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
-			bio_chain(bio, prev);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 
 		sector += sg->length >> 9;
-- 
2.34.1

