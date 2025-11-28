Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55582FD1A1
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318801; cv=none; b=mnvm1AdF7DyO3a13FeKnEHYE6wh4SSZtBcB+iMxQBNSm0OCInRvCzq/cePjOKSMYOR8aruUb9evuw/HhjVbAcACKWEjN24uA7ouqCnPTrQkWpEjdT0t546c/hv3Y3MJ/XLaG1640Glt2AjRp7BRZNCRF1cC6S543vdq5Efga9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318801; c=relaxed/simple;
	bh=Hfn+I4xKib6YHUNH+g6fjmCyECLvbavw8yPYoNL/5CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dijvbtkWhee/iLK7CZ2nLB+tT+qSoh1/i6vAOfqvRTZFV+LEsBBjxccurF9tV9qWKrlGM6dAC9F07wec1mc++FKg2CVp+J2QevV/vzLUtORUfGr5ImexN83e//nq681A9iqd1ex+D8BjujspUCdd48PJpwHF5S8tpsnsghq3O0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0aOLTiO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0aOLTiO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1389487b3a.2
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318799; x=1764923599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=E0aOLTiOgeQw15qD+0lcu4SBgBMtSbwysfU6q8Elgic2p5citmMT9WtnTZU+exM/zf
         P1qxw9Hcsx4VPSUXKUAlJCd6rENwT+126hey4N9kTiGiM4rVxi2W4G5jzKuJgaybWweO
         BgKPYGZCxMno2xm+7DLIjhKtttyZZjpP439fUXOdNyQfOo/sTffV5ecd/mfQcsexYuXo
         fhIwOmGX4kxVJIqeqmh+K82VpTm4UrfkWuCL03irGEbeMfoK4vw9at5yDziodT4EG1LG
         fCmyYvMUjUoFO1XfPd+qGYSYowoDjij+HN7BxGTh2VMTfydt2qrTFpq/AxGdhPJDnRCW
         qs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318799; x=1764923599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=KAlh05YntitR1dx6eMVVzwAJGtYuJJzz5GUxVVz4USijnMU7HHHSfVkb2zP1GMHTHT
         aJfon+e89+AYgztNC6Qv1AqmQfURBBZlihvOrkedBs8V1UPl2pf4HiCcLuOtSaoYvRGA
         83xJxZaJUo2ApHe0uW01q3Kap6/NLbrJ9exxqdDqGWXn+TR5RxIKWya3GkakioBFlGRL
         Cs//f3Rhm0BP0VAGM8hp7QzZrWK31VJUtEBrtcQIIhOfsBEEuKUtIOKeN5vdPZ/qD2oO
         MPVp8LW2+02mhkCKvpKgdqzc0ZH/vk3uroQGk72Xar43/ky2XMuxMlrsXMBkgqHSyRZJ
         Vpuw==
X-Forwarded-Encrypted: i=1; AJvYcCUFWN1rMvhIofjlZOGYzKFLz2fKu4dCmybBCMrtkao72Jq8n18gDlWCrA8yFQyQbr3AMnXGO5mzaOhzaJXpPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpn9EgljtJ4vr/6uefEWLTTLTWF4U1d8wTEVK7cWW3OoqO9Y4h
	AoFgmnN7GlBvOvPgPag185gwUS6PCEisAoneu7jAtK0HaG9D/z+JJhm2
X-Gm-Gg: ASbGncsYKtl/B7suxRWhZg4zc4XE0MxHr/G6AFbIzR7V+HTa5FBjt9miXh/3xZOwKnh
	l/7nWYuyII/9AhhDAQHg/Di5R9X4XV4C1iQWSGl+NlPSpzzni74xgNfPxJtnLs/QKuSjQkcd0NP
	XSgtEZ20arowS6dX4z1Y8Ji+eLombtEQhoFamhruHWt3pPz5gGg7Vcm7SAYVTop+C2GI8fq1L33
	7w5ZlrRqo/gdg8TNSD4tAeaokQQUJ1UjciM7M1jvUtqmfYCEIRzasMKr1jmxEvbc11jTq681hi2
	uctuAPRyAnJ1dhD99Bn48A6ZnC75GRnxWfIN7gkG0wKldwAgbJJaFh6OGHsn5lXE9DVvkXD4MJ9
	hGPcq3+WSZb0vCmG6iIBmCOTArAzC+jQZngYc43N9DA48o+Cau87dRoidAw5Y9UfU+OfgclFvng
	rjSRA8Xwve23aDowovUhqWPtP4Kg==
X-Google-Smtp-Source: AGHT+IHKXq8x9elSCjEHks4N7hQUevj8WxDVP5HKi9llAEtlIQFfHNb05BLq+B1Nz6uA8fi9DHZiww==
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id a92af1059eb24-11c9d870411mr17436186c88.35.1764318798796;
        Fri, 28 Nov 2025 00:33:18 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:18 -0800 (PST)
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
Subject: [PATCH v2 08/12] block: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:15 +0800
Message-Id: <20251128083219.2332407-9-zhangshida@kylinos.cn>
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
 fs/squashfs/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index a05e3793f93..5818e473255 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -126,8 +126,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 			if (bio) {
 				bio_trim(bio, start_idx * PAGE_SECTORS,
 					 (end_idx - start_idx) * PAGE_SECTORS);
-				bio_chain(bio, new);
-				submit_bio(bio);
+				bio_chain_and_submit(bio, new);
 			}
 
 			bio = new;
-- 
2.34.1

