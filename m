Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA89399019
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689440; cv=none; b=ncWSgXOvKDE+z0qNqPRDpDgQEIoHIbuK173EJc4tCyZUd3skYrhIfVZIcBEBlHRK/B8Qdxjr1zzmnOjqMvVi7KIQ8859Om/DbI8TusHJqjf1uMp3rEjOIq30emvgiLE0XiXhWj3WZmzvgqzJv/13m2cDvxcgiwy+qyacSnTax6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689440; c=relaxed/simple;
	bh=pJyVKKoRMp8v4PnofjcMEJwk3zM1uIs2Ipko/ZCecJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Vozkj7OyRQYcl+64i6/s6jz1z24+OuMKVgLsoBk8BU8gB777wS5kmIoyA0HoqmM87O14Es/injN53U8YCRgKFAFuBSfepmO/ykxI7kFucc8w9Vvzu/+IoFHTBVi0sqydVFXtQfh/Y7DkSqGAPyS3pLqaMYRA9pvyfgzWnYziWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/cMEC/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/cMEC/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IETrtHkv4WyAsn+xKXnLATQqoj86uMIE60X1mP6bLOg=;
	b=E/cMEC/EaznxUSe+vb3VGfVKWXPdXrDdaHUjjSpOSWZ1lLQMwZWSSt44/Jl0mLmy1roKPc
	Iu4ZiQOtH4MQ5T4pMlm0UO0wooiKhpA4CGwUisVhqla7pXuTHLCfDvrcb8YUtnZMmD7dk0
	/EnW5QLy6IYslNqcZM3LCUmWZeOkb3E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-YBll3bPuPEaqEWTRPSlsqQ-1; Mon, 20 Apr 2026 08:50:37 -0400
X-MC-Unique: YBll3bPuPEaqEWTRPSlsqQ-1
X-Mimecast-MFC-AGG-ID: YBll3bPuPEaqEWTRPSlsqQ_1776689436
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a215f17so535963f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689436; x=1777294236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IETrtHkv4WyAsn+xKXnLATQqoj86uMIE60X1mP6bLOg=;
        b=tCww3oyq47VOPIeZwituU7fNpyTkDw0i/TWp+QtFpcT9sPCHOgox3rrpD/S5st9CTM
         VSlJn2/5p6vPFrMSXX3UVAV/tXjmz/LbZ0Y+QZ0llwIPGXbuqLh4kpsNvNl7qhyG2jnh
         m+1KmaERuJ7HIb5eTzImPPqbN2qlyNfWzm7xYpOtivQlSv/dxn2cPF4I7OSGI/ZqfdPc
         NyKmsDO4o6mdwjOm5IBB/gcyxIJNldtCVJRfzXxNxCb2YPFJ30qmTiBbo+IhpWnkO9n9
         HjncmXMN7mnuuIk8Fu9OEWh7wbGHmV8ut2MqN0CIxodldccRP1Kfh0Sm6Gte4VA7l++8
         XDFw==
X-Forwarded-Encrypted: i=1; AFNElJ8c6fboXQZeeWdAt3AeI8lL2kUEEyYlkfkPGO7gCcHx8z4G29TJ15YoUTiOu9GnAAvxt6/v9jAO7xKkxQPqgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJTILR+KramF+k2N11SWograEJ/IPqBuH6d9udKaagswr0okyq
	Whge+/mY+fCqKJ79buFUAJxYqXBxytWoWH1BVTP7X18nudemnJx5bgOC1I/D0a/R83MzMTZbLhT
	PZc4SLeEXkRjzFsXVvE517ZfUbnQ9A1sBdOp5KS/9+UiUmbgGg21fVTmbKM8SkISbDmbQ
X-Gm-Gg: AeBDieuZPH+0Y0IL64581aNZASWKuhE5QQ+IZKZxVty3UnDE+pTHuI/P+o011jKSq3Z
	jggPZxtmr+zOLnc26L/dBvV4mwsM24lnz3P13SpbQlW9A0vozzQN/mViJZ8DvDc59EMZU41etgu
	7VoQbLY03dcuvODMpNQROf+wzDxCGowTsoyboNbI4lNtGtI1APMqwyN6pIGESqh8DC5miErb8jS
	P0CBss01x4Q2mm8+IUmBp5pQEdkybKwPT/GEM0rqwzXIQNeNK27yPLksK7IPF51CrbqUkCexb4G
	yIdf7ilnSPE8FPqytxS+nS/uEAfp8g8jdZsOZfTAFergqyuYXAxtz1ZdsYw+rT0jLu8BZzUYu45
	rwh30E0gqSojmzFBv+aD2CF7iQ7WZGKv+4p2PaO1YyakOEZjvab5t4A==
X-Received: by 2002:a05:6000:2308:b0:43d:76d8:5794 with SMTP id ffacd0b85a97d-43fe3e14f8dmr22172811f8f.36.1776689435764;
        Mon, 20 Apr 2026 05:50:35 -0700 (PDT)
X-Received: by 2002:a05:6000:2308:b0:43d:76d8:5794 with SMTP id ffacd0b85a97d-43fe3e14f8dmr22172730f8f.36.1776689435207;
        Mon, 20 Apr 2026 05:50:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm32291619f8f.37.2026.04.20.05.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:34 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v2 05/18] mm: page_alloc: preserve PG_zeroed in
 try_to_claim_block
Message-ID: <0be843ccdd029d61887f199123cce216dcbbdead.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oHnjcmSC_qbKVnJp3Jc3J9kLL5AO8Ulny6RNth3McIk_1776689436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

try_to_claim_block() calls expand() with false for both reported
and zeroed, losing the zeroed state for claimed pageblocks.

Capture reported and zeroed state before del_page_from_free_list()
clears PageReported, and pass them to expand() for sub-page
propagation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6adc894748c8..b0971a1eaa73 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2345,11 +2345,13 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		unsigned int nr_added;
+		bool was_reported = page_reported(page);
+		bool was_zeroed = PageZeroed(page);
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type,
-				  false, false);
+				  was_reported, was_zeroed);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

