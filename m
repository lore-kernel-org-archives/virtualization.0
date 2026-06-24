Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D64265CDD
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337918; cv=pass; b=i4kLyFfjt19P/9Woyxe0cm/WLdK+XAmKTQzh3NxTtlPLoRJXOwWukp5MHURQdeceIvl303JLRI8VQXOtLSE0JhrwFtiM6U0KTVFJIx3LLJ2/JJrSuwEmhhMME4ElHQ24wZLuIGKl4VBiTNzeKCrM09LRwLpEqMaq+R3QG5HSQw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337918; c=relaxed/simple;
	bh=WaN4T3fbz8Ix268G4AelzWRoHuaajgHJySjLnaW2MDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BXXB4msgYlbhTBuSdiCDfykIkHCS2zJTq/W+snQE/SDf/Iwa8LqSbrDeJpWqReo5xW0qi5gRUfvZ8Lg42Kg+RZ7eeq2WvWQbTB75JN098pzZ/ye/ok6Lr3HDkfUqd1w8I1KtvkHUXC3nag8fMaVFSsi7+95tjH/+cPWQgVo1ftA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTtA/ySJ; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTtA/ySJ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-805f5d1a6c3so16287707b3.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782337916; cv=none;
        d=google.com; s=arc-20260327;
        b=moVcqSliiRxuUDM6Q6mVvudqZ75Q93IwiTsvVFz2sWBmKoSZ0RKX70v3KlMe4iuDc4
         H4At0atlsMNcLFPeVtqw+WX93R/8357TF683f9SyYiOuDeWXPVLDayyw+ov+6djf4TNE
         9rLIqyOPAU+608rf4kAM8JmyDLAyvx+shDQkePM4ELxNA/EDzWRA+0heOVBduau3rbRc
         GRKGKpa9q8vVe1zEpguINtgNaMQgO2KR3uPSCO5gh/FCUw8cEZhddFSdIzmmxtB6MXHc
         H94yeyPBzEJ89wh2L3qr5H8rV/lT6gammj8I/Vm1Aelw9VkjQdzptrVFr4kXFksrKBsq
         LM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        fh=o5VyQj68C++8eOr+uLXCDpxnC+i3EoDe7rSogVWdphE=;
        b=jvlxdbkWKIgydNIL9+lyC28CvYH34O5s1SStIxl97zaE1dSFH+pN3PCA7hvckRtUDv
         B/liy48BFcgJC9IAxDp+5r4oFEO0J6/mZQsfzKGOeuJKr+jWuAfiTrgTF/1ClC1Dsuq0
         cbezNb9rrgg3oyffAYmSJVYto9zAHvM7yjTNfH4H7i7d8UlzHpfAhwTvbs7Km/JO6HFG
         CPUyt2ZunaXN5OX3Dm3Bf2vjS8zM7/ZTf+OaMZmj3X7iSGqQDesEWqohtfNvqJqyR5qR
         ZAfJm6NZ2LnKvtDWasCgRJDgj979EuHzlrHdQg6DA7zR0+8YF4g1sbLsP84pW38k7zGC
         /O6g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782337916; x=1782942716; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        b=fTtA/ySJYp4Ic28YQnD8/2AufSkq5q9FOLx5IJAECV5oQz/Vtr6drBAsl+cUHnT0Le
         xeRRofqjnDf6R2zCtH4/C4Z98vQ5D4CDJDgYMkaXENP062mA9w7pEaN6hlg2WHV7nWQG
         F0vuXgACln0+4Ei4UfgMK35JbOCFgnpXOPLixgGTEDUEeqSJvDe/EvNdPe18QTqCGcbz
         3lSMB+Gz6WYjQewX2ij8hOO/4aTTT0g4fz+IZncAra5Kqq/kTYvz6zHwmG4Vjj/9kVBE
         oRAps80ifHccXrNuQF5z+JyEibtiA9/dmDTJpZqJHMLjaCPhTVtaeYvudZ/WY2AwYJbh
         3/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782337916; x=1782942716;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        b=Lvrp9FL5CIUZLXHajgbCGPk+hyYqgaqf2GwK58RijfEjUBWkhTRm9nwQi9rlMWIgmj
         ptRJ48wulGWO0p0t3Fdl6UTD4iViUwqsVH/X6bfNu9rZ8eLzJzTK6TLosCq132vX3vvW
         krzOBCFeSvT7fVbT6T8i+Iw7XlOxiw47TvdGiH/FeTVRYAsNYzkb686l/1/A5lWef653
         fQCV00uze8Y0VGjcWxHJrUJezhBKcBy2NojSWWkIjPFsHbeLJpshIrQ9eORmexx8qXZq
         z698AeSuKrL5gSussGYNAMrEYHamoODayU/PK/WiQgzmn1GeDgnDfPkHtrmndUOTR4sb
         8okA==
X-Forwarded-Encrypted: i=1; AHgh+RojN3mJhkClG3kz5RwzaEzF8fPtI1TfyXRZKuiyUj1TJrHSWOLonDDBcVU5TJyQ730Xo8yE9FGU30CYU11JJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ81Yw4OFrmsjhiMploZ9LNDlX8QaWvxtgtmwQJ1EEtu0+8vmL
	/RfD+UkVypAPbQ9CthKbEYE7+qSQcoozMlZrEP6n+l9Fe6R+WKBePbeTsQj7O1Hv0R8t2tooTwn
	gRnQ5YYgCle++j/ff/9EQf8cjAJFt96o=
X-Gm-Gg: AfdE7cnvdhi+3aFEo9SE6V2893wmYnmatxjlJtVdrhXA6+GH/asjBKYxW3U6xHb1KwD
	oPj1H3P+Tevpd/4mJqU8tLmjH2u8l7ZLlnn/5DQichfLn2AUk3o378j40m6+V8Z/AJ6X5f/FrzW
	T5sbFgLUJDcnRGpQUJwMs1uIT6vg40ziNRrl542pyciQ8E+Xugg8JaMQauZvr7jS1DxweeNVbAU
	mSd6tfHnvFTqyDPeJKfUPaDTMyyGECY3jQMm1RahKE4LLmUVNZQ5u9GztJ8Ou7q21ke7gh9
X-Received: by 2002:a05:690c:a98:b0:806:8eaf:cf1e with SMTP id
 00721157ae682-80a698b8b07mr44057b3.25.1782337916257; Wed, 24 Jun 2026
 14:51:56 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:51:53 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:51:53 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:51:53 -0700
X-Gm-Features: AVVi8CdHz4x01_NrUP0s8m15X4RCCzs8WdYKYti90s1WpO20ye-Hi9vgV_npMcM
Message-ID: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
Subject: [PATCH v2] vhost/vdpa: reject overflowing PA map page counts on 32-bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Content-Type: text/plain; charset="UTF-8"

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. On 32-bit systems,
where unsigned long is narrower than u64, that addition can overflow and
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the unsigned long page-count calculation.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Clarify that the overflow is on 32-bit systems.
- Drop the unrelated memlock check change.

 drivers/vhost/vdpa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa..38b28ed3d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
 	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
 	int ret = 0;
@@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	if (perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;

-	npages = PFN_UP(size + (iova & ~PAGE_MASK));
+	page_offset = iova & ~PAGE_MASK;
+	if (size > ULONG_MAX - page_offset) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	npages = PFN_UP(size + page_offset);
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
-- 
2.54.0
