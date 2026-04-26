Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C130CDA2
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240118; cv=none; b=YfUmNWfZLyv+yB8/IvTUQmoS+WpvAxqw+C5CJ0ImrOAhQBfA4cM1fovf10sskdkTYot7UkqH/aFrLETjBXednNMkKbO7z9UvliuMUckGno5F7U/TOqK09/krfbU2k1Ksa8etoxtFziGx/DBqkK2Fd/n5ozdL0xYj+xHn6psGDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240118; c=relaxed/simple;
	bh=d/DtwOXUxWzwJlhiqF5ZSiNoDuNbGpQpz89YwsrRjLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aFrXqI/5COY3F0y6MB/CEE1K+qsSejVYOr9Bh9QyP8gKB5PbQ7qaK7xx8dImqVBU1l54iqVT2zIUk8txvbxrl7tdGPafyfbaL6c5GmHWk2nIPleFea9m9hCV4XmV3t4ARQE5WRnOujQTEFTKH8K9IQ2ZVRosvXw26VkCO5RYU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8gpPyHY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8gpPyHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqSjL1olH8+AffRmYI03HiN9kMkx6LQqrsSuHYVoaLI=;
	b=Y8gpPyHYKWJryL5g33r8xHukaPrLKrH6+mDewz0w/G681VRi/UUXWLJbk129Cz1OYHRyz8
	MV27l1HwXXIS9kTJvmrbrEgOitTN3ywa6Ralbq/Q7IBzw+FLcGh/kq+jMtA5V3fQ99rwav
	4r6JA6yHq5hHyl+87ZSWUjXu3B+AqSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-7CLJpPK9M4KxdXR8SyreQA-1; Sun, 26 Apr 2026 17:48:35 -0400
X-MC-Unique: 7CLJpPK9M4KxdXR8SyreQA-1
X-Mimecast-MFC-AGG-ID: 7CLJpPK9M4KxdXR8SyreQA_1777240114
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a55de6fb0so53870445e9.3
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240114; x=1777844914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqSjL1olH8+AffRmYI03HiN9kMkx6LQqrsSuHYVoaLI=;
        b=SqzNZzvNp2vdBqujp28AzaAzktXLips3t18Ef0N/CFXqdBORhcfAu/41Kni8Op1G9j
         D7E8kyPVr0oL3TmAVaBFa0kcBTDCJwDnEdvyhyYtmNYiUws0qgk1vWfxXR7I/7DdCBBH
         YOas/F+AuittzZOMNqEY5vL2LZkFP4aI2RhuW/IMC3rGKYbz1LQl23zdEpoziW0AsfQA
         UXbk7aNGUlmWCsbvzazNaKkVbpM1+26q8HkFbz9dd5nCYpnlNg4i/HOMsNWPLpHNQwLl
         ddrAApn4THKiWnYdF/TP9j9rbumwsN6QpT7jnnFyMQZr90Q9ZFctjwt318Pz0exqrKaT
         J66w==
X-Forwarded-Encrypted: i=1; AFNElJ/xvNW9rEzjnypOVrxcNBSnf4Gg3w1DwyIV6ASyDLEaAUYxL2Xm1qQQHg45BBcjhRpZUeV6Md8nACFbWt9SIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHvd+CMvQErnm097E4YVExO5Ovc/2wcjWMFN1EDINhi9VlrxUk
	6hmmurv4tea920ak6Fw8l5gINuFSIKwkX1OIMrI3cba9T5ieSckmaESvZJrhJ+nVJ6kgAj8TY9C
	pUyUiCOxPnSprs1vuNyKNCISl3F+3RAFnaXaYG3IDoZFnGcor9Yrj/o++4n+CfthA6qB2
X-Gm-Gg: AeBDievBvc356aXO3ygErfyXEh+hxo2+/vgjzPh+k+UDkJQVa+Np5cis9YT9W5kCUNv
	r3RhebZMg7AaB0emcSEdRRwTK2ED+GVhnhlObYgPXtbjNu32fbJvdZ7b87kv8tCWC0zPjsABNTo
	flkwtd5x0c1Q/23I5tpmSL5mHj6kwuVMffsh8yHeAZuMuucnil1srs6Z9R+7e9wKOCE7I0j3gAi
	5ODq/ZvWzM8HY7dqVo57BUl7FDy5ulPLKwwNdqHj27L7ToK1F1wy9FfP0D8Eb2807UyymYgK39k
	Zm17Pf9BntVAaHGN+xswfxEnA82/iqk1jncNMMMu6dMjbMbJVyGW/CwVypKpfySLmnZ5hI2S4wr
	DthyT5w5w9uCNTr9SG4UQicXGbVf8NTlN+1HKz/QHzStUDi9IfKyiOTj9
X-Received: by 2002:a05:600c:620d:b0:489:1d23:4524 with SMTP id 5b1f17b1804b1-4891d23468bmr440690715e9.5.1777240113576;
        Sun, 26 Apr 2026 14:48:33 -0700 (PDT)
X-Received: by 2002:a05:600c:620d:b0:489:1d23:4524 with SMTP id 5b1f17b1804b1-4891d23468bmr440690285e9.5.1777240113138;
        Sun, 26 Apr 2026 14:48:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8188sm806361295e9.2.2026.04.26.14.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:32 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v4 19/22] mm: page_reporting: add flush parameter with
 page budget
Message-ID: <d4ae5823206893e4c3d9e980d93064c9d52a1a28.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WlAiE-wTibI28OZY6tyNSfm4nt1iux5P-QjUTb4ckok_1777240114
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a write-only module parameter 'flush' that triggers immediate
page reporting.  The value specifies approximately how many pages
(at page_reporting_order) to report.  The flush loops through
reporting cycles, each processing up to PAGE_REPORTING_CAPACITY
pages, until the budget is exhausted, all pages are reported, or
a signal is pending.

This is helpful when there is a lot of memory freed quickly,
and a single cycle may not process all free pages due to
internal budget limits.

  echo 512 > /sys/module/page_reporting/parameters/flush

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_reporting.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 61f7f08d02d4..05bdcf89f3e3 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -358,6 +358,48 @@ static void page_reporting_process(struct work_struct *work)
 static DEFINE_MUTEX(page_reporting_mutex);
 DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
 
+static int page_reporting_flush_set(const char *val,
+				    const struct kernel_param *kp)
+{
+	struct page_reporting_dev_info *prdev;
+	unsigned int budget;
+	int err;
+
+	err = kstrtouint(val, 0, &budget);
+	if (err)
+		return err;
+	if (!budget)
+		return 0;
+
+	mutex_lock(&page_reporting_mutex);
+	prdev = rcu_dereference_protected(pr_dev_info,
+				lockdep_is_held(&page_reporting_mutex));
+	if (prdev) {
+		unsigned int reported;
+
+		for (reported = 0; reported < budget;
+		     reported += PAGE_REPORTING_CAPACITY) {
+			flush_delayed_work(&prdev->work);
+			__page_reporting_request(prdev);
+			flush_delayed_work(&prdev->work);
+			if (atomic_read(&prdev->state) == PAGE_REPORTING_IDLE)
+				break;
+			if (signal_pending(current))
+				break;
+		}
+	}
+	mutex_unlock(&page_reporting_mutex);
+	return 0;
+}
+
+static const struct kernel_param_ops flush_ops = {
+	.set = page_reporting_flush_set,
+	.get = param_get_uint,
+};
+static unsigned int page_reporting_flush;
+module_param_cb(flush, &flush_ops, &page_reporting_flush, 0200);
+MODULE_PARM_DESC(flush, "Report up to N pages at page_reporting_order");
+
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
 	int err = 0;
-- 
MST

