Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC131063B
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434665; cv=none; b=BCmf23Pdg0KAZV0O3VmB+FcEKa0nvQik0eLbdyy1T396MgjeRKpvjX7XF2fZ9/VQNbYCMdlUiFPSUdByYLzMBVmS4my8CmV3E6wkagQtyCnrNG21xVO/8H2gh64qSJBqOOvHl9G+Xkghhf/bA2uCI5OFX7hP35YzMwha2F2+ODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434665; c=relaxed/simple;
	bh=flZoV7rTu0HoLnYzDWHCPkEv69kRnAJvNaCvCfg2dPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kts5Z3cg4sMkQngYEbMWgy5nBVl7+7fGC4k60e4nwt9ZFRRnwdtJKQVPmofsXM2fOISMZ6EyKiT7ML+MesE3vN86Z8ctk+sedVN7wQklCexoC9/JVIkcgzvPMLkNJys9jAq47JIjzjatgpHAYwnXUim2fr7GgFHBWcqDRckCSG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TX0Frthd; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TX0Frthd"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4ee1939e70bso3772651cf.3
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 15:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768434660; x=1769039460; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeEc8tQJdZv6wSmBwJwNJ7eg8WiARnEu4gZS0Yp4t4I=;
        b=TX0Frthde9bakbZWa0n74tS5K1+/mxmk7qR0y47Iqraq64u7EpycCT2RLScURdcYBR
         WhS80YHFPa6dL68m0yj3aGSJGg7lcS3avxpkepk9WLv7zIxMRPorB4tv7m8pV9q8RYr7
         HIBuQzA7Vi9UIIeafqypWSKGvWunAQM1wF9y3/OPQZh66x6XoJTGePkfc7FMq7SSQACQ
         p0rWUj96FV1lUcqqtYKMB+2nRl5pAWotReSswNYwTcI6c/1J2RRHL6jLv/j0xNeiZhDz
         LoIyeSW1BOoSk0Ks0ulQDLsdHhMe0yb697Vc3WnmkMNBWVqu3YFNZYs+I2HbOAhBsUVS
         ZvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434660; x=1769039460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TeEc8tQJdZv6wSmBwJwNJ7eg8WiARnEu4gZS0Yp4t4I=;
        b=twDXTV2/rD25Smc+wm8EUk72ddFKChxqe9J4wPU5xiBXGZ0MshkTnUAsAPfT5+wikb
         U8kFoy3IXmrYgLf+CtbZ5PMEfeRpQWBbizjHyP3aCYpTHl+EBl1lxziEJMEZYZF7iJzS
         6Bk0CkBEJmnw2BY/JMFOBDRLtDZG5oo3E70wPVFjxHUQ5/8ZonJ13x/zpxTpRL50i84f
         wBnsbYr/KpAy5PAg4+b51YYRFMkVNszulGxbDNsfww4eJwQ14/Ko4ZtceBukzfSw5Rr7
         8Ug8bAmBgXGwFOZOyT/rn6JasoXvG3jjSsq+6Y+8DOH05VHBLNqmgffHriMcckY6YFKc
         zPSw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ94OxGKf5ufRqzXZJC1OCObooGPQMdXvz5NNlMVPjcoWZOvsaTrlxHX2X6hMpA54ulSjJQbs5qpZPjRM7EA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdpDm5WiHD2CtPnBMpNDnovjXfBm+d9L82VghZidClCOmuxCf1
	GjxnBhbJywkTwCbSU2cCc66B2MqNFFoypMpo6WRODT8Fr+ZkpRBHgnfLIz+J4fddrTs=
X-Gm-Gg: AY/fxX5mEy7r3WjjSc6XZKbKWA6+MZYXb8z/SKeLhguhWSSvNIw44mKCC2CqA1SziFG
	YBu/sNDg65Nw4g4NsG05FMR9ikYU1lLm0kWkQ63nrdA01bkz1rqFH90X5dDlicMaKsvGRnH6KJ4
	kJgjvHgw0nF4H71FQes1vzCXXKrA/6mBjz2goJDgWlL67c47CPvw5KV6gBfo6kOwD3iW8h996gR
	No88SBf7aWZ5OvPezqS2jLCZNMjfD8GR4AtHhH9KElHGmu2yrS6Jl7kfw/nUsTijfdvZw5y4lj3
	hHn951s1AQ/+1sAQwyBdwwFMnK2+PhfD+vNrxiVw+3MkCHqpVcyka4NkCjsvuuVghJLjUsWUo4Y
	8OHkwCrx6t8853o0ZMA/AJN+s1P+D0LY5hvYIAmv9qKlynJTt/UUmrX3k5Nmapbiz3rOlhHg5Dh
	g7jYnTiodK/Kdf+MZKq8+IpJE4KmkH4JEobSu1nJjiaJxGKs+70mVb1ViVbCML5CTRdUkqowazo
	sml++6/cd4a9w==
X-Received: by 2002:a05:622a:181d:b0:4ee:1d0c:15e8 with SMTP id d75a77b69052e-5014a99becfmr55478081cf.74.1768434659885;
        Wed, 14 Jan 2026 15:50:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm188449106d6.35.2026.01.14.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:50:59 -0800 (PST)
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
Subject: [PATCH v2 1/5] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Wed, 14 Jan 2026 18:50:17 -0500
Message-ID: <20260114235022.3437787-2-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114235022.3437787-1-gourry@gourry.net>
References: <20260114235022.3437787-1-gourry@gourry.net>
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

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
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

