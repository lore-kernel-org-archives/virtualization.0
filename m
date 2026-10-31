Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468762;
	b=mZUKyCBvq5iDN6KWmDRQ/R1QiTKMuJEdQ9YjCaKWjENdwiCF3btms4V2kiXepSSG/akj
	 qmcpTLJmlcBoyCVFCMv69euoWJRXaulXlE4PeymJqF0P9XcuZsYO9fWsUm6AG+A9/bqAa
	 hP0D6Y4gP70FkHSrH6UHpXgauix/66Z7G42kPycaTVkJgLW8gwxHld05zpxBjcrOJ9+TE
	 8GCkgFWJScYylh6mNIbR9w8ctreEPKhHW4/yFCDl0VNf9co76g1DFxYfwuQKQHn9Q3Jk/
	 OejiweuQ8CrIc+9iNZnM1xcENJ0ov1H0172qqMMqkDmf4/3NJdePpEMxyT87b8eabTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468762;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aJekqtZd8q/3ArsU+9b6lj5+AIzwCIpS5G7gHNxiD/k=;
	b=xiTxIiKx2Jpf2IwYB8H4LkttchpTGJr2zmDID9e2V6OQ/jEgX5yOR2V9r7cUWlpx8lnI
	 NPu13esS1fwT5qciVNXbGEg2T+csnGLbDiNJh8WsGVEZO9Ra3tOIXsanCVQXJuwsBI/pj
	 S+Fj+X0jOPI8VYlD/fEoy6hDigZ6MN+0oIMIOpcrKdC6VNArkUgPXY5QmYaTasYQSlNaP
	 iXsTwIxZH9TicRj9zKcyvauMeT2jp7qQv/L3U+UVKxlcScDe0HaK26vE2IDUBqPFOY20C
	 xGZiAfR6XocGPBaP5xJYl5L7PtiTU+R3DMp7X+LN8dKLa1tz0vM7P8l/dQcAh89WN4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WqfoXEgz;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=cSJD4BUc;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F460A2612
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 17:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 763F460A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WqfoXEgz;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=cSJD4BUc
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDnt9O3698184
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 13:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aJek
	qtZd8q/3ArsU+9b6lj5+AIzwCIpS5G7gHNxiD/k=; b=WqfoXEgzdHJJs2k8MvcL
	/g26eZf704RKz7uoJY5+9rJDc6ve6LKz6U10MPfAgHvLPvKnmXk0qCaoj8FZA6MX
	bZZgi5GV2eEAGbTBxjT2nltAnNbNlKQdLU6h/m1muqfSEEaBGcdkEnryPVi+8NlD
	ujzT124VPz7gZm5cBAL6kOzSmqzuqsEtIUDdaEnmklCwbroLzcA8l1FLwG2HM1gr
	t1VP7RbxQeDen2IVg9AsOIMMN1tnYeQHmMz4y+o0JtUM5G+M7hXxMkJGcYXtAunP
	93Sl0hc1/Om0ITQ1mNCbnQarY2Pbf04sTH2EqcpBwfGsh7aXypj6Bm75lOCVCChA
	VQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hn2xhvj52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 13:46:00 -0400 (EDT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eabb3a1bb8so453515e0c.2
        for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468760; x=1794073560; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJekqtZd8q/3ArsU+9b6lj5+AIzwCIpS5G7gHNxiD/k=;
        b=cSJD4BUck+0UBA+WAhB22ETYPgwKBYqcv2n8bsNQkZ09i6/4AZRSQk16WvlqE7Nj0r
         58gLAcXA/1Gyh3XChbtn0SbzvAornh7kIM4y9qkO759tjB6apX5/+JD/tSdUK9dy4ZSz
         22kEHQjjQ7uvyy2dK8yQcWs8CYgtJNQ/EfHba9w4nSfnXXy8xk8lVhx4xeGZSsv9va7i
         6Zrj5LOvFXlu6jutSCj/g8z/55Wvf7IDj+28QVxNCDvh9dALYI1GJm3Tgvb7bLWZMo6N
         GVW3LHbHJ/CJP6cIuG39WZPlIyAEOU6lFBJ7nd9Cf9aUBwB2MYVl6uV9Sf5ImBxqtnwg
         VEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468760; x=1794073560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJekqtZd8q/3ArsU+9b6lj5+AIzwCIpS5G7gHNxiD/k=;
        b=CFHtm/2h7uFU5Hj3C39kOzN5nDMG6LcZx0H9PmXO5wEDUGEel+rtVafvBNxTry0uxt
         TdCT1+uni/oWkyuFPqgkeAfwHMQTFDyiwDqV8+fqTEkdRUHZ6D9vIBg/Up+Ui3qibnjG
         SgrQmm2hv3i0T2frGnkrE15Amzvtc6+vj2J1qWaXByMeUkKJny61acPxzTryqqALXRoy
         AY01BxCRxWuBZzHPOsSxpVBav6Ik6xISuVQSDG4edoeK/487B4rTIkNGc5MjJaYdJMmf
         CjDyShGYKkIjB538rj6dEY0XAvVii3LGJb+2uCZ4J8TzRROCc7VLXB5IopbH384tYp0G
         5IgQ==
X-Forwarded-Encrypted: i=1; AKwUvByBzPkOb5Vu+BvpbhsiUg+sVNmbXaG5Ct+FSCtI3PIHSGJP8hUuaG3R/QCWVFoYfE/W2BD2+Z+H/iW6Uop5YA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJbaTJSdlgzbf66cwF0UBbgw0SzIB0/VZZJSzneXNGGI/Qb6Wbz
	ebuylWQ4vMLxVaX1ML4Msrts44cTCRoc1OHZjLqQ+UKpyWXkpb4zN5yjpsrQFx8GqcSOHX8JtlI
	J4wQ2gMYWiaZbTMKDrvMm/r37JL2yzEqmPhl7YB/fimu5PJQYPPlrb+OETz8OZ2qL
X-Gm-Gg: AYBFou19idOWG4avB08IFW2OebUekOhXDrj0/8hNdFxAlecEDRE2jYv+jzQT9kaE1sL
	Lb559kJ3PiVTn/4l/qDRcu5ZqQ4wiblidm8cZPIv2kixFLhCHjHZwQ5V7J6gvuwYO2aSv487KjS
	HMj9ySnyUU8t6NEOgp3Byk/WCiUyv4NZMCHocn5Q1BIEZTxz3tKAPesUaRJ7uSJR7bxF40fLSMp
	kzjcI9ge0oJHnwOR2gMm70Emq2l1y2s4czX3q3CQyxBYssoNIWY4jUGxPRYIMQDorRPAkKeFQAa
	lpv8g1vyR3cgvXwVclagEhTA8VS3QVMoKfKweCdwL6RaJ526Zk4CRJpopwB3NnEi0CQQ0cxtVyF
	2kytm/mWiUFNp4rCIA5ZFDNV0N2oOG9Ejwg+vGclY/7oEIxFOokHsHNwlHw==
X-Received: by 2002:a05:6102:148c:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d07223f482mr2959690137.2.1793468759695;
        Sat, 31 Oct 2026 10:45:59 -0700 (PDT)
X-Received: by 2002:a05:6102:148c:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d07223f482mr2959682137.2.1793468759156;
        Sat, 31 Oct 2026 10:45:59 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:57 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 13:45:35 -0400
Subject: [PATCH 2/2] vhost-vdpa: unpin mappings by range
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-vhost-vdpa-unpin-v1-2-94ffc9683256@columbia.edu>
References: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
In-Reply-To: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=2247;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Gl1rZ25wXNyNmee5e2PpkIojdGVNpwtOFO12QJgbtq0=;
 b=Yc35BLvALhKx8rPBAzm50hZFs+VIj2767yCsM7DHjbdqhj8KQJZguVerhRuWtRGIifzqbDrPY
 e4bjGwmJAZ8CIDTEbQW+/UaLJKu9KMENbgB2/aAZ6r4/z+CrdnaxFg2
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: M02-78OHWvIKiqMt7gFHlqAGYxX7X6OA
X-Proofpoint-ORIG-GUID: M02-78OHWvIKiqMt7gFHlqAGYxX7X6OA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX8WjAQUwINfHt
 lNBQVMkeIUbjdFVNXGTL6OF3YAyjfqzdVe5cCA2rH/EBnt6IjWLdJwL35fWZPZF9wAEQKP+EaGi
 kAFnSOchuyEjwhftTIMngYA4nHjMFsGsBhw6Qm8R8r7mQVrAmYxxAS2bIHkXDg3Lq1uYjkajq8E
 Zsho/Tw41tHQBAVB3UjcNxB40ryplE9eCIZ9Zeq6qm2UuLMFWqEM6xD/dbF9Vb8IYsHE/6Spvre
 k6g1uXmD3G7ae2cudAxlqKVOMRFT9IQCzo5dxUnkZkEk4R1hng1YICdugdINIeb8hxsQRC5bbtS
 PU3oll86Q66QPDQKsefvOgcprOalA9S7qaoVdmFbtyFLCfXqlv9IH+d7+CJcSfNBnngimvkf4dR
 Ww6poZA4brFIm7W1bsVoWFtyLmvPMqYBXzHJ6OGoUAR34dYmDMNrqrJT7U5xjZam8n8x5qs0ej1
 Wfsm1VE2YflEoFDtJPQ==
X-Authority-Analysis: v=2.4 cv=LPLz05W9 c=1 sm=1 tr=0 ts=6ae62958 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=RvicXfEJGDZI3HCdRHsA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX9CIDCaKA2mAs
 V94E6q6jLShXxmdKrrLQLsdRiZUUAVs8bhjON9GkSr5eC8yPdorAkpzQr/CsiYl0Nnk1YWib287
 arBUH4c6aQKKJGOwY+9Jxb95m96la+nSb1cVqoS2Rz2arBkhryGO
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=10 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=10 malwarescore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310070

vhost_vdpa_pa_unmap() unpins each mapping a page at a time, dirtying
each page first if the mapping is writable. Each mapping is physically
contiguous, so use unpin_user_page_range_dirty_lock() instead, which
marks every folio dirty once and drops its pins in one go. Do the same
for the pages left pinned in the vhost_vdpa_pa_map() error path.

This removes the last use of set_page_dirty_lock() in vhost.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/vhost/vdpa.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index d9af728942b3..cd5da522fdc0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -972,18 +972,11 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 {
 	struct vhost_dev *dev = &v->vdev;
 	struct vhost_iotlb_map *map;
-	struct page *page;
-	unsigned long pfn, pinned;
 
 	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
-		pinned = PFN_DOWN(map->size);
-		for (pfn = PFN_DOWN(map->addr);
-		     pinned > 0; pfn++, pinned--) {
-			page = pfn_to_page(pfn);
-			if (map->perm & VHOST_ACCESS_WO)
-				set_page_dirty_lock(page);
-			unpin_user_page(page);
-		}
+		unpin_user_page_range_dirty_lock(pfn_to_page(PFN_DOWN(map->addr)),
+						 PFN_DOWN(map->size),
+						 map->perm & VHOST_ACCESS_WO);
 		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
 		vhost_vdpa_general_unmap(v, map, asid);
 		vhost_iotlb_map_free(iotlb, map);
@@ -1246,8 +1239,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 out:
 	if (ret) {
 		if (last_pfn) {
-			unsigned long pfn;
-
 			/*
 			 * Unpin the outstanding pages which are yet to be
 			 * mapped but haven't due to vdpa_map() or
@@ -1257,8 +1248,9 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			 * the corresponding unpinning will be handled by
 			 * vdpa_unmap().
 			 */
-			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
-				unpin_user_page(pfn_to_page(pfn));
+			unpin_user_page_range_dirty_lock(pfn_to_page(map_pfn),
+							 last_pfn - map_pfn + 1,
+							 false);
 		}
 		vhost_vdpa_unmap(v, iotlb, start, size);
 	}

-- 
2.39.5

