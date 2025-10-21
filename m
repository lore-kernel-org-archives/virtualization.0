Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C560335BC1
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051586; cv=none; b=SuQIAiO22zNgF+zwq0gqTS0YpciLUrw3csJfRmC6EI4o0K/5zxaYUmpRzPHtj2cendd07AWQgKSZFrgYyeTqNCB+ew7HFxdGYV0t2Y0KOu2uTy0hoMHi4LyHN5dHBI3lp+xox/ESUxUA9UWxvIS1zIKduuIWOOXayhbFpL+9p18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051586; c=relaxed/simple;
	bh=ZX1IzZQQgreBcTlZHB/kVI28Gz8nSRy+pF223nJsGSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RLOX21LG29QjvW7iLFHL3TBmUzfkvxzNM1ig5GQRyQVw2L5NE05BoeeJnxlCcFAx9Jhj3tJC2IagLNAUAAFdsPhMQAvl4UFLudsoU4u3PY1in/JBrNzSODeWa349BIoa/5MDeNIHqQuKZ4Bt4qxCA1gYRNRdijeL1gP1tere6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWRej30T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWRej30T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cInpBRrRn5ydv+Sa63F4MdgmnDVvTCru+7wR3lsxUS4=;
	b=FWRej30TYYnPeFlWDXkomwx9Ogie31ypXdn3MLwQh5AxMxw+gbhFtOurzLDcnLDTFYXFm6
	WHp0YHBeJe5mFlOB7PQd4wUvvywBmAEuSzWDJXAxAT2u/plRM7Ykf6uRszgdBbCzngOdku
	M2GxICnjIMsLkynRCZE9pzxdPsd53OU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-IBeGSFCwPXyljZQuDF0P_A-1; Tue, 21 Oct 2025 08:59:40 -0400
X-MC-Unique: IBeGSFCwPXyljZQuDF0P_A-1
X-Mimecast-MFC-AGG-ID: IBeGSFCwPXyljZQuDF0P_A_1761051579
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso7680405e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051579; x=1761656379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cInpBRrRn5ydv+Sa63F4MdgmnDVvTCru+7wR3lsxUS4=;
        b=jl6byu+g5pEvZwc2sQwKhaPQbBcPv3LIU9TK43d/OskWYGZL23I9KzQj3SxEZ9m8D0
         PiVlsWScR3CIs24cO3d16mp/1zeiQiOClsaLVSM8yKXgjuG+12CSX+dusuN2fe+JPpnf
         6zRH/FMAvvdN9vFAhojkrfh/b59GFjGJ4aXzSo9l+Zrbti7UPbC8HRY8vgYuwMzxzXeG
         bC48fkygUsuXdTqLyhtNVVOtWjlTxp2mMt3sEpV07UIfAl+XgqyTwYDorROryRCbHV6Q
         00vQUyGCbuZTiKYjD7sQaIssdOKBdTJ+5CF2+yE1j8cXBZEOJcmbyE2JO9q04T8WDkKF
         AdRg==
X-Forwarded-Encrypted: i=1; AJvYcCU86yNwwaVBh0U5uj3fyWftRjptDL2sAzvUT0PdbiBdZ4IGRQgP5UXs9z3miTaN+sT+938HpzoVy3dCvOSqdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy03yUGBQadwbyhxqIRvtohkAddbxcEFOJrKwXl6r+iM6sp72F
	F8h5SjWhzG5R1worK8dA4bps/XGNkwsxeqL1KcUtWKTLBaKUJ2gS2ag85QokFENr6Xhzu8kucqG
	5Qd5AhqUtuxlPkByHQc0lnuwwS2zRV7XawjccsIAa83sDkO9JMBOFQ/MwKPMVTv/5BXUM
X-Gm-Gg: ASbGncu2KJ3+F7YAcKBFogOcAD3jn+9dK62D42ed2uSMG8lqJE4gnt/L4mtfuFSlHhM
	k2fEkgbPOew/isXic7UDMeh2+7tRG/VoVaXcQDwiOUP9cRAOVYRWH4B8nZDmCETZs0YVFsG83qE
	MuWZaTzgxacHXTwRmlP9aCU0uKCVNsk3RowGAvhasAy98Ae1C4PjzkLy9DPeYNnJnRP29CbpfoI
	UtCbGidku6b/cowvYh4a2KqwSnfABWRfcMxEfMqa7LGM8Q5clCTgwSEHRHx5924mBAYTsHJESpr
	j7Xt3BzLMA3A2Xr6dJQmYNliPmDX0hdNX2MHC7MbmNigKonNnaeFkJZZQYjoHTULdDw464S+Mcp
	wq38IHVqvHjPl/IiebZUYtRMCMxM+S60Q5bExH8ih/Wn8i4h2SZPCorUMcIXQ
X-Received: by 2002:a05:600c:811b:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-4711787c803mr122622435e9.12.1761051578979;
        Tue, 21 Oct 2025 05:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+zjcAWFH7UfZS6G5yWsBJ4PGUBhvAl9sC1ULzHpIWHcC8Aeot/GO9fktrhO0M9VdZy+aJsA==
X-Received: by 2002:a05:600c:811b:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-4711787c803mr122622255e9.12.1761051578618;
        Tue, 21 Oct 2025 05:59:38 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a781sm20658322f8f.30.2025.10.21.05.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:38 -0700 (PDT)
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
Subject: [PATCH v1 03/23] powerpc/pseries/cmm: remove cmm_balloon_compaction_init()
Date: Tue, 21 Oct 2025 14:59:08 +0200
Message-ID: <20251021125929.377194-4-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WMwpL1JsJAGUgmHO0nUk7EVmp7UnYzLTnDeCeqBJKuc_1761051579
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that there is not a lot of logic left, let's just inline setting up
the migration function.

To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
the compiler happy by only providing the function declaration.

Now that the function is gone, drop the "out_balloon_compaction" label.
Note that before commit 68f2736a8583 ("mm: Convert all PageMovable users
to movable_operations"), now not anymore.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 310dab4bc8679..67c7309c36147 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -548,15 +548,9 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	return 0;
 }
-
-static void cmm_balloon_compaction_init(void)
-{
-	b_dev_info.migratepage = cmm_migratepage;
-}
 #else /* CONFIG_BALLOON_COMPACTION */
-static void cmm_balloon_compaction_init(void)
-{
-}
+int cmm_migratepage(struct balloon_dev_info *b_dev_info, struct page *newpage,
+		    struct page *page, enum migrate_mode mode);
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 /**
@@ -573,11 +567,12 @@ static int cmm_init(void)
 		return -EOPNOTSUPP;
 
 	balloon_devinfo_init(&b_dev_info);
-	cmm_balloon_compaction_init();
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		b_dev_info.migratepage = cmm_migratepage;
 
 	rc = register_oom_notifier(&cmm_oom_nb);
 	if (rc < 0)
-		goto out_balloon_compaction;
+		return rc;
 
 	if ((rc = register_reboot_notifier(&cmm_reboot_nb)))
 		goto out_oom_notifier;
@@ -606,7 +601,6 @@ static int cmm_init(void)
 	unregister_reboot_notifier(&cmm_reboot_nb);
 out_oom_notifier:
 	unregister_oom_notifier(&cmm_oom_nb);
-out_balloon_compaction:
 	return rc;
 }
 
-- 
2.51.0

