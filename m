Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFAB342140
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058856; cv=none; b=jDRjRALqyY+xGaPqpUlpJLY8OVtEmkzlWlNKlCjvCPwlQ4rAMOOvwazByf7uKi+pEqbMih7b3Z4uXKqj58tn0+zU+AJqeJvWa8Owf794BKzk1hYVGmFVcTYgqOMQ3+oyjAHXDzvi16KOCUXU4boa2XpQ3I3Uva0WSj2FULJaXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058856; c=relaxed/simple;
	bh=bQcdfA2mrt7mpXYEYdKFgafDPjdfDxx4+RaAhMIH5Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pcHdb5QYBTa9WGnElx4WaBYwodC5PfBNGbsJsA6M872MVS7GOyVH+sA7Ns0vJPzngVow6AajK35nmPCtCjrFog06xXmLnKGCN1bAK5oGqbjtGLEOPwOcXO+3aMWkRbweme4zSI/cvU5h7vxHnxetxshiBEkUgFv4LdWo9j+3y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJtlmdlG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJtlmdlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDLrgg+nqjJKw4aq9VppMtv44pG2L3C4aYFxjxK1b9A=;
	b=gJtlmdlGtmHRjFUXczTpUtiCvUB9qgrx9GCFx3iLh4WDm4CJauGT7FXeqfoVSilLghFWli
	Y5IrJvMelSdrrZ1ppKHXvB77iZ/qke3VXRE8AimAOj03Oag6jEdz9MaEc9xRwAz99TSDB1
	0hLT+RJmhMq4g1iz2Sa7swUdWq4Nyoo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-05ofbNjqM5iFJwtPm-oNzA-1; Tue, 21 Oct 2025 11:00:51 -0400
X-MC-Unique: 05ofbNjqM5iFJwtPm-oNzA-1
X-Mimecast-MFC-AGG-ID: 05ofbNjqM5iFJwtPm-oNzA_1761058850
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471001b980eso35255675e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058850; x=1761663650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDLrgg+nqjJKw4aq9VppMtv44pG2L3C4aYFxjxK1b9A=;
        b=brvlG/1u5xxZf4K6I+XgO3C3VREZwGo6DWfeYSWapC7vrdlGN+M0leKAehm0hI1lve
         +vSFXiDjnyriWSJPtFx/rjA+9CKJYAg9BK0qnNEBSp4wTjRgb5Vw8DXakmH1Vm8AF04A
         zmU/i33k3kLKLeHW2uKirYt/+xYYOu8BaksK0jp2hJo9Nnmd1iCkQxVgp4x78GlLyeEx
         3G13eFldaKSxy65kkRsCZtR4XV8gRHJ+5MyfNiFx89OyFhs0uF/yjI5PVPmIjkxVBwOf
         w91b8lcV4Y6RO4sdQucMLeDOM35pmKt/FijTxIEne21Q0A9f0zso3Nqh7PIKWh0OKrtm
         3NuA==
X-Forwarded-Encrypted: i=1; AJvYcCVc/VvZMRi3C+zLgtJRTqiK2/9Ia+opwNfNtzVzkMSSQN/Ib6MNrP0HWXgL1ZvCv11EXB/dG+Ekz5wWYQwE5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeTbqBUAWkeRXAX0A3anyqgtbG9azN9jAWSIxwHlIoWWtgvekR
	/7JCWWg7pYXt4mtvZqDg3MqHGl2PBQ+dbLHE9vRUAz9bRULwDEGtlLPvMjYlE+xmcyuaRrDfQLm
	adE8hEfNOOGkWvrcfv7O2Ti+QjqrECviiVPBaomjS5XioidLihQlNjefMWBdHe17MZY1P
X-Gm-Gg: ASbGncuxm3uhYNUsmU6/Y0p22Rab4aT8GnPSCGnJnIVjqIKSKX5N5MqCKWtLl7NlZnQ
	I0tNflM/WIw55WM6Q+3xYhuhg3MTREH0hHC1rLFNq+er2aTLHdy2T1nEcgUkzNgBUXnwSl5I8Ei
	T4SW09C6o15id94aM2Oe+9gM/YlB7xNv/fyX4O1fJHSoNTLa1Gf/omN3raSSpQoNqplQ91PWGTq
	f74MeSYt6SHDAk6IhEd9OxrTBi6OaTdk+ewHFY1Me6JP/pDwN6arDBUaM1Xk3OJsMB7kFPV+rHK
	T2vtfMJAP5bl490fXw1KT46aQ8lcSR1+6E1f++SJN9Q4FR3vzl3sLAeC6fz8BBrx9fd3Qngqd88
	PqIB1uB9jZmqF420tgMUY3nzSsmwCNo0FzIH4SwASxkSBBIILgj25K3vTorXr
X-Received: by 2002:a05:600c:3f10:b0:46e:59f8:8546 with SMTP id 5b1f17b1804b1-471178afb7amr120260125e9.17.1761058850155;
        Tue, 21 Oct 2025 08:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDk/chsWh4lmzSq81oi5QgoA5chh2GWI8u8p0fIiNZPQgGrNl16RwScdXvWvZ/Onc3FnooFg==
X-Received: by 2002:a05:600c:3f10:b0:46e:59f8:8546 with SMTP id 5b1f17b1804b1-471178afb7amr120259635e9.17.1761058849707;
        Tue, 21 Oct 2025 08:00:49 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471553f8a3asm233676345e9.16.2025.10.21.08.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:49 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 20/23] mm/kconfig: make BALLOON_COMPACTION depend on MIGRATION
Date: Tue, 21 Oct 2025 17:00:37 +0200
Message-ID: <20251021150040.498160-4-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021150040.498160-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021150040.498160-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 09Op0OoS21qrmAuqHSoeFb_2YYGQn03MxDGLPyfDU4o_1761058850
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Migration support for balloon memory depends on MIGRATION not
COMPACTION. Compaction is simply another user of page migration.

The last dependency on compaction.c was effectively removed with
commit 3d388584d599 ("mm: convert "movable" flag in page->mapping to a
page flag"). Ever since, everything for handling movable_ops page
migration resides in core migration code.

So let's change the dependency and adjust the description +
help text.

We'll rename BALLOON_COMPACTION separately next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index e47321051d765..3aff4d05a2d8c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -599,17 +599,14 @@ config MEMORY_BALLOON
 #
 # support for memory balloon compaction
 config BALLOON_COMPACTION
-	bool "Allow for balloon memory compaction/migration"
+	bool "Allow for balloon memory migration"
 	default y
-	depends on COMPACTION && MEMORY_BALLOON
-	help
-	  Memory fragmentation introduced by ballooning might reduce
-	  significantly the number of 2MB contiguous memory blocks that can be
-	  used within a guest, thus imposing performance penalties associated
-	  with the reduced number of transparent huge pages that could be used
-	  by the guest workload. Allowing the compaction & migration for memory
-	  pages enlisted as being part of memory balloon devices avoids the
-	  scenario aforementioned and helps improving memory defragmentation.
+	depends on MIGRATION && MEMORY_BALLOON
+	help
+	  Allow for migration of pages inflated in a memory balloon such that
+	  they can be allocated from memory areas only available for movable
+	  allocations (e.g., ZONE_MOVABLE, CMA) and such that they can get
+	  migrated for memory defragmentation purposes by memory compaction.
 
 #
 # support for memory compaction
-- 
2.51.0

