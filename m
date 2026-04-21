Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB640DFBB
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808925; cv=none; b=m8UKm0lUsB9HqzpnN2QELoPT++O8AY5AqbW77fpCGa/yvv235u8ssodxSXE7U9iC7QI2PTn7H4OQEwuI/BmUncfsEdTl6nGQ3y5jE3qlfxXCOF74QJFS0ur8UYkp71WibW3y5wgkqwnnJEy6KwHRMqrHNErS7ryz3s9s8QSLlBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808925; c=relaxed/simple;
	bh=DFAESwwsDTSQc7OD6QuzKMEO6K5LP9EvdbUmNXhsvmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RBlwbWh6akqDw1MYEmrAhZKn8y4zI6Pq0/GYSRm6ijGkn6NUfstYhrthAbQKFZzTAKAHH1HsVYxOuOKt+6S/STFY8a5iJxHbv+AAJb7UAOFIkikOtPJK7wGAjwmA/hPCQ0O0zSagUHSOGon6xzMetgE6cmvEp4dqG0PWSQyEyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EevQQEaO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EevQQEaO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cryXnIzewbC4JFE37j7BqLz76I8OG7HbHQFiiqeqBgM=;
	b=EevQQEaOTw7vBxM3DP8HGYm/WcZkhWOJ4QUdZ2t2+N50A8Rq6RhCW503wm4ZRT09L/KdqT
	hx0qgrw20C5VdTEcBYljVS+Nz1Fi3lPIvzRwMyP9FXMooGaJZ9VyCKrvA2+WvWblLbEhWf
	mDJWQfE3ducIOk9Y+2zLOftU9CifMxk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-Cfe6sVmcPmet-TST5T4zEA-1; Tue, 21 Apr 2026 18:02:01 -0400
X-MC-Unique: Cfe6sVmcPmet-TST5T4zEA-1
X-Mimecast-MFC-AGG-ID: Cfe6sVmcPmet-TST5T4zEA_1776808920
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5775d647so9446135e9.2
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808920; x=1777413720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cryXnIzewbC4JFE37j7BqLz76I8OG7HbHQFiiqeqBgM=;
        b=s+DMUBNG8FucZ8X+DpzYMfAL7uvdD0W+18mNmpSUjzOkPjhhwdljlegS20dBR7GLgs
         EwDgCGnPOB2ApINzUa+0OfIpJZx6ksk15szY1/jw+6kNo/0TxIq18r+O4yjyQPH8TUOq
         E85HjQjpqutpZy9RauuC8KQS81Jbf/66RcE87ObD+KLmHxSaBeuwJE/RK5L+TXswoneL
         OA6EP25Ke23RpKHW8tcKIdMQf6gOJrLg47BIEA5mKWcWXoaVZzszmP9R/uVf2n3AkmA9
         lSgI/5zTCPHbqlYahBrchdf9GOl/ygtuEML9XGLMIAaXU93lKpaM56n+6rEofR5rnU/p
         6eaw==
X-Forwarded-Encrypted: i=1; AFNElJ9rtQaG+0buHMCIdwmQuIcMLqYp1Y8I40I85PN/x3gWq1LFk8RMSMArlw1EovzAwP25gCRTxj5CEaRnURI0eQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4BGudzOzKJ0yoGhXhjtjCmJMZ426WY3hQAY/qrva0Qm4ykccO
	qEL1SdMtJSl8uE/9XWGmf5W8QHk1ySuw5XvbnNYuQUVimylPLfZGltEIJIM/0Y1B7dEgkUPxatk
	mRmS7Y9sljQH2+ObshSz8C+QipIzaP7Y8ngubcYiI8iVvd4dRJ3gpzCILtsEnnvo1EDWy
X-Gm-Gg: AeBDiesMOPHvQSHeU3qaQsealfglSY/ZDhzPQ1fXehZO2vI99XsYKP4n4MoJ2P2Q8Z+
	zla3DxsWv3MlJVKzhJm3PoFaDIhYvjn8mUXEl/rMFlotN7onfcZsTeDc36ih5mvbG7lWRNdFKQK
	ke7c3UTEzx657rS7VmqO/aA1xmMdTZIXbl0HHvygB8YyYEy3XI/i8YsbHbJh92EyZ2aVlD9BN8q
	COL77BpuLWFaXgr3xmvI8BzBfw4fpsu8PRNGeA4JtNm0mODLYsapTioRb2KhsjeC8U3DlPGXCnl
	jOAM6lF151uJsgXuU/nF3/Yh/gZlF7uLZQ+jPyEHGzoohlRgl07fZuXiW1nR2fwe4JWXFxhFKP0
	NOWrnv73Zl+W480p5AeHyv29WuDjIE6XSI91VQ4UeIyi94BIm1M654g==
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-488fb782d91mr292618775e9.21.1776808919856;
        Tue, 21 Apr 2026 15:01:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-488fb782d91mr292618445e9.21.1776808919403;
        Tue, 21 Apr 2026 15:01:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc558f2sm265846935e9.1.2026.04.21.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:58 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:56 -0400
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
Subject: [PATCH RFC v3 14/19] mm: page_reporting: add flush parameter with
 page budget
Message-ID: <abd751c3d59d5c99c1f318d5c8e9027bdb26f024.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RUpwwbFLrOY0R2fFTMbVIIAElLBdr3t-GfeJj8WtM2E_1776808920
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
index 6177d2413743..c09a8ac754dc 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -354,6 +354,48 @@ static void page_reporting_process(struct work_struct *work)
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

