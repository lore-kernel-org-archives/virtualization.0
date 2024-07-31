Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245EE366
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384164; cv=none; b=iS5t09jtBl63RDYm67BqEWDl79K4PS9JbpaiZzak0O9al/VA7L/WuRc9guosaszSVjTE6Bx1+kOpwNG3NIp8MWaNZrGG6uwXZj+o7kSvKzGqe3hsIXQoYFvDqDsElwBurk9BWHPjKgZO1pYOYGPcwxAjg8fd0x4Vu7KAyplDIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384164; c=relaxed/simple;
	bh=Igx18LKP18SwrdD4qRV0Ak8Cqu2nwSLloD0GHKiEzuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WfH4IsFGAnSET8/+QkpLEQIzbwZWOgqYew5mcYsfdV8zQf9m17WCGV1zJBHmBc9NMkXHja/oykz6m7/u7pRVF5Dg7fQYZPVTipFyJUwpJEaOCXZBRMHvy7CIR3TVZXTH5IV5ai/yqFlI86KssGunG1Y/vpAUpgwYtGk7W1bHB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO5UCeQM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO5UCeQM"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d357040dbso4113813b3a.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722384162; x=1722988962; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7XE31Xnis95FwL0BCSpbXSmWoexmbCjdp1JCCxsjbA=;
        b=DO5UCeQMBt2Bp4g7izFIVXczJgjBT7S4zP8jkD58D5yIzB0N4SMASowajq4tzzovz+
         8l8AhYmqrDUX8fP3p3n7e43JSsbBInLuGEtXvXJUtsfbOXJTyYiTxL/TCmn5H8bfr/67
         k4tl7rRBG5ZgEJgyt1cAWZQZpvlFSBxMu5fKTzqF3ZZv3oC9Xmc8pPdAoQXXX9DmiWaS
         0yIk+LDUKwLMaX6IHJ68I0Eh4WWtKCDgH+mtJZWSeI77veKcwfJwaSb4KK3ZxaC9rHKy
         tSiO10ncBKfTDWnl0IYrnZ0MrS5hjp4+JTn9ebSsQZZPWO1uzeh9IzkIWfpQSSs2bubU
         DZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722384162; x=1722988962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7XE31Xnis95FwL0BCSpbXSmWoexmbCjdp1JCCxsjbA=;
        b=YjJF7kIAewW3VXhwOUPiPhLGl00DFnky3lEAHL1gStAbB0qQbZokI/ng5sF3r0LZRT
         h+mK7zSnl0kP64Z7g/DSGzcGdW0vq7hr0Sv9+PApTx90nf1F0VkDDjbw2ssOx4gTz6gF
         uCzebJorXj22SMhUDEIDMzVIKX4O+iLV+/06nVFiWzTXyonnvV30ECh3RQrMJZ1Xc31k
         erxWfxAFm+uAqcbCBNFvwMlw9DAk0txjppQUTAOuTW8SRfTpknktIZgCUphDOjMxsrxL
         n+mu2tC7G6xlQneAd/7XdcgYaITgRu6DkVAVgAJWY0oxmgAhLPTYf3I2fXMDuTR2InZZ
         pdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWKB+JwqAUv88SB0htcsx47awd9K0aKScrzGxu4Qg5eu2mve6TyfCLPnmH1qnuJZCTcp/S5X7I259J+alDQ3LsH9jph/Pbm2yz4YpjNXY=
X-Gm-Message-State: AOJu0Yx/WE/+U04Vpa3Ro6nCVYgZ7Qc4gPsE3kVBX6uc3dUS7FcMfkXl
	j5o76DAH4xt9TcjiIprJHKe25EJ9RW313dlANzS9rOl4c4HsSgmcqKlLZw==
X-Google-Smtp-Source: AGHT+IH9TIr1BjC9Dxmz8MIiv0IdQXYIX1RAmPY4wZlrTUPpc7c4xiWYuzvWLtqwXFXiJrYxGHZFWQ==
X-Received: by 2002:a05:6a00:4651:b0:706:34f3:7b60 with SMTP id d2e1a72fcca58-70eceda1d57mr10958031b3a.23.1722384162173;
        Tue, 30 Jul 2024 17:02:42 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1a2asm8871689b3a.23.2024.07.30.17.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:02:41 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com,
	cl@linux.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: [PATCH v2 0/4] mm: clarify nofail memory allocation
Date: Wed, 31 Jul 2024 12:01:51 +1200
Message-Id: <20240731000155.109583-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>


-v2:
 * adjust vpda fix according to Jason and Michal's feedback, I would
   expect Jason to test it, thanks!
 * split BUG_ON of unavoidable failure and the case GFP_ATOMIC |
   __GFP_NOFAIL into two patches according to Vlastimil and Michal.
 * collect Michal's acked-by for patch 2 - the doc;
 * remove the new GFP_NOFAIL from this series, that one would be a
   separate enhancement patchset later on.

-v1:
 https://lore.kernel.org/linux-mm/20240724085544.299090-1-21cnbao@gmail.com/

__GFP_NOFAIL carries the semantics of never failing, so its callers
do not check the return value:
  %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
  cannot handle allocation failures. The allocation could block
  indefinitely but will never return with failure. Testing for
  failure is pointless.

However, __GFP_NOFAIL can sometimes fail if it exceeds size limits
or is used with GFP_ATOMIC/GFP_NOWAIT in a non-sleepable context.
This can expose security vulnerabilities due to potential NULL
dereferences.

Since __GFP_NOFAIL does not support non-blocking allocation, we introduce
GFP_NOFAIL with inclusive blocking semantics and encourage using GFP_NOFAIL
as a replacement for __GFP_NOFAIL in non-mm.

If we must still fail a nofail allocation, we should trigger a BUG rather
than exposing NULL dereferences to callers who do not check the return
value.

* The discussion started from this topic:
 [PATCH RFC] mm: warn potential return NULL for kmalloc_array and
             kvmalloc_array with __GFP_NOFAIL

 https://lore.kernel.org/linux-mm/20240717230025.77361-1-21cnbao@gmail.com/

Thank you to Michal, Christoph, Vlastimil, and Hailong for all the
comments.

Barry Song (4):
  vpda: try to fix the potential crash due to misusing __GFP_NOFAIL
  mm: Document __GFP_NOFAIL must be blockable
  mm: BUG_ON to avoid NULL deference while __GFP_NOFAIL fails
  mm: prohibit NULL deference exposed for unsupported non-blockable 
    __GFP_NOFAIL

 drivers/vdpa/vdpa_user/iova_domain.c | 31 +++++++++++++++++++++++-----
 drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
 include/linux/gfp_types.h            |  5 ++++-
 include/linux/slab.h                 |  4 +++-
 mm/page_alloc.c                      | 14 +++++++------
 mm/util.c                            |  1 +
 7 files changed, 49 insertions(+), 15 deletions(-)

-- 
2.34.1

