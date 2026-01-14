Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25643815F2
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380767; cv=none; b=YmJAxW9HSU74KQAj8zmKAwOW9bVFArpnGXH9J70wI9/73s2NnZObnQLf3Ly8kHBwj100UhWVbAvRkBefDAfZpmZh2SgcnOOqTBy6tyAJlTmpWg3AMW6lV5jcKu7KkfAP/zYNKSa70ILBuH252Lte1WbGNq6jOX1v8NZ6SvCEVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380767; c=relaxed/simple;
	bh=cImdW1I8gYlqyptmlVX3KT4VCZEIXu721DnCa4CHzjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCiGwLh/E01V+Acva6/FWOezK4032sZRjVbPuqJbaTQlhHwHYj87+UrKfIK2Omj4fhvrdVWaewEJZHpnql9cazWjFjYqSxFkHPcNTCkwGh+RovW5+AG5j22nG9FLFo1FU/7eTGH2rPGhH8Mo4bQ6g0Wo2H3jr1h3C9Yn7wCzbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MVsZ65+3; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MVsZ65+3"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-5014b671367so4672431cf.3
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 00:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380756; x=1768985556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDpE5wtoJCiMhRN5zrFeLb7soUJCKnfGA3SqaObqP6g=;
        b=MVsZ65+3BjwgxTZaugSWINsTYTZht3CsLrAevEs3vWJtEKP8qbDtm+HYHwyIrNvicg
         rqZrQqEdsgdKXBdSvkKmV6U9hxQ90deTStFXBicLSehXaRRE6CMJgYrBx1NDfhFtGKGs
         v0ylfg4Zm4ei5p4sY5HPbL1749m9IDZD+jFWYo5Il2n05FP1Io37kZXQb9lKpsapP2XR
         rrk3AuUK0wusQ0q2ZKLeFoXjI60BG3yhabImlnyg0xVORfXbowDLVdlKF5ZKvktAXVOi
         iOnQMuYJxZcz+J8p0LL2MlRL1U5dp/y9s2Reop0hgCjDVl0v75qsXl+O8XzTFdJISx1h
         pw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380756; x=1768985556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDpE5wtoJCiMhRN5zrFeLb7soUJCKnfGA3SqaObqP6g=;
        b=dt74foU9HLw0PDsCNsiVlBcDg1cmVeW64cgTJWDRi7vr+dKe8qlYeswKS13S5FXSsg
         UJLF23K9VIiGz/XmhxrhDZYJAVXlJC2AL3D1uhaRL6FlqHDq7JMiV2e9m7SysOx+CpIm
         j+D9ORkloFFcliSdnhV2AnixQDrGG/KRg5QmECHj9/JsYajhtZJQgBuS7UVwyb8qJ69p
         Y521ROlTxpmX8EZyiTXnKZRmIelHW4qs3UAM/m9Qstyf/LtsCY4T1Nwjj4byTo5JwGnB
         NU/NHweT5IQHy9AbO6KkLvU+96wGz+9aolTVKdGOZQV5cqqo3WVjdtkWXHZmqhpn9Rs1
         3LDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH2Hrn4R5gOpSLrNwwncgJlEiZek6srreId3VT3K7XXX8+JAjk30Ms2dl9o+VHrUUlz02kHqFumzMUQRirog==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzgo/1+CSZzF5RuqzF9j5t31Rwb2vciQjJQ9lnSSsw7yxKtc6QZ
	OLS1KpKDI1ABnbKa1vdNUxFMUmQc5hLZQk3s0ZdnI1L0qpp77SIxbS12hvPE+APvf9M=
X-Gm-Gg: AY/fxX6DFbTCjGn9p2m2THtwpf1XKYwbFKay681KB6UEK5uL7EpkekhIE/6Pi3bqS+i
	oa9gh7qN6JhKCnkBJjO40NO5LYhbhfeyZdh/rqfrLjFg+6xCFP7Ccq+pusiZK9SZggfUxvdXd/r
	/szDxHNViY1dHChcTXzk9To3jN6ThMtFVYg0cRJ6MWhMfzR8pPmIZ8yu/fHHQRen7W9ZsATbDr/
	jufzkkLgEicn2cP/kyainnW40C10yS0gdORL/8FRHMhS7ljWMnSuDo7ZpVth6R4G+UGcEBvFtBE
	Fsd0sQ4u4bU4fcq25yYppOsRRWSGbEQZolPV8+xuGQ7eWHJ4x+G+J0XFMg7iwLSdxXEkNWe/qZ7
	dVwkP35TZx2m/URJCv+5xhJJYnqufN9maisreOtfv8YSLP+RQ9G0Dpq7RbWuFsG4geYnHpPwEWs
	aJ+PwwnVkCGCn3SHQn+BWEVfaG+/dhgO0GIhbjFKQ6SqlGys8Je/Dx+jfuKAVDwItPMEgX7KvVW
	Fp4FC91YmO9Tg==
X-Received: by 2002:a05:622a:18a9:b0:4f1:ac9c:9388 with SMTP id d75a77b69052e-50148125e71mr26783181cf.0.1768380756171;
        Wed, 14 Jan 2026 00:52:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:35 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH 1/8] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Wed, 14 Jan 2026 03:51:53 -0500
Message-ID: <20260114085201.3222597-2-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114085201.3222597-1-gourry@gourry.net>
References: <20260114085201.3222597-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify online_memory_block() to accept the online type through its arg
parameter rather than calling mhp_get_default_online_type() internally.
This prepares for allowing callers to specify explicit online types.

Update the caller in add_memory_resource() to pass the default online
type via a local variable. No functional change.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 389989a28abe..5718556121f0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1337,7 +1337,9 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
-	mem->online_type = mhp_get_default_online_type();
+	int *online_type = arg;
+
+	mem->online_type = *online_type;
 	return device_online(&mem->dev);
 }
 
@@ -1578,8 +1580,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (mhp_get_default_online_type() != MMOP_OFFLINE)
-		walk_memory_blocks(start, size, NULL, online_memory_block);
+	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
+		int online_type = mhp_get_default_online_type();
+
+		walk_memory_blocks(start, size, &online_type,
+				   online_memory_block);
+	}
 
 	return ret;
 error:
-- 
2.52.0

