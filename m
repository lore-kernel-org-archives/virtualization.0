Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274861CCEEC
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316898; cv=none; b=FLDiJyjRVLcGevdHY5oWe50B1fSLnlgSjhXt0BHWlo9KiK7A8b49IH6ICvbYn77Vw15JiWNuEwmXnc2fUDOyofdcptjdCCH0uU9GSa3ZnhpdXcw26IlzzrJX4BlNKuAgEdGqzTO5X8/sl9FuKRLFGRWAqj2UmVwyidiJxqgvXsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316898; c=relaxed/simple;
	bh=WdYleG7wq0/QsvZ4l+B0SUHHNWJZ0MpP6g4l1w+mx3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZMuROrDgJCe8VHBB02LPi5rXQuAKLW6cLPD6ywVFzO9WWe5Co3aDOAHE97eYXJ6iPNxtw9OKI6X8kn4Wt/MB2i4DUdt54glM/rNvLcn2oS+yyBbb90IlLLg+fcgoE7Cdm26qmPcXK5TEHQZyhPlUIBZk11n4LaELnElh21l/0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GunmxSy9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GunmxSy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=;
	b=GunmxSy90/g6QePWMgtggml73as1tWEu180Cbn8AQmHvZ6Rz1eCZ6Oq2R9fGFcbgf2Swe1
	t+sQFoCP9O27BX5VgG5LyQNjsOVN6bmfLHjv2VjWyQd47WWPqz6SPaE9YK62Au29s9nbyA
	6cewNXD9bJ+wDleyZPwpITZc2Y3Wmaw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-M8zAtxwZO5mhsu1Ncrmm0w-1; Wed, 04 Dec 2024 07:54:55 -0500
X-MC-Unique: M8zAtxwZO5mhsu1Ncrmm0w-1
X-Mimecast-MFC-AGG-ID: M8zAtxwZO5mhsu1Ncrmm0w
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d735965bso3352431f8f.1
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 04:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316894; x=1733921694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=;
        b=seMqh+rj+gwb0geS9n/rWYrsdQJ8grrfXcsAydbhDr5Ff790BUXeX4d6QYIxsX2YUE
         33T0patu/0Luu1y32XJ/sp3oKDITJip02Pn9WBpzfJkm/Sj0V6EB9wLEjbuq6ZQXXwXF
         VPoxdBmh/1F+G9lAttgWyQkpOpbnrmG1lj8MXAXdcdqrKqiQNr1Zlo55EJDBtQjce1TU
         D4NixEFniv8ijy0OqG+xuHqVuxG96lgPv2sil9Ohdr2owMiUM9DNoO8CucMc3/Im7IQZ
         Uvp4Uz0E9j01wj6TID0BKd/nmbcjZExmwE7xzdOqZ7RIcMWibf15eWZmEmQnXnb2Ah6Q
         BuDw==
X-Forwarded-Encrypted: i=1; AJvYcCXdZ75lkUWLpObvqWtvS24wd45T8du1POe3BhkwjqlSmpudxemgwhdYcn4eO609q4MgPRoz85JkUv5mMvoCxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlqxvI9yn/tGjVroyuJSRPCssI39XBRVmR09jKM8tkmtvY/ql5
	B7qX7OUrsQoF/iZEuDHF6RDoBc+sUGRgyI3ogHDWTz4nVdltukeaLJ62P3clPrArVpb0vQ6d2qz
	sBWh307OWqCKrVtiIH8kVpIq1EnCriH7vWdZEPrI03VBLOQtG3gg09FJ9lyJqYHCt
X-Gm-Gg: ASbGncuCtT51WF3DW/oIY7coKyKlVPoCGjBklULCxJ2GXFzqWtGlP3RdRvdjnOzI9Pd
	8/fo0o5ZZL5Dn3OlCKqX8UYnjOWP232+B3P1sizOFIQ0o1A5Y3fxWjVwXkCQXw5OT4cKvxbE1Oc
	xjPfOVUe5lSLAABdx/BD6e4o1Xa5sHxcDmWEmoEjKSB9myjHFf4S+WdmP6qIXdaa9aY9Lykvo4E
	2T5pDGtU/0jJsGgHqRvoTBeFSB2GwwiV8JthmuwdjgfrU/mk+KJhlZCGzWmvd3UcMJvUiRAq6nD
	gYYjwwbi3LWCFFR/WuCGg+em6gbNjX5Wr2Q=
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5400392f8f.33.1733316893967;
        Wed, 04 Dec 2024 04:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvdtkWkEwxi8mpcTLDx5Tk+eqhyWjoc+BX5ypLCUE7CH8mOKCeowIphEqt4hXFtq1npl/2WQ==
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5400356f8f.33.1733316893544;
        Wed, 04 Dec 2024 04:54:53 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c12a4sm23880495e9.30.2024.12.04.04.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:52 -0800 (PST)
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
Subject: [PATCH v2 02/12] fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
Date: Wed,  4 Dec 2024 13:54:33 +0100
Message-ID: <20241204125444.1734652-3-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Va_4MdmGWUe6ZSaJqMAN4a0JCv402W7129BwjLdCrKA_1733316894
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that we have a mutex that synchronizes against opening of the vmcore,
let's use that one to replace vmcoredd_mutex: there is no need to have
two separate ones.

This is a preparation for properly preventing vmcore modifications
after the vmcore was opened.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 586f84677d2f..e5a7e302f91f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -53,7 +53,6 @@ static struct proc_dir_entry *proc_vmcore;
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
 /* Device Dump list and mutex to synchronize access to list */
 static LIST_HEAD(vmcoredd_list);
-static DEFINE_MUTEX(vmcoredd_mutex);
 
 static bool vmcoredd_disabled;
 core_param(novmcoredd, vmcoredd_disabled, bool, 0);
@@ -248,7 +247,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
@@ -269,7 +268,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 	}
 
 out_unlock:
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 	return ret;
 }
 
@@ -283,7 +282,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
@@ -306,7 +305,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	}
 
 out_unlock:
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 	return ret;
 }
 #endif /* CONFIG_MMU */
@@ -1518,9 +1517,9 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->size = data_size;
 
 	/* Add the dump to driver sysfs list */
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_add_tail(&dump->list, &vmcoredd_list);
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 
 	vmcoredd_update_size(data_size);
 	return 0;
@@ -1538,7 +1537,7 @@ EXPORT_SYMBOL(vmcore_add_device_dump);
 static void vmcore_free_device_dumps(void)
 {
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	while (!list_empty(&vmcoredd_list)) {
 		struct vmcoredd_node *dump;
 
@@ -1548,7 +1547,7 @@ static void vmcore_free_device_dumps(void)
 		vfree(dump->buf);
 		vfree(dump);
 	}
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 }
 
-- 
2.47.1

