Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468759;
	b=dgnl6B8wy1qgBo1GTmK1fbJsb1gvBfH0CKmeMFqlikkdWZLdS2lZq6S98M+49KIuvqQt
	 rPHjv+XUDfxOGXz86mzVopTTp0z3180HALkwyLKUX1YuKsdR+PQml10DEJf1MplVn8xjm
	 4e9zN1Rjgqehp4mpi9d5XPEcqEB7Hp6VO05Xd+sg1YqnSUUFPCUaeJcMTFei7QDTPkmk7
	 MjNWtQjpaxi6nATVhLLt6oLhQfDvG47JUrtQUieHbiG3V9JKcHM3OUU8Rwyw59NUcb6Kx
	 KsWwofKsvvG5FLmnxNT1pPQxlhGv9f266OWaAuE9qnISGWRq9jcnodCvfvD+NYo6jfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468759;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
	b=kqhDg0/9kqd7/I41QBIzOXAyWFZ2mVdp152lPtsr8hitABP4F4a3/ahTMFQt8mRH8cpN
	 AAsfVK37aKprbktvq4BCr0TttI8AkxufuaovE9Pla+kgV5KqIhO9f14PtmeJQD65/J85B
	 s7AIvkxJRzSi0EC8pvAxuGX/NoQljDeRv3gie4neotBbMO+N7Jp+/C56tlX8iHInsEPbx
	 YbA23Bi4znTXf0HCIBjAd8IRs4RkGWOAO8+x+m59E/EuY9O7ZZ3Uz8Y3NtwvdOl5wkAaM
	 ueCftJ7MjAy5QP64t5lmUpwhmffNvaHlDpH22ab6I+rZ0VQGAIh7qQxID5nFzl6buSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AILMGxYi;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=zDzf6VvP;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97874606A339
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 17:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97874606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AILMGxYi;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=zDzf6VvP
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDnj4d3698089
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=uJK3
	1gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=; b=AILMGxYihFp4aa47RKE3
	ZkwqpaFA/qji9U4eUXttEpbkTO8SzOmW54oWCpknvVgzl3mlXPDw7zISGHqOQ5xm
	mUHbR90Kuj8TtuommrbOsRAj9DroiV9GS9MqnHAmF0hvy+n8Imz+EI0PPrrwJuBD
	yLxHW3VlUTIHnuCKnMf8tEub5zv7WtQp+JHjzoN40noj4J8gTkjguypnodlpcu/8
	NgMQDZnao+Vaeb8PuQ9M1WCCPQMUkREXnnKxJlcYGxMJK3INHKXWh0SSY6wJUkVs
	EvXP7WtDhAqEltlCeRJAkzQ4vOoU0PltSMQEjRBYrLSOk2LrhVu1cl6Kwbr+b/Sx
	ag==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hn2xhvj4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 13:45:57 -0400 (EDT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7d06f3784e2so456374137.3
        for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468757; x=1794073557; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
        b=zDzf6VvPV70VeyVx/3vsaAqfeMclwXrc5brFL/FEQTvPo/RtPt/RXdM/qmT5Wmxbcy
         FAVLDTlimRTlsWSl6RAAcWBgND8v1gxU8wyW6qb+ad566HmhebKgMvuE7NlVp201EqUU
         orU0QR+rdlgYyyvRTRm3sW3t0hk/LrkdIdFjr3378397xsqMUR53es/fYCLIqlvzdJaJ
         eKvNrsWULa43FFvAjg/51YNkLb0u0+/MF9UrbVVkTUY6tR0TkwchRfsIpGA2fM79d4Ly
         mOvt+QGXQ9zUs9yXW6CAsAWcD92KeqqLOf8JYQ2krZpUtvvUh+R+ye/njWNPqloyBhzy
         UBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468757; x=1794073557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
        b=IwBaQ9BJHVFkcyMxfO7EA1BnT1ECm+H5AHYDPJBsl3+QRVjUmLwygy9IrIake1s74P
         J0jkG9ij2KoAdnNq0xpMiosdq+GMeewzZhLaPwLXMxVONvxO3nSy39kyMhNUCdZnxhZi
         H8t/5sL5fOvc8f9s9dXcZqMAhCEZSiC+C08O+X5rxvRn6q4CX0RzThkd7Fc2YXYhAui1
         T68Zh1/mFi9t8WOurxgWhylz70cYXHnEdB2RDInaKCi93cZ926XD5BowYwhEXjXeJHT5
         JxhMzoXbJeGqX3mEAFDENpWoBtKH51OHt/T0bPh7dGeblzERNlyY4RiPgAN+qT5CTQIO
         w1Jw==
X-Forwarded-Encrypted: i=1; AKwUvBzAquNITvBaEk3NCQpaUm96OMjgG7tUoU3LOKOI08A9+iC93JCzehMRROJQVcx2jOabOGq7kKTWWfJKLEtUHA==@lists.linux.dev
X-Gm-Message-State: AFq9FYK2ubpZEAaZRK/ShoENmAg9MYq1xLgWx1xLjsbb7032SXRBx5Cs
	e+XM863mDs5oiTiwIPcMWkCS9DUB4BOt+G1DktHfRHObRgblsoDBoGDQsAfIi3LvBxNmwgfdEr0
	se6seyp2ip2Dcd8vhl0uxvXqYSohPxqf+qAxYDz7g0uKhpTwVOHHTWBBaewqBdAoA
X-Gm-Gg: AYBFou0NiDw24BbAlvQqClLTNdsO6SfNbhFrftXQXIxTWZK9+mVyu3gqTSrxa3BYfGR
	/byd1kB9d/b5lJKK3czpJhAs/9twWkaOZJDX3pVpD3naq8khGCmWKxrJsbwTojz6j4Tw45SAWf0
	/c7pYPhisngZ5HNY/6m1Min4G3DsF+aMAFsg4TfhZd8tN82mDcigDA38sufq2qdAojZBtbKx8Ek
	VLnOGpgwTvgSkqF00agfKsNPBd75FUVCElxIGNpUyfl45sWnsRb2xYyPoTvOt+KHTLeLibmAWBs
	FI/XN1+fpxb41Od47pNVJXbRk046pTVZ9KgeAG5Er4NUSAkHa0UYhPVzcTImdxE5MwIJYKJ7W0u
	YFJ6qPDAf8vguhek6PsB+cFgcExGyMVAI7LYmgLMSxaZlA2PrhC2+rp2rjQ==
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id ada2fe7eead31-7d072cc29e5mr2098027137.28.1793468756669;
        Sat, 31 Oct 2026 10:45:56 -0700 (PDT)
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id ada2fe7eead31-7d072cc29e5mr2098018137.28.1793468756238;
        Sat, 31 Oct 2026 10:45:56 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:54 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 13:45:34 -0400
Subject: [PATCH 1/2] vhost-vdpa: fix pinned page leak in
 vhost_vdpa_pa_map() error path
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
Message-Id: <20261031-vhost-vdpa-unpin-v1-1-94ffc9683256@columbia.edu>
References: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
In-Reply-To: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=2574;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=2cfbyA5E1BgeuOs5GH6EveuwRPzjMvx0EL0D8iIR4TI=;
 b=ASB3o36C4fU3EYWb71QWR0b3OloFHUbllnjysWZc/O/WJMEbMyalbSxUjvtUsiJCSd5hwtbVN
 UV1UmC6jYICARYL7Qn5AYWXOvVzIfj1mcr+UxfTHO1a4QhwHfdFBPLf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: BfWaciE90L04frWMBLP2qZR63eIf6Lfq
X-Proofpoint-ORIG-GUID: BfWaciE90L04frWMBLP2qZR63eIf6Lfq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfXylYg++e1qlpA
 qzqTeJYmlDFrKYWO2uT3+A5rAPuAPZkcRECE3Y91AFbeAlftOJ9fvhfKpVGFey8dE1B5w4eS8/2
 bSmTwBWGQ9X3OeT/8SDOVnT2S2XFICenReGwQNr2Shc4msrETp6a05fM+nmTLZxF1QrrU1AXuaw
 CThGKEJbhYr3ZOes9dqLgWCjjAY44rKk/Jk/azcVBhyx/WgH0Bx1hR1gH7oFnC7sMGGVI274R1b
 3eq3n9u912+0MkQCM7e/17j1gElduWDXlQQPFRZNWnrq84F0C+wzv4k8/Oa9XwMgBWkl20xi1Yr
 3FvGnHrsKzaxonrVylbToDZdJpTuSOHkgqJb7AIZzVPL9kJNxCqVJ7hDoYHzN9u7Jtj17yeMEGy
 vUeOg2yo04kHEtpKpiD0c9NnmrgWptBosm+/rW9jRHag9v8lKVXZT5y+q5vTjfvIaYuaIhnw1KV
 fb2v7q3n8CP0ORub+Fw==
X-Authority-Analysis: v=2.4 cv=LPLz05W9 c=1 sm=1 tr=0 ts=6ae62955 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=Vli3z_CPQh-YiPf8mvEA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX/aXjD31ueRsO
 +484Ai/+Bb7qWuuCU9sUMPCSmJRiq9TJFMev4XSBFlBfjU3UdDXSBS5ZYmea8ViWS5amaSIpn2E
 nu5FPiLZO88u0PpkkH4yPBrLaRmjjKLYHfmreEjaW9USSfAo7Lh8
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=10 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=10 malwarescore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310070

When pin_user_pages() or vhost_vdpa_map() fails, vhost_vdpa_pa_map()
is supposed to unpin the pages pinned after the last successfully
mapped chunk, i.e. the range [map_pfn, last_pfn]. The unpin is guarded
by nchunks, but nchunks is reset to 0 every time a chunk is mapped from
inside the current page list, so a failure after any such boundary
leaves that pending range pinned forever. With physically scattered
memory nearly every page list contains a boundary, so the leak happens
on practically every failed IOTLB update.

The pending range is non-empty exactly when a page has been pinned,
which last_pfn already tells us, so drop nchunks and test last_pfn.

Fixes: ad89653f79f1 ("vhost-vdpa: fix page pinning leakage in error path (rework)")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/vhost/vdpa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ff7d90719171..d9af728942b3 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1151,7 +1151,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
-	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long lock_limit, sz2pin, i;
 	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
@@ -1187,7 +1187,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	cur_base = uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
-	nchunks = 0;
 
 	while (npages) {
 		sz2pin = min_t(unsigned long, npages, list_size);
@@ -1202,7 +1201,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			}
 			goto out;
 		}
-		nchunks++;
 
 		if (!last_pfn)
 			map_pfn = page_to_pfn(page_list[0]);
@@ -1233,7 +1231,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 				map_pfn = this_pfn;
 				iova += csize;
-				nchunks = 0;
 			}
 
 			last_pfn = this_pfn;
@@ -1248,7 +1245,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     PFN_PHYS(map_pfn), perm, NULL);
 out:
 	if (ret) {
-		if (nchunks) {
+		if (last_pfn) {
 			unsigned long pfn;
 
 			/*
@@ -1260,7 +1257,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			 * the corresponding unpinning will be handled by
 			 * vdpa_unmap().
 			 */
-			WARN_ON(!last_pfn);
 			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
 				unpin_user_page(pfn_to_page(pfn));
 		}

-- 
2.39.5

