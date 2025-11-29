Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB69283FCD
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406925; cv=none; b=bHs+aj81zWpHBGI751iBTycX9OHYqMwYdcC2TlR8hoYCCjsHAuY9xdcV0IPbBTpw4C3dg7wU1oO2KErZqR1W2ywvsuWWKa8E5YNNXeFISASp/NYMZwfTNTZPPOXcgzX0Rh1EKz7W+s55Xi7x7i6n1+sxQgyGcITyqJ8aw/0Hc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406925; c=relaxed/simple;
	bh=Hfn+I4xKib6YHUNH+g6fjmCyECLvbavw8yPYoNL/5CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rntlOcI1lV0aJxx3bq8WThUQRJJB+RPyAaC6Sqto+YTxcAVur1MIpkZnAVVZpKhPG3KSARLk8L61h4KCX3nlBsJCdyebDl2WBMiycJExGRwt0EM2dnm73E1qfYdp/YGcz+lx9XdQ0w84uN8y6RCD8+C2/IFGVmrJc+44I1uvVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfIc55w+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfIc55w+"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so2958707b3a.1
        for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406923; x=1765011723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=ZfIc55w+a51cFLAUC4IJD5VNeR61k2Y8R+MLZZDmnhO6vkW920NBIORavsHlIyehub
         GlXK2e1DFIz0Rd5vLqV3GBeIhzo4btZ1aekgoSQkZZB26o3DDQvxeue/L2uL/2knKTzP
         ov1dyj1Y+4mB0mObpHfrFNwEmGOBjxthq1eix6nNWqX/OiIFr3x3MGJlRhtHASlfNXsa
         myB6y2KS1yq+ZhXMHescMbPOhKmqyVbTFxC0N1QmTkUOJvw2Yj0TviFtBiyjRSRuOrD+
         tcpp3m0gdGYFm5b06y4ermKEP+u36Ox/glrXbqkDKQLFGHh7a7iMgw7ZWJJBvm7TxRqr
         WKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406923; x=1765011723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=mz2WXNsrrQGrl8wMcPsjzp2P8K/fgieEcRRhHRE51Dgp5Rzkdcy4gHTsBzGi03aGj0
         6VBkpH3TOfTm/Nd68Rpg2HK9JR1YsPuT/WMdOfzb/wWggoHVqUVJSQEXEyMevyYmb+zr
         Bu0piar1IBUxa/pgWxUEEwu382fIzhtkFkPuQ8x3a0Or3WHYr4Pd7Qe41XEbWC0nLh+I
         Rig/3vDdOwyfAgzc5XmpClrYEwOOZaIPgXVTjxC9cH9dvzTsEVcRqxMtx9LAwCZbrn9z
         iXipptUXmWKCE9bKC47pXKvwPlOB/eLLq0cEZXqrUC3GfXpHztOc2WxgYd1Q3ZUreIMY
         xAWg==
X-Forwarded-Encrypted: i=1; AJvYcCWz0uCxafmgMSw4FNxrOQ2jK55hkSRhwqWgHQ+YZDe4XLSZPHgedsn6zVlscyPqMnuG1JVHDwvYQexE/cz/Hw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKRzWRc3KiErUmyqIPiacEAVaGsEwiTl/3alMx1ryhX2OYypxN
	czhMaOtRaIAwgqWHYDrYxKTKLROd9/ff674JebjJO7bOYgcjO1bB6JUb
X-Gm-Gg: ASbGncuXIHAfa21Zl3W4F6AmUhjBcolWcbzdDnFTnP59+pCxZt4Z6ESYVZ8INq6hP35
	00bVWWFTRxbUmuJG2BK6gv2Jm+Jiduglc3UW4GlI0QHhb0KWFfxqaiJQtSFxwXAb8ahhUwm486Y
	m6a1D+nSFFlDpy8UcgcsL1fvWxwsqg5lybZwt9AqSTNA91Cb5OD/LYCH6VCfM6zwXH46g1IILl3
	cQ1z6QNQ0cvNex9ju68BX3kTqWQWf5gQZaiioXdPAEhauv3Ad8uSjdjvUaN39pL3+q5ZAc4vkXz
	bOOu3T23faFWB/imQKb2C/ENuJEF/kpPmpHGpuSVbK+1pPJZw+oi3WkKVt16wP1PMvn7dFhotZn
	749kQxZyJvBGXSMpbEHFK6N8Wk9xJycMBtgnOIb36AniV+MwwRvb8Bms5OduqwofgRnJ/hgXxKn
	VIIVX5h6naLFIRjWPheFjcsGGu533ehtrRyGo5
X-Google-Smtp-Source: AGHT+IH/QH6JeY8zEnnFSEp2edvSj4WvW2OiftF5ahPSC2LjhfBX3UeSnFliqzhG5QTteUkJDEx/bA==
X-Received: by 2002:a05:7022:ebc2:b0:119:e56b:957d with SMTP id a92af1059eb24-11c9d6127f9mr19966464c88.2.1764406923339;
        Sat, 29 Nov 2025 01:02:03 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:02:03 -0800 (PST)
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
Subject: [PATCH v3 6/9] block: Replace the repetitive bio chaining code patterns
Date: Sat, 29 Nov 2025 17:01:19 +0800
Message-Id: <20251129090122.2457896-7-zhangshida@kylinos.cn>
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

