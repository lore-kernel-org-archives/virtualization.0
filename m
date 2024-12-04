Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9641F8AC0
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316913; cv=none; b=DW7gpSq4+CxeSF6P2dfUsWAMYU1eY0RAU/Oeak/KunEqTnlqQzhRZIkt0SjNaLpo78g5CUbxtMe0VU3h2AnkSeBIQ5F8msCi6jzTorsISRV5V68Lko4us4Y86hqv/DnV+G+UBFep4N4J4lZe2qkdV5bW3HmfkwKr4NfdMGpTjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316913; c=relaxed/simple;
	bh=8EJBn/hbfhsOHacsaBstPaeEQTFd5MZoCB7W0faV+24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LWUhPke14mGuGWPCbYvpHjQRq2yJiT4vWcKvdnhhmzn0Yu1Fu7YcJfagrwfW5DItsGIYjGVSbOf6WTP3oSMEYUB12S15RqIhl6zM93tfTZ9/nrnOOXgYoB0i+pkaXKsQ0nATjdyUSkvvmknCxuA9zvIxVntsu0kr+wjUTlX/5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZTG4jZ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZTG4jZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=;
	b=XZTG4jZ1PUFPzXxpxcrZeEHJ0zK9ykSbLB+Hl/rzplDFFSGo8LKx/1qCgqPgX2FDUQhsXG
	4aFZejYg02Sl6LtmU0CD3WS1klTLiZ/J942x9Y7m1I3fawrKrCl4BT2bpuGIGQRnNz5E98
	jPGauwonsfHTfjgMMg9bSp6MNa8iwQg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-iXafVKoYPZaZMGN3BmRvwA-1; Wed, 04 Dec 2024 07:55:09 -0500
X-MC-Unique: iXafVKoYPZaZMGN3BmRvwA-1
X-Mimecast-MFC-AGG-ID: iXafVKoYPZaZMGN3BmRvwA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349df2d87dso62398675e9.2
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 04:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316909; x=1733921709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=;
        b=jbeo7m0JKmM602ofPTGojfY0etafjWw4BeHlijpSlRpKQxpqJvb4eoeC4yqhKjhPMM
         F0VKy4G4CiCiHmLmXnC/oI36nExTHjVLs59cvQU5u0sInCX2Dv7654kGfkfD8kCaffgN
         lhGFyRYVwLi4Pf1X/64yCsQa8XDvWNRXEQz5HtlIK4fBaxl+U1kEeewjABENpdCAPIHD
         LeLbRZlbA8s/LKYBr3tzYpAvWW1H3o3pazP77YCQkApG4hi+mjhGsNy69S3gxFGPUQLN
         oRhNMgeC7rWheMzmvC13ml0N7K4GbAtqjAi9BQD5usFWVfAnOAXffwh87kl37K0YBxBe
         Ia1w==
X-Forwarded-Encrypted: i=1; AJvYcCUyCCYyEGmkw0V9DsJ7lm8x0rD49hs5Kd/H88v4bpiHwOsyvi3OZ4n/YACCaPKiwglP/WE+ZtN+pFqJQDv8+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzABam+q0VReSwbj1pTixm0mCT75pphTrCMfNnxa5TvsX3qHhV7
	wSZw+1TRsdr41lHdMWE9ht4Mu0D4u6F9FSZVplcFMMhxQC7u0plJFMh+0cIY155zVzgSFfivNP8
	ndhFHrnSdtNqtL6gWMlZvvX68Drzw/vNS4REk6BCVwYwfaJpfoIlrT5lcY89JvgZC
X-Gm-Gg: ASbGncu5OXUAt7qmM74YqhOPn+ey0dYigtFoD1ZlT1QLOJ/3mb/Mq2mdHS4Bo8E9Wrh
	DpG9MDs9UfTwIrHGFfjxxbYKNY7FCAUplyFT1ivQTxrntQqBPBax/37Ymb4boo8JyoxcPfZ6qvw
	ASx1Sayy3j07G+p8a2p0Pth//D5FJ9/wSJPANpvJagOsEUNf+Pt+V9cT3bq6XPP5CUvp8Ky7Akg
	NlGFYv+oJ5rY93oKpOZlnPGi8Qu2I+RfyeTOvPAH2uV8drYrN7BM4hSmU7g7iB3nkNGWZXxjz0p
	Ozc6pTFC4HWPSOwawosiF+yz8VDE2TEx8VI=
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr60274895e9.6.1733316908761;
        Wed, 04 Dec 2024 04:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKlYOU/tZlshqWyJGjVsl03zkEzffSPE/+D71b9Tfd5+g4TqcfXtmwO5t6x/22DC/lF4E/bA==
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr60274425e9.6.1733316908112;
        Wed, 04 Dec 2024 04:55:08 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385db7f86dasm16267209f8f.66.2024.12.04.04.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:06 -0800 (PST)
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
Subject: [PATCH v2 07/12] fs/proc/vmcore: factor out freeing a list of vmcore ranges
Date: Wed,  4 Dec 2024 13:54:38 +0100
Message-ID: <20241204125444.1734652-8-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fXlTjff0pM05yUBcRVthQTVK-r1X4o6_CaVSJG_m2Qs_1733316909
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           |  9 +--------
 include/linux/crash_dump.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9b72e255dd03..e7b3cde44890 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1592,14 +1592,7 @@ void vmcore_cleanup(void)
 		proc_vmcore = NULL;
 	}
 
-	/* clear the vmcore list. */
-	while (!list_empty(&vmcore_list)) {
-		struct vmcore_range *m;
-
-		m = list_first_entry(&vmcore_list, struct vmcore_range, list);
-		list_del(&m->list);
-		kfree(m);
-	}
+	vmcore_free_ranges(&vmcore_list);
 	free_elfcorebuf();
 
 	/* clear vmcore device dump list */
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 9717912ce4d1..5d61c7454fd6 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -135,6 +135,17 @@ static inline int vmcore_alloc_add_range(struct list_head *list,
 	return 0;
 }
 
+/* Free a list of vmcore ranges. */
+static inline void vmcore_free_ranges(struct list_head *list)
+{
+	struct vmcore_range *m, *tmp;
+
+	list_for_each_entry_safe(m, tmp, list, list) {
+		list_del(&m->list);
+		kfree(m);
+	}
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.47.1

