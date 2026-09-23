Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB05304B2
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171416; cv=none; b=Rh7WgL0Uzx9XqtcbACJebruCCjzXxftxyl1SDihbml0UfjCFPcs/eHyap3XemYcGMO6COzWRfNBZa4eG1C0k/qVIPwYLWqjw1YbAPXoCeL6K0l4Bk817d9QIhi7C26QQm5epsWDqBqaPqEROHo1ZMsxKB0giUQcNG/rSlIi6KQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171416; c=relaxed/simple;
	bh=7Le+bSKS4i++0atX4ob/re5jRUUIa9YEDMNPqlpG9Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6IoaOEbsZvcpKUB3jJLAUDfJzpStjZ5jikJQcGL05t2tqlAfjOwK/aXPSt3xLfpKIY2wAYOYPGGWyGqebka3S6ZxFFK8rjr59bj4tVwHvPonQbf//UTVxIn6H1UfERyBlaKT+OBYi90eEKIMQB97Mhe1LNSPA9N49YUreu4cdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPzsX+eS; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPzsX+eS"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a0477a4a01so280241137.2
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171412; x=1790776212; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIg/ABLVf9+aKRgVLx2ojwBZLXuVOVgsPgIbjXHaOXw=;
        b=OPzsX+eSzrMNpn+NcT1zE9dnJ2gb9K66ntWl2Res7n4+kpfSwA8cRxBBDpRzlFIRmn
         Tt4H/DCjajabYGIGqiOk629vzAxRg63+VNyfdSsryCjbHifL3W1UOYeMBaWIywLjaqBd
         aYq10ArtOufdC85NRdfug2Kua1/gx/1+dn5vkBNn51/KQGIVt87CFdRNma9nxhHNdoao
         D6+A1ohDDVoasgXo97J10xxDIU7iBJaGRG7AHDiey91Wpt6Y4p+l0shCStTmBlFetl+v
         d1uVW8k/Mor2corY+styxp38/nKpGcLN6N2n/c7+6TcEWCbk6FyJ+AtmKtFoCc/4hbEp
         AS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171412; x=1790776212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIg/ABLVf9+aKRgVLx2ojwBZLXuVOVgsPgIbjXHaOXw=;
        b=oBRIhrDatoHjjRYsBSf0qpanF+XPzMbO9/+akJ1nY2hbMCrng2ql6nouMn8ejJBRkO
         trfa4c+loj23gO+j9ko25s+HIEcBZJTpxG5SdX5gqGJW8/8+yYuoAHcQjUet0Etr++nK
         qi7dGgob/JlbdGjm0H5A8nqNotjFOdTUhKpLSNsAcU8jW9YUsEIXl7Ugk8gUNw1Vzzx+
         ycfwDNtG/p1M9+dqCCEz0rvbqxMiaCJIS1wUk2/dZpsGOGdFgcDISa0CjP1s8uVrLBl1
         AqMKxcIlIWix4CEs9gLqMXStBzLkHlFGQMWjtcasTATE2cIgCBTms76Wg0E0UMcSX6Gf
         431Q==
X-Forwarded-Encrypted: i=1; AKwUvBykqhY7dUIaBQdTH+ja5rFh8cMbPAkmmZKnwAuZWlMxjZcpwkadcEpPJGCXf469rAjO6mPLzGimvOjxuz7vBg==@lists.linux.dev
X-Gm-Message-State: AFuF++nXuMqpUhgdWo9fCVvOaoKa4ZTLHBZ11G8bIptVsd0vzzi6tpuD
	2HVwWW9QC+E2ndbFbHcIxGlsA10Meob+k2EdWzZK68oCTiWZwWlFWAvE
X-Gm-Gg: AYBFou1XpBVnUcSi7CDbpoi+3y3YbyFOhweWjPMAy7R1um8cPOhbcojvfDiPyfJjCxt
	SJcR2mUXstCyT2O04txGv/g1PJPi58vn6a0rLE9cI5Y9hPiDwZVVqdbOT+hplaFDVBNqVyD2O8h
	xZpFhk5m8l2eRzzKsxHcUfIRidPuc2WfJIxrYGYNPDK2Wc9693MrdoTthjL+0K7Y6PnkUx/allP
	OMX2hvqK/DSVsEOtdyTNtjAY0ITsAYWeSLWArLT3d7rzL20sDsnW0cMGh6dQv8GXeFXkM3KqR7a
	2/ImdcleAH+o+FZgZIKaVf9MIBmrjYEX45Xr17nOdg2jviJjE/qEvMp8fRNKoOiI6W9tTcLGeCa
	QJh406hQqD/GkfvDeB2Ohlxc+4KotLAFWrli7PLw61R+SWLGfxQPmeXgfQUsfRq/r1ZVGZH2fgv
	Pwu5XkCQjpWgXubuv1G48/e9LZeGRya2vqzC4KwBWAChgZZQnM2Zr1L8kNdcOHsPU=
X-Received: by 2002:a05:6102:291e:b0:7a7:ad9f:53c6 with SMTP id ada2fe7eead31-7ac1bb4a3f7mr2276292137.13.1790171411528;
        Wed, 23 Sep 2026 06:50:11 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9852407d1f2sm113126241.6.2026.09.23.06.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:50:10 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/qxl: remove double page-size scaling in kmap fallback paths
Date: Wed, 23 Sep 2026 10:49:52 -0300
Message-ID: <20260923134952.1750600-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qxl_bo_kmap_atomic_page() takes a page_offset parameter that callers
compute as a byte offset aligned to a page boundary:

    reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
                                         info->dst_offset & PAGE_MASK);

The VRAM/PRIV path adds it directly to the mapping base (both in
bytes), which is correct:

    offset = bo->tbo.resource->start << PAGE_SHIFT;
    return io_mapping_map_atomic_wc(map, offset + page_offset);

But the two system-memory fallback paths multiply it by PAGE_SIZE
again:

    rptr = bo->kptr + (page_offset * PAGE_SIZE);

For page_offset = 0x5000 (page 5), this computes
0x5000 * 0x1000 = 0x5000000, a 80 MiB offset instead of 20 KiB,
producing a massive out-of-bounds access into kernel memory.

Remove the spurious multiplication so the fallback paths use the
same byte-offset semantics as the io_mapping path.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -223,7 +223,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 	return io_mapping_map_atomic_wc(map, offset + page_offset);
 fallback:
 	if (bo->kptr) {
-		rptr = bo->kptr + (page_offset * PAGE_SIZE);
+		rptr = bo->kptr + page_offset;
 		return rptr;
 	}

@@ -232,7 +232,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 		return NULL;
 	rptr = bo_map.vaddr; /* TODO: Use mapping abstraction properly */

-	rptr += page_offset * PAGE_SIZE;
+	rptr += page_offset;
 	return rptr;
 }

--
2.43.0
