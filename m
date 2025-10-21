Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0833890F
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051600; cv=none; b=k4mV87ueWfkN/4s/KcA8kycRNlumWpFEb8K9nvVsvO2JhjiYTpiLY0W2n+VoSOwew43mEx6FvOmzrC2tlQFFIHlK8e4tn7QgcXTXX0+89Hlp4YRCdQ0wcpd5HEPqtPaR+IhDLojaJWYooXxP6QmM78viWIUgiqVGWNpo6I2m9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051600; c=relaxed/simple;
	bh=RVpO0/1Rr2WqDw7IdAgDtrk1Tta4kn04Oz5nTYeayzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=px94rWfOhkQQzY6qdE6X6hyh5ogU/koTN1zBHZvXrU/rTZJ5pXlJ/vOPe7cRjhnver8fz/SUmMWFx92TfhH5R1Pv0n/sCY/prLVfXeulhnfrYDq+Yf5nVmDFl+yNUV/Gt0k5Lq82fROiM69jJZ/DZjr6Vbkxaz6STp5zIFYyFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BF1ComNc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BF1ComNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a58UIIapVgV9zdPpt63SgupeCmEgQ8fjnLkqSW0/g7g=;
	b=BF1ComNcbnYMa+SCGmB34BLXFXqpg0uNWiN7i83kAcWnDrxSelQnv2OhHtToKL7o6OzSVf
	fNS2kqdbdFJDJy7Me3CUkYxa8X7JAvobgAUoeL0nnHHkmA2S+N8vKetq9P8Tb3uPwcwCJz
	GAFjvAMBf0/VFI2iICo9Ix95vSY0Agw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-DnjQAm-6O8GFDqNB1SiJNw-1; Tue, 21 Oct 2025 08:59:56 -0400
X-MC-Unique: DnjQAm-6O8GFDqNB1SiJNw-1
X-Mimecast-MFC-AGG-ID: DnjQAm-6O8GFDqNB1SiJNw_1761051595
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4283bf540ceso2237485f8f.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051595; x=1761656395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a58UIIapVgV9zdPpt63SgupeCmEgQ8fjnLkqSW0/g7g=;
        b=mbAUHrJsHVEsnaUK26Zms42sIg8unEvucvylLsFvrP/Uu7Zpq5FeIG28SzoRnPPjSz
         YVRdfrqSw4C3Kf9IpFETz/xd7Fmf1/aFnxhZhcTVc2Vt0PSYg8La3ehHZHXb5lWPBqhh
         ZnbOkeDuMXXgIa7ER/eNXZgVtTYZJO8AgCwMfNMBwBvvrG1Q4YT8OEnpl9FT9rzY3D/l
         qsrMyKf3I0CMRDkzlrK7ECT6YRSUQuTqaXsiVt5gsBYDS0w4u2H3NFS4nFc74i8x/5tp
         rzqa5xVh93w2kvjYzcuxvPWe9U4ZhxgQ3/kaRd41mMNNDf0vNNVDcFDOxce5BsG9IaaT
         EJjg==
X-Forwarded-Encrypted: i=1; AJvYcCWKFj5P+/lw5YOVz/RUx/vENHacPRzSI8bcDLyNtrpxF2e2kwDnhX1V7SJYabw7JmROtRf2Z72fbO+KhKtSMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb0Us6kIaa1EWHA3dtSeG5U+LltcafiQMZjciRCT8ebmKHeR9V
	LjfmZwGBe3JFYxOFUfeBz9qt+/4ndgQUWzlMAkxpKf+JEVtUw5YvAv4Aequ2g7Km+PfL0YJtp18
	RNfgTUwbAqe2AY6xtigwRMJK5lLnsllutLwlRa+6LTZGZJz6FJehOdoqvvtOBOHLcHJ6k
X-Gm-Gg: ASbGncuCfF7ovwc8TQfj3dt7V0AyIoD/cPJVnobpNPtsEzngdU2gLgJCqZcC6QRZy/8
	6xWSCSc6ki7dnsAjrcMe/PpE+RkqnvEpDaTLvb4DcgkkKbaFyUCrV2BDs9uv6Hpx7bw/HoOPG4D
	RCCTQRmW6lRxEeqVA4GK8PCEI7tnW4GGv+N+xiK44gbHP9Lk7i+5GS6R3WZA8yPTVngBaeNJEH4
	ssT++aFkTWl9Bs/AqTo0sZtcceAJZX0UDA88JjMrb0Vs3b+xIVrOoynWYY4G8/yRKeCMqnqqkDK
	mshdUHYs7lo6GvywFxIsuU6vWQMjdXUCyTLg1zKk515eJ0uI8t8xagzllRGyou/U/wZ2pS3S3Df
	p3sR6j01rDb8EVx9eYBkv36kSMvA1oQEs/2Ak/9ncFqxFLTLoC2BxIyGNgISY
X-Received: by 2002:a5d:5f48:0:b0:427:2e8:fe5e with SMTP id ffacd0b85a97d-42704d83898mr11742009f8f.13.1761051594847;
        Tue, 21 Oct 2025 05:59:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOL78NSzfD/K3cQTXDnH1hifM9lFea/fB9GzfGevY7RVlJ9OG6SsU/tMvE3AQ+AuHnf7dxjA==
X-Received: by 2002:a5d:5f48:0:b0:427:2e8:fe5e with SMTP id ffacd0b85a97d-42704d83898mr11741985f8f.13.1761051594394;
        Tue, 21 Oct 2025 05:59:54 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce56csm20023457f8f.50.2025.10.21.05.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:53 -0700 (PDT)
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
Subject: [PATCH v1 10/23] mm/balloon_compaction: drop fs.h include from balloon_compaction.h
Date: Tue, 21 Oct 2025 14:59:15 +0200
Message-ID: <20251021125929.377194-11-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: uhLJoIjLrsUatIvBAdMw6uTqnMyg3t4_PP51JRBXO6c_1761051595
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit 68f2736a8583 ("mm: Convert all PageMovable users to
movable_operations") we no longer store an inode in balloon_dev_info,
so we can stop including "fs.h".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 7db66c2c86cdc..1452ea0635245 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -42,7 +42,6 @@
 #include <linux/migrate.h>
 #include <linux/gfp.h>
 #include <linux/err.h>
-#include <linux/fs.h>
 #include <linux/list.h>
 
 /*
-- 
2.51.0

