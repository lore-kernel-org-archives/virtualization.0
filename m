Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847A1BC9FB
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049754; cv=none; b=Xp96JDNGNd+iWyvOXEjxbKb0Cbbo6z93ZFb3ULrzIyAmoma6h1nrB4I+wtOqQTyGhn6U88cfdnZzma/181/wjeJowMxJx9WpJCF1vanwhVRdT3rdHav1xr7eu/xlG/Yt5SXPFUL/UoWkPsUSmVHNr9GQsrpdSbproRHDpv2keKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049754; c=relaxed/simple;
	bh=4CqL82GVNYHRWFer6kSIpzW9V5Ut6neIsyi4tNcbhco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DZi9uETOwIGvW68V2OiwdCTIjZS2WCuoMKT6IazHD7wQn06qqUGx0Hu7Acosupuz+GsunvQrIyaF48EQDF45xrYNEu/jaxVrEL1/4bAT9VpQVSzGX2RrZ4kMezgzBb3vut6IrkgtbDxPIf5GY6BSU1j+mDNx+cH1pcRkkqHz2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjR/zjAh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjR/zjAh"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-715cdc7a153so1717322b3a.0
        for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049752; x=1725654552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEPWr/xekCDmqr18XIc3NMTS/mqkekh8L9HwJ1zsDOs=;
        b=YjR/zjAha+HnO83XTiJvf14hNssdGCW++X8T3yrFf3LVEJDZ0yx8kfN+kEXcwfRMdh
         d0b7SOl+eOMt9DIaKCvV3oyWL66c/tZwBkKRqBXDfSC79ZE8c2w3gNMKozvzo5oaFjkn
         j0BaOol/Eg85phEqhXDmPp1/CRBV+idLT80Cc29mQtq+OfXEXTAXVFERhUwxYT8ygF60
         VdW6uJEPr2xvbAPtla1/Q+78OFwjYUc7YW7Pfy52pzvJp7VAg4KwXnF6JTS3+TIGHyxK
         nedekDjoR07Kssf9F7daHTOR9mse1xlNBlQ8S2oeRadwhz3ovvxJt7tX5bYwSUSJqegA
         +emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049752; x=1725654552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEPWr/xekCDmqr18XIc3NMTS/mqkekh8L9HwJ1zsDOs=;
        b=OClXrMmmPPIWPb9BdOBXWBFDBZjgvss2BdvUv7nwzW2Cuedd2Zdlfh8SaZxLzaJZ4a
         3TaQ5m4icwU8KVPyAtp3UB0RAfq4fggfPtwapmdByBbACWIs9nxsIz7jpF4R9R6S4wCX
         Pjv902pNotBeEePmVWm/2qUE0et92Hd955sqLb1YgPsvMaKyPJqQJo3bgBs4hKs0rhyo
         3tOlSyUZJv9xsH5+sCVvQ7VvRsK1tOF/AEH3kH92FM4fovATXANqQ/4MDFPqkxVF7qHi
         fioOaPHrgVF5qZe/woPGsWtbasFlb7ox1Rn8oAnjY/1cB4Ee7LEVLu+6jLKAH9wGgede
         zxug==
X-Forwarded-Encrypted: i=1; AJvYcCXeOQVlL2C9O/kd+W3QQCDY7m5bbYlzly3YQg7TmHxz87cxR4Dt6VG8eUArmnNavllQJxv7/iLzSo75aaiplA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfYxnroScnPIK3eo3JQYhrV8sOnbiEEmGvqZZNa9VrtiORV2PH
	3SZ9kiPUJ3WS1DkbilGXHU7A2di9zml2KM9Uvp/lAGJuUPiRub8r
X-Google-Smtp-Source: AGHT+IFqjeYqDDW0p7ov7mbsWnsDnaInYvg+SCciG16pXiE/HxsuLuxNulpcZ6NEkxObce1PH5rryg==
X-Received: by 2002:a05:6a00:9160:b0:714:1a71:cb0a with SMTP id d2e1a72fcca58-715e101f8camr11560642b3a.10.1725049752281;
        Fri, 30 Aug 2024 13:29:12 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d74eesm3257035b3a.147.2024.08.30.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:29:11 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: david@redhat.com,
	42.hyeyoo@gmail.com,
	cl@linux.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	laoar.shao@gmail.com
Subject: [PATCH v4 0/3] mm/vdpa: correct misuse of non-direct-reclaim __GFP_NOFAIL and improve related doc and warn
Date: Sat, 31 Aug 2024 08:28:20 +1200
Message-Id: <20240830202823.21478-1-21cnbao@gmail.com>
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


-v4:
 * drop all BUG_ON, Linus, David, Yafang;
 * warn in a better place, Vlastimil;
 * drop patch 3/4, the maximum supported size for __GFP_NOFAIL will be
   discussed separately, Michal;
 
-v3:
 https://lore.kernel.org/linux-mm/20240817062449.21164-1-21cnbao@gmail.com/
 * collect reviewed-by, acked-by etc. Michal, Christoph, Vlastimil, Davidlohr,
   thanks!
 * use Jason's patch[1] to fix vdpa and refine his changelog.
 * refine changelogs
[1] https://lore.kernel.org/all/20240808054320.10017-1-jasowang@redhat.com/

-v2:
 https://lore.kernel.org/linux-mm/20240731000155.109583-1-21cnbao@gmail.com/

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
This patchset handles illegal using __GFP_NOFAIL together with
GFP_ATOMIC lacking __GFP_DIRECT_RECLAIM(without this, we can't do
anything to reclaim memory to satisfy the nofail requirement) and
improve related document and warnings.

The proper size limits for __GFP_NOFAIL will be handled separately
after more discussions.

* The discussion started from this topic:
 [PATCH RFC] mm: warn potential return NULL for kmalloc_array and
             kvmalloc_array with __GFP_NOFAIL

 https://lore.kernel.org/linux-mm/20240717230025.77361-1-21cnbao@gmail.com/


Barry Song (2):
  mm: document __GFP_NOFAIL must be blockable
  mm: warn about illegal __GFP_NOFAIL usage in a more appropriate
    location and manner

Jason Wang (1):
  vduse: avoid using __GFP_NOFAIL

 drivers/vdpa/vdpa_user/iova_domain.c | 19 ++++++-----
 drivers/vdpa/vdpa_user/iova_domain.h |  1 +
 include/linux/gfp_types.h            |  5 ++-
 mm/page_alloc.c                      | 50 ++++++++++++++--------------
 4 files changed, 41 insertions(+), 34 deletions(-)

-- 
2.34.1

