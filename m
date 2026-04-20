Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01243A542D
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689480; cv=none; b=Du0bMaciupFnL1wKzhiVGxPxC+7GYkkVZkDmBIF9usmGWh0HQMQstfd6lWBJSAEdQ6EX1xmMSI9Hu7bb5Mi6/DN5eIOeh7jgA7Bv5K9/liPObIjQkp9QgY7qKRIfVI5F0nXbywDQVws/qmqJGZOmrztF0QZeOFhwNveO+SRBtGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689480; c=relaxed/simple;
	bh=eX3Z6XPUFBMrbZVyjGzejWpH6ibjpiwEgtfLEO0L8/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KSwcVGYu03bNsJjKFF+fLaaToVfYE4EiZwzeFCcqtv2oVWntRtVtySlpUKqm5mA95EYoJFJxt3L9CehY7vrVOf5bdP6iyD7BHnGKrtqG9gxsUeFl8CqNHmPjvEaXHrPnrMBiVAu8ACQYrcDZdypz9bL7gJYDePJQgW9U/AH2Bls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2bcXYhB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2bcXYhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/g8ZGQWZ8XlzWBJ+7NKr3kj7gz6pSemT6E24/mXHPA=;
	b=U2bcXYhBP2AM1isI/bfd/BqEz2lZWW6MFlNlahUPwZME8KA/9OFD89WuQcsL7pZuTfJbJo
	jwPO8WFhKsBp+6dGlz/bW/icjSI4fOyRS+L3+oDZXx/dVhRcQ/b1XJKlpVpLy1zS8G7fXO
	jlX8z5Od44c3QZjDbQNHlR/D9ci9vvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-cOhbdb39PEmOwa81C5V6hA-1; Mon, 20 Apr 2026 08:51:14 -0400
X-MC-Unique: cOhbdb39PEmOwa81C5V6hA-1
X-Mimecast-MFC-AGG-ID: cOhbdb39PEmOwa81C5V6hA_1776689473
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c768a9a9so24872485e9.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689473; x=1777294273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/g8ZGQWZ8XlzWBJ+7NKr3kj7gz6pSemT6E24/mXHPA=;
        b=A3G5nxxfrcekarG4391or3+RNs48LY2JWl29UZ1AtFggOW6H7VMxjqF6VTyQ9m/T2B
         J+acowk8SUuItEK9pCq6SDn1XRUb5EtGDacH86kp6ra7fgbOE9CQYeTKrQxKZTxUSyzB
         2pmG4bRQOOyCsipZzllTYGw+ZUOIeIVS28mCMz0+YFEhvFwQXLeQI36W31DRimHWyhGN
         qMHha9WPdvmpOD6oCyNwZIjUcIu1g8TBKIiSVC+BFZQmSPIDGbHRVGLA+kD3xtvvfsyt
         YL4VhuY2wOIhiaHS4o//SKXGTrjBZ0I3iW5W6fwFmxfn/PcItQNdVngKQdIfPvoF1sw8
         ucaA==
X-Forwarded-Encrypted: i=1; AFNElJ/I/1qBybKLFSzPBHlpR8nvq0AMXyoTDevm3gMcOAYlAmEi9gFFDCw/ditC7bu1OMGRinig9ZvH0XknaSxMYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfxXHlt5B8C0dt6C2WkHOJ79MLZ/Oz4quu1qBgbD4Kr9pzjuZI
	Tk12X0zcCX330l3S7mytbEwRRV+tT9Ren2oDMdKJ427TfMbkguU2tXl3qSFaB89D2ft1ZjLXoQG
	yOPzgGXVfRLX234qqkCB3o0K9VBceCVZp8rcIwoRLxNU2lE+EiuCUgap6nlMP3oiDzVgT
X-Gm-Gg: AeBDies8xSRtxG2iLJuEXD8ZOEd5kow1LtbraJatAz+zJRLh64iHhU0XW91ctzQThrW
	Mza9WniNW4dCbkRKi9XqyAyT+0KP+YWFt6ecEIgb0707EsCSFUFmwg6xz08bLeyA+wjdWxeWxWS
	wOvkZ/fADEMppGTdwsbTwlIq2auuxrUTxv6CiAjWnUA1vjemBkwFPuK1d4PD7XV1Vs9ybUh28qt
	tIRePFClSWuSmrmgm6JfpBJnAWZe7tCtWtJxhapk2IoszMwhcFTf+o89GFFuL5rbp2Gfc/YZGtN
	X6Tw4OyI/wlni3G0PDECkBxktb5ciyPEUidnVTD2zLsBTE28BCiBgw1+xLxuKVBpR6j+912ENmw
	tBQYMlBhsCEIBxR+V+XudEkPbTMVOq43uY7YHWKwE4igi0OUCd3Eshw==
X-Received: by 2002:a05:600c:4ecf:b0:488:caed:5cc7 with SMTP id 5b1f17b1804b1-488fb76fddcmr200447945e9.15.1776689473383;
        Mon, 20 Apr 2026 05:51:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecf:b0:488:caed:5cc7 with SMTP id 5b1f17b1804b1-488fb76fddcmr200447555e9.15.1776689472840;
        Mon, 20 Apr 2026 05:51:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c320084sm125770965e9.2.2026.04.20.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:51:12 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:51:10 -0400
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
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v2 18/18] virtio_balloon: mark deflated pages as
 pre-zeroed
Message-ID: <1b1f7c79ef36716f7819c8e2a65a3d4a1fde3b46.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DmsowV8Fs8kqdIzdGroiRdH58Hi7CQbDOYrwZkjFQVc_1776689473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Mark deflated pages as pre-zeroed when host_zeroes_pages is set.
Use put_page_hint() with PGHINT_ZEROED during deflation so the
freed pages carry PG_zeroed in the buddy allocator, allowing the
next allocation to skip redundant zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 drivers/virtio/virtio_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 2e524bf6f934..9b35203f579d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -299,7 +299,10 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 
 	list_for_each_entry_safe(page, next, pages, lru) {
 		list_del(&page->lru);
-		put_page(page); /* balloon reference */
+		if (host_zeroes_pages)
+			put_page_hint(page, PGHINT_ZEROED);
+		else
+			put_page(page);
 	}
 }
 
-- 
MST

