Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314401A5B8C
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338183; cv=pass; b=slqgVwI/i1d+yAYLDyPPNPajti9j77LRIFtRmMST6dbXIQeVvmR7rKecPaqRwzr2Y9lx1tF2EkFM5YZLV+/3WIbzBHSWFxAJzgnOIQ1usIJe81w1yxZsDk4/X50EZgMznN+T72wGZlqvdED8xAu40MKklG9Pk6Ci5J0chqbjt4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338183; c=relaxed/simple;
	bh=O1T7BsM1mJR790dEAc6emGIwnJEEqVArxUUj+UuSsVU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gpQolA2d10Yi+dEe9LX2HlQs7lR2hxMdg+YAZy7rd20z0zt50QbK9D8Lve+dDNzBnkj+QTGgxEkd+rWQdaJcpqMkDSEQ4o3y8rQSo74NHb45Zfju9dHARzbIP8JYzydX7QOAU57bHdAc1HmRD4P6u4dqNhXSCEMXVHPjZs+emuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHst/DPS; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHst/DPS"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80260a90522so22294917b3.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782338181; cv=none;
        d=google.com; s=arc-20260327;
        b=kWWu9fhJp+PY8TVNj1zenoSk3wopTGu1iV4ZEPzZY1rCvXQbM/XlyBGvr/0gu6ZfFG
         0ar0/WIWkoGpLoYgxMoAFcegQVZC2O8Nr5BVvOCenRfBLgOTU5S3vE9apI9todPOaVxh
         kkOBMAh0RtxBEQVtz32nrkd6ARFFX0Bkemil2Pg3e6hi1HgQ8/pet57LU0jp/qIpgpRK
         u0xY3lcPg5H0sGxvqqb8aO9R2+S1RK6LDE3CS6hhv+U6RSl2b9KklE3xzsPc2Oj+Vwhw
         8m9AbMu3R6QWvFMz7sOE9PP+o9T/Nn5r9a5R1Xa47mh7PcNnd8KECBJ7LFNv7zlZgfI3
         8WeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        fh=DARrm+/7omP9jXhsFZNZ8Pvy/0hasyKdHDoId9PGiNE=;
        b=nM8iK9Oy/A+lz9xumtyT4bJg1Ikr1D8p6/2asMhSkoOQureurDnDs1BLJAuSkCEa65
         dS7RB3reXL7dJk4n0H9lu2Rdl7HtG5gXwbnK1Lxmfepjp441RKyGTf5S73ANVD4/Mr39
         GUz1wQQSrDgABV0LtyRybBGAtgiL2mbNPAgg8hOihFVKHsgGaQVKrKAdZf77bzGLzuvp
         jpJxYICCsIGlbCKtap8Q6Qj6wCJwuhG+0cLO7uEGwGM62hAaDvqeVjY0t1GbWd11iWbp
         PVu79jeDd4nbMsnGiuQEkPG1Zv8ER/xa5uO0GVIy4D2urKy6pMJ0cqi6qAc4prbHLZLm
         EgAA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338181; x=1782942981; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        b=HHst/DPSqUDtDI+MIF0Cx4ChkR9DzytA92yUODjboNWZPoDTuV/VPknFmHpEvdY/Ct
         tbVF9nq8I23OhNnpjicwppRXFHpRJOtDeu5v5VXBt1Zb2fJQkfPN1V12g9w8E2VivupD
         N3BrPdwXfFy4L4Sjy3EmzQVNkytkQ/r2EF6Y5YvraV/TLwq98gAbmh/z3NvQykPnyev6
         uNZAQU6KCeLI/BQymxZO/FV6vF1Pvw5c4P+sNQ9zZcjhhw4b5fR9vQW9GsS8YyKN+Lpc
         nfSSVmm3a5PWJuoR/ZgDbjNXXO3jMT8OtJzKfMtGyiOTcZglJY/TXaDaYH37T6o+O7P/
         iZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338181; x=1782942981;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        b=pAYNgAegC3uRB3KZXK3SZk2AEuiNEB6J0JHWnNT0yXgnSfRTqpZPB9CT5K2yG79eUl
         LDxY39UqyB6726L6zkKVo0QKrlcOE47zNnKxXwbLJkT7c1aVZ/4e1yTXmuj7QnFFl3Cd
         hIKzcAmIArX0K+V0d0uquxV3ELBstO1YKTAAPcHE2e8bx0uO5uR81/l1NIRDdCiummbB
         OsWzy4M0mmpL/A67j7TeDFCScAq3haxdyP4FoZitOambiBur5KJnYebxlYSEqQEqpsXD
         GZMrV4cpBdQN7Ew3rReJI7V7copD6WAi9hgGZ7XmQPKWCezwgEvLN1gu3Sb42dZN/BzO
         3kIA==
X-Forwarded-Encrypted: i=1; AHgh+RoOT6c980NHQCt90NFqyoLg3IovjX9Stg1LZMXQtE89amOFCCWXnSamtpZ/RTTYNS5ad+R6qJ0CPJdy9RwZKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaBFOA65mzlWfAwKsjah1bD27SfoObwsCfxqKFtdQACXCGH9yP
	4PNy9t4F7nghvVtCd4Zi/hpiEAd3/LbMcU5XNiGGGqytkJl1s56dIUlGfHTAGj1zSwfcOXQM9ce
	7kKaRODIzsfyhLLY12XtOF9WdgAFPGFk=
X-Gm-Gg: AfdE7cmfUlkRSQF21mjesBrKMKDCszRG0P4peRZZhM1yRwTa7hiWRwAKJ46MDiEj6DE
	XJXJ7v+AFpWSvg68TzlULLpr/HsLGTrs6FQlNVGnrR0VYJrd7b8JZvcvglJ3EVHcHejsDj9Q+Ok
	7jPRKjunxP0cJC/1AzdnIn+nW886ukgG7A9oXmEGLGhNNgJHcDJi1LtoaRvJwm7k0L9pi5jZvDG
	MAlgCYZPL51d6Wxwu/lxPJuScATvm1+qpbSJEDe/ygAwB2xAxyeo9fdrGuyugziHj6nGSdI
X-Received: by 2002:a05:690c:e17:b0:7fe:27a7:1c26 with SMTP id
 00721157ae682-80a678089ecmr497127b3.6.1782338181128; Wed, 24 Jun 2026
 14:56:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:56:20 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:56:20 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:56:20 -0700
X-Gm-Features: AVVi8CciZ2XEwtuWFeWZQavetqbmxlWkUIUYW-f6jq5xGyaQanvMGnD6EWJ2eVs
Message-ID: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
Subject: [PATCH v3] vhost/vdpa: reject overflowing PA map page counts on 32-bit
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

Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
vhost_vdpa_pa_unmap()")
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v3:
- Add the Fixes tag.

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
