Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B49242D84
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338526; cv=pass; b=OGlkVDuJhoSlwsMmMa5KKs0VppzPRO/M8WdvovJEsMysRy2/Qv3pr09sM+OqnE/00eKdGrlBDVTK9iFHqOy96CqthRV9xHgtoUjL75bx6uQ6lPVDSpUbpsZ7PWu881rRojx7guwyb4VMtVRSx9VA4W2Q5gc+69QGtrnjQ8BGsWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338526; c=relaxed/simple;
	bh=7lfnvnV3tDsdkAeD8ENY3TZFcgviUe6OdssAmRPb6ME=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EwmFvdsfqzERsHsZJs2eR0O60Ng57E0kHWy0Finzw5ePthNaFzjbCdS+1p2YOmx03o9FI8lH/vwFHnEneeeUYUhkBygkwYB1vQcyw33QAGbEdwDlUS3WIKUIkodEiIKNEtTPYIsMWeZWJyIzCu+BiVhidFkBuJY2YUuUVQ1LwPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj0QIkxH; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj0QIkxH"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80814edb536so15482697b3.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 15:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782338524; cv=none;
        d=google.com; s=arc-20240605;
        b=J525sqhoS+J7NYsfVaW/LEKz6r83mknqFRJwsZi5wFHuPI6EjFgkz1dV9BipFPcvRf
         Z2dJYAxYTvW1hByuxojltb85eM3EWsB55yYQ0wESoubRcau1dEZi7W6DgVJ+iQkL/vHN
         7EX6mgFgcnwkonSKIpJCdrf1aSp5JxDb3HOC4fGEPeuDgWRk5vWpLUBLkbxmcycG7aWp
         TezR1tfwNm/tpsyzRPQOCmV+silyTv//DtXu/8LszTUg2IAu7QRmYO4T/+GqZ1A36DKc
         KHXVlibb0JC7ADCekBCBgxCSu2I0400/cDaE9tM7/xe4eqoS/2GTsU+0rp7kmVZgvAwB
         Xrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        fh=DYQ9rWDyH7virEYruQKvPmujk8a7HV1npF3xPzydEUk=;
        b=B1bqdQzy6gm1YymHBn1Kcdled2W2Gk91RgWhf8hkd/wsOB8tS563yspkcuyMfgDWdk
         6BqKdA7zdv4pMukeq7FhX7m/FgUFKNtPxOhRbrVOzi7gNqO1VsSk+DQTLOZaodx9qKkO
         E/ey2skjh+qNjMEuVq6iVFp4xEa0AQP/lQf3Y+Qkix1TPRqPfPaJmHOz0TcM/r8e6QRZ
         WiLKaypHdyqETJrQW5Kj4tH47ErpGSQSexYGW+uGNCJOhujgcgmUHWSQYw5WEWEty3cj
         VItAsw9ibfsI34/NqH4nwwm8TJRktxLJpvIkd+d3mZykBmTuFoPEFo34n/ZHKrL7qqW/
         cLDg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338524; x=1782943324; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        b=Hj0QIkxH7Ua66UhXkUYsyA47XBy6sA0yJtJUmbYdINaKXe62m7442okFsNkBQDBjyg
         UPNc/UpF1LLDUvScDQAdrhojBCo6rbbcKp+gx39H8GC7EWka/orJ9qDuicwWCSTFMk9g
         IU1LFcAfpk1dm93Iu/lT5jv0tTzylB/gB0welQD1CHvz86iWZDfsxpPRUeopBeOpuvDQ
         LKkAj/WvUwUiafq9k+gxa2Q2moHNFBuqdw1iRqC0coNpZIkqbfIJtEvyJVzvj1xK3++e
         zhiIzldbhxP0019CEekpAuCa/lrWIXzp2nLeuOncGeHVjaVDyfIWFftHFAtt0/OPuUxW
         N4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338524; x=1782943324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        b=I9A4vAuN5mRzi+2fzvvKuxlpWXECgGfHaMaEWWAYq8qhApOfzKfEw4GP4T08JGV8CI
         Nj0HFJRlLRRhAkhQeLY9XIAEjpKdgHhV2/M/g5+hjsTuMzxJmwdyycu545dtd7Faqtyx
         Ln5UD4YJlECpYq8QufpM+xGnjDR8Krh7NLtoLfdHkcfDC4slwhJBwr9SrbrooixAhekW
         zjHYnkfe4aP3T3tIK90e77uCI4W563L1REHMXd6E71M/RE7sIlR6LZaw+X2hx0AGUAJX
         JfIlU16F/oSnyAfOsqRE4PWwGUZ7lZErkE8eB9Jy0JyF947DDqiZyJ7PqHgq5+9Qlc8/
         i5Cg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2UK0fEuiqxACNI/EWQpxOqRyp37zJNsj+nVit9bg6isqPPe8JI2vEYn9VEJmxz3roBlf0OPE1jMzXdULeVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx01Bui4oJdHP97q+oNrzcexaTYbUae7CYJDrI7fkhVDG1EaOyS
	VchZVVfg5ghBhWtLk0astF8OURgkI7LPcW3uiz+xDWF3aixWWmMpFY2tgJ8ZOGnQXRmThv+CML1
	jJInQcCpDQB6UT2oNuhxIFo/G9bQWPEE=
X-Gm-Gg: AfdE7clG1Suih2JCx/3Uclfalri+DCuEFnUPFERW0xhyL2GVWuDz/uBZYLiHHoP7XkN
	TICCycws3y6icYjApZozSBU0i3+Cf8/131rVTRnkq/B814TwL1Y7IDzsvBK0GTM0wi3iSaaURnu
	fk23XZLKsY4uDCEXVaKOIwYk94cUxHT5aCPcCR9AZwlpx/SVebEPNia+uXCi0xbtv3khpM2pxnT
	4bP0W4jJTgoMqFn/y1BHv8cRiWMpBYCVsz+HOvvExqleqSMn1dK/CrVLQ513Jnav/WDOMK3
X-Received: by 2002:a05:690c:b19:b0:7f8:7e31:28ae with SMTP id
 00721157ae682-80a662eb798mr848857b3.48.1782338523988; Wed, 24 Jun 2026
 15:02:03 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 15:02:02 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 15:02:02 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 15:02:02 -0700
X-Gm-Features: AVVi8CdqX4PfLHQXiwpnwtEKJdmkwx9CQ3waCkhoXh_EjZA4ykU1Up_eDosLuk8
Message-ID: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
Subject: [PATCH v4] vhost/vdpa: reject overflowing PA map page counts on 32-bit
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v4:
- Keep the Fixes tag on one line.
- Add Michael's Acked-by tag.

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
