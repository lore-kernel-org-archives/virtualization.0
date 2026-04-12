Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44C337BBD
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034262; cv=none; b=rm2IVlWfX/DcKpKOHJvowSNoYmYsO7pFrZ22c2jfjQGcxbPD8u18m4WgVatqWYIPMgZW9fBANBxNOH2sf7z10c8qY75mSvER0ItuvCoPVWTNqKON3aZOZEceGzD4KXTGGgZS9gbOjJV+YDW1rrpyLCvPZgSsOFRnZ+inJoqG6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034262; c=relaxed/simple;
	bh=6gjSNaFIDSNyW8+yvCTZyht2lyKWhv9QbxmNHAkjjAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P5p/Vl/OIX4hxDRxLG0C1k7LH/yPVujEZ1DCfdOVdEoZLl6fKVQ0PzPkVevJBEy+HfFVMWtCCtxbC8HSTJNgULUyWQd86xMt6iRkcOMp9jurP9C7yP41GfQhSVSjfHFOlr40ofCsu/PChsObhdROAe/Gz1demYhRtNicia6r21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HvMhdOti; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvMhdOti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZObZy/vetFZ/0CGX/0sKWeCj7TXTkOR8AcV2oS2lySk=;
	b=HvMhdOtibyxBwhAWHaNAFk3A6aBGnH/GzAku+k13qfIPXWWrFxxd6xPEQXzlOcmTQPyyQb
	BV8TRHzxYkSwWzdbf/hCNVXOJxfCWPlx2t0f54LexKCFugm9clGyG1aWKAvD676rfWjA66
	NOYkxl2XlWx1zlBZ4kecp6ADBn5E9/o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-VRXn1ImgOyqza0w7jvfbBA-1; Sun, 12 Apr 2026 18:50:59 -0400
X-MC-Unique: VRXn1ImgOyqza0w7jvfbBA-1
X-Mimecast-MFC-AGG-ID: VRXn1ImgOyqza0w7jvfbBA_1776034258
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so219828f8f.2
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034258; x=1776639058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZObZy/vetFZ/0CGX/0sKWeCj7TXTkOR8AcV2oS2lySk=;
        b=DzS81aThzBsPe3YakpNB/hcsj/2CMUhycq3UgFgIDES8GhuKXKAZg+JWVeLOb2nzzH
         TG/aRPLgczsnvdnnFPzM+YAqpWGh1284XltRLlNRh9TZ/roiE/vuar+o6jLdOTXOcbP/
         WCaEZ3Ci2u6g5p0ZtPwuSdMioHpAOErasVoWfagBIeXB+LHhsG3/L+5YNar5w2ey12bz
         sI/nLqBIYiV7E/ff4B9BO1c/UNO+XmcmNlyv8Lrk4ZPlPUivLnHpO5op3FmQSFhQTHMn
         supvbt4fluINdWST5iaThk42o8lWvyhmh4OqAsCa+U4nUfJqTIWAolbNYc5aqM9WuTam
         pQAw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ist34FSSeDObgM1lHfW6s0HrT1Ivsp5nYn6OaElEYJYlFoEsu0+xfXR815DXRmVEeepIW4H5rJIXmlmbOCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHTQgCrSmGaX+lWm+1b6ArTjztMnwUwUDnFb+ZNpTjJGZYeKTc
	v4nHwyP5bCPUkaxtfio3j+NE+J0dJ8c+U7SJzepq835KTF+AwXidUFumbsyGSoQ2xTwaITRlp6h
	LmiWCBBDnIOii3wD5EeOD0Csk0U0K30WEpX4Z5VsMONiP+2Exl/yptD24KrD0ytQjf13v
X-Gm-Gg: AeBDietPY2r4nHDzfkX+4+scDh4FNKwxiE8eFV7ibBZ6plxCNgMYuDGXtjiaiuogoFv
	5br8CzVdZ4sA7fbANn2/GwGjhJjHUysH7d++yQOpIv+8sssRhdD4Uby4IPviKCpKYPXmnm7WaCF
	ptdQ9LNmumC8sMrdBVNmRgEaQAKuXvnZE0mTBpG2S4JdgiZ134K79w4aVOrpxmGI6QicNtNy7uy
	1Wmy8gXYaG87N2mWatYvuDgawbbSoj6hXhm8Ac5hw/R39DvG0dlQG7wzT671ZPiNWP5uBTXo9qO
	21FG/0Q2MJIV5tPXC1ftUE7hbbdwfnEzVk/Eq9QZb4xAeArNbSkBFm3qPu6UJ+ro4MXOEGOBbKz
	aY2dGdv+BspOK5+bEEo+fn7eq27SGXBzLWhNF275PkfM=
X-Received: by 2002:a05:6000:250f:b0:43d:1c7a:8b5b with SMTP id ffacd0b85a97d-43d642d1d00mr16517168f8f.40.1776034258050;
        Sun, 12 Apr 2026 15:50:58 -0700 (PDT)
X-Received: by 2002:a05:6000:250f:b0:43d:1c7a:8b5b with SMTP id ffacd0b85a97d-43d642d1d00mr16517133f8f.40.1776034257540;
        Sun, 12 Apr 2026 15:50:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7400708dsm9145343f8f.25.2026.04.12.15.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:50:56 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:50:54 -0400
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
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC 5/9] mm: skip zeroing in alloc_anon_folio for pre-zeroed
 pages
Message-ID: <56ae30d7f080b089e4fdc93c4d6e2353a9e0123a.1776033771.git.mst@redhat.com>
References: <cover.1776033471.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776033471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wZjdu3k0OHg83OQdQeKNzcV-vDKxVtXsO2SZivcwEqY_1776034258
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use __GFP_PREZEROED and folio_test_clear_prezeroed() to skip
folio_zero_user() in the mTHP anonymous page allocation path
when the page is already zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 07778814b4a8..2f61321a81fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5176,7 +5176,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		goto fallback;
 
 	/* Try allocating the highest of the remaining orders. */
-	gfp = vma_thp_gfp_mask(vma);
+	gfp = vma_thp_gfp_mask(vma) | __GFP_PREZEROED;
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
 		folio = vma_alloc_folio(gfp, order, vma, addr);
@@ -5194,7 +5194,8 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 			 * that the page corresponding to the faulting address
 			 * will be hot in the cache after zeroing.
 			 */
-			if (user_alloc_needs_zeroing())
+			if (user_alloc_needs_zeroing() &&
+			    !folio_test_clear_prezeroed(folio))
 				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
-- 
MST

