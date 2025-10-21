Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EC333733
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051582; cv=none; b=B/D95wG6v+Y+w176Ulo43+/wPgyrQOfK0spkbkd8z07kj0tEo/Ybmaa7cWHQTgyCn9yoxc1T5SEPRCyqnM5Icb4XCnhcG5XNw0f7iMHQ17VLgNCB++YPvFgJiKE9QsH57ynBiVhT+Q7CIJBfmxtvnFjUeN0nZhYdDRjAPBCbVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051582; c=relaxed/simple;
	bh=L+63bx9D11EYkqLrccK+lnT9JaJRwWO+dQ0bdJZ2z3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mzQFwgWgL2iRqqdGNhQb5TGsEGPVIJyAIyCRj07ypRdSujXUcCxwhAaZo2XAUhOuSPuKApaRyXxwtk4S1Yp3kzwMBUJ4yX7zSZY25zhjWKEwTTOrKCgni9IbVfmQXPvGgZ0a/Ej+kLSSCNoVMbFNpJcm0f4nAeJuuTtbmc8ySvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd6goDZb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd6goDZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8R/9+ffq24GRtsamw+sO0Dq3xyN1P0TNXMmPfo3y584=;
	b=Nd6goDZbxtHT0pGcSMcrGpJGZJXlc1s1oX2XhVKHKoXm2oaYRGzoGgOf60636RJpaNviSr
	TU1NM9ei4JzOG8FRB/FKPRxeMeBSvPCgdIjzIl0uxBf42NA/UEtu/3Et4KBTk7utK8gVcU
	pQlVNzSh5LoGNdbVN0NU72/zT1Go0ok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-u7Qxq7boNgSO68m1l_X5Gg-1; Tue, 21 Oct 2025 08:59:38 -0400
X-MC-Unique: u7Qxq7boNgSO68m1l_X5Gg-1
X-Mimecast-MFC-AGG-ID: u7Qxq7boNgSO68m1l_X5Gg_1761051577
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471144baa6bso32644985e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051577; x=1761656377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R/9+ffq24GRtsamw+sO0Dq3xyN1P0TNXMmPfo3y584=;
        b=vPexo5aFgr2OWsDFJ7V+XhS5QTyYN8fnSih0O7eynyo0yiH8QXcuY5hfbfKcM6MoAU
         tID1/ZjnpTt7rL4WFQmj0Ic3tBu8S5BWNxuxmeBtM1J+4812DSTEJXO3BNoFRtrkMcHI
         h6kLiguj2XlxS9Udq1vOzTllxpAYG0KBeorWlDaDwr1/dGaVENDBIZKms6oXNFvpVoJA
         Sui5d3Q0SyEYZZRABe1YFG6fSsmsjt+tHyzhJjiffBXARsdNZxMuPGIBeO/wIqrmM51K
         lLqKURyzgQnhCCCqoh22zZ8l98HVUCJGoXOOyZPeqVWceNuaKGiVSfKZ9a6plwr191yA
         pMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+YV+DHu3aLpMHLT5izHSdiAOiG+Z/C9qM1QhNUi+ClCbZWewbtoG7ubnKcVdwqg/xnOPwgiwchyAzvB3QZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfI6AN3SH3CURXjfSuMhFycfDxsdoYqAso8x05vR7MALhT0jEk
	Wr1Br3pprLYcRQ0/D2RE9tsCj463C6MmKWx+4mSX2wNmbtWD8W/DbmgIumsFTTXbG7zP0Rla5Sz
	+OAl40+dHctyy4PCa1z7yX1CUd7trBh1/BCCPKLioGT4W7fq6onpH8yeDs5g2Bw4bKJFt
X-Gm-Gg: ASbGncv1z7KCCJyJ9eyrsInOk1Lg/RUAWj5vvW/M0sCwO8I3VA1AX/vIsMnTlOu90cG
	Tl9iO+eBgLXToZBKkj09D+YgFRsXNlbbaLL51BWHw006enuEGemQcHkeaDZeOuPZx7WBUwjGKwx
	Oe+wPKfYNsin1PzhXJNpD+hg53PEXFAVFS3GF5WSb3nA3XHCyhVKKmyxTZ+4ZxwpTjspspyC6O6
	M+QIhA5ba3vMHD28A0Uk/xnzt+QVDgSDcuzA8BgaG4aPxyiGF8QmlaFH5pscoVsis0PEf64kPET
	QQCtRctJfkR56s1Q2+r9NWvOvEzj2HZZFZQFdpsY9BPlvgdDPwhwJAP5hyz8JKnIaO8iK6933NC
	YlBPgDVhn5pOkQx4iCxxJsMKCPN7xZ3b3UX+XrC16xcOErX2iIYmjIwO8v9GQ
X-Received: by 2002:a05:600c:444d:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-471179202famr118678205e9.36.1761051576974;
        Tue, 21 Oct 2025 05:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEokGBhUzCRsmptihAjBHDZlL2+6LwM1McdhB6sS9tCAS0C96fTIUzPBBNJE//85lgKmaBsaA==
X-Received: by 2002:a05:600c:444d:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-471179202famr118678045e9.36.1761051576500;
        Tue, 21 Oct 2025 05:59:36 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47496be2eb6sm16562465e9.2.2025.10.21.05.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:36 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 02/23] vmw_balloon: remove vmballoon_compaction_init()
Date: Tue, 21 Oct 2025 14:59:07 +0200
Message-ID: <20251021125929.377194-3-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nXJZgRPJfsUNyM2TOIDG5GSTLE3j1oDSU14mWxNNqS0_1761051577
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that there is not a lot of logic left, let's just inline setting up
the migration function and drop all these excessive comments that are
not really required (or true) anymore.

To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
the compiler happy by only providing the function declaration.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/misc/vmw_balloon.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 2cc34c4968fac..07e60a4b846aa 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1833,27 +1833,10 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	up_read(&b->conf_sem);
 	return ret;
 }
-
-/**
- * vmballoon_compaction_init() - initialized compaction for the balloon.
- *
- * @b: pointer to the balloon.
- *
- * If during the initialization a failure occurred, this function does not
- * perform cleanup. The caller must call vmballoon_compaction_deinit() in this
- * case.
- *
- * Return: zero on success or error code on failure.
- */
-static __init void vmballoon_compaction_init(struct vmballoon *b)
-{
-	b->b_dev_info.migratepage = vmballoon_migratepage;
-}
-
 #else /* CONFIG_BALLOON_COMPACTION */
-static inline void vmballoon_compaction_init(struct vmballoon *b)
-{
-}
+int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
+			  struct page *newpage, struct page *page,
+			  enum migrate_mode mode);
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 static int __init vmballoon_init(void)
@@ -1873,12 +1856,9 @@ static int __init vmballoon_init(void)
 	if (error)
 		return error;
 
-	/*
-	 * Initialization of compaction must be done after the call to
-	 * balloon_devinfo_init() .
-	 */
 	balloon_devinfo_init(&balloon.b_dev_info);
-	vmballoon_compaction_init(&balloon);
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		balloon.b_dev_info.migratepage = vmballoon_migratepage;
 
 	INIT_LIST_HEAD(&balloon.huge_pages);
 	spin_lock_init(&balloon.comm_lock);
-- 
2.51.0

