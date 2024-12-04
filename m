Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E21F7070
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316911; cv=none; b=kzWoEFU4jgzYY2Npvnpdq69J6PCtDfCB46crOIt6HavqVv63ZAhaSy9rMRLKCyig+WZ+mHQ6TvgPHeIptB2sGTTyGL70Hqufu2LTpqk+MT86kYvB5QZbC6+Y6aNR8obD6EALstcUdPDIfKab85VIfY4L1+QzCQG0mQRobyzVezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316911; c=relaxed/simple;
	bh=GU+EylrtNkBl0PCgVUrji2d7nB4cQuMPE/K3NHw4YGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sd92DyQ3PoBE7i/YJpgCZjO1ppzvqRdq1IjpNM7QL9OLEIy97C+vS8hDmy0ULUMnpkgRR78eOgwkYU+760Ai/DJMZQvhH7IzDe0irYMcP38syfiT3PXbRkUAAeBs40rI9gzRvx5j5Lz679cBHzB+aqVXPn6+GYfnc6KH0fsyHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXB0Qe3S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXB0Qe3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TMBFu0zsYs/BK8mI3BuEemyVvVnFxsrbDwOUtwonV0=;
	b=ZXB0Qe3SDwA17RUnOpcp43lo8CjYMTnbwYhE0Mn+TFbXoj1bmgn1pROo6WcPntOt3C5hGs
	/AbhT01j6InMCpUNxK36PG5W2ehXOFWS+EMzkvMZ1ZX0BHCSEoRNNuD5z9YjlAsxciA4VA
	nIH5QDabJZXgJKAMRVOMZQl09TeagLQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-xNrU9DxWOSS0z-HaTY8Huw-1; Wed, 04 Dec 2024 07:55:06 -0500
X-MC-Unique: xNrU9DxWOSS0z-HaTY8Huw-1
X-Mimecast-MFC-AGG-ID: xNrU9DxWOSS0z-HaTY8Huw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385dcae001fso2825619f8f.1
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 04:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316906; x=1733921706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TMBFu0zsYs/BK8mI3BuEemyVvVnFxsrbDwOUtwonV0=;
        b=AspzXT0R8ew/kx/v3Y7ChEvWHATrEVkZiMC1IUULrIHxgxELKhYqOpi73xiWMk1O/J
         84OSyi7KHuEVLiOHRuM1aMSKhwr4T3iFoN9Iix+Jp6LiC1V6vCkb5X26qlnszZxW4i2E
         7yFij77TwOG2QBcqEBZRhMKdeh6mhS/5FL6CapQas/p5m+lMpTh2kOrqFHQ2GssWUZRs
         3EO5oiTscLwNqmenFrnH1MVECf5NNQj9f4V19fSwzjINMpegB+kfhm5flknga3SwXT4h
         8O7BZz8wYiG+RWCRenuPu/6/ZSPIu2DNyuVEK31q2dOVjEbDdDFq6ACb3EOakA4et8Pq
         i3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCW363Z2BYLR+zYrr5GCS9II6EKBRa9xUEcJmOq/4VtTyR9WIthBqmBY3rlRlcoR+jqzf+TOUHB16Q8xj4zXvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5W1bMrEWsq/zZLzIY/0vyOG+grPmZQbppwOSN71DXA8+btDeV
	idajmkzrkujSiMq7q79qM43Q3ZL+ao8yN2QIiDC2TZ6F+UNyOiCI2yxwZ0ZDyfTRXt22oKTXnpY
	zMIVp5ydYfXz4ubAfumJ6XlN/zMSaInm6MLE3NJn29zOK8g0Y7EVhHhSwnIkEGZfkhjwb8GfRR6
	Y=
X-Gm-Gg: ASbGnctQTsWADNYrbgJJEnKHHycEsWe55QtGeNmaL68y2NuTF1apk7AL8qNbRCtg39S
	wd5tnGjtG/0PF6gvP4xFCwANz4uPf0MTULHAirhkbMI2NL8tIL8O06b4wpsLb3VxlRSrB/fYPJf
	auKvLQDIKMVkGMAkcFDDSJM8Pl3DFlN/47NH7x1zv8mLBHZMJYuCt+S9SIjcLLTM+HaqsPNQbZc
	B/YlisPIIoIZ+ZNZwZpDv3BVCChtKg4JYEg+a4VMDeLawNUNPZ/kmyJJVNmimdfyE1YIBO7Fdqk
	PmUXcgOksBxCWGUhK8j8W+w5SqlFgG0kbAI=
X-Received: by 2002:a05:6000:156e:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38607c0e1e7mr3561610f8f.43.1733316905762;
        Wed, 04 Dec 2024 04:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3Vs5XvVpD9wVjl4Do+O4dwdUFKsmLeUCgsK0LBk5udBDNdRPox9DV3gXL42llKQONJirIJg==
X-Received: by 2002:a05:6000:156e:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38607c0e1e7mr3561572f8f.43.1733316905408;
        Wed, 04 Dec 2024 04:55:05 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ed8dee66sm10241947f8f.104.2024.12.04.04.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:04 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 06/12] fs/proc/vmcore: factor out allocating a vmcore range and adding it to a list
Date: Wed,  4 Dec 2024 13:54:37 +0100
Message-ID: <20241204125444.1734652-7-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 49CBrSvs-hetbHGd8FwJ-f6jnIBEGBvBJwC4bcqMOPA_1733316906
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           | 21 ++-------------------
 include/linux/crash_dump.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 8d262017ca11..9b72e255dd03 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -709,11 +709,6 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_mmap	= mmap_vmcore,
 };
 
-static struct vmcore_range * __init get_new_element(void)
-{
-	return kzalloc(sizeof(struct vmcore_range), GFP_KERNEL);
-}
-
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
 			   struct list_head *vc_list)
 {
@@ -1116,7 +1111,6 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_range *new;
 	int i;
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr *phdr_ptr;
@@ -1139,13 +1133,8 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_range(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset. */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
@@ -1159,7 +1148,6 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_range *new;
 	int i;
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr *phdr_ptr;
@@ -1182,13 +1170,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_range(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 788a45061f35..9717912ce4d1 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -121,6 +121,20 @@ struct vmcore_range {
 	loff_t offset;
 };
 
+/* Allocate a vmcore range and add it to the list. */
+static inline int vmcore_alloc_add_range(struct list_head *list,
+		unsigned long long paddr, unsigned long long size)
+{
+	struct vmcore_range *m = kzalloc(sizeof(*m), GFP_KERNEL);
+
+	if (!m)
+		return -ENOMEM;
+	m->paddr = paddr;
+	m->size = size;
+	list_add_tail(&m->list, list);
+	return 0;
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.47.1

